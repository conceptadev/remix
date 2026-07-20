part of 'popover.dart';

/// Resolved visual properties for a [RemixPopover] overlay.
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixPopoverSpec with _$RemixPopoverSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;

  const RemixPopoverSpec({StyleSpec<BoxSpec>? container, this.surface})
    : container = container ?? const StyleSpec(spec: BoxSpec());
}
