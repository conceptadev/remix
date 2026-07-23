part of 'popover.dart';

/// Resolved visual properties for a [RemixPopover] overlay.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixPopoverSpec with _$RemixPopoverSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixPopoverSpec({StyleSpec<BoxSpec>? container, this.containerEffects})
    : container = container ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixPopoverSpec lerp(RemixPopoverSpec? other, double t) {
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
