part of 'select.dart';

/// Style configuration for an item in a [RemixSelect] menu.
extension RemixSelectMenuItemStylerRemixHelpers on SelectMenuItemStyler {
  /// Sets label styling (delegates to text for consistency with mixin)
  SelectMenuItemStyler label(TextStyler value) {
    return text(value);
  }

  SelectMenuItemStyler labelStyle(TextStyleMix value) {
    return label(TextStyler(style: value));
  }

  SelectMenuItemStyler labelColor(Color value) {
    return label(TextStyler(style: TextStyleMix(color: value)));
  }

  SelectMenuItemStyler labelFontSize(double value) {
    return label(TextStyler(style: TextStyleMix(fontSize: value)));
  }

  SelectMenuItemStyler labelFontWeight(FontWeight value) {
    return label(TextStyler(style: TextStyleMix(fontWeight: value)));
  }

  SelectMenuItemStyler labelFontStyle(FontStyle value) {
    return label(TextStyler(style: TextStyleMix(fontStyle: value)));
  }

  SelectMenuItemStyler labelLetterSpacing(double value) {
    return label(TextStyler(style: TextStyleMix(letterSpacing: value)));
  }

  SelectMenuItemStyler labelDecoration(TextDecoration value) {
    return label(TextStyler(style: TextStyleMix(decoration: value)));
  }

  SelectMenuItemStyler labelFontFamily(String value) {
    return label(TextStyler(style: TextStyleMix(fontFamily: value)));
  }

  SelectMenuItemStyler labelHeight(double value) {
    return label(TextStyler(style: TextStyleMix(height: value)));
  }

  SelectMenuItemStyler labelWordSpacing(double value) {
    return label(TextStyler(style: TextStyleMix(wordSpacing: value)));
  }

  SelectMenuItemStyler labelDecorationColor(Color value) {
    return label(TextStyler(style: TextStyleMix(decorationColor: value)));
  }
}
