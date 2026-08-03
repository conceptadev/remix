part of 'tooltip.dart';

/// A trigger widget that shows styled overlay content in a tooltip.
///
/// [tooltipChild] is rendered inside the tooltip overlay. [child] is the
/// widget users hover, focus, or long-press to reveal the tooltip.
class RemixTooltip extends StatelessWidget {
  const RemixTooltip({
    super.key,
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
    this.style = const TooltipStyler.create(),
    this.styleSpec,
  });

  /// The style configuration for the tooltip.
  final TooltipStyler style;

  /// The style spec for the tooltip.
  final TooltipSpec? styleSpec;

  /// The widget to display in the tooltip.
  final Widget tooltipChild;

  /// The child widget that will trigger the tooltip.
  final Widget child;

  /// The semantic label for the tooltip.
  final String? tooltipSemantics;

  /// Overlay positioning configuration.
  final OverlayPositionConfig positioning;

  static final styleFrom = TooltipStyler.new;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<TooltipSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return NakedTooltip(
          overlayBuilder: (context, info) => Box(
            styleSpec: spec.container,
            child: StyleSpecBuilder(
              styleSpec: spec.label,
              builder: (context, labelSpec) => DefaultTextStyle.merge(
                style: labelSpec.style,
                child: tooltipChild,
              ),
            ),
          ),
          hoverDelay: spec.waitDuration ?? const Duration(milliseconds: 300),
          // showDuration is touch long-press wait (Material-aligned touchDelay).
          touchDelay: spec.showDuration ?? const Duration(milliseconds: 1500),
          // dismissDuration is hover-exit grace before the tooltip closes.
          dismissDelay:
              spec.dismissDuration ?? const Duration(milliseconds: 100),
          positioning: positioning,
          semanticLabel: tooltipSemantics,
          child: child,
        );
      },
    );
  }
}
