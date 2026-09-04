import 'dart:convert';
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import 'cli.dart';
import 'process_runner.dart';
import 'project_config.dart';
import 'registry.dart';
import 'template_renderer.dart';

const managedExportsStart = '// remix_cli:exports:start';
const managedExportsEnd = '// remix_cli:exports:end';
const emptyManagedBarrel =
    '''library;

$managedExportsStart
$managedExportsEnd
''';

typedef RegistryLoader = Future<RegistryCatalog> Function();

abstract interface class ProjectFileWriter {
  void write(File target, String contents);
}

final class AtomicProjectFileWriter implements ProjectFileWriter {
  const AtomicProjectFileWriter();

  @override
  void write(File target, String contents) {
    target.parent.createSync(recursive: true);
    final temporary = File(
      p.join(
        target.parent.path,
        '.${p.basename(target.path)}.remix_cli_${pid}_${DateTime.now().microsecondsSinceEpoch}',
      ),
    );
    try {
      temporary.writeAsStringSync(contents, flush: true);
      temporary.renameSync(target.path);
    } finally {
      if (temporary.existsSync()) temporary.deleteSync();
    }
  }
}

final class Installer {
  Installer({
    required Directory projectRoot,
    required LineWriter writeOut,
    ProcessRunner processRunner = const SystemProcessRunner(),
    ProjectFileWriter fileWriter = const AtomicProjectFileWriter(),
    RegistryLoader registryLoader = RegistryCatalog.loadBundled,
  }) : projectRoot = projectRoot.absolute,
       _writeOut = writeOut,
       _processRunner = processRunner,
       _fileWriter = fileWriter,
       _registryLoader = registryLoader;

  final Directory projectRoot;
  final LineWriter _writeOut;
  final ProcessRunner _processRunner;
  final ProjectFileWriter _fileWriter;
  final RegistryLoader _registryLoader;
  final TemplateRenderer _renderer = const TemplateRenderer();

  Future<void> initialize(InitOptions options) async {
    final root = validateFlutterPackageRoot(projectRoot);
    final requested = ProjectConfig.create(
      packageRoot: root,
      prefix: options.prefix,
      uiPath: options.uiPath,
    );
    final configFile = File(p.join(root.path, projectConfigFileName));
    final barrelRelative = p.posix.join(requested.uiPath, 'ui.dart');
    validateProjectFilePath(root, projectConfigFileName);
    validateProjectFilePath(root, barrelRelative);
    final barrelFile = _projectFile(root, barrelRelative);

    var writeConfig = true;
    if (configFile.existsSync()) {
      final existing = ProjectConfig.parse(
        configFile.readAsStringSync(),
        packageRoot: root,
      );
      if (existing.prefix != requested.prefix ||
          existing.uiPath != requested.uiPath) {
        throw const FormatException(
          'Existing remix.yaml does not match the requested prefix and UI path.',
        );
      }
      writeConfig = false;
    }

    var writeBarrel = true;
    if (barrelFile.existsSync()) {
      validateManagedBarrel(barrelFile.readAsStringSync());
      writeBarrel = false;
    }

    if (writeConfig) _fileWriter.write(configFile, requested.encode());
    if (writeBarrel) _fileWriter.write(barrelFile, emptyManagedBarrel);

    // Report the transition that actually happened. `init` doubles as a repair
    // command, so the both-created message would be untrue for a repair run.
    _writeOut(switch ((writeConfig, writeBarrel)) {
      (true, true) => 'Initialized $projectConfigFileName and $barrelRelative.',
      (true, false) =>
        'Created $projectConfigFileName; preserved $barrelRelative.',
      (false, true) =>
        'Created $barrelRelative; preserved $projectConfigFileName.',
      (false, false) => 'Remix is already initialized.',
    });
  }

