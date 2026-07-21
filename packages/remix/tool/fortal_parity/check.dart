import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const _expectedIntegrity =
    'sha512-I0/h2CRNTpYNB7Mi3xFIvSsQq5a108d7kK8dTO5zp5b9HR5QJXKag6B8tjpz2ITkVYkFdkGk45doNkSr7OxwNw==';
const _expectedNakedUiVersion = '1.0.0-beta.7';
const _expectedMappedFamilies = <String>{
  'avatar',
  'badge',
  'button',
  'callout',
  'card',
  'checkbox',
  'dialog',
  'divider',
  'menu',
  'icon_button',
  'popover',
  'progress',
  'radio',
  'select',
  'slider',
  'spinner',
  'switch',
  'tabs',
  'text_field',
  'tooltip',
};
const _expectedExtensions = <String>{'accordion', 'toggle', 'toggle_group'};
const _expectedStyleProps = <String, Set<String>>{
  'avatar': {'color', 'radius', 'highContrast'},
  'badge': {'color', 'radius', 'highContrast'},
  'button': {'color', 'radius', 'highContrast'},
  'callout': {'color', 'highContrast'},
  'card': {},
  'checkbox': {'color', 'highContrast'},
  'dialog': {},
  'divider': {'color'},
  'menu': {'color', 'highContrast'},
  'icon_button': {'color', 'radius', 'highContrast'},
  'popover': {},
  'progress': {'color', 'radius', 'highContrast'},
  'radio': {'color', 'highContrast'},
  'select': {
    'triggerColor',
    'triggerRadius',
    'contentColor',
    'contentHighContrast',
  },
  'slider': {'color', 'radius', 'highContrast'},
  'spinner': {},
  'switch': {'color', 'radius', 'highContrast'},
  'tabs': {'color', 'highContrast'},
  'text_field': {'color', 'radius'},
  'tooltip': {},
};

void main() {
  final packageRoot = Directory.current;
  final pubspec = File('${packageRoot.path}/pubspec.yaml');
  if (!pubspec.existsSync() ||
      !pubspec.readAsStringSync().contains('name: remix')) {
    stderr.writeln('Run this checker from packages/remix.');
    exitCode = 64;
    return;
  }

  final workspaceRoot = packageRoot.parent.parent;
  final failures = <String>[];
  final manifestFile = File(
    '${packageRoot.path}/reference/radix_themes_3_3_0/manifest.json',
  );
  final manifest = _readObject(manifestFile, failures);
  if (manifest == null) {
    _finish(failures);
  }

  final evidencePath = manifest['coverageEvidence'];
  if (evidencePath is! String || evidencePath.isEmpty) {
    failures.add('coverageEvidence must be a package-relative JSON path.');
    _finish(failures);
  }
  final evidence = _readObject(
    File('${packageRoot.path}/$evidencePath'),
    failures,
  );
  if (evidence == null) {
    _finish(failures);
  }
  _checkCoverageEvidenceOwners(evidence, failures);

  _checkSource(manifest, failures);
  _checkTheme(manifest, evidence, packageRoot, failures);
  _checkFamilies(manifest, evidence, packageRoot, workspaceRoot, failures);
  _checkFixtures(manifest, packageRoot, failures);
  _checkNakedPin(
    pubspec,
    File('${workspaceRoot.path}/pubspec.yaml'),
    File('${workspaceRoot.path}/pubspec.lock'),
    failures,
  );
  _checkSingleConstructors(packageRoot, failures);
  _checkApproximations(manifest, failures);
  _finish(failures);
}

Map<String, Object?>? _readObject(File file, List<String> failures) {
  if (!file.existsSync()) {
    failures.add('Missing ${file.path}.');
    return null;
  }
  try {
    final value = jsonDecode(file.readAsStringSync());
    if (value is Map<String, Object?>) return value;
    failures.add('${file.path} must contain a JSON object.');
  } on FormatException catch (error) {
    failures.add('${file.path} is invalid JSON: $error');
  }
  return null;
}

