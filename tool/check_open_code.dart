/// Proves that the project-local CLI installs the open-code MVP into a fresh
/// Flutter application.
///
/// ```shell
/// dart run tool/check_open_code.dart [--keep]
/// ```
///
/// The checker writes only to a guarded system-temporary directory. It installs
/// this checkout's `remix_cli`, lets the CLI install every registry item, then
/// tests the installed source first with hosted Remix and again with a temporary
/// override to the current Remix checkout.
library;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

const _fixtureAppFiles = <String>[
  'pubspec.yaml',
  'analysis_options.yaml',
  'lib/main.dart',
  'test/open_code_test.dart',
];

/// The registry items the CLI installs, in invocation order.
///
/// Each is added by its own `remix add`, which is the only supported call
/// shape. Theme arrives as the first item's registry dependency.
const _registryItems = <String>[
  'avatar',
  'badge',
  'button',
  'callout',
  'card',
  'checkbox',
  'divider',
  'icon_button',
  'link',
  'progress',
  'radio',
  'segmented_control',
  'skeleton',
  'slider',
  'spinner',
  'switch',
  'tabs',
  'textfield',
  'toggle',
  'toggle_group',
];

/// Generated adapters compared byte-for-byte against a committed snapshot.
///
/// Representative shapes rather than every component: `button` is the
/// single-adapter case, `tabs` the multi-adapter one. These guard *generator*
/// drift, which is shape-wide; the fixture's behavior tests are the stronger
/// per-component guard.
///
/// The generator copies the recipe's doc comment into the adapter, so editing
/// prose in a template moves these bytes. A snapshot diff that is only
/// comments is expected and is refreshed, not investigated; a diff that
/// touches a constructor, a field, or a `build` body is the thing this is
/// here to catch.
const _generatedSnapshots = <String, String>{
  'lib/ui/components/button.g.dart': 'expected/acme_button.g.dart',
  'lib/ui/components/tabs.g.dart': 'expected/acme_tabs.g.dart',
};

/// Every file the CLI is expected to leave under `lib/ui/`, and nothing else.
///
/// Derived from [_registryItems] rather than restated: an item that installed
/// a file this list does not name would be a boundary violation, and a list
/// maintained by hand would drift into agreeing with whatever the CLI did.
final _installedUiFiles = <String>[
  'ui.dart',
  'theme/tokens.dart',
  'theme/theme_data.dart',
  'theme/theme_scope.dart',
  for (final item in _registryItems) ...[
    'components/$item.dart',
    'components/$item.g.dart',
  ],
];

final _generatedAppFiles = <String>[
  for (final item in _registryItems) 'lib/ui/components/$item.g.dart',
];

const _requiredRuntimeDependencies = <String>['remix', 'mix_annotations'];
const _requiredDevDependencies = <String>['build_runner', 'mix_generator'];
const _forbiddenDependencies = <String>['mix', 'naked_ui', 'remix_fortal'];
const _allowedImportPackages = <String>['flutter', 'remix', 'mix_annotations'];

