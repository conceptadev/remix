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
    this.open,
    this.onOpenChanged,
    this.disableHoverableContent = false,
    this.enableTapToDismiss = true,
    this.triggerMode = TooltipTriggerMode.longPress,
    this.enableFeedback = true,
    this.onTriggered,
    this.animationStyle = const AnimationStyle(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 150),
      reverseDuration: Duration(milliseconds: 75),
    ),
    this.useRootOverlay = false,
    this.excludeSemantics = false,
    this.minWidth,
    this.maxWidth,
    this.showArrow = false,
    this.arrowSize = const Size(10, 5),
    this.style = const RemixTooltipStyler.create(),
    this.styleSpec,
  }) : assert(minWidth == null || minWidth >= 0),
       assert(maxWidth == null || maxWidth >= 0),
       assert(
         minWidth == null || maxWidth == null || minWidth <= maxWidth,
         'Tooltip minWidth must not exceed maxWidth.',
       );

  /// The style configuration for the tooltip.
  final RemixTooltipStyler style;

  /// The style spec for the tooltip.
  final RemixTooltipSpec? styleSpec;

  /// The widget to display in the tooltip.
  final Widget tooltipChild;

  /// The child widget that will trigger the tooltip.
  final Widget child;

  /// The semantic label for the tooltip.
  final String? tooltipSemantics;

  /// Overlay positioning configuration.
  final OverlayPositionConfig positioning;

  /// Whether the tooltip is controlled open, or null for internal state.
  final bool? open;

  /// Receives user requests to change [open].
  final ValueChanged<bool>? onOpenChanged;

  /// Whether entering the overlay content does not keep it open.
  final bool disableHoverableContent;

  /// Whether an outside tap dismisses an open tooltip.
  final bool enableTapToDismiss;

  /// Touch/stylus activation behavior.
  final TooltipTriggerMode triggerMode;

  /// Whether touch activation emits platform feedback.
  final bool enableFeedback;

  /// Called when touch input triggers the tooltip.
  final TooltipTriggeredCallback? onTriggered;

  /// Overlay show and hide animation configuration.
  final AnimationStyle animationStyle;

  /// Whether to insert the content in the root overlay.
  final bool useRootOverlay;

  /// Whether to hide tooltip semantics from the trigger subtree.
  final bool excludeSemantics;

  /// Optional minimum content width.
  final double? minWidth;

  /// Optional maximum content width.
  final double? maxWidth;

  /// Whether to paint an arrow toward the trigger.
  final bool showArrow;

  /// Width and height of the arrow triangle.
  final Size arrowSize;

  static final styleFrom = RemixTooltipStyler.new;

  @override
  Widget build(BuildContext context) {
    BuildContext? triggerContext;

    return RemixStyleSpecBuilder<RemixTooltipSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return NakedTooltip(
          overlayBuilder: (context, info) => _RemixTooltipOverlay(
            minWidth: minWidth,
            maxWidth: maxWidth,
            showArrow: showArrow,
            arrowSize: arrowSize,
            arrowColor: spec.arrowColor,
            triggerContext: () => triggerContext,
            child: Box(
              styleSpec: spec.container,
              child: StyleSpecBuilder(
                styleSpec: spec.label,
                builder: (context, labelSpec) => DefaultTextStyle.merge(
                  style: labelSpec.style,
                  child: tooltipChild,
                ),
              ),
            ),
          ),
          hoverDelay: spec.waitDuration ?? const Duration(milliseconds: 300),
          // showDuration is the post-activation touch visibility interval.
          touchDelay: spec.showDuration ?? const Duration(milliseconds: 1500),
          // dismissDuration is hover-exit grace before the tooltip closes.
          dismissDelay:
              spec.dismissDuration ?? const Duration(milliseconds: 100),
          open: open,
          onOpenChanged: onOpenChanged,
          disableHoverableContent: disableHoverableContent,
          enableTapToDismiss: enableTapToDismiss,
          triggerMode: triggerMode,
          enableFeedback: enableFeedback,
          onTriggered: onTriggered,
          animationStyle: animationStyle,
          positioning: positioning,
          useRootOverlay: useRootOverlay,
          semanticLabel: tooltipSemantics,
          excludeSemantics: excludeSemantics,
          child: Builder(
            builder: (context) {
              triggerContext = context;
              return child;
            },
          ),
        );
      },
    );
  }
}

class _RemixTooltipOverlay extends StatelessWidget {
  const _RemixTooltipOverlay({
    required this.minWidth,
    required this.maxWidth,
    required this.showArrow,
    required this.arrowSize,
    required this.arrowColor,
    required this.triggerContext,
    required this.child,
  });

