part of 'data_table.dart';

/// Direction of a [RemixDataTable]'s single active sort.
enum RemixDataTableSortDirection { ascending, descending }

/// Directional placement of a column's content inside its cells.
///
/// [start] and [end] follow [Directionality]; numeric columns opt into [end]
/// explicitly rather than receiving a locale guess.
enum RemixDataTableCellAlignment { start, center, end }

/// Formats the footer's visible page range.
///
/// Receives the one-based [start] and [end] of the visible page (both zero
/// when the result set is empty) and the [total] row count.
typedef RemixDataTablePageRangeFormatter =
    String Function({required int start, required int end, required int total});

/// Default English page-range summary, e.g. `1–10 of 42`.
String remixDefaultDataTablePageRangeFormatter({
  required int start,
  required int end,
  required int total,
}) => '$start–$end of $total';

/// The column and direction a [RemixDataTable] is currently sorted by.
///
/// This is a controlled signal: the table emits a new descriptor when a
/// sortable header is activated and never reorders rows itself.
@immutable
final class RemixDataTableSort {
  const RemixDataTableSort({required this.columnId, required this.direction})
    : assert(columnId != '', 'RemixDataTableSort.columnId must be nonempty.');

  /// Identifier of the sorted [RemixDataTableColumn].
  final String columnId;

  /// Whether the column is sorted ascending or descending.
  final RemixDataTableSortDirection direction;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemixDataTableSort &&
          other.columnId == columnId &&
          other.direction == direction;

  @override
  int get hashCode => Object.hash(columnId, direction);

  @override
  String toString() => 'RemixDataTableSort($columnId, ${direction.name})';
}

/// One column shared by every row of a [RemixDataTable].
///
/// Exactly one of [label] and [header] must be provided; a custom [header]
/// additionally requires a [semanticLabel] because the header's semantics node
/// replaces the announcement of its visible content.
@immutable
final class RemixDataTableColumn<T> {
  const RemixDataTableColumn({
    required this.id,
    required this.cellBuilder,
    this.label,
    this.header,
    this.semanticLabel,
    this.width = const FlexColumnWidth(),
    this.alignment = RemixDataTableCellAlignment.start,
    this.sortable = false,
  }) : assert(id != '', 'RemixDataTableColumn.id must be nonempty.'),
       assert(
         (label == null) != (header == null),
         'Provide exactly one of label or header to RemixDataTableColumn.',
       ),
       assert(
         label != '',
         'RemixDataTableColumn.label must be nonempty when provided.',
       ),
       assert(
         semanticLabel != '',
         'RemixDataTableColumn.semanticLabel must be nonempty when provided.',
       ),
       assert(
         header == null || semanticLabel != null,
         'RemixDataTableColumn.header requires a semanticLabel: the header '
         'semantics node replaces the announcement of its visible content.',
       );

  /// Stable identifier used by sort descriptors. Unique within a table.
  final String id;

  /// Header text rendered with the table's header typography.
  final String? label;

  /// Custom header content rendered instead of [label].
  final Widget? header;

  /// Accessible name of the column header.
  ///
  /// Required with [header]; defaults to [label] otherwise.
  final String? semanticLabel;

  /// Width of this column, shared by its header and body cells.
  final TableColumnWidth width;

  /// Directional placement of this column's content.
  final RemixDataTableCellAlignment alignment;

  /// Whether activating this column's header emits a new sort descriptor.
  final bool sortable;

  /// Builds this column's cell for one row.
  final Widget Function(BuildContext context, T row) cellBuilder;

  /// Accessible name announced for this column's header.
  String get _semanticLabel => semanticLabel ?? label!;
}

/// Every built-in English string a [RemixDataTable] can announce or display.
///
/// Replacing this object keeps Remix independent of `MaterialLocalizations`;
/// combined with [RemixDataTable.pageRangeFormatter] it lets an application
/// localize the whole component without wrapping it in a Material host.
@immutable
final class RemixDataTableLabels {
  const RemixDataTableLabels({
    this.rowsPerPage = 'Rows per page',
    this.previousPage = 'Previous page',
    this.nextPage = 'Next page',
    this.selectAllRows = 'Select all rows on this page',
    this.selectRow = 'Select row',
    this.sortedAscending = 'sorted ascending',
    this.sortedDescending = 'sorted descending',
  });

  /// Visible label preceding the page-size select.
  final String rowsPerPage;

  /// Accessible name of the previous-page button.
  final String previousPage;

  /// Accessible name of the next-page button.
  final String nextPage;

  /// Accessible name of the header select-all checkbox.
  final String selectAllRows;

  /// Accessible name of a body row's selection checkbox.
  final String selectRow;

  /// Announced sort state of an ascending sortable header.
  final String sortedAscending;

  /// Announced sort state of a descending sortable header.
  final String sortedDescending;
}

