// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_table.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's DataTable recipe.
///
/// Remix owns the rendering, sorting, selection, pagination, the empty state,
/// and the table accessibility semantics; this recipe supplies the frame, the
/// rows, the cells, and the three text roles.
///
/// It is the one recipe in this layer that **depends on other items**, and it
/// is the reason its registry entry lists `checkbox`, `icon_button`, and
/// `select` beside `theme`. A table's selection column is a checkbox, its
/// pager is a pair of icon buttons, and its page-size control is a select —
/// literally, not by analogy. `DataTableSpec` takes each of those as a styler,
/// so the honest thing is to hand it the application's own recipes rather than
/// restate three components inside a fourth. Change the checkbox recipe and
/// this table's checkboxes change with it, which is what a reader expects.
///
/// That is a deliberate exception to the rule that these files are
/// self-contained. It earns it: the alternative is either three duplicated
/// recipes that drift, or a table whose controls do not match the rest of the
/// application.
///
/// The frame is the card's: `background` fill, `border` hairline, the theme
/// radius. Header and body rows are separated by the same hairline, and the
/// last body row drops it so the table does not draw a second line on top of
/// its own bottom edge.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundDataTable<T> extends StatelessWidget {
  const PlaygroundDataTable({
    super.key,
    this.style = const DataTableStyler.create(),
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
    this.sortableIcon,
    this.sortAscendingIcon,
    this.sortDescendingIcon,
    this.previousPageIcon,
    this.nextPageIcon,
  });

  final DataTableStyler style;

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

  final IconData? sortableIcon;

  final IconData? sortAscendingIcon;

  final IconData? sortDescendingIcon;

  final IconData? previousPageIcon;

  final IconData? nextPageIcon;

  @override
  Widget build(BuildContext context) {
    return RemixDataTable<T>(
      key: this.key,
      style: playgroundDataTableStyle(style: this.style),
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
