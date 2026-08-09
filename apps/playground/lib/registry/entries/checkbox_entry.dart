import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildCheckboxExample() {
  return SizedBox(
    width: 360,
    child: ComparisonView(
      remix: const [
        RemixCheckbox(
          selected: true,
          semanticLabel: 'Checked checkbox',
          onChanged: _noopNullable,
        ),
        RemixCheckbox(
          selected: false,
          semanticLabel: 'Unchecked checkbox',
          onChanged: _noopNullable,
        ),
        RemixCheckbox(
          tristate: true,
          selected: null,
          semanticLabel: 'Mixed checkbox',
          onChanged: _noopNullable,
        ),
        RemixCheckbox(
          selected: true,
          onChanged: _noopNullable,
          label: 'With label',
        ),
        RemixCheckbox(
          selected: false,
          enabled: false,
          semanticLabel: 'Disabled checkbox',
        ),
      ],
      material: [
        Checkbox(value: true, onChanged: (_) {}),
        Checkbox(value: false, onChanged: (_) {}),
        Checkbox(tristate: true, value: null, onChanged: (_) {}),
        Row(
          mainAxisSize: .min,
          children: [
            Checkbox(value: true, onChanged: (_) {}),
            const SizedBox(width: 8),
            const Text('With label'),
          ],
        ),
        const Checkbox(value: false, onChanged: null),
      ],
    ),
  );
}

void _noopNullable(bool? _) {}