void _checkSource(Map<String, Object?> manifest, List<String> failures) {
  final source = _object(manifest['source'], 'source', failures);
  if (source == null) return;
  _expect(
    source['package'] == '@radix-ui/themes',
    'source.package must be @radix-ui/themes.',
    failures,
  );
  _expect(
    source['version'] == '3.3.0',
    'source.version must be 3.3.0.',
    failures,
  );
  _expect(
    source['integrity'] == _expectedIntegrity,
    'source.integrity drifted from the approved npm artifact.',
    failures,
  );
  _expect(
    source['tarball'] ==
        'https://registry.npmjs.org/@radix-ui/themes/-/themes-3.3.0.tgz',
    'source.tarball drifted from the approved npm artifact.',
    failures,
  );
}

void _checkTheme(
  Map<String, Object?> manifest,
  Map<String, Object?> evidence,
  Directory packageRoot,
  List<String> failures,
) {
  final theme = _object(manifest['theme'], 'theme', failures);
  if (theme == null) return;
  final autoGray = _object(theme['autoGray'], 'theme.autoGray', failures);
  _expect(
    autoGray?.length == 26,
    'theme.autoGray must map all 26 accents.',
    failures,
  );
  _checkCoverage(
    owner: 'theme',
    enums: _enumKeys(theme['enums'], 'theme.enums', failures),
    states: _strings(theme['states'], 'theme.states', failures),
    coverageValue: theme['coverage'],
    evidence: evidence,
    packageRoot: packageRoot,
    failures: failures,
  );
}

void _checkFamilies(
  Map<String, Object?> manifest,
  Map<String, Object?> evidence,
  Directory packageRoot,
  Directory workspaceRoot,
  List<String> failures,
) {
  final familyValues = manifest['families'];
  if (familyValues is! List<Object?>) {
    failures.add('families must be a JSON array.');
    return;
  }
  final families = <String, Map<String, Object?>>{};
  final mapped = <String>{};
  final extensions = <String>{};
  for (final (index, value) in familyValues.indexed) {
    final family = _object(value, 'families[$index]', failures);
    if (family == null) continue;
    final id = family['id'];
    if (id is! String || id.isEmpty) {
      failures.add('families[$index].id must be a non-empty string.');
      continue;
    }
    if (families.containsKey(id)) failures.add('Duplicate family id: $id.');
    families[id] = family;
    switch (family['parity']) {
      case 'mapped':
        mapped.add(id);
      case 'extension':
        extensions.add(id);
      default:
        failures.add('$id.parity must be mapped or extension.');
    }

    final selectors = _strings(
      family['sourceSelectors'],
      '$id.sourceSelectors',
      failures,
    );
    final sourceFiles = _strings(
      family['sourceFiles'],
      '$id.sourceFiles',
      failures,
    );
    if (family['parity'] == 'mapped') {
      _expect(
        selectors.isNotEmpty,
        '$id must name its upstream selectors.',
        failures,
      );
      _expect(
        sourceFiles.isNotEmpty,
        '$id must name its upstream source files.',
        failures,
      );
      final actualProps = _strings(
        family['supportedStyleProps'],
        '$id.supportedStyleProps',
        failures,
      ).toSet();
      _expect(
        _sameSet(actualProps, _expectedStyleProps[id] ?? const {}),
        '$id supportedStyleProps drifted: $actualProps.',
        failures,
      );
    }
    _expect(
      _strings(
        family['flutterExceptions'],
        '$id.flutterExceptions',
        failures,
      ).isNotEmpty,
      '$id must document its Flutter mapping or extension status.',
      failures,
    );
    _checkCoverage(
      owner: id,
      enums: _enumKeys(family['enums'], '$id.enums', failures),
      states: _strings(family['states'], '$id.states', failures),
      coverageValue: family['coverage'],
      evidence: evidence,
      packageRoot: packageRoot,
      failures: failures,
    );
  }

  _expect(
    _sameSet(mapped, _expectedMappedFamilies),
    'Mapped family set drifted: $mapped.',
    failures,
  );
  _expect(
    _sameSet(extensions, _expectedExtensions),
    'Extension family set drifted: $extensions.',
    failures,
  );
  _expect(
    families.length == 23,
    'Exactly 23 Fortal families must be tracked.',
    failures,
  );

  final atlas = _object(manifest['atlas'], 'atlas', failures);
  final requiredAtlasIds = _strings(
    atlas?['requiredFamilyIds'],
    'atlas.requiredFamilyIds',
    failures,
  ).toSet();
  _expect(
    _sameSet(requiredAtlasIds, families.keys.toSet()),
    'Atlas family ids must equal the 23 manifest families.',
    failures,
  );

  final catalog = File(
    '${workspaceRoot.path}/packages/demo/test/atlas/support/fortal_atlas_catalog.dart',
  );
  if (!catalog.existsSync()) {
    failures.add('Missing ${catalog.path}.');
    return;
  }
  final catalogSource = catalog.readAsStringSync();
  for (final id in requiredAtlasIds) {
    final literal = "id: '$id'";
    if (!catalogSource.contains(literal)) {
      failures.add('Atlas catalog has no explicit $literal component.');
    }
  }
}

