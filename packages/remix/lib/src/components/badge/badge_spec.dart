part of 'badge.dart';

/// Resolved visual properties for a [RemixBadge].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin])
class RemixBadgeSpec with _$RemixBadgeSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  @MixableField(setterType: RemixSurfaceEffectsMix)
  final RemixSurfaceEffectsSpec? effects;

  const RemixBadgeSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.effects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());

  @override
  RemixBadgeSpec lerp(RemixBadgeSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      effects: RemixSurfaceEffectsSpec.lerpNullable(effects, other.effects, t),
    );
  }
}
