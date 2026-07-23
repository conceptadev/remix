import 'package:flutter/material.dart';

import '../pages/customers_page.dart';
import '../pages/gallery/gallery_actions_page.dart';
import '../pages/gallery/gallery_display_page.dart';
import '../pages/gallery/gallery_forms_page.dart';
import '../pages/gallery/gallery_navigation_page.dart';
import '../pages/gallery/gallery_overlays_page.dart';
import '../pages/orders_page.dart';
import '../pages/overview_page.dart';
import '../pages/settings_page.dart';
import 'dashboard_page.dart';
import 'sidebar.dart';
import 'top_bar.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardPage _selected = .overview;
  String _searchQuery = '';

  void _select(DashboardPage page) {
    setState(() => _selected = page);
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.sizeOf(context).width < dashboardCompactBreakpoint;
    final pages = <Widget>[
      OverviewPage(onViewOrders: () => _select(.orders)),
      CustomersPage(globalQuery: _searchQuery),
      OrdersPage(globalQuery: _searchQuery),
      const SettingsPage(),
      const GalleryActionsPage(),
      const GalleryFormsPage(),
      const GalleryDisplayPage(),
      const GalleryOverlaysPage(),
      const GalleryNavigationPage(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: compact
          ? Drawer(
              width: 256,
              child: Sidebar(selected: _selected, onSelected: _select),
            )
          : null,
      body: Row(
        children: [
          if (!compact) Sidebar(selected: _selected, onSelected: _select),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  page: _selected,
                  onMenuPressed: compact
                      ? () => _scaffoldKey.currentState?.openDrawer()
                      : null,
                  onSearchChanged: (value) =>
                      setState(() => _searchQuery = value.trim().toLowerCase()),
                ),
                Expanded(
                  child: IndexedStack(index: _selected.index, children: pages),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
