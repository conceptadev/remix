import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Derives the application-owned Fortal registry from `remix_fortal` source.
///
/// Run without arguments to synchronize committed output. Pass `--check` to
/// compare in memory and fail on drift without writing.
void main(List<String> arguments) {
  final check = arguments.contains('--check');
  final unknown = arguments.where((argument) => argument != '--check').toList();
  if (unknown.isNotEmpty || arguments.length != (check ? 1 : 0)) {
    stderr.writeln('Usage: dart run tool/build_fortal_preset.dart [--check]');
    exitCode = 64;
    return;
  }

  final repositoryRoot = Directory.current.absolute;
  final pubspec = File(p.join(repositoryRoot.path, 'pubspec.yaml'));
  if (!pubspec.existsSync() ||
      !RegExp(
        r'^name:\s*remix_workspace\s*$',
        multiLine: true,
      ).hasMatch(pubspec.readAsStringSync())) {
    stderr.writeln('Run this tool from the Remix workspace root.');
    exitCode = 64;
    return;
  }

  try {
    final builder = FortalPresetBuilder.forRepository(repositoryRoot);
    final output = builder.derive();
    if (!check) {
      builder.write(output);
      stdout.writeln(
        'Wrote the Fortal preset: ${output.files.length - 1} templates and '
        'registry.yaml.',
      );
      return;
    }

    final drift = builder.drift(output);
    if (drift.isNotEmpty) {
      stderr
        ..writeln('The committed Fortal preset is stale:')
        ..writeln(drift.map((entry) => '  - $entry').join('\n'))
        ..writeln(
          'Run `dart run tool/build_fortal_preset.dart` and commit the result.',
        );
      exitCode = 1;
      return;
    }
    stdout.writeln('The committed Fortal preset matches authored source.');
  } on Object catch (error) {
    stderr.writeln(error);
    exitCode = 1;
  }
}

/// A deterministic snapshot of every file owned by the Fortal preset.
final class FortalPresetOutput {
  const FortalPresetOutput({
    required this.files,
    required this.sourceByTemplate,
  });

  /// Output paths relative to the preset root, including `registry.yaml`.
  final Map<String, String> files;

  /// Original authored source keyed by its derived template output path.
  ///
  /// This makes the substitution round trip directly testable without
  /// exposing filesystem implementation details.
  final Map<String, String> sourceByTemplate;
}

/// Builds one bundled registry tree from analyzer-checked Fortal Dart source.
final class FortalPresetBuilder {
  const FortalPresetBuilder({
    required this.sourceRoot,
    required this.defaultRegistryRoot,
    required this.outputRoot,
  });

  factory FortalPresetBuilder.forRepository(Directory repositoryRoot) {
    final registryRoot = Directory(
      p.join(
        repositoryRoot.path,
        'packages',
        'remix_cli',
        'lib',
        'src',
        'registry',
      ),
    );
    return FortalPresetBuilder(
      sourceRoot: Directory(
        p.join(repositoryRoot.path, 'packages', 'remix_fortal', 'lib', 'src'),
      ),
      defaultRegistryRoot: Directory(p.join(registryRoot.path, 'default')),
      outputRoot: Directory(p.join(registryRoot.path, 'fortal')),
    );
  }

  final Directory sourceRoot;
  final Directory defaultRegistryRoot;
  final Directory outputRoot;

