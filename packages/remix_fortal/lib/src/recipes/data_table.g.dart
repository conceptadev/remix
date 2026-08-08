// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_table.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal recipe for [RemixDataTable].
///
/// Sizes and variants map `@radix-ui/themes@3.3.0` `table.css` exactly: cell
/// padding, minimum cell height, typography, radius, the `gray-a5` row
/// divider, bold column headers, the surface panel/border, the `gray-a2`
/// header background, and the suppressed divider under a surface table's last
/// row.
///
/// Sorting, selection, pagination, and row hover have no Radix counterpart —
/// Radix's Table is a passive layout. They are Fortal extensions built from
/// existing accent/gray control tokens and are recorded as extensions in the
/// parity manifest.
class FortalDataTable<T> extends StatelessWidget {
  const FortalDataTable({
    super.key,
    this.size = .size2,
    this.variant = .ghost,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
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
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  });

  const FortalDataTable.surface({
    super.key,
    this.size = .size2,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
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
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  }) : variant = FortalDataTableVariant.surface;

  const FortalDataTable.ghost({
    super.key,
    this.size = .size2,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
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
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.sortableIcon = Icons.unfold_more,
    this.sortAscendingIcon = Icons.keyboard_arrow_up,
    this.sortDescendingIcon = Icons.keyboard_arrow_down,
    this.previousPageIcon = Icons.chevron_left,
    this.nextPageIcon = Icons.chevron_right,
  }) : variant = FortalDataTableVariant.ghost;

  final FortalDataTableSize size;

  final FortalDataTableVariant variant;

  final List<T> rows;

  final List<RemixDataTableColumn<T>> columns;

  final String? semanticLabel;

  final RemixDataTableSort? sort;

  final ValueChanged<RemixDataTableSort>? onSortChanged;

  final Object Function(T row)? rowId;

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

  final RemixDataTableLabels labels;

  final RemixDataTablePageRangeFormatter pageRangeFormatter;

  final IconData sortableIcon;

  final IconData sortAscendingIcon;

  final IconData sortDescendingIcon;

  final IconData previousPageIcon;

  final IconData nextPageIcon;

  @override
  Widget build(BuildContext context) {
    return RemixDataTable<T>(
      key: this.key,
      style: fortalDataTableStyle(size: this.size, variant: this.variant),
      rows: this.rows,
      columns: this.columns,
      semanticLabel: this.semanticLabel,
      sort: this.sort,
      onSortChanged: this.onSortChanged,
      rowId: this.rowId,
      selectedRowIds: this.selectedRowIds,
      onSelectionChanged: this.onSelectionChanged,
      totalRows: this.totalRows,
      pageIndex: this.pageIndex,
      pageSize: this.pageSize,
      pageSizeOptions: this.pageSizeOptions,
      onPageChanged: this.onPageChanged,
      onPageSizeChanged: this.onPageSizeChanged,
      minimumWidth: this.minimumWidth,
      emptyBuilder: this.emptyBuilder,
      labels: this.labels,
      pageRangeFormatter: this.pageRangeFormatter,
      sortableIcon: this.sortableIcon,
      sortAscendingIcon: this.sortAscendingIcon,
      sortDescendingIcon: this.sortDescendingIcon,
      previousPageIcon: this.previousPageIcon,
      nextPageIcon: this.nextPageIcon,
    );
  }
}
