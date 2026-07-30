part of 'checkbox.dart';

/// A customizable checkbox component that supports various styles and behaviors.
/// The checkbox integrates with the Mix styling system and follows Remix design patterns.
///
/// ## Example
///
/// ```dart
/// RemixCheckbox(
///   selected: _isChecked,
///   onChanged: (value) {
///     setState(() {
///       _isChecked = value;
///     });
///   },
///   checkedIcon: Icons.check_rounded,
/// )
/// ```
///
/// Pair with your own label for accessible layouts:
/// ```dart
/// Row(
///   children: [
///     RemixCheckbox(selected: _isChecked, onChanged: _setChecked),
///     const SizedBox(width: 8),
///     const Text('Accept Terms'),
///   ],
/// )
/// ```
class RemixCheckbox extends StatelessWidget {
  const RemixCheckbox({
    super.key,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.indeterminateIcon = Icons.horizontal_rule,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const RemixCheckboxStyler.create(),
    this.styleSpec,
  });

  /// Whether the checkbox is enabled for interaction.
  final bool enabled;

  /// Whether the checkbox is currently selected.
  /// When [tristate] is true, can be null for indeterminate state.
  final bool? selected;

  /// Whether the checkbox can be true, false, or null (indeterminate).
  final bool tristate;

  /// The icon to display when the checkbox is checked.
  final IconData checkedIcon;

  /// Whether the checkbox should automatically request focus when it is created.
  final bool autofocus;

  /// The icon to display when the checkbox is unchecked.
  final IconData? uncheckedIcon;

  /// The icon to display when the checkbox is in indeterminate state (null value).
  final IconData indeterminateIcon;

  /// The callback function that is called when the checkbox is tapped.
  /// When [tristate] is true, the value can be null.
  final ValueChanged<bool?>? onChanged;

  /// The style configuration for the checkbox.
  final RemixCheckboxStyler style;

  /// The style spec for the checkbox.
  final RemixCheckboxSpec? styleSpec;

  static final styleFrom = RemixCheckboxStyler.new;

  /// Whether to provide haptic feedback when the checkbox is toggled.
  /// Defaults to true.
  final bool enableFeedback;

  /// The focus node for the checkbox.
  final FocusNode? focusNode;

  /// The semantic label for the checkbox.
  final String? semanticLabel;

  /// Cursor when hovering over the checkbox.
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return NakedCheckbox(
      value: selected,
      tristate: tristate,
      onChanged: enabled && onChanged != null
          ? (value) => onChanged!(tristate ? value : (value ?? false))
          : null,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<RemixCheckboxSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedCheckboxState.controllerOf(context),
          builder: (context, spec) {
            final iconData = tristate && selected == null
                ? indeterminateIcon
                : selected == true
                ? checkedIcon
                : uncheckedIcon;

            return RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.containerEffects,
              child: iconData != null
                  ? StyledIcon(icon: iconData, styleSpec: spec.indicator)
                  : null,
            );
          },
        );
      },
    );
  }
}