  FortalPresetOutput derive() {
    if (!sourceRoot.existsSync()) {
      throw FormatException(
        'Fortal source root is missing: ${sourceRoot.path}',
      );
    }

    final sources = _readSources();
    _validateSources(sources);

    final floors = _readDefaultFloors();
    final output = <String, String>{};
    final sourceByTemplate = <String, String>{};
    final items = <String, _RegistryItemDraft>{};

    final themeSources = sources.entries
        .where((entry) => entry.key.startsWith('theme/'))
        .toList();
    if (themeSources.isEmpty ||
        !themeSources.any((entry) => entry.key == 'theme/theme.dart')) {
      throw const FormatException(
        'Fortal source must contain theme/theme.dart and its theme files.',
      );
    }

    final themeFiles = <_RegistryFileDraft>[];
    for (final entry in themeSources) {
      final name = p.posix.basename(entry.key);
      final templatePath = 'templates/theme/$name.tmpl';
      output[templatePath] = _templateFor(entry.key, entry.value);
      sourceByTemplate[templatePath] = entry.value;
      themeFiles.add(
        _RegistryFileDraft(source: templatePath, target: '@ui/theme/$name'),
      );
    }
    items['theme'] = _RegistryItemDraft(
      name: 'theme',
      dependencies: {'remix': floors['remix']!},
      files: themeFiles,
      exports: const ['theme/theme.dart'],
    );

    final defaultIcons = File(
      p.join(defaultRegistryRoot.path, 'templates', 'icons', 'icons.dart.tmpl'),
    );
    if (!defaultIcons.existsSync()) {
      throw FormatException(
        'Default icons template is missing: ${defaultIcons.path}',
      );
    }
    const iconsTemplate = 'templates/icons/icons.dart.tmpl';
    output[iconsTemplate] = defaultIcons.readAsStringSync();
    items['icons'] = _RegistryItemDraft(
      name: 'icons',
      registryDependencies: const ['theme'],
      dependencies: {'remix_ui_icons': floors['remix_ui_icons']!},
      files: const [
        _RegistryFileDraft(source: iconsTemplate, target: '@ui/icons.dart'),
      ],
      exports: const ['icons.dart'],
    );

    final componentNames = {
      for (final path in sources.keys)
        if (path.startsWith('components/'))
          p.posix.basenameWithoutExtension(path),
    };
    for (final entry in sources.entries.where(
      (entry) => entry.key.startsWith('components/'),
    )) {
      final name = p.posix.basenameWithoutExtension(entry.key);
      final templatePath = 'templates/$name/$name.dart.tmpl';
      final generated = _generatedPart(entry.value);
      final imports = _imports(entry.value);
      final registryDependencies = _registryDependencies(
        sourcePath: entry.key,
        imports: imports,
        componentNames: componentNames,
      );
      final dependencies = <String, String>{};
      final devDependencies = <String, String>{};
      if (generated != null) {
        dependencies['mix_annotations'] = floors['mix_annotations']!;
        devDependencies
          ..['build_runner'] = floors['build_runner']!
          ..['mix_generator'] = floors['mix_generator']!;
      }
      for (final package in const ['mix_chart', 'remix_ui_icons']) {
        if (imports.any((uri) => uri.startsWith('package:$package/'))) {
          dependencies[package] = floors[package]!;
        }
      }

      output[templatePath] = _templateFor(entry.key, entry.value);
      sourceByTemplate[templatePath] = entry.value;
      items[name] = _RegistryItemDraft(
        name: name,
        registryDependencies: registryDependencies,
        dependencies: dependencies,
        devDependencies: devDependencies,
        files: [
          _RegistryFileDraft(
            source: templatePath,
            target: '@ui/components/$name.dart',
          ),
        ],
        generated: generated == null ? const [] : ['@ui/components/$generated'],
        exports: ['components/$name.dart'],
      );
    }

    if (items.length != componentNames.length + 2) {
      throw StateError('Fortal registry item names collided.');
    }

    output['registry.yaml'] = _renderRegistry(items);
    return FortalPresetOutput(
      files: Map.unmodifiable(_sortedMap(output)),
      sourceByTemplate: Map.unmodifiable(_sortedMap(sourceByTemplate)),
    );
  }

  /// Synchronizes only the files owned beneath [outputRoot].
  void write(FortalPresetOutput output) {
    outputRoot.createSync(recursive: true);
    final expected = output.files.keys.toSet();
    for (final file in _outputFiles()) {
      final relative = _relative(file, outputRoot);
      if (!expected.contains(relative)) file.deleteSync();
    }
    for (final entry in output.files.entries) {
      final file = File(
        p.joinAll([outputRoot.path, ...p.posix.split(entry.key)]),
      );
      if (file.existsSync() && file.readAsStringSync() == entry.value) continue;
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(entry.value);
    }
  }

