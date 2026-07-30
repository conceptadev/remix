part of 'tooltip.dart';

/// Resolved visual values for a [RemixTooltip].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixTooltipSpec with _$RemixTooltipSpec {
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

  const RemixTooltipSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    this.waitDuration = const Duration(milliseconds: 300),
    this.showDuration = const Duration(milliseconds: 1500),
    this.dismissDuration = const Duration(milliseconds: 100),
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec());
}
