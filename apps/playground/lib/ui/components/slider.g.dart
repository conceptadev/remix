// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Slider recipe.
///
/// Remix owns the rendering, the drag and keyboard behavior, the mapping from
/// a 0-1 value onto the filled range, and the slider accessibility semantics;
/// this recipe supplies the rail, the filled range, and the thumb.
///
/// The rail is `muted` and the range is `primary`, the same pairing the
/// progress bar uses — a slider is a progress bar you can grab, and reading
/// them as one family is worth more than distinguishing them by color.
///
/// `semanticFormatterCallback` is deliberately not forwarded to the generated
/// `PlaygroundSlider`. Its type is
/// `NakedSliderSemanticFormatterCallback`, which comes from
/// `package:naked_ui` — a package this layer does not depend on. Reach for
/// `RemixSlider` directly on the rare call site that needs to reword the
/// announced value.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's hover thumb has to be
/// declared as a hover fragment too (`SliderStyler().onHovered(...)`).
class PlaygroundSlider extends StatelessWidget {
  const PlaygroundSlider({
    super.key,
    this.style = const SliderStyler.create(),
    required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.enabled = true,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.snapDivisions,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final SliderStyler style;

  final double value;

  final ValueChanged<double>? onChanged;

  final ValueChanged<double>? onChangeStart;

  final ValueChanged<double>? onChangeEnd;

  final double min;

  final double max;

  final bool enabled;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final int? snapDivisions;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixSlider(
      key: this.key,
      style: playgroundSliderStyle(style: this.style),
      value: this.value,
      onChanged: this.onChanged,
      onChangeStart: this.onChangeStart,
      onChangeEnd: this.onChangeEnd,
      min: this.min,
      max: this.max,
      enabled: this.enabled,
      enableFeedback: this.enableFeedback,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      snapDivisions: this.snapDivisions,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
