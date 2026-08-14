part of 'progress.dart';

/// Resolved visual values for a [RemixProgress].
@MixableSpec(
  target: RemixProgress.new,
  extraStylerMixins: [RemixBoxStylerMixin],
)
class ProgressSpec with _$ProgressSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> track;
  @override
  final StyleSpec<BoxSpec> indicator;
  @override
  final StyleSpec<BoxSpec> trackContainer;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? trackEffects;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? indicatorEffects;

  const ProgressSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? track,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<BoxSpec>? trackContainer,
    this.trackEffects,
    this.indicatorEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       track = track ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec()),
       trackContainer = trackContainer ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  ProgressSpec lerp(ProgressSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      trackEffects: RemixBoxEffectsSpec.lerpNullable(
        trackEffects,
        other.trackEffects,
        t,
      ),
      indicatorEffects: RemixBoxEffectsSpec.lerpNullable(
        indicatorEffects,
        other.indicatorEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [ProgressSpec].
///
/// The generated style API is based on [ProgressSpec], so resolved values use
/// `ProgressSpec` as their runtime type.
typedef RemixProgressSpec = ProgressSpec;
