import 'package:remix/remix.dart';

import 'dashboard_page.dart';

/// Dashboard destinations in visual and keyboard traversal order.
final List<RemixNavigationSection<DashboardPage>> dashboardNavSections =
    List.unmodifiable([
      for (final section in DashboardSection.values)
        RemixNavigationSection<DashboardPage>(
          label: section.label,
          destinations: _destinationsFor(section),
        ),
    ]);

List<RemixNavigationDestination<DashboardPage>> _destinationsFor(
  DashboardSection section,
) => List.unmodifiable([
  for (final page in DashboardPage.values)
    if (page.section == section)
      RemixNavigationDestination(
        value: page,
        label: page.label,
        icon: page.icon,
      ),
]);
