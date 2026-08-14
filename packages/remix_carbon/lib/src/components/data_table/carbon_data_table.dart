import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../checkbox/carbon_checkbox.dart';
import '../select/carbon_select.dart';

enum CarbonDataTableSortDirection { ascending, descending }

enum CarbonDataTableCellAlignment { start, center, end }

@immutable
final class CarbonDataTableSort {
  const CarbonDataTableSort({required this.columnId, required this.direction})
    : assert(columnId != '');

  final String columnId;
  final CarbonDataTableSortDirection direction;

  @override
  bool operator ==(Object other) =>
      other is CarbonDataTableSort &&
      other.columnId == columnId &&
      other.direction == direction;

  @override
  int get hashCode => Object.hash(columnId, direction);
}

@immutable
final class CarbonDataTableColumn<T> {
  const CarbonDataTableColumn({
    required this.id,
    required this.cellBuilder,
    this.label,
    this.header,
    this.semanticLabel,
    this.width = const FlexColumnWidth(),
    this.alignment = .start,
    this.sortable = false,
  }) : assert((label == null) != (header == null)),
       assert(header == null || semanticLabel != null);

  final String id;
  final String? label;
  final Widget? header;
  final String? semanticLabel;
  final TableColumnWidth width;
  final CarbonDataTableCellAlignment alignment;
  final bool sortable;
  final Widget Function(BuildContext context, T row) cellBuilder;
}

@immutable
final class CarbonDataTableLabels {
  const CarbonDataTableLabels({
    this.rowsPerPage = 'Rows per page',
    this.previousPage = 'Previous page',
    this.nextPage = 'Next page',
    this.selectAllRows = 'Select all rows on this page',
    this.selectRow = 'Select row',
    this.sortedAscending = 'sorted ascending',
    this.sortedDescending = 'sorted descending',
  });

  final String rowsPerPage;
  final String previousPage;
  final String nextPage;
  final String selectAllRows;
  final String selectRow;
  final String sortedAscending;
  final String sortedDescending;
}

const _carbonTableLayer = ContextToken(_resolveCarbonTableLayer);
const _carbonTableHeader = ContextToken(_resolveCarbonTableHeader);
const _carbonTableHover = ContextToken(_resolveCarbonTableHover);
const _carbonTableSelected = ContextToken(_resolveCarbonTableSelected);
const _carbonTableBorder = ContextToken(_resolveCarbonTableBorder);

Color _resolveCarbonTableLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonTableHeader(BuildContext context) =>
    CarbonLayer.of(context).color(.layerAccent).resolve(context);

Color _resolveCarbonTableHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

Color _resolveCarbonTableSelected(BuildContext context) =>
    CarbonLayer.of(context).color(.layerSelected).resolve(context);

Color _resolveCarbonTableBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

/// Carbon visual recipe for Remix's semantic data table renderer.
DataTableStyler carbonDataTableStyle() {
  final divider = BorderSideMix(color: _carbonTableBorder(), width: 1);

  return DataTableStyler()
      .color(_carbonTableLayer())
      .border(BoxBorderMix.all(divider))
      .headerRow(
        BoxStyler().color(_carbonTableHeader()).border(.bottom(divider)),
      )
      .bodyRow(
        BoxStyler()
            .color(_carbonTableLayer())
            .border(.bottom(divider))
            .onHovered(.color(_carbonTableHover()))
            .onSelected(.color(_carbonTableSelected())),
      )
      .headerCell(BoxStyler().padding(.horizontal(CarbonTokens.spacing05())))
      .bodyCell(BoxStyler().padding(.horizontal(CarbonTokens.spacing05())))
      .selectionCell(BoxStyler().padding(.horizontal(CarbonTokens.spacing05())))
      .headerLabel(
        .style(
          CarbonTokens.headingCompact01.mix(),
        ).color(CarbonTokens.textPrimary()),
      )
      .cellText(
        .style(
          CarbonTokens.bodyCompact01.mix(),
        ).color(CarbonTokens.textPrimary()),
      )
      .footer(
        .minHeight(CarbonTokens.sizeLarge())
            .padding(.horizontal(CarbonTokens.spacing05()))
            .spacing(CarbonTokens.spacing03())
            .crossAxisAlignment(.center)
            .color(_carbonTableLayer()),
      )
      .footerLabel(
        .style(
          CarbonTokens.bodyCompact01.mix(),
        ).color(CarbonTokens.textSecondary()),
      )
      .sortIcon(
        .size(CarbonTokens.iconSize01()).color(CarbonTokens.iconPrimary()),
      )
      .selectionCheckbox(carbonCheckboxStyle())
      .pageSizeSelect(carbonSelectStyle(size: .sm))
      .pageButton(
        IconButtonStyler()
            .size(CarbonTokens.sizeLarge(), CarbonTokens.sizeLarge())
            .color(const Color(0x00000000))
            .icon(
              .size(
                CarbonTokens.iconSize01(),
              ).color(CarbonTokens.iconPrimary()),
            )
            .onHovered(.color(CarbonTokens.backgroundHover()))
            .onFocusVisible(
              .border(
                BoxBorderMix.all(
                  BorderSideMix(color: CarbonTokens.focus(), width: 2),
                ),
              ),
            ),
      )
      .headerMinHeight(48)
      .rowMinHeight(48)
      .selectionColumnWidth(48)
      .sortIconSpacing(8);
}

