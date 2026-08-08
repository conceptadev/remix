import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('DataTableSpec', () {
    test('defaults every region and leaves every scalar null', () {
      const spec = DataTableSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.headerRow, isA<StyleSpec<BoxSpec>>());
      expect(spec.bodyRow, isA<StyleSpec<BoxSpec>>());
      expect(spec.headerCell, isA<StyleSpec<BoxSpec>>());
      expect(spec.bodyCell, isA<StyleSpec<BoxSpec>>());
      expect(spec.selectionCell, isA<StyleSpec<BoxSpec>>());
      expect(spec.footer, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.headerLabel, isA<StyleSpec<TextSpec>>());
      expect(spec.footerLabel, isA<StyleSpec<TextSpec>>());
      expect(spec.sortIcon, isA<StyleSpec<IconSpec>>());

      expect(spec.lastBodyRow, isNull);
      expect(spec.containerEffects, isNull);
      expect(spec.selectionCheckbox, isNull);
      expect(spec.pageButton, isNull);
      expect(spec.pageSizeSelect, isNull);
      expect(spec.headerMinHeight, isNull);
      expect(spec.rowMinHeight, isNull);
      expect(spec.selectionColumnWidth, isNull);
      expect(spec.sortIconSpacing, isNull);
    });

    test('retains every supplied region and scalar', () {
      final checkbox = CheckboxStyler().indicatorColor(Colors.red);
      final pageButton = IconButtonStyler().iconColor(Colors.green);
      final select = SelectStyler().content(SelectContentStyler().width(10));
      final spec = DataTableSpec(
        container: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(1))),
        headerRow: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(2))),
        bodyRow: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(3))),
        lastBodyRow: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(4))),
        headerCell: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(5))),
        bodyCell: StyleSpec(spec: BoxSpec(padding: const EdgeInsets.all(6))),
        selectionCell: StyleSpec(
          spec: BoxSpec(padding: const EdgeInsets.all(7)),
        ),
        footer: const StyleSpec(spec: FlexBoxSpec()),
        headerLabel: const StyleSpec(spec: TextSpec(maxLines: 1)),
        footerLabel: const StyleSpec(spec: TextSpec(maxLines: 2)),
        sortIcon: const StyleSpec(spec: IconSpec(size: 8)),
        selectionCheckbox: checkbox,
        pageButton: pageButton,
        pageSizeSelect: select,
        headerMinHeight: 36,
        rowMinHeight: 44,
        selectionColumnWidth: 48,
        sortIconSpacing: 4,
      );

      expect(spec.container.spec.padding, const EdgeInsets.all(1));
      expect(spec.lastBodyRow!.spec.padding, const EdgeInsets.all(4));
      expect(spec.selectionCell.spec.padding, const EdgeInsets.all(7));
      expect(spec.headerLabel.spec.maxLines, 1);
      expect(spec.footerLabel.spec.maxLines, 2);
      expect(spec.sortIcon.spec.size, 8);
      expect(spec.selectionCheckbox, same(checkbox));
      expect(spec.pageButton, same(pageButton));
      expect(spec.pageSizeSelect, same(select));
      expect(spec.headerMinHeight, 36);
      expect(spec.rowMinHeight, 44);
      expect(spec.selectionColumnWidth, 48);
      expect(spec.sortIconSpacing, 4);
    });

    test('retains negative metrics for the renderer to reject', () {
      const spec = DataTableSpec(rowMinHeight: -1);

      expect(spec.rowMinHeight, -1);
    });

    test('copyWith replaces only the named fields', () {
      const original = DataTableSpec(rowMinHeight: 10, sortIconSpacing: 2);
      final updated = original.copyWith(rowMinHeight: 20);

      expect(updated.rowMinHeight, 20);
      expect(updated.sortIconSpacing, 2);
      expect(original.rowMinHeight, 10);
    });

    test('lerp interpolates scalars and holds unresolved control styles', () {
      final checkbox = CheckboxStyler().indicatorColor(Colors.red);
      const from = DataTableSpec(rowMinHeight: 0, selectionColumnWidth: 0);
      final to = DataTableSpec(
        rowMinHeight: 40,
        selectionColumnWidth: 20,
        selectionCheckbox: checkbox,
      );

      final middle = from.lerp(to, 0.5);

      expect(middle.rowMinHeight, 20);
      expect(middle.selectionColumnWidth, 10);
      // Control styles are unresolved handoffs, not animatable values.
      expect(middle.selectionCheckbox, same(checkbox));
      expect(from.lerp(null, 0.5), same(from));
    });

    test('lerp animates container effects instead of snapping', () {
      const from = DataTableSpec(
        containerEffects: RemixBoxEffectsSpec(backdropBlur: 0),
      );
      const to = DataTableSpec(
        containerEffects: RemixBoxEffectsSpec(backdropBlur: 40),
      );

      expect(from.lerp(to, 0.5).containerEffects?.backdropBlur, 20);
    });

    test('equality and hashCode follow every field', () {
      const a = DataTableSpec(rowMinHeight: 10);
      const b = DataTableSpec(rowMinHeight: 10);
      const c = DataTableSpec(rowMinHeight: 11);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
    });

    test('debugFillProperties lists every region and scalar', () {
      const spec = DataTableSpec(rowMinHeight: 44, sortIconSpacing: 4);
      final builder = DiagnosticPropertiesBuilder();
      spec.debugFillProperties(builder);
      final names = builder.properties.map((p) => p.name).toList();

      expect(
        names,
        containsAll([
          'container',
          'containerEffects',
          'headerRow',
          'bodyRow',
          'lastBodyRow',
          'headerCell',
          'bodyCell',
          'selectionCell',
          'footer',
          'headerLabel',
          'footerLabel',
          'sortIcon',
          'selectionCheckbox',
          'pageButton',
          'pageSizeSelect',
          'headerMinHeight',
          'rowMinHeight',
          'selectionColumnWidth',
          'sortIconSpacing',
        ]),
      );
    });
  });

  group('RemixDataTableSort', () {
    test('is value equal', () {
      const a = RemixDataTableSort(
        columnId: 'name',
        direction: RemixDataTableSortDirection.ascending,
      );
      const b = RemixDataTableSort(
        columnId: 'name',
        direction: RemixDataTableSortDirection.ascending,
      );
      const c = RemixDataTableSort(
        columnId: 'name',
        direction: RemixDataTableSortDirection.descending,
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(c));
      expect(a.toString(), contains('name'));
    });
  });

  group('RemixDataTableColumn', () {
    test('rejects supplying both a label and a header', () {
      expect(
        () => RemixDataTableColumn<int>(
          id: 'a',
          label: 'A',
          header: const SizedBox(),
          semanticLabel: 'A',
          cellBuilder: (_, _) => const SizedBox(),
        ),
        throwsAssertionError,
      );
    });

    test('rejects a custom header without a semantic label', () {
      expect(
        () => RemixDataTableColumn<int>(
          id: 'a',
          header: const SizedBox(),
          cellBuilder: (_, _) => const SizedBox(),
        ),
        throwsAssertionError,
      );
    });

    test('rejects an empty id or label', () {
      expect(
        () => RemixDataTableColumn<int>(
          id: '',
          label: 'A',
          cellBuilder: (_, _) => const SizedBox(),
        ),
        throwsAssertionError,
      );
      expect(
        () => RemixDataTableColumn<int>(
          id: 'a',
          label: '',
          cellBuilder: (_, _) => const SizedBox(),
        ),
        throwsAssertionError,
      );
    });
  });

  group('RemixDataTableLabels', () {
    test('defaults to English strings that callers can replace wholesale', () {
      const labels = RemixDataTableLabels();

      expect(labels.rowsPerPage, 'Rows per page');
      expect(labels.previousPage, 'Previous page');
      expect(labels.nextPage, 'Next page');
      expect(labels.selectAllRows, 'Select all rows on this page');
      expect(labels.selectRow, 'Select row');
      expect(labels.sortedAscending, 'sorted ascending');
      expect(labels.sortedDescending, 'sorted descending');
    });
  });

  group('remixDefaultDataTablePageRangeFormatter', () {
    test('formats one-based ranges and the empty case', () {
      expect(
        remixDefaultDataTablePageRangeFormatter(start: 1, end: 10, total: 42),
        '1–10 of 42',
      );
      expect(
        remixDefaultDataTablePageRangeFormatter(start: 0, end: 0, total: 0),
        '0–0 of 0',
      );
    });
  });
}
