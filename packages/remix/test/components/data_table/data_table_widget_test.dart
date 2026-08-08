import 'dart:ui' show CheckedState, SemanticsRole;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' hide SemanticsRole;
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

class _Record {
  const _Record(this.id, this.name, this.amount);

  final String id;
  final String name;
  final int amount;
}

const _records = [
  _Record('a', 'Ada', 3),
  _Record('b', 'Blaise', 1),
  _Record('c', 'Curie', 2),
];

/// The renderer uses a private [Table] subclass, so match by subtype.
final Finder _tableFinder = find.byWidgetPredicate((widget) => widget is Table);

List<RemixDataTableColumn<_Record>> _columns({bool sortable = false}) {
  return [
    RemixDataTableColumn<_Record>(
      id: 'name',
      label: 'Name',
      sortable: sortable,
      cellBuilder: (context, row) => Text(row.name),
    ),
    RemixDataTableColumn<_Record>(
      id: 'amount',
      label: 'Amount',
      alignment: RemixDataTableCellAlignment.end,
      cellBuilder: (context, row) => Text('${row.amount}'),
    ),
  ];
}

SemanticsNode? _find(
  SemanticsNode root,
  bool Function(SemanticsData data) predicate,
) {
  if (predicate(root.getSemanticsData())) return root;
  SemanticsNode? found;
  root.visitChildren((child) {
    found ??= _find(child, predicate);

    return found == null;
  });

  return found;
}

List<SemanticsNode> _children(SemanticsNode node) {
  final children = <SemanticsNode>[];
  node.visitChildren((child) {
    children.add(child);

    return true;
  });

  return children;
}

SemanticsNode _tableNode(WidgetTester tester) {
  final anchor = tester.getSemantics(_tableFinder);
  final node = _find(anchor, (data) => data.role == SemanticsRole.table);
  expect(node, isNotNull, reason: 'Expected a table semantics node.');

  return node!;
}

