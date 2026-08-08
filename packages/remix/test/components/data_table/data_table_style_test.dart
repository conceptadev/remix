import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

class _Record {
  const _Record(this.id, this.name);

  final String id;
  final String name;
}

const _records = [_Record('a', 'Ada'), _Record('b', 'Blaise')];

final Finder _tableFinder = find.byWidgetPredicate((widget) => widget is Table);

List<RemixDataTableColumn<_Record>> _columns({
  TableColumnWidth first = const FixedColumnWidth(120),
  TableColumnWidth second = const FlexColumnWidth(),
}) {
  return [
    RemixDataTableColumn<_Record>(
      id: 'name',
      label: 'Name',
      width: first,
      cellBuilder: (context, row) => Text(row.name),
    ),
    RemixDataTableColumn<_Record>(
      id: 'id',
      label: 'Id',
      width: second,
      cellBuilder: (context, row) => Text(row.id),
    ),
  ];
}

/// Horizontal offset of [finder] relative to the table's own left edge.
double _left(WidgetTester tester, Finder finder) =>
    tester.getRect(finder).left - tester.getRect(_tableFinder).left;

/// Every visible [Box] painted for one region, matched by its resolved color.
List<Color?> _boxColors(WidgetTester tester) {
  return tester
      .widgetList<Box>(find.byType(Box))
      .map((box) => (box.styleSpec?.spec.decoration as BoxDecoration?)?.color)
      .toList();
}

Widget _table({
  List<_Record> rows = _records,
  DataTableStyler? style,
  DataTableSpec? styleSpec,
  bool selectable = false,
  Set<Object> selected = const {},
  double minimumWidth = 0,
  List<RemixDataTableColumn<_Record>>? columns,
}) {
  return RemixDataTable<_Record>(
    rows: rows,
    columns: columns ?? _columns(),
    minimumWidth: minimumWidth,
    rowId: selectable ? (row) => row.id : null,
    selectedRowIds: selected,
    onSelectionChanged: selectable ? (_) {} : null,
    style: style ?? const DataTableStyler.create(),
    styleSpec: styleSpec,
  );
}