void _checkCoverage({
  required String owner,
  required Set<String> enums,
  required List<String> states,
  required Object? coverageValue,
  required Map<String, Object?> evidence,
  required Directory packageRoot,
  required List<String> failures,
}) {
  final coverage = _object(coverageValue, '$owner.coverage', failures);
  if (coverage == null) return;
  final coveredEnums = _strings(
    coverage['enums'],
    '$owner.coverage.enums',
    failures,
  ).toSet();
  final coveredStates = _strings(
    coverage['states'],
    '$owner.coverage.states',
    failures,
  ).toSet();
  _expect(
    _sameSet(coveredEnums, enums),
    '$owner enum coverage drifted. Expected $enums, found $coveredEnums.',
    failures,
  );
  _expect(
    _sameSet(coveredStates, states.toSet()),
    '$owner state coverage drifted. Expected ${states.toSet()}, found $coveredStates.',
    failures,
  );
  final tests = _strings(coverage['tests'], '$owner.coverage.tests', failures);
  _expect(
    tests.isNotEmpty,
    '$owner must cite at least one test file.',
    failures,
  );
  for (final relativePath in tests) {
    final test = File('${packageRoot.path}/$relativePath');
    if (!test.existsSync()) {
      failures.add('$owner cites missing test $relativePath.');
    } else if (!test.readAsStringSync().contains('test')) {
      failures.add(
        '$owner evidence $relativePath contains no test declaration.',
      );
    }
  }

  final evidenceValue = evidence[owner];
  if (evidenceValue is! List<Object?> || evidenceValue.isEmpty) {
    failures.add('$owner must have at least one coverage evidence case.');
    return;
  }

  final expectedEvidence = {
    ...enums.map((key) => 'enum:$key'),
    ...states.map((state) => 'state:$state'),
  };
  final coveredEvidence = <String>{};
  for (final (index, value) in evidenceValue.indexed) {
    final path = 'coverageEvidence.$owner[$index]';
    final entry = _object(value, path, failures);
    if (entry == null) continue;
    final relativePath = entry['test'];
    final testCase = entry['case'];
    if (relativePath is! String || relativePath.isEmpty) {
      failures.add('$path.test must be a non-empty path.');
      continue;
    }
    if (testCase is! String || testCase.isEmpty) {
      failures.add('$path.case must be a non-empty test description.');
      continue;
    }
    if (!tests.contains(relativePath)) {
      failures.add('$path cites $relativePath outside $owner.coverage.tests.');
    }
    final test = File('${packageRoot.path}/$relativePath');
    if (test.existsSync() && !_hasTestCase(test.readAsStringSync(), testCase)) {
      failures.add('$path cites missing executable test case "$testCase".');
    }

    final covers = _strings(entry['covers'], '$path.covers', failures);
    if (covers.isEmpty) {
      failures.add('$path must cover at least one enum or state.');
    }
    for (final key in covers) {
      if (!expectedEvidence.contains(key)) {
        failures.add('$path contains unknown coverage key $key.');
      }
      coveredEvidence.add(key);
    }
  }
  _expect(
    _sameSet(coveredEvidence, expectedEvidence),
    '$owner executable evidence drifted. Expected $expectedEvidence, '
    'found $coveredEvidence.',
    failures,
  );
}

void _checkCoverageEvidenceOwners(
  Map<String, Object?> evidence,
  List<String> failures,
) {
  final expectedOwners = {
    'theme',
    ..._expectedMappedFamilies,
    ..._expectedExtensions,
  };
  _expect(
    _sameSet(evidence.keys.toSet(), expectedOwners),
    'Coverage evidence owners drifted. Expected $expectedOwners, '
    'found ${evidence.keys.toSet()}.',
    failures,
  );
}

