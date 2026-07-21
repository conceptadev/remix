import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

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
                style: TextStyler(
                  style: FortalTokens.text6.mix(),
                ).fontWeight(.w700).color(FortalTokens.gray12()),
              ),
              StyledText(
                description,
                style: TextStyler(
                  style: FortalTokens.text2.mix(),
                ).color(FortalTokens.gray11()),
              ),
            ],
          ),
        ),
        ?actions,
      ],
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return StyledText(
      label,
      style: TextStyler(
        style: FortalTokens.text4.mix(),
      ).fontWeight(.w600).color(FortalTokens.gray12()),
    );
  }
}
