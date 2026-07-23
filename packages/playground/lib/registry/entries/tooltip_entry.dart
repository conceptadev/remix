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
          child: RemixIconButton(
            semanticLabel: 'More info',
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ),
        RemixTooltip(
          tooltipChild: const Text('Settings'),
          child: RemixIconButton(
            semanticLabel: 'Settings',
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
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
