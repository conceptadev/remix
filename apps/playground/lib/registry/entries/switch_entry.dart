import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildSwitchExample() {
  return SizedBox(
    width: 360,
    child: ComparisonView(
      remix: const [
        RemixSwitch(selected: true, onChanged: _noop),
        RemixSwitch(selected: false, onChanged: _noop),
        RemixSwitch(selected: false, enabled: false, onChanged: _noop),
      ],
      material: [
        Switch(value: true, onChanged: (_) {}),
        Switch(value: false, onChanged: (_) {}),
        const Switch(value: false, onChanged: null),
      ],
    ),
  );
}

void _noop(bool _) {}