/// Carbon API adapter over [RemixDataTable].
class CarbonDataTable<T> extends StatelessWidget {
  const CarbonDataTable({
    super.key,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowIdBuilder,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.pageIndex = 0,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50],
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minimumWidth = 0,
    this.emptyBuilder,
    this.labels = const CarbonDataTableLabels(),
  });

  final List<T> rows;
  final List<CarbonDataTableColumn<T>> columns;
  final String? semanticLabel;
  final CarbonDataTableSort? sort;
  final ValueChanged<CarbonDataTableSort>? onSortChanged;
  final Object Function(T row)? rowIdBuilder;
  final Set<Object> selectedRowIds;
  final ValueChanged<Set<Object>>? onSelectionChanged;
  final int? totalRows;
  final int pageIndex;
  final int pageSize;
  final List<int> pageSizeOptions;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onPageSizeChanged;
  final double minimumWidth;
  final WidgetBuilder? emptyBuilder;
  final CarbonDataTableLabels labels;

  @override
  Widget build(BuildContext context) => RemixDataTable<T>(
    rows: rows,
    columns: [
      for (final column in columns)
        RemixDataTableColumn<T>(
          id: column.id,
          label: column.label,
          header: column.header,
          semanticLabel: column.semanticLabel,
          width: column.width,
          alignment: switch (column.alignment) {
            .start => .start,
            .center => .center,
            .end => .end,
          },
          sortable: column.sortable,
          cellBuilder: column.cellBuilder,
        ),
    ],
    semanticLabel: semanticLabel,
    sort: sort == null
        ? null
        : RemixDataTableSort(
            columnId: sort!.columnId,
            direction: switch (sort!.direction) {
              .ascending => .ascending,
              .descending => .descending,
            },
          ),
    onSortChanged: onSortChanged == null
        ? null
        : (next) => onSortChanged!(
            CarbonDataTableSort(
              columnId: next.columnId,
              direction: next.direction == .ascending
                  ? .ascending
                  : .descending,
            ),
          ),
    rowId: rowIdBuilder,
    selectedRowIds: selectedRowIds,
    onSelectionChanged: onSelectionChanged,
    totalRows: totalRows,
    pageIndex: pageIndex,
    pageSize: pageSize,
    pageSizeOptions: pageSizeOptions,
    onPageChanged: onPageChanged,
    onPageSizeChanged: onPageSizeChanged,
    minimumWidth: minimumWidth,
    emptyBuilder: emptyBuilder,
    sortableIcon: CarbonIcons.arrowsVertical,
    sortAscendingIcon: CarbonIcons.arrowUp,
    sortDescendingIcon: CarbonIcons.arrowDown,
    previousPageIcon: CarbonIcons.caretLeft,
    nextPageIcon: CarbonIcons.caretRight,
    labels: RemixDataTableLabels(
      rowsPerPage: labels.rowsPerPage,
      previousPage: labels.previousPage,
      nextPage: labels.nextPage,
      selectAllRows: labels.selectAllRows,
      selectRow: labels.selectRow,
      sortedAscending: labels.sortedAscending,
      sortedDescending: labels.sortedDescending,
    ),
    style: carbonDataTableStyle(),
  );
}
