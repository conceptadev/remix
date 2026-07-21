import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import 'empty_state.dart';

enum DataGridSortDirection { ascending, descending }

class DataGridSort {
  const DataGridSort(this.columnId, this.direction);

  final String columnId;
  final DataGridSortDirection direction;
}

class DataGridColumn<T> {
  const DataGridColumn({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.width,
    this.flex = 1,
    this.align = .left,
    this.sortable = false,
  }) : assert(width != null || flex > 0);

  final String id;
  final String label;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final double? width;
  final int flex;
  final TextAlign align;
  final bool sortable;
}

class DataGrid<T> extends StatelessWidget {
  const DataGrid({
    super.key,
    required this.rows,
    required this.columns,
    this.sort,
    this.onSortChanged,
    this.rowId,
    this.selectedIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.page = 0,
    this.rowsPerPage = 10,
    this.onPageChanged,
    this.onRowsPerPageChanged,
    this.minimumWidth = 840,
    this.emptyBuilder,
  });

  final List<T> rows;
  final List<DataGridColumn<T>> columns;
  final DataGridSort? sort;
  final ValueChanged<DataGridSort>? onSortChanged;
  final String Function(T row)? rowId;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>>? onSelectionChanged;
  final int? totalRows;
  final int page;
  final int rowsPerPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onRowsPerPageChanged;
  final double minimumWidth;
  final WidgetBuilder? emptyBuilder;

  bool get _selectable => rowId != null && onSelectionChanged != null;

