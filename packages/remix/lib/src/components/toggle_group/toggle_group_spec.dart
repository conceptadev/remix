part of 'toggle_group.dart';

/// Resolved visual properties for a [RemixToggleGroup].
@MixableSpec(
  target: RemixToggleGroup.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class ToggleGroupSpec with _$ToggleGroupSpec {
  /// Layout and decoration for the group container.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Default visual style for every option in the group.
  @override
  final StyleSpec<ToggleGroupItemSpec> item;

  const ToggleGroupSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<ToggleGroupItemSpec>? item,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       item = item ?? const StyleSpec(spec: ToggleGroupItemSpec());
}

/// Backward-compatible name for [ToggleGroupSpec].
///
/// The generated style API is based on [ToggleGroupSpec], so resolved values
/// use `ToggleGroupSpec` as their runtime type.
typedef RemixToggleGroupSpec = ToggleGroupSpec;

/// Resolved visual properties for an item in a [RemixToggleGroup].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class ToggleGroupItemSpec with _$ToggleGroupItemSpec {
  /// Layout and decoration for the item content.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;

  /// Text style for the optional label.
  @override
  final StyleSpec<TextSpec> label;

  /// Icon style for the optional icon.
  @override
  final StyleSpec<IconSpec> icon;

  const ToggleGroupItemSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [ToggleGroupItemSpec].
///
/// The generated style API is based on [ToggleGroupItemSpec], so resolved
/// values use `ToggleGroupItemSpec` as their runtime type.
typedef RemixToggleGroupItemSpec = ToggleGroupItemSpec;
