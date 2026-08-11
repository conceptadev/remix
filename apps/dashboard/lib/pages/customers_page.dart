import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../data/customers.dart';
import '../data/models.dart';
import '../utils/date_format.dart';
import '../utils/pagination.dart';
import '../widgets/action_popover.dart';
import '../widgets/data_table_cell_text.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_header.dart';
import '../widgets/status_badge.dart';
import '../widgets/toast.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key, this.globalQuery = ''});

  final String globalQuery;

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  String _query = '';
  RemixDataTableSort _sort = const RemixDataTableSort(
    columnId: 'joined',
    direction: .descending,
  );
  Set<Object> _selectedIds = {};
  int _page = 0;
  int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final globalQuery = widget.globalQuery.toLowerCase();
    final filtered = customers.where((customer) {
      final haystack = '${customer.name} ${customer.email} ${customer.plan}'
          .toLowerCase();
      return haystack.contains(_query) && haystack.contains(globalQuery);
    }).toList();
    filtered.sort(_compareCustomers);
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
            title: 'Customers',
            description: 'Manage customer access, plans, and account status.',
            actions: FortalButton(
              onPressed: () =>
                  showToast(context, message: 'Customer invitation started'),
              label: 'Add customer',
              leadingIcon: Icons.add,
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final search = SizedBox(
                width: constraints.maxWidth < 320 ? constraints.maxWidth : 300,
                child: FortalTextField(
                  key: const ValueKey('customer-search'),
                  leading: const Icon(Icons.search, size: 18),
                  hintText: 'Search customers…',
                  onChanged: (value) => setState(() {
                    _query = value.trim().toLowerCase();
                    _page = 0;
                  }),
                ),
              );
              final selection = _selectedIds.isEmpty
                  ? null
                  : Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FortalBadge(
                          size: .size2,
                          label: '${_selectedIds.length} selected',
                        ),
                        FortalButton.ghost(
                          size: .size1,
                          onPressed: () => showToast(
                            context,
                            message:
                                'Export prepared for ${_selectedIds.length} customers',
                          ),
                          label: 'Export',
                        ),
                        FortalButton.ghost(
                          size: .size1,
                          onPressed: () => showToast(
                            context,
                            message:
                                '${_selectedIds.length} customers archived',
                            actionLabel: 'Undo',
                          ),
                          label: 'Archive',
                        ),
                      ],
                    );
              if (constraints.maxWidth < 700) {
                return Column(
                  crossAxisAlignment: .start,
                  spacing: 10,
                  children: [search, ?selection],
                );
              }
              return Row(children: [search, const Spacer(), ?selection]);
            },
          ),
          FortalDataTable<Customer>.surface(
            key: const ValueKey('data-grid-customers'),
            rows: visible,
            columns: _columns,
            semanticLabel: 'Customers',
            minimumWidth: 840,
            sort: _sort,
            onSortChanged: (sort) => setState(() {
              _sort = sort;
              _page = 0;
            }),
            rowId: (customer) => customer.id,
            selectedRowIds: _selectedIds,
            onSelectionChanged: (ids) => setState(() => _selectedIds = ids),
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
              icon: Icons.person_search_outlined,
              title: 'No customers found',
              body: 'Try a different name or email address.',
            ),
          ),
        ],
      ),
    );
  }

  int _compareCustomers(Customer a, Customer b) {
    final result = switch (_sort.columnId) {
      'name' => a.name.compareTo(b.name),
      _ => a.joinedAt.compareTo(b.joinedAt),
    };
    return _sort.direction == .ascending ? result : -result;
  }

  List<RemixDataTableColumn<Customer>> get _columns => [
    RemixDataTableColumn(
      id: 'name',
      label: 'Customer',
      sortable: true,
      width: const FlexColumnWidth(2),
      cellBuilder: (context, customer) => Row(
        mainAxisSize: .min,
        spacing: 9,
        children: [
          FortalAvatar(size: .size2, label: customer.initials),
          Flexible(child: DataTableCellText(customer.name, primary: true)),
        ],
      ),
    ),
    RemixDataTableColumn(
      id: 'email',
      label: 'Email',
      width: const FlexColumnWidth(2),
      cellBuilder: (_, customer) => DataTableCellText(customer.email),
    ),
    RemixDataTableColumn(
      id: 'plan',
      label: 'Plan',
      width: const FixedColumnWidth(110),
      cellBuilder: (_, customer) =>
          DataTableCellText(customer.plan, primary: true),
    ),
    RemixDataTableColumn(
      id: 'status',
      label: 'Status',
      width: const FixedColumnWidth(110),
      cellBuilder: (_, customer) => StatusBadge.customer(customer.status),
    ),
    RemixDataTableColumn(
      id: 'joined',
      label: 'Joined',
      sortable: true,
      width: const FixedColumnWidth(118),
      cellBuilder: (_, customer) =>
          DataTableCellText(formatShortDate(customer.joinedAt)),
    ),
    RemixDataTableColumn(
      id: 'actions',
      header: const SizedBox.shrink(),
      semanticLabel: 'Actions',
      width: const FixedColumnWidth(64),
      alignment: .end,
      cellBuilder: (context, customer) => DashboardActionPopover(
        key: ValueKey('customer-actions-${customer.id}'),
        semanticLabel: 'Actions for ${customer.name}',
        positioning: dataTableActionsPositioning,
        trigger: dataTableActionsTrigger,
        actions: const [
          DashboardAction(value: 'view', label: 'View profile'),
          DashboardAction(value: 'email', label: 'Send email'),
          DashboardAction(
            value: 'archive',
            label: 'Archive',
            dividerBefore: true,
          ),
        ],
        onSelected: (value) =>
            showToast(context, message: '$value selected for ${customer.name}'),
      ),
    ),
  ];
}
