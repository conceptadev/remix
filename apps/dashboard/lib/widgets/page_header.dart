import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

/// The title, description, and optional actions at the top of a page.
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
              StyledText(
                title,
                style: dashboardText(FortalTokens.text6, weight: .w700),
              ),
              StyledText(
                description,
                style: dashboardText(FortalTokens.text2, tone: .muted),
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
  Widget build(BuildContext context) => StyledText(
    label,
    style: dashboardText(FortalTokens.text4, weight: .w600),
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
      StyledText(
        description,
        style: dashboardText(FortalTokens.text2, tone: .muted),
      ),
    ],
  );
}
