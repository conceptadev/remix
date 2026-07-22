part of 'callout.dart';

/// Resolved visual values for a [RemixCallout].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class RemixCalloutSpec with _$RemixCalloutSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> text;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  @MixableField(setterType: RemixSurfaceEffectsMix)
  final RemixSurfaceEffectsSpec? effects;

  const RemixCalloutSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<IconSpec>? icon,
    this.effects,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());

  @override
  RemixCalloutSpec lerp(RemixCalloutSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      effects: RemixSurfaceEffectsSpec.lerpNullable(effects, other.effects, t),
    );
  }
}