/// A controlled table that compares many records under shared column headers.
///
/// The table renders one bounded page of [rows] using Flutter's core [Table],
/// so every row negotiates the same column widths and the native
/// table/row/cell semantics roles are produced by the framework itself.
///
/// ## Controlled signals
///
/// Sorting, selection, and pagination are signals, not behavior. Remix never
/// fetches, filters, sorts, or slices caller data: [rows] is already the
/// current page in its final order, and the table only reports the intent to
/// change sort, selection, or page.
///
/// - Sorting is active when a column sets `sortable: true` and
///   [onSortChanged] is supplied. Activating the header cycles
///   ascending/descending and emits a new [RemixDataTableSort].
/// - Selection is active when both [rowId] and [onSelectionChanged] are
///   supplied. Select-all is scoped to the visible page and preserves
///   selections made on other pages.
/// - Pagination is active when [totalRows], [onPageChanged], and
///   [onPageSizeChanged] are all supplied.
///
/// ## Layout contract
///
/// Horizontal scrolling belongs to this widget: under a bounded width the
/// table is laid out at `max(minimumWidth, availableWidth)` inside a
/// horizontal viewport, so flex columns never resolve against unbounded
/// constraints. Vertical scrolling, sticky headers, and viewport height stay
/// with the parent. The pagination footer stays pinned to the visible width
/// while the header and body scroll.
///
/// ## Example
///
/// ```dart
/// RemixDataTable<Customer>(
///   rows: page,
///   columns: [
///     RemixDataTableColumn(
///       id: 'name',
///       label: 'Name',
///       sortable: true,
///       cellBuilder: (context, row) => Text(row.name),
///     ),
///   ],
///   sort: sort,
///   onSortChanged: (value) => setState(() => sort = value),
/// )
/// ```
///
/// See also:
///
/// - [RemixDataList], which describes *one* record as label/value metadata.
///   DataTable compares *many* records under shared column headers.
// Deliberate: Flutter's core `Table` is the layout and semantics authority
// here. It is the one primitive that negotiates a single column-width map
// across every row, and `RenderTable` already emits the table/row/cell role
// hierarchy that `SemanticsRole` validation requires. It lays out every row it
// is given, which is exactly right because callers own pagination and
// virtualization is out of scope.
class RemixDataTable<T> extends StatelessWidget {
  const RemixDataTable({
    super.key,
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
    this.style = const DataTableStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = DataTableStyler.new;

  /// The rows of the current page, already sorted and sliced by the caller.
  final List<T> rows;

  /// The columns shared by the header and every row. Ids are unique.
  final List<RemixDataTableColumn<T>> columns;

  /// Optional accessible name for the table itself.
  final String? semanticLabel;

  /// The active sort descriptor, or null when the table is unsorted.
  final RemixDataTableSort? sort;

  /// Called with the next descriptor when a sortable header is activated.
  final ValueChanged<RemixDataTableSort>? onSortChanged;

  /// Derives a stable, value-equal identity for a row.
  ///
  /// Keyed by [Object] so callers choose any value-equal key without a second
  /// type parameter.
  final Object Function(T row)? rowId;

  /// Ids of the currently selected rows, including rows on other pages.
  final Set<Object> selectedRowIds;

  /// Called with a fresh unmodifiable id set when selection changes.
  final ValueChanged<Set<Object>>? onSelectionChanged;

  /// Total number of rows across all pages.
  final int? totalRows;

  /// Zero-based index of the visible page.
  final int pageIndex;

  /// Number of rows per page. Must be one of [pageSizeOptions].
  final int pageSize;

  /// Page sizes offered by the footer's select. Unique and positive.
  final List<int> pageSizeOptions;

  /// Called with the next page index.
  final ValueChanged<int>? onPageChanged;

  /// Called with the next page size.
  final ValueChanged<int>? onPageSizeChanged;

  /// Lower bound of the laid-out table width before horizontal scrolling.
  final double minimumWidth;

  /// Replaces the body rows when [rows] is empty.
  ///
  /// The column header and the optional pagination footer are preserved.
  final WidgetBuilder? emptyBuilder;

  /// Every built-in string the table displays or announces.
  final RemixDataTableLabels labels;

  /// Formats the footer's visible page range.
  final RemixDataTablePageRangeFormatter pageRangeFormatter;

  /// Indicator shown on a sortable column that is not the active sort.
  final IconData? sortableIcon;

  /// Indicator shown on the ascending active sort column.
  final IconData? sortAscendingIcon;

  /// Indicator shown on the descending active sort column.
  final IconData? sortDescendingIcon;

  /// Icon of the previous-page button. Mirrored with [nextPageIcon] in RTL.
  final IconData? previousPageIcon;

  /// Icon of the next-page button. Mirrored with [previousPageIcon] in RTL.
  final IconData? nextPageIcon;

  /// The style configuration for the table.
  final DataTableStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final DataTableSpec? styleSpec;

  bool get _selectable => rowId != null && onSelectionChanged != null;

  bool get _paginated =>
      totalRows != null && onPageChanged != null && onPageSizeChanged != null;

  @override
  Widget build(BuildContext context) {
    // One immutable snapshot per build: the const constructor cannot copy, so
    // this is where the "callers must not mutate during build" contract is
    // enforced for everything rendered below.
    final visibleRows = List<T>.unmodifiable(rows);
    final tableColumns = List<RemixDataTableColumn<T>>.unmodifiable(columns);
    final selection = Set<Object>.unmodifiable(selectedRowIds);
    final sizeOptions = List<int>.unmodifiable(pageSizeOptions);
    final rowIds = _resolveRowIds(visibleRows);

    assert(_debugValidateColumns(tableColumns));
    assert(_debugValidateSelection(rowIds));
    assert(_debugValidatePagination(sizeOptions));
    assert(
      semanticLabel == null || semanticLabel!.trim().isNotEmpty,
      'RemixDataTable.semanticLabel must not be blank when provided: it '
      'becomes the accessible name of the table.',
    );
    assert(
      minimumWidth >= 0 && minimumWidth.isFinite,
      'RemixDataTable.minimumWidth must be a finite non-negative value.',
    );

    // StyleBuilder merges StyleProvider-inherited styles into the resolved
    // spec; merge them here too so per-row re-resolution sees the same
    // widget-state variants. Other Style subtypes (IdentityStyle) carry no
    // props to re-resolve and are already represented in the spec fallback.
    final inherited = Style.maybeOf<DataTableSpec>(context);
    final effectiveStyler = inherited is DataTableStyler
        ? inherited.merge(style)
        : style;

    return RemixStyleSpecBuilder<DataTableSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) => _RemixDataTableView<T>(
        table: this,
        rows: visibleRows,
        columns: tableColumns,
        rowIds: rowIds,
        selectedRowIds: selection,
        pageSizeOptions: sizeOptions,
        // A supplied raw spec has no styler to re-resolve per row, so the
        // table-level values are the final ones in that path.
        styles: _DataTableStyles(
          styler: styleSpec == null ? effectiveStyler : null,
          spec: spec,
        ),
      ),
    );
  }

