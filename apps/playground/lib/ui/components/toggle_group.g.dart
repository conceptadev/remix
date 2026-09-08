// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_group.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's ToggleGroup recipe.
///
/// A toggle group is a set of toggles that share one selection. Remix owns the
/// rendering, the roving focus and arrow-key traversal, the single- or
/// multi-select rules, and the group accessibility semantics; this recipe
/// owns the strip's layout and every option's appearance.
///
/// One recipe covers both, because `ToggleGroupSpec` carries the option's
/// style as a field: the group's `item` is the default every
/// `RemixToggleGroupItem` resolves against. That is what makes an option in a
/// loop impossible to leave unstyled, and it is why this file has one
/// `@MixWidget` rather than two.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. Because [variant] is a non-nullable
/// enum, the generator also emits one named constructor per enum value.
class PlaygroundToggleGroup<T> extends StatelessWidget {
  const PlaygroundToggleGroup({
    super.key,
    this.variant = .ghost,
    this.size = .medium,
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

  /// No fill and no border until an option is hovered or on.
  const PlaygroundToggleGroup.ghost({
    super.key,
    this.size = .medium,
    this.style = const ToggleGroupStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = PlaygroundToggleGroupVariant.ghost;

  /// A hairline `border` around every option, so the set is visible while off.
  const PlaygroundToggleGroup.outline({
    super.key,
    this.size = .medium,
    this.style = const ToggleGroupStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = PlaygroundToggleGroupVariant.outline;

  final PlaygroundToggleGroupVariant variant;

  final PlaygroundToggleGroupSize size;

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
      style: playgroundToggleGroupStyle(
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
