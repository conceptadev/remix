/// Proves that installed recipes style `remix_agent` in a fresh application.
///
/// ```shell
/// dart run tool/check_agent_consumer.dart [--keep]
/// ```
///
/// This is the gate the open-code review puts before any Agent registry item:
/// prove one consumer before converting eight surfaces. The checker writes only
/// to a guarded system-temporary directory. It installs this checkout's
/// `remix_cli`, lets the CLI install Theme, Card, TextField, and IconButton,
/// then points `remix` and `remix_agent` at this checkout and runs the
/// fixture's composer recipe against them.
///
/// It deliberately has no hosted phase. `remix_agent` is `publish_to: none`, so
/// there is no version to resolve and nothing here claims that hosted
/// installation works. That claim needs a release first; see
/// `packages/remix_agent/docs/adr/0001-package-boundary.md`.
library;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

/// The fixture files copied over the `flutter create` skeleton.
const _fixtureAppFiles = <String>[
  'pubspec.yaml',
  'analysis_options.yaml',
  'lib/main.dart',
  'lib/agent/composer.dart',
  'test/agent_consumer_test.dart',
];

/// The registry items the composer recipe composes, in invocation order.
///
/// Theme is named rather than left to arrive as a registry dependency, because
/// the review's acceptance step names it. The other three are exactly the
/// recipes `uiAgentComposerRecipe` calls.
const _registryItems = <String>['theme', 'card', 'textfield', 'icon_button'];

/// Every file the CLI is expected to leave under `lib/ui/`, and nothing else.
const _installedUiFiles = <String>[
  'ui.dart',
  'theme/tokens.dart',
  'theme/theme_data.dart',
  'theme/theme_scope.dart',
  'components/card.dart',
  'components/card.g.dart',
  'components/textfield.dart',
  'components/textfield.g.dart',
  'components/icon_button.dart',
  'components/icon_button.g.dart',
];

/// Packages that must resolve to this checkout once the overrides are applied.
const _checkoutPackages = <String>['remix', 'remix_agent', 'remix_cli'];

/// Packages that must still resolve from the hosted cache.
///
/// `lucide_icons_flutter` is here because it is Agent's own runtime
/// dependency: the check would be worthless if Agent's icon font were being
/// satisfied by something local.
const _hostedPackages = <String>[
  'mix',
  'mix_annotations',
  'lucide_icons_flutter',
];

/// The packages an installed file may import.
const _allowedImportPackages = <String>['flutter', 'remix', 'mix_annotations'];

/// The metric this check edits in the installed IconButton recipe.
///
/// Editing a recipe and rerunning the suite is the only evidence that Agent's
/// send and stop buttons are painted by the application's file rather than by
/// a copy Agent kept for itself.
const _originalMetric = '.small => (edge: 32.0, iconSize: 16.0)';
const _editedMetric = '.small => (edge: 44.0, iconSize: 16.0)';
const _editedEdge = 44;

/// What `remix add --diff` prints when the installed source is up to date.
const _cleanDiff = 'No authored-source differences.';

Future<void> main(List<String> arguments) async {
  final keep = arguments.contains('--keep');
  final unknown = arguments.where((argument) => argument != '--keep').toList();
  if (unknown.isNotEmpty) {
    stderr.writeln('Unknown arguments: ${unknown.join(' ')}');
    stderr.writeln('Usage: dart run tool/check_agent_consumer.dart [--keep]');
    exitCode = 64;
    return;
  }

  final repositoryRoot = Directory.current.absolute;
  final failure = await _run(repositoryRoot, keep: keep);
  if (failure != null) {
    stderr.writeln('agent consumer check failed: ${failure.message}');
    exitCode = failure.exitCode;
    return;
  }
  stdout.writeln('agent consumer check passed.');
}