  /// Row identities for the visible page, or null when selection is disabled.
  List<Object>? _resolveRowIds(List<T> visibleRows) {
    final resolve = rowId;
    if (!_selectable || resolve == null) return null;

    return List<Object>.unmodifiable(visibleRows.map(resolve));
  }

  bool _debugValidateColumns(List<RemixDataTableColumn<T>> tableColumns) {
    assert(
      tableColumns.isNotEmpty,
      'RemixDataTable.columns must not be empty.',
    );
    final ids = <String>{};
    for (final column in tableColumns) {
      assert(
        column.id.trim().isNotEmpty,
        'RemixDataTableColumn.id must not be blank.',
      );
      assert(
        ids.add(column.id),
        'RemixDataTable.columns contains duplicate id "${column.id}".',
      );
      assert(
        column._semanticLabel.trim().isNotEmpty,
        'RemixDataTableColumn "${column.id}" must expose a nonblank '
        'accessible header name.',
      );
      assert(
        !column.sortable || onSortChanged != null,
        'RemixDataTableColumn "${column.id}" is sortable but '
        'RemixDataTable.onSortChanged is null, so activating its header '
        'could not report anything.',
      );
    }
    final descriptor = sort;
    if (descriptor != null) {
      final target = tableColumns
          .where((column) => column.id == descriptor.columnId)
          .firstOrNull;
      assert(
        target != null,
        'RemixDataTable.sort names column "${descriptor.columnId}", which is '
        'not one of the supplied columns.',
      );
      assert(
        target == null || target.sortable,
        'RemixDataTable.sort names column "${descriptor.columnId}", which is '
        'not sortable.',
      );
    }

    return true;
  }

  bool _debugValidateSelection(List<Object>? rowIds) {
    assert(
      (rowId == null) == (onSelectionChanged == null),
      'RemixDataTable selection requires both rowId and onSelectionChanged, '
      'or neither. Supplying one alone cannot produce partial behavior.',
    );
    if (rowIds == null) return true;
    final seen = <Object>{};
    for (final id in rowIds) {
      assert(
        id != '',
        'RemixDataTable.rowId must not return an empty identity.',
      );
      assert(
        seen.add(id),
        'RemixDataTable.rowId produced duplicate identity "$id" on the '
        'visible page.',
      );
    }

    return true;
  }

  bool _debugValidatePagination(List<int> sizeOptions) {
    final total = totalRows;
    assert(
      (total == null) == (onPageChanged == null) &&
          (total == null) == (onPageSizeChanged == null),
      'RemixDataTable pagination requires totalRows, onPageChanged, and '
      'onPageSizeChanged together, or none of them.',
    );
    if (total == null) return true;
    assert(total >= 0, 'RemixDataTable.totalRows must not be negative.');
    assert(pageSize > 0, 'RemixDataTable.pageSize must be positive.');
    assert(
      rows.length <= pageSize,
      'RemixDataTable.rows has ${rows.length} rows, which exceeds pageSize '
      '($pageSize): rows must be exactly the visible page.',
    );
    assert(
      sizeOptions.isNotEmpty && sizeOptions.every((option) => option > 0),
      'RemixDataTable.pageSizeOptions must be nonempty and positive.',
    );
    assert(
      sizeOptions.toSet().length == sizeOptions.length,
      'RemixDataTable.pageSizeOptions must not contain duplicates.',
    );
    assert(
      sizeOptions.contains(pageSize),
      'RemixDataTable.pageSize ($pageSize) must be one of pageSizeOptions '
      '($sizeOptions).',
    );
    assert(pageIndex >= 0, 'RemixDataTable.pageIndex must not be negative.');
    assert(
      pageIndex == 0 || pageIndex <= (total - 1) ~/ pageSize,
      'RemixDataTable.pageIndex ($pageIndex) is past the last page for '
      '$total rows at $pageSize per page.',
    );

    return true;
  }
}

