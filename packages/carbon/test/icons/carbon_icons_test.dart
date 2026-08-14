import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  test('exposes stable, tree-shakable Carbon icon metadata', () {
    expect(CarbonIcons.add.codePoint, 0xE000);
    expect(CarbonIcons.add.fontFamily, 'CarbonIcons');
    expect(CarbonIcons.add.fontPackage, 'carbon');
    expect(CarbonIcons.close.fontFamily, 'CarbonIcons');
    expect(CarbonIcons.warningFilled.codePoint, greaterThan(0xE000));
    expect(CarbonIcons.radioButtonChecked.codePoint, 0xE020);
    expect(CarbonIcons.radioButton.codePoint, 0xE021);
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
