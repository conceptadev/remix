part of 'card.dart';

/// Resolved visual properties for a [RemixCard].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixCardSpec with _$RemixCardSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixCardSpec({StyleSpec<BoxSpec>? container, this.containerEffects})
    : container = container ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  RemixCardSpec lerp(RemixCardSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return RemixCardSpec(
      container: generated.container,
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}
