import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _expectedCoreFamilies = <String>{
  'accordion',
  'ai_label',
  'breadcrumb',
  'button',
  'checkbox',
  'code_snippet',
  'contained_list',
  'content_switcher',
  'data_table',
  'date_picker',
  'dropdown',
  'file_uploader',
  'form',
  'inline_loading',
  'link',
  'list',
  'loading',
  'menu',
  'menu_button',
  'modal',
  'multiselect',
  'notification',
  'number_input',
  'pagination',
  'popover',
  'progress_bar',
  'progress_indicator',
  'radio_button',
  'search',
  'select',
  'slider',
  'structured_list',
  'tabs',
  'tag',
  'text_input',
  'tile',
  'toggle',
  'toggletip',
  'tooltip',
  'tree_view',
  'ui_shell',
};

const _expectedExtensions = <String>{'bar_chart', 'line_chart', 'pie_chart'};

const _expectedExcludedRemixFamilies = <String>{
  'avatar',
  'badge',
  'card',
  'data_list',
  'divider',
  'skeleton',
  'toggle_button',
  'toggle_group',
};

void main() {
  test('pins the complete Carbon 1.114.0 implementation inventory', () {
    final file = File('reference/carbon_1_114_0/manifest.json');

    expect(
      file.existsSync(),
      isTrue,
      reason: 'The Carbon parity manifest is the implementation contract.',
    );

    final manifest =
        jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
    final source = manifest['source']! as Map<String, Object?>;
    final coreFamilies = _ids(manifest['coreFamilies']);
    final extensions = _ids(manifest['extensions']);
    final excluded = _ids(manifest['excludedRemixFamilies']);

    expect(source['reactPackage'], '@carbon/react');
    expect(source['reactVersion'], '1.114.0');
    expect(source['stylesPackage'], '@carbon/styles');
    expect(source['stylesVersion'], '1.113.0');
    expect(source['gitCommit'], '188d23202ec1092322dee92cf0df9d9958224ae4');
    expect(coreFamilies, _expectedCoreFamilies);
    expect(extensions, _expectedExtensions);
    expect(excluded, _expectedExcludedRemixFamilies);
  });

  test('keeps the component matrix synchronized with the manifest', () {
    final manifest =
        jsonDecode(
              File('reference/carbon_1_114_0/manifest.json').readAsStringSync(),
            )
            as Map<String, Object?>;
    final matrix = File(
      'reference/carbon_1_114_0/component_matrix.md',
    ).readAsStringSync();
    final families = [
      ...manifest['coreFamilies']! as List<Object?>,
      ...manifest['extensions']! as List<Object?>,
    ].cast<Map<String, Object?>>();
    final mappedRows = matrix
        .split('\n')
        .where(
          (line) => line.startsWith('| `') && '|'.allMatches(line).length == 5,
        );

    expect(
      mappedRows,
      hasLength(families.length),
      reason: 'The matrix must not contain missing or extra family rows.',
    );

    for (final family in families) {
      final id = family['id']! as String;
      final publicApi = (family['publicApi']! as List<Object?>).cast<String>();
      final strategy = family['strategy']! as String;
      final remixBase = (family['remixBase']! as List<Object?>).cast<String>();
      final implementation = switch ((strategy, remixBase)) {
        ('mix_chart_recipe', _) => '`mix_chart`',
        (_, []) => 'Carbon-native',
        _ => remixBase.map((name) => '`$name`').join(', '),
      };
      final expectedRow =
          '| `$id` | ${publicApi.map((name) => '`$name`').join(', ')} '
          '| `$strategy` | $implementation |';

      expect(matrix, contains(expectedRow), reason: '$id matrix row drifted.');
    }
  });

  test('pins token packages from the same Carbon release baseline', () {
    final upstreamPackage =
        jsonDecode(File('tool/upstream/package.json').readAsStringSync())
            as Map<String, Object?>;
    final dependencies =
        upstreamPackage['dependencies']! as Map<String, Object?>;

    expect(dependencies, {
      '@carbon/colors': '11.56.0',
      '@carbon/layout': '11.57.0',
      '@carbon/motion': '11.50.0',
      '@carbon/themes': '11.79.0',
      '@carbon/type': '11.65.0',
    });
  });
}

Set<String> _ids(Object? value) => {
  for (final item in value! as List<Object?>)
    (item! as Map<String, Object?>)['id']! as String,
};
