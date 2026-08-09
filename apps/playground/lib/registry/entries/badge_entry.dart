import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildBadgeExample() {
  return const SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [
        RemixBadge(label: 'New'),
        RemixBadge(child: Text('Beta')),
      ],
      material: [
        Chip(label: Text('New')),
        Chip(label: Text('Beta')),
      ],
    ),
  );
}
