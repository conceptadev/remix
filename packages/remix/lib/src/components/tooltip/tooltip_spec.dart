part of 'tooltip.dart';

/// Resolved visual values for a [RemixTooltip].
@MixableSpec(target: RemixTooltip.new, extraStylerMixins: [RemixBoxStylerMixin])
class TooltipSpec with _$TooltipSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final Duration? waitDuration;
  @override
  final Duration? showDuration;
  @override
  final Duration? dismissDuration;

  const TooltipSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.waitDuration = const Duration(milliseconds: 300),
    this.showDuration = const Duration(milliseconds: 1500),
    this.dismissDuration = const Duration(milliseconds: 100),
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());
}

/// Backward-compatible name for [TooltipSpec].
///
/// The generated style API is based on [TooltipSpec], so resolved values use
/// `TooltipSpec` as their runtime type.
typedef RemixTooltipSpec = TooltipSpec;
