part of 'callout.dart';

/// Style configuration for [RemixCallout] layout, icon, and text.
extension RemixCalloutStylerRemixHelpers on CalloutStyler {
  /// Sets container background color
  CalloutStyler backgroundColor(Color value) {
    return merge(
      CalloutStyler(
        container: FlexBoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the foreground color (icon and text) of the callout.
  CalloutStyler foregroundColor(Color value) {
    return iconColor(value).textColor(value);
  }

  /// Sets the callout content text style.
  CalloutStyler contentTextStyle(TextStyleMix value) {
    return text(TextStyler(style: value));
  }

  CalloutStyler textColor(Color value) {
    return text(TextStyler(style: TextStyleMix(color: value)));
  }

  CalloutStyler fontSize(double value) {
    return text(TextStyler(style: TextStyleMix(fontSize: value)));
  }

  CalloutStyler fontWeight(FontWeight value) {
    return text(TextStyler(style: TextStyleMix(fontWeight: value)));
  }

  CalloutStyler fontStyle(FontStyle value) {
    return text(TextStyler(style: TextStyleMix(fontStyle: value)));
  }

  CalloutStyler letterSpacing(double value) {
    return text(TextStyler(style: TextStyleMix(letterSpacing: value)));
  }

  CalloutStyler textDecoration(TextDecoration value) {
    return text(TextStyler(style: TextStyleMix(decoration: value)));
  }

  CalloutStyler fontFamily(String value) {
    return text(TextStyler(style: TextStyleMix(fontFamily: value)));
  }

  CalloutStyler textHeight(double value) {
    return text(TextStyler(style: TextStyleMix(height: value)));
  }

  CalloutStyler wordSpacing(double value) {
    return text(TextStyler(style: TextStyleMix(wordSpacing: value)));
  }

  CalloutStyler textDecorationColor(Color value) {
    return text(TextStyler(style: TextStyleMix(decorationColor: value)));
  }

  /// Creates a [RemixCallout] widget with this style applied.
  RemixCallout call({Key? key, String? text, IconData? icon, Widget? child}) {
    return RemixCallout(
      key: key,
      text: text,
      icon: icon,
      style: this,
      child: child,
    );
  }

  CalloutStyler flex(FlexStyler value) {
    return merge(CalloutStyler(container: FlexBoxStyler().flex(value)));
  }
}
