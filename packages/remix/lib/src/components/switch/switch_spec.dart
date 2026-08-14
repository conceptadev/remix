part of 'switch.dart';

/// Resolved visual values for a [RemixSwitch].
@MixableSpec(target: RemixSwitch.new, extraStylerMixins: [RemixBoxStylerMixin])
class SwitchSpec with _$SwitchSpec {
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

  const SwitchSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? thumb,
    this.trackEffects,
    this.thumbEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  SwitchSpec lerp(SwitchSpec? other, double t) {
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

/// Backward-compatible name for [SwitchSpec].
///
/// The generated style API is based on [SwitchSpec], so resolved values use
/// `SwitchSpec` as their runtime type.
typedef RemixSwitchSpec = SwitchSpec;
