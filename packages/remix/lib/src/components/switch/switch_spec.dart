part of 'switch.dart';

/// Resolved visual values for a [RemixSwitch].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSwitchSpec with _$RemixSwitchSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> thumb;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? thumbSurface;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? thumbOverlay;

  const RemixSwitchSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? thumb,
    this.surface,
    this.overlay,
    this.thumbSurface,
    this.thumbOverlay,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       thumb = thumb ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixSwitchSpec lerp(RemixSwitchSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      surface: RemixSurfaceLayerSpec.lerpNullable(surface, other.surface, t),
      overlay: RemixSurfaceLayerSpec.lerpNullable(overlay, other.overlay, t),
      thumbSurface: RemixSurfaceLayerSpec.lerpNullable(
        thumbSurface,
        other.thumbSurface,
        t,
      ),
      thumbOverlay: RemixSurfaceLayerSpec.lerpNullable(
        thumbOverlay,
        other.thumbOverlay,
        t,
      ),
    );
  }
}
