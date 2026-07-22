part of 'slider.dart';

/// Formats one thumb value for accessibility services.
typedef RemixSliderSemanticFormatterCallback = String Function(double value);

/// Convenience helpers for [RemixSliderStyler].
extension RemixSliderStylerRemixHelpers on RemixSliderStyler {
  /// Sets the solid thumb fill.
  RemixSliderStyler thumbColor(Color value) =>
      merge(RemixSliderStyler(thumb: BoxStyler().color(value)));

  /// Sets every visual thumb to a fixed [size].
  RemixSliderStyler thumbSize(Size size) => merge(
    RemixSliderStyler(
      thumb: BoxStyler(constraints: BoxConstraintsMix.size(size)),
    ),
  );

  /// Sets the track's cross-axis extent.
  RemixSliderStyler thickness(double value) =>
      merge(RemixSliderStyler(trackThickness: value));

  /// Sets the solid track fill.
  RemixSliderStyler trackColor(Color value) =>
      merge(RemixSliderStyler(track: BoxStyler().color(value)));

  /// Sets the solid selected-range fill.
  RemixSliderStyler rangeColor(Color value) =>
      merge(RemixSliderStyler(range: BoxStyler().color(value)));

  /// Creates a [RemixSlider] with this style.
  RemixSlider call({
    Key? key,
    required List<double> values,
    ValueChanged<List<double>>? onChanged,
    ValueChanged<List<double>>? onChangeStart,
    ValueChanged<List<double>>? onChangeEnd,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onDragChange,
    ValueChanged<bool>? onFocusChange,
    double min = 0,
    double max = 100,
    double step = 1,
    double minSpacing = 0,
    Axis orientation = Axis.horizontal,
    bool inverted = false,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    List<FocusNode?>? focusNodes,
    int? autofocusThumbIndex,
    List<String?>? semanticLabels,
    List<RemixSliderSemanticFormatterCallback?>? semanticFormatterCallbacks,
    bool excludeSemantics = false,
  }) => RemixSlider(
    key: key,
    values: values,
    onChanged: onChanged,
    onChangeStart: onChangeStart,
    onChangeEnd: onChangeEnd,
    onHoverChange: onHoverChange,
    onDragChange: onDragChange,
    onFocusChange: onFocusChange,
    min: min,
    max: max,
    step: step,
    minSpacing: minSpacing,
    orientation: orientation,
    inverted: inverted,
    enabled: enabled,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    focusNodes: focusNodes,
    autofocusThumbIndex: autofocusThumbIndex,
    semanticLabels: semanticLabels,
    semanticFormatterCallbacks: semanticFormatterCallbacks,
    excludeSemantics: excludeSemantics,
    style: this,
  );
}