  Future<void> add(AddOptions options) async {
    final root = validateFlutterPackageRoot(projectRoot);
    final configFile = File(p.join(root.path, projectConfigFileName));
    if (!configFile.existsSync()) {
      throw const FormatException('Run remix init before remix add.');
    }
    validateProjectFilePath(root, projectConfigFileName);
    final config = ProjectConfig.parse(
      configFile.readAsStringSync(),
      packageRoot: root,
    );
    final barrelRelative = p.posix.join(config.uiPath, 'ui.dart');
    validateProjectFilePath(root, barrelRelative);
    final barrel = _projectFile(root, barrelRelative);
    if (!barrel.existsSync()) {
      throw FormatException('Managed UI barrel $barrelRelative is missing.');
    }
    final currentBarrel = barrel.readAsStringSync();
    validateManagedBarrel(currentBarrel);

    final catalog = await _registryLoader();
    final items = catalog.resolve(options.item);
    final requested = items.last;
    final rendered = <String, String>{};
    final filesByItem = <String, List<String>>{};
    for (final item in items) {
      final targets = <String>[];
      for (final registryFile in item.files) {
        final relative = _resolveTarget(config, registryFile.target);
        validateProjectFilePath(root, relative);
        if (rendered.containsKey(relative)) {
          throw FormatException('Multiple registry files target $relative.');
        }
        rendered[relative] = _renderer.render(
          await catalog.readTemplate(registryFile),
          typePrefix: config.prefix,
          valuePrefix: config.valuePrefix,
        );
        targets.add(relative);
      }
      filesByItem[item.name] = List.unmodifiable(targets);
      for (final generated in item.generated) {
        validateProjectFilePath(root, _resolveTarget(config, generated));
      }
    }

    final states = <String, _ItemState>{};
    for (final item in items) {
      states[item.name] = _classify(root, filesByItem[item.name]!);
    }
    _validateInstallStates(states, requested.name, options.mode);

    final exports = [for (final item in items) ...item.exports];
    final proposedBarrel = updateManagedBarrel(currentBarrel, exports);
    final requirements = _collectRequirements(items);
    final pubspec = File(p.join(root.path, 'pubspec.yaml'));
    final dependencies = _inspectDependencies(
      pubspec.readAsStringSync(),
      requirements,
    );
    final generated = <String>[
      for (final item in items)
        for (final target in item.generated) _resolveTarget(config, target),
    ];
    // A newly added dependency can invalidate build_runner's asset graph. On
    // that first rebuild, outputs excluded by --build-filter may be removed as
    // stale even when their authored inputs did not change. Keep every
    // already-installed registry adapter in the focused build so adding one
    // optional item cannot delete another item's generated part.
    final generationTargets = <String>{
      ...generated,
      for (final item in catalog.items.values)
        for (final target in item.generated)
          if (_projectFile(root, _resolveTarget(config, target)).existsSync())
            _resolveTarget(config, target),
    }.toList(growable: false);

    _printPlan(
      items: items,
      requirements: requirements,
      filesByItem: filesByItem,
      generated: generated,
      exports: exports,
      states: states,
    );

    if (options.mode == AddMode.dryRun) return;
    if (options.mode == AddMode.diff) {
      // The diff has to predict what `add` would write, and `add` formats with
      // the project's Flutter SDK. Formatting the proposed tree with whichever
      // Dart happens to run this CLI would report formatter-version
      // differences that no install would ever produce.
      final diffToolchain = await _resolveFlutter(root);
      await _printDiff(
        dart: diffToolchain.dart,
        root: root,
        requestedName: requested.name,
        items: items,
        states: states,
        filesByItem: filesByItem,
        rendered: rendered,
        barrelRelative: barrelRelative,
        currentBarrel: currentBarrel,
        proposedBarrel: proposedBarrel,
      );
      return;
    }

    final toolchain = await _resolveFlutter(root);
    final completed = <String>[];
    var regenerated = false;
    try {
      if (dependencies.missing.isNotEmpty) {
        final arguments = <String>['pub', 'add'];
        for (final requirement in dependencies.missing) {
          final descriptor = '${requirement.name}@${requirement.constraint}';
          arguments.add(requirement.dev ? 'dev:$descriptor' : descriptor);
        }
        await _checked(
          ProcessInvocation(
            executable: toolchain.flutter,
            arguments: arguments,
            workingDirectory: root.path,
          ),
          detail: 'Could not add required dependencies',
        );
        completed.add('dependency declarations');
      }

      await _checked(
        ProcessInvocation(
          executable: toolchain.flutter,
          arguments: const ['pub', 'get'],
          workingDirectory: root.path,
        ),
        detail: 'Could not resolve consumer dependencies',
      );
      completed.add('pub get');
      final locked = _verifyLockedVersions(root, requirements);
      final floor = _snapshotFloor(requirements);
      final lockedRemix = locked['remix'];
      if (floor != null && lockedRemix != null && lockedRemix > floor) {
        _writeOut(
          'Resolved remix $lockedRemix; this remix_cli registry was authored '
          'against $floor. Run flutter pub upgrade remix_cli, then review '
          'with --diff.',
        );
      }

      final pathsToWrite = <String>[];
      for (final item in items) {
        final state = states[item.name]!;
        final shouldWrite =
            state == _ItemState.missing ||
            (item.name == requested.name && options.mode == AddMode.overwrite);
        if (!shouldWrite) continue;
        for (final relative in filesByItem[item.name]!) {
          _fileWriter.write(_projectFile(root, relative), rendered[relative]!);
          pathsToWrite.add(relative);
        }
      }
      if (proposedBarrel != currentBarrel) {
        _fileWriter.write(barrel, proposedBarrel);
        pathsToWrite.add(barrelRelative);
      }
      if (pathsToWrite.isNotEmpty) {
        completed.add('authored source');
        await _checked(
          ProcessInvocation(
            executable: toolchain.dart,
            arguments: ['format', ...pathsToWrite],
            workingDirectory: root.path,
          ),
          detail: 'Could not format installed source',
        );
        completed.add('format');
      }

      final needsGeneration =
          generated.isNotEmpty &&
          (pathsToWrite.any((path) => path.endsWith('.dart')) ||
              generated.any((path) => !_projectFile(root, path).existsSync()));
      if (needsGeneration) {
        final packageName =
            (loadYaml(pubspec.readAsStringSync()) as YamlMap)['name'] as String;
        await _checked(
          ProcessInvocation(
            executable: toolchain.dart,
            arguments: [
              'run',
              'build_runner',
              'build',
              for (final target in generationTargets)
                '--build-filter=${_generationFilter(packageName, target)}',
            ],
            workingDirectory: root.path,
          ),
          detail: 'Mix code generation failed',
        );
        for (final target in generationTargets) {
          if (!_projectFile(root, target).existsSync()) {
            throw StateError('Code generation did not create $target.');
          }
        }
        completed.add('generated Dart');
        regenerated = true;
      }

      await _checked(
        ProcessInvocation(
          executable: toolchain.dart,
          arguments: ['analyze', config.uiPath],
          workingDirectory: root.path,
        ),
        detail: 'Installed UI analysis failed',
      );
      completed.add('analysis');
    } on Object catch (error) {
      final done = completed.isEmpty ? 'none' : completed.join(', ');
      throw StateError(
        '$error\nCompleted steps: $done. Fix the reported problem, then rerun '
        'remix add ${options.item}.',
      );
    }

    for (final item in items) {
      // The preflight state decides the verb: overwrite mode only ever
      // *replaces* files that were already there, so a missing item installed
      // under --overwrite was still added, not updated.
      final action = switch (states[item.name]!) {
        _ItemState.missing => 'Added',
        _ =>
          item.name == requested.name && options.mode == AddMode.overwrite
              ? 'Updated'
              : 'Preserved',
      };
      _writeOut('$action ${item.name}.');
    }
    for (final target in generated) {
      _writeOut('${regenerated ? 'Generated' : 'Preserved'} $target.');
    }
  }

