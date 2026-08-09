import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildRadioExample() {
  return const SizedBox(
    width: 360,
    child: ComparisonView(
      remix: [_RemixRadioGroupPreview()],
      material: [_MaterialRadioGroupPreview()],
    ),
  );
}

class _RemixRadioGroupPreview extends StatelessWidget {
  const _RemixRadioGroupPreview();

  @override
  Widget build(BuildContext context) {
    const groupValue = 'B';
    return RemixRadioGroup<String>(
      groupValue: groupValue,
      onChanged: (_) {},
      child: const Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          _RemixLabeledRadio(value: 'A', label: 'Option A'),
          _RemixLabeledRadio(value: 'B', label: 'Option B'),
          _RemixLabeledRadio(value: 'C', label: 'Disabled', enabled: false),
        ],
      ),
    );
  }
}

class _RemixLabeledRadio extends StatelessWidget {
  const _RemixLabeledRadio({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final String value;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        RemixRadio<String>(value: value, enabled: enabled),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _MaterialRadioGroupPreview extends StatefulWidget {
  const _MaterialRadioGroupPreview();

  @override
  State<_MaterialRadioGroupPreview> createState() =>
      _MaterialRadioGroupPreviewState();
}

class _MaterialRadioGroupPreviewState
    extends State<_MaterialRadioGroupPreview> {
  String groupValue = 'B';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        _LabeledRadio(
          value: 'A',
          label: 'Option A',
          groupValue: groupValue,
          onChanged: (value) => setState(() => groupValue = value!),
        ),
        _LabeledRadio(
          value: 'B',
          label: 'Option B',
          groupValue: groupValue,
          onChanged: (value) => setState(() => groupValue = value!),
        ),
        _LabeledRadio(
          value: 'C',
          label: 'Disabled',
          groupValue: groupValue,
          enabled: false,
          onChanged: null,
        ),
      ],
    );
  }
}

class _LabeledRadio extends StatelessWidget {
  const _LabeledRadio({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
  });

  final String value;
  final String label;
  final String groupValue;
  final bool enabled;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(value) : null,
      child: Row(
        mainAxisSize: .min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: enabled
                    ? (isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey)
                    : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: enabled
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade400,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: enabled ? null : Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
