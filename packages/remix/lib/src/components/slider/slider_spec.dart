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
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? trackSurface;

  /// Paint layers above the track.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? trackOverlay;

  /// Layout boundary for the selected range.
  @override
  final StyleSpec<BoxSpec> range;

  /// Paint layers behind the selected range.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? rangeSurface;

  /// Paint layers above the selected range.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? rangeOverlay;

  /// Layout and decoration for every visual thumb.
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> thumb;

  /// Paint layers behind every thumb.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? thumbSurface;

  /// Paint layers above every thumb.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? thumbOverlay;

  /// Additional overlay painted only on the focused thumb.
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? thumbFocusOverlay;

  /// Preferred cross-axis extent of the visual track.
  @override
  final double trackThickness;

  /// Whole-subtree blend used for state recipes such as disabled sliders.
  @override
  final BlendMode? blendMode;

  const RemixSliderSpec({
    StyleSpec<BoxSpec>? track,
    this.trackSurface,
    this.trackOverlay,
    StyleSpec<BoxSpec>? range,
    this.rangeSurface,
    this.rangeOverlay,
    StyleSpec<BoxSpec>? thumb,
    this.thumbSurface,
    this.thumbOverlay,
    this.thumbFocusOverlay,
    double? trackThickness,
    this.blendMode,
  }) : track = track ?? const StyleSpec(spec: BoxSpec()),
       range = range ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec()),
       trackThickness = trackThickness ?? _remixSliderDefaultTrackThickness;
}
