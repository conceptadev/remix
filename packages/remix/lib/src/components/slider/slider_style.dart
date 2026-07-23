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

  /// Sets the width of both the unfilled track and selected range.
  RemixSliderStyler thickness(double value) =>
      merge(RemixSliderStyler(trackWidth: value, rangeWidth: value));

  /// Sets the width of the unfilled track.
  RemixSliderStyler trackThickness(double value) =>
      merge(RemixSliderStyler(trackWidth: value));

  /// Sets the width of the selected range.
  RemixSliderStyler rangeThickness(double value) =>
      merge(RemixSliderStyler(rangeWidth: value));

  /// Creates a [RemixSlider] with this style.
  RemixSlider call({
    Key? key,
    double? value,
    List<double>? values,
    ValueChanged<double>? onChanged,
    ValueChanged<double>? onChangeStart,
    ValueChanged<double>? onChangeEnd,
    ValueChanged<List<double>>? onValuesChanged,
    ValueChanged<List<double>>? onValuesChangeStart,
    ValueChanged<List<double>>? onValuesChangeEnd,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onDragChange,
    ValueChanged<bool>? onFocusChange,
    double min = 0,
    double? max,
    double? step,
    int? snapDivisions,
    double minSpacing = 0,
    Axis orientation = Axis.horizontal,
    bool inverted = false,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    List<FocusNode?>? focusNodes,
    int? autofocusThumbIndex,
    List<String?>? semanticLabels,
    List<RemixSliderSemanticFormatterCallback?>? semanticFormatterCallbacks,
    bool excludeSemantics = false,
  }) => RemixSlider(
    key: key,
    value: value,
    values: values,
    onChanged: onChanged,
    onChangeStart: onChangeStart,
    onChangeEnd: onChangeEnd,
    onValuesChanged: onValuesChanged,
    onValuesChangeStart: onValuesChangeStart,
    onValuesChangeEnd: onValuesChangeEnd,
    onHoverChange: onHoverChange,
    onDragChange: onDragChange,
    onFocusChange: onFocusChange,
    min: min,
    max: max,
    step: step,
    snapDivisions: snapDivisions,
    minSpacing: minSpacing,
    orientation: orientation,
    inverted: inverted,
    enabled: enabled,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    focusNode: focusNode,
    autofocus: autofocus,
    focusNodes: focusNodes,
    autofocusThumbIndex: autofocusThumbIndex,
    semanticLabels: semanticLabels,
    semanticFormatterCallbacks: semanticFormatterCallbacks,
    excludeSemantics: excludeSemantics,
    style: this,
  );
}