Future<_Failure?> _run(Directory repositoryRoot, {required bool keep}) async {
  final rootFailure = _verifyRepositoryRoot(repositoryRoot);
  if (rootFailure != null) return rootFailure;

  final pinnedVersion = _pinnedFlutterVersion(repositoryRoot);
  if (pinnedVersion == null) {
    return _Failure('.fvmrc does not pin a Flutter version.', exitCode: 64);
  }

  final resolved = await _resolveToolchain(repositoryRoot, pinnedVersion);
  if (resolved is _Failure) return resolved;
  final sdk = resolved as _Toolchain;
  _step('Flutter ${sdk.version} from ${sdk.root}');

  final fixtureRoot = Directory(
    '${repositoryRoot.path}/open_code/agent_fixture',
  );
  final fixtureFailure = _verifyFixtureContract(fixtureRoot);
  if (fixtureFailure != null) return fixtureFailure;
  _step('Fixture is a pre-install app whose only named dependency is Agent.');

  final parent = Directory.systemTemp.createTempSync('remix_agent_consumer_');
  final app = Directory('${parent.path}/app');

  try {
    final guardFailure = _verifyDeletableParent(parent, repositoryRoot);
    if (guardFailure != null) return _retainedFailure(parent, guardFailure);

    final checkFailure = await _checkInTemporaryApp(
      sdk: sdk,
      repositoryRoot: repositoryRoot,
      fixtureRoot: fixtureRoot,
      app: app,
    );
    if (checkFailure != null) return _retainedFailure(parent, checkFailure);

    if (!keep) {
      final deletionFailure = _deleteVerifiedParent(parent, repositoryRoot);
      if (deletionFailure != null) {
        return _retainedFailure(parent, deletionFailure);
      }
    }
  } on Object catch (error, stackTrace) {
    return _retainedFailure(parent, error, stackTrace: stackTrace);
  }

  if (keep) {
    stdout
      ..writeln('')
      ..writeln('Kept the generated application at:')
      ..writeln('  ${app.path}')
      ..writeln('')
      ..writeln('It overrides remix and remix_agent with this checkout.')
      ..writeln('')
      ..writeln('Run the page:')
      ..writeln('  cd ${app.path} && ${sdk.flutter} run -d chrome');
  }
  return null;
}

