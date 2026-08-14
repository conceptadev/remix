import 'dart:convert';
import 'dart:io';

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  test('pins the complete upstream catalog and generated inventory', () {
    final manifest =
        jsonDecode(
              File(
                'reference/carbon_icons_11_86_0/manifest.json',
              ).readAsStringSync(),
            )
            as Map<String, Object?>;
    final upstream = manifest['upstream']! as Map<String, Object?>;
    final integrity = manifest['integrity']! as Map<String, Object?>;
    final preparation = manifest['fontPreparation']! as Map<String, Object?>;
    final lock =
        jsonDecode(
              File(
                'lib/src/icons/generated/iconfont.lock.json',
              ).readAsStringSync(),
            )
            as Map<String, Object?>;
    final report =
        jsonDecode(
              File(
                'lib/src/icons/generated/iconfont.report.json',
              ).readAsStringSync(),
            )
            as Map<String, Object?>;

    expect(upstream['package'], '@carbon/icons');
    expect(upstream['version'], '11.86.0');
    expect(upstream['license'], 'Apache-2.0');
    expect(integrity['fileCount'], 2725);
    expect(preparation['fileCount'], 5);
    expect(lock['fontPackage'], 'remix_carbon');
    expect(lock['glyphs']! as List<Object?>, hasLength(2725));
    expect(report['glyphCount'], 2725);
    expect(report['losslessGlyphCount'], 2725);
    expect(report['approximatedGlyphCount'], 0);
    expect(report['skippedIconCount'], 0);
  });

  test('exposes stable, tree-shakable Carbon icon metadata', () {
    expect(CarbonIcons.add.codePoint, 0xE000);
    expect(CarbonIcons.add.fontFamily, 'CarbonIcons');
    expect(CarbonIcons.add.fontPackage, 'remix_carbon');
    expect(CarbonIcons.close.fontFamily, 'CarbonIcons');
    expect(CarbonIcons.warningFilled.codePoint, greaterThan(0xE000));
    expect(CarbonIcons.radioButtonChecked.codePoint, 0xE020);
    expect(CarbonIcons.radioButton.codePoint, 0xE021);
    expect(CarbonIcons.icon4K.codePoint, greaterThan(0xE021));
    expect(CarbonIcons.switchIcon.fontFamily, 'CarbonIcons');
    expect(CarbonIcons.zoomOut.codePoint, greaterThan(0xE021));
  });

  testWidgets('builds representative official glyph categories', (
    tester,
  ) async {
    const representatives = [
      CarbonIcons.add,
      CarbonIcons.chevronDown,
      CarbonIcons.checkmarkFilled,
      CarbonIcons.warningFilled,
      CarbonIcons.overflowMenuVertical,
      CarbonIcons.radioButtonChecked,
      CarbonIcons.icon4K,
      CarbonIcons.calendarAdd,
      CarbonIcons.dataQualityDefinition,
      CarbonIcons.switchIcon,
      CarbonIcons.watsonHealthStudyView,
      CarbonIcons.workflowAutomation,
      CarbonIcons.zoomOut,
    ];

    await tester.pumpWidget(
      WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (context, child) =>
            Row(children: [for (final icon in representatives) Icon(icon)]),
      ),
    );

    expect(find.byType(Icon), findsNWidgets(representatives.length));
    for (final icon in representatives) {
      expect(find.byIcon(icon), findsOneWidget);
    }
  });

  testWidgets('Carbon components use the generated catalog', (tester) async {
    final controller = TextEditingController(text: 'query');
    addTearDown(controller.dispose);

    await tester.pumpCarbonApp(
      Column(
        children: [
          CarbonSearch(labelText: 'Search', controller: controller),
          CarbonIconButton(
            icon: CarbonIcons.copy,
            semanticLabel: 'Copy',
            onPressed: () {},
          ),
        ],
      ),
    );

    expect(find.byIcon(CarbonIcons.search), findsOneWidget);
    expect(find.byIcon(CarbonIcons.close), findsOneWidget);
    expect(find.byIcon(CarbonIcons.copy), findsOneWidget);
  });
}
