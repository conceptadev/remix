import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildCalloutExample() {
  return const SizedBox(
    width: 520,
    child: ComparisonView(
      remix: [
        RemixCallout(text: 'Information message', icon: Icons.info),
        RemixCallout(
          text: 'Warning message',
          icon: Icons.warning_amber_rounded,
        ),
      ],
      material: [
        MaterialBanner(
          content: Text('Information message'),
          leading: Icon(Icons.info),
          actions: [SizedBox.shrink()],
        ),
        MaterialBanner(
          content: Text('Warning message'),
          leading: Icon(Icons.warning_amber_rounded),
          actions: [SizedBox.shrink()],
        ),
      ],
    ),
  );
}
