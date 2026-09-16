// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segmented_control.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui recipe for [RemixSegmentedControl].
///
/// Content icons use size-matched 12/16/20 token defaults rather than the
/// ambient icon size. Control and item styles may override these defaults.
///
/// Paints the selected item in place. It does not reproduce Radix's sliding
/// indicator, duplicate-label crossfade, inactive separators, or max-content
/// overflow. Changing an item's label with the selection can therefore cause a
/// small intrinsic-width shift.
class UiSegmentedControl<T extends Object> extends StatelessWidget {
  const UiSegmentedControl({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.style = const SegmentedControlStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const UiSegmentedControl.surface({
    super.key,
    this.size = .size2,
    this.style = const SegmentedControlStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = UiSegmentedControlVariant.surface;

  const UiSegmentedControl.classic({
    super.key,
    this.size = .size2,
    this.style = const SegmentedControlStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = UiSegmentedControlVariant.classic;

  final UiSegmentedControlVariant variant;

  final UiSegmentedControlSize size;

  final SegmentedControlStyler style;

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
      style: uiSegmentedControlStyle(
        variant: this.variant,
        size: this.size,
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
