import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../widgets/comparison_view.dart';

Widget buildCardExample() {
  Widget content(String title) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Card content goes here'),
      ],
    ),
  );

  return SizedBox(
    width: 420,
    child: ComparisonView(
      remix: [RemixCard(child: content('Remix Card'))],
      material: [Card(child: content('Material Card'))],
    ),
  );
}