  /// Returns stable, human-readable differences without mutating output.
  List<String> drift(FortalPresetOutput output) {
    final differences = <String>[];
    final actual = {
      for (final file in _outputFiles()) _relative(file, outputRoot): file,
    };
    for (final entry in output.files.entries) {
      final file = actual.remove(entry.key);
      if (file == null) {
        differences.add('missing ${entry.key}');
      } else if (file.readAsStringSync() != entry.value) {
        differences.add('changed ${entry.key}');
      }
    }
    for (final stale in actual.keys) {
      differences.add('stale $stale');
    }
    differences.sort();
    return differences;
  }

  Map<String, String> _readSources() {
    final files =
        sourceRoot
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .where(
              (file) =>
                  file.path.endsWith('.dart') && !file.path.endsWith('.g.dart'),
            )
            .toList()
          ..sort((left, right) => left.path.compareTo(right.path));
    return {
      for (final file in files)
        _relative(file, sourceRoot): file.readAsStringSync(),
    };
  }

  void _validateSources(Map<String, String> sources) {
    final failures = <String>[];
    for (final entry in sources.entries) {
      final path = entry.key;
      final content = entry.value;
      if (p.posix
          .split(path)
          .any((segment) => segment.toLowerCase().contains('fortal'))) {
        failures.add('$path: a path segment contains "fortal"');
      }
      if (content.contains('{{')) {
        failures.add('$path: source contains the reserved template token "{{"');
      }
      for (final match in _importPattern.allMatches(content)) {
        final uri = match.group(1)!;
        if (_forbiddenImportPrefixes.any(uri.startsWith)) {
          failures.add('$path: forbidden installed-source import $uri');
        }
      }
      if (path != 'icons.dart' &&
          !path.startsWith('theme/') &&
          !path.startsWith('components/')) {
        failures.add('$path: unsupported Fortal source placement');
      }
    }
    if (failures.isNotEmpty) {
      failures.sort();
      throw FormatException(
        'Cannot derive the Fortal preset:\n${failures.map((failure) => '  - $failure').join('\n')}',
      );
    }
  }

  Map<String, String> _readDefaultFloors() {
    final registry = File(p.join(defaultRegistryRoot.path, 'registry.yaml'));
    if (!registry.existsSync()) {
      throw FormatException('Default registry is missing: ${registry.path}');
    }
    final document = loadYaml(registry.readAsStringSync());
    if (document is! YamlMap || document['items'] is! YamlMap) {
      throw FormatException('${registry.path} is not a registry map.');
    }
    final constraints = <String, Set<String>>{};
    for (final item in (document['items'] as YamlMap).values) {
      if (item is! YamlMap) continue;
      for (final sectionName in const ['dependencies', 'devDependencies']) {
        final section = item[sectionName];
        if (section is! YamlMap) continue;
        for (final entry in section.entries) {
          if (entry.key is String && entry.value is String) {
            constraints
                .putIfAbsent(entry.key as String, () => <String>{})
                .add(entry.value as String);
          }
        }
      }
    }

    const required = {
      'remix',
      'mix_annotations',
      'build_runner',
      'mix_generator',
      'mix_chart',
      'remix_ui_icons',
    };
    final floors = <String, String>{};
    for (final package in required) {
      final values = constraints[package];
      if (values == null || values.length != 1) {
        throw FormatException(
          'Default registry must declare one $package constraint; found '
          '${values?.join(', ') ?? 'none'}.',
        );
      }
      floors[package] = values.single;
    }
    return floors;
  }

  List<File> _outputFiles() {
    if (!outputRoot.existsSync()) return const [];
    final files =
        outputRoot
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList()
          ..sort((left, right) => left.path.compareTo(right.path));
    return files;
  }
}

final class _RegistryItemDraft {
  const _RegistryItemDraft({
    required this.name,
    this.registryDependencies = const [],
    this.dependencies = const {},
    this.devDependencies = const {},
    required this.files,
    this.generated = const [],
    required this.exports,
  });

  final String name;
  final List<String> registryDependencies;
  final Map<String, String> dependencies;
  final Map<String, String> devDependencies;
  final List<_RegistryFileDraft> files;
  final List<String> generated;
  final List<String> exports;
}

final class _RegistryFileDraft {
  const _RegistryFileDraft({required this.source, required this.target});

  final String source;
  final String target;
}

