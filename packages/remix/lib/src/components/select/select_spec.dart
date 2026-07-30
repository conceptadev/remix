part of 'select.dart';

/// Resolved visual values for a [RemixSelect].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSelectSpec with _$RemixSelectSpec {
  @override
  final StyleSpec<RemixSelectTriggerSpec> trigger;
  @override
  final StyleSpec<RemixSelectContentSpec> content;
  @override
  @MixableField(forwardStyler: true, stylerSurface: BoxSpec)
  final StyleSpec<FlexBoxSpec> menuContainer;
  @override
  final StyleSpec<RemixSelectMenuItemSpec> item;

  const RemixSelectSpec({
    StyleSpec<RemixSelectTriggerSpec>? trigger,
    StyleSpec<RemixSelectContentSpec>? content,
    StyleSpec<FlexBoxSpec>? menuContainer,
    StyleSpec<RemixSelectMenuItemSpec>? item,
  }) : trigger = trigger ?? const StyleSpec(spec: RemixSelectTriggerSpec()),
       content = content ?? const StyleSpec(spec: RemixSelectContentSpec()),
       item = item ?? const StyleSpec(spec: RemixSelectMenuItemSpec()),
       menuContainer = menuContainer ?? const StyleSpec(spec: FlexBoxSpec());
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
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;
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
    this.containerEffects,
    this.chevronOpacity,
    this.placeholderOpacity,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       placeholder = placeholder ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       chevron = chevron ?? const StyleSpec(spec: IconSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  RemixSelectTriggerSpec lerp(RemixSelectTriggerSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
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
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixSelectContentSpec({
    StyleSpec<BoxSpec>? container,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  RemixSelectContentSpec lerp(RemixSelectContentSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
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
