part of 'switch.dart';

/// A customizable switch component.
///
/// ## Example
///
/// ```dart
/// RemixSwitch(
///   semanticLabel: 'Enable feature',
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
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const SwitchStyler.create(),
    this.styleSpec,
  }) : assert(
         semanticLabel != '',
         'RemixSwitch.semanticLabel must be a nonblank accessible name.',
       );

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
  final SwitchStyler style;

  /// The style spec for the switch.
  final SwitchSpec? styleSpec;

  static final styleFrom = SwitchStyler.new;

  /// Whether to enable haptic feedback when toggled.
  final bool enableFeedback;

  /// The focus node for the switch.
  final FocusNode? focusNode;

  /// Whether the switch should automatically request focus when it is created.
  final bool autofocus;

  /// Accessible name for this switch.
  ///
  /// Required and must be nonblank. A bare switch must not be unnamed;
  /// do not rely on adjacent [Text] as the accessible composition.
  final String semanticLabel;

  /// Whether to hide the switch and its visual subtree from semantics.
  final bool excludeSemantics;

  /// Cursor when hovering over the switch.
  final MouseCursor mouseCursor;

  SwitchStyler _buildStyle() {
    return SwitchStyler()
        .alignment(.centerLeft)
        // Small thumb inset
        .onSelected(SwitchStyler().alignment(.centerRight))
        .merge(style);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      semanticLabel.trim().isNotEmpty,
      'RemixSwitch.semanticLabel must be a nonblank accessible name.',
    );
    // Forwarded raw: NakedToggle derives interactivity from
    // enabled && onChanged != null itself.
    return NakedToggle(
      value: selected,
      onChanged: onChanged,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      asSwitch: true,
      excludeSemantics: excludeSemantics,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<SwitchSpec>(
          style: _buildStyle(),
          styleSpec: styleSpec,
          controller: NakedToggleState.controllerOf(context),
          builder: (context, spec) {
            return RemixBoxAdapter(
              styleSpec: spec.container,
              containerEffects: spec.trackEffects,
              child: RemixBoxAdapter(
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
