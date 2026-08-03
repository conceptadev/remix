part of 'checkbox.dart';

/// Style configuration for [RemixCheckbox] container and indicator icon.
extension RemixCheckboxStylerRemixHelpers on CheckboxStyler {
  /// Sets indicator color.
  CheckboxStyler indicatorColor(Color value) {
    return merge(CheckboxStyler(indicator: IconStyler(color: value)));
  }

  CheckboxStyler onIndeterminate(CheckboxStyler value) {
    return variant(
      ContextVariant(
        'on_indeterminate',
        (context) => NakedCheckboxState.maybeOf(context)?.isChecked == null,
      ),
      value,
    );
  }

  /// Sets checkbox fill color on the container.
  CheckboxStyler fillColor(Color value) {
    return merge(
      CheckboxStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Creates a [RemixCheckbox] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final checkbox = CheckboxStyler()
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
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      semanticLabel: semanticLabel,
      mouseCursor: mouseCursor,
      style: this,
    );
  }

  CheckboxStyler icon(IconStyler value) {
    return merge(CheckboxStyler(indicator: value));
  }

  CheckboxStyler iconColor(Color value) => icon(IconStyler(color: value));

  CheckboxStyler iconSize(double value) => icon(IconStyler(size: value));

  CheckboxStyler iconOpacity(double value) {
    return icon(IconStyler(opacity: value));
  }

  CheckboxStyler iconWeight(double value) {
    return icon(IconStyler(weight: value));
  }

  CheckboxStyler iconGrade(double value) => icon(IconStyler(grade: value));

  CheckboxStyler iconFill(double value) => icon(IconStyler(fill: value));

  CheckboxStyler iconOpticalSize(double value) {
    return icon(IconStyler(opticalSize: value));
  }

  CheckboxStyler iconBlendMode(BlendMode value) {
    return icon(IconStyler(blendMode: value));
  }

  CheckboxStyler iconTextDirection(TextDirection value) {
    return icon(IconStyler(textDirection: value));
  }

  CheckboxStyler iconShadows(List<ShadowMix> value) {
    return icon(IconStyler(shadows: value));
  }

  CheckboxStyler iconShadow(ShadowMix value) {
    return icon(IconStyler(shadows: [value]));
  }
}
