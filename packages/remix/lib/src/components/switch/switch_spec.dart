part of 'switch.dart';

/// Resolved visual values for a [RemixSwitch].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSwitchSpec with _$RemixSwitchSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> thumb;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? trackEffects;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? thumbEffects;

  const RemixSwitchSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? thumb,
    this.trackEffects,
    this.thumbEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixSwitchSpec lerp(RemixSwitchSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      trackEffects: RemixBoxEffectsSpec.lerpNullable(
        trackEffects,
        other.trackEffects,
        t,
      ),
      thumbEffects: RemixBoxEffectsSpec.lerpNullable(
        thumbEffects,
        other.thumbEffects,
        t,
      ),
    );
  }
}