Future<void> main(List<String> arguments) async {
  final keep = arguments.contains('--keep');
  final unknown = arguments.where((argument) => argument != '--keep').toList();
  if (unknown.isNotEmpty) {
    stderr.writeln('Unknown arguments: ${unknown.join(' ')}');
    stderr.writeln('Usage: dart run tool/check_open_code.dart [--keep]');
    exitCode = 64;
    return;
  }

  final repositoryRoot = Directory.current.absolute;
  final failure = await _run(repositoryRoot, keep: keep);
  if (failure != null) {
    stderr.writeln('open-code check failed: ${failure.message}');
    exitCode = failure.exitCode;
  }
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

  final coverageFailure = _verifyRegistryCoverage(repositoryRoot);
  if (coverageFailure != null) return coverageFailure;
  _step('Every bundled registry item is installed by this check.');

  final fixtureRoot = Directory('${repositoryRoot.path}/open_code/fixture');
  final fixtureFailure = _verifyFixtureContract(fixtureRoot);
  if (fixtureFailure != null) return fixtureFailure;
  _step('Fixture is a minimal pre-install app with no consumer build.yaml.');

  final parent = Directory.systemTemp.createTempSync('remix_open_code_');
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
    if (checkFailure != null) {
      return _retainedFailure(parent, checkFailure);
    }

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
      ..writeln('It has a temporary checkout override for Remix. Delete')
      ..writeln('pubspec_overrides.yaml and run `${sdk.flutter} pub get` to')
      ..writeln('return to hosted Remix.')
      ..writeln('')
      ..writeln('Run the gallery:')
      ..writeln('  cd ${app.path} && ${sdk.flutter} run -d chrome')
      ..writeln('')
      ..writeln('Review local source against the registry:')
      ..writeln(
        '  cd ${app.path} && ${sdk.dart} run remix_cli:remix add '
        '${_registryItems.first} --diff',
      );
  }

  stdout.writeln('open-code check passed.');
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
      'open_code_fixture',
      app.path,
    ],
    workingDirectory: app.parent.path,
    environment: environment,
  );
  if (create != null) return create;
  _step('Created a fresh Flutter application.');

  _replaceSkeleton(app: app, fixtureRoot: fixtureRoot);
  _step('Applied the committed pre-install fixture.');

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

  final init = await _runProcess(
    sdk.dart,
    ['run', 'remix_cli:remix', 'init', '--prefix', 'Acme'],
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
  _step('CLI installed Theme, every item, dependencies, and generated output.');

  final installedFailure = _verifyInstalledUi(app);
  if (installedFailure != null) return installedFailure;
  _step('Installed UI inventory and import boundary are exact.');

  final dependencyFailure = _verifyInstalledDependencies(app);
  if (dependencyFailure != null) return dependencyFailure;

  final hostedConfig = _readPackageConfig(app);
  if (hostedConfig is _Failure) return hostedConfig;
  final hostedPackages = hostedConfig as Map<String, String>;
  for (final package in [
    ..._requiredRuntimeDependencies,
    ..._requiredDevDependencies,
  ]) {
    final root = hostedPackages[package];
    if (root == null || !_isHostedCachePath(root)) {
      return _Failure(
        '$package resolved to ${root ?? 'nothing'}, expected a hosted cache.',
      );
    }
    stdout.writeln('  $package -> $root');
  }

  final hostedCheckoutFailure = _verifyCheckoutPackages(
    packages: hostedPackages,
    repositoryRoot: repositoryRoot,
    expected: {'remix_cli': cliRoot},
  );
  if (hostedCheckoutFailure != null) return hostedCheckoutFailure;
  _step('remix_cli is the only checkout package in hosted-consumer mode.');

  final generatedFailure = _verifyGeneratedFixture(
    app: app,
    fixtureRoot: fixtureRoot,
  );
  if (generatedFailure != null) return generatedFailure;
  _step('Hosted generation matches the committed Acme adapter.');

  final hostedVerification = await _analyzeAndTest(
    sdk: sdk,
    app: app,
    dependencySource: 'hosted Remix',
    environment: environment,
  );
  if (hostedVerification != null) return hostedVerification;

  final remixSource = Directory('${repositoryRoot.path}/packages/remix');
  if (!remixSource.existsSync()) {
    return _Failure('packages/remix is missing from this checkout.');
  }
  File('${app.path}/pubspec_overrides.yaml').writeAsStringSync('''
# Created in a guarded temporary app by tool/check_open_code.dart.
dependency_overrides:
  remix:
    path: ${remixSource.path}
''');

  final overrideGet = await _runProcess(
    sdk.flutter,
    ['pub', 'get'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (overrideGet != null) {
    return _Failure('flutter pub get failed with the Remix checkout override');
  }

  final currentConfig = _readPackageConfig(app);
  if (currentConfig is _Failure) return currentConfig;
  final currentPackages = currentConfig as Map<String, String>;
  final currentCheckoutFailure = _verifyCheckoutPackages(
    packages: currentPackages,
    repositoryRoot: repositoryRoot,
    expected: {'remix_cli': cliRoot, 'remix': remixSource},
  );
  if (currentCheckoutFailure != null) return currentCheckoutFailure;
  _step('Current-source override resolves only Remix and remix_cli locally.');

  for (final relative in _generatedAppFiles) {
    final generated = File('${app.path}/$relative');
    if (!generated.existsSync()) {
      return _Failure('CLI produced no $relative before regeneration.');
    }
    generated.deleteSync();
  }
  final regenerate = await _runProcess(
    sdk.dart,
    [
      'run',
      'build_runner',
      'build',
      for (final relative in _generatedAppFiles) '--build-filter=$relative',
    ],
    workingDirectory: app.path,
    environment: environment,
  );
  if (regenerate != null) {
    return _Failure('build_runner failed against current Remix source');
  }
  if (File('${app.path}/build.yaml').existsSync()) {
    return _Failure('generation created an app-level build.yaml');
  }

  final regeneratedFailure = _verifyGeneratedFixture(
    app: app,
    fixtureRoot: fixtureRoot,
  );
  if (regeneratedFailure != null) return regeneratedFailure;
  _step('Current-source regeneration matches the committed Acme adapter.');

  return _analyzeAndTest(
    sdk: sdk,
    app: app,
    dependencySource: 'current checkout',
    environment: environment,
  );
}

Future<_Failure?> _analyzeAndTest({
  required _Toolchain sdk,
  required Directory app,
  required String dependencySource,
  required Map<String, String> environment,
}) async {
  final analyze = await _runProcess(
    sdk.flutter,
    ['analyze'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (analyze != null) {
    return _Failure('flutter analyze failed against $dependencySource');
  }
  _step('flutter analyze is clean against $dependencySource.');

  final test = await _runProcess(
    sdk.flutter,
    ['test', '--reporter=failures-only'],
    workingDirectory: app.path,
    environment: environment,
  );
  if (test != null) {
    return _Failure('flutter test failed against $dependencySource');
  }
  _step('flutter test passed against $dependencySource.');
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
  if (!Directory('${root.path}/open_code').existsSync()) {
    return _Failure('open_code/ is missing from this checkout.', exitCode: 64);
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

/// Fails when [_registryItems] and the bundled registry have drifted apart.
///
/// This check exists because the failure it prevents is silent: an item added
/// to `registry.yaml` but not to [_registryItems] is never installed, never
/// rendered into the fixture, never behavior-tested, and never boundary
/// checked — and every suite still passes.
_Failure? _verifyRegistryCoverage(Directory repositoryRoot) {
  final file = File(
    '${repositoryRoot.path}/packages/remix_cli/lib/src/registry/registry.yaml',
  );
  if (!file.existsSync()) {
    return _Failure('packages/remix_cli is missing its registry.yaml.');
  }

  final document = loadYaml(file.readAsStringSync());
  if (document is! YamlMap || document['items'] is! YamlMap) {
    return _Failure('registry.yaml is not in the expected shape.');
  }

  // `theme` is every component's registry dependency, so the CLI installs it
  // on the first `add` rather than as an item of its own.
  final bundled = {
    for (final key in (document['items'] as YamlMap).keys)
      if (key is String && key != 'theme') key,
  };
  final installed = _registryItems.toSet();
  final problems = <String>[
    for (final item in bundled.difference(installed))
      'registry.yaml has $item, which this check never installs',
    for (final item in installed.difference(bundled))
      'this check installs $item, which registry.yaml does not define',
  ]..sort();

  if (problems.isEmpty) return null;
  return _Failure(
    'the checker and the bundled registry disagree on the catalog:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

_Failure? _verifyFixtureContract(Directory fixtureRoot) {
  final problems = <String>[];
  for (final relative in [..._fixtureAppFiles, ..._generatedSnapshots.values]) {
    if (!File('${fixtureRoot.path}/$relative').existsSync()) {
      problems.add('open_code/fixture/$relative is missing');
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
      problems.add('declares dependency_overrides');
    }
    _expectExactKeys(runtime, {'flutter'}, 'runtime', problems);
    _expectExactKeys(development, {'flutter_test'}, 'development', problems);
    if (!_isFlutterSdkDeclaration(runtime['flutter'])) {
      problems.add('flutter is not an SDK dependency');
    }
    if (!_isFlutterSdkDeclaration(development['flutter_test'])) {
      problems.add('flutter_test is not an SDK dependency');
    }
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'open_code/fixture is not the minimal CLI consumer contract:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

_Failure? _verifyInstalledDependencies(Directory app) {
  final sections = _dependencySections(
    File('${app.path}/pubspec.yaml').readAsStringSync(),
  );
  final runtime = sections['dependencies'] ?? const <String, Object?>{};
  final development = sections['dev_dependencies'] ?? const <String, Object?>{};
  final problems = <String>[];

  _expectExactKeys(
    runtime,
    {'flutter', ..._requiredRuntimeDependencies},
    'runtime',
    problems,
  );
  _expectExactKeys(
    development,
    {'flutter_test', 'remix_cli', ..._requiredDevDependencies},
    'development',
    problems,
  );
  for (final package in [
    ..._requiredRuntimeDependencies,
    ..._requiredDevDependencies,
  ]) {
    final declaration = runtime[package] ?? development[package];
    if (declaration is! String) {
      problems.add('$package is not a hosted version constraint');
    }
  }
  for (final package in _forbiddenDependencies) {
    if (runtime.containsKey(package) || development.containsKey(package)) {
      problems.add('declares forbidden direct dependency $package');
    }
  }
  final cli = development['remix_cli'];
  if (cli is! YamlMap || !cli.containsKey('path')) {
    problems.add('remix_cli is not a temporary path development dependency');
  }
  if (sections.containsKey('dependency_overrides')) {
    problems.add('hosted phase unexpectedly declares dependency_overrides');
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'CLI produced an invalid consumer dependency manifest:\n'
    '${problems.map((problem) => '  - $problem').join('\n')}',
  );
}

void _expectExactKeys(
  Map<String, Object?> actual,
  Set<String> expected,
  String section,
  List<String> problems,
) {
  for (final name in expected.difference(actual.keys.toSet())) {
    problems.add('missing $section dependency $name');
  }
  for (final name in actual.keys.toSet().difference(expected)) {
    problems.add('unexpected $section dependency $name');
  }
}

bool _isFlutterSdkDeclaration(Object? declaration) =>
    declaration is YamlMap && declaration['sdk'] == 'flutter';

_Failure? _verifyInstalledUi(Directory app) {
  if (File('${app.path}/build.yaml').existsSync()) {
    return _Failure('remix_cli created a consumer build.yaml');
  }
  final uiRoot = Directory('${app.path}/lib/ui');
  if (!uiRoot.existsSync()) {
    return _Failure('remix_cli created no lib/ui directory');
  }

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

_Failure? _verifyGeneratedFixture({
  required Directory app,
  required Directory fixtureRoot,
}) {
  for (final entry in _generatedSnapshots.entries) {
    final generated = File('${app.path}/${entry.key}');
    if (!generated.existsSync()) {
      return _Failure('generation produced no ${entry.key}');
    }
    final expected = File('${fixtureRoot.path}/${entry.value}');
    if (!_sameBytes(expected.readAsBytesSync(), generated.readAsBytesSync())) {
      return _Failure(
        '${entry.key} differs from open_code/fixture/${entry.value}. '
        'Regenerate with --keep and review the diff; do not hand-edit '
        'generated source.',
      );
    }
  }
  return null;
}

_Failure? _verifyCheckoutPackages({
  required Map<String, String> packages,
  required Directory repositoryRoot,
  required Map<String, Directory> expected,
}) {
  final repository = repositoryRoot.resolveSymbolicLinksSync();
  final problems = <String>[];

  for (final entry in packages.entries) {
    final directory = Directory(entry.value);
    if (!directory.existsSync()) continue;
    final resolved = directory.resolveSymbolicLinksSync();
    if (!_isWithin(resolved, repository) && resolved != repository) continue;

    final expectedDirectory = expected[entry.key];
    if (expectedDirectory == null) {
      problems.add('${entry.key} unexpectedly resolves inside the checkout');
    }
  }

  for (final entry in expected.entries) {
    final root = packages[entry.key];
    if (root == null) {
      problems.add('${entry.key} is absent from package_config.json');
      continue;
    }
    final actual = Directory(root).resolveSymbolicLinksSync();
    final wanted = entry.value.resolveSymbolicLinksSync();
    if (actual != wanted) {
      problems.add('${entry.key} resolves to $actual, expected $wanted');
    }
  }

  if (problems.isEmpty) return null;
  return _Failure(
    'checkout package boundary failed:\n'
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
  if (!_basename(resolved).startsWith('remix_open_code_')) {
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

bool _sameBytes(List<int> left, List<int> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index += 1) {
    if (left[index] != right[index]) return false;
  }
  return true;
}

/// Returns the fixture contract error for focused regression tests.
String? fixtureContractProblem(Directory fixtureRoot) =>
    _verifyFixtureContract(fixtureRoot)?.message;

/// Returns the catalog-drift error for focused regression tests.
String? registryCoverageProblem(Directory repositoryRoot) =>
    _verifyRegistryCoverage(repositoryRoot)?.message;

/// Returns installed inventory/import errors for focused regression tests.
String? installedUiProblem(Directory app) => _verifyInstalledUi(app)?.message;

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
