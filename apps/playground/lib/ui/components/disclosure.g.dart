// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disclosure.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Disclosure recipe.
///
/// A single collapsible section: a trigger row and the content it reveals.
/// Remix owns the rendering, the expand and collapse animation, keyboard
/// activation, and the accessibility semantics — including announcing the
/// expanded state; this recipe supplies the trigger row, the content inset,
/// and the state fragments.
///
/// It is deliberately frameless, unlike the card. The accordion is this
/// component's stacked sibling and draws a rule under each section because
/// its rows have neighbours to separate; a lone disclosure has none, so a
/// frame would only box in whatever the caller already placed it inside.
/// The trigger is styled as a self-contained row target instead — same
/// padding, radius, and hover treatment as a menu row, because behaviorally
/// that is what it is: a full-width thing you click.
///
/// The spec carries plain boxes (`trigger`, `content`), not text: the caller
/// passes whole widgets for both, so their type belongs to the caller. The
/// hover and open fills are `accent` and `muted`, which in the shipped themes
/// are near-surface tints the `foreground` text keeps its contrast on.
///
/// Two constructor parameters are deliberately not forwarded to the generated
/// `PlaygroundDisclosure`: `triggerBuilder` and `transitionBuilder`. Both
/// are typed by `package:naked_ui`, which this layer does not depend on.
/// Reach for `RemixDisclosure` directly on the rare call site that needs a
/// state-aware trigger or a custom transition.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state,
/// not by depth: an override that must beat the open trigger's fill has to be
/// declared with `.onExpanded(...)` too.
class PlaygroundDisclosure extends StatelessWidget {
  const PlaygroundDisclosure({
    super.key,
    this.style = const DisclosureStyler.create(),
    required this.trigger,
    required this.content,
    this.expanded,
    this.defaultExpanded = false,
    this.onExpandedChanged,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.animationStyle = const AnimationStyle(
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    ),
  });

  final DisclosureStyler style;

  final Widget trigger;

  final Widget content;

  final bool? expanded;

  final bool defaultExpanded;

  final ValueChanged<bool>? onExpandedChanged;

  final bool enabled;

  final MouseCursor mouseCursor;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final ValueChanged<bool>? onFocusChange;

  final ValueChanged<bool>? onHoverChange;

  final ValueChanged<bool>? onPressChange;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  final AnimationStyle animationStyle;

  @override
  Widget build(BuildContext context) {
    return RemixDisclosure(
      key: this.key,
      style: playgroundDisclosureStyle(style: this.style),
      trigger: this.trigger,
      content: this.content,
      expanded: this.expanded,
      defaultExpanded: this.defaultExpanded,
      onExpandedChanged: this.onExpandedChanged,
      enabled: this.enabled,
      mouseCursor: this.mouseCursor,
      enableFeedback: this.enableFeedback,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      onFocusChange: this.onFocusChange,
      onHoverChange: this.onHoverChange,
      onPressChange: this.onPressChange,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
      animationStyle: this.animationStyle,
    );
  }
}
