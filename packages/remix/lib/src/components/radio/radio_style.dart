part of 'radio.dart';

/// Style configuration for [RemixRadio] container and selected indicator.
extension RemixRadioStylerRemixHelpers on RadioStyler {
  /// Sets fill color on the container.
  RadioStyler fillColor(Color value) {
    return merge(
      RadioStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the indicator's fill color.
  RadioStyler indicatorColor(Color value) {
    return merge(
      RadioStyler(
        indicator: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }
}
