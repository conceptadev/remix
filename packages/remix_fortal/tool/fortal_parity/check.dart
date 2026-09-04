import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const _expectedIntegrity =
    'sha512-I0/h2CRNTpYNB7Mi3xFIvSsQq5a108d7kK8dTO5zp5b9HR5QJXKag6B8tjpz2ITkVYkFdkGk45doNkSr7OxwNw==';
const _expectedNakedUiVersion = '1.0.0-beta.14';

/// A range, not the exact version, because these are two different guarantees
/// enforced in two different places. The parity contract is validated against
/// exactly [_expectedNakedUiVersion], and the *lockfile* check below is what
/// pins that: the workspace must resolve it hosted, byte-exact. The pubspec
/// constraint is the consumer surface, and pub.dev refuses to publish an exact
/// hosted constraint ("your dependency should allow more than one version",
/// exit 65) — an exact pin here made the v1.0.0-beta.7 publish impossible.
/// The floor still names the tested release; both packages must carry this
/// identical string.
const _expectedNakedUiConstraint = '^1.0.0-beta.14';
const _expectedMappedFamilies = <String>{
  'avatar',
  'badge',
  'button',
  'callout',
  'card',
  'checkbox',
  'code',
  'data_list',
  'data_table',
  'dialog',
  'divider',
  'heading',
  'kbd',
  'link',
  'menu',
  'icon_button',
  'popover',
  'progress',
  'radio',
  'select',
  'segmented_control',
  'slider',
  'skeleton',
  'spinner',
  'switch',
  'tabs',
  'text',
  'text_area',
  'text_field',
  'tooltip',
};
const _expectedExtensions = <String>{
  'accordion',
  'disclosure',
  'toggle',
  'toggle_group',
};
const _expectedUnmappedUpstreamFamilies = <String>{'checkbox_group'};

/// The five typography families publish one shared nine-step `FortalTextSize`
/// instead of five parallel size enums, so their `size` resolves against the
/// shared typography source rather than a per-family Dart enum.
const _sharedTextSizeFamilies = <String>{
  'code',
  'heading',
  'kbd',
  'link',
  'text',
};