  Future<_FlutterToolchain> _resolveFlutter(Directory root) async {
    final invocation = ProcessInvocation(
      executable: Platform.isWindows ? 'flutter.bat' : 'flutter',
      arguments: const ['--version', '--machine'],
      workingDirectory: root.path,
    );
    final output = await _checked(
      invocation,
      detail: 'Could not inspect the active Flutter SDK',
    );
    final Object? machine;
    try {
      // A fresh SDK can print dependency setup before its machine response.
      final jsonStart = output.stdout.indexOf('{');
      machine = jsonDecode(
        jsonStart < 0 ? output.stdout : output.stdout.substring(jsonStart),
      );
    } on FormatException catch (error) {
      throw FormatException(
        'flutter --version --machine returned invalid JSON: $error',
      );
    }
    if (machine is! Map<String, Object?> ||
        machine['flutterRoot'] is! String ||
        machine['frameworkVersion'] is! String) {
      throw const FormatException(
        'flutter --version --machine omitted flutterRoot or frameworkVersion.',
      );
    }
    final version = Version.parse(machine['frameworkVersion']! as String);
    if (version < Version(3, 44, 0)) {
      throw FormatException(
        'Flutter 3.44 or newer is required; found $version.',
      );
    }
    final sdkRoot = machine['flutterRoot']! as String;
    return _FlutterToolchain(
      flutter: p.join(
        sdkRoot,
        'bin',
        Platform.isWindows ? 'flutter.bat' : 'flutter',
      ),
      dart: Platform.isWindows
          ? p.join(sdkRoot, 'bin', 'cache', 'dart-sdk', 'bin', 'dart.exe')
          : p.join(sdkRoot, 'bin', 'dart'),
    );
  }

