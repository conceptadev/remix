// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segmented_control.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal recipe for [RemixSegmentedControl].
///
/// Paints the selected item in place. It does not reproduce Radix's sliding
/// indicator, duplicate-label crossfade, inactive separators, or max-content
/// overflow. Changing an item's label with the selection can therefore cause a
/// small intrinsic-width shift.
class FortalSegmentedControl<T extends Object> extends StatelessWidget {
  const FortalSegmentedControl({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const FortalSegmentedControl.surface({
    super.key,
    this.size = .size2,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalSegmentedControlVariant.surface;

  const FortalSegmentedControl.classic({
    super.key,
    this.size = .size2,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalSegmentedControlVariant.classic;

  final FortalSegmentedControlVariant variant;

  final FortalSegmentedControlSize size;

  final List<RemixSegmentedControlItem<T>> items;

  final T? selectedValue;

  final ValueChanged<T>? onChanged;

  final bool enabled;

  final Axis orientation;

  final bool loop;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixSegmentedControl<T>(
      key: this.key,
      style: fortalSegmentedControlStyle(
        variant: this.variant,
        size: this.size,
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
