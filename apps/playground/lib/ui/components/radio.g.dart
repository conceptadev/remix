// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Radio recipe.
///
/// Remix owns the rendering, the single-selection behavior, arrow-key
/// traversal within the group, and the radio accessibility role; this recipe
/// supplies the circle, the dot, and the state fragments.
///
/// `RemixRadioGroup` — the behavioral coordinator that owns `groupValue` and
/// the change callback — carries no styler and therefore no recipe. Compose it
/// directly around these:
///
/// ```dart
/// RemixRadioGroup<String>(
///   groupValue: plan,
///   onChanged: (value) => setState(() => plan = value),
///   child: Column(children: const [
///     PlaygroundRadio(value: 'free', semanticLabel: 'Free'),
///     PlaygroundRadio(value: 'pro', semanticLabel: 'Pro'),
///   ]),
/// )
/// ```
///
/// Unlike the checkbox, a radio draws no glyph: the mark is a filled dot
/// inside the ring, which is what tells the two controls apart at a glance
/// even before their shapes register.
///
/// `RemixRadio` requires a `semanticLabel` because it renders no text of its
/// own — the visible label beside it belongs to the caller's layout.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's selected ring has to be
/// declared as a selected fragment too (`RadioStyler().onSelected(...)`).
class PlaygroundRadio<T> extends StatelessWidget {
  const PlaygroundRadio({
    super.key,
    this.style = const RadioStyler.create(),
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
  });

  final RadioStyler style;

  final T value;

  final String semanticLabel;

  final bool enabled;

  final bool toggleable;

  final MouseCursor? mouseCursor;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixRadio<T>(
      key: this.key,
      style: playgroundRadioStyle(style: this.style),
      value: this.value,
      semanticLabel: this.semanticLabel,
      enabled: this.enabled,
      toggleable: this.toggleable,
      mouseCursor: this.mouseCursor,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
