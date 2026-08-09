import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const SpacedColumn({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.mainAxisAlignment = .start,
    this.crossAxisAlignment = .center,
    this.mainAxisSize = .max,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
      );
    }

    final spacedChildren = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);

      // Add spacing between items (but not after the last item)
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}
