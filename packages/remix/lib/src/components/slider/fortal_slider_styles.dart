part of 'slider.dart';

/// Fortal slider size presets.
enum FortalSliderSize {
  /// Compact slider with a 13 px thumb and 6 px track.
  size1,

  /// Default slider with a 16 px thumb and 8 px track.
  size2,

  /// Large slider with a 19 px thumb and 10 px track.
  size3,
}

/// Fortal slider color variants.
enum FortalSliderVariant {
  /// Neutral track with the active accent indicator.
  surface,

  /// Softer accent treatment for lower-emphasis controls.
  soft,
}

/// Fortal-themed preset for [RemixSlider].
RemixSliderStyler fortalSliderStyler({
  FortalSliderVariant variant = .surface,
  FortalSliderSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .surface => _fortalSliderSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalSliderSoftStyler(size, highContrast: highContrast),
  };
}

RemixSliderStyler _fortalSliderBaseStyler(FortalSliderSize size) {
  return RemixSliderStyler()
      .thumb(
        BoxStyler()
            .color(Colors.white)
            .shapeRoundedRectangle(
              side: BorderSideMix()
                  .color(FortalTokens.grayA6())
                  .strokeAlign(BorderSide.strokeAlignOutside),
              borderRadius: BorderRadiusMix.all(FortalTokens.radiusThumb()),
            )
            .shadow(
              BoxShadowMix()
                  .blurRadius(2)
                  .offset(x: 0, y: 1)
                  .color(FortalTokens.gray7()),
            ),
      )
      .merge(_fortalSliderSizeStyler(size));
}

RemixSliderStyler _fortalSliderSurfaceStyler(
  FortalSliderSize size, {
  bool highContrast = false,
}) {
  return _fortalSliderBaseStyler(size)
      .trackColor(FortalTokens.gray3())
      .rangeColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentIndicator(),
      )
      .onDisabled(
        RemixSliderStyler()
            .trackColor(FortalTokens.accentTrack())
            .rangeColor(FortalTokens.accentIndicator())
            .thumbColor(FortalTokens.colorSurface()),
      );
}

RemixSliderStyler _fortalSliderSoftStyler(
  FortalSliderSize size, {
  bool highContrast = false,
}) {
  return _fortalSliderBaseStyler(size)
      .trackColor(FortalTokens.gray4())
      .rangeColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent6(),
      )
      .onDisabled(
        RemixSliderStyler()
            .trackColor(FortalTokens.accent4())
            .rangeColor(FortalTokens.accent9())
            .thumbColor(FortalTokens.accent9()),
      );
}

RemixSliderStyler _fortalSliderSizeStyler(FortalSliderSize size) {
  return switch (size) {
    .size1 => RemixSliderStyler(
      thumb: BoxStyler().size(13.0, 13.0),
      trackWidth: 6.0,
      rangeWidth: 6.0,
    ),
    .size2 => RemixSliderStyler(
      thumb: BoxStyler().size(16.0, 16.0),
      trackWidth: 8.0,
      rangeWidth: 8.0,
    ),
    .size3 => RemixSliderStyler(
      thumb: BoxStyler().size(19.0, 19.0),
      trackWidth: 10.0,
      rangeWidth: 10.0,
    ),
  };
}

/// Fortal-themed preset for [RemixSlider].
class FortalSlider extends StatelessWidget {
  const FortalSlider({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
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
  });

  /// Neutral track with the active accent indicator.
  const FortalSlider.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
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
  }) : variant = FortalSliderVariant.surface;

  /// Softer accent treatment for lower-emphasis controls.
  const FortalSlider.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
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
  }) : variant = FortalSliderVariant.soft;

  final FortalSliderVariant variant;

  final FortalSliderSize size;

  /// Optional accent color override for this slider subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this slider subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

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

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalSliderStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
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
          ),
    );
  }
}
