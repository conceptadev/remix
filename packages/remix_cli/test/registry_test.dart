import 'package:path/path.dart' as p;
import 'package:remix_cli/src/registry.dart';
import 'package:remix_cli/src/template_renderer.dart';
import 'package:test/test.dart';

void main() {
  test(
    'bundled registry resolves theme before button and loads assets',
    () async {
      final catalog = await RegistryCatalog.loadBundled();

      expect(catalog.resolve('button').map((item) => item.name), [
        'theme',
        'button',
      ]);
      final button = catalog.items['button']!;
      final source = await catalog.readTemplate(button.files.single);
      expect(source, contains("name: '{{typePrefix}}Button'"));
    },
  );

  test(
    'dependency resolution de-duplicates in stable dependency-first order',
    () {
      final catalog = parse('''schema: 1
items:
  foundation:
    files:
      - source: templates/foundation.dart.tmpl
        target: "@ui/foundation.dart"
  theme:
    registryDependencies: [foundation]
    files:
      - source: templates/theme.dart.tmpl
        target: "@ui/theme.dart"
  button:
    registryDependencies: [foundation, theme]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''');

      expect(catalog.resolve('button').map((item) => item.name), [
        'foundation',
        'theme',
        'button',
      ]);
    },
  );

  test('rejects schema, key, path, and constraint failures', () {
    final invalid = <String>[
      'schema: 2\nitems: {}\n',
      'schema: 1\nitems: {}\nextra: true\n',
      '''schema: 1
items:
  button:
    unknown: true
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''',
      '''schema: 1
items:
  button:
    files:
      - source: ../button.dart.tmpl
        target: "@ui/button.dart"
''',
      '''schema: 1
items:
  button:
    files:
      - source: templates/button.dart.tmpl
        target: "../button.dart"
''',
      '''schema: 1
items:
  button:
    dependencies:
      remix: not a constraint!
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''',
      '''schema: 1
items:
  button:
    generated: ["/button.g.dart"]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''',
      '''schema: 1
items:
  button:
    exports: ["../button.dart"]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''',
    ];

    for (final source in invalid) {
      expect(() => parse(source), throwsFormatException, reason: source);
    }
  });

  test(
    'rejects duplicate dependencies, missing items, cycles, and collisions',
    () {
      final invalid = <String>[
        '''schema: 1
items:
  button:
    registryDependencies: [theme, theme]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
  theme:
    files:
      - source: templates/theme.dart.tmpl
        target: "@ui/theme.dart"
''',
        '''schema: 1
items:
  button:
    registryDependencies: [theme]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
''',
        '''schema: 1
items:
  button:
    registryDependencies: [theme]
    files:
      - source: templates/button.dart.tmpl
        target: "@ui/button.dart"
  theme:
    registryDependencies: [button]
    files:
      - source: templates/theme.dart.tmpl
        target: "@ui/theme.dart"
''',
        '''schema: 1
items:
  first:
    files:
      - source: templates/first.dart.tmpl
        target: "@ui/same.dart"
  second:
    files:
      - source: templates/second.dart.tmpl
        target: "@ui/same.dart"
''',
        '''schema: 1
items:
  first:
    files:
      - source: templates/first.dart.tmpl
        target: "@ui/same.dart"
  second:
    generated: ["@ui/same.dart"]
    files:
      - source: templates/second.dart.tmpl
        target: "@ui/second.dart"
''',
      ];

      for (final source in invalid) {
        expect(() => parse(source), throwsFormatException, reason: source);
      }
    },
  );

  test('Acme rendering covers the configured public surface', () async {
    final catalog = await RegistryCatalog.loadBundled();
    final source = await catalog.readTemplate(
      catalog.items['button']!.files.single,
    );
    final rendered = const TemplateRenderer().render(
      source,
      typePrefix: 'Acme',
      valuePrefix: 'acme',
    );

    expect(rendered, contains('AcmeButton'));
    expect(rendered, contains('AcmeButtonVariant'));
    expect(rendered, contains('AcmeButtonSize'));
    expect(rendered, contains('acmeButtonStyle'));
    expect(rendered, isNot(contains('UiButton')));
    expect(rendered, isNot(contains('{{')));
  });

  test('bundled templates stay inside the allowed import boundary', () async {
    final catalog = await RegistryCatalog.loadBundled();
    const allowedPackages = {'flutter', 'remix', 'mix_annotations'};
    final directive = RegExp(r'''(?:import|export|part)\s+['"]([^'"]+)['"]''');

    for (final item in catalog.items.values) {
      for (final file in item.files) {
        final source = await catalog.readTemplate(file);
        for (final match in directive.allMatches(source)) {
          final uri = match.group(1)!;
          if (uri.startsWith('package:')) {
            expect(
              allowedPackages,
              contains(uri.substring(8).split('/').first),
              reason: '${file.source}: $uri',
            );
          } else if (!uri.startsWith('dart:')) {
            expect(uri, isNot(startsWith('/')), reason: file.source);
            final resolved = p.posix.normalize(
              p.posix.join(p.posix.dirname(file.target.substring(4)), uri),
            );
            expect(resolved, isNot(startsWith('../')), reason: file.source);
          }
        }
      }
    }
  });
}

RegistryCatalog parse(String source) => RegistryCatalog.parse(
  source,
  rootUri: Uri.parse('package:remix_cli/src/registry/'),
  loader: const _NoopLoader(),
);

final class _NoopLoader implements RegistryAssetLoader {
  const _NoopLoader();

  @override
  Future<String> read(Uri uri) => throw StateError('Unexpected read of $uri');
}