void main() {
  final packageRoot = Directory.current;
  final pubspec = File('${packageRoot.path}/pubspec.yaml');
  // Anchored so `name: remix` (the sibling package) cannot satisfy the guard.
  if (!pubspec.existsSync() ||
      !RegExp(
        r'^name:\s*remix_fortal\s*$',
        multiLine: true,
      ).hasMatch(pubspec.readAsStringSync())) {
    stderr.writeln('Run this checker from packages/remix_fortal.');
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
  final testSourceCache = <String, String>{};

  _checkSource(manifest, failures);
  _checkTheme(
    manifest,
    evidence,
    packageRoot,
    workspaceRoot,
    testSourceCache,
    failures,
  );
  _checkFamilies(
    manifest,
    evidence,
    packageRoot,
    workspaceRoot,
    testSourceCache,
    failures,
  );
  _checkFixtures(manifest, packageRoot, failures);
  final remixPubspec = File(
    '${workspaceRoot.path}/packages/remix/pubspec.yaml',
  );
  _checkNakedPin(
    pubspec,
    remixPubspec,
    File('${workspaceRoot.path}/pubspec.yaml'),
    File('${workspaceRoot.path}/pubspec.lock'),
    failures,
  );
  _checkRemixHostedPin(pubspec, remixPubspec, failures);
  _checkVariantConstructors(packageRoot, failures);
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
  Directory workspaceRoot,
  Map<String, String> testSourceCache,
  List<String> failures,
) {
  final theme = _object(manifest['theme'], 'theme', failures);
  if (theme == null) return;
  _expect(
    theme['upstreamInventory'] is Map<String, Object?>,
    'theme must retain a separate upstreamInventory.',
    failures,
  );
  _expect(
    _strings(
      theme['supportedVisualStates'],
      'theme.supportedVisualStates',
      failures,
    ).isNotEmpty,
    'theme must list supportedVisualStates separately.',
    failures,
  );
  _checkCoverage(
    owner: 'theme',
    enums: _enumKeys(theme['enums'], 'theme.enums', failures),
    states: _strings(theme['states'], 'theme.states', failures),
    coverageValue: theme['coverage'],
    evidence: evidence,
    packageRoot: packageRoot,
    workspaceRoot: workspaceRoot,
    testSourceCache: testSourceCache,
    failures: failures,
  );
}

void _checkFamilies(
  Map<String, Object?> manifest,
  Map<String, Object?> evidence,
  Directory packageRoot,
  Directory workspaceRoot,
  Map<String, String> testSourceCache,
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
    final stylesSource = _readFortalStylesSource(packageRoot, id, failures);
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
      if (stylesSource != null) {
        final sourceExposesHighContrast = _recipeExposesHighContrast(
          stylesSource,
        );
        _expect(
          actualProps.contains('highContrast') == sourceExposesHighContrast,
          '$id supportedStyleProps.highContrast drifted: manifest='
          '${actualProps.contains('highContrast')}, '
          'source=$sourceExposesHighContrast.',
          failures,
        );
      }
      // `color` and `radius` describe the upstream Radix prop surface rather
      // than Dart recipe parameters. Review owns that mapping, anchored by the
      // required sourceFiles and sourceSelectors above.
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
    _expect(
      family['upstreamInventory'] is Map<String, Object?>,
      '$id must retain a separate upstreamInventory.',
      failures,
    );
    _expect(
      family['visualMapping'] is Map<String, Object?>,
      '$id must document its Flutter visualMapping.',
      failures,
    );
    _strings(
      family['deferredCapabilities'],
      '$id.deferredCapabilities',
      failures,
    );
    if (id == 'disclosure') {
      _checkDisclosurePrimitiveContract(family, failures);
    }
    _checkCoverage(
      owner: id,
      enums: _familyEnumKeys(
        family: family,
        id: id,
        stylesSource: stylesSource,
        failures: failures,
      ),
      states: _strings(family['states'], '$id.states', failures),
      coverageValue: family['coverage'],
      evidence: evidence,
      packageRoot: packageRoot,
      workspaceRoot: workspaceRoot,
      testSourceCache: testSourceCache,
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
    families.length == 34,
    'Exactly 34 Fortal families must be tracked.',
    failures,
  );
  _checkUnmappedUpstreamFamilies(manifest, families.keys.toSet(), failures);
  _checkGlobalUpstreamInventory(manifest, families.keys.toSet(), failures);
}

/// The manifest keeps a second, family-independent upstream inventory so the
/// upstream contract can be read without the Fortal mapping beside it. Nothing
/// kept the two in step, and `data_table` was tracked with no inventory entry;
/// requiring set equality makes a new family fail until both are written.
void _checkGlobalUpstreamInventory(
  Map<String, Object?> manifest,
  Set<String> trackedFamilyIds,
  List<String> failures,
) {
  final inventory = _object(
    manifest['upstreamInventory'],
    'upstreamInventory',
    failures,
  );
  if (inventory == null) return;
  _expect(
    inventory['theme'] is Map<String, Object?>,
    'upstreamInventory.theme must be a JSON object.',
    failures,
  );
  final families = _object(
    inventory['families'],
    'upstreamInventory.families',
    failures,
  );
  if (families == null) return;
  final ids = families.keys.toSet();
  _expect(
    _sameSet(ids, trackedFamilyIds),
    'Global upstream inventory drifted from the tracked family set. Missing '
    '${trackedFamilyIds.difference(ids)}, unexpected '
    '${ids.difference(trackedFamilyIds)}.',
    failures,
  );
  for (final entry in families.entries) {
    _object(entry.value, 'upstreamInventory.families.${entry.key}', failures);
  }
  final disclosure = _object(
    families['disclosure'],
    'upstreamInventory.families.disclosure',
    failures,
  );
  if (disclosure != null) {
    _checkDisclosureUpstreamInventory(
      disclosure,
      'upstreamInventory.families.disclosure',
      failures,
    );
  }
}

void _checkDisclosurePrimitiveContract(
  Map<String, Object?> family,
  List<String> failures,
) {
  _expect(
    family['radixComponent'] == 'Collapsible' &&
        family['parity'] == 'extension',
    'disclosure must map the Radix Collapsible primitive as a Fortal extension.',
    failures,
  );
  _expect(
    _strings(family['sourceFiles'], 'disclosure.sourceFiles', failures).isEmpty,
    'disclosure must not claim Radix Themes source files.',
    failures,
  );
  _expect(
    _strings(
      family['sourceSelectors'],
      'disclosure.sourceSelectors',
      failures,
    ).isEmpty,
    'disclosure must not claim Radix Themes style selectors.',
    failures,
  );
  final inventory = _object(
    family['upstreamInventory'],
    'disclosure.upstreamInventory',
    failures,
  );
  if (inventory != null) {
    _checkDisclosureUpstreamInventory(
      inventory,
      'disclosure.upstreamInventory',
      failures,
    );
  }
}

void _checkDisclosureUpstreamInventory(
  Map<String, Object?> inventory,
  String path,
  List<String> failures,
) {
  final enums = _object(inventory['enums'], '$path.enums', failures);
  _expect(
    enums != null && enums.isEmpty,
    '$path.enums must remain empty because Radix Collapsible exposes no enums.',
    failures,
  );
  final states = _strings(inventory['states'], '$path.states', failures);
  _expect(
    _sameSet(states.toSet(), const {'open', 'closed', 'disabled'}),
    '$path.states must be exactly open, closed, and disabled.',
    failures,
  );
  final styleProps = _strings(
    inventory['supportedStyleProps'],
    '$path.supportedStyleProps',
    failures,
  );
  _expect(
    styleProps.isEmpty,
    '$path.supportedStyleProps must remain empty because Radix Themes does not style Collapsible.',
    failures,
  );
}

String? _readFortalStylesSource(
  Directory packageRoot,
  String id,
  List<String> failures,
) {
  // Components are flat under lib/src/components/, and TextField and TextArea
  // share one file because TextArea reuses TextField's private helpers.
  final recipeName = switch (id) {
    'text_field' || 'text_area' => 'textfield',
    _ => id,
  };
  final file = File('${packageRoot.path}/lib/src/components/$recipeName.dart');
  if (!file.existsSync()) {
    failures.add('$id is missing Fortal recipe source ${file.path}.');
    return null;
  }
  final source = file.readAsStringSync();
  if (!_sharedTextSizeFamilies.contains(id)) return source;

  // The shared scale, weights, and flow helpers live beside the five
  // typography recipes rather than inside any one of them.
  final shared = File('${packageRoot.path}/lib/src/components/typography.dart');
  if (!shared.existsSync()) {
    failures.add('$id is missing shared typography source ${shared.path}.');
    return source;
  }

  return '$source\n${shared.readAsStringSync()}';
}

void _checkUnmappedUpstreamFamilies(
  Map<String, Object?> manifest,
  Set<String> trackedFamilyIds,
  List<String> failures,
) {
  final values = manifest['unmappedUpstreamFamilies'];
  if (values is! List<Object?>) {
    failures.add('unmappedUpstreamFamilies must be a JSON array.');
    return;
  }

  final ids = <String>{};
  for (final (index, value) in values.indexed) {
    final path = 'unmappedUpstreamFamilies[$index]';
    final family = _object(value, path, failures);
    if (family == null) continue;
    final id = family['id'];
    if (id is! String || id.isEmpty) {
      failures.add('$path.id must be a non-empty string.');
      continue;
    }
    if (!ids.add(id)) failures.add('Duplicate unmapped family id: $id.');
    _expect(
      !trackedFamilyIds.contains(id),
      '$id cannot be both tracked and intentionally unmapped.',
      failures,
    );

    final sourceFiles = _strings(
      family['sourceFiles'],
      '$path.sourceFiles',
      failures,
    ).toSet();
    final selectors = _strings(
      family['sourceSelectors'],
      '$path.sourceSelectors',
      failures,
    ).toSet();
    _expect(
      sourceFiles.isNotEmpty,
      '$id must name pinned source files.',
      failures,
    );
    _expect(
      selectors.isNotEmpty,
      '$id must name pinned source selectors.',
      failures,
    );
    for (final field in [
      'supportedRemixComposition',
      'reason',
      'reopenCondition',
    ]) {
      final text = family[field];
      _expect(
        text is String && text.isNotEmpty,
        '$path.$field must be a non-empty string.',
        failures,
      );
    }
    _expect(
      family['upstreamInventory'] is Map<String, Object?>,
      '$path.upstreamInventory must document the upstream contract.',
      failures,
    );

    if (id == 'checkbox_group') {
      _expect(
        _sameSet(sourceFiles, const {
          'src/components/checkbox-group.props.tsx',
          'src/components/checkbox-group.css',
          'src/components/checkbox-group.tsx',
        }),
        'checkbox_group pinned source files drifted.',
        failures,
      );
      _expect(
        _sameSet(selectors, const {
          '.rt-CheckboxGroupRoot',
          '.rt-CheckboxGroupItem',
          '.rt-CheckboxGroupItemCheckbox',
          '.rt-CheckboxGroupItemInner',
        }),
        'checkbox_group pinned selectors drifted.',
        failures,
      );
      final inventory = family['upstreamInventory'];
      if (inventory is Map<String, Object?>) {
        final enums = _enumKeys(
          inventory['enums'],
          '$path.upstreamInventory.enums',
          failures,
        );
        _expect(
          _sameSet(enums, const {
            'size.size1',
            'size.size2',
            'size.size3',
            'variant.classic',
            'variant.surface',
            'variant.soft',
          }),
          'checkbox_group size/variant inventory drifted.',
          failures,
        );
        _expect(
          _sameSet(
            _strings(
              inventory['supportedStyleProps'],
              '$path.upstreamInventory.supportedStyleProps',
              failures,
            ).toSet(),
            const {'color', 'highContrast'},
          ),
          'checkbox_group color/highContrast inventory drifted.',
          failures,
        );
        final layout = _object(
          inventory['layout'],
          '$path.upstreamInventory.layout',
          failures,
        );
        _expect(
          layout?['rootGap'] == 'space1' && layout?['itemLabelGap'] == '0.5em',
          'checkbox_group pinned gap inventory drifted.',
          failures,
        );
      }
    }
  }

  _expect(
    _sameSet(ids, _expectedUnmappedUpstreamFamilies),
    'Unmapped upstream family set drifted: $ids.',
    failures,
  );
}

/// Code, Kbd, and Link derive em-relative geometry from the resolved font size,
/// so their recipes take a leading positional [BuildContext] before the named
/// block. Without allowing it here every context-bound recipe would read as
/// exposing no `highContrast`.
bool _recipeExposesHighContrast(String source) {
  return RegExp(
    r'\bfortal[A-Za-z0-9_]+Style\s*\('
    r'\s*(?:BuildContext\s+[A-Za-z0-9_]+\s*,\s*)?\{[^}]*'
    r'\bbool\s+highContrast\b',
    dotAll: true,
  ).hasMatch(source);
}

Set<String> _familyEnumKeys({
  required Map<String, Object?> family,
  required String id,
  required String? stylesSource,
  required List<String> failures,
}) {
  final enums = _object(family['enums'], '$id.enums', failures);
  if (enums == null) return {};
  final fortalType = family['fortalType'];
  if (fortalType is! String || fortalType.isEmpty) {
    failures.add('$id.fortalType must be a non-empty string.');
  }

  final result = <String>{};
  for (final entry in enums.entries) {
    final kind = entry.key;
    final definition = _object(entry.value, '$id.enums.$kind', failures);
    if (definition == null) continue;
    final documentedValues = _strings(
      definition['values'],
      '$id.enums.$kind.values',
      failures,
    );
    if (definition.containsKey('default')) {
      final defaultValue = definition['default'];
      if (defaultValue != null && !documentedValues.contains(defaultValue)) {
        failures.add(
          '$id.enums.$kind.default is not one of its documented values.',
        );
      }
      if (stylesSource != null &&
          fortalType is String &&
          fortalType.isNotEmpty) {
        _checkRecipeDefault(
          id: id,
          kind: kind,
          fortalType: fortalType,
          manifestDefault: defaultValue,
          stylesSource: stylesSource,
          failures: failures,
        );
      }
    }

    Iterable<String> expectedValues = documentedValues;
    if (kind == 'size' || kind == 'variant') {
      if (stylesSource == null || fortalType is! String || fortalType.isEmpty) {
        continue;
      }
      final candidates = _fortalEnumCandidates(
        id: id,
        kind: kind,
        fortalType: fortalType,
      );
      RegExpMatch? enumMatch;
      for (final candidate in candidates) {
        enumMatch = RegExp(
          'enum\\s+${RegExp.escape(candidate)}\\s*\\{([^}]*)\\}',
          dotAll: true,
        ).firstMatch(stylesSource);
        if (enumMatch != null) break;
      }
      if (enumMatch == null) {
        failures.add(
          '$id could not resolve its Dart $kind enum; tried $candidates.',
        );
        continue;
      }
      expectedValues = _dartEnumValues(enumMatch.group(1)!);
    } else {
      // Other enum kinds do not consistently map to named Fortal Dart enums.
    }

    for (final value in expectedValues) {
      result.add('$kind.$value');
    }
  }
  return result;
}

void _checkCoverage({
  required String owner,
  required Set<String> enums,
  required List<String> states,
  required Object? coverageValue,
  required Map<String, Object?> evidence,
  required Directory packageRoot,
  required Directory workspaceRoot,
  required Map<String, String> testSourceCache,
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
    final found = _resolveCitedTests(packageRoot, workspaceRoot, relativePath);
    if (found.isEmpty) {
      failures.add('$owner cites missing test $relativePath.');
    } else if (!found.any((file) => file.readAsStringSync().contains('test'))) {
      failures.add(
        '$owner evidence $relativePath contains no test declaration.',
      );
    }
  }

  final evidenceValue = evidence[owner];
  if (evidenceValue is! List<Object?> || evidenceValue.isEmpty) {
    failures.add('$owner must retain upstream coverage evidence.');
    return;
  }
  for (final (index, value) in evidenceValue.indexed) {
    final citation = _object(
      value,
      'coverageEvidence.$owner[$index]',
      failures,
    );
    if (citation == null) continue;
    final relativePath = citation['test'];
    final caseName = citation['case'];
    if (relativePath is! String || relativePath.isEmpty) {
      failures.add(
        'coverageEvidence.$owner[$index].test must be a non-empty path.',
      );
      continue;
    }
    if (caseName is! String || caseName.isEmpty) {
      failures.add('coverageEvidence.$owner[$index].case must be non-empty.');
      continue;
    }
    final found = _resolveCitedTests(packageRoot, workspaceRoot, relativePath);
    if (found.isEmpty) {
      failures.add('$owner evidence cites missing test $relativePath.');
      continue;
    }
    final source = testSourceCache.putIfAbsent(
      relativePath,
      () => found.map((file) => file.readAsStringSync()).join('\n'),
    );
    if (!source.contains(caseName)) {
      failures.add(
        '$owner evidence $relativePath cites missing case "$caseName".',
      );
    }
  }
}

/// Resolves a cited test path across both `remix_fortal` and `remix`.
///
/// The coverage ledger cites tests by package-relative path. Extracting Fortal
/// split those tests across two packages, and a single path such as
/// `test/components/menu/menu_widget_test.dart` now commonly exists in *both*:
/// `remix` keeps the base behavior cases, `remix_fortal` keeps the Fortal ones.
/// Returning every match — and searching their union for a cited case — keeps
/// the ledger's paths stable instead of rewriting every citation.
List<File> _resolveCitedTests(
  Directory packageRoot,
  Directory workspaceRoot,
  String relativePath,
) {
  return [
    for (final root in [
      packageRoot.path,
      '${workspaceRoot.path}/packages/remix',
    ])
      File('$root/$relativePath'),
  ].where((file) => file.existsSync()).toList();
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
  File remixPubspec,
  File workspacePubspec,
  File workspaceLock,
  List<String> failures,
) {
  // Both publishable packages must carry the identical hosted constraint,
  // whose floor is the release the parity contract was validated against.
  // The exact tested resolution is enforced on the lockfile below, not here.
  final pinned = RegExp(
    '^  naked_ui: ${RegExp.escape(_expectedNakedUiConstraint)}\\s*\$',
    multiLine: true,
  );
  for (final entry in <String, File>{
    'remix_fortal': packagePubspec,
    'remix': remixPubspec,
  }.entries) {
    _expect(
      pinned.hasMatch(entry.value.readAsStringSync()),
      '${entry.key} must constrain naked_ui to $_expectedNakedUiConstraint.',
      failures,
    );
  }
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

/// Guards the publish-order hazard: `remix_fortal` must depend on a *hosted*
/// `remix` whose floor is the version `remix` currently declares.
///
/// The invariant behind the equality is that the floor must name a `remix` that
/// does **not** export Fortal. `remix` releases up to and including 1.0.0-beta.1
/// bundled `FortalScope`, `FortalTokens`, and the `Fortal*` widgets, so a floor
/// that admits one of those lets pub resolve a `remix` whose symbols collide
/// with this package's. Keeping the floor pinned to whatever `remix` currently
/// declares means the version bump that removes Fortal also forces this floor
/// forward.
///
/// `dart pub publish --dry-run` cannot catch this — it validates the pubspec
/// text and packs a tarball without re-resolving against the live registry, so
/// a stale or path-shaped constraint would only fail after `remix_fortal` is
/// already published.
void _checkRemixHostedPin(
  File packagePubspec,
  File remixPubspec,
  List<String> failures,
) {
  final source = packagePubspec.readAsStringSync();
  // `melos version` rewrites this floor when `remix` bumps, because
  // remix_fortal depends on it. A trailing comment is still tolerated so the
  // line can carry a note without failing the contract.
  final declared = RegExp(
    r'^  remix:\s*\^?([^\s#]+)\s*(?:#.*)?$',
    multiLine: true,
  ).firstMatch(source);
  _expect(
    declared != null,
    'remix_fortal must declare remix as a hosted constraint on one line '
    '(no path: or git: entry).',
    failures,
  );
  if (declared == null) return;

  final remixVersion = RegExp(
    r'^version:\s*(\S+)\s*$',
    multiLine: true,
  ).firstMatch(remixPubspec.readAsStringSync())?.group(1);
  if (remixVersion == null) {
    failures.add('packages/remix/pubspec.yaml must declare a version.');

    return;
  }

  _expect(
    declared.group(1) == remixVersion,
    'remix_fortal must constrain remix to ^$remixVersion to match '
    'packages/remix/pubspec.yaml (found ^${declared.group(1)}). The floor has '
    'to name a remix release that no longer exports Fortal, or pub can resolve '
    'a remix whose Fortal symbols collide with this package.',
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

/// The Dart enum names a family's `kind` could publish, most specific first.
///
/// The typography families share one nine-step scale and one weight enum
/// instead of five parallel copies, so their `size` and `weight` anchor on the
/// shared names. Every other kind is named after either the widget type or the
/// manifest id, which differ for the families whose id is not a straight
/// lower-snake of the type (`icon_button` publishes `FortalIconButtonVariant`,
/// while `tabs` publishes `FortalTabsSize` against a `FortalTabBar` type).
Set<String> _fortalEnumCandidates({
  required String id,
  required String kind,
  required String fortalType,
}) {
  if (_sharedTextSizeFamilies.contains(id)) {
    if (kind == 'size') return {'FortalTextSize'};
    if (kind == 'weight') return {'FortalTextWeight'};
  }
  final suffix = '${kind[0].toUpperCase()}${kind.substring(1)}';
  final idType = id
      .split('_')
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join();
  return {'$fortalType$suffix', 'Fortal$idType$suffix'};
}

/// Verifies the manifest's recorded default is the one a caller actually gets.
///
/// The membership check in [_familyEnumKeys] only proves the default names one
/// of its own documented values, so it stays green when a recipe's `= .size2`
/// becomes `= .size3` — the manifest would then publish a default no caller
/// receives. This reads the recipe signature, which is where the default is
/// authored: `melos generate:check` already fails on any drift between a recipe
/// and the widget constructor generated from it, so the recipe is the single
/// place worth comparing against.
void _checkRecipeDefault({
  required String id,
  required String kind,
  required String fortalType,
  required Object? manifestDefault,
  required String stylesSource,
  required List<String> failures,
}) {
  final candidates = _fortalEnumCandidates(
    id: id,
    kind: kind,
    fortalType: fortalType,
  );
  final enumName = candidates.firstWhere(
    (candidate) => RegExp(
      'enum\\s+${RegExp.escape(candidate)}\\s*\\{',
    ).hasMatch(stylesSource),
    orElse: () => '',
  );
  // `orientation`, `activationMode`, and `alignment` name Flutter and Naked
  // types the recipes take directly, so they have no Fortal enum to anchor on
  // and no recipe-authored default to compare. `size` and `variant` are
  // contractually required to resolve, and [_familyEnumKeys] already fails
  // when they do not, so staying quiet here cannot hide a missing mapping.
  if (enumName.isEmpty) return;

  final actual = _recipeEnumDefault(stylesSource, enumName, kind);
  if (!actual.resolved) {
    failures.add(
      '$id.enums.$kind.default records ${_defaultLabel(manifestDefault)} but '
      'the recipe declares no $enumName $kind parameter.',
    );
    return;
  }
  if (actual.value != manifestDefault) {
    failures.add(
      '$id.enums.$kind.default is ${_defaultLabel(manifestDefault)} but the '
      'recipe defaults $kind to ${_defaultLabel(actual.value)}.',
    );
  }
}

/// The default a caller gets for [parameter] where the recipe types it as
/// [enumName].
///
/// `resolved: false` means no such parameter exists. `(resolved: true, value:
/// null)` is the nullable no-default shape the typography families use so an
/// omitted size resolves from tokens rather than a pinned enum value, which is
/// exactly what a `null` default in the manifest records.
///
/// Anchoring on [enumName] rather than [parameter] alone keeps TextField and
/// TextArea apart: they share `textfield.dart`, so a bare `size` search would
/// read whichever signature happened to come first.
({bool resolved, String? value}) _recipeEnumDefault(
  String source,
  String enumName,
  String parameter,
) {
  // Doc comments cite defaults in prose (`defaults to [FortalDialogSize.size3]`),
  // so strip comments before matching rather than risk reading documentation as
  // the declaration.
  final code = source
      .replaceAll(RegExp(r'//[^\n]*'), '')
      .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
  final escaped = RegExp.escape(enumName);
  final withDefault = RegExp(
    '\\b$escaped\\s+$parameter\\s*=\\s*(?:$escaped)?\\.([A-Za-z0-9_]+)',
  ).firstMatch(code);
  if (withDefault != null) return (resolved: true, value: withDefault.group(1));
  if (RegExp('\\b$escaped\\?\\s+$parameter\\s*[,)]').hasMatch(code)) {
    return (resolved: true, value: null);
  }
  return (resolved: false, value: null);
}

String _defaultLabel(Object? value) =>
    value == null ? 'no default (nullable)' : "'$value'";

Set<String> _dartEnumValues(String body) {
  return body
      .replaceAll(RegExp(r'//[^\n]*'), '')
      .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .map((value) => RegExp(r'^[A-Za-z0-9_]+').stringMatch(value))
      .nonNulls
      .toSet();
}

void _checkVariantConstructors(Directory packageRoot, List<String> failures) {
  final recipeRoot = Directory('${packageRoot.path}/lib/src/components');
  for (final entity in recipeRoot.listSync()) {
    if (entity is! File ||
        !entity.path.endsWith('.dart') ||
        entity.path.endsWith('.g.dart')) {
      continue;
    }
    // Components are flat, so pair each one with its same-stem `.g.dart` rather
    // than concatenating every generated file in the directory.
    final generated = File(
      entity.path.replaceFirst(RegExp(r'\.dart$'), '.g.dart'),
    );
    final generatedSource = generated.existsSync()
        ? generated.readAsStringSync()
        : '';
    final source = '${entity.readAsStringSync()}\n$generatedSource';

    for (final enumMatch in RegExp(
      r'enum\s+(Fortal[A-Za-z0-9_]+Variant)\s*\{([^}]*)\}',
      dotAll: true,
    ).allMatches(source)) {
      final enumName = enumMatch.group(1)!;
      final className = enumName.substring(
        0,
        enumName.length - 'Variant'.length,
      );
      if (!RegExp(
        'class\\s+${RegExp.escape(className)}(?:<|\\s)',
      ).hasMatch(source)) {
        continue;
      }

      final variants = _dartEnumValues(enumMatch.group(2)!);
      final constructors = RegExp(
        'const\\s+${RegExp.escape(className)}\\.([A-Za-z0-9_]+)\\s*\\(',
      ).allMatches(source).map((match) => match.group(1)!).toSet();
      final relatedVariants =
          RegExp(
            'enum\\s+${RegExp.escape(className)}[A-Za-z0-9_]*Variant\\s*\\{([^}]*)\\}',
            dotAll: true,
          ).allMatches(source).expand((match) {
            return _dartEnumValues(match.group(1)!);
          }).toSet();

      final missing = variants.difference(constructors);
      final unexpected = constructors.difference(relatedVariants);
      if (missing.isNotEmpty) {
        failures.add(
          '${entity.path} is missing $className variant constructors: $missing.',
        );
      }
      if (unexpected.isNotEmpty) {
        failures.add(
          '${entity.path} has non-variant $className constructors: $unexpected.',
        );
      }
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
    '30 mapped families, 4 Fortal extensions, 1 audited unmapped family, '
    'Chromium fixtures, '
    'coverage ledger, hosted Naked $_expectedNakedUiVersion resolution, and no '
    'undocumented approximations.',
  );
  exit(0);
}
