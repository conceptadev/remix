part of 'toggle_group.dart';

/// Style configuration for a [RemixToggleGroup] container and its items.
extension RemixToggleGroupStylerRemixHelpers on ToggleGroupStyler {
  /// Creates a [RemixToggleGroup] with this style applied.
  RemixToggleGroup<T> call<T>({
    Key? key,
    required List<RemixToggleGroupItem<T>> items,
    required T? selectedValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    Axis orientation = .horizontal,
    bool loop = true,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixToggleGroup(
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