  @override
  Widget build(BuildContext context) {
    final border = MixScope.tokenOf(FortalTokens.grayA5, context);
    final radius = MixScope.tokenOf(FortalTokens.radius4, context);
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: MixScope.tokenOf(FortalTokens.colorPanelSolid, context),
        border: Border.all(color: border),
        borderRadius: BorderRadius.all(radius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = math.max(minimumWidth, constraints.maxWidth);
          return SingleChildScrollView(
            scrollDirection: .horizontal,
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisSize: .min,
                children: [
                  _buildHeader(context),
                  if (rows.isEmpty)
                    (emptyBuilder?.call(context) ??
                        const EmptyState(
                          icon: Icons.search_off_outlined,
                          title: 'No results found',
                          body: 'Try changing your filters or search query.',
                        ))
                  else
                    SizedBox(
                      height: rows.length * 48,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rows.length,
                        itemBuilder: (context, index) => _DataGridRow<T>(
                          row: rows[index],
                          columns: columns,
                          selectable: _selectable,
                          selected:
                              _selectable &&
                              selectedIds.contains(rowId!(rows[index])),
                          onSelected: _selectable
                              ? (selected) => _toggleRow(rows[index], selected)
                              : null,
                        ),
                      ),
                    ),
                  if (totalRows != null) _buildFooter(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final rowIds = rowId == null ? const <String>[] : rows.map(rowId!).toList();
    final selectedOnPage = rowIds.where(selectedIds.contains).length;
    final selectedValue = selectedOnPage == 0
        ? false
        : selectedOnPage == rowIds.length
        ? true
        : null;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: MixScope.tokenOf(FortalTokens.grayA2, context),
        border: Border(
          bottom: BorderSide(
            color: MixScope.tokenOf(FortalTokens.grayA6, context),
          ),
        ),
      ),
      child: Row(
        children: [
          if (_selectable)
            SizedBox(
              width: 42,
              child: FortalCheckbox(
                key: const ValueKey('grid-select-all'),
                size: .size1,
                selected: selectedValue,
                tristate: true,
                semanticLabel: 'Select all rows',
                onChanged: (_) => _toggleAll(
                  select: selectedOnPage != rowIds.length,
                  rowIds: rowIds,
                ),
              ),
            ),
          for (final column in columns)
            _ColumnSlot(
              width: column.width,
              flex: column.flex,
              align: column.align,
              child: column.sortable
                  ? FortalButton(
                      key: ValueKey('sort-${column.id}'),
                      variant: .ghost,
                      size: .size1,
                      onPressed: () => _sortBy(column.id),
                      child: Row(
                        mainAxisSize: .min,
                        spacing: 3,
                        children: [
                          Text(column.label),
                          Icon(
                            sort?.columnId == column.id
                                ? sort!.direction == .ascending
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down
                                : Icons.unfold_more,
                            size: 14,
                          ),
                        ],
                      ),
                    )
                  : StyledText(
                      column.label,
                      style: TextStyler(
                        style: FortalTokens.text1.mix(),
                      ).fontWeight(.w600).color(FortalTokens.gray11()),
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final total = totalRows!;
    final start = total == 0 ? 0 : page * rowsPerPage + 1;
    final end = math.min((page + 1) * rowsPerPage, total);
    final maxPage = total == 0 ? 0 : (total - 1) ~/ rowsPerPage;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MixScope.tokenOf(FortalTokens.grayA6, context),
          ),
        ),
      ),
      child: Row(
        children: [
          StyledText(
            'Rows per page',
            style: TextStyler(
              style: FortalTokens.text1.mix(),
            ).color(FortalTokens.gray11()),
          ),
          const SizedBox(width: 8),
          FortalSelect<int>(
            size: .size1,
            triggerVariant: .ghost,
            trigger: const RemixSelectTrigger(placeholder: '10'),
            entries: const [
              RemixSelectItem(value: 5, label: '5'),
              RemixSelectItem(value: 10, label: '10'),
              RemixSelectItem(value: 20, label: '20'),
            ],
            selectedValue: rowsPerPage,
            onChanged: (value) {
              if (value != null) onRowsPerPageChanged?.call(value);
            },
          ),
          const Spacer(),
          StyledText(
            '$start–$end of $total',
            style: TextStyler(
              style: FortalTokens.text1.mix(),
            ).color(FortalTokens.gray11()),
          ),
          const SizedBox(width: 10),
          FortalIconButton(
            key: const ValueKey('grid-previous'),
            variant: .ghost,
            size: .size1,
            semanticLabel: 'Previous page',
            enabled: page > 0,
            onPressed: () => onPageChanged?.call(page - 1),
            child: const Icon(Icons.chevron_left),
          ),
          FortalIconButton(
            key: const ValueKey('grid-next'),
            variant: .ghost,
            size: .size1,
            semanticLabel: 'Next page',
            enabled: page < maxPage,
            onPressed: () => onPageChanged?.call(page + 1),
            child: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void _sortBy(String columnId) {
    final direction =
        sort?.columnId == columnId &&
            sort?.direction == DataGridSortDirection.ascending
        ? DataGridSortDirection.descending
        : DataGridSortDirection.ascending;
    onSortChanged?.call(DataGridSort(columnId, direction));
  }

  void _toggleRow(T row, bool selected) {
    final next = {...selectedIds};
    final id = rowId!(row);
    selected ? next.add(id) : next.remove(id);
    onSelectionChanged?.call(next);
  }

  void _toggleAll({required bool select, required List<String> rowIds}) {
    final next = {...selectedIds};
    select ? next.addAll(rowIds) : next.removeAll(rowIds);
    onSelectionChanged?.call(next);
  }
}

class _DataGridRow<T> extends StatefulWidget {
  const _DataGridRow({
    required this.row,
    required this.columns,
    required this.selectable,
    required this.selected,
    required this.onSelected,
  });

  final T row;
  final List<DataGridColumn<T>> columns;
  final bool selectable;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  State<_DataGridRow<T>> createState() => _DataGridRowState<T>();
}

class _DataGridRowState<T> extends State<_DataGridRow<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final background = widget.selected
        ? MixScope.tokenOf(
            _hovered ? FortalTokens.accentA4 : FortalTokens.accentA3,
            context,
          )
        : _hovered
        ? MixScope.tokenOf(FortalTokens.grayA3, context)
        : Colors.transparent;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: background,
          border: Border(
            bottom: BorderSide(
              color: MixScope.tokenOf(FortalTokens.grayA5, context),
            ),
          ),
        ),
        child: Row(
          children: [
            if (widget.selectable)
              SizedBox(
                width: 42,
                child: FortalCheckbox(
                  key: const ValueKey('grid-row-checkbox'),
                  size: .size1,
                  selected: widget.selected,
                  semanticLabel: 'Select row',
                  onChanged: (value) => widget.onSelected?.call(value ?? false),
                ),
              ),
            for (final column in widget.columns)
              _ColumnSlot(
                width: column.width,
                flex: column.flex,
                align: column.align,
                child: column.cellBuilder(context, widget.row),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColumnSlot extends StatelessWidget {
  const _ColumnSlot({
    required this.width,
    required this.flex,
    required this.align,
    required this.child,
  });

  final double? width;
  final int flex;
  final TextAlign align;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: align == .right
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: child,
      ),
    );
    return width == null
        ? Expanded(flex: flex, child: content)
        : SizedBox(width: width, child: content);
  }
}