/// Style inputs for one table: the resolved table-level spec plus the styler
/// that per-row regions re-resolve against their own widget states.
@immutable
class _DataTableStyles {
  const _DataTableStyles({required this.styler, required this.spec});

  /// Null when the caller supplied a raw [DataTableSpec], which carries no
  /// variants to re-resolve.
  final DataTableStyler? styler;

  /// Values resolved once, outside any row's widget-state scope.
  final DataTableSpec spec;

  /// Resolves [prop] in [context] so widget-state variants see the row's
  /// states, falling back to the table-level value when there is no styler.
  V _resolve<V>(BuildContext context, Prop<V>? prop, V fallback) {
    if (styler == null || prop == null) return fallback;

    return MixOps.resolve(context, prop) ?? fallback;
  }

  StyleSpec<BoxSpec> headerRow(BuildContext context) =>
      _resolve(context, styler?.$headerRow, spec.headerRow);

  /// The final row merges [DataTableSpec.lastBodyRow] over the shared row
  /// chrome; every other row uses the shared chrome alone.
  StyleSpec<BoxSpec> bodyRow(BuildContext context, {required bool isLast}) {
    if (!isLast) return _resolve(context, styler?.$bodyRow, spec.bodyRow);

    return _resolve(
      context,
      MixOps.merge(styler?.$bodyRow, styler?.$lastBodyRow),
      spec.lastBodyRow ?? spec.bodyRow,
    );
  }

  StyleSpec<BoxSpec> headerCell(BuildContext context) =>
      _resolve(context, styler?.$headerCell, spec.headerCell);

  StyleSpec<BoxSpec> bodyCell(BuildContext context) =>
      _resolve(context, styler?.$bodyCell, spec.bodyCell);

  StyleSpec<BoxSpec> selectionCell(BuildContext context) =>
      _resolve(context, styler?.$selectionCell, spec.selectionCell);

  StyleSpec<TextSpec> headerLabel(BuildContext context) =>
      _resolve(context, styler?.$headerLabel, spec.headerLabel);

  StyleSpec<TextSpec> cellText(BuildContext context) =>
      _resolve(context, styler?.$cellText, spec.cellText);

  StyleSpec<IconSpec> sortIcon(BuildContext context) =>
      _resolve(context, styler?.$sortIcon, spec.sortIcon);
}

/// Renders one table: header, body, optional empty surface, optional footer.
///
/// Stateful because row hover is shared by every cell of a row. Flutter's
/// [Table] has no per-row widget to host a [MouseRegion], so each cell reports
/// its row index here and the whole body repaints with the new row states.
class _RemixDataTableView<T> extends StatefulWidget {
  const _RemixDataTableView({
    required this.table,
    required this.rows,
    required this.columns,
    required this.rowIds,
    required this.selectedRowIds,
    required this.pageSizeOptions,
    required this.styles,
  });

  /// The originating widget, consulted for its scalar fields only (sort,
  /// callbacks, labels, icons, pagination indices). Its [RemixDataTable.rows],
  /// [RemixDataTable.columns], [RemixDataTable.selectedRowIds], and
  /// [RemixDataTable.pageSizeOptions] are shadowed on purpose by the
  /// pre-normalized fields below: [RemixDataTable.build] already paid for the
  /// defensive `List.unmodifiable` copy once, so reading through [table] here
  /// instead would repeat that copy on every hover-only rebuild of this
  /// State, rather than once per rebuild of the whole table.
  final RemixDataTable<T> table;
  final List<T> rows;
  final List<RemixDataTableColumn<T>> columns;
  final List<Object>? rowIds;
  final Set<Object> selectedRowIds;
  final List<int> pageSizeOptions;
  final _DataTableStyles styles;

  @override
  State<_RemixDataTableView<T>> createState() => _RemixDataTableViewState<T>();
}

class _RemixDataTableViewState<T> extends State<_RemixDataTableView<T>> {
  int? _hoveredRow;

  @override
  void didUpdateWidget(covariant _RemixDataTableView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Hover is tracked by row index and MouseRegion.onExit does not fire for
    // a region unmounted while hovered, so new row content invalidates the
    // index. The mouse tracker re-enters the correct row on the next frame
    // when the pointer is still over one.
    if (_hoveredRow != null && !listEquals(widget.rows, oldWidget.rows)) {
      _hoveredRow = null;
    }
  }

  RemixDataTable<T> get _table => widget.table;

  bool get _selectable => _table._selectable;

  DataTableSpec get _spec => widget.styles.spec;

