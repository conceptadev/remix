part of 'checkbox.dart';

final _onIndeterminateVariant = ContextVariant(
  'on_indeterminate',
  (context) => NakedCheckboxState.maybeOf(context)?.isChecked == null,
);

/// Style configuration for [RemixCheckbox] container and indicator icon.
extension RemixCheckboxStylerRemixHelpers on CheckboxStyler {
  /// Sets indicator color.
  CheckboxStyler indicatorColor(Color value) {
    return merge(CheckboxStyler(indicator: IconStyler(color: value)));
  }

  CheckboxStyler onIndeterminate(CheckboxStyler value) {
    return variant(_onIndeterminateVariant, value);
  }

  /// Sets checkbox fill color on the container.
  CheckboxStyler fillColor(Color value) {
    return merge(
      CheckboxStyler(
        container: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
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
