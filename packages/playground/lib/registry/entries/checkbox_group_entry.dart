import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildCheckboxGroupExample() {
  return const SizedBox(
    width: 480,
    child: ComparisonView(
      remix: [_RemixCheckboxGroupPreview()],
      material: [_MaterialCheckboxGroupPreview()],
    ),
  );
}

enum _Interest { design, code, research }

extension on _Interest {
  String get label => switch (this) {
    _Interest.design => 'Design',
    _Interest.code => 'Code',
    _Interest.research => 'Research',
  };
}

/// The group itself is unstyled — every visual comes from the item's checkbox
/// recipe, so `fortalCheckboxStyle()` applies with no group-level style.
class _RemixCheckboxGroupPreview extends StatefulWidget {
  const _RemixCheckboxGroupPreview();

  @override
  State<_RemixCheckboxGroupPreview> createState() =>
      _RemixCheckboxGroupPreviewState();
}

class _RemixCheckboxGroupPreviewState
    extends State<_RemixCheckboxGroupPreview> {
  Set<_Interest> _interests = {_Interest.design};
  Set<String> _filters = {'open'};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        RemixCheckboxGroup<_Interest>(
          values: _interests,
          onChanged: (values) => setState(() => _interests = values),
          semanticLabel: 'Interests',
          isRequired: true,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              for (final interest in _Interest.values)
                _LabeledOption<_Interest>(
                  value: interest,
                  label: interest.label,
                  enabled: interest != _Interest.research,
                ),
            ],
          ),
        ),
        Text('Selected: ${_interests.map((i) => i.label).join(', ')}'),
        RemixCheckboxGroup<String>(
          values: _filters,
          onChanged: (values) => setState(() => _filters = values),
          semanticLabel: 'Filters',
          child: const Row(
            mainAxisSize: .min,
            spacing: 16,
            children: [
              _LabeledOption<String>(value: 'open', label: 'Open'),
              _LabeledOption<String>(value: 'closed', label: 'Closed'),
            ],
          ),
        ),
        RemixCheckboxGroup<String>(
          values: const {'archived'},
          enabled: false,
          onChanged: (_) {},
          semanticLabel: 'Disabled group',
          child: const Row(
            mainAxisSize: .min,
            spacing: 16,
            children: [
              _LabeledOption<String>(value: 'archived', label: 'Archived'),
              _LabeledOption<String>(value: 'muted', label: 'Muted'),
            ],
          ),
        ),
      ],
    );
  }
}

/// The item keeps its indicator, spacing, visible label, and 48px target inside
/// the composed checkbox, so the whole row is one interactive semantics node.
class _LabeledOption<T extends Object> extends StatelessWidget {
  const _LabeledOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RemixCheckboxGroupItem<T>(
      value: value,
      label: label,
      enabled: enabled,
      style: fortalCheckboxStyle(),
    );
  }
}

class _MaterialCheckboxGroupPreview extends StatefulWidget {
  const _MaterialCheckboxGroupPreview();

  @override
  State<_MaterialCheckboxGroupPreview> createState() =>
      _MaterialCheckboxGroupPreviewState();
}

class _MaterialCheckboxGroupPreviewState
    extends State<_MaterialCheckboxGroupPreview> {
  final Set<_Interest> _interests = {_Interest.design};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        for (final interest in _Interest.values)
          Row(
            mainAxisSize: .min,
            children: [
              Checkbox(
                value: _interests.contains(interest),
                onChanged: interest == _Interest.research
                    ? null
                    : (checked) => setState(() {
                        if (checked ?? false) {
                          _interests.add(interest);
                        } else {
                          _interests.remove(interest);
                        }
                      }),
              ),
              const SizedBox(width: 8),
              Text(interest.label),
            ],
          ),
      ],
    );
  }
}
