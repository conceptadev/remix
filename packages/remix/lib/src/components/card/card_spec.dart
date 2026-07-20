part of 'card.dart';

/// Resolved visual properties for a [RemixCard].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixCardSpec with _$RemixCardSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;

  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  const RemixCardSpec({
    StyleSpec<BoxSpec>? container,
    this.surface,
    this.overlay,
  }) : container = container ?? const StyleSpec(spec: BoxSpec());

  @override
  RemixCardSpec lerp(RemixCardSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return RemixCardSpec(
      container: generated.container,
      surface: RemixSurfaceLayerSpec.lerpNullable(surface, other.surface, t),
      overlay: RemixSurfaceLayerSpec.lerpNullable(overlay, other.overlay, t),
    );
  }
}
