part of 'icon_button.dart';

/// Resolved visual properties for a [RemixIconButton].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class RemixIconButtonSpec with _$RemixIconButtonSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  final StyleSpec<RemixSpinnerSpec> spinner;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  const RemixIconButtonSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    this.surface,
    this.overlay,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec()),
       spinner = spinner ?? const StyleSpec(spec: RemixSpinnerSpec());

  @override
  RemixIconButtonSpec lerp(RemixIconButtonSpec? other, double t) {
    final generated = super.lerp(other, t);
    if (other == null) return generated;
    return generated.copyWith(
      surface: RemixSurfaceLayerSpec.lerpNullable(surface, other.surface, t),
      overlay: RemixSurfaceLayerSpec.lerpNullable(overlay, other.overlay, t),
    );
  }
}
