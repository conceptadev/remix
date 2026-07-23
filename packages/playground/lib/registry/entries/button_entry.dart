import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildButtonExample() {
  return ComparisonView(
    remix: [
      RemixButton(
        onPressed: () {},
        style: ButtonStyler()
            .paddingX(16)
            .paddingY(10)
            .borderRadiusAll(const Radius.circular(8))
            .backgroundColor(const Color(0xFF1F2937))
            .foregroundColor(Colors.white),
        child: const Text('Primary Button'),
      ),
      RemixButton(
        onPressed: null,
        style: ButtonStyler()
            .paddingX(16)
            .paddingY(10)
            .borderRadiusAll(const Radius.circular(8))
            .backgroundColor(const Color(0xFFE5E7EB))
            .foregroundColor(const Color(0xFF9CA3AF)),
        child: const Text('Disabled'),
      ),
      RemixButton(
        loading: true,
        onPressed: () {},
        style: ButtonStyler()
            .paddingX(16)
            .paddingY(10)
            .borderRadiusAll(const Radius.circular(8))
            .backgroundColor(const Color(0xFF1F2937).withValues(alpha: 0.6))
            .foregroundColor(Colors.white.withValues(alpha: 0.7))
            .spinner(.color(Colors.white)),
        child: const Text('Loading'),
      ),
      RemixButton(
        onPressed: () {},
        style: ButtonStyler()
            .paddingX(16)
            .paddingY(10)
            .borderRadiusAll(const Radius.circular(8))
            .backgroundColor(const Color(0xFF1F2937))
            .foregroundColor(Colors.white),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.star), Text('With Icon')],
        ),
      ),
      RemixIconButton(
        onPressed: () {},
        semanticLabel: 'Favorite',
        style: RemixIconButtonStyler()
            .paddingAll(10)
            .borderRadiusAll(const Radius.circular(8))
            .backgroundColor(const Color(0xFF1F2937))
            .foregroundColor(Colors.white),
        icon: const Icon(Icons.star),
      ),
    ],
    material: [
      FilledButton(onPressed: () {}, child: const Text('Primary Button')),
      const FilledButton(onPressed: null, child: Text('Disabled')),
      // Simulated loading state for Material (no built-in loading flag)
      const FilledButton(
        onPressed: null,
        child: Row(
          mainAxisSize: .min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('Loading'),
          ],
        ),
      ),
      FilledButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.star, size: 18),
        label: const Text('With Icon'),
      ),
      IconButton.filled(
        onPressed: () {},
        tooltip: 'Favorite',
        iconSize: 16,
        icon: const Icon(Icons.star, size: 16),
      ),
    ],
  );
}
