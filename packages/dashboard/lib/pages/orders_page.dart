import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../data/models.dart';
import '../data/orders.dart';
import '../widgets/data_grid.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_header.dart';
import '../widgets/toast.dart';

enum _OrderFilter { all, paid, pending, refunded, cancelled }

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key, this.globalQuery = ''});

  final String globalQuery;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  _OrderFilter _filter = .all;
  DataGridSort _sort = const DataGridSort('date', .descending);
  int _page = 0;
  int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final filtered = orders.where((order) {
      final statusMatches =
          _filter == .all || order.status.name == _filter.name;
      final query = widget.globalQuery.toLowerCase();
      final queryMatches = '${order.id} ${order.customer} ${order.status.name}'
          .toLowerCase()
          .contains(query);
      return statusMatches && queryMatches;
    }).toList()..sort(_compareOrders);
    final maxPage = filtered.isEmpty
        ? 0
        : (filtered.length - 1) ~/ _rowsPerPage;
    final safePage = _page.clamp(0, maxPage);
    final visible = filtered
        .skip(safePage * _rowsPerPage)
        .take(_rowsPerPage)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 20,
        children: [
          PageHeader(
            title: 'Orders',
            description: 'Review transactions and fulfillment status.',
            actions: FortalButton(
              onPressed: () =>
                  showToast(context, message: 'Order export prepared'),
              child: const Row(
                mainAxisSize: .min,
                spacing: 6,
                children: [
                  Icon(Icons.download_outlined, size: 18),
                  Text('Export'),
                ],
              ),
            ),
          ),
          Align(
            alignment: .centerLeft,
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: FortalToggleGroup<_OrderFilter>(
                semanticLabel: 'Filter orders by status',
                selectedValue: _filter,
                items: const [
                  RemixToggleGroupItem(value: .all, label: 'All'),
                  RemixToggleGroupItem(value: .paid, label: 'Paid'),
                  RemixToggleGroupItem(value: .pending, label: 'Pending'),
                  RemixToggleGroupItem(value: .refunded, label: 'Refunded'),
                  RemixToggleGroupItem(value: .cancelled, label: 'Cancelled'),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _filter = value;
                      _page = 0;
                    });
                  }
                },
              ),
            ),
          ),
          DataGrid<Order>(
            key: const ValueKey('data-grid-orders'),
            rows: visible,
            columns: _columns,
            sort: _sort,
            onSortChanged: (sort) => setState(() {
              _sort = sort;
              _page = 0;
            }),
            totalRows: filtered.length,
            page: safePage,
            rowsPerPage: _rowsPerPage,
            onPageChanged: (page) => setState(() => _page = page),
            onRowsPerPageChanged: (count) => setState(() {
              _rowsPerPage = count;
              _page = 0;
            }),
            emptyBuilder: (_) => const EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No matching orders',
              body: 'Choose another status to see more orders.',
            ),
          ),
        ],
      ),
    );
  }

  int _compareOrders(Order a, Order b) {
    final result = switch (_sort.columnId) {
      'amount' => a.amount.compareTo(b.amount),
      _ => a.date.compareTo(b.date),
    };
    return _sort.direction == .ascending ? result : -result;
  }

  List<DataGridColumn<Order>> get _columns => [
    DataGridColumn(
      id: 'id',
      label: 'Order',
      width: 120,
      cellBuilder: (_, order) => _CellText(order.id, primary: true),
    ),
    DataGridColumn(
      id: 'customer',
      label: 'Customer',
      flex: 2,
      cellBuilder: (_, order) => _CellText(order.customer, primary: true),
    ),
    DataGridColumn(
      id: 'date',
      label: 'Date',
      width: 120,
      sortable: true,
      cellBuilder: (_, order) => _CellText(_date(order.date)),
    ),
    DataGridColumn(
      id: 'amount',
      label: 'Amount',
      width: 120,
      align: .right,
      sortable: true,
      cellBuilder: (_, order) =>
          _CellText('\$${order.amount.toStringAsFixed(2)}', primary: true),
    ),
    DataGridColumn(
      id: 'status',
      label: 'Status',
      width: 118,
      cellBuilder: (_, order) => _OrderStatusBadge(order.status),
    ),
    DataGridColumn(
      id: 'actions',
      label: '',
      width: 46,
      align: .right,
      cellBuilder: (context, order) => FortalMenu<String>(
        semanticLabel: 'Actions for ${order.id}',
        trigger: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(Icons.more_horiz, size: 18),
        ),
        entries: const [
          RemixMenuAction(value: 'view', child: Text('View order')),
          RemixMenuAction(value: 'receipt', child: Text('Download receipt')),
          RemixMenuSeparator(),
          RemixMenuAction(value: 'refund', child: Text('Issue refund')),
        ],
        onSelected: (value) =>
            showToast(context, message: '$value selected for ${order.id}'),
      ),
    ),
  ];
}

class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge(this.status);
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      .paid => FortalAccentColor.green,
      .pending => FortalAccentColor.amber,
      .refunded => FortalAccentColor.red,
      .cancelled => FortalAccentColor.gray,
    };
    final label = '${status.name[0].toUpperCase()}${status.name.substring(1)}';
    return FortalBadge(color: color, child: Text(label));
  }
}

class _CellText extends StatelessWidget {
  const _CellText(this.text, {this.primary = false});
  final String text;
  final bool primary;

  @override
  Widget build(BuildContext context) => StyledText(
    text,
    style: TextStyler(style: FortalTokens.text2.mix())
        .fontWeight(primary ? .w500 : .w400)
        .color(primary ? FortalTokens.gray12() : FortalTokens.gray11())
        .maxLines(1)
        .overflow(.ellipsis),
  );
}

String _date(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[value.month - 1]} ${value.day}, ${value.year}';
}
