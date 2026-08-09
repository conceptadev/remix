import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../data/models.dart';
import '../data/orders.dart';
import '../utils/date_format.dart';
import '../utils/pagination.dart';
import '../widgets/action_popover.dart';
import '../widgets/data_table_cell_text.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_header.dart';
import '../widgets/status_badge.dart';
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
  RemixDataTableSort _sort = const RemixDataTableSort(
    columnId: 'date',
    direction: .descending,
  );
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
    final (page: safePage, items: visible) = paginate(
      filtered,
      page: _page,
      rowsPerPage: _rowsPerPage,
    );

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
              label: 'Export',
              leadingIcon: Icons.download_outlined,
            ),
          ),
          Align(
            alignment: .centerLeft,
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: FortalSegmentedControl<_OrderFilter>(
                semanticLabel: 'Filter orders by status',
                selectedValue: _filter,
                items: const [
                  RemixSegmentedControlItem(value: .all, label: 'All'),
                  RemixSegmentedControlItem(value: .paid, label: 'Paid'),
                  RemixSegmentedControlItem(value: .pending, label: 'Pending'),
                  RemixSegmentedControlItem(
                    value: .refunded,
                    label: 'Refunded',
                  ),
                  RemixSegmentedControlItem(
                    value: .cancelled,
                    label: 'Cancelled',
                  ),
                ],
                onChanged: (value) => setState(() {
                  _filter = value;
                  _page = 0;
                }),
              ),
            ),
          ),
          FortalDataTable<Order>.surface(
            key: const ValueKey('data-grid-orders'),
            rows: visible,
            columns: _columns,
            semanticLabel: 'Orders',
            minimumWidth: 840,
            sort: _sort,
            onSortChanged: (sort) => setState(() {
              _sort = sort;
              _page = 0;
            }),
            totalRows: filtered.length,
            pageIndex: safePage,
            pageSize: _rowsPerPage,
            pageSizeOptions: const [5, 10, 20],
            onPageChanged: (page) => setState(() => _page = page),
            onPageSizeChanged: (count) => setState(() {
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

  List<RemixDataTableColumn<Order>> get _columns => [
    RemixDataTableColumn(
      id: 'id',
      label: 'Order',
      width: const FixedColumnWidth(120),
      cellBuilder: (_, order) => DataTableCellText(order.id, primary: true),
    ),
    RemixDataTableColumn(
      id: 'customer',
      label: 'Customer',
      width: const FlexColumnWidth(2),
      cellBuilder: (_, order) =>
          DataTableCellText(order.customer, primary: true),
    ),
    RemixDataTableColumn(
      id: 'date',
      label: 'Date',
      width: const FixedColumnWidth(120),
      sortable: true,
      cellBuilder: (_, order) => DataTableCellText(formatShortDate(order.date)),
    ),
    RemixDataTableColumn(
      id: 'amount',
      label: 'Amount',
      width: const FixedColumnWidth(120),
      alignment: .end,
      sortable: true,
      cellBuilder: (_, order) => DataTableCellText(
        '\$${order.amount.toStringAsFixed(2)}',
        primary: true,
      ),
    ),
    RemixDataTableColumn(
      id: 'status',
      label: 'Status',
      width: const FixedColumnWidth(118),
      cellBuilder: (_, order) => StatusBadge.order(order.status),
    ),
    RemixDataTableColumn(
      id: 'actions',
      header: const SizedBox.shrink(),
      semanticLabel: 'Actions',
      width: const FixedColumnWidth(64),
      alignment: .end,
      cellBuilder: (context, order) => DashboardActionPopover(
        key: ValueKey('order-actions-${order.id}'),
        semanticLabel: 'Actions for ${order.id}',
        positioning: dataTableActionsPositioning,
        trigger: dataTableActionsTrigger,
        actions: const [
          DashboardAction(value: 'view', label: 'View order'),
          DashboardAction(value: 'receipt', label: 'Download receipt'),
          DashboardAction(
            value: 'refund',
            label: 'Issue refund',
            dividerBefore: true,
          ),
        ],
        onSelected: (value) =>
            showToast(context, message: '$value selected for ${order.id}'),
      ),
    ),
  ];
}
