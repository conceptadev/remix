import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../../tool/build_registry.dart';

void main() {
  test(
    'Fortal merges Agent behavior and recipes without changing base output',
    () {
      final root = Directory.current.absolute;
      final baseBuilder = PresetBuilder.forRepository(root);
      final agentBuilder = PresetBuilder.forRepository(
        root,
        spec: fortalAgentExtension,
      );
      final base = baseBuilder.derive();
      final merged = mergePresetOutputs(base, agentBuilder.derive());

      for (final entry in base.files.entries) {
        if (entry.key == 'registry.yaml') continue;
        expect(merged.files[entry.key], entry.value, reason: entry.key);
      }
      final registry = merged.files['registry.yaml']!;
      expect(registry, contains('  composer_recipe:'));
      expect(registry, contains('  transcript_recipe:'));
      expect(
        merged.files,
        contains('templates/agent/composer/composer.dart.tmpl'),
      );
      expect(
        merged.files,
        contains('templates/recipes/composer_recipe.dart.tmpl'),
      );
      expect(
        merged.files.keys.where((path) => path.startsWith('templates/agent/')),
        isNot(anyElement(contains('/recipes/'))),
      );
    },
  );

  test(
    'recipes derive against installed behavior, not the authoring import',
    () {
      for (final spec in [defaultPreset, fortalPreset]) {
        final output = PresetBuilder.forRepository(
          Directory.current.absolute,
          spec: spec,
        ).derive();
        final items =
            loadYaml(output.files['registry.yaml']!)['items'] as YamlMap;
        for (final name in agentRecipes) {
          final template = output.files['templates/recipes/$name.dart.tmpl']!;
          expect(
            template,
            isNot(contains('package:remix_agent')),
            reason: name,
          );
          expect(
            RegExp(r'(?<![A-Za-z0-9_}])Agent[A-Z]').hasMatch(template),
            isFalse,
            reason: '$name still names a behavior type by its authoring word',
          );
          // The domain name survives: the recipe is the Agent composer recipe.
          expect(template, contains('{{typePrefix}}Agent'), reason: name);
          final dependencies = _strings(
            (items[name] as YamlMap)['registryDependencies'],
          );
          expect(dependencies, contains(name.replaceAll('_recipe', '')));
          expect(dependencies, isNot(contains('models')));
        }
      }
    },
  );

  test('preset output merge rejects file collisions', () {
    const left = PresetOutput(
      files: {'registry.yaml': 'schema: 1\nitems:\n', 'templates/a': 'a'},
      sourceByTemplate: {},
    );
    const right = PresetOutput(
      files: {'registry.yaml': 'schema: 1\nitems:\n', 'templates/a': 'b'},
      sourceByTemplate: {},
    );
    expect(() => mergePresetOutputs(left, right), throwsStateError);
  });

  test('preset merge rejects item and target collisions before writing', () {
    PresetOutput fixture(
      String name,
      String target,
      String source,
    ) => PresetOutput(
      files: {
        'registry.yaml':
            'schema: 1\nitems:\n  $name:\n    files:\n      - source: $source\n        target: "$target"\n',
        source: 'fixture',
      },
      sourceByTemplate: const {},
    );
    final base = fixture('one', '@ui/one.dart', 'templates/one');
    expect(
      () => mergePresetOutputs(
        base,
        fixture('one', '@ui/two.dart', 'templates/two'),
      ),
      throwsStateError,
    );
    expect(
      () => mergePresetOutputs(
        base,
        fixture('two', '@ui/one.dart', 'templates/two'),
      ),
      throwsStateError,
    );
  });

  late Directory sandbox;

  setUp(() {
    sandbox = Directory.systemTemp.createTempSync('fortal_preset_test_');
  });

  tearDown(() {
    if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
  });

  test('every authored template round-trips and removes Fortal names', () {
    final output = PresetBuilder.forRepository(Directory.current).derive();

    expect(output.sourceByTemplate, isNotEmpty);
    for (final entry in output.sourceByTemplate.entries) {
      final template = output.files[entry.key]!;
      final rendered = template
          .replaceAll('{{typePrefix}}', 'Fortal')
          .replaceAll('{{valuePrefix}}', 'fortal');

      expect(rendered, entry.value, reason: entry.key);
      expect(template, isNot(contains('Fortal')), reason: entry.key);
      expect(template, isNot(contains('fortal')), reason: entry.key);
    }
  });

  test('registry dependencies and package floors are inferred', () {
    final output = PresetBuilder.forRepository(Directory.current).derive();
    final document = loadYaml(output.files['registry.yaml']!) as YamlMap;
    final items = document['items'] as YamlMap;

    expect(_strings((items['button'] as YamlMap)['registryDependencies']), [
      'theme',
      'base_button',
    ]);
    expect(_strings((items['data_table'] as YamlMap)['registryDependencies']), [
      'theme',
      'checkbox',
      'icon_button',
      'select',
    ]);
    expect(_strings((items['sidebar'] as YamlMap)['registryDependencies']), [
      'theme',
      'text',
      'toggle',
      'tooltip',
    ]);
    // sidebar_layout's `sidebar` field is typed `Widget`, not
    // `FortalSidebar`, so its source never imports components/sidebar.dart
    // and import inference alone would miss this dependency. It comes from
    // the spec's composedRegistryDependencies instead, mirroring the same
    // manual dependency the default preset's registry.yaml declares.
    expect(
      _strings((items['sidebar_layout'] as YamlMap)['registryDependencies']),
      ['theme', 'sidebar'],
    );
    expect(
      (items['base_button'] as YamlMap).containsKey('dependencies'),
      isFalse,
    );
    expect(
      (items['typography'] as YamlMap).containsKey('devDependencies'),
      isFalse,
    );
    expect(
      ((items['chart'] as YamlMap)['dependencies'] as YamlMap).keys,
      containsAll(['mix_annotations', 'mix_chart']),
    );
    expect(_strings((items['button'] as YamlMap)['generated']), [
      '@ui/components/button.g.dart',
    ]);
  });

  test('refuses Fortal path segments before reading registry metadata', () {
    final builder = _emptyBuilder(sandbox);
    _write(
      builder.sourceRoot,
      'components/fortal_button.dart',
      'void recipe() {}\n',
    );

    expect(
      builder.derive,
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          allOf(contains('components/fortal_button.dart'), contains('segment')),
        ),
      ),
    );
  });

  test('refuses reserved template tokens before substitution', () {
    final builder = _emptyBuilder(sandbox);
    _write(
      builder.sourceRoot,
      'components/button.dart',
      '// {{reserved}}\nvoid recipe() {}\n',
    );

    expect(
      builder.derive,
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          allOf(contains('components/button.dart'), contains('"{{"')),
        ),
      ),
    );
  });

  test('refuses every package import outside the installed boundary', () {
    for (final package in ['registry_source', 'mix', 'naked_ui']) {
      final root = Directory(p.join(sandbox.path, package));
      final builder = _emptyBuilder(root);
      _write(
        builder.sourceRoot,
        'components/button.dart',
        "import 'package:$package/example.dart';\n",
      );

      expect(
        builder.derive,
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            allOf(
              contains('components/button.dart'),
              contains('package:$package/'),
            ),
          ),
        ),
        reason: package,
      );
    }
  });

  test('a second spec derives without any Fortal naming', () {
    // Without this, "generalized" is unverified: every other test here runs
    // the one spec whose values the builder used to hardcode.
    final builder = _emptyBuilder(sandbox, spec: _acmePreset);
    _write(builder.sourceRoot, 'core/core.dart', "export 'tokens.dart';\n");
    _write(
      builder.sourceRoot,
      'core/tokens.dart',
      "import 'package:remix/remix.dart';\nabstract class AcmeTokens {}\n",
    );
    _write(
      builder.sourceRoot,
      'widgets/dial.dart',
      """import 'package:remix/remix.dart';

import '../core/core.dart';

void acmeDialStyle() {}
""",
    );
    _writeDefaultRegistry(builder.defaultRegistryRoot);

    final output = builder.derive();
    final items =
        (loadYaml(output.files['registry.yaml']!) as YamlMap)['items']
            as YamlMap;

    // The spec's directories, not Fortal's, decide layout and item names.
    expect(items.keys, ['core', 'dial']);
    expect(_strings((items['dial'] as YamlMap)['registryDependencies']), [
      'core',
    ]);
    expect(_strings((items['dial'] as YamlMap)['exports']), [
      'widgets/dial.dart',
    ]);
    // One directory per component, as Fortal's `templates/button/` is.
    expect(
      output.files['templates/dial/dial.dart.tmpl'],
      contains('void {{valuePrefix}}DialStyle()'),
    );
    expect(
      output.files['templates/core/tokens.dart.tmpl'],
      contains('abstract class {{typePrefix}}Tokens'),
    );
    // `Fortal` is not a reserved word to this builder any more; `Acme` is.
    expect(
      output.files['templates/core/tokens.dart.tmpl'],
      isNot(contains('Acme')),
    );
  });

  test('a second spec forbids importing its own source package', () {
    final builder = _emptyBuilder(sandbox, spec: _acmePreset);
    _write(
      builder.sourceRoot,
      'widgets/dial.dart',
      "import 'package:remix_acme/remix_acme.dart';\n",
    );

    expect(
      builder.derive,
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('package:remix_acme/'),
        ),
      ),
    );
  });

  test('a recipe rewrites the behavior import and word, then sorts', () {
    final builder = _emptyBuilder(sandbox, spec: _acmeWithRecipes);
    _writeAcmeSources(builder);
    _write(
      builder.sourceRoot,
      'recipes/dial_recipe.dart',
      """import 'package:remix/remix.dart';
import '../../bot/components/dial.dart';

import '../core/core.dart';
import '../widgets/dial.dart';

final class AcmeBotDialRecipe {
  const AcmeBotDialRecipe(this.style);
  final BotDialStyler style;
}

AcmeBotDialRecipe acmeBotDialRecipe() =>
    AcmeBotDialRecipe(BotDialStyler().merge(acmeDialStyle()));
""",
    );
    final output = builder.derive();
    final template = output.files['templates/recipes/dial_recipe.dart.tmpl']!;
    expect(template, """import 'package:remix/remix.dart';

import '../components/dial.dart';
import '../core/core.dart';
import '../widgets/dial.dart';

final class {{typePrefix}}BotDialRecipe {
  const {{typePrefix}}BotDialRecipe(this.style);
  final {{typePrefix}}DialStyler style;
}

{{typePrefix}}BotDialRecipe {{valuePrefix}}BotDialRecipe() =>
    {{typePrefix}}BotDialRecipe({{typePrefix}}DialStyler().merge({{valuePrefix}}DialStyle()));
""");
    final items = loadYaml(output.files['registry.yaml']!)['items'] as YamlMap;
    expect(
      _strings((items['dial_recipe'] as YamlMap)['registryDependencies']),
      ['core', 'dial'],
    );
    expect(
      (items['dial_recipe'] as YamlMap)['files'].first['target'],
      '@ui/recipes/dial_recipe.dart',
    );
  });

  test(
    'behavior imports are refused outside recipes and beyond components',
    () {
      final builder = _emptyBuilder(sandbox, spec: _acmeWithRecipes);
      _writeAcmeSources(builder);
      _write(
        builder.sourceRoot,
        'widgets/gauge.dart',
        "import '../../bot/components/dial.dart';\n",
      );
      _write(
        builder.sourceRoot,
        'recipes/dial_recipe.dart',
        "import '../../bot/support/glyph.dart';\n",
      );
      expect(
        builder.derive,
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            allOf(
              contains('widgets/gauge.dart: only recipes may import'),
              contains(
                'recipes/dial_recipe.dart: recipes import behavior '
                'components only',
              ),
            ),
          ),
        ),
      );
    },
  );

  test('recipes and declared recipe items must agree', () {
    final builder = _emptyBuilder(sandbox, spec: _acmeWithRecipes);
    _writeAcmeSources(builder);
    expect(
      builder.derive,
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('recipes/dial_recipe.dart'),
        ),
      ),
    );
    _write(builder.sourceRoot, 'recipes/dial_recipe.dart', '');
    _write(builder.sourceRoot, 'recipes/extra_recipe.dart', '');
    expect(
      builder.derive,
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('extra_recipe.dart is not a declared acme recipe'),
        ),
      ),
    );
  });

  test('a recipe importing something the preset never installs is refused', () {
    final builder = _emptyBuilder(sandbox, spec: _acmeWithRecipes);
    _writeAcmeSources(builder);
    _write(
      builder.sourceRoot,
      'recipes/dial_recipe.dart',
      "import '../../bot/components/dial.dart';\n",
    );
    // Derivation defers the behavior component to the merge; validation of
    // the un-merged preset is where it surfaces.
    final output = builder.derive();
    expect(
      () => builder.validate(output),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('dial_recipe imports ../components/dial.dart'),
        ),
      ),
    );
  });

  test('check mode reports planted changed and stale output', () {
    final builder = _fixtureBuilder(sandbox);
    final output = builder.derive();
    builder.write(output);
    expect(builder.drift(output), isEmpty);

    File(
      p.join(
        builder.outputRoot.path,
        'templates',
        'button',
        'button.dart.tmpl',
      ),
    ).writeAsStringSync('// planted drift\n');
    _write(builder.outputRoot, 'templates/stale.dart.tmpl', '// stale\n');

    expect(builder.drift(output), [
      'changed templates/button/button.dart.tmpl',
      'stale templates/stale.dart.tmpl',
    ]);
  });
}

