part of 'divider.dart';

/// Resolved visual values for a [RemixDivider].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixDividerSpec with _$RemixDividerSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  @override
  final double? thickness;

  const RemixDividerSpec({StyleSpec<BoxSpec>? container, this.thickness})
    : container = container ?? const StyleSpec(spec: BoxSpec());
}