  Future<ProcessOutput> _checked(
    ProcessInvocation invocation, {
    required String detail,
  }) async {
    final output = await _processRunner.run(invocation);
    if (output.exitCode != 0) {
      throw ProcessFailure(invocation, output, detail: detail);
    }
    return output;
  }

  Future<void> _printDiff({
    required String dart,
    required Directory root,
    required String requestedName,
    required List<RegistryItem> items,
    required Map<String, _ItemState> states,
    required Map<String, List<String>> filesByItem,
    required Map<String, String> rendered,
    required String barrelRelative,
    required String currentBarrel,
    required String proposedBarrel,
  }) async {
    final parent = Directory.systemTemp.createTempSync('remix_cli_diff_');
    final current = Directory(p.join(parent.path, 'current'))..createSync();
    final proposed = Directory(p.join(parent.path, 'proposed'))..createSync();
    try {
      final proposedDartPaths = <String>{};
      for (final item in items) {
        final include =
            item.name == requestedName ||
            states[item.name] == _ItemState.missing;
        if (!include) continue;
        for (final relative in filesByItem[item.name]!) {
          final existing = _projectFile(root, relative);
          if (existing.existsSync()) {
            _writeDiffFile(current, relative, existing.readAsStringSync());
          }
          _writeDiffFile(proposed, relative, rendered[relative]!);
          if (relative.endsWith('.dart')) proposedDartPaths.add(relative);
        }
      }
      _writeDiffFile(current, barrelRelative, currentBarrel);
      _writeDiffFile(proposed, barrelRelative, proposedBarrel);
      proposedDartPaths.add(barrelRelative);

      await _checked(
        ProcessInvocation(
          executable: dart,
          arguments: ['format', ...proposedDartPaths],
          workingDirectory: proposed.path,
        ),
        detail: 'Could not format proposed source for diff',
      );

      final invocation = ProcessInvocation(
        executable: 'git',
        arguments: [
          'diff',
          '--no-index',
          '--',
          p.basename(current.path),
          p.basename(proposed.path),
        ],
        workingDirectory: parent.path,
      );
      final ProcessOutput output;
      try {
        output = await _processRunner.run(invocation);
      } on ProcessException catch (error) {
        throw FormatException('Git is required for --diff: $error');
      }
      if (output.exitCode != 0 && output.exitCode != 1) {
        throw ProcessFailure(invocation, output, detail: 'Git diff failed');
      }
      if (output.stdout.trim().isEmpty) {
        _writeOut('No authored-source differences.');
      } else {
        _writeOut(output.stdout.trimRight());
      }
    } finally {
      if (parent.existsSync()) parent.deleteSync(recursive: true);
    }
  }

  void _writeDiffFile(Directory tree, String relative, String contents) {
    final file = _projectFile(tree, relative);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(contents);
  }

  void _printPlan({
    required List<RegistryItem> items,
    required List<_DependencyRequirement> requirements,
    required Map<String, List<String>> filesByItem,
    required List<String> generated,
    required List<String> exports,
    required Map<String, _ItemState> states,
  }) {
    _writeOut('Items: ${items.map((item) => item.name).join(' -> ')}');
    _writeOut(
      'Dependencies: ${requirements.map((item) => '${item.dev ? 'dev:' : ''}${item.name}@${item.constraint}').join(', ')}',
    );
    for (final item in items) {
      _writeOut(
        '${item.name}: ${states[item.name]!.name}; ${filesByItem[item.name]!.join(', ')}',
      );
    }
    _writeOut('Exports: ${exports.join(', ')}');
    _writeOut(
      'Generated: ${generated.isEmpty ? 'none' : generated.join(', ')}',
    );
  }
}

