part of 'tooltip.dart';

/// Style builder for [RemixTooltip].
///
/// Use this class to style tooltip container, label, wait duration, and show
/// duration.
extension RemixTooltipStylerRemixHelpers on TooltipStyler {
  /// Creates a [RemixTooltip] widget with this style applied.
  RemixTooltip call({
    Key? key,
    required Widget tooltipChild,
    required Widget child,
    String? tooltipSemantics,
    OverlayPositionConfig positioning = const OverlayPositionConfig(),
  }) {
    return RemixTooltip(
      key: key,
      tooltipChild: tooltipChild,
      tooltipSemantics: tooltipSemantics,
      positioning: positioning,
      style: this,
      child: child,
    );
  }
}
