part of 'slider.dart';

const Size _remixSliderDefaultThumbSize = Size.square(16);
const double _remixSliderDefaultTrackThickness = 8;

/// Resolved visuals for a multi-thumb [RemixSlider].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSliderSpec with _$RemixSliderSpec {
  static const Size defaultThumbSize = _remixSliderDefaultThumbSize;
  static const double defaultTrackThickness = _remixSliderDefaultTrackThickness;

  /// Layout boundary for the complete track.
  @override
  final StyleSpec<BoxSpec> track;

  /// Paint layers behind the track.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? trackEffects;

  /// Layout boundary for the selected range.
  @override
  final StyleSpec<BoxSpec> range;

  /// Paint layers behind the selected range.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? rangeEffects;

  /// Layout and decoration for every visual thumb.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> thumb;

  /// Paint layers behind every thumb.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? thumbEffects;

  /// Additional overlay painted only on the focused thumb.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? thumbFocusEffects;

  /// Preferred cross-axis extent of the visual track.
  @override
  final double trackThickness;

  /// Whole-subtree blend used for state recipes such as disabled sliders.
  @override
  final BlendMode? blendMode;

  const RemixSliderSpec({
    StyleSpec<BoxSpec>? track,
    this.trackEffects,
    StyleSpec<BoxSpec>? range,
    this.rangeEffects,
    StyleSpec<BoxSpec>? thumb,
    this.thumbEffects,
    this.thumbFocusEffects,
    double? trackThickness,
    this.blendMode,
  }) : track = track ?? const StyleSpec(spec: BoxSpec()),
       range = range ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec()),
       trackThickness = trackThickness ?? _remixSliderDefaultTrackThickness;

  @override
  RemixSliderSpec lerp(RemixSliderSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      trackEffects: RemixBoxEffectsSpec.lerpNullable(
        trackEffects,
        other.trackEffects,
        t,
      ),
      rangeEffects: RemixBoxEffectsSpec.lerpNullable(
        rangeEffects,
        other.rangeEffects,
        t,
      ),
      thumbEffects: RemixBoxEffectsSpec.lerpNullable(
        thumbEffects,
        other.thumbEffects,
        t,
      ),
      thumbFocusEffects: RemixBoxEffectsSpec.lerpNullable(
        thumbFocusEffects,
        other.thumbFocusEffects,
        t,
      ),
    );
  }
}
