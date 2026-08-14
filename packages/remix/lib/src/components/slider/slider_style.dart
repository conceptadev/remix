part of 'slider.dart';

/// Style builder for [RemixSlider].
///
/// Use this class to customize the thumb, track, and filled range. It supports
/// Mix variants and widget state variants such as disabled, hovered, focused,
/// and pressed states.
extension RemixSliderStylerRemixHelpers on SliderStyler {
  /// Sets thumb color
  SliderStyler thumbColor(Color value) {
    return merge(
      SliderStyler(
        thumb: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets thumb to a fixed [size].
  SliderStyler thumbSize(Size size) {
    return merge(
      SliderStyler(thumb: BoxStyler(constraints: BoxConstraintsMix.size(size))),
    );
  }

  /// Sets stroke width for both track and range.
  SliderStyler thickness(double value) {
    return merge(SliderStyler(trackWidth: value, rangeWidth: value));
  }

  /// Sets stroke width for the track only (background rail).
  SliderStyler trackThickness(double value) {
    return merge(SliderStyler(trackWidth: value));
  }

  /// Sets stroke width for the range only (filled portion).
  SliderStyler rangeThickness(double value) {
    return merge(SliderStyler(rangeWidth: value));
  }
}