  final double? minWidth;
  final double? maxWidth;
  final bool showArrow;
  final Size arrowSize;
  final Color? arrowColor;
  final BuildContext? Function() triggerContext;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final constrained = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: child,
    );
    if (!showArrow || arrowSize.isEmpty || arrowColor == null) {
      return constrained;
    }

    final placement = OverlayPlacement.of(context);
    final padding = switch (placement.side) {
      .top => EdgeInsets.only(bottom: arrowSize.height),
      .bottom => EdgeInsets.only(top: arrowSize.height),
      .left => EdgeInsets.only(right: arrowSize.height),
      .right => EdgeInsets.only(left: arrowSize.height),
    };

    return Builder(
      builder: (paintContext) => CustomPaint(
        foregroundPainter: _RemixTooltipArrowPainter(
          placement: placement,
          arrowSize: arrowSize,
          color: arrowColor!,
          triggerContext: triggerContext,
          paintContext: paintContext,
        ),
        child: Padding(padding: padding, child: constrained),
      ),
    );
  }
}

class _RemixTooltipArrowPainter extends CustomPainter {
  const _RemixTooltipArrowPainter({
    required this.placement,
    required this.arrowSize,
    required this.color,
    required this.triggerContext,
    required this.paintContext,
  });

  final OverlayPlacement placement;
  final Size arrowSize;
  final Color color;
  final BuildContext? Function() triggerContext;
  final BuildContext paintContext;

  Offset? _triggerCenter() {
    final triggerBox = triggerContext()?.findRenderObject();
    final paintBox = paintContext.findRenderObject();
    if (triggerBox is! RenderBox ||
        paintBox is! RenderBox ||
        !triggerBox.attached ||
        !paintBox.attached) {
      return null;
    }

    final globalCenter = triggerBox.localToGlobal(
      triggerBox.size.center(Offset.zero),
    );
    return paintBox.globalToLocal(globalCenter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final tip = debugArrowTip(size);
    final path = Path();
    switch (placement.side) {
      case .top:
        final base = size.height - arrowSize.height;
        path
          ..moveTo(tip.dx - arrowSize.width / 2, base)
          ..lineTo(tip.dx + arrowSize.width / 2, base)
          ..lineTo(tip.dx, tip.dy);
        break;
      case .bottom:
        path
          ..moveTo(tip.dx, tip.dy)
          ..lineTo(tip.dx + arrowSize.width / 2, arrowSize.height)
          ..lineTo(tip.dx - arrowSize.width / 2, arrowSize.height);
        break;
      case .left:
        final base = size.width - arrowSize.height;
        path
          ..moveTo(base, tip.dy - arrowSize.width / 2)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(base, tip.dy + arrowSize.width / 2);
        break;
      case .right:
        path
          ..moveTo(tip.dx, tip.dy)
          ..lineTo(arrowSize.height, tip.dy + arrowSize.width / 2)
          ..lineTo(arrowSize.height, tip.dy - arrowSize.width / 2);
        break;
    }
    canvas.drawPath(path..close(), Paint()..color = color);
  }

  @visibleForTesting
  Offset debugArrowTip(Size size) {
    final triggerCenter = _triggerCenter();
    return switch (placement.side) {
      .top => Offset(
        _clampArrowCenter(
          triggerCenter?.dx ?? size.width / 2,
          extent: arrowSize.width,
          available: size.width,
        ),
        size.height,
      ),
      .bottom => Offset(
        _clampArrowCenter(
          triggerCenter?.dx ?? size.width / 2,
          extent: arrowSize.width,
          available: size.width,
        ),
        0,
      ),
      .left => Offset(
        size.width,
        _clampArrowCenter(
          triggerCenter?.dy ?? size.height / 2,
          extent: arrowSize.width,
          available: size.height,
        ),
      ),
      .right => Offset(
        0,
        _clampArrowCenter(
          triggerCenter?.dy ?? size.height / 2,
          extent: arrowSize.width,
          available: size.height,
        ),
      ),
    };
  }

  @override
  bool shouldRepaint(_RemixTooltipArrowPainter oldDelegate) =>
      placement != oldDelegate.placement ||
      arrowSize != oldDelegate.arrowSize ||
      color != oldDelegate.color ||
      triggerContext != oldDelegate.triggerContext ||
      paintContext != oldDelegate.paintContext;
}

double _clampArrowCenter(
  double value, {
  required double extent,
  required double available,
}) {
  final halfExtent = extent / 2;
  if (available <= extent) return available / 2;
  return value.clamp(halfExtent, available - halfExtent);
}
