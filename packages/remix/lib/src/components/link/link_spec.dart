part of 'link.dart';

/// Resolved visual properties for a [RemixLink].
///
/// A link is a text run, not a control surface, so the spec carries only a
/// [container] box and a [label] text style. Focus rings and other decoration
/// layers arrive through [containerEffects] rather than extra slots.
@MixableSpec(
  target: RemixLink.new,
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin],
)
class LinkSpec with _$LinkSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const LinkSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  LinkSpec lerp(LinkSpec? other, double t) {
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