  void _setHoveredRow(int index, bool hovered) {
    final next = hovered ? index : (_hoveredRow == index ? null : _hoveredRow);
    if (next == _hoveredRow) return;
    setState(() => _hoveredRow = next);
  }

  void _sortBy(RemixDataTableColumn<T> column) {
    final current = _table.sort;
    final ascending =
        current == null ||
        current.columnId != column.id ||
        current.direction == RemixDataTableSortDirection.descending;
    _table.onSortChanged?.call(
      RemixDataTableSort(
        columnId: column.id,
        direction: ascending
            ? RemixDataTableSortDirection.ascending
            : RemixDataTableSortDirection.descending,
      ),
    );
  }

  void _emitSelection(Set<Object> next) {
    _table.onSelectionChanged?.call(Set<Object>.unmodifiable(next));
  }

  void _toggleRow(Object id, bool selected) {
    final next = {...widget.selectedRowIds};
    if (selected) {
      next.add(id);
    } else {
      next.remove(id);
    }
    _emitSelection(next);
  }

  /// Select-all is page scoped: it only adds or removes the visible ids and
  /// leaves selections made on other pages untouched.
  void _toggleAll(bool select) {
    final ids = widget.rowIds ?? const <Object>[];
    final next = {...widget.selectedRowIds};
    if (select) {
      next.addAll(ids);
    } else {
      next.removeAll(ids);
    }
    _emitSelection(next);
  }

  /// False, true, or null for none, all, or some of the visible ids selected.
  bool? get _selectAllValue {
    final ids = widget.rowIds ?? const <Object>[];
    if (ids.isEmpty) return false;
    final selected = ids.where(widget.selectedRowIds.contains).length;
    if (selected == 0) return false;

    return selected == ids.length ? true : null;
  }

  Map<int, TableColumnWidth> get _columnWidths {
    final offset = _selectable ? 1 : 0;

    return <int, TableColumnWidth>{
      if (_selectable)
        0: FixedColumnWidth(
          _spec.selectionColumnWidth ?? _defaultSelectionExtent,
        ),
      for (var index = 0; index < widget.columns.length; index += 1)
        index + offset: widget.columns[index].width,
    };
  }

