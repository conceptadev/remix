part of 'select.dart';

/// Resolved visual values for a [RemixSelect].
@MixableSpec()
class RemixSelectSpec with _$RemixSelectSpec {
  @override
  final StyleSpec<RemixSelectTriggerSpec> trigger;
  @override
  final StyleSpec<RemixSelectContentSpec> content;
  @override
  final StyleSpec<RemixSelectMenuItemSpec> item;
  @override
  final StyleSpec<RemixSelectLabelSpec> label;
  @override
  final StyleSpec<BoxSpec> separator;

  const RemixSelectSpec({
    StyleSpec<RemixSelectTriggerSpec>? trigger,
    StyleSpec<RemixSelectContentSpec>? content,
    StyleSpec<RemixSelectMenuItemSpec>? item,
    StyleSpec<RemixSelectLabelSpec>? label,
    StyleSpec<BoxSpec>? separator,
  }) : trigger = trigger ?? const StyleSpec(spec: RemixSelectTriggerSpec()),
       content = content ?? const StyleSpec(spec: RemixSelectContentSpec()),
       item = item ?? const StyleSpec(spec: RemixSelectMenuItemSpec()),
       label = label ?? const StyleSpec(spec: RemixSelectLabelSpec()),
       separator = separator ?? const StyleSpec(spec: BoxSpec());
}

/// Resolved visual values for the select trigger.
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class RemixSelectTriggerSpec with _$RemixSelectTriggerSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<TextSpec> placeholder;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  final StyleSpec<IconSpec> chevron;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;
  @override
  final double? chevronOpacity;
  @override
  final double? placeholderOpacity;

  const RemixSelectTriggerSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? placeholder,
    StyleSpec<IconSpec>? icon,
    StyleSpec<IconSpec>? chevron,
    this.surface,
    this.overlay,
    this.chevronOpacity,
    this.placeholderOpacity,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       placeholder = placeholder ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       chevron = chevron ?? const StyleSpec(spec: IconSpec());

  @override
  RemixSelectTriggerSpec lerp(RemixSelectTriggerSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      surface: RemixSurfaceLayerSpec.lerpNullable(surface, other.surface, t),
      overlay: RemixSurfaceLayerSpec.lerpNullable(overlay, other.overlay, t),
    );
  }
}

/// Resolved visual values for the select popup content.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSelectContentSpec with _$RemixSelectContentSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;

  const RemixSelectContentSpec({StyleSpec<BoxSpec>? container, this.surface})
    : container = container ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixSelectContentSpec lerp(RemixSelectContentSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      surface: RemixSurfaceLayerSpec.lerpNullable(surface, other.surface, t),
    );
  }
}

/// Resolved visual values for a select menu item.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class RemixSelectMenuItemSpec with _$RemixSelectMenuItemSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> text;
  @override
  final StyleSpec<BoxSpec> indicator;
  @override
  final StyleSpec<IconSpec> icon;

  const RemixSelectMenuItemSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Resolved visual values for a non-selectable select label.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSelectLabelSpec with _$RemixSelectLabelSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> text;
  @override
  final double? adjacentItemSpacing;

  const RemixSelectLabelSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    this.adjacentItemSpacing,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec());
}
