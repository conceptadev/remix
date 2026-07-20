part of 'tooltip.dart';

/// Style builder for [RemixTooltip].
///
/// Use this class to style tooltip container, label, wait duration, and show
/// duration.
extension RemixTooltipStylerRemixHelpers on RemixTooltipStyler {
  /// Sets tooltip container background color.
  RemixTooltipStyler backgroundColor(Color value) => color(value);

  /// Creates a [RemixTooltip] widget with this style applied.
  RemixTooltip call({
    Key? key,
    required Widget tooltipChild,
    required Widget child,
    String? tooltipSemantics,
    OverlayPositionConfig positioning = const OverlayPositionConfig(),
    bool? open,
    ValueChanged<bool>? onOpenChanged,
    bool disableHoverableContent = false,
    bool enableTapToDismiss = true,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.longPress,
    bool enableFeedback = true,
    TooltipTriggeredCallback? onTriggered,
    AnimationStyle animationStyle = const AnimationStyle(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 150),
      reverseDuration: Duration(milliseconds: 75),
    ),
    bool useRootOverlay = false,
    bool excludeSemantics = false,
    double? minWidth,
    double? maxWidth,
    bool showArrow = false,
    Size arrowSize = const Size(10, 5),
  }) {
    return RemixTooltip(
      key: key,
      tooltipChild: tooltipChild,
      tooltipSemantics: tooltipSemantics,
      positioning: positioning,
      open: open,
      onOpenChanged: onOpenChanged,
      disableHoverableContent: disableHoverableContent,
      enableTapToDismiss: enableTapToDismiss,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      animationStyle: animationStyle,
      useRootOverlay: useRootOverlay,
      excludeSemantics: excludeSemantics,
      minWidth: minWidth,
      maxWidth: maxWidth,
      showArrow: showArrow,
      arrowSize: arrowSize,
      style: this,
      child: child,
    );
  }
}
