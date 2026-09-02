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
      // The loader returns the raw template, placeholders and all.
      expect(source, contains('@MixWidget(target: RemixButton.new)'));
      expect(source, contains('{{valuePrefix}}ButtonStyle'));
    },
  );

  test(
    'chart is a theme-only extension backed directly by mix_chart',
    () async {
      final catalog = await RegistryCatalog.loadBundled();
      final chart = catalog.items['chart']!;
      final source = await catalog.readTemplate(chart.files.single);

      expect(catalog.resolve('chart').map((item) => item.name), [
        'theme',
        'chart',
      ]);
      expect(chart.dependencies.keys, {'mix_annotations', 'mix_chart'});
      expect('${chart.dependencies['mix_chart']}', '^0.0.1-beta.1');
      expect(source, contains("import 'package:mix_chart/mix_chart.dart';"));
      expect(source, isNot(contains('remix_fortal')));
      expect(
        RegExp(
          r'^@MixWidget\(target: (?:Line|Bar|Pie)Chart\.new\)$',
          multiLine: true,
        ).allMatches(source),
        hasLength(3),
      );
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

  test('every item resolves theme first and owns its expected files', () async {
    final catalog = await RegistryCatalog.loadBundled();

    // Both directions. Checking only that each listed name exists would let a
    // new registry item ship with no surface pinned and no rendering asserted.
    expect(
      catalog.items.keys.where((name) => name != 'theme').toSet(),
      _componentSurfaces.keys.toSet(),
    );

    for (final name in _componentSurfaces.keys) {
      final item = catalog.items[name];
      expect(item, isNotNull, reason: name);
      // Dependency-first order, and `theme` always leads because every
      // component declares it. `data_table` is the one item that needs more:
      // its selection column, pager, and page-size control are the
      // application's own checkbox, icon button, and select.
      expect(
        catalog.resolve(name).map((item) => item.name),
        name == 'data_table'
            ? ['theme', 'checkbox', 'icon_button', 'select', name]
            : ['theme', name],
        reason: name,
      );
      if (name == 'icons') {
        expect(item!.files.single.target, '@ui/icons.dart');
        expect(item.generated, isEmpty);
        expect(item.exports, ['icons.dart']);
      } else {
        expect(item!.files.single.target, '@ui/components/$name.dart');
        expect(item.generated, ['@ui/components/$name.g.dart']);
        expect(item.exports, ['components/$name.dart']);
      }
    }
  });

  test('both prefixes render every configured public surface', () async {
    final catalog = await RegistryCatalog.loadBundled();

    for (final entry in _componentSurfaces.entries) {
      final source = await catalog.readTemplate(
        catalog.items[entry.key]!.files.single,
      );

      for (final prefix in const [
        (type: 'Acme', value: 'acme'),
        (type: 'Ui', value: 'ui'),
      ]) {
        final rendered = const TemplateRenderer().render(
          source,
          typePrefix: prefix.type,
          valuePrefix: prefix.value,
        );
        final reason = '${entry.key}/${prefix.type}';

        for (final widget in entry.value.widgets) {
          // The recipe is what the generator reads the widget name from, so
          // this is the widget's name too. Matched as a declaration rather
          // than a bare substring, because the templates mention their own
          // identifiers in prose and a doc comment must not satisfy this.
          expect(
            rendered,
            contains(
              RegExp('^\\w+ ${prefix.value}${widget}Style\\(', multiLine: true),
            ),
            reason: '$reason: ${prefix.type}$widget',
          );
        }
        for (final type in entry.value.types) {
          expect(
            rendered,
            contains(RegExp('^enum ${prefix.type}$type ', multiLine: true)),
            reason: '$reason: $type',
          );
        }
        if (entry.key == 'icons') {
          expect(
            rendered,
            contains('abstract final class ${prefix.type}Icons'),
            reason: reason,
          );
        }
        expect(rendered, isNot(contains('{{')), reason: reason);
        expect(rendered, isNot(contains('}}')), reason: reason);
      }
    }
  });

  test('bundled templates stay inside the allowed import boundary', () async {
    final catalog = await RegistryCatalog.loadBundled();
    const allowedPackages = {
      'flutter',
      'remix',
      'mix_annotations',
      'mix_chart',
      'remix_ui_icons',
    };
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

/// The public surface each component template must publish.
///
/// `widgets` are the adapters `@MixWidget` generates. Their names are not
/// written anywhere: the generator drops a trailing `Style` from the recipe
/// function's own name and capitalises what is left, so `uiTabBarStyle`
/// produces `UiTabBar`. Pinning the recipe name therefore pins the widget
/// name, and the test below asserts exactly that derivation rather than
/// searching for a string that no longer appears in the template.
///
/// `types` are the enums and other names written with the type prefix.
///
/// Renaming or dropping any of these breaks a consumer's source, so they are
/// pinned here rather than left to the fixture, which only ever sees the
/// `Acme` rendering.
const _componentSurfaces =
    <String, ({List<String> widgets, List<String> types})>{
      'icons': (widgets: [], types: []),
      'accordion': (widgets: ['Accordion'], types: []),
      'avatar': (widgets: ['Avatar'], types: []),
      'badge': (widgets: ['Badge'], types: ['BadgeVariant']),
      'button': (widgets: ['Button'], types: ['ButtonVariant', 'ButtonSize']),
      'callout': (widgets: ['Callout'], types: ['CalloutVariant']),
      'card': (widgets: ['Card'], types: []),
      'chart': (widgets: ['LineChart', 'BarChart', 'PieChart'], types: []),
      'checkbox': (widgets: ['Checkbox', 'CheckboxGroupItem'], types: []),
      'data_list': (widgets: ['DataList'], types: []),
      'data_table': (widgets: ['DataTable'], types: []),
      'dialog': (widgets: ['Dialog'], types: []),
      'disclosure': (widgets: ['Disclosure'], types: []),
      'divider': (widgets: ['Divider'], types: []),
      'icon_button': (
        widgets: ['IconButton'],
        types: ['IconButtonVariant', 'IconButtonSize'],
      ),
      'link': (widgets: ['Link'], types: []),
      'menu': (widgets: ['Menu'], types: []),
      'popover': (widgets: ['Popover'], types: []),
      'progress': (widgets: ['Progress'], types: []),
      'radio': (widgets: ['Radio'], types: []),
      'segmented_control': (widgets: ['SegmentedControl'], types: []),
      'select': (widgets: ['Select'], types: []),
      'skeleton': (widgets: ['Skeleton'], types: []),
      'slider': (widgets: ['Slider'], types: []),
      'spinner': (widgets: ['Spinner'], types: []),
      'switch': (widgets: ['Switch'], types: []),
      'tabs': (widgets: ['TabBar', 'Tab', 'TabView'], types: []),
      'textfield': (widgets: ['TextField', 'TextArea'], types: []),
      'toggle': (widgets: ['Toggle'], types: ['ToggleVariant', 'ToggleSize']),
      'tooltip': (widgets: ['Tooltip'], types: []),
      'toggle_group': (
        widgets: ['ToggleGroup'],
        types: ['ToggleGroupVariant', 'ToggleGroupSize'],
      ),
    };

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
