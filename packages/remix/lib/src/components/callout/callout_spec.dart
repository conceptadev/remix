part of 'callout.dart';

/// Resolved visual values for a [RemixCallout].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class RemixCalloutSpec with _$RemixCalloutSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  @override
  final StyleSpec<TextSpec> text;
  @override
  final StyleSpec<IconSpec> icon;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? surface;
  @override
  @MixableField(setterType: RemixSurfaceLayerMix)
  final RemixSurfaceLayerSpec? overlay;

  const RemixCalloutSpec({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<IconSpec>? icon,
    this.surface,
    this.overlay,
  }) : container = container ?? const StyleSpec(spec: FlexBoxSpec()),
       text = text ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}