/// A deliberately un-Fortal spec: different word, directories, and package.
const _acmePreset = PresetSpec(
  name: 'acme',
  sourceRoot: 'registry_source/acme',
  sourcePackage: 'remix_acme',
  typeWord: 'Acme',
  valueWord: 'acme',
  componentDirectory: 'widgets',
  sharedItems: [
    SharedItemSpec(
      name: 'core',
      directory: 'core',
      requiredFile: 'core/core.dart',
      packages: {'remix'},
      exports: ['core/core.dart'],
    ),
  ],
  copiedItems: [],
  ignoredSourceFiles: {},
  floorPackages: {'remix'},
  detectedPackages: [],
  composedRegistryDependencies: {},
);

/// [_acmePreset] styling a `remix_bot` behavior through one recipe.
const _acmeWithRecipes = PresetSpec(
  name: 'acme',
  sourceRoot: 'registry_source/acme',
  sourcePackage: 'remix_acme',
  typeWord: 'Acme',
  valueWord: 'acme',
  componentDirectory: 'widgets',
  sharedItems: [
    SharedItemSpec(
      name: 'core',
      directory: 'core',
      requiredFile: 'core/core.dart',
      packages: {'remix'},
      exports: ['core/core.dart'],
    ),
  ],
  copiedItems: [],
  ignoredSourceFiles: {},
  floorPackages: {'remix'},
  detectedPackages: [],
  composedRegistryDependencies: {},
  recipeItems: ['dial_recipe'],
  behavior: BehaviorSpec(
    directory: 'bot',
    typeWord: 'Bot',
    valueWord: 'bot',
    componentDirectory: 'components',
  ),
);

