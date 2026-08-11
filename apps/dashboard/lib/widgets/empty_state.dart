import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
          child: Column(
            mainAxisSize: .min,
            spacing: 10,
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: .center,
                decoration: BoxDecoration(
                  color: MixScope.tokenOf(FortalTokens.gray4, context),
                  shape: .circle,
                ),
                child: Icon(
                  icon,
                  color: MixScope.tokenOf(FortalTokens.gray9, context),
                ),
              ),
              // An empty state sits inside a page, so it stays a level-2
              // heading and only drops its visual size.
              FortalHeading(
                title,
                headingLevel: 2,
                size: .size3,
                weight: .medium,
                align: .center,
              ),
              StyledText(
                body,
                style: dashboardText(.size2, tone: .muted).textAlign(.center),
              ),
              if (action case final action?) ...[
                const SizedBox(height: 4),
                action,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
