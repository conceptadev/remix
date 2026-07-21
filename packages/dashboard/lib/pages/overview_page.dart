import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../data/activity.dart';
import '../data/models.dart';
import '../data/orders.dart';
import '../widgets/data_grid.dart';
import '../widgets/page_header.dart';
import '../widgets/stat_card.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key, required this.onViewOrders});

  final VoidCallback onViewOrders;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 24,
          children: [
            const PageHeader(
              title: 'Overview',
              description: 'A snapshot of your workspace performance.',
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                StatCard(
                  label: 'Revenue',
                  value: '\$84,420',
                  delta: 12.4,
                  icon: Icons.payments_outlined,
                ),
                StatCard(
                  label: 'Active customers',
                  value: '2,420',
                  delta: 8.2,
                  icon: Icons.people_outline,
                ),
                StatCard(
                  label: 'Open orders',
                  value: '184',
                  delta: -2.8,
                  icon: Icons.inventory_2_outlined,
                ),
                StatCard(
                  label: 'Fulfillment',
                  value: '94.2%',
                  delta: 4.1,
                  icon: Icons.local_shipping_outlined,
                  progress: 94.2,
                ),
              ],
            ),
            if (constraints.maxWidth >= 1050)
              Row(
                crossAxisAlignment: .start,
                spacing: 20,
                children: [
                  const Expanded(child: _ActivityCard()),
                  Expanded(child: _RecentOrders(onViewOrders: onViewOrders)),
                ],
              )
            else
              Column(
                crossAxisAlignment: .stretch,
                spacing: 20,
                children: [
                  const _ActivityCard(),
                  _RecentOrders(onViewOrders: onViewOrders),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return FortalCard(
      size: .size2,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          const SectionLabel('Recent activity'),
          const SizedBox(height: 8),
          for (final (index, event) in activityEvents.indexed) ...[
            _ActivityRow(event),
            if (index != activityEvents.length - 1)
              Container(
                height: 1,
                color: MixScope.tokenOf(FortalTokens.grayA5, context),
              ),
          ],
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow(this.event);
  final ActivityEvent event;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (event.kind) {
      .customer => (Icons.person_add_alt, FortalAccentColor.blue),
      .order => (Icons.local_shipping_outlined, FortalAccentColor.indigo),
      .payment => (Icons.payments_outlined, FortalAccentColor.green),
      .alert => (Icons.error_outline, FortalAccentColor.amber),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        spacing: 12,
        children: [
          _ActivityIcon(icon: icon, color: color),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2,
              children: [
                StyledText(
                  event.title,
                  style: TextStyler(
                    style: FortalTokens.text2.mix(),
                  ).fontWeight(.w600).color(FortalTokens.gray12()),
                ),
                StyledText(
                  event.detail,
                  style: TextStyler(
                    style: FortalTokens.text1.mix(),
                  ).color(FortalTokens.gray11()),
                ),
              ],
            ),
          ),
          StyledText(
            event.relativeTime,
            style: TextStyler(
              style: FortalTokens.text1.mix(),
            ).color(FortalTokens.gray10()),
          ),
        ],
      ),
    );
  }
}

class _ActivityIcon extends StatelessWidget {
  const _ActivityIcon({required this.icon, required this.color});

  final IconData icon;
  final FortalAccentColor color;

  @override
  Widget build(BuildContext context) {
    final radix = switch (color) {
      .blue => blue,
      .green => green,
      .amber => amber,
      _ => indigo,
    };
    final scale = FortalTheme.of(context).isDark ? radix.dark : radix.light;
    return Container(
      width: 32,
      height: 32,
      alignment: .center,
      decoration: BoxDecoration(
        color: scale.scale.alphaStep(3),
        shape: .circle,
      ),
      child: Icon(icon, size: 16, color: scale.scale.step(11)),
    );
  }
}

class _RecentOrders extends StatelessWidget {
  const _RecentOrders({required this.onViewOrders});
  final VoidCallback onViewOrders;

  @override
  Widget build(BuildContext context) {
    return FortalCard(
      size: .size2,
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 12,
        children: [
          Row(
            children: [
              const Expanded(child: SectionLabel('Recent orders')),
              FortalButton(
                key: const ValueKey('overview-view-orders'),
                variant: .ghost,
                size: .size1,
                onPressed: onViewOrders,
                child: const Row(
                  mainAxisSize: .min,
                  spacing: 3,
                  children: [
                    Text('View all'),
                    Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
              ),
            ],
          ),
          DataGrid<Order>(
            rows: orders.take(5).toList(),
            minimumWidth: 560,
            columns: [
              DataGridColumn(
                id: 'id',
                label: 'Order',
                width: 105,
                cellBuilder: (_, order) => _OrderText(order.id, primary: true),
              ),
              DataGridColumn(
                id: 'customer',
                label: 'Customer',
                flex: 2,
                cellBuilder: (_, order) => _OrderText(order.customer),
              ),
              DataGridColumn(
                id: 'amount',
                label: 'Amount',
                width: 100,
                align: .right,
                cellBuilder: (_, order) => _OrderText(
                  '\$${order.amount.toStringAsFixed(2)}',
                  primary: true,
                ),
              ),
              DataGridColumn(
                id: 'status',
                label: 'Status',
                width: 94,
                cellBuilder: (_, order) => FortalBadge(
                  color: order.status == .paid ? .green : .amber,
                  child: Text(order.status.name),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderText extends StatelessWidget {
  const _OrderText(this.value, {this.primary = false});
  final String value;
  final bool primary;

  @override
  Widget build(BuildContext context) => StyledText(
    value,
    style: TextStyler(style: FortalTokens.text1.mix())
        .fontWeight(primary ? .w600 : .w400)
        .color(primary ? FortalTokens.gray12() : FortalTokens.gray11())
        .maxLines(1)
        .overflow(.ellipsis),
  );
}
