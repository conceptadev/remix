part of 'badge.dart';

/// Resolved visual properties for a [RemixBadge].
@MixableSpec(
  target: RemixBadge.new,
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin],
)
class BadgeSpec with _$BadgeSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const BadgeSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  BadgeSpec lerp(BadgeSpec? other, double t) {
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

/// Backward-compatible name for [BadgeSpec].
///
/// The generated style API is based on [BadgeSpec], so resolved values use
/// `BadgeSpec` as their runtime type.
typedef RemixBadgeSpec = BadgeSpec;
