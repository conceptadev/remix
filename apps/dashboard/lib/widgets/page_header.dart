import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

/// The title, description, and optional actions at the top of a page.
///
/// Titles are [FortalHeading] so the page publishes a real heading tree: the
/// page title is level 1 and every card or section title below it is level 2.
/// The visual size is chosen independently of that level, exactly as Radix
/// separates `as` from `size`.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.description,
    this.actions,
  });

  final String title;
  final String description;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              DashboardTextTone(
                child: FortalHeading(title, size: .size6, weight: .bold),
              ),
              StyledText(
                description,
                style: dashboardText(.size2, tone: .muted),
              ),
            ],
          ),
        ),
        ?actions,
      ],
    );
  }
}

/// The title of a section inside a card.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) => DashboardTextTone(
    child: FortalHeading(label, headingLevel: 2, size: .size4, weight: .medium),
  );
}

/// A [SectionLabel] with supporting copy beneath it.
class CardHeading extends StatelessWidget {
  const CardHeading({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    spacing: 3,
    children: [
      SectionLabel(title),
      StyledText(description, style: dashboardText(.size2, tone: .muted)),
    ],
  );
}
