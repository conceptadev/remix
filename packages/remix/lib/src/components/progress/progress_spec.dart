part of 'progress.dart';

/// Resolved visual values for a [RemixProgress].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixProgressSpec with _$RemixProgressSpec {
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

  const RemixProgressSpec({
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

  @override
  RemixProgressSpec lerp(RemixProgressSpec? other, double t) {
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
