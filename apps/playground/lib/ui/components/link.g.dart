// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Link recipe.
///
/// Remix owns the link role, the destination, focus, activation, and the rule
/// that a link with no callback is a disabled link; this recipe supplies only
/// its color and its underline.
///
/// It sets no font size on purpose. A link is inline text, so it should take
/// the size and weight of the paragraph around it — a fixed size here would
/// make a link inside a heading render at body scale.
///
/// The color is `foreground`, not `primary`. This theme's `primary` is a
/// near-neutral fill color rather than a link hue, so a `primary` link would
/// read as body text with no affordance at all. Underlining is what marks it,
/// which also means the link is still identifiable without color — an
/// application that has a brand link color changes the two `.color(...)` calls
/// below.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's hover color has to be
/// declared as a hover fragment too (`LinkStyler().onHovered(...)`).
class PlaygroundLink extends StatelessWidget {
  const PlaygroundLink({
    super.key,
    this.style = const LinkStyler.create(),
    this.label,
    this.child,
    this.onPressed,
    this.enabled = true,
    this.linkUrl,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
  });

  final LinkStyler style;

  final String? label;

  final Widget? child;

  final VoidCallback? onPressed;

  final bool enabled;

  final Uri? linkUrl;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool enableFeedback;

  final MouseCursor mouseCursor;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixLink(
      key: this.key,
      style: playgroundLinkStyle(style: this.style),
      label: this.label,
      child: this.child,
      onPressed: this.onPressed,
      enabled: this.enabled,
      linkUrl: this.linkUrl,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      enableFeedback: this.enableFeedback,
      mouseCursor: this.mouseCursor,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
