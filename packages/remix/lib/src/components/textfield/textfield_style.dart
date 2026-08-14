part of 'textfield.dart';

/// Style builder for [RemixTextField].
///
/// Use this class to style the text field container, text, hint text, helper
/// text, label, cursor, selection behavior, and spacing.
extension RemixTextFieldStylerRemixHelpers on TextFieldStyler {
  /// Sets the editable text color.
  ///
  /// Use [TextFieldStyler.color] for the generated container color
  /// shortcut.
  TextFieldStyler textColor(Color value) {
    return merge(
      TextFieldStyler(
        text: TextStyler(style: TextStyleMix(color: value)),
      ),
    );
  }

  /// Sets hint text color
  TextFieldStyler hintColor(Color value) {
    return merge(
      TextFieldStyler(
        hintText: TextStyler(style: TextStyleMix(color: value)),
      ),
    );
  }
}
