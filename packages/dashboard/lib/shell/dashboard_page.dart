import 'package:flutter/material.dart';

const dashboardCompactBreakpoint = 720.0;

enum DashboardSection {
  overview('Workspace'),
  data('Data'),
  settings('Manage'),
  components('Components');

  const DashboardSection(this.label);
  final String label;
}

enum DashboardPage {
  overview(
    DashboardSection.overview,
    'Overview',
    Icons.space_dashboard_outlined,
  ),
  customers(DashboardSection.data, 'Customers', Icons.people_outline),
  orders(DashboardSection.data, 'Orders', Icons.receipt_long_outlined),
  settings(DashboardSection.settings, 'Settings', Icons.settings_outlined),
  galleryActions(
    DashboardSection.components,
    'Actions',
    Icons.smart_button_outlined,
  ),
  galleryForms(
    DashboardSection.components,
    'Forms & Inputs',
    Icons.text_fields_outlined,
  ),
  galleryDisplay(
    DashboardSection.components,
    'Data Display',
    Icons.view_agenda_outlined,
  ),
  galleryOverlays(
    DashboardSection.components,
    'Overlays',
    Icons.layers_outlined,
  ),
  galleryNavigation(
    DashboardSection.components,
    'Navigation',
    Icons.segment_outlined,
  );

  const DashboardPage(this.section, this.label, this.icon);

  final DashboardSection section;
  final String label;
  final IconData icon;
}
