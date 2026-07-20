import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildSpinnerExample() {
  return SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [
        RemixSpinner(style: RemixSpinnerStyler(opacity: 0.65)),
        RemixSpinner(style: RemixSpinnerStyler(size: 32, opacity: 0.65)),
      ],
      material: const [
        CircularProgressIndicator(strokeWidth: 2),
        SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ],
    ),
  );
}