/// Splits [source] into lines without its line terminators.
///
/// A barrel that Git checked out with `core.autocrlf=true`, or that a Windows
/// editor saved, carries CRLF endings. The markers are still there, so neither
/// validation nor rewriting may depend on the terminator.
List<String> _barrelLines(String source) => [
  for (final line in source.split('\n'))
    line.endsWith('\r') ? line.substring(0, line.length - 1) : line,
];

void validateManagedBarrel(String source) {
  final lines = _barrelLines(source);
  final starts = <int>[];
  final ends = <int>[];
  for (var index = 0; index < lines.length; index++) {
    if (lines[index] == managedExportsStart) starts.add(index);
    if (lines[index] == managedExportsEnd) ends.add(index);
  }
  if (starts.length != 1 || ends.length != 1 || starts.single >= ends.single) {
    throw const FormatException(
      'The managed UI barrel must contain one ordered exports marker pair.',
    );
  }
  for (var index = starts.single + 1; index < ends.single; index++) {
    if (lines[index].contains('remix_cli:exports:')) {
      throw const FormatException('Managed export markers cannot be nested.');
    }
    final line = lines[index].trim();
    if (line.isNotEmpty && !_managedExport.hasMatch(line)) {
      throw FormatException('Unexpected content inside managed exports: $line');
    }
  }
}

String updateManagedBarrel(String source, Iterable<String> additions) {
  validateManagedBarrel(source);
  // Rewrite the file with the terminator it already uses, so an installed
  // barrel never shows up as a whole-file change on Windows.
  final terminator = source.contains('\r\n') ? '\r\n' : '\n';
  final lines = _barrelLines(source);
  final start = lines.indexOf(managedExportsStart);
  final end = lines.indexOf(managedExportsEnd);
  final exports = <String>{...additions};
  for (final line in lines.sublist(start + 1, end)) {
    final match = _managedExport.firstMatch(line.trim());
    if (match != null) exports.add(match.group(1)!);
  }
  final replacement = [
    managedExportsStart,
    for (final export in exports.toList()..sort()) "export '$export';",
    if (exports.isNotEmpty) '',
    managedExportsEnd,
  ];
  return [
    ...lines.sublist(0, start),
    ...replacement,
    ...lines.sublist(end + 1),
  ].join(terminator);
}

_ItemState _classify(Directory root, List<String> targets) {
  var existing = 0;
  for (final target in targets) {
    final type = FileSystemEntity.typeSync(
      _projectFile(root, target).path,
      followLinks: false,
    );
    if (type == FileSystemEntityType.file ||
        type == FileSystemEntityType.link) {
      existing++;
    } else if (type != FileSystemEntityType.notFound) {
      throw FormatException('Authored target $target is not a file.');
    }
  }
  if (existing == 0) return _ItemState.missing;
  if (existing == targets.length) return _ItemState.complete;
  return _ItemState.partial;
}

void _validateInstallStates(
  Map<String, _ItemState> states,
  String requested,
  AddMode mode,
) {
  for (final entry in states.entries) {
    if (entry.value != _ItemState.partial) continue;
    if (entry.key != requested) {
      throw FormatException(
        'Registry dependency ${entry.key} is partially installed; repair it or add it explicitly.',
      );
    }
    if (mode == AddMode.write) {
      throw FormatException(
        'Requested item $requested is partially installed; use --diff or --overwrite.',
      );
    }
  }
}

List<_DependencyRequirement> _collectRequirements(List<RegistryItem> items) {
  final requirements = <String, _DependencyRequirement>{};
  void add(String name, VersionConstraint constraint, {required bool dev}) {
    final previous = requirements[name];
    if (previous == null) {
      requirements[name] = _DependencyRequirement(name, constraint, dev: dev);
      return;
    }
    final intersection = previous.constraint.intersect(constraint);
    if (intersection.isEmpty) {
      throw FormatException('Registry constraints for $name do not intersect.');
    }
    requirements[name] = _DependencyRequirement(
      name,
      intersection,
      dev: previous.dev && dev,
    );
  }

  for (final item in items) {
    item.dependencies.forEach(
      (name, constraint) => add(name, constraint, dev: false),
    );
    item.devDependencies.forEach(
      (name, constraint) => add(name, constraint, dev: true),
    );
  }
  return List.unmodifiable(requirements.values);
}

