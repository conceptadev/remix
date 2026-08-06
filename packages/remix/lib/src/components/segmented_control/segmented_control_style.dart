part of 'segmented_control.dart';

/// Style helpers for [RemixSegmentedControl].
///
/// Hand-written rather than generated: `@MixableSpec(target:)` cannot express a
/// generic widget, so generic components carry their own `call` the same way
/// [RemixToggleGroup] and [RemixRadio] do.
extension RemixSegmentedControlStylerRemixHelpers on SegmentedControlStyler {
  /// Creates a [RemixSegmentedControl] with this style applied.
  RemixSegmentedControl<T> call<T extends Object>({
    Key? key,
    required List<RemixSegmentedControlItem<T>> items,
    required T? selectedValue,
    ValueChanged<T>? onChanged,
    bool enabled = true,
    Axis orientation = .horizontal,
    bool loop = true,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixSegmentedControl(
      key: key,
      items: items,
      selectedValue: selectedValue,
      onChanged: onChanged,
      enabled: enabled,
      orientation: orientation,
      loop: loop,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
