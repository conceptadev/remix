part of 'radio.dart';

/// A customizable radio button component that integrates with the Mix styling system.
/// Must be used within a RemixRadioGroup for proper functionality.
///
/// ## Examples
///
/// ```dart
/// RemixRadioGroup<String>(
///   groupValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   child: Column(
///     children: [
///       Row(
///         children: [
///           RemixRadio<String>(
///             value: 'option1',
///             semanticLabel: 'Option 1',
///           ),
///           const SizedBox(width: 8),
///           const Text('Option 1'),
///         ],
///       ),
///       Row(
///         children: [
///           RemixRadio<String>(
///             value: 'option2',
///             semanticLabel: 'Option 2',
///           ),
///           const SizedBox(width: 8),
///           const Text('Option 2'),
///         ],
///       ),
///     ],
///   ),
/// )
/// ```
///
class RemixRadio<T> extends StatelessWidget {
  const RemixRadio({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.excludeSemantics = false,
    this.style = const RadioStyler.create(),
    this.styleSpec,
  }) : assert(
         semanticLabel != '',
         'RemixRadio.semanticLabel must be a nonblank accessible name.',
       );

  final RadioStyler style;

  final RadioSpec? styleSpec;

  static final styleFrom = RadioStyler.new;

  /// The value represented by this radio button.
  final T value;

  /// Whether this radio button is enabled.
  final bool enabled;

  /// Whether the radio button should automatically request focus when it is created.
  final bool autofocus;

  /// Whether the radio button is toggleable (can be unselected).
  final bool toggleable;

  /// The focus node for the radio button.
  final FocusNode? focusNode;

  /// The mouse cursor to use when hovering over the radio button.
  final MouseCursor? mouseCursor;

  /// Accessible name for this radio.
  ///
  /// Required and must be nonblank. A bare radio must not be unnamed;
  /// do not rely on adjacent [Text] as the accessible composition.
  final String semanticLabel;

  /// Whether to hide the radio button and its visual subtree from semantics.
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    assert(
      semanticLabel.trim().isNotEmpty,
      'RemixRadio.semanticLabel must be a nonblank accessible name.',
    );
    // NakedRadio owns missing-group validation and group participation.
    return NakedRadio<T>(
      value: value,
      enabled: enabled,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      toggleable: toggleable,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<RadioSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedRadioState.controllerOf<T>(context),
          builder: (context, spec) {
            return RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.containerEffects,
              child: state.isSelected ? Box(styleSpec: spec.indicator) : null,
            );
          },
        );
      },
    );
  }
}
