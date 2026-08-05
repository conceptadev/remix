import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

class _Member {
  const _Member(this.id, this.name, this.role, this.seats);

  final String id;
  final String name;
  final String role;
  final int seats;
}

const _members = [
  _Member('m1', 'Leo Farias', 'Owner', 12),
  _Member('m2', 'Ada Lovelace', 'Engineer', 4),
  _Member('m3', 'Grace Hopper', 'Engineer', 7),
];

Widget buildDataTableExample() => const _DataTableExample();

class _DataTableExample extends StatefulWidget {
  const _DataTableExample();

  @override
  State<_DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<_DataTableExample> {
  RemixDataTableSort _sort = const RemixDataTableSort(
    columnId: 'name',
    direction: RemixDataTableSortDirection.ascending,
  );
  Set<Object> _selected = {'m2'};
  int _pageIndex = 0;
  int _pageSize = 10;

  List<_Member> get _sorted {
    final rows = List<_Member>.of(_members);
    rows.sort((a, b) {
      final result = switch (_sort.columnId) {
        'seats' => a.seats.compareTo(b.seats),
        _ => a.name.compareTo(b.name),
      };

      return _sort.direction == RemixDataTableSortDirection.ascending
          ? result
          : -result;
    });

    return rows;
  }

  List<RemixDataTableColumn<_Member>> get _columns => [
    RemixDataTableColumn(
      id: 'name',
      label: 'Member',
      sortable: true,
      width: const FlexColumnWidth(2),
      cellBuilder: (context, row) => Text(row.name),
    ),
    RemixDataTableColumn(
      id: 'role',
      label: 'Role',
      width: const FixedColumnWidth(120),
      cellBuilder: (context, row) => FortalBadge(label: row.role),
    ),
    RemixDataTableColumn(
      id: 'seats',
      label: 'Seats',
      sortable: true,
      width: const FixedColumnWidth(96),
      alignment: RemixDataTableCellAlignment.end,
      cellBuilder: (context, row) => Text('${row.seats}'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 900,
      child: ComparisonView(
        remix: [
          // Sortable, selectable, and paginated: every operation stays a
          // controlled signal owned by this widget's state.
          SizedBox(
            width: 460,
            child: FortalDataTable<_Member>.surface(
              semanticLabel: 'Workspace members',
              rows: _sorted,
              columns: _columns,
              sort: _sort,
              onSortChanged: (sort) => setState(() => _sort = sort),
              rowId: (row) => row.id,
              selectedRowIds: _selected,
              onSelectionChanged: (ids) => setState(() => _selected = ids),
              totalRows: _members.length,
              pageIndex: _pageIndex,
              pageSize: _pageSize,
              pageSizeOptions: const [5, 10, 20],
              onPageChanged: (index) => setState(() => _pageIndex = index),
              onPageSizeChanged: (size) => setState(() {
                _pageSize = size;
                _pageIndex = 0;
              }),
            ),
          ),
          // Ghost keeps every divider and drops the panel surface.
          SizedBox(
            width: 460,
            child: FortalDataTable<_Member>.ghost(
              size: .size1,
              semanticLabel: 'Compact members',
              rows: _sorted,
              columns: _columns,
            ),
          ),
          // The empty state replaces body rows and keeps the header.
          SizedBox(
            width: 460,
            child: FortalDataTable<_Member>.surface(
              semanticLabel: 'No members',
              rows: const [],
              columns: _columns,
              emptyBuilder: (context) => const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No members match this filter'),
              ),
            ),
          ),
          // Directional alignment follows Directionality, not a locale guess.
          SizedBox(
            width: 460,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: FortalDataTable<_Member>.surface(
                semanticLabel: 'أعضاء',
                rows: _sorted,
                columns: _columns,
              ),
            ),
          ),
        ],
        material: [
          SizedBox(
            width: 380,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Member')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Seats'), numeric: true),
              ],
              rows: [
                for (final member in _members)
                  DataRow(
                    cells: [
                      DataCell(Text(member.name)),
                      DataCell(Text(member.role)),
                      DataCell(Text('${member.seats}')),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
