part of 'slider.dart';

const Size _remixSliderDefaultThumbSize = Size.square(16);
const double _remixSliderDefaultTrackThickness = 8;
const Color _remixSliderDefaultTrackColor = MixColors.grey;
const Color _remixSliderDefaultRangeColor = MixColors.black;

/// Resolved visuals for a multi-thumb [RemixSlider].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSliderSpec with _$RemixSliderSpec {
  static const Size defaultThumbSize = _remixSliderDefaultThumbSize;
  static const double defaultTrackStrokeWidth =
      _remixSliderDefaultTrackThickness;

  /// Preferred alias for [defaultTrackStrokeWidth].
  static const double defaultTrackThickness = _remixSliderDefaultTrackThickness;

  /// Layout boundary for the complete track.
  @override
  final StyleSpec<BoxSpec> track;

  /// Established solid-color track API.
  @override
  final Color trackColor;

  /// Established unfilled-track width API.
  @override
  final double trackWidth;

  /// Paint layers behind the track.
  @override
  @MixableField(setterType: RemixBoxEffectsMix)
  final RemixBoxEffectsSpec? trackEffects;

  /// Layout boundary for the selected range.
  @override
  final StyleSpec<BoxSpec> range;

  /// Established solid-color selected-range API.
  @override
  final Color rangeColor;

  /// Established selected-range width API.
  @override
  final double rangeWidth;

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

  /// Whole-subtree blend used for state recipes such as disabled sliders.
  @override
  final BlendMode? blendMode;

  const RemixSliderSpec({
    StyleSpec<BoxSpec>? track,
    Color? trackColor,
    double? trackWidth,
    this.trackEffects,
    StyleSpec<BoxSpec>? range,
    Color? rangeColor,
    double? rangeWidth,
    this.rangeEffects,
    StyleSpec<BoxSpec>? thumb,
    this.thumbEffects,
    this.thumbFocusEffects,
    this.blendMode,
  }) : trackColor = trackColor ?? _remixSliderDefaultTrackColor,
       trackWidth = trackWidth ?? _remixSliderDefaultTrackThickness,
       rangeColor = rangeColor ?? _remixSliderDefaultRangeColor,
       rangeWidth = rangeWidth ?? _remixSliderDefaultTrackThickness,
       track = track ?? const StyleSpec(spec: BoxSpec()),
       range = range ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec());

  /// Largest track or range width used for layout clearance.
  double get trackThickness => math.max(trackWidth, rangeWidth);

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
