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
  DashboardPage _selected = .overview;
  String _searchQuery = '';

  void _select(DashboardPage page) => setState(() => _selected = page);

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Sidebar(selected: _selected, onSelected: _select),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  page: _selected,
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
