part of 'badge.dart';

/// Resolved visual properties for a [RemixBadge].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin])
class RemixBadgeSpec with _$RemixBadgeSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  const RemixBadgeSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.surface,
    this.overlay,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());
}