void _writeAcmeSources(PresetBuilder builder) {
  // The behavior the recipe styles, a sibling of the preset source.
  _write(
    Directory(p.join(builder.sourceRoot.parent.path, 'bot')),
    'components/dial.dart',
    'class BotDialStyler {}\n',
  );
  _write(
    Directory(p.join(builder.sourceRoot.parent.path, 'bot')),
    'support/glyph.dart',
    '',
  );
  _write(builder.sourceRoot, 'core/core.dart', "export 'tokens.dart';\n");
  _write(
    builder.sourceRoot,
    'core/tokens.dart',
    "import 'package:remix/remix.dart';\nabstract class AcmeTokens {}\n",
  );
  _write(
    builder.sourceRoot,
    'widgets/dial.dart',
    "import 'package:remix/remix.dart';\n\nimport '../core/core.dart';\n\n"
        'void acmeDialStyle() {}\n',
  );
  _writeDefaultRegistry(builder.defaultRegistryRoot);
}

/// [fortalPreset] as the sandbox fixtures author it: theme and components
/// only, no recipes, so every refusal below is about the file under test.
const _fortalFixture = PresetSpec(
  name: 'fortal',
  sourceRoot: 'registry_source/fortal',
  sourcePackage: 'registry_source',
  typeWord: 'Fortal',
  valueWord: 'fortal',
  componentDirectory: 'components',
  sharedItems: [
    SharedItemSpec(
      name: 'theme',
      directory: 'theme',
      requiredFile: 'theme/theme.dart',
      packages: {'remix'},
      exports: ['theme/theme.dart'],
    ),
  ],
  copiedItems: [
    CopiedItemSpec(
      name: 'icons',
      templatePath: 'templates/icons/icons.dart.tmpl',
      target: '@ui/icons.dart',
      registryDependencies: ['theme'],
      packages: {'remix_ui_icons'},
      exports: ['icons.dart'],
    ),
  ],
  ignoredSourceFiles: {'icons.dart'},
  floorPackages: {
    'remix',
    'mix_annotations',
    'build_runner',
    'mix_generator',
    'mix_chart',
    'remix_ui_icons',
  },
  detectedPackages: ['mix_chart', 'remix_ui_icons'],
  composedRegistryDependencies: {},
);

