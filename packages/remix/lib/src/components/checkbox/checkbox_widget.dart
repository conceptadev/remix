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
///   label: 'Receive updates',
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
    this.label,
    this.semanticLabel,
    this.minimumTapTargetSize = const Size.square(48),
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const CheckboxStyler.create(),
    this.styleSpec,
  }) : assert(label != '', 'label must not be empty'),
       assert(semanticLabel != '', 'semanticLabel must not be empty');

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
  final CheckboxStyler style;

  /// The style spec for the checkbox.
  final CheckboxSpec? styleSpec;

  static final styleFrom = CheckboxStyler.new;

  /// Whether to provide haptic feedback when the checkbox is toggled.
  /// Defaults to true.
  final bool enableFeedback;

  /// The focus node for the checkbox.
  final FocusNode? focusNode;

  /// Optional visible label included in the checkbox's interaction target.
  ///
  /// The label is also used as the accessible name unless [semanticLabel]
  /// overrides it.
  final String? label;

  /// The semantic label for the checkbox.
  final String? semanticLabel;

  /// Minimum pointer, focus, and semantics target size.
  ///
  /// Defaults to 48 logical pixels on each axis. Pass [Size.zero] to opt into
  /// compact geometry when the surrounding composition provides its own
  /// accessible interaction target.
  final Size minimumTapTargetSize;

  /// Cursor when hovering over the checkbox.
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    assert(
      label == null || label!.trim().isNotEmpty,
      'label must not be blank',
    );
    assert(
      semanticLabel == null || semanticLabel!.trim().isNotEmpty,
      'semanticLabel must not be blank',
    );
    assert(
      minimumTapTargetSize.isFinite &&
          minimumTapTargetSize.width >= 0 &&
          minimumTapTargetSize.height >= 0,
      'minimumTapTargetSize must be finite and non-negative',
    );

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
      semanticLabel: semanticLabel ?? label,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<CheckboxSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedCheckboxState.controllerOf(context),
          builder: (context, spec) {
            final iconData = tristate && selected == null
                ? indeterminateIcon
                : selected == true
                ? checkedIcon
                : uncheckedIcon;

            final checkbox = RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.containerEffects,
              child: iconData != null
                  ? StyledIcon(icon: iconData, styleSpec: spec.indicator)
                  : null,
            );

            final visibleLabel = label;
            final content = visibleLabel == null
                ? Align(widthFactor: 1, heightFactor: 1, child: checkbox)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final labelWidget = ExcludeSemantics(
                        child: StyledText(visibleLabel, styleSpec: spec.label),
                      );

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          checkbox,
                          SizedBox(width: spec.labelSpacing),
                          if (constraints.hasBoundedWidth)
                            Flexible(child: labelWidget)
                          else
                            labelWidget,
                        ],
                      );
                    },
                  );

            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minimumTapTargetSize.width,
                minHeight: minimumTapTargetSize.height,
              ),
              child: content,
            );
          },
        );
      },
    );
  }
}