  @override
  Widget build(BuildContext context) {
    assert(
      (_spec.selectionColumnWidth ?? 0.0) >= 0 &&
          (_spec.headerMinHeight ?? 0.0) >= 0 &&
          (_spec.rowMinHeight ?? 0.0) >= 0 &&
          (_spec.sortIconSpacing ?? 0.0) >= 0,
      'DataTableSpec dimensions must resolve to non-negative values.',
    );

    final tableContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTable(context),
        // Flutter's Table cannot span a cell across columns and its role
        // validation rejects a `row` outside a `table`, so the empty surface
        // is rendered adjacent to the header instead of inside it. Its
        // semantics stay caller-owned.
        if (widget.rows.isEmpty && _table.emptyBuilder != null)
          _table.emptyBuilder!(context),
      ],
    );

    return RemixBoxAdapter(
      styleSpec: _spec.container,
      containerEffects: _spec.containerEffects,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final available = constraints.maxWidth;
          if (!available.isFinite) {
            // Nothing to scroll inside. IntrinsicWidth gives the column a
            // finite width, so flex columns never resolve against unbounded
            // constraints and the footer still spans the table; minimumWidth
            // remains the flex target.
            return IntrinsicWidth(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: _table.minimumWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tableContent,
                    if (_table._paginated) _buildFooter(context),
                  ],
                ),
              ),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: math.max(_table.minimumWidth, available),
                  child: tableContent,
                ),
              ),
              // Deliberate: the footer is a sibling of the scroller, matching
              // PaginatedDataTable — pagination stays visible while the table
              // scrolls. Its top border spans the viewport, not the laid-out
              // table width.
              if (_table._paginated) _buildFooter(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return _DataTableLayout(
      semanticLabel: _table.semanticLabel,
      columnWidths: _columnWidths,
      textDirection: Directionality.of(context),
      children: [
        _buildHeaderRow(context),
        for (var index = 0; index < widget.rows.length; index += 1)
          _buildBodyRow(context, index),
      ],
    );
  }

  TableRow _buildHeaderRow(BuildContext context) {
    return TableRow(
      children: [
        if (_selectable)
          _DataTableHeaderCell(
            styles: widget.styles,
            minHeight: _spec.headerMinHeight,
            alignment: RemixDataTableCellAlignment.center,
            useSelectionCell: true,
            child: _checkbox(
              RemixCheckbox(
                key: const ValueKey('remix-data-table-select-all'),
                selected: _selectAllValue,
                tristate: true,
                semanticLabel: _table.labels.selectAllRows,
                minimumTapTargetSize: _selectionTargetSize(
                  _spec.headerMinHeight,
                ),
                onChanged: (_) => _toggleAll(_selectAllValue != true),
              ),
            ),
          ),
        for (final column in widget.columns)
          _DataTableHeaderCell(
            styles: widget.styles,
            minHeight: _spec.headerMinHeight,
            semanticLabel: column._semanticLabel,
            alignment: column.alignment,
            sortState: _sortStateOf(column),
            onSort: column.sortable ? () => _sortBy(column) : null,
            sortValue: _sortValueOf(column),
            child: column.header,
            label: column.label,
            sortIcons: _sortIcons,
          ),
      ],
    );
  }

  TableRow _buildBodyRow(BuildContext context, int index) {
    final row = widget.rows[index];
    final id = widget.rowIds?[index];
    final isLast = index == widget.rows.length - 1;
    final selected = id != null && widget.selectedRowIds.contains(id);
    final states = <WidgetState>{
      if (_hoveredRow == index) WidgetState.hovered,
      if (selected) WidgetState.selected,
    };

    return TableRow(
      key: id == null ? null : ValueKey<Object>(id),
      children: [
        if (_selectable)
          _DataTableBodyCell(
            styles: widget.styles,
            states: states,
            isLastRow: isLast,
            minHeight: _spec.rowMinHeight,
            useSelectionCell: true,
            onHoverChanged: (hovered) => _setHoveredRow(index, hovered),
            child: _checkbox(
              RemixCheckbox(
                selected: selected,
                semanticLabel: _table.labels.selectRow,
                minimumTapTargetSize: _selectionTargetSize(_spec.rowMinHeight),
                onChanged: (value) => _toggleRow(id!, value ?? false),
              ),
            ),
          ),
        for (final column in widget.columns)
          _DataTableBodyCell(
            styles: widget.styles,
            states: states,
            isLastRow: isLast,
            minHeight: _spec.rowMinHeight,
            alignment: column.alignment,
            onHoverChanged: (hovered) => _setHoveredRow(index, hovered),
            child: column.cellBuilder(context, row),
          ),
      ],
    );
  }

  /// Sizes a selection checkbox to its own cell.
  ///
  /// [RemixCheckbox] would otherwise apply its hardcoded 48px minimum target,
  /// which fights the table on both axes: it inflates Radix's 36px and 44px
  /// rows the moment selection is enabled, and Flutter's [Table] lays every
  /// cell out at a tight width, so a selection column narrower than 48 —
  /// anything below 100% scaling — silently clamps the target back down
  /// instead of honoring it. Matching the cell keeps the caller's row metric,
  /// never gets clamped, and still gives an unstyled table a usable control.
  Size _selectionTargetSize(double? minHeight) => Size(
    _spec.selectionColumnWidth ?? _defaultSelectionExtent,
    minHeight ?? _defaultSelectionExtent,
  );

  /// Hands a composed control its style through Mix inheritance.
  ///
  /// [StyleProvider] is how a control receives an unresolved style and still
  /// resolves it against its own widget states, which is exactly what a
  /// checkbox's checked appearance or a button's pressed appearance needs.
  Widget _inheritStyle<S extends Spec<S>>(Style<S>? style, Widget child) {
    return style == null ? child : StyleProvider<S>(style: style, child: child);
  }

  Widget _checkbox(Widget child) =>
      _inheritStyle<CheckboxSpec>(_spec.selectionCheckbox, child);

  _DataTableSortIcons get _sortIcons => (
    sortable: _table.sortableIcon,
    ascending: _table.sortAscendingIcon,
    descending: _table.sortDescendingIcon,
  );

  RemixDataTableSortDirection? _sortStateOf(RemixDataTableColumn<T> column) {
    final descriptor = _table.sort;
    if (!column.sortable || descriptor?.columnId != column.id) return null;

    return descriptor!.direction;
  }

  String? _sortValueOf(RemixDataTableColumn<T> column) {
    return switch (_sortStateOf(column)) {
      RemixDataTableSortDirection.ascending => _table.labels.sortedAscending,
      RemixDataTableSortDirection.descending => _table.labels.sortedDescending,
      null => null,
    };
  }

  Widget _buildFooter(BuildContext context) {
    final total = _table.totalRows!;
    final pageSize = _table.pageSize;
    final pageIndex = _table.pageIndex;
    // The range describes what is actually on screen, so a short final page
    // reports its real length instead of the nominal page size.
    final visible = widget.rows.length;
    final start = total == 0 || visible == 0 ? 0 : pageIndex * pageSize + 1;
    final end = start == 0 ? 0 : start + visible - 1;
    final lastPage = total == 0 ? 0 : (total - 1) ~/ pageSize;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final previousIcon = isRtl ? _table.nextPageIcon : _table.previousPageIcon;
    final nextIcon = isRtl ? _table.previousPageIcon : _table.nextPageIcon;
    final previousGlyph = isRtl
        ? RemixPathGlyph.chevronRight
        : RemixPathGlyph.chevronLeft;
    final nextGlyph = isRtl
        ? RemixPathGlyph.chevronLeft
        : RemixPathGlyph.chevronRight;

    return RowBox(
      styleSpec: _spec.footer,
      children: [
        StyledText(_table.labels.rowsPerPage, styleSpec: _spec.footerLabel),
        _inheritStyle<SelectSpec>(
          _spec.pageSizeSelect,
          RemixSelect<int>(
            key: const ValueKey('remix-data-table-page-size'),
            trigger: RemixSelectTrigger(placeholder: '$pageSize'),
            items: [
              for (final option in widget.pageSizeOptions)
                RemixSelectItem<int>(value: option, label: '$option'),
            ],
            selectedValue: pageSize,
            onChanged: (value) {
              if (value != null) _table.onPageSizeChanged?.call(value);
            },
            semanticLabel: _table.labels.rowsPerPage,
          ),
        ),
        const Spacer(),
        StyledText(
          _table.pageRangeFormatter(start: start, end: end, total: total),
          styleSpec: _spec.footerLabel,
        ),
        _inheritStyle<IconButtonSpec>(
          _spec.pageButton,
          RemixIconButton(
            key: const ValueKey('remix-data-table-previous-page'),
            // Chevrons are mirrored so "previous" always points toward the
            // start of the reading direction.
            icon: previousIcon,
            iconBuilder: previousIcon == null
                ? (context, spec, _) => RemixPathIcon(
                    glyph: previousGlyph,
                    styleSpec: StyleSpec(spec: spec),
                  )
                : null,
            semanticLabel: _table.labels.previousPage,
            enabled: pageIndex > 0,
            onPressed: () => _table.onPageChanged?.call(pageIndex - 1),
          ),
        ),
        _inheritStyle<IconButtonSpec>(
          _spec.pageButton,
          RemixIconButton(
            key: const ValueKey('remix-data-table-next-page'),
            icon: nextIcon,
            iconBuilder: nextIcon == null
                ? (context, spec, _) => RemixPathIcon(
                    glyph: nextGlyph,
                    styleSpec: StyleSpec(spec: spec),
                  )
                : null,
            semanticLabel: _table.labels.nextPage,
            enabled: pageIndex < lastPage,
            onPressed: () => _table.onPageChanged?.call(pageIndex + 1),
          ),
        ),
      ],
    );
  }
}

