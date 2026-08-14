part of 'select.dart';

/// Resolved visual values for a [RemixSelect].
@MixableSpec(target: RemixSelect.new, extraStylerMixins: [RemixBoxStylerMixin])
class SelectSpec with _$SelectSpec {
  @override
  final StyleSpec<SelectTriggerSpec> trigger;
  @override
  final StyleSpec<SelectContentSpec> content;
  @override
  @MixableField(forwardStyler: true, stylerSurface: BoxSpec)
  final StyleSpec<FlexBoxSpec> menuContainer;
  @override
  final StyleSpec<SelectMenuItemSpec> item;

  const SelectSpec({
    StyleSpec<SelectTriggerSpec>? trigger,
    StyleSpec<SelectContentSpec>? content,
    StyleSpec<FlexBoxSpec>? menuContainer,
    StyleSpec<SelectMenuItemSpec>? item,
  }) : trigger = trigger ?? const StyleSpec(spec: SelectTriggerSpec()),
       content = content ?? const StyleSpec(spec: SelectContentSpec()),
       item = item ?? const StyleSpec(spec: SelectMenuItemSpec()),
       menuContainer = menuContainer ?? const StyleSpec(spec: FlexBoxSpec());
}

/// Backward-compatible name for [SelectSpec].
///
/// The generated style API is based on [SelectSpec], so resolved values use
/// `SelectSpec` as their runtime type.
typedef RemixSelectSpec = SelectSpec;

/// Resolved visual values for the select trigger.
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class SelectTriggerSpec with _$SelectTriggerSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<TextSpec> placeholder;
  @override
  final StyleSpec<IconSpec> icon;

  /// Style for the collapsed/expanded trigger affordance.
  @override
  final StyleSpec<IconSpec> indicator;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Opacity applied to the collapsed/expanded trigger affordance.
  @override
  final double? indicatorOpacity;
  @override
  final double? placeholderOpacity;

  const SelectTriggerSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? placeholder,
    StyleSpec<IconSpec>? icon,
    StyleSpec<IconSpec>? indicator,
    this.containerEffects,
    this.indicatorOpacity,
    this.placeholderOpacity,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       placeholder = placeholder ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  SelectTriggerSpec lerp(SelectTriggerSpec? other, double t) {
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

/// Backward-compatible name for [SelectTriggerSpec].
///
/// The generated style API is based on [SelectTriggerSpec], so resolved values
/// use `SelectTriggerSpec` as their runtime type.
typedef RemixSelectTriggerSpec = SelectTriggerSpec;

/// Resolved visual values for the select popup content.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class SelectContentSpec with _$SelectContentSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const SelectContentSpec({
    StyleSpec<BoxSpec>? container,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  SelectContentSpec lerp(SelectContentSpec? other, double t) {
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

/// Backward-compatible name for [SelectContentSpec].
///
/// The generated style API is based on [SelectContentSpec], so resolved values
/// use `SelectContentSpec` as their runtime type.
typedef RemixSelectContentSpec = SelectContentSpec;

/// Resolved visual values for a select menu item.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class SelectMenuItemSpec with _$SelectMenuItemSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> text;
  @override
  final StyleSpec<BoxSpec> indicator;
  @override
  final StyleSpec<IconSpec> icon;

  const SelectMenuItemSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [SelectMenuItemSpec].
///
/// The generated style API is based on [SelectMenuItemSpec], so resolved values
/// use `SelectMenuItemSpec` as their runtime type.
typedef RemixSelectMenuItemSpec = SelectMenuItemSpec;
