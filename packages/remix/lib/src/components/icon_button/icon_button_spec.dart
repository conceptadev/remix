part of 'icon_button.dart';

/// Resolved visual properties for a [RemixIconButton].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class RemixIconButtonSpec with _$RemixIconButtonSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  final StyleSpec<RemixSpinnerSpec> spinner;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixIconButtonSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       spinner = spinner ?? const StyleSpec(spec: RemixSpinnerSpec());

  @override
  RemixIconButtonSpec lerp(RemixIconButtonSpec? other, double t) {
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
