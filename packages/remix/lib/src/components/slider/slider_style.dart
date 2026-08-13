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

  /// Creates a [RemixSlider] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final slider = SliderStyler()
  ///   .thumbColor(Colors.blue)
  ///   .rangeColor(Colors.blue.shade200);
  ///
  /// // Use it like a function
  /// slider(
  ///   value: _sliderValue,
  ///   onChanged: (value) => setState(() => _sliderValue = value),
  /// )
  /// ```
  RemixSlider call({
    Key? key,
    required double value,
    ValueChanged<double>? onChanged,
    ValueChanged<double>? onChangeStart,
    ValueChanged<double>? onChangeEnd,
    double min = 0.0,
    double max = 1.0,
    bool enabled = true,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    int? snapDivisions,
    String? semanticLabel,
    NakedSliderSemanticFormatterCallback? semanticFormatterCallback,
    bool excludeSemantics = false,
  }) {
    return RemixSlider(
      key: key,
      value: value,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      enabled: enabled,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      snapDivisions: snapDivisions,
      semanticLabel: semanticLabel,
      semanticFormatterCallback: semanticFormatterCallback,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
