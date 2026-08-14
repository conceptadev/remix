part of 'icon_button.dart';

/// Resolved visual properties for a [RemixIconButton].
@MixableSpec(
  target: RemixIconButton.new,
  extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin],
)
class IconButtonSpec with _$IconButtonSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  final StyleSpec<SpinnerSpec> spinner;
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const IconButtonSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? icon,
    StyleSpec<SpinnerSpec>? spinner,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       spinner = spinner ?? const StyleSpec(spec: SpinnerSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  IconButtonSpec lerp(IconButtonSpec? other, double t) {
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

/// Backward-compatible name for [IconButtonSpec].
///
/// The generated style API is based on [IconButtonSpec], so resolved values use
/// `IconButtonSpec` as their runtime type.
typedef RemixIconButtonSpec = IconButtonSpec;
