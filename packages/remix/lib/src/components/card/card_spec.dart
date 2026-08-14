part of 'card.dart';

/// Resolved visual properties for a [RemixCard].
@MixableSpec(target: RemixCard.new, extraStylerMixins: [RemixBoxStylerMixin])
class CardSpec with _$CardSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const CardSpec({StyleSpec<BoxSpec>? container, this.containerEffects})
    : container = container ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  CardSpec lerp(CardSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return CardSpec(
      container: generated.container,
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [CardSpec].
///
/// The generated style API is based on [CardSpec], so resolved values use
/// `CardSpec` as their runtime type.
typedef RemixCardSpec = CardSpec;
