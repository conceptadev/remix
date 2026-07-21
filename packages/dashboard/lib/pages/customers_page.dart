import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../data/customers.dart';
import '../data/models.dart';
import '../widgets/data_grid.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_header.dart';
import '../widgets/toast.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key, this.globalQuery = ''});

  final String globalQuery;

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  String _query = '';
  DataGridSort _sort = const DataGridSort('joined', .descending);
  Set<String> _selectedIds = {};
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
    final maxPage = filtered.isEmpty
        ? 0
        : (filtered.length - 1) ~/ _rowsPerPage;
    final safePage = _page.clamp(0, maxPage);
    final start = safePage * _rowsPerPage;
    final visible = filtered.skip(start).take(_rowsPerPage).toList();

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
              child: const Row(
                mainAxisSize: .min,
                spacing: 6,
                children: [Icon(Icons.add, size: 18), Text('Add customer')],
              ),
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
                          child: Text('${_selectedIds.length} selected'),
                        ),
                        FortalButton(
                          variant: .ghost,
                          size: .size1,
                          onPressed: () => showToast(
                            context,
                            message:
                                'Export prepared for ${_selectedIds.length} customers',
                          ),
                          child: const Text('Export'),
                        ),
                        FortalButton(
                          variant: .ghost,
                          size: .size1,
                          onPressed: () => showToast(
                            context,
                            message:
                                '${_selectedIds.length} customers archived',
                            actionLabel: 'Undo',
                          ),
                          child: const Text('Archive'),
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
          DataGrid<Customer>(
            key: const ValueKey('data-grid-customers'),
            rows: visible,
            columns: _columns,
            sort: _sort,
            onSortChanged: (sort) => setState(() {
              _sort = sort;
              _page = 0;
            }),
            rowId: (customer) => customer.id,
            selectedIds: _selectedIds,
            onSelectionChanged: (ids) => setState(() => _selectedIds = ids),
            totalRows: filtered.length,
            page: safePage,
            rowsPerPage: _rowsPerPage,
            onPageChanged: (page) => setState(() => _page = page),
            onRowsPerPageChanged: (count) => setState(() {
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

  List<DataGridColumn<Customer>> get _columns => [
    DataGridColumn(
      id: 'name',
      label: 'Customer',
      sortable: true,
      flex: 2,
      cellBuilder: (context, customer) => Row(
        mainAxisSize: .min,
        spacing: 9,
        children: [
          FortalAvatar(size: .size2, label: customer.initials),
          Flexible(child: _PrimaryText(customer.name)),
        ],
      ),
    ),
    DataGridColumn(
      id: 'email',
      label: 'Email',
      flex: 2,
      cellBuilder: (_, customer) => _SecondaryText(customer.email),
    ),
    DataGridColumn(
      id: 'plan',
      label: 'Plan',
      width: 110,
      cellBuilder: (_, customer) => _PrimaryText(customer.plan),
    ),
    DataGridColumn(
      id: 'status',
      label: 'Status',
      width: 110,
      cellBuilder: (_, customer) => _CustomerStatusBadge(customer.status),
    ),
    DataGridColumn(
      id: 'joined',
      label: 'Joined',
      sortable: true,
      width: 118,
      cellBuilder: (_, customer) => _SecondaryText(_date(customer.joinedAt)),
    ),
    DataGridColumn(
      id: 'actions',
      label: '',
      width: 46,
      align: .right,
      cellBuilder: (context, customer) => FortalMenu<String>(
        semanticLabel: 'Actions for ${customer.name}',
        trigger: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(Icons.more_horiz, size: 18),
        ),
        entries: const [
          RemixMenuAction(value: 'view', child: Text('View profile')),
          RemixMenuAction(value: 'email', child: Text('Send email')),
          RemixMenuSeparator(),
          RemixMenuAction(value: 'archive', child: Text('Archive')),
        ],
        onSelected: (value) =>
            showToast(context, message: '$value selected for ${customer.name}'),
      ),
    ),
  ];
}

class _CustomerStatusBadge extends StatelessWidget {
  const _CustomerStatusBadge(this.status);
  final CustomerStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      .active => ('Active', FortalAccentColor.green),
      .invited => ('Invited', FortalAccentColor.blue),
      .suspended => ('Suspended', FortalAccentColor.red),
    };
    return FortalBadge(color: color, child: Text(label));
  }
}

class _PrimaryText extends StatelessWidget {
  const _PrimaryText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => StyledText(
    text,
    style: TextStyler(style: FortalTokens.text2.mix())
        .fontWeight(.w500)
        .color(FortalTokens.gray12())
        .maxLines(1)
        .overflow(.ellipsis),
  );
}

class _SecondaryText extends StatelessWidget {
  const _SecondaryText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => StyledText(
    text,
    style: TextStyler(
      style: FortalTokens.text2.mix(),
    ).color(FortalTokens.gray11()).maxLines(1).overflow(.ellipsis),
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