PresetBuilder _emptyBuilder(
  Directory root, {
  PresetSpec spec = _fortalFixture,
}) => PresetBuilder(
  spec: spec,
  sourceRoot: Directory(p.join(root.path, 'source')),
  defaultRegistryRoot: Directory(p.join(root.path, 'default')),
  outputRoot: Directory(p.join(root.path, 'output')),
);

PresetBuilder _fixtureBuilder(Directory root) {
  final builder = _emptyBuilder(root);
  _write(builder.sourceRoot, 'theme/theme.dart', "export 'tokens.dart';\n");
  _write(
    builder.sourceRoot,
    'theme/tokens.dart',
    "import 'package:remix/remix.dart';\nabstract class FortalTokens {}\n",
  );
  _write(
    builder.sourceRoot,
    'components/button.dart',
    """import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'button.g.dart';

void fortalButtonStyle() {}
""",
  );
  _writeDefaultRegistry(builder.defaultRegistryRoot);
  return builder;
}

void _writeDefaultRegistry(Directory root) {
  _write(root, 'registry.yaml', '''schema: 1
items:
  theme:
    dependencies:
      remix: ^1.0.0
    files:
      - source: templates/theme/theme.dart.tmpl
        target: "@ui/theme/theme.dart"
  button:
    dependencies:
      mix_annotations: ^2.0.0
    devDependencies:
      build_runner: ^2.0.0
      mix_generator: ^2.0.0
    files:
      - source: templates/button/button.dart.tmpl
        target: "@ui/components/button.dart"
  chart:
    dependencies:
      mix_chart: ^1.0.0
    files:
      - source: templates/chart/chart.dart.tmpl
        target: "@ui/components/chart.dart"
  icons:
    dependencies:
      remix_ui_icons: ^1.0.0
    files:
      - source: templates/icons/icons.dart.tmpl
        target: "@ui/icons.dart"
''');
  _write(
    root,
    'templates/icons/icons.dart.tmpl',
    'abstract final class {{typePrefix}}Icons {}\n',
  );
}

void _write(Directory root, String relativePath, String source) {
  final file = File(p.joinAll([root.path, ...p.posix.split(relativePath)]));
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(source);
}

List<String> _strings(Object? value) => (value as YamlList).cast<String>();
