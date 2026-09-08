import 'package:flutter/material.dart';

const dashboardDisclosureAnimationStyle = AnimationStyle(
  curve: Curves.ease,
  duration: Duration(milliseconds: 200),
  reverseDuration: Duration(milliseconds: 200),
);

/// Dashboard trigger composition shared by standalone Fortal disclosures.
///
/// `FortalDisclosure` deliberately leaves its trailing affordance to the
/// caller. This widget gives every dashboard disclosure the same expanding
/// chevron while preserving arbitrary trigger content.
class DashboardDisclosureTrigger extends StatelessWidget {
  const DashboardDisclosureTrigger({
    super.key,
    required this.expanded,
    required this.child,
  });

  final bool expanded;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: child),
      AnimatedRotation(
        turns: expanded ? 0.5 : 0,
        duration: dashboardDisclosureAnimationStyle.duration!,
        curve: dashboardDisclosureAnimationStyle.curve!,
        child: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    ],
  );
}
