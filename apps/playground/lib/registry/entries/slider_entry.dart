import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildSliderExample() {
  return const SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [
        _StaticRemixSlider(value: 25, min: 0, max: 100),
        _StaticRemixSlider(value: 50, min: 0, max: 100, snapDivisions: 5),
        _StaticRemixSlider(value: 75, min: 0, max: 100, enabled: false),
      ],
      material: [
        _StaticMaterialSlider(value: 25, min: 0, max: 100),
        _StaticMaterialSlider(value: 50, min: 0, max: 100, divisions: 5),
        _StaticMaterialSlider(value: 75, min: 0, max: 100, enabled: false),
      ],
    ),
  );
}

class _StaticRemixSlider extends StatelessWidget {
  const _StaticRemixSlider({
    required this.value,
    required this.min,
    required this.max,
    this.snapDivisions,
    this.enabled = true,
  });

  final double value;
  final double min;
  final double max;
  final int? snapDivisions;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RemixSlider(
      value: value,
      min: min,
      max: max,
      snapDivisions: snapDivisions,
      enabled: enabled,
      onChanged: (_) {},
    );
  }
}

class _StaticMaterialSlider extends StatelessWidget {
  const _StaticMaterialSlider({
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.enabled = true,
  });

  final double value;
  final double min;
  final double max;
  final int? divisions;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: min,
      max: max,
      divisions: divisions,
      onChanged: enabled ? (_) {} : null,
    );
  }
}