Future<_Failure?> _checkInTemporaryApp({
  required _Toolchain sdk,
  required Directory repositoryRoot,
  required Directory fixtureRoot,
  required Directory app,
}) async {
  final environment = _toolchainEnvironment(sdk);

  final create = await _runProcess(
    sdk.flutter,
    [
      'create',
      '--empty',
      '--no-pub',
      '--platforms=web',
      '--project-name',
      'agent_consumer_fixture',
      app.path,
    ],
    workingDirectory: app.parent.path,
    environment: environment,
  );
  if (create != null) return create;
  _step('Created a fresh Flutter application.');

  _replaceSkeleton(app: app, fixtureRoot: fixtureRoot);

  final sources = <String, Directory>{
    for (final package in ['remix', 'remix_agent'])
      package: Directory('${repositoryRoot.path}/packages/$package'),
  };
  for (final entry in sources.entries) {
    if (!entry.value.existsSync()) {
      return _Failure('packages/${entry.key} is missing from this checkout.');
    }
  }

  // Written before the first resolution: the fixture names `remix_agent`, and
  // the package is private, so nothing resolves without the override.
  File('${app.path}/pubspec_overrides.yaml').writeAsStringSync('''
# Created in a guarded temporary app by tool/check_agent_consumer.dart.
dependency_overrides:
${sources.entries.map((entry) => '  ${entry.key}:\n    path: ${entry.value.path}').join('\n')}
''');
  _step('Applied the fixture and the Agent and Remix checkout overrides.');

  final cliRoot = Directory('${repositoryRoot.path}/packages/remix_cli');
  if (!cliRoot.existsSync()) {
    return _Failure('packages/remix_cli is missing from this checkout.');
  }
  final addCli = await _runProcess(
    sdk.dart,
    ['pub', 'add', 'dev:remix_cli@{path: ${cliRoot.path}}'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (addCli != null) {
    return _Failure('could not add the checkout CLI to the temporary app');
  }

  // No `--prefix`: the CLI's default is `Ui`, which is the prefix the review's
  // proposed `uiAgentComposerRecipe()` is written against.
  final init = await _runProcess(
    sdk.dart,
    ['run', 'remix_cli:remix', 'init'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (init != null) return _Failure('remix init failed in the fresh app');

  for (final item in _registryItems) {
    final add = await _runProcess(
      sdk.dart,
      ['run', 'remix_cli:remix', 'add', item],
      workingDirectory: app.path,
      environment: environment,
    );
    if (add != null) return _Failure('remix add $item failed in the fresh app');
  }
  _step(
    'CLI installed ${_registryItems.join(', ')} and generated their parts.',
  );

  final installedFailure = _verifyInstalledUi(app);
  if (installedFailure != null) return installedFailure;
  _step('Installed UI inventory is exactly the four items the recipe uses.');

  final config = _readPackageConfig(app);
  if (config is _Failure) return config;
  final packages = config as Map<String, String>;
  final resolutionFailure = _verifyResolution(
    packages: packages,
    repositoryRoot: repositoryRoot,
  );
  if (resolutionFailure != null) return resolutionFailure;
  _step('Agent and Remix resolve to this checkout; Mix stays hosted.');

  final verification = await _analyzeAndTest(
    sdk: sdk,
    app: app,
    environment: environment,
  );
  if (verification != null) return verification;

  return _verifyRecipeOwnership(sdk: sdk, app: app, environment: environment);
}

/// Edits the installed IconButton recipe and reruns the suite.
///
/// Two claims are settled here. The rerun with the new expectation proves the
/// edit reached Agent's send and stop buttons, so Agent has no private copy of
/// the recipe. The `--diff` proves the CLI treats the edited file as the
/// application's, which is the other half of the ownership contract.
Future<_Failure?> _verifyRecipeOwnership({
  required _Toolchain sdk,
  required Directory app,
  required Map<String, String> environment,
}) async {
  final recipe = File('${app.path}/lib/ui/components/icon_button.dart');
  final original = recipe.readAsStringSync();
  if (!original.contains(_originalMetric)) {
    return _Failure(
      'the installed IconButton recipe no longer contains\n'
      '  $_originalMetric\n'
      'This check edits that line to prove the edit reaches Agent. Point it '
      'at the metric the recipe declares now.',
    );
  }
  recipe.writeAsStringSync(
    original.replaceFirst(_originalMetric, _editedMetric),
  );

  final rerun = await _runProcess(
    sdk.flutter,
    [
      'test',
      '--reporter=failures-only',
      '--dart-define=AGENT_RECIPE_EDGE=$_editedEdge',
    ],
    workingDirectory: app.path,
    environment: environment,
  );
  if (rerun != null) {
    return _Failure(
      'editing the application IconButton recipe did not change the Agent '
      'send and stop buttons',
    );
  }
  _step('An IconButton recipe edit reaches Agent send and stop.');

  final diff = await Process.run(
    sdk.dart,
    ['run', 'remix_cli:remix', 'add', 'icon_button', '--diff'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (diff.exitCode != 0) {
    return _Failure('`remix add icon_button --diff` exited ${diff.exitCode}');
  }
  if ((diff.stdout as String).contains(_cleanDiff)) {
    return _Failure(
      'the CLI reports no difference after the recipe was edited, so the '
      'installed file is not the one Agent resolves',
    );
  }
  _step('The CLI reports the edited recipe as application-owned source.');

  recipe.writeAsStringSync(original);
  return null;
}

Future<_Failure?> _analyzeAndTest({
  required _Toolchain sdk,
  required Directory app,
  required Map<String, String> environment,
}) async {
  final analyze = await _runProcess(
    sdk.flutter,
    ['analyze'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (analyze != null) return _Failure('flutter analyze failed');
  _step('flutter analyze is clean.');

  final test = await _runProcess(
    sdk.flutter,
    ['test', '--reporter=failures-only'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (test != null) return _Failure('flutter test failed');
  _step('flutter test passed against the installed recipes.');
  return null;
}

_Failure? _verifyRepositoryRoot(Directory root) {
  final pubspec = File('${root.path}/pubspec.yaml');
  if (!pubspec.existsSync() ||
      !pubspec.readAsStringSync().contains('name: remix_workspace')) {
    return _Failure(
      'run this checker from the Remix workspace root.',
      exitCode: 64,
    );
  }
  return null;
}

String? _pinnedFlutterVersion(Directory root) {
  final file = File('${root.path}/.fvmrc');
  if (!file.existsSync()) return null;
  final decoded = jsonDecode(file.readAsStringSync());
  if (decoded is! Map) return null;
  final version = decoded['flutter'];
  return version is String && version.isNotEmpty ? version : null;
}

Future<Object> _resolveToolchain(Directory root, String pinned) async {
  final candidates = <List<String>>[
    ['fvm', 'flutter'],
    ['flutter'],
  ];
  final attempts = <String>[];

  for (final candidate in candidates) {
    final ProcessResult result;
    try {
      result = await Process.run(candidate.first, [
        ...candidate.skip(1),
        '--version',
        '--machine',
      ], workingDirectory: root.path);
    } on ProcessException catch (error) {
      attempts.add('${candidate.join(' ')}: ${error.message}');
      continue;
    }
    if (result.exitCode != 0) {
      attempts.add('${candidate.join(' ')}: exited ${result.exitCode}');
      continue;
    }

    try {
      final output = result.stdout as String;
      final jsonStart = output.indexOf('{');
      if (jsonStart < 0) throw const FormatException('no JSON object');
      final decoded = jsonDecode(output.substring(jsonStart));
      if (decoded is! Map) throw const FormatException('unexpected JSON');
      final version = decoded['frameworkVersion'];
      final sdkRoot = decoded['flutterRoot'];
      if (version is! String || sdkRoot is! String) {
        throw const FormatException('incomplete toolchain JSON');
      }
      if (version != pinned) {
        attempts.add(
          '${candidate.join(' ')}: Flutter $version, expected $pinned',
        );
        continue;
      }
      return _Toolchain(
        version: version,
        root: sdkRoot,
        flutter: '$sdkRoot/bin/flutter',
        dart: '$sdkRoot/bin/dart',
      );
    } on FormatException catch (error) {
      attempts.add('${candidate.join(' ')}: ${error.message}');
    }
  }

  return _Failure(
    'no Flutter SDK matching the .fvmrc pin ($pinned) was found.\n'
    '${attempts.map((attempt) => '  - $attempt').join('\n')}\n'
    '  Install it with `fvm install $pinned`, or put a matching SDK on PATH.',
    exitCode: 64,
  );
}

_Failure? _verifyFixtureContract(Directory fixtureRoot) {
  final problems = <String>[];
  for (final relative in _fixtureAppFiles) {
    if (!File('${fixtureRoot.path}/$relative').existsSync()) {
      problems.add('open_code/agent_fixture/$relative is missing');
    }
  }
  if (File('${fixtureRoot.path}/build.yaml').existsSync()) {
    problems.add('declares a consumer build.yaml');
  }

  final pubspec = File('${fixtureRoot.path}/pubspec.yaml');
  if (pubspec.existsSync()) {
    final sections = _dependencySections(pubspec.readAsStringSync());
    final runtime = sections['dependencies'] ?? const <String, Object?>{};
    final development =
        sections['dev_dependencies'] ?? const <String, Object?>{};
    if (sections.containsKey('dependency_overrides')) {
      // The overrides are the checker's, written into the temporary app. A
      // committed one would resolve against whatever path it named.
      problems.add('declares dependency_overrides');
    }
    _expectExactKeys(runtime, {'flutter', 'remix_agent'}, 'runtime', problems);
    _expectExactKeys(development, {'flutter_test'}, 'development', problems);
    if (!_isFlutterSdkDeclaration(runtime['flutter'])) {
      problems.add('flutter is not an SDK dependency');
    }
    if (!_isFlutterSdkDeclaration(development['flutter_test'])) {
      problems.add('flutter_test is not an SDK dependency');
    }
    if (runtime['remix_agent'] != 'any') {
      problems.add(
        'remix_agent is constrained to ${runtime['remix_agent']}; Agent is '
        'unpublished, so the fixture must not name a version it cannot get',
      );
    }
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'open_code/agent_fixture is not the expected consumer contract:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

void _expectExactKeys(
  Map<String, Object?> section,
  Set<String> expected,
  String label,
  List<String> problems,
) {
  final actual = section.keys.toSet();
  final missing = expected.difference(actual);
  final extra = actual.difference(expected);
  if (missing.isNotEmpty) {
    problems.add('$label is missing ${missing.join(', ')}');
  }
  if (extra.isNotEmpty) {
    problems.add('$label declares unexpected ${extra.join(', ')}');
  }
}

bool _isFlutterSdkDeclaration(Object? declaration) =>
    declaration is YamlMap && declaration['sdk'] == 'flutter';

_Failure? _verifyInstalledUi(Directory app) {
  if (File('${app.path}/build.yaml').existsSync()) {
    return _Failure('remix_cli created a consumer build.yaml');
  }
  final uiRoot = Directory('${app.path}/lib/ui');
  if (!uiRoot.existsSync()) return _Failure('remix_cli created no lib/ui/.');

  final found =
      uiRoot
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .map((file) => _relativePath(uiRoot, file))
          .toList()
        ..sort();
  final expected = [..._installedUiFiles]..sort();
  final problems = <String>[];
  for (final relative in expected) {
    if (!found.contains(relative)) problems.add('installed UI lacks $relative');
  }
  for (final relative in found) {
    if (!expected.contains(relative)) {
      problems.add('installed UI has an unexpected file: $relative');
    }
  }
  problems.addAll(_installedReferenceProblems(uiRoot));

  if (problems.isEmpty) return null;
  return _Failure(
    'installed UI violates the registry boundary:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

List<String> _installedReferenceProblems(Directory uiRoot) {
  final directive = RegExp(
    r'''^\s*(?:import|export|part(?:\s+of)?)\s+([^;]+);''',
    multiLine: true,
  );
  final quotedUri = RegExp(r'''(?:'([^']*)'|"([^"]*)")''');
  final problems = <String>[];

  for (final file
      in uiRoot
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .where((candidate) => candidate.path.endsWith('.dart'))) {
    final relative = _relativePath(uiRoot, file);
    for (final match in directive.allMatches(file.readAsStringSync())) {
      for (final uriMatch in quotedUri.allMatches(match.group(1)!)) {
        final uri = uriMatch.group(1) ?? uriMatch.group(2)!;
        final problem = _referenceProblem(uri, from: relative);
        if (problem != null) problems.add('$relative: $problem');
      }
    }
  }
  return problems;
}

/// Rejects a reference the installed layer is not allowed to make.
///
/// `remix_agent` is the one that matters here and it is deliberately absent
/// from [_allowedImportPackages]: the dependency runs one way. The application
/// composes installed recipes into an Agent call site, and no installed file
/// may reach back into Agent to do it.
String? _referenceProblem(String uri, {required String from}) {
  if (uri.startsWith('dart:')) return null;
  if (uri.startsWith('package:')) {
    final package = uri.substring('package:'.length).split('/').first;
    if (_allowedImportPackages.contains(package)) return null;
    return 'imports package:$package, which is outside the registry contract';
  }
  if (uri.contains(':')) return 'uses the non-relative URI `$uri`';
  if (uri.startsWith('/')) return 'uses the absolute path `$uri`';

  final resolved = Uri.parse(from).resolve(uri).path;
  if (resolved.startsWith('..') || resolved.startsWith('/')) {
    return '`$uri` escapes lib/ui';
  }
  if (!_installedUiFiles.contains(resolved)) {
    return '`$uri` resolves to $resolved, which is not installed';
  }
  return null;
}

_Failure? _verifyResolution({
  required Map<String, String> packages,
  required Directory repositoryRoot,
}) {
  final problems = <String>[];
  for (final package in _checkoutPackages) {
    final root = packages[package];
    if (root == null) {
      problems.add('$package did not resolve at all');
      continue;
    }
    if (!_isWithin(
      Directory(root).absolute.resolveSymbolicLinksSync(),
      repositoryRoot.resolveSymbolicLinksSync(),
    )) {
      problems.add('$package resolved to $root, outside this checkout');
    }
  }
  for (final package in _hostedPackages) {
    final root = packages[package];
    if (root == null || !_isHostedCachePath(root)) {
      problems.add(
        '$package resolved to ${root ?? 'nothing'}, expected a hosted cache',
      );
    }
  }
  if (packages.containsKey('remix_fortal')) {
    problems.add('remix_fortal reached the consumer');
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'the consumer did not resolve the expected sources:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

void _replaceSkeleton({
  required Directory app,
  required Directory fixtureRoot,
}) {
  final lib = Directory('${app.path}/lib');
  if (lib.existsSync()) lib.deleteSync(recursive: true);
  final tests = Directory('${app.path}/test');
  if (tests.existsSync()) tests.deleteSync(recursive: true);
  final lock = File('${app.path}/pubspec.lock');
  if (lock.existsSync()) lock.deleteSync();
  final build = File('${app.path}/build.yaml');
  if (build.existsSync()) build.deleteSync();

  for (final relative in _fixtureAppFiles) {
    final target = File('${app.path}/$relative');
    target.parent.createSync(recursive: true);
    File('${fixtureRoot.path}/$relative').copySync(target.path);
  }
}

Object _readPackageConfig(Directory app) {
  final file = File('${app.path}/.dart_tool/package_config.json');
  if (!file.existsSync()) {
    return _Failure('pub get produced no .dart_tool/package_config.json');
  }
  final decoded = jsonDecode(file.readAsStringSync());
  if (decoded is! Map || decoded['packages'] is! List) {
    return _Failure('package_config.json is not in the expected shape');
  }

  final roots = <String, String>{};
  for (final entry in decoded['packages'] as List) {
    if (entry is! Map) continue;
    final name = entry['name'];
    final rootUri = entry['rootUri'];
    if (name is! String || rootUri is! String) continue;
    roots[name] = rootUri.startsWith('file:')
        ? Uri.parse(rootUri).toFilePath()
        : file.parent.uri.resolve(rootUri).toFilePath();
  }
  return roots;
}

Map<String, String> _toolchainEnvironment(_Toolchain sdk) => {
  'PATH':
      '${sdk.root}/bin${Platform.isWindows ? ';' : ':'}'
      '${Platform.environment['PATH'] ?? ''}',
};

bool _isHostedCachePath(String path) {
  final separator = Platform.pathSeparator;
  return path.contains('${separator}hosted$separator');
}

_Failure? _verifyDeletableParent(Directory parent, Directory repositoryRoot) {
  final problems = <String>[];
  final resolved = parent.resolveSymbolicLinksSync();
  final temp = Directory.systemTemp.resolveSymbolicLinksSync();
  final repository = repositoryRoot.resolveSymbolicLinksSync();

  if (!_isWithin(resolved, temp)) problems.add('$resolved is not inside $temp');
  if (_isWithin(resolved, repository) || resolved == repository) {
    problems.add('$resolved is inside the repository');
  }
  if (!_basename(resolved).startsWith('remix_agent_consumer_')) {
    problems.add('$resolved was not created by this checker');
  }
  if (FileSystemEntity.isLinkSync(parent.path)) {
    problems.add('$resolved is a symbolic link');
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'refusing to use a temporary directory that cannot be proven safe:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

_Failure? _deleteVerifiedParent(Directory parent, Directory repositoryRoot) {
  final guard = _verifyDeletableParent(parent, repositoryRoot);
  if (guard != null) return guard;
  parent.deleteSync(recursive: true);
  return null;
}

bool _isWithin(String path, String parent) =>
    path.startsWith(parent.endsWith('/') ? parent : '$parent/');

String _basename(String path) => path.split(Platform.pathSeparator).last;

Future<_Failure?> _runProcess(
  String executable,
  List<String> arguments, {
  required String workingDirectory,
  Map<String, String>? environment,
}) async {
  stdout.writeln('\$ $executable ${arguments.join(' ')}');
  final Process process;
  try {
    process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      mode: ProcessStartMode.inheritStdio,
    );
  } on ProcessException catch (error) {
    return _Failure('could not start `$executable`: ${error.message}');
  }
  final code = await process.exitCode;
  if (code == 0) return null;
  return _Failure('`$executable ${arguments.join(' ')}` exited $code');
}

Map<String, Map<String, Object?>> _dependencySections(String pubspec) {
  const sectionNames = {
    'dependencies',
    'dev_dependencies',
    'dependency_overrides',
  };
  final document = loadYaml(pubspec);
  if (document is! YamlMap) return const {};

  final parsed = <String, Map<String, Object?>>{};
  for (final section in sectionNames) {
    if (!document.containsKey(section)) continue;
    final node = document[section];
    parsed[section] = {
      if (node is YamlMap)
        for (final entry in node.entries) entry.key.toString(): entry.value,
    };
  }
  return parsed;
}

String _relativePath(Directory root, File file) =>
    file.path.substring(root.path.length + 1);

/// Returns the fixture contract error for focused regression tests.
String? agentFixtureContractProblem(Directory fixtureRoot) =>
    _verifyFixtureContract(fixtureRoot)?.message;

/// Returns the installed inventory error for focused regression tests.
String? agentInstalledUiProblem(Directory app) =>
    _verifyInstalledUi(app)?.message;

/// Formats a post-creation failure so the retained directory is always named.
String retainedFailureMessage(
  Directory parent,
  Object problem, {
  StackTrace? stackTrace,
}) {
  final String message;
  if (problem is _Failure) {
    message = problem.message;
  } else {
    final stack = stackTrace == null ? '' : '\n$stackTrace';
    message = 'unexpected exception: $problem$stack';
  }
  return '$message\nTemporary application preserved at ${parent.path}';
}

_Failure _retainedFailure(
  Directory parent,
  Object problem, {
  StackTrace? stackTrace,
}) => _Failure(
  retainedFailureMessage(parent, problem, stackTrace: stackTrace),
  exitCode: problem is _Failure ? problem.exitCode : 1,
);

void _step(String message) => stdout.writeln('✓ $message');

final class _Toolchain {
  const _Toolchain({
    required this.version,
    required this.root,
    required this.flutter,
    required this.dart,
  });

  final String version;
  final String root;
  final String flutter;
  final String dart;
}

final class _Failure {
  const _Failure(this.message, {this.exitCode = 1});

  final String message;
  final int exitCode;
}
