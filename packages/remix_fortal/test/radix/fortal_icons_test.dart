import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../helpers/test_helpers.dart';

void main() {
  test('exposes stable tree-shakable icon metadata', () {
    expect(FortalIcons.accessibility.codePoint, 0xE000);
    expect(FortalIcons.accessibility.fontFamily, 'FortalIcons');
    expect(FortalIcons.accessibility.fontPackage, 'remix_fortal');

    expect(FortalIcons.check.fontFamily, 'FortalIcons');
    expect(FortalIcons.switchIcon.fontFamily, 'FortalIcons');
    expect(FortalIcons.zoomOut.codePoint, greaterThan(0xE000));
  });

  test('Fortal controls forward explicit catalog icons', () {
    const checkbox = FortalCheckbox(
      selected: true,
      checkedIcon: FortalIcons.check,
      indeterminateIcon: FortalIcons.minus,
    );
    expect(checkbox.checkedIcon, FortalIcons.check);
    expect(checkbox.indeterminateIcon, FortalIcons.minus);

    const groupItem = FortalCheckboxGroupItem<int>(
      value: 1,
      label: 'One',
      checkedIcon: FortalIcons.check,
    );
    expect(groupItem.checkedIcon, FortalIcons.check);

    final table = FortalDataTable<int>(
      rows: const [1],
      sortableIcon: FortalIcons.caretSort,
      sortAscendingIcon: FortalIcons.caretUp,
      sortDescendingIcon: FortalIcons.caretDown,
      previousPageIcon: FortalIcons.chevronLeft,
      nextPageIcon: FortalIcons.chevronRight,
      columns: [
        RemixDataTableColumn<int>(
          id: 'value',
          label: 'Value',
          cellBuilder: (context, row) => Text('$row'),
        ),
      ],
    );
    expect(table.sortableIcon, FortalIcons.caretSort);
    expect(table.sortAscendingIcon, FortalIcons.caretUp);
    expect(table.sortDescendingIcon, FortalIcons.caretDown);
    expect(table.previousPageIcon, FortalIcons.chevronLeft);
    expect(table.nextPageIcon, FortalIcons.chevronRight);
  });

  testWidgets('generated Fortal wrappers keep the direct Remix targets', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      Column(
        children: [
          const FortalCheckbox(selected: true),
          FortalDataTable<int>(
            rows: const [1],
            columns: [
              RemixDataTableColumn<int>(
                id: 'value',
                label: 'Value',
                cellBuilder: (context, row) => Text('$row'),
              ),
            ],
          ),
        ],
      ),
    );

    expect(find.byType(RemixCheckbox), findsOneWidget);
    expect(find.byType(RemixDataTable<int>), findsOneWidget);
  });

  testWidgets(
    'renders outline, filled, even-odd, directional, and approximated glyphs',
    (tester) async {
      const representatives = [
        FortalIcons.check,
        FortalIcons.heartFilled,
        FortalIcons.borderSplit,
        FortalIcons.arrowLeft,
        FortalIcons.shadow,
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
    },
  );
}
