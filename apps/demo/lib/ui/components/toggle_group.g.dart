// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_group.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed segmented-control preset for [RemixToggleGroup].
class FortalToggleGroup<T> extends StatelessWidget {
  const FortalToggleGroup({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ToggleGroupStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const FortalToggleGroup.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ToggleGroupStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalToggleGroupVariant.soft;

  const FortalToggleGroup.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const ToggleGroupStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalToggleGroupVariant.surface;

  final FortalToggleGroupVariant variant;

  final FortalToggleGroupSize size;

  final bool highContrast;

  final ToggleGroupStyler style;

  final List<RemixToggleGroupItem<T>> items;

  final T? selectedValue;

  final ValueChanged<T?>? onChanged;

  final bool enabled;

  final Axis orientation;

  final bool loop;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixToggleGroup<T>(
      key: this.key,
      style: fortalToggleGroupStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      items: this.items,
      selectedValue: this.selectedValue,
      onChanged: this.onChanged,
      enabled: this.enabled,
      orientation: this.orientation,
      loop: this.loop,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
