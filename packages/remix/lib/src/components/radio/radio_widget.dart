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
///           RemixRadio<String>(value: 'option1'),
///           const SizedBox(width: 8),
///           const Text('Option 1'),
///         ],
///       ),
///       Row(
///         children: [
///           RemixRadio<String>(value: 'option2'),
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
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.style = const RemixRadioStyler.create(),
    this.styleSpec,
  });

  final RemixRadioStyler style;

  final RemixRadioSpec? styleSpec;

  static final styleFrom = RemixRadioStyler.new;

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

  @override
  Widget build(BuildContext context) {
    final registry = RadioGroup.maybeOf<T>(context);
    final groupScope = _RemixRadioGroupScope.maybeOf<T>(context);

    // Always require registry - same as NakedRadio
    if (registry == null) {
      throw FlutterError.fromParts([
        ErrorSummary(
          'RemixRadio<$T> must be used within a RemixRadioGroup<$T>.',
        ),
        ErrorDescription(
          'No RemixRadioGroup<$T> ancestor was found in the widget tree.',
        ),
        ErrorHint(
          'Wrap your RemixRadio widgets with a RemixRadioGroup:\n'
          'RemixRadioGroup<$T>(\n'
          '  groupValue: selectedValue,\n'
          '  onChanged: (value) { ... },\n'
          '  child: Column(\n'
          '    children: [\n'
          '      RemixRadio<$T>(value: ...),\n'
          '      RemixRadio<$T>(value: ...),\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
      ]);
    }

    final effectiveEnabled = enabled && (groupScope?.enabled ?? true);

    // Check if selected
    final isSelected = registry.groupValue == value;

    // NakedRadio handles semantics through RawRadio - no need for wrapper
    return NakedRadio<T>(
      value: value,
      enabled: effectiveEnabled,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      toggleable: toggleable,
      builder: (context, _, __) {
        return RemixStyleSpecBuilder<RemixRadioSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedRadioState.controllerOf<T>(context),
          builder: (context, spec) {
            return RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.containerEffects,
              child: isSelected ? Box(styleSpec: spec.indicator) : null,
            );
          },
        );
      },
    );
  }
}