void main() {
  group('column widths', () {
    testWidgets('header and body share one column map', (tester) async {
      await tester.pumpRemixApp(SizedBox(width: 600, child: _table()));

      expect(_left(tester, find.text('Name')), _left(tester, find.text('Ada')));
      expect(_left(tester, find.text('Id')), _left(tester, find.text('a')));
    });

    testWidgets('the fixed column keeps its width when selection is added', (
      tester,
    ) async {
      await tester.pumpRemixApp(SizedBox(width: 600, child: _table()));
      final withoutSelection =
          _left(tester, find.text('Id')) - _left(tester, find.text('Name'));
      expect(_left(tester, find.text('Name')), 0);

      await tester.pumpRemixApp(
        SizedBox(width: 600, child: _table(selectable: true)),
      );

      expect(
        _left(tester, find.text('Id')) - _left(tester, find.text('Name')),
        withoutSelection,
      );
      // The whole map shifts by exactly the inserted selection column.
      expect(_left(tester, find.text('Name')), 48);
    });

    testWidgets('selection column parity survives across every row', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(width: 600, child: _table(selectable: true)),
      );

      final checkboxes = tester
          .widgetList<RemixCheckbox>(find.byType(RemixCheckbox))
          .toList();
      expect(checkboxes, hasLength(_records.length + 1));
      final lefts = find
          .byType(RemixCheckbox)
          .evaluate()
          .map((element) => tester.getRect(find.byWidget(element.widget)).left)
          .toSet();
      expect(lefts, hasLength(1));
    });
  });

  group('bounded width', () {
    testWidgets('lays out at the viewport width when it exceeds the minimum', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(width: 500, child: _table(minimumWidth: 300)),
      );

      expect(tester.getSize(_tableFinder).width, 500);
    });

    testWidgets('lays out at the minimum width and scrolls when narrower', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(width: 200, child: _table(minimumWidth: 640)),
      );

      expect(tester.getSize(_tableFinder).width, 640);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'keeps pagination controls in the viewport while table scrolls',
      (tester) async {
        const viewportKey = ValueKey('data-table-viewport');
        await tester.pumpRemixApp(
          SizedBox(
            key: viewportKey,
            width: 500,
            child: RemixDataTable<_Record>(
              rows: _records,
              columns: _columns(),
              minimumWidth: 640,
              totalRows: 42,
              onPageChanged: (_) {},
              onPageSizeChanged: (_) {},
            ),
          ),
        );

        expect(tester.getSize(_tableFinder).width, 640);
        final viewport = tester.getRect(find.byKey(viewportKey));
        expect(
          tester
              .getRect(find.byKey(const ValueKey('remix-data-table-next-page')))
              .right,
          lessThanOrEqualTo(viewport.right),
        );
      },
    );

    testWidgets('resolves flex columns under an unbounded parent', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _table(minimumWidth: 400),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(tester.getSize(_tableFinder).width, greaterThanOrEqualTo(400));
    });

    testWidgets('does not overflow at a very narrow viewport', (tester) async {
      await tester.pumpRemixApp(SizedBox(width: 60, child: _table()));

      expect(tester.takeException(), isNull);
    });
  });

  group('regions', () {
    testWidgets('paints row chrome behind every cell of a row', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            style: DataTableStyler()
                .headerRow(BoxStyler().color(const Color(0xFF111111)))
                .bodyRow(BoxStyler().color(const Color(0xFF222222))),
          ),
        ),
      );

      final colors = _boxColors(tester);
      // Two header cells plus two cells for each of the two rows.
      expect(colors.where((c) => c == const Color(0xFF111111)), hasLength(2));
      expect(colors.where((c) => c == const Color(0xFF222222)), hasLength(4));
    });

    testWidgets('lastBodyRow merges over bodyRow for the final row only', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            style: DataTableStyler()
                .bodyRow(BoxStyler().color(const Color(0xFF222222)))
                .lastBodyRow(BoxStyler().color(const Color(0xFF333333))),
          ),
        ),
      );

      final colors = _boxColors(tester);
      expect(colors.where((c) => c == const Color(0xFF222222)), hasLength(2));
      expect(colors.where((c) => c == const Color(0xFF333333)), hasLength(2));
    });

    testWidgets('the selection column uses selectionCell, not bodyCell', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            style: DataTableStyler()
                .bodyCell(BoxStyler().color(const Color(0xFF444444)))
                .selectionCell(BoxStyler().color(const Color(0xFF555555))),
          ),
        ),
      );

      final colors = _boxColors(tester);
      expect(colors.where((c) => c == const Color(0xFF444444)), hasLength(4));
      // One header selection cell plus one per row.
      expect(colors.where((c) => c == const Color(0xFF555555)), hasLength(3));
    });

    testWidgets('applies header typography and the sort indicator style', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: RemixDataTable<_Record>(
            rows: _records,
            columns: [
              RemixDataTableColumn<_Record>(
                id: 'name',
                label: 'Name',
                sortable: true,
                cellBuilder: (context, row) => Text(row.name),
              ),
            ],
            onSortChanged: (_) {},
            style: DataTableStyler()
                .headerLabelColor(const Color(0xFF00FF00))
                .sortIconColor(const Color(0xFF0000FF)),
          ),
        ),
      );

      final header = tester.widget<Text>(find.text('Name'));
      expect(header.style?.color, const Color(0xFF00FF00));
      expect(
        tester.widget<Icon>(find.byIcon(Icons.unfold_more)).color,
        const Color(0xFF0000FF),
      );
    });

    testWidgets('a raw spec bypasses styler resolution', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            styleSpec: DataTableSpec(
              bodyRow: StyleSpec(
                spec: BoxSpec(
                  decoration: const BoxDecoration(color: Color(0xFF666666)),
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        _boxColors(tester).where((c) => c == const Color(0xFF666666)),
        hasLength(4),
      );
    });
  });

  group('widget states', () {
    testWidgets('selected rows resolve their own onSelected variant', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            selected: const {'a'},
            style: DataTableStyler().bodyRow(
              BoxStyler()
                  .color(const Color(0xFF777777))
                  .onSelected(BoxStyler().color(const Color(0xFF888888))),
            ),
          ),
        ),
      );

      final colors = _boxColors(tester);
      // The selected row's three cells, and the unselected row's three.
      expect(colors.where((c) => c == const Color(0xFF888888)), hasLength(3));
      expect(colors.where((c) => c == const Color(0xFF777777)), hasLength(3));
    });

    testWidgets('hovering any cell highlights its whole row', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            style: DataTableStyler().bodyRow(
              BoxStyler()
                  .color(const Color(0xFF777777))
                  .onHovered(BoxStyler().color(const Color(0xFF999999))),
            ),
          ),
        ),
      );

      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(
        pointer.hover(tester.getCenter(find.text('Ada'))),
      );
      await tester.pump();

      final colors = _boxColors(tester);
      expect(colors.where((c) => c == const Color(0xFF999999)), hasLength(2));
      expect(colors.where((c) => c == const Color(0xFF777777)), hasLength(2));
    });

    testWidgets('provider-inherited stylers resolve on a hovered row', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        StyleProvider<DataTableSpec>(
          style: DataTableStyler().bodyRow(
            BoxStyler()
                .color(const Color(0xFF777777))
                .onHovered(BoxStyler().color(const Color(0xFF999999))),
          ),
          child: SizedBox(width: 400, child: _table()),
        ),
      );

      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(
        pointer.hover(tester.getCenter(find.text('Ada'))),
      );
      await tester.pump();

      final colors = _boxColors(tester);
      expect(colors.where((c) => c == const Color(0xFF999999)), hasLength(2));
      expect(colors.where((c) => c == const Color(0xFF777777)), hasLength(2));
    });

    testWidgets('clears a hovered row index when row content changes', (
      tester,
    ) async {
      final style = DataTableStyler().bodyRow(
        BoxStyler()
            .color(const Color(0xFF777777))
            .onHovered(BoxStyler().color(const Color(0xFF999999))),
      );
      final c = _Record('c', 'Curie');

      await tester.pumpRemixApp(
        SizedBox(width: 400, child: _table(style: style)),
      );

      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(
        pointer.hover(tester.getCenter(find.text('Blaise'))),
      );
      await tester.pump();
      expect(
        _boxColors(tester).where((c) => c == const Color(0xFF999999)),
        hasLength(2),
      );

      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(rows: [_records.first], style: style),
        ),
      );
      // Once the hovered MouseRegion is gone, moving the pointer cannot fire
      // its onExit callback.
      await tester.sendEventToBinding(pointer.hover(const Offset(1000, 1000)));
      await tester.pump();
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(rows: [_records.first, c], style: style),
        ),
      );

      expect(
        _boxColors(tester).where((c) => c == const Color(0xFF999999)),
        isEmpty,
      );
    });

    testWidgets('selection visuals do not change row geometry', (tester) async {
      final style = DataTableStyler()
          .bodyRow(
            BoxStyler()
                .color(const Color(0xFF777777))
                .onSelected(BoxStyler().color(const Color(0xFF888888))),
          )
          .rowMinHeight(40);

      await tester.pumpRemixApp(
        SizedBox(width: 400, child: _table(selectable: true, style: style)),
      );
      final unselected = tester.getSize(_tableFinder);

      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            selected: const {'a', 'b'},
            style: style,
          ),
        ),
      );

      expect(tester.getSize(_tableFinder), unselected);
    });
  });

  group('metrics', () {
    testWidgets('rowMinHeight and headerMinHeight set the row floors', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            style: DataTableStyler().headerMinHeight(60).rowMinHeight(30),
          ),
        ),
      );

      expect(tester.getSize(_tableFinder).height, 60 + 30 * _records.length);
    });

    testWidgets('each selection checkbox fills its own row', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            style: DataTableStyler()
                .selectionColumnWidth(52)
                .headerMinHeight(80)
                .rowMinHeight(24),
          ),
        ),
      );

      // The header and body floors differ, so a checkbox wired to the wrong
      // one would still leave the surrounding cell correct and go unnoticed.
      expect(
        tester.getSize(find.byType(RemixCheckbox).first),
        const Size(52, 80),
      );
      expect(
        tester.getSize(find.byType(RemixCheckbox).at(1)),
        const Size(52, 24),
      );
    });

    testWidgets('selectionColumnWidth sets the leading column width', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            style: DataTableStyler().selectionColumnWidth(72),
          ),
        ),
      );

      expect(_left(tester, find.text('Name')), 72);
    });

    testWidgets('a negative resolved dimension fails in debug builds', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(style: DataTableStyler().rowMinHeight(-1)),
        ),
      );

      expect(
        tester.takeException(),
        isA<AssertionError>().having(
          (error) => error.message,
          'message',
          contains('non-negative'),
        ),
      );
    });
  });

  group('DataTableStyler helpers', () {
    testWidgets('cellPadding reaches header, body, and selection cells', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            selectable: true,
            style: DataTableStyler().cellPadding(EdgeInsetsGeometryMix.all(9)),
          ),
        ),
      );

      final paddings = tester
          .widgetList<Box>(find.byType(Box))
          .map((box) => box.styleSpec?.spec.padding)
          .whereType<EdgeInsetsGeometry>()
          .toSet();
      expect(paddings, {const EdgeInsets.all(9)});
    });

    testWidgets('rowDivider draws under header and body rows', (tester) async {
      await tester.pumpRemixApp(
        SizedBox(
          width: 400,
          child: _table(
            style: DataTableStyler().rowDivider(
              BorderSideMix(color: const Color(0xFFAAAAAA), width: 2),
            ),
          ),
        ),
      );

      final borders = tester
          .widgetList<Box>(find.byType(Box))
          .map(
            (box) => (box.styleSpec?.spec.decoration as BoxDecoration?)?.border,
          )
          .whereType<Border>()
          .toList();
      expect(borders, hasLength(6));
      expect(borders.first.bottom.color, const Color(0xFFAAAAAA));
      expect(borders.first.bottom.width, 2);
    });
  });
}
