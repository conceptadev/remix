// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkbox.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Checkbox recipe.
///
/// Everything visual about a checkbox lives in this function: the box
/// geometry, the indicator, the label, and the
/// hover/checked/indeterminate/focus/disabled fragments. Remix keeps
/// ownership of rendering, the tristate transition, pointer and keyboard
/// behavior, the minimum tap target, and the checkbox accessibility
/// semantics — this recipe never reimplements any of that.
///
/// `@MixWidget(target: RemixCheckbox.new)` generates `PlaygroundCheckbox`
/// into `checkbox.g.dart`: an adapter whose constructor is this function's
/// parameters plus every safe `RemixCheckbox` parameter, and whose `build`
/// calls `RemixCheckbox(style: playgroundCheckboxStyle(...), ...)`. Unlike
/// Button there is no `variant` parameter, so the generator emits no named
/// constructors: a checkbox has one look, and its meaningful axes are the
/// runtime states below.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundCheckbox(
///   selected: subscribed,
///   label: 'Email me',
///   style: CheckboxStyler().onSelected(
///     CheckboxStyler().color(const Color(0xFF7C3AED)),
///   ),
///   onChanged: (value) => setState(() => subscribed = value),
/// )
/// ```
///
/// State fragments merge by state, not by depth: an override that must beat
/// the recipe's checked fill has to be declared as a selected fragment too
/// (`CheckboxStyler().onSelected(...)`).
///
/// There is deliberately no pressed fragment. A button needs one because
/// nothing else about it changes on tap; a checkbox flips its own state, and
/// that is the feedback.
class PlaygroundCheckbox extends StatelessWidget {
  const PlaygroundCheckbox({
    super.key,
    this.style = const CheckboxStyler.create(),
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.checkedIcon,
    this.uncheckedIcon,
    this.indeterminateIcon,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.label,
    this.semanticLabel,
    this.minimumTapTargetSize = const Size.square(48),
    this.mouseCursor = SystemMouseCursors.click,
  });

  final CheckboxStyler style;

  final bool? selected;

  final ValueChanged<bool?>? onChanged;

  final bool enabled;

  final bool tristate;

  final IconData? checkedIcon;

  final IconData? uncheckedIcon;

  final IconData? indeterminateIcon;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool enableFeedback;

  final String? label;

  final String? semanticLabel;

  final Size minimumTapTargetSize;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixCheckbox(
      key: this.key,
      style: playgroundCheckboxStyle(style: this.style),
      selected: this.selected,
      onChanged: this.onChanged,
      enabled: this.enabled,
      tristate: this.tristate,
      checkedIcon: this.checkedIcon,
      uncheckedIcon: this.uncheckedIcon,
      indeterminateIcon: this.indeterminateIcon,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      enableFeedback: this.enableFeedback,
      label: this.label,
      semanticLabel: this.semanticLabel,
      minimumTapTargetSize: this.minimumTapTargetSize,
      mouseCursor: this.mouseCursor,
    );
  }
}

/// The application's Checkbox recipe for one option in a checkbox group.
///
/// `RemixCheckboxGroup` is behavioral: it owns the selected set and the
/// group-wide enabled and required configuration, and carries no styler of
/// its own. Without this second adapter every option in a group would need
/// the recipe attached by hand, and one missed option in a loop would render
/// unstyled beside its styled siblings.
///
/// It delegates to [playgroundCheckboxStyle] rather than restating it:
/// a group option is the same checkbox, so editing the recipe above restyles
/// both.
class PlaygroundCheckboxGroupItem<T extends Object> extends StatelessWidget {
  const PlaygroundCheckboxGroupItem({
    super.key,
    this.style = const CheckboxStyler.create(),
    required this.value,
    required this.label,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.checkedIcon,
    this.uncheckedIcon,
    this.enableFeedback = true,
    this.minimumTapTargetSize = const Size.square(48),
    this.mouseCursor = SystemMouseCursors.click,
  });

  final CheckboxStyler style;

  final T value;

  final String label;

  final String? semanticLabel;

  final bool enabled;

  final FocusNode? focusNode;

  final bool autofocus;

  final IconData? checkedIcon;

  final IconData? uncheckedIcon;

  final bool enableFeedback;

  final Size minimumTapTargetSize;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixCheckboxGroupItem<T>(
      key: this.key,
      style: playgroundCheckboxGroupItemStyle(style: this.style),
      value: this.value,
      label: this.label,
      semanticLabel: this.semanticLabel,
      enabled: this.enabled,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      checkedIcon: this.checkedIcon,
      uncheckedIcon: this.uncheckedIcon,
      enableFeedback: this.enableFeedback,
      minimumTapTargetSize: this.minimumTapTargetSize,
      mouseCursor: this.mouseCursor,
    );
  }
}
