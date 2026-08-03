part of 'divider.dart';

/// Resolved visual values for a [RemixDivider].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class DividerSpec with _$DividerSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;

  const DividerSpec({StyleSpec<BoxSpec>? container})
    : container = container ?? const StyleSpec(spec: BoxSpec());
}

/// Backward-compatible name for [DividerSpec].
///
/// The generated style API is based on [DividerSpec], so resolved values use
/// `DividerSpec` as their runtime type.
typedef RemixDividerSpec = DividerSpec;
