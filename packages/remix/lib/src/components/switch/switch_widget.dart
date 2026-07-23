part of 'switch.dart';

/// A customizable switch component.
///
/// ## Example
///
/// ```dart
/// RemixSwitch(
///   selected: _isEnabled,
///   onChanged: (value) {
///     setState(() {
///       _isEnabled = value;
///     });
///   },
/// )
/// ```
class RemixSwitch extends StatelessWidget {
  const RemixSwitch({
    super.key,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const RemixSwitchStyler.create(),
    this.styleSpec,
  });

  /// Whether this switch is enabled.
  final bool enabled;

  /// Whether the switch is currently selected.
  final bool selected;

  /// Called when the user toggles the switch.
  ///
  /// When null, the switch is visually disabled and does not respond to
  /// interaction.
  final ValueChanged<bool>? onChanged;

  /// The style configuration for the switch.
  final RemixSwitchStyler style;

  /// The style spec for the switch.
  final RemixSwitchSpec? styleSpec;

  static final styleFrom = RemixSwitchStyler.new;

  /// Whether to enable haptic feedback when toggled.
  final bool enableFeedback;

  /// The focus node for the switch.
  final FocusNode? focusNode;

  /// Whether the switch should automatically request focus when it is created.
  final bool autofocus;

  /// The semantic label for the switch.
  final String? semanticLabel;

  /// Cursor when hovering over the switch.
  final MouseCursor mouseCursor;

  RemixSwitchStyler _buildStyle() {
    return RemixSwitchStyler()
        .alignment(.centerLeft)
        // Small thumb inset
        .onSelected(RemixSwitchStyler().alignment(.centerRight))
        .merge(style);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnChanged = enabled && onChanged != null ? onChanged : null;

    return NakedToggle(
      value: selected,
      onChanged: effectiveOnChanged,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      asSwitch: true,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<RemixSwitchSpec>(
          style: _buildStyle(),
          styleSpec: styleSpec,
          controller: NakedToggleState.controllerOf(context),
          builder: (context, spec) {
            return RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.trackEffects,
              child: RemixBoxWithEffects(
                styleSpec: spec.thumb,
                containerEffects: spec.thumbEffects,
              ),
            );
          },
        );
      },
    );
  }
}
