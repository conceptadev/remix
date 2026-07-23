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
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixCalloutSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<IconSpec>? icon,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());

  @override
  RemixCalloutSpec lerp(RemixCalloutSpec? other, double t) {
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