bool _hasTestCase(String source, String description) {
  final escaped = RegExp.escape(description);
  return RegExp(
    "\\b(?:test(?:Widgets)?|widgetControllerTest(?:<[^>]+>)?)"
    "\\s*\\(\\s*['\"]$escaped['\"]",
    multiLine: true,
  ).hasMatch(source);
}

Set<String> _enumKeys(Object? value, String path, List<String> failures) {
  final enums = _object(value, path, failures);
  if (enums == null) return {};
  final result = <String>{};
  for (final entry in enums.entries) {
    final definition = _object(entry.value, '$path.${entry.key}', failures);
    if (definition == null) continue;
    final values = _strings(
      definition['values'],
      '$path.${entry.key}.values',
      failures,
    );
    for (final value in values) {
      result.add('${entry.key}.$value');
    }
    if (definition.containsKey('default')) {
      final defaultValue = definition['default'];
      if (defaultValue != null && !values.contains(defaultValue)) {
        failures.add('$path.${entry.key}.default is not one of its values.');
      }
    }
  }
  return result;
}

void _checkFixtures(
  Map<String, Object?> manifest,
  Directory packageRoot,
  List<String> failures,
) {
  final fixtures = _object(
    manifest['referenceFixtures'],
    'referenceFixtures',
    failures,
  );
  if (fixtures == null) return;
  File resolve(String key) => File('${packageRoot.path}/${fixtures[key]}');
  for (final key in ['computedStyles', 'screenshot', 'generator', 'fixture']) {
    final value = fixtures[key];
    if (value is! String || value.isEmpty) {
      failures.add('referenceFixtures.$key must be a path.');
      continue;
    }
    if (!resolve(key).existsSync())
      failures.add('Missing reference fixture $value.');
  }

  final computed = _readObject(resolve('computedStyles'), failures);
  final source = computed == null
      ? null
      : _object(computed['source'], 'computedStyles.source', failures);
  _expect(
    source?['version'] == '3.3.0',
    'Computed styles must record Radix 3.3.0.',
    failures,
  );
  _expect(
    source?['integrity'] == _expectedIntegrity,
    'Computed-style npm integrity drifted.',
    failures,
  );
  final probes = computed == null
      ? null
      : _object(computed['probes'], 'computedStyles.probes', failures);
  final normalizedProbeIds =
      probes?.keys.map((id) => id.replaceAll('-', '_')).toSet() ?? {};
  _expect(
    _sameSet(normalizedProbeIds, _expectedMappedFamilies),
    'Computed styles must contain one probe for every mapped family.',
    failures,
  );

  final screenshot = resolve('screenshot');
  if (screenshot.existsSync()) {
    final bytes = screenshot.readAsBytesSync();
    final validSignature =
        bytes.length >= 24 &&
        const [
          137,
          80,
          78,
          71,
          13,
          10,
          26,
          10,
        ].indexed.every((entry) => bytes[entry.$1] == entry.$2);
    _expect(validSignature, 'Reference screenshot is not a PNG.', failures);
    if (validSignature) {
      final data = ByteData.sublistView(bytes);
      _expect(
        data.getUint32(16) == 1440 && data.getUint32(20) == 1280,
        'Reference screenshot must be 1440×1280.',
        failures,
      );
    }
  }

  final lock = _readObject(
    File('${packageRoot.path}/tool/fortal_parity/chromium/package-lock.json'),
    failures,
  );
  final packages = lock == null
      ? null
      : _object(lock['packages'], 'chromium lockfile packages', failures);
  final lockedThemes = packages == null
      ? null
      : _object(
          packages['node_modules/@radix-ui/themes'],
          'chromium lockfile Radix package',
          failures,
        );
  _expect(
    lockedThemes?['version'] == '3.3.0',
    'Chromium harness must lock Radix 3.3.0.',
    failures,
  );
  _expect(
    lockedThemes?['integrity'] == _expectedIntegrity,
    'Chromium harness integrity drifted.',
    failures,
  );
}