_DependencyInspection _inspectDependencies(
  String pubspecSource,
  List<_DependencyRequirement> requirements,
) {
  final document = loadYaml(pubspecSource);
  if (document is! YamlMap) {
    throw const FormatException('pubspec.yaml must contain a map.');
  }
  final regular = document['dependencies'] is YamlMap
      ? document['dependencies'] as YamlMap
      : const <Object?, Object?>{};
  final dev = document['dev_dependencies'] is YamlMap
      ? document['dev_dependencies'] as YamlMap
      : const <Object?, Object?>{};
  final missing = <_DependencyRequirement>[];
  for (final requirement in requirements) {
    final inRegular = regular.containsKey(requirement.name);
    final inDev = dev.containsKey(requirement.name);
    if (inRegular && inDev) {
      throw FormatException(
        '${requirement.name} is declared under both dependencies and '
        'dev_dependencies. Remove one declaration from pubspec.yaml and rerun. '
        'No source was written.',
      );
    }
    // Sections are asymmetric on purpose. A runtime requirement is satisfied
    // only by `dependencies`, because the installed source lives under the
    // consumer's lib/ and imports it; `dev_dependencies` are not available to
    // packages that depend on the consumer. A development requirement is
    // satisfied by either section, because regular placement is strictly
    // broader than the build-time need.
    if (!requirement.dev && inDev) {
      throw FormatException(
        '${requirement.name} is declared under dev_dependencies but installed '
        'source imports it at runtime. Move ${requirement.name} to '
        'dependencies in pubspec.yaml and rerun. No source was written.',
      );
    }
    if (!inRegular && !inDev) {
      missing.add(requirement);
      continue;
    }
    final declaration = inRegular
        ? regular[requirement.name]
        : dev[requirement.name];
    final existing = _hostedConstraint(declaration);
    if (existing != null &&
        existing.intersect(requirement.constraint).isEmpty) {
      throw FormatException(
        'Existing ${requirement.name} constraint $existing is incompatible with ${requirement.constraint}.',
      );
    }
  }
  return _DependencyInspection(List.unmodifiable(missing));
}

VersionConstraint? _hostedConstraint(Object? declaration) {
  if (declaration is String) return VersionConstraint.parse(declaration);
  if (declaration is YamlMap &&
      declaration.containsKey('hosted') &&
      declaration['version'] is String) {
    return VersionConstraint.parse(declaration['version'] as String);
  }
  return null;
}

// Returns the resolved version of every requirement so the caller can compare
// them against the registry snapshot; the versions are parsed here anyway.
Map<String, Version> _verifyLockedVersions(
  Directory root,
  List<_DependencyRequirement> requirements,
) {
  final locked = <String, Version>{};
  final lock = _findPubLock(root);
  final document = loadYaml(lock.readAsStringSync());
  final packages = document is YamlMap && document['packages'] is YamlMap
      ? document['packages'] as YamlMap
      : null;
  if (packages == null) {
    throw const FormatException('pubspec.lock has no packages map.');
  }
  for (final requirement in requirements) {
    final entry = packages[requirement.name];
    final lockedVersion = entry is YamlMap ? entry['version'] : null;
    final versionSource = lockedVersion is String
        ? lockedVersion
        : _resolvedPackageVersion(lock.parent, requirement.name);
    if (versionSource is! String) {
      throw FormatException(
        '${requirement.name} is missing from pubspec.lock.',
      );
    }
    final version = Version.parse(versionSource);
    if (!requirement.constraint.allows(version)) {
      throw FormatException(
        '${requirement.name} $version does not satisfy ${requirement.constraint}.',
      );
    }
    locked[requirement.name] = version;
  }
  return locked;
}