String _templateFor(String path, String source) {
  final template = source
      .replaceAll('Fortal', '{{typePrefix}}')
      .replaceAll('fortal', '{{valuePrefix}}');
  final roundTrip = template
      .replaceAll('{{typePrefix}}', 'Fortal')
      .replaceAll('{{valuePrefix}}', 'fortal');
  if (roundTrip != source) {
    throw StateError('$path did not survive the template round trip.');
  }
  return template;
}

List<String> _imports(String source) => [
  for (final match in _importPattern.allMatches(source)) match.group(1)!,
];

List<String> _registryDependencies({
  required String sourcePath,
  required List<String> imports,
  required Set<String> componentNames,
}) {
  final dependencies = <String>{};
  for (final uri in imports) {
    if (uri.startsWith('package:') || uri.startsWith('dart:')) continue;
    final resolved = p.posix.normalize(
      p.posix.join(p.posix.dirname(sourcePath), uri),
    );
    if (resolved.startsWith('theme/')) {
      dependencies.add('theme');
      continue;
    }
    if (resolved.startsWith('components/')) {
      final component = p.posix.basenameWithoutExtension(resolved);
      if (component != p.posix.basenameWithoutExtension(sourcePath)) {
        if (!componentNames.contains(component)) {
          throw FormatException(
            '$sourcePath imports missing component source $uri.',
          );
        }
        dependencies.add(component);
      }
    }
  }
  return [
    if (dependencies.remove('theme')) 'theme',
    ...(dependencies.toList()..sort()),
  ];
}

String? _generatedPart(String source) {
  final matches = RegExp(
    r'''^\s*part\s+['"]([^'"]+\.g\.dart)['"]\s*;''',
    multiLine: true,
  ).allMatches(source).toList();
  if (matches.length > 1) {
    throw const FormatException(
      'A component declares multiple generated parts.',
    );
  }
  return matches.singleOrNull?.group(1);
}

String _renderRegistry(Map<String, _RegistryItemDraft> items) {
  final ordered = <_RegistryItemDraft>[
    items['theme']!,
    items['icons']!,
    ...items.entries
        .where((entry) => entry.key != 'theme' && entry.key != 'icons')
        .map((entry) => entry.value)
        .toList()
      ..sort((left, right) => left.name.compareTo(right.name)),
  ];
  final buffer = StringBuffer()
    ..writeln('# Generated by tool/build_fortal_preset.dart. Do not edit.')
    ..writeln('schema: 1')
    ..writeln('items:');
  for (final item in ordered) {
    buffer.writeln('  ${item.name}:');
    _writeStringList(buffer, 'registryDependencies', item.registryDependencies);
    _writeConstraintMap(buffer, 'dependencies', item.dependencies);
    _writeConstraintMap(buffer, 'devDependencies', item.devDependencies);
    buffer.writeln('    files:');
    for (final file in item.files) {
      buffer
        ..writeln('      - source: ${file.source}')
        ..writeln('        target: "${file.target}"');
    }
    _writeStringList(buffer, 'generated', item.generated, quote: true);
    _writeStringList(buffer, 'exports', item.exports);
    buffer.writeln();
  }
  return '${buffer.toString().trimRight()}\n';
}

void _writeStringList(
  StringBuffer buffer,
  String name,
  List<String> values, {
  bool quote = false,
}) {
  if (values.isEmpty) return;
  buffer.writeln('    $name:');
  for (final value in values) {
    buffer.writeln('      - ${quote ? '"$value"' : value}');
  }
}

void _writeConstraintMap(
  StringBuffer buffer,
  String name,
  Map<String, String> values,
) {
  if (values.isEmpty) return;
  buffer.writeln('    $name:');
  for (final key in values.keys.toList()..sort()) {
    buffer.writeln('      $key: ${values[key]}');
  }
}

Map<String, String> _sortedMap(Map<String, String> source) {
  final keys = source.keys.toList()..sort();
  return {for (final key in keys) key: source[key]!};
}

String _relative(File file, Directory root) =>
    p.posix.joinAll(p.split(p.relative(file.path, from: root.path)));

final _importPattern = RegExp(
  r'''^\s*import\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

const _forbiddenImportPrefixes = <String>[
  'package:remix_fortal/',
  'package:mix/',
  'package:naked_ui/',
];