void _checkNakedPin(
  File packagePubspec,
  File workspacePubspec,
  File workspaceLock,
  List<String> failures,
) {
  final packageSource = packagePubspec.readAsStringSync();
  _expect(
    RegExp(
      '^  naked_ui: ${RegExp.escape(_expectedNakedUiVersion)}\\s*\$',
      multiLine: true,
    ).hasMatch(packageSource),
    'Remix must declare the exact naked_ui $_expectedNakedUiVersion '
    'dependency.',
    failures,
  );
  final workspaceSource = workspacePubspec.readAsStringSync();
  _expect(
    !_hasDependencyOverride(workspaceSource, 'naked_ui'),
    'The workspace must resolve naked_ui $_expectedNakedUiVersion from '
    'pub.dev without a dependency override.',
    failures,
  );
  final lockSource = workspaceLock.readAsStringSync();
  final nakedUiLockEntry = _lockEntry(lockSource, 'naked_ui');
  _expect(
    nakedUiLockEntry != null &&
        RegExp(
          r'^    source: hosted$',
          multiLine: true,
        ).hasMatch(nakedUiLockEntry) &&
        RegExp(
          '^    version: "${RegExp.escape(_expectedNakedUiVersion)}"\\s*\$',
          multiLine: true,
        ).hasMatch(nakedUiLockEntry),
    'The workspace lockfile must resolve naked_ui '
    '$_expectedNakedUiVersion from pub.dev.',
    failures,
  );
}

bool _hasDependencyOverride(String source, String dependency) {
  var inDependencyOverrides = false;
  for (final line in const LineSplitter().convert(source)) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#')) continue;
    final indentation = line.length - line.trimLeft().length;
    if (indentation == 0) {
      inDependencyOverrides = trimmed == 'dependency_overrides:';
      continue;
    }
    if (inDependencyOverrides &&
        indentation == 2 &&
        trimmed == '$dependency:') {
      return true;
    }
  }
  return false;
}

String? _lockEntry(String source, String dependency) {
  final lines = const LineSplitter().convert(source);
  final start = lines.indexOf('  $dependency:');
  if (start == -1) return null;
  var end = lines.length;
  for (var index = start + 1; index < lines.length; index++) {
    if (RegExp(r'^  [^ ]').hasMatch(lines[index])) {
      end = index;
      break;
    }
  }
  return lines.sublist(start, end).join('\n');
}

void _checkSingleConstructors(Directory packageRoot, List<String> failures) {
  final componentRoot = Directory('${packageRoot.path}/lib/src/components');
  for (final entity in componentRoot.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('_styles.dart')) continue;
    final source = entity.readAsStringSync();
    final named = RegExp(r'const\s+(Fortal[A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\s*\(')
        .allMatches(source)
        .map((match) => '${match.group(1)}.${match.group(2)}')
        .toSet();
    if (named.isNotEmpty) {
      failures.add('${entity.path} retains variant constructors: $named.');
    }
  }
}

void _checkApproximations(
  Map<String, Object?> manifest,
  List<String> failures,
) {
  final approximations = manifest['approximations'];
  if (approximations is! List<Object?>) {
    failures.add('approximations must be a JSON array.');
    return;
  }
  for (final (index, value) in approximations.indexed) {
    final approximation = _object(value, 'approximations[$index]', failures);
    if (approximation == null) continue;
    for (final field in [
      'family',
      'upstream',
      'flutter',
      'reason',
      'tolerance',
    ]) {
      if (approximation[field] is! String ||
          (approximation[field]! as String).isEmpty) {
        failures.add(
          'approximations[$index].$field must document the parity boundary.',
        );
      }
    }
  }
}

Map<String, Object?>? _object(
  Object? value,
  String path,
  List<String> failures,
) {
  if (value is Map<String, Object?>) return value;
  failures.add('$path must be a JSON object.');
  return null;
}

List<String> _strings(Object? value, String path, List<String> failures) {
  if (value is List<Object?> && value.every((item) => item is String)) {
    return value.cast<String>();
  }
  failures.add('$path must be an array of strings.');
  return const [];
}

bool _sameSet(Set<String> left, Set<String> right) =>
    left.length == right.length && left.containsAll(right);

void _expect(bool condition, String message, List<String> failures) {
  if (!condition) failures.add(message);
}

Never _finish(List<String> failures) {
  if (failures.isNotEmpty) {
    stderr.writeln(
      'Fortal parity contract failed (${failures.length} findings):',
    );
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    exit(1);
  }
  stdout.writeln(
    'Verified @radix-ui/themes 3.3.0 contract: '
    '20 mapped families, 3 Fortal extensions, Chromium fixtures, '
    'coverage ledger, Atlas inventory, hosted Naked '
    '$_expectedNakedUiVersion pin, and no '
    'undocumented approximations.',
  );
  exit(0);
}
