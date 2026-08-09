import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../widgets/comparison_view.dart';

Widget buildTooltipExample() {
  Widget iconButtonWithTooltip(Widget child) =>
      IconButton(onPressed: () {}, icon: child);

  return SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [
        RemixTooltip(
          tooltipChild: const Text('More info'),
          child: RemixIconButton(icon: Icons.info_outline, onPressed: () {}),
        ),
        RemixTooltip(
          tooltipChild: const Text('Settings'),
          child: RemixIconButton(icon: Icons.settings, onPressed: () {}),
        ),
      ],
      material: [
        Tooltip(
          message: 'More info',
          child: iconButtonWithTooltip(const Icon(Icons.info_outline)),
        ),
        Tooltip(
          message: 'Settings',
          child: iconButtonWithTooltip(const Icon(Icons.settings)),
        ),
      ],
    ),
  );
}