/// Documented layout floor for the optional selection column, on both axes.
///
/// Every other spec dimension defaults to zero, but a zero-extent selection
/// cell would leave its checkbox with no room and no hit target. This matches
/// [RemixCheckbox.minimumTapTargetSize]'s own default, so an unstyled table
/// still gets a usable control. An explicit
/// [DataTableSpec.selectionColumnWidth], [DataTableSpec.headerMinHeight], or
/// [DataTableSpec.rowMinHeight] is used verbatim.
const double _defaultSelectionExtent = 48;

typedef _DataTableSortIcons = ({
  IconData? sortable,
  IconData? ascending,
  IconData? descending,
});

/// One header cell: the table's only `columnHeader` semantics node.
///
/// A labelled header owns the announcement outright and excludes its visible
/// content, so a sortable header announces its name, its role, and its sort
/// state exactly once. That is why a custom [RemixDataTableColumn.header]
/// requires a `semanticLabel`. The selection column has no label of its own
/// and instead keeps the checkbox's native semantics as an explicit child.
class _DataTableHeaderCell extends StatelessWidget {
  const _DataTableHeaderCell({
    required this.styles,
    required this.minHeight,
    this.semanticLabel,
    this.alignment = RemixDataTableCellAlignment.start,
    this.label,
    this.child,
    this.sortState,
    this.sortValue,
    this.onSort,
    this.sortIcons,
    this.useSelectionCell = false,
  });

  final _DataTableStyles styles;
  final double? minHeight;
  final String? semanticLabel;
  final RemixDataTableCellAlignment alignment;
  final String? label;
  final Widget? child;
  final RemixDataTableSortDirection? sortState;
  final String? sortValue;
  final VoidCallback? onSort;
  final _DataTableSortIcons? sortIcons;
  final bool useSelectionCell;

  Widget _buildContent(BuildContext context) {
    final headerStyle = styles.headerLabel(context);
    // A custom header inherits the header typography the way Radix cascades
    // `th` styles onto arbitrary markup, without excluding its own semantics.
    final content = child == null
        ? StyledText(label!, styleSpec: headerStyle)
        : RemixDefaultContentStyle(text: headerStyle, child: child!);
    final icons = sortIcons;
    if (onSort == null || icons == null) return content;

    final icon = switch (sortState) {
      RemixDataTableSortDirection.ascending => icons.ascending,
      RemixDataTableSortDirection.descending => icons.descending,
      null => icons.sortable,
    };
    final indicator = icon == null
        ? RemixPathIcon(
            glyph: switch (sortState) {
              RemixDataTableSortDirection.ascending => RemixPathGlyph.caretUp,
              RemixDataTableSortDirection.descending =>
                RemixPathGlyph.caretDown,
              null => RemixPathGlyph.caretSort,
            },
            styleSpec: styles.sortIcon(context),
          )
        : StyledIcon(icon: icon, styleSpec: styles.sortIcon(context));

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: styles.spec.sortIconSpacing ?? 0.0,
      children: [
        // The indicator keeps its natural size and the label yields, so a
        // narrow fixed column shrinks the text instead of overflowing.
        Flexible(child: content),
        indicator,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget cell = Builder(
      builder: (context) => _DataTableCellSurface(
        row: styles.headerRow(context),
        cell: useSelectionCell
            ? styles.selectionCell(context)
            : styles.headerCell(context),
        alignment: alignment,
        minHeight: minHeight,
        child: _buildContent(context),
      ),
    );

    if (onSort != null) {
      // Pressable supplies the hover/press/focus scope that the row and cell
      // regions above re-resolve against; its own button semantics are
      // excluded because the columnHeader node below carries the tap action.
      cell = Pressable(
        excludeFromSemantics: true,
        onPress: onSort,
        child: cell,
      );
    }

    final owned = semanticLabel != null;

    return Semantics(
      role: SemanticsRole.columnHeader,
      container: true,
      explicitChildNodes: !owned,
      excludeSemantics: owned,
      button: onSort != null,
      label: semanticLabel,
      value: sortValue,
      onTap: onSort,
      child: cell,
    );
  }
}

/// One body cell, re-resolving its row and cell regions inside the row's
/// widget-state scope.
///
/// The scope is inherited by the caller's cell content on purpose: a cell can
/// react to its row being hovered or selected. Remix controls such as
/// [RemixCheckbox] install their own scope, so their interaction visuals stay
/// driven by their own states.
class _DataTableBodyCell extends StatelessWidget {
  const _DataTableBodyCell({
    required this.styles,
    required this.states,
    required this.isLastRow,
    required this.minHeight,
    required this.onHoverChanged,
    required this.child,
    this.alignment = RemixDataTableCellAlignment.start,
    this.useSelectionCell = false,
  });

