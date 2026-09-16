import 'package:remix_cli/src/builder_config.dart';
import 'package:test/test.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

void main() {
  const first = 'lib/ui/components/activity.dart';
  const second = 'lib/ui/components/message.dart';
  test('new config is narrowly scoped and repeated configuration is stable', () {
    final source = _configure('', [first]);
    final builder =
        (loadYaml(source)
            as Map)['targets'][r'$default']['builders'][specStylerBuilder];
    expect(builder['enabled'], isTrue);
    expect(builder['generate_for'], [first]);
    expect(_configure(source, [first]), source);
    final updated = _configure(source, [first, second]);
    expect(
      (loadYaml(updated)
          as Map)['targets'][r'$default']['builders'][specStylerBuilder]['generate_for'],
      [first, second],
    );
    expect(_configure(updated, [first, second]), updated);
  });
  test('preserves comments, unrelated builders, options and custom sources', () {
    const source = '''# Application-owned configuration.
targets:
  \$default:
    sources:
      include: [lib/**]
      exclude: [lib/private/**]
    builders:
      custom:builder:
        options: {keep: true} # untouched
      mix_generator|spec_styler_generator:
        enabled: true
        options: {custom: value}
        generate_for: [lib/custom/**]
''';
    final updated = _configure(source, [first]);
    expect(updated, contains('# Application-owned configuration.'));
    expect(updated, contains('options: {keep: true} # untouched'));
    final builder =
        (loadYaml(updated)
            as Map)['targets'][r'$default']['builders']['mix_generator|spec_styler_generator'];
    expect(builder['options'], {'custom': 'value'});
    expect(builder['generate_for'], ['lib/custom/**', first]);
  });
  test('an options-only builder retains its implicit all-source scope', () {
    const source =
        r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {options: {custom: value}}}}}';
    final updated = _configure(source, [first]);
    final builder =
        (loadYaml(updated)
            as Map)['targets'][r'$default']['builders'][specStylerBuilder];
    expect(builder.containsKey('generate_for'), isFalse);
    expect(builder['options'], {'custom': 'value'});
  });
  for (final settings in [
    '{}',
    '{options: {}}',
    '{generate_for: []}',
    '{generate_for: {include: [], exclude: []}}',
  ]) {
    test('preserves all-source builder settings $settings', () {
      final source =
          'targets: {\$default: {builders: {$specStylerBuilder: $settings}}}';
      final updated = _configure(source, [first]);
      final before =
          (loadYaml(source)
                  as Map)['targets'][r'$default']['builders'][specStylerBuilder]
              as Map;
      final after =
          (loadYaml(updated)
                  as Map)['targets'][r'$default']['builders'][specStylerBuilder]
              as Map;
      expect(after, {...before, 'enabled': true});
      expect(_configure(updated, [first]), updated);
    });
  }
  for (final sources in ['[]', '{include: []}', '{include: [], exclude: []}']) {
    test('accepts all-source target filter $sources', () {
      final updated = _configure('targets: {\$default: {sources: $sources}}', [
        first,
      ]);
      expect(_configure(updated, [first]), updated);
    });
  }
  for (final target in ['consumer', ':consumer', 'consumer:consumer']) {
    test('preserves package-named default target $target', () {
      final updated = _configure('targets: {$target: {sources: [lib/**]}}', [
        first,
      ]);
      expect((loadYaml(updated) as Map)['targets'].keys, [target]);
      expect(_configure(updated, [first]), updated);
      expect(
        () => _configure(
          'targets: {$target: {sources: {exclude: [lib/ui/**]}}}',
          [first],
        ),
        throwsFormatException,
      );
    });
  }
  test('rejects aliases declaring the default target twice', () {
    expect(
      () => _configure(r'targets: {$default: {}, consumer: {}}', [first]),
      throwsFormatException,
    );
  });
  for (final source in [
    '',
    '{}',
    r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {generate_for: [lib/custom/**]}}}}',
    r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {generate_for: {include: [lib/custom/**]}}}}}',
  ]) {
    test(
      'quotes literal paths for new and appended generation filters: $source',
      () {
        const input = 'lib/design system [brand] #1/components/composer.dart';
        final updated = _configure(source, [input]);
        final filter =
            (loadYaml(updated)
                as Map)['targets'][r'$default']['builders'][specStylerBuilder]['generate_for'];
        final patterns = (filter is Map ? filter['include'] : filter) as List;
        expect(
          patterns.any((pattern) => Glob(pattern as String).matches(input)),
          isTrue,
        );
        expect(
          patterns.any(
            (pattern) => Glob(
              pattern as String,
            ).matches('lib/design system b #1/components/composer.dart'),
          ),
          isFalse,
        );
        expect(_configure(updated, [input]), updated);
      },
    );
  }
  test('empty includes do not bypass explicit exclusions', () {
    expect(
      () => _configure(
        r'targets: {$default: {sources: {include: [], exclude: [lib/ui/**]}}}',
        [first],
      ),
      throwsFormatException,
    );
    expect(
      () => _configure(
        r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {generate_for: {include: [], exclude: [lib/ui/**]}}}}}',
        [first],
      ),
      throwsFormatException,
    );
  });
  test('respects existing glob coverage without changing it', () {
    const source = '''targets:
  \$default:
    builders:
      mix_generator:spec_styler_generator:
        enabled: true
        generate_for:
          include: [lib/ui/**]
          exclude: [lib/ui/private/**]
''';
    expect(_configure(source, [first]), source);
  });
  test('explicit opt-outs and split targets fail instead of being overwritten', () {
    for (final source in [
      'targets: {custom: {}}',
      r'targets: {$default: {sources: {exclude: [lib/ui/**]}}}',
      r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {enabled: false}}}}',
      r'targets: {$default: {builders: {mix_generator:spec_styler_generator: {generate_for: {exclude: [lib/ui/**]}}}}}',
      '[]',
    ]) {
      expect(
        () => _configure(source, [first]),
        throwsFormatException,
        reason: source,
      );
    }
  });
}

String _configure(String source, List<String> inputs) =>
    configureSpecStylers(source, inputs, packageName: 'consumer');
