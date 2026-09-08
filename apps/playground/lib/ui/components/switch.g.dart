// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Switch recipe.
///
/// Remix owns the rendering, the toggle behavior, the switch accessibility
/// role, and — importantly — the thumb's travel: it aligns the thumb to the
/// leading edge when off and the trailing edge when on. This recipe supplies
/// only the two boxes' geometry and their colors.
///
/// `RemixSwitch` requires a `semanticLabel` because a switch has no visible
/// text of its own. That is a Remix rule, not a recipe choice.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's on-track has to be
/// declared as a selected fragment too (`SwitchStyler().onSelected(...)`).
class PlaygroundSwitch extends StatelessWidget {
  const PlaygroundSwitch({
    super.key,
    this.style = const SwitchStyler.create(),
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  final SwitchStyler style;

  final bool selected;

  final String semanticLabel;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixSwitch(
      key: this.key,
      style: playgroundSwitchStyle(style: this.style),
      selected: this.selected,
      semanticLabel: this.semanticLabel,
      onChanged: this.onChanged,
      enabled: this.enabled,
      enableFeedback: this.enableFeedback,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}