void main() {
  group('RemixDataTable structure', () {
    testWidgets('renders one header row plus one row per record', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(rows: _records, columns: _columns()),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      for (final record in _records) {
        expect(find.text(record.name), findsOneWidget);
      }
    });

    testWidgets('operates without a Material ancestor', (tester) async {
      await tester.pumpWidget(
        MixScope.empty(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Align(
              child: RemixDataTable<_Record>(
                rows: _records,
                columns: _columns(),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Ada'), findsOneWidget);
    });

    testWidgets('keeps a rendered snapshot of a mutated rows list', (
      tester,
    ) async {
      final rows = [..._records];
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(rows: rows, columns: _columns()),
      );
      rows.clear();
      await tester.pump();

      expect(find.text('Ada'), findsOneWidget);
    });

    testWidgets('renders the empty builder while keeping the header', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: const [],
          columns: _columns(),
          emptyBuilder: (context) => const Text('No results'),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('No results'), findsOneWidget);
    });

    testWidgets('infers its generic argument from typed columns', (
      tester,
    ) async {
      final table = RemixDataTable(
        rows: _records,
        columns: <RemixDataTableColumn<_Record>>[
          RemixDataTableColumn(
            id: 'name',
            label: 'Name',
            cellBuilder: (context, row) => Text(row.name.toUpperCase()),
          ),
        ],
      );
      await tester.pumpRemixApp(table);

      expect(table, isA<RemixDataTable<_Record>>());
      expect(find.text('ADA'), findsOneWidget);
    });

    testWidgets('rejects duplicate column ids in debug builds', (tester) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: [
            RemixDataTableColumn<_Record>(
              id: 'name',
              label: 'Name',
              cellBuilder: (context, row) => Text(row.name),
            ),
            RemixDataTableColumn<_Record>(
              id: 'name',
              label: 'Copy',
              cellBuilder: (context, row) => Text(row.name),
            ),
          ],
        ),
      );

      expect(
        tester.takeException(),
        isA<AssertionError>().having(
          (error) => error.message,
          'message',
          contains('duplicate id'),
        ),
      );
    });
  });

  group('RemixDataTable sorting', () {
    testWidgets('cycles ascending then descending without reordering rows', (
      tester,
    ) async {
      final emitted = <RemixDataTableSort>[];
      RemixDataTableSort? sort;
      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) => RemixDataTable<_Record>(
            rows: _records,
            columns: _columns(sortable: true),
            sort: sort,
            onSortChanged: (value) {
              emitted.add(value);
              setState(() => sort = value);
            },
          ),
        ),
      );

      await tester.tap(find.text('Name'));
      await tester.pump();
      await tester.tap(find.text('Name'));
      await tester.pump();

      expect(emitted, [
        const RemixDataTableSort(
          columnId: 'name',
          direction: RemixDataTableSortDirection.ascending,
        ),
        const RemixDataTableSort(
          columnId: 'name',
          direction: RemixDataTableSortDirection.descending,
        ),
      ]);
      // Row order is caller-owned; the table never reorders what it was given.
      final names = tester
          .widgetList<Text>(find.byType(Text))
          .map((text) => text.data)
          .toList();
      expect(
        names.indexOf('Ada') < names.indexOf('Blaise'),
        isTrue,
        reason: 'Supplied row order must survive a sort emission.',
      );
    });

    testWidgets('announces sort state on the column header node once', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(sortable: true),
          sort: const RemixDataTableSort(
            columnId: 'name',
            direction: RemixDataTableSortDirection.descending,
          ),
          onSortChanged: (_) {},
        ),
      );

      final header = _children(_tableNode(tester)).first;
      final headerCells = _children(header);
      final data = headerCells.first.getSemanticsData();

      expect(data.role, SemanticsRole.columnHeader);
      expect(data.label, 'Name');
      expect(data.value, 'sorted descending');
      expect(data.hasAction(SemanticsAction.tap), isTrue);
      expect(headerCells.first.childrenCount, 0);

      handle.dispose();
    });

    testWidgets('reports a header tap through its semantics action', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      RemixDataTableSort? emitted;
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(sortable: true),
          onSortChanged: (value) => emitted = value,
        ),
      );

      final header = _children(_tableNode(tester)).first;
      tester.binding.performSemanticsAction(
        SemanticsActionEvent(
          type: SemanticsAction.tap,
          nodeId: _children(header).first.id,
          viewId: tester.view.viewId,
        ),
      );
      await tester.pump();

      expect(emitted?.columnId, 'name');
      handle.dispose();
    });

    testWidgets('overrides the announced sort state through labels', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(sortable: true),
          labels: const RemixDataTableLabels(sortedAscending: 'croissant'),
          sort: const RemixDataTableSort(
            columnId: 'name',
            direction: RemixDataTableSortDirection.ascending,
          ),
          onSortChanged: (_) {},
        ),
      );

      final header = _children(_tableNode(tester)).first;
      expect(_children(header).first.getSemanticsData().value, 'croissant');
      handle.dispose();
    });
  });

  group('RemixDataTable selection', () {
    Widget buildSelectable({
      required Set<Object> selected,
      required ValueChanged<Set<Object>> onChanged,
    }) {
      return RemixDataTable<_Record>(
        rows: _records,
        columns: _columns(),
        rowId: (row) => row.id,
        selectedRowIds: selected,
        onSelectionChanged: onChanged,
      );
    }

    testWidgets('emits a fresh unmodifiable set when a row toggles', (
      tester,
    ) async {
      Set<Object>? emitted;
      await tester.pumpRemixApp(
        buildSelectable(selected: const {}, onChanged: (v) => emitted = v),
      );

      await tester.tap(find.byType(RemixCheckbox).at(1));
      await tester.pump();

      expect(emitted, {'a'});
      expect(() => emitted!.add('z'), throwsUnsupportedError);
    });

    testWidgets('select-all is page scoped and keeps other pages selected', (
      tester,
    ) async {
      Set<Object>? emitted;
      await tester.pumpRemixApp(
        buildSelectable(
          selected: const {'offpage'},
          onChanged: (v) => emitted = v,
        ),
      );

      await tester.tap(
        find.byKey(const ValueKey('remix-data-table-select-all')),
      );
      await tester.pump();

      expect(emitted, {'offpage', 'a', 'b', 'c'});
    });

    testWidgets('select-all clears only the visible rows', (tester) async {
      Set<Object>? emitted;
      await tester.pumpRemixApp(
        buildSelectable(
          selected: const {'offpage', 'a', 'b', 'c'},
          onChanged: (v) => emitted = v,
        ),
      );

      await tester.tap(
        find.byKey(const ValueKey('remix-data-table-select-all')),
      );
      await tester.pump();

      expect(emitted, {'offpage'});
    });

    testWidgets('renders no selection column without both selection inputs', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(rows: _records, columns: _columns()),
      );

      expect(find.byType(RemixCheckbox), findsNothing);
    });

    testWidgets('rejects half of the selection contract in debug builds', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(),
          rowId: (row) => row.id,
        ),
      );

      expect(
        tester.takeException(),
        isA<AssertionError>().having(
          (error) => error.message,
          'message',
          contains('rowId and onSelectionChanged'),
        ),
      );
    });

    testWidgets('exposes checkbox semantics exactly once per selection cell', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpRemixApp(
        buildSelectable(selected: const {'a'}, onChanged: (_) {}),
      );

      final rows = _children(_tableNode(tester));
      final firstBodyCells = _children(rows[1]);
      expect(firstBodyCells.first.getSemanticsData().role, SemanticsRole.cell);
      final checkboxes = <SemanticsNode>[];
      void collect(SemanticsNode node) {
        if (node.getSemanticsData().flagsCollection.isChecked !=
            CheckedState.none) {
          checkboxes.add(node);
        }
        node.visitChildren((child) {
          collect(child);

          return true;
        });
      }

      collect(firstBodyCells.first);
      expect(checkboxes, hasLength(1));
      expect(
        checkboxes.single.getSemanticsData().flagsCollection.isChecked,
        CheckedState.isTrue,
      );

      handle.dispose();
    });

    testWidgets('select-all reports none, mixed, and all as one node', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      Future<CheckedState> selectAllState(Set<Object> selected) async {
        await tester.pumpRemixApp(
          buildSelectable(selected: selected, onChanged: (_) {}),
        );
        final headerCells = _children(_children(_tableNode(tester)).first);
        // The unlabelled selection header keeps the checkbox as its one child.
        expect(
          headerCells.first.getSemanticsData().role,
          SemanticsRole.columnHeader,
        );
        final children = _children(headerCells.first);
        expect(children, hasLength(1));

        return children.single.getSemanticsData().flagsCollection.isChecked;
      }

      expect(await selectAllState(const {}), CheckedState.isFalse);
      expect(await selectAllState(const {'a'}), CheckedState.mixed);
      expect(await selectAllState(const {'a', 'b', 'c'}), CheckedState.isTrue);

      handle.dispose();
    });
  });

  group('RemixDataTable pagination', () {
    Widget buildPaginated({
      int pageIndex = 0,
      RemixDataTableLabels labels = const RemixDataTableLabels(),
      RemixDataTablePageRangeFormatter formatter =
          remixDefaultDataTablePageRangeFormatter,
      ValueChanged<int>? onPageChanged,
      ValueChanged<int>? onPageSizeChanged,
    }) {
      return RemixDataTable<_Record>(
        rows: _records,
        columns: _columns(),
        totalRows: 42,
        pageIndex: pageIndex,
        pageSize: 10,
        labels: labels,
        pageRangeFormatter: formatter,
        onPageChanged: onPageChanged ?? (_) {},
        onPageSizeChanged: onPageSizeChanged ?? (_) {},
      );
    }

    testWidgets('reports the one-based range of the visible rows', (
      tester,
    ) async {
      await tester.pumpRemixApp(buildPaginated(pageIndex: 1));

      // Page 2 of a 10-per-page result set starts at 11, and only three rows
      // were supplied, so the range describes what is actually on screen.
      expect(find.text('11–13 of 42'), findsOneWidget);
    });

    testWidgets('reports a zero range for an empty result set', (tester) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: const [],
          columns: _columns(),
          totalRows: 0,
          pageSize: 10,
          onPageChanged: (_) {},
          onPageSizeChanged: (_) {},
        ),
      );

      expect(find.text('0–0 of 0'), findsOneWidget);
    });

    testWidgets('routes the range through a caller-supplied formatter', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        buildPaginated(
          formatter: ({required start, required end, required total}) =>
              '$total ← $end..$start',
        ),
      );

      expect(find.text('42 ← 3..1'), findsOneWidget);
    });

    testWidgets('disables previous on the first page and advances on next', (
      tester,
    ) async {
      final pages = <int>[];
      await tester.pumpRemixApp(buildPaginated(onPageChanged: pages.add));

      await tester.tap(
        find.byKey(const ValueKey('remix-data-table-previous-page')),
      );
      await tester.pump();
      expect(pages, isEmpty);

      await tester.tap(
        find.byKey(const ValueKey('remix-data-table-next-page')),
      );
      await tester.pump();
      expect(pages, [1]);
    });

    testWidgets('localizes every built-in control label', (tester) async {
      await tester.pumpRemixApp(
        buildPaginated(
          labels: const RemixDataTableLabels(
            rowsPerPage: 'Linhas por página',
            previousPage: 'Anterior',
            nextPage: 'Próxima',
          ),
        ),
      );

      expect(find.text('Linhas por página'), findsOneWidget);
      expect(
        tester
            .widget<RemixIconButton>(
              find.byKey(const ValueKey('remix-data-table-previous-page')),
            )
            .semanticLabel,
        'Anterior',
      );
      expect(
        tester
            .widget<RemixIconButton>(
              find.byKey(const ValueKey('remix-data-table-next-page')),
            )
            .semanticLabel,
        'Próxima',
      );
    });

    testWidgets('renders no footer without the full pagination contract', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(rows: _records, columns: _columns()),
      );

      expect(find.byType(RemixIconButton), findsNothing);
    });

    testWidgets('rejects a page with more rows than its page size', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(),
          totalRows: 3,
          pageSize: 2,
          pageSizeOptions: const [2],
          onPageChanged: (_) {},
          onPageSizeChanged: (_) {},
        ),
      );

      expect(
        tester.takeException(),
        isA<AssertionError>().having(
          (error) => error.message,
          'message',
          contains('exceeds pageSize'),
        ),
      );
    });

    testWidgets('keeps pagination outside the structural table node', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpRemixApp(buildPaginated());

      for (final row in _children(_tableNode(tester))) {
        expect(row.getSemanticsData().role, SemanticsRole.row);
        for (final cell in _children(row)) {
          expect(
            cell.getSemanticsData().role,
            anyOf(SemanticsRole.cell, SemanticsRole.columnHeader),
          );
        }
      }

      handle.dispose();
    });
  });

  group('RemixDataTable semantics and hosts', () {
    testWidgets('emits table, row, columnHeader, and cell roles', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: _columns(),
          semanticLabel: 'Customers',
        ),
      );

      final table = _tableNode(tester);
      expect(table.getSemanticsData().label, 'Customers');

      final rows = _children(table);
      expect(rows, hasLength(_records.length + 1));
      expect(
        _children(rows.first).map((node) => node.getSemanticsData().role),
        everyElement(SemanticsRole.columnHeader),
      );
      expect(
        _children(rows[1]).map((node) => node.getSemanticsData().role),
        everyElement(SemanticsRole.cell),
      );

      handle.dispose();
    });

    testWidgets('keeps interactive cell content actionable', (tester) async {
      var pressed = 0;
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(
          rows: _records,
          columns: [
            RemixDataTableColumn<_Record>(
              id: 'actions',
              header: const Icon(Icons.more_horiz),
              semanticLabel: 'Actions',
              cellBuilder: (context, row) => RemixButton(
                key: ValueKey('action-${row.id}'),
                label: 'Edit ${row.id}',
                onPressed: () => pressed += 1,
              ),
            ),
          ],
        ),
      );

      await tester.tap(find.byKey(const ValueKey('action-a')));
      await tester.pump();

      expect(pressed, 1);
    });

    testWidgets('mirrors the pagination chevrons right to left', (
      tester,
    ) async {
      Future<Rect> pumpPagination(TextDirection direction) async {
        await tester.pumpRemixApp(
          RemixDataTable<_Record>(
            rows: _records,
            columns: _columns(),
            totalRows: 42,
            onPageChanged: (_) {},
            onPageSizeChanged: (_) {},
          ),
          textDirection: direction,
        );

        return tester.getRect(
          find.byKey(const ValueKey('remix-data-table-previous-page')),
        );
      }

      final ltr = await pumpPagination(TextDirection.ltr);
      expect(
        tester
            .widget<RemixIconButton>(
              find.byKey(const ValueKey('remix-data-table-previous-page')),
            )
            .icon,
        Icons.chevron_left,
      );

      final rtl = await pumpPagination(TextDirection.rtl);
      expect(
        tester
            .widget<RemixIconButton>(
              find.byKey(const ValueKey('remix-data-table-previous-page')),
            )
            .icon,
        Icons.chevron_right,
      );
      // Icon and position mirror together, so "previous" always points back.
      expect(rtl.left, lessThan(ltr.left));
    });

    testWidgets('lays out right to left without overflow', (tester) async {
      await tester.pumpRemixApp(
        RemixDataTable<_Record>(rows: _records, columns: _columns()),
        textDirection: TextDirection.rtl,
      );

      expect(tester.takeException(), isNull);
      final name = tester.getRect(find.text('Name'));
      final amount = tester.getRect(find.text('Amount'));
      expect(name.left, greaterThan(amount.left));
    });

    testWidgets('survives a high text scale', (tester) async {
      await tester.pumpWidget(
        MixScope.empty(
          child: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(3)),
              child: Scaffold(
                body: RemixDataTable<_Record>(
                  rows: _records,
                  columns: _columns(),
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}
