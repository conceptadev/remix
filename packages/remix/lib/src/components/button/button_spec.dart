part of 'button.dart';

/// Placement used when a button contains exactly one icon.
enum RemixIconAlignment { start, end }

/// Resolved visual properties for a [RemixButton].
@MixableSpec(
  target: RemixButton.new,
  extraStylerMixins: [
    RemixBoxStylerMixin,
    LabelStyleMixin,
    IconStyleMixin,
    SpinnerStyleMixin,
  ],
)
class ButtonSpec with _$ButtonSpec {
  /// Styling specification for the button's container.
  @MixableField(forwardStyler: true)
  @override
  final StyleSpec<FlexBoxSpec> container;

  /// Styling specification for the button's text label.
  @override
  final StyleSpec<TextSpec> label;

  /// Styling specification for the button's icon.
  @override
  final StyleSpec<IconSpec> icon;

  /// Styling specification for the button's loading spinner.
  @override
  final StyleSpec<SpinnerSpec> spinner;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  /// Placement used when exactly one icon is present.
  @override
  final RemixIconAlignment? iconAlignment;

  const ButtonSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    StyleSpec<SpinnerSpec>? spinner,
    this.containerEffects,
    this.iconAlignment,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       spinner = spinner ?? const StyleSpec(spec: SpinnerSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  ButtonSpec lerp(ButtonSpec? other, double t) {
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

/// Backward-compatible name for [ButtonSpec].
///
/// The generated button style API is based on [ButtonSpec], so resolved
/// values use `ButtonSpec` as their runtime type.
typedef RemixButtonSpec = ButtonSpec;
