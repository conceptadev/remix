// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accordion.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Accordion recipe.
///
/// Remix owns the rendering, the expand and collapse animation, the group
/// coordination, keyboard activation, and the accessibility semantics; this
/// recipe supplies the row, the two icons, the title, and the panel.
///
/// `RemixAccordionGroup` — the behavioral coordinator that owns which values
/// are expanded — carries no styler and therefore no recipe. Compose it
/// directly around these:
///
/// ```dart
/// // `RemixAccordionController` is Remix's alias for the Naked UI type, so
/// // the controller does not pull `package:naked_ui` into this layer.
/// RemixAccordionGroup<String>(
///   controller: RemixAccordionController<String>(),
///   child: Column(children: const [
///     PlaygroundAccordion(
///       value: 'shipping',
///       title: 'Shipping',
///       child: Text('Two to four business days.'),
///     ),
///   ]),
/// )
/// ```
///
/// Each section is separated by a rule along its bottom edge rather than by a
/// box of its own, so a stack of them reads as one list. The `border` token
/// is the same hairline the divider draws, which is what makes a divider
/// between sections indistinguishable from the sections' own edges.
///
/// `builder` is deliberately not forwarded to the generated
/// `PlaygroundAccordion`. Its type is `NakedAccordionTriggerBuilder`,
/// which comes from `package:naked_ui` — a package this layer does not depend
/// on. Use `title` with the icons, or reach for `RemixAccordion` directly on
/// the rare call site that needs to build its own trigger row.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's open title has to be
/// declared as a selected fragment too (`AccordionStyler().onSelected(...)`).
class PlaygroundAccordion<T> extends StatelessWidget {
  const PlaygroundAccordion({
    super.key,
    this.style = const AccordionStyler.create(),
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder,
  });

  final AccordionStyler style;

  final T value;

  final Widget child;

  final String? title;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final bool enabled;

  final MouseCursor mouseCursor;

  final bool enableFeedback;

  final bool autofocus;

  final FocusNode? focusNode;

  final ValueChanged<bool>? onFocusChange;

  final ValueChanged<bool>? onHoverChange;

  final ValueChanged<bool>? onPressChange;

  final String? semanticLabel;

  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixAccordion<T>(
      key: this.key,
      style: playgroundAccordionStyle(style: this.style),
      value: this.value,
      child: this.child,
      title: this.title,
      leadingIcon: this.leadingIcon,
      trailingIcon: this.trailingIcon,
      enabled: this.enabled,
      mouseCursor: this.mouseCursor,
      enableFeedback: this.enableFeedback,
      autofocus: this.autofocus,
      focusNode: this.focusNode,
      onFocusChange: this.onFocusChange,
      onHoverChange: this.onHoverChange,
      onPressChange: this.onPressChange,
      semanticLabel: this.semanticLabel,
      transitionBuilder: this.transitionBuilder,
    );
  }
}
