part of 'checkbox.dart';

/// Style configuration for [RemixCheckbox] container and indicator icon.
extension RemixCheckboxStylerRemixHelpers on RemixCheckboxStyler {
  /// Sets indicator color.
  RemixCheckboxStyler indicatorColor(Color value) {
    return merge(RemixCheckboxStyler(indicator: IconStyler(color: value)));
  }

  RemixCheckboxStyler onIndeterminate(RemixCheckboxStyler value) {
    return variant(
      ContextVariant(
        'on_indeterminate',
        (context) => NakedCheckboxState.maybeOf(context)?.isChecked == null,
      ),
      value,
    );
  }

  /// Sets checkbox fill color on the container.
  RemixCheckboxStyler fillColor(Color value) {
    return merge(
      RemixCheckboxStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Creates a [RemixCheckbox] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final checkbox = RemixCheckboxStyler()
  ///   .fillColor(Colors.blue)
  ///   .size(24, 24);
  ///
  /// // Use it like a function
  /// checkbox(
  ///   selected: isChecked,
  ///   onChanged: (value) => setState(() => isChecked = value),
  /// )
  /// ```
  RemixCheckbox call({
    Key? key,
    required bool? selected,
    ValueChanged<bool?>? onChanged,
    bool enabled = true,
    bool tristate = false,
    IconData checkedIcon = Icons.check_rounded,
    IconData? uncheckedIcon,
    IconData indeterminateIcon = Icons.horizontal_rule,
    RemixCheckboxIndicatorBuilder? indicatorBuilder,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableFeedback = true,
    String? semanticLabel,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixCheckbox(
      key: key,
      selected: selected,
      onChanged: onChanged,
      enabled: enabled,
      tristate: tristate,
      checkedIcon: checkedIcon,
      uncheckedIcon: uncheckedIcon,
      indeterminateIcon: indeterminateIcon,
      indicatorBuilder: indicatorBuilder,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      semanticLabel: semanticLabel,
      mouseCursor: mouseCursor,
      style: this,
    );
  }

  RemixCheckboxStyler icon(IconStyler value) {
    return merge(RemixCheckboxStyler(indicator: value));
  }

  RemixCheckboxStyler iconColor(Color value) => icon(IconStyler(color: value));

  RemixCheckboxStyler iconSize(double value) => icon(IconStyler(size: value));

  RemixCheckboxStyler iconOpacity(double value) {
    return icon(IconStyler(opacity: value));
  }

  RemixCheckboxStyler iconWeight(double value) {
    return icon(IconStyler(weight: value));
  }

  RemixCheckboxStyler iconGrade(double value) => icon(IconStyler(grade: value));

  RemixCheckboxStyler iconFill(double value) => icon(IconStyler(fill: value));

  RemixCheckboxStyler iconOpticalSize(double value) {
    return icon(IconStyler(opticalSize: value));
  }

  RemixCheckboxStyler iconBlendMode(BlendMode value) {
    return icon(IconStyler(blendMode: value));
  }

  RemixCheckboxStyler iconTextDirection(TextDirection value) {
    return icon(IconStyler(textDirection: value));
  }

  RemixCheckboxStyler iconShadows(List<ShadowMix> value) {
    return icon(IconStyler(shadows: value));
  }

  RemixCheckboxStyler iconShadow(ShadowMix value) {
    return icon(IconStyler(shadows: [value]));
  }
}