  final _DataTableStyles styles;
  final Set<WidgetState> states;
  final bool isLastRow;
  final double? minHeight;
  final ValueChanged<bool> onHoverChanged;
  final Widget child;
  final RemixDataTableCellAlignment alignment;
  final bool useSelectionCell;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) => _DataTableCellSurface(
            row: styles.bodyRow(context, isLast: isLastRow),
            cell: useSelectionCell
                ? styles.selectionCell(context)
                : styles.bodyCell(context),
            alignment: alignment,
            minHeight: minHeight,
            child: RemixDefaultContentStyle(
              text: styles.cellText(context),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// The two boxes every cell paints: row chrome outside, cell padding inside.
class _DataTableCellSurface extends StatelessWidget {
  const _DataTableCellSurface({
    required this.row,
    required this.cell,
    required this.alignment,
    required this.minHeight,
    required this.child,
  });

  final StyleSpec<BoxSpec> row;
  final StyleSpec<BoxSpec> cell;
  final RemixDataTableCellAlignment alignment;
  final double? minHeight;
  final Widget child;

  static AlignmentGeometry _alignmentOf(RemixDataTableCellAlignment value) {
    return switch (value) {
      RemixDataTableCellAlignment.start => AlignmentDirectional.centerStart,
      RemixDataTableCellAlignment.center => AlignmentDirectional.center,
      RemixDataTableCellAlignment.end => AlignmentDirectional.centerEnd,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      styleSpec: row,
      // The floor is outside the cell padding, matching Radix's border-box
      // `height: var(--table-cell-min-height)` on `.rt-TableCell`.
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight ?? 0.0),
        child: Box(
          styleSpec: cell,
          child: Align(alignment: _alignmentOf(alignment), child: child),
        ),
      ),
    );
  }
}

/// A [Table] whose semantics node also carries the table's accessible name.
///
/// Deliberate: [RenderTable] already produces the whole role hierarchy —
/// `table` on itself, synthesized `row` nodes, and a `cell` wrapper for any
/// cell that is not already a `cell` or `columnHeader`. Adding a `Semantics`
/// ancestor would insert a second node above that one, so the label is written
/// straight into the render object's own configuration instead.
class _DataTableLayout extends Table {
  _DataTableLayout({
    required this.semanticLabel,
    required super.children,
    required super.columnWidths,
    required super.textDirection,
  }) : super(
         defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
       );

  final String? semanticLabel;

  @override
  RenderTable createRenderObject(BuildContext context) {
    return _RenderDataTable(
      columns: children.isNotEmpty ? children[0].children.length : 0,
      rows: children.length,
      columnWidths: columnWidths,
      defaultColumnWidth: defaultColumnWidth,
      textDirection: textDirection ?? Directionality.of(context),
      border: border,
      configuration: createLocalImageConfiguration(context),
      defaultVerticalAlignment: defaultVerticalAlignment,
      textBaseline: textBaseline,
    )..semanticLabel = semanticLabel;
  }

  @override
  void updateRenderObject(BuildContext context, RenderTable renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _RenderDataTable).semanticLabel = semanticLabel;
  }
}

class _RenderDataTable extends RenderTable {
  _RenderDataTable({
    super.columns,
    super.rows,
    super.columnWidths,
    super.defaultColumnWidth,
    required super.textDirection,
    super.border,
    super.configuration,
    super.defaultVerticalAlignment,
    super.textBaseline,
  });

  String? _semanticLabel;
  set semanticLabel(String? value) {
    if (value == _semanticLabel) return;
    _semanticLabel = value;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    final label = _semanticLabel;
    if (label != null) {
      config
        ..label = label
        ..textDirection = textDirection;
    }
  }
}
