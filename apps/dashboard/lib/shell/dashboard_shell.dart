import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../pages/charts_page.dart';
import '../pages/customers_page.dart';
import '../pages/gallery/gallery_actions_page.dart';
import '../pages/gallery/gallery_display_page.dart';
import '../pages/gallery/gallery_forms_page.dart';
import '../pages/gallery/gallery_navigation_page.dart';
import '../pages/gallery/gallery_overlays_page.dart';
import '../pages/gallery/gallery_typography_page.dart';
import '../pages/orders_page.dart';
import '../pages/overview_page.dart';
import '../pages/settings_page.dart';
import 'dashboard_page.dart';
import 'dashboard_shell_layout.dart';
import 'sidebar.dart';
import 'top_bar.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  DashboardPage _selected = .overview;
  String _searchQuery = '';
  bool _sidebarCollapsed = false;

  void _select(DashboardPage page) => setState(() => _selected = page);

  @override
  Widget build(BuildContext context) {
    // IndexedStack is keyed by DashboardPage.index, so this list must stay in
    // enum order.
    final pages = <Widget>[
      OverviewPage(onViewOrders: () => _select(.orders)),
      CustomersPage(globalQuery: _searchQuery),
      OrdersPage(globalQuery: _searchQuery),
      const SettingsPage(),
      const ChartsPage(),
      const GalleryActionsPage(),
      const GalleryFormsPage(),
      const GalleryDisplayPage(),
      const GalleryOverlaysPage(),
      const GalleryNavigationPage(),
      const GalleryTypographyPage(),
    ];

    return FortalSidebarLayout(
      compactBreakpoint: dashboardCompactBreakpoint,
      sidebarWidth: dashboardSidebarWidth,
      collapsedWidth: dashboardSidebarCollapsedWidth,
      collapsed: _sidebarCollapsed,
      sidebar: Builder(
        builder: (context) {
          final scope = FortalSidebarLayoutScope.of(context);
          return Sidebar(
            key: const ValueKey('dashboard-sidebar'),
            selected: _selected,
            // The compact sheet always shows the fully expanded panel — a
            // mobile drawer with icon-only labels defeats the point of the
            // sheet — independent of the desktop collapse toggle.
            collapsed: !scope.isCompact && _sidebarCollapsed,
            onSelected: (page) {
              _select(page);
              scope.closeCompact();
            },
            // Null hides the collapse control inside the compact sheet.
            onToggle: scope.isCompact
                ? null
                : () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
          );
        },
      ),
      header: Builder(
        builder: (context) {
          final scope = FortalSidebarLayoutScope.of(context);
          return TopBar(
            page: _selected,
            onMenuPressed: scope.isCompact ? scope.openCompact : null,
            onSearchChanged: (value) =>
                setState(() => _searchQuery = value.trim().toLowerCase()),
          );
        },
      ),
      body: IndexedStack(index: _selected.index, children: pages),
    );
  }
}
