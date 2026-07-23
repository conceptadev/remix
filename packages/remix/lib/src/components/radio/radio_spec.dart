part of 'radio.dart';

/// Defines the resolved styling structure for [RemixRadio].
///
/// The spec is populated by [RemixRadioStyler] and consumed by the widget when
/// building the control. It provides two [StyleSpec] segments representing the
/// container (outer ring) and the indicator fill shown when the radio is selected.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixRadioSpec with _$RemixRadioSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> indicator;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RemixRadioSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? indicator,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixRadioSpec lerp(RemixRadioSpec? other, double t) {
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
