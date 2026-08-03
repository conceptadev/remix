part of 'radio.dart';

/// Defines the resolved styling structure for [RemixRadio].
///
/// The spec is populated by [RadioStyler] and consumed by the widget when
/// building the control. It provides two [StyleSpec] segments representing the
/// container (outer ring) and the indicator fill shown when the radio is selected.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RadioSpec with _$RadioSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> indicator;

  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? containerEffects;

  const RadioSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? indicator,
    this.containerEffects,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec());

  // Deliberate: route effects through lerpNullable so shadows/blends animate;
  // the generator's default snap-lerps unrecognized spec types.
  @override
  RadioSpec lerp(RadioSpec? other, double t) {
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

/// Backward-compatible name for [RadioSpec].
///
/// The generated style API is based on [RadioSpec], so resolved values use
/// `RadioSpec` as their runtime type.
typedef RemixRadioSpec = RadioSpec;
