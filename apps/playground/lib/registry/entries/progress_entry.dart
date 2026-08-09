import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildProgressExample() {
  return const SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [RemixProgress(value: 0.25), RemixProgress(value: 0.6)],
      material: [
        LinearProgressIndicator(value: 0.25),
        LinearProgressIndicator(value: 0.6),
      ],
    ),
  );
}
