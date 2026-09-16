import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../../packages/remix_cli/lib/src/registry.dart';
import '../../tool/build_registry.dart';

/// The Agent extension: `registry_source/lib/src/agent` deriving into a preset's
/// `templates/agent/` subtree. It never writes; the preset's own spec merges
/// and owns the result, which is what `build_registry_test.dart` covers.
void main() {
  late Directory sandbox;
  late PresetBuilder builder;

  setUp(() {
    sandbox = Directory.systemTemp.createTempSync('agent_registry_test_');
    final source = Directory('${sandbox.path}/source');
    for (final file in Directory(
      'registry_source/lib/src/agent',
    ).listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart') || file.path.endsWith('.g.dart'))
        continue;
      _write(
        source,
        p.relative(file.path, from: 'registry_source/lib/src/agent'),
        file.readAsStringSync(),
      );
    }
    final registry = Directory('${sandbox.path}/default');
    _write(
      registry,
      'registry.yaml',
      File(
        'packages/remix_cli/lib/src/registry/default/registry.yaml',
      ).readAsStringSync(),
    );
    builder = PresetBuilder(
      spec: defaultAgentExtension,
      sourceRoot: source,
      defaultRegistryRoot: registry,
      outputRoot: registry,
    );
  });

  tearDown(() => sandbox.deleteSync(recursive: true));

  test('components reuse default floors and resolve independently', () {
    final output = builder.derive();
    final items = _items(output.files['registry.yaml']!);
    expect(items.keys, [
      'models',
      'support',
      'activity',
      'answer',
      'composer',
      'execution',
      'message',
      'permission',
      'plan',
      'transcript',
    ]);
    expect(items['support']['registryDependencies'], ['theme']);
    expect(items['support']['dependencies']['remix_ui_icons'], isNotNull);
    expect(items['support']['exports'], isNull);
    expect(items['models']['exports'], contains('models/statuses.dart'));
    expect(
      output.files.keys.where((path) => path != 'registry.yaml'),
      everyElement(startsWith('templates/agent/')),
    );
    expect(output.files.keys, isNot(anyElement(endsWith('.g.dart.tmpl'))));

    // Resolvable against the committed default catalog, with the theme item
    // as the single owner of the Remix floor and no dependency on the
    // authoring package.
    final catalog = RegistryCatalog.parse(
      _merged(builder.outputRoot, output),
      preset: 'default',
      rootUri: builder.outputRoot.uri,
    );
    for (final name in items.keys.where(
      (name) => name != 'models' && name != 'support',
    )) {
      final closure = catalog.resolve(name as String);
      expect(
        closure.map((item) => item.name),
        containsAll(['theme', 'support', name]),
      );
      expect(
        closure.where((item) => item.dependencies.containsKey('remix')),
        hasLength(1),
      );
      expect(
        closure.expand((item) => item.dependencies.keys),
        isNot(contains('remix_agent')),
      );
    }
  });

  test('prefix round trips and domain prose is not silently renamed', () {
    final output = builder.derive();
    for (final entry in output.sourceByTemplate.entries) {
      final template = output.files[entry.key]!;
      expect(
        template
            .replaceAll('{{typePrefix}}', 'Agent')
            .replaceAll('{{valuePrefix}}', 'agent'),
        entry.value,
      );
      final rendered = template
          .replaceAll('{{typePrefix}}', 'Acme')
          .replaceAll('{{valuePrefix}}', 'acme');
      expect(rendered, isNot(contains('package:remix_agent/')));
      expect(rendered, isNot(contains('../style/')));
      // Prefixable identifiers and family names remain legal. A lowercase
      // standalone domain noun in authored line comments does not.
      for (final line in entry.value.split('\n')) {
        if (!line.trimLeft().startsWith('//')) continue;
        final prose = line.replaceAll(RegExp(r'\[[^\]]+\]|`[^`]+`'), '');
        expect(
          RegExp(r'\bagent\b').hasMatch(prose),
          isFalse,
          reason: '${entry.key}: $line',
        );
      }
    }
  });

  test('an extension neither writes nor checks a tree on its own', () {
    final output = builder.derive();
    expect(() => builder.write(output), throwsStateError);
    expect(() => builder.drift(output), throwsStateError);
  });

  test('relative imports between shared directories become dependencies', () {
    final file = File(
      '${builder.sourceRoot.path}/support/functional_glyph.dart',
    );
    file.writeAsStringSync(
      "import '../models/statuses.dart';\n${file.readAsStringSync()}",
    );
    final items = _items(builder.derive().files['registry.yaml']!);
    expect(items['support']['registryDependencies'], ['theme', 'models']);
  });

  test(
    'missing relative sources and prefix-sensitive URIs fail derivation',
    () {
      final file = File('${builder.sourceRoot.path}/models/statuses.dart');
      final original = file.readAsStringSync();
      file.writeAsStringSync("import 'missing.dart';\n$original");
      expect(builder.derive, throwsFormatException);
      file.writeAsStringSync(
        "export 'package:unrelated/agent.dart';\n$original",
      );
      expect(builder.derive, throwsFormatException);
    },
  );

  test('shared dependency cycles are rejected by catalog validation', () {
    final models = File('${builder.sourceRoot.path}/models/statuses.dart');
    final support = File(
      '${builder.sourceRoot.path}/support/functional_glyph.dart',
    );
    models.writeAsStringSync(
      "import '../support/functional_glyph.dart';\n${models.readAsStringSync()}",
    );
    support.writeAsStringSync(
      "import '../models/statuses.dart';\n${support.readAsStringSync()}",
    );
    final output = builder.derive();
    expect(
      () => RegistryCatalog.parse(
        _merged(builder.outputRoot, output),
        preset: 'default',
        rootUri: builder.outputRoot.uri,
      ),
      throwsFormatException,
    );
  });
}

Map _items(String registry) => (loadYaml(registry) as Map)['items'] as Map;

/// The committed default registry with the extension's items merged in, as
/// the preset writer would see it.
String _merged(Directory registryRoot, PresetOutput output) {
  final file = File('${registryRoot.path}/registry.yaml');
  return jsonEncode({
    'schema': 1,
    'items': {
      ..._items(file.readAsStringSync()),
      ..._items(output.files['registry.yaml']!),
    },
  });
}

void _write(Directory root, String relative, String contents) {
  final file = File(p.join(root.path, relative));
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(contents);
}
