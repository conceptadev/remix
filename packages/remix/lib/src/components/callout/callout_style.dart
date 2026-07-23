part of 'callout.dart';

/// Style configuration for [RemixCallout] layout, icon, and text.
extension RemixCalloutStylerRemixHelpers on RemixCalloutStyler {
  /// Sets container background color
  RemixCalloutStyler backgroundColor(Color value) {
    return merge(
      RemixCalloutStyler(
        container: FlexBoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the foreground color (icon and text) of the callout.
  RemixCalloutStyler foregroundColor(Color value) {
    return iconColor(value).textColor(value);
  }

  /// Sets the callout content text style.
  RemixCalloutStyler contentTextStyle(TextStyleMix value) {
    return text(TextStyler(style: value));
  }

  RemixCalloutStyler textColor(Color value) {
    return text(TextStyler(style: TextStyleMix(color: value)));
  }

  RemixCalloutStyler fontSize(double value) {
    return text(TextStyler(style: TextStyleMix(fontSize: value)));
  }

  RemixCalloutStyler fontWeight(FontWeight value) {
    return text(TextStyler(style: TextStyleMix(fontWeight: value)));
  }

  RemixCalloutStyler fontStyle(FontStyle value) {
    return text(TextStyler(style: TextStyleMix(fontStyle: value)));
  }

  RemixCalloutStyler letterSpacing(double value) {
    return text(TextStyler(style: TextStyleMix(letterSpacing: value)));
  }

  RemixCalloutStyler textDecoration(TextDecoration value) {
    return text(TextStyler(style: TextStyleMix(decoration: value)));
  }

  RemixCalloutStyler fontFamily(String value) {
    return text(TextStyler(style: TextStyleMix(fontFamily: value)));
  }

  RemixCalloutStyler textHeight(double value) {
    return text(TextStyler(style: TextStyleMix(height: value)));
  }

  RemixCalloutStyler wordSpacing(double value) {
    return text(TextStyler(style: TextStyleMix(wordSpacing: value)));
  }

  RemixCalloutStyler textDecorationColor(Color value) {
    return text(TextStyler(style: TextStyleMix(decorationColor: value)));
  }

  /// Creates a [RemixCallout] widget with this style applied.
  RemixCallout call({
    Key? key,
    String? text,
    Widget? child,
    IconData? icon,
    Widget? iconWidget,
  }) => RemixCallout(
    key: key,
    text: text,
    child: child,
    icon: icon,
    iconWidget: iconWidget,
    style: this,
  );

  RemixCalloutStyler flex(FlexStyler value) {
    return merge(RemixCalloutStyler(container: FlexBoxStyler().flex(value)));
  }
}
