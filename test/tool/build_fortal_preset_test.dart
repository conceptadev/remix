import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../../tool/build_fortal_preset.dart';

void main() {
  late Directory sandbox;

  setUp(() {
    sandbox = Directory.systemTemp.createTempSync('fortal_preset_test_');
  });

  tearDown(() {
    if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
  });

  test('every authored template round-trips and removes Fortal names', () {
    final output = FortalPresetBuilder.forRepository(
      Directory.current,
    ).derive();

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
    final output = FortalPresetBuilder.forRepository(
      Directory.current,
    ).derive();
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
    ]);
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
    for (final package in ['remix_fortal', 'mix', 'naked_ui']) {
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

FortalPresetBuilder _emptyBuilder(Directory root) => FortalPresetBuilder(
  sourceRoot: Directory(p.join(root.path, 'source')),
  defaultRegistryRoot: Directory(p.join(root.path, 'default')),
  outputRoot: Directory(p.join(root.path, 'output')),
);

FortalPresetBuilder _fixtureBuilder(Directory root) {
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
