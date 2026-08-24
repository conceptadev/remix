import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../data/activity.dart';
import '../data/models.dart';
import '../data/orders.dart';
import '../widgets/accent_scope.dart';
import '../widgets/analytics_charts.dart';
import '../widgets/data_table_cell_text.dart';
import '../widgets/page_header.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';
import '../widgets/typography.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key, required this.onViewOrders});

  final VoidCallback onViewOrders;

  @override
  Widget build(BuildContext context) {
    final pagePadding = MixScope.tokenOf(FortalTokens.space6, context);
    final pageGap = MixScope.tokenOf(FortalTokens.space5, context);
    final metricGap = MixScope.tokenOf(FortalTokens.space4, context);
    final bandGap = MixScope.tokenOf(FortalTokens.space5, context);
    // Omit autoRows: Mix 1031 defaults implicit rows to content height.
    final GridBoxStyler metricsStyle = .equalColumns(4)
        .gap(metricGap)
        .onConstraints(const .maxWidth(900), .equalColumns(2).gap(metricGap))
        .onConstraints(const .maxWidth(520), .equalColumns(1).gap(metricGap));
    final GridBoxStyler activityStyle = .equalColumns(2)
        .gap(bandGap)
        .onConstraints(
          // Old LayoutBuilder used content width ≥ 1050. This Grid sees
          // that slot minus page padding on both sides (space6 × 2 = 64).
          const .maxWidth(985),
          .equalColumns(1).gap(bandGap),
        );

    return SingleChildScrollView(
      padding: EdgeInsets.all(pagePadding),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: pageGap,
        children: [
          const PageHeader(
            title: 'Overview',
            description: 'A snapshot of your workspace performance.',
          ),
          GridBox(
            style: metricsStyle,
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
          const AnalyticsCharts(),
          GridBox(
            style: activityStyle,
            children: [
              const _ActivityCard(),
              _RecentOrders(onViewOrders: onViewOrders),
            ],
          ),
        ],
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
              const FortalDivider(size: .size4),
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
    final (icon, accent) = switch (event.kind) {
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
          _ActivityIcon(icon: icon, accent: accent),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2,
              children: [
                FortalText(event.title, size: .size2, weight: .medium),
                StyledText(
                  event.detail,
                  style: dashboardText(.size1, tone: .muted),
                ),
              ],
            ),
          ),
          StyledText(
            event.relativeTime,
            style: dashboardText(.size1, tone: .subtle),
          ),
        ],
      ),
    );
  }
}

/// The accent-tinted disc in front of an activity row.
///
/// A soft avatar already is this disc — `accent-a3` fill, 32px at size 2 — so
/// re-scoping to [accent] is the whole widget. Before this it reached into a
/// Radix colour scale directly and had to pick its own dark-mode branch.
class _ActivityIcon extends StatelessWidget {
  const _ActivityIcon({required this.icon, required this.accent});

  final IconData icon;
  final FortalAccentColor accent;

  @override
  Widget build(BuildContext context) => DashboardAccentScope(
    accent: accent,
    child: FortalAvatar.soft(icon: icon, size: .size2),
  );
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
              FortalButton.ghost(
                key: const ValueKey('overview-view-orders'),
                size: .size1,
                onPressed: onViewOrders,
                label: 'View all',
                trailingIcon: Icons.arrow_forward,
              ),
            ],
          ),
          FortalDataTable<Order>.surface(
            rows: orders.take(5).toList(),
            semanticLabel: 'Recent orders',
            minimumWidth: 560,
            columns: [
              RemixDataTableColumn(
                id: 'id',
                label: 'Order',
                width: const FixedColumnWidth(105),
                cellBuilder: (_, order) =>
                    DataTableCellText(order.id, primary: true),
              ),
              RemixDataTableColumn(
                id: 'customer',
                label: 'Customer',
                width: const FlexColumnWidth(2),
                cellBuilder: (_, order) => DataTableCellText(order.customer),
              ),
              RemixDataTableColumn(
                id: 'amount',
                label: 'Amount',
                width: const FixedColumnWidth(100),
                alignment: .end,
                cellBuilder: (_, order) => DataTableCellText(
                  '\$${order.amount.toStringAsFixed(2)}',
                  primary: true,
                ),
              ),
              RemixDataTableColumn(
                id: 'status',
                label: 'Status',
                width: const FixedColumnWidth(94),
                cellBuilder: (_, order) => StatusBadge.order(order.status),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
