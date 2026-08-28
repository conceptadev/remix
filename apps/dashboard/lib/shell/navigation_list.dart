import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../widgets/typography.dart';
import 'dashboard_page.dart';

class DashboardNavDestination {
  const DashboardNavDestination({
    required this.value,
    required this.label,
    this.icon,
  }) : assert(label != '', 'DashboardNavDestination label must not be empty.');

  final DashboardPage value;
  final String label;
  final IconData? icon;
}

class DashboardNavSection {
  const DashboardNavSection({this.label, required this.destinations})
    : assert(
        label != '',
        'DashboardNavSection label must be null or non-empty.',
      );

  final String? label;
  final List<DashboardNavDestination> destinations;
}

final List<DashboardNavSection> dashboardNavSections = [
  for (final section in DashboardSection.values)
    DashboardNavSection(
      label: section.label,
      destinations: [
        for (final page in DashboardPage.values)
          if (page.section == section)
            DashboardNavDestination(
              value: page,
              label: page.label,
              icon: page.icon,
            ),
      ],
    ),
];

class DashboardNavigationList extends StatelessWidget {
  const DashboardNavigationList({
    super.key,
    required this.sections,
    required this.selected,
    required this.onSelected,
  });

  /// Navigation sections in visual and traversal order.
  ///
  /// The list and its destination lists must not be modified after being
  /// passed to this widget.
  final List<DashboardNavSection> sections;

  final DashboardPage? selected;
  final ValueChanged<DashboardPage> onSelected;

  static final _destinationStyle = fortalToggleStyle(
    variant: .ghost,
  ).container(.mainAxisSize(.max).mainAxisAlignment(.start));

  bool _debugItemsAreValid() {
    final values = <DashboardPage>{};

    for (final section in sections) {
      for (final destination in section.destinations) {
        if (!values.add(destination.value)) {
          throw FlutterError(
            'DashboardNavigationList destination values must be unique. '
            'Duplicate value: ${destination.value}.',
          );
        }
      }
    }

    final selectedValue = selected;
    if (selectedValue != null && !values.contains(selectedValue)) {
      throw FlutterError(
        'DashboardNavigationList selected must match one destination. '
        'No destination has value: $selectedValue.',
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugItemsAreValid());

    return Semantics(
      role: SemanticsRole.navigation,
      container: true,
      explicitChildNodes: true,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          for (final section in sections)
            if (section.destinations.isNotEmpty) ...[
              if (section.label case final label?) _SectionLabel(label),
              for (final destination in section.destinations)
                Padding(
                  key: ValueKey('nav-${destination.value.name}'),
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Semantics(
                    button: true,
                    selected: destination.value == selected,
                    enabled: true,
                    label: destination.label,
                    onTap: () => onSelected(destination.value),
                    child: RemixToggle(
                      selected: destination.value == selected,
                      excludeSemantics: true,
                      onChanged: (_) => onSelected(destination.value),
                      label: destination.label,
                      icon: destination.icon,
                      style: _destinationStyle,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        child: StyledText(
          label.toUpperCase(),
          style: dashboardText(
            .size1,
            weight: .medium,
            tone: .muted,
          ).letterSpacing(0.7),
        ),
      ),
    );
  }
}
