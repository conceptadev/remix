// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Tooltip recipe.
///
/// Remix owns the rendering, the overlay, the anchor positioning, and the
/// hover and focus timing; this recipe supplies the bubble and the three
/// durations that decide when it appears and how long it stays.
///
/// It is the one floating surface here that does *not* use `background`. A
/// tooltip is a transient label, not a panel a reader can act in, and
/// inverting it — `foreground` fill, `background` text — is what makes that
/// difference legible at a glance without a second token.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundTooltip extends StatelessWidget {
  const PlaygroundTooltip({
    super.key,
    this.style = const TooltipStyler.create(),
    required this.tooltipChild,
    required this.child,
    this.tooltipSemantics,
    this.positioning = const OverlayPositionConfig(),
  });

  final TooltipStyler style;

  final Widget tooltipChild;

  final Widget child;

  final String? tooltipSemantics;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixTooltip(
      key: this.key,
      style: playgroundTooltipStyle(style: this.style),
      tooltipChild: this.tooltipChild,
      child: this.child,
      tooltipSemantics: this.tooltipSemantics,
      positioning: this.positioning,
    );
  }
}
