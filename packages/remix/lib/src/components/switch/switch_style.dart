part of 'switch.dart';

/// Style builder for [RemixSwitch].
///
/// Use this class to style the switch track and thumb, including selected,
/// focused, disabled, hovered, and pressed state variants.
extension RemixSwitchStylerRemixHelpers on SwitchStyler {
  /// Sets thumb color
  SwitchStyler thumbColor(Color value) {
    return merge(
      SwitchStyler(
        thumb: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the track/rail background color.
  SwitchStyler trackColor(Color value) {
    return color(value);
  }

  /// Creates a [RemixSwitch] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final toggle = SwitchStyler()
  ///   .thumbColor(Colors.white)
  ///   .trackColor(Colors.blue);
  ///
  /// // Use it like a function
  /// toggle(
  ///   selected: _isEnabled,
  ///   onChanged: (value) => setState(() => _isEnabled = value),
  /// )
  /// ```
  RemixSwitch call({
    Key? key,
    required bool selected,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    String? semanticLabel,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixSwitch(
      key: key,
      selected: selected,
      onChanged: onChanged,
      enabled: enabled,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      mouseCursor: mouseCursor,
      style: this,
    );
  }
}
