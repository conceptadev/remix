part of 'progress.dart';

/// Resolved visual values for a [RemixProgress].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixProgressSpec with _$RemixProgressSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> track;
  @override
  final StyleSpec<BoxSpec> indicator;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? indicatorSurface;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? indicatorOverlay;

  const RemixProgressSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? track,
    StyleSpec<BoxSpec>? indicator,
    this.surface,
    this.overlay,
    this.indicatorSurface,
    this.indicatorOverlay,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       track = track ?? const StyleSpec(spec: BoxSpec()),
       indicator = indicator ?? const StyleSpec(spec: BoxSpec());
}
