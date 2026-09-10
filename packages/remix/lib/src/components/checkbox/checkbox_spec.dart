part of 'checkbox.dart';

/// Resolved visual properties for a [RemixCheckbox].
@MixableSpec(
  target: RemixCheckbox.new,
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin],
)
class CheckboxSpec with _$CheckboxSpec {
  /// Styling specification for the checkbox box container.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  /// Styling specification for the checkbox indicator icon.
  @override
  final StyleSpec<IconSpec> indicator;

  /// Styling specification for the optional visible checkbox label.
  @override
  final StyleSpec<TextSpec> label;

  /// Gap between the checkbox box and its optional visible label.
  @override
  final double labelSpacing;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const CheckboxSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<TextSpec>? label,
    double? labelSpacing,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       labelSpacing = labelSpacing ?? 8;

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  CheckboxSpec lerp(CheckboxSpec? other, double t) {
    if (other == null) return this;
    final generated = super.lerp(other, t);
    return generated.copyWith(
      containerEffects: RemixBoxEffectsSpec.lerpNullable(
        containerEffects,
        other.containerEffects,
        t,
      ),
    );
  }
}

/// Backward-compatible name for [CheckboxSpec].
///
/// The generated style API is based on [CheckboxSpec], so resolved values use
/// `CheckboxSpec` as their runtime type.
typedef RemixCheckboxSpec = CheckboxSpec;