// The `remix` version this registry snapshot was authored against.
//
// It is the floor of the registry constraint, not a separate `tested:` key:
// `tool/check_version_alignment.dart` holds that floor equal to the released
// `remix` version, so a second field would only be another value to keep in
// step. A constraint with no lower bound — `any`, or a union — names no
// authored version, so there is nothing to compare and the caller stays quiet.
Version? _snapshotFloor(List<_DependencyRequirement> requirements) {
  for (final requirement in requirements) {
    if (requirement.name != 'remix') continue;
    final constraint = requirement.constraint;
    return constraint is VersionRange ? constraint.min : null;
  }
  return null;
}

String? _resolvedPackageVersion(Directory resolutionRoot, String packageName) {
  final root = _configuredPackageRoot(resolutionRoot, packageName);
  if (root == null) return null;
  final pubspec = File(p.join(root.path, 'pubspec.yaml'));
  if (!pubspec.existsSync()) return null;
  final document = loadYaml(pubspec.readAsStringSync());
  if (document is! YamlMap || document['name'] != packageName) return null;
  final version = document['version'];
  return version is String ? version : null;
}

// Pub has already resolved workspace globs, nested members, and overrides.
// Reuse its package map instead of interpreting workspace declarations again.
Directory? _configuredPackageRoot(
  Directory resolutionRoot,
  String packageName,
) {
  final packageConfig = File(
    p.join(resolutionRoot.path, '.dart_tool', 'package_config.json'),
  );
  if (!packageConfig.existsSync()) return null;
  final configDocument = jsonDecode(packageConfig.readAsStringSync());
  final configuredPackages = configDocument is Map
      ? configDocument['packages']
      : null;
  if (configuredPackages is! List) return null;
  final configured = configuredPackages.whereType<Map>().where(
    (entry) => entry['name'] == packageName,
  );
  if (configured.length != 1) return null;
  final rootUri = configured.single['rootUri'];
  if (rootUri is! String) return null;
  final uri = packageConfig.parent.uri.resolve(rootUri);
  if (uri.scheme != 'file') return null;
  final root = Directory.fromUri(uri);
  return root.existsSync() ? root : null;
}

File _findPubLock(Directory packageRoot) {
  final resolvedPackage = packageRoot.resolveSymbolicLinksSync();
  var candidate = Directory(resolvedPackage);

  while (true) {
    final lock = File(p.join(candidate.path, 'pubspec.lock'));
    if (lock.existsSync() &&
        (candidate.path == resolvedPackage ||
            _workspaceContains(candidate, resolvedPackage))) {
      return lock;
    }

    final parent = candidate.parent;
    if (parent.path == candidate.path) break;
    candidate = parent;
  }

  throw const FormatException(
    'flutter pub get did not create a package or workspace pubspec.lock.',
  );
}

bool _workspaceContains(Directory workspaceRoot, String resolvedPackage) {
  final pubspec = File(p.join(resolvedPackage, 'pubspec.yaml'));
  if (!pubspec.existsSync()) return false;

  final document = loadYaml(pubspec.readAsStringSync());
  final name = document is YamlMap ? document['name'] : null;
  if (name is! String) return false;
  final configured = _configuredPackageRoot(workspaceRoot, name);
  return configured?.resolveSymbolicLinksSync() == resolvedPackage;
}

// Package URIs preserve spaces and URI characters. Quote glob syntax so each
// filter selects one generated file, even when the UI path contains brackets.
String _generationFilter(String packageName, String target) => Uri(
  scheme: 'package',
  pathSegments: [
    packageName,
    ...p.posix.split(Glob.quote(target.substring(4))),
  ],
).toString();

String _resolveTarget(ProjectConfig config, String target) =>
    p.posix.join(config.uiPath, target.substring('@ui/'.length));

File _projectFile(Directory root, String relative) =>
    File(p.joinAll([root.path, ...p.posix.split(relative)]));

final class _FlutterToolchain {
  const _FlutterToolchain({required this.flutter, required this.dart});

  final String flutter;
  final String dart;
}

final class _DependencyRequirement {
  const _DependencyRequirement(this.name, this.constraint, {required this.dev});

  final String name;
  final VersionConstraint constraint;
  final bool dev;
}

final class _DependencyInspection {
  const _DependencyInspection(this.missing);

  final List<_DependencyRequirement> missing;
}

enum _ItemState { missing, partial, complete }

final _managedExport = RegExp(r"^export '([^']+)';$");
