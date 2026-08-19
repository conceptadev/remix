part of 'slider.dart';

/// A customizable slider component that supports various styles and behaviors.
/// The slider integrates with the Mix styling system and follows Remix design patterns.
///
/// ## Example
///
/// ```dart
/// RemixSlider(
///   min: 0.0,
///   max: 100.0,
///   value: 50.0,
///   onChanged: (value) {
///     debugPrint('Slider value changed: $value');
///   },
///   style: SliderStyler(),
/// )
/// ```
class RemixSlider extends StatelessWidget {
  const RemixSlider({
    super.key,
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
    this.semanticFormatterCallback,
    this.excludeSemantics = false,
    this.style = const SliderStyler.create(),
    this.styleSpec,
  }) : assert(min < max, 'Slider min must be less than max'),
       assert(
         snapDivisions == null || snapDivisions > 0,
         'Slider snapDivisions must be greater than 0',
       ),
       assert(
         value >= min && value <= max,
         'Slider value must be between min and max values',
       );

  /// The minimum value the slider can have.
  final double min;

  /// The maximum value the slider can have.
  final double max;

  /// Optional snapping divisions for interaction only (no visual ticks).
  /// When provided, the slider snaps to these discrete steps but does not
  /// render any division marks on the track.
  final int? snapDivisions;

  /// Whether the slider should automatically request focus when it is created.
  final bool autofocus;

  /// The current value of the slider.
  /// Must be between [min] and [max].
  final double value;

  /// The style configuration for the slider.
  final SliderStyler style;

  /// The style spec for the slider.
  final SliderSpec? styleSpec;

  static final styleFrom = SliderStyler.new;

  /// Whether the slider is enabled for interaction.
  final bool enabled;

  /// Whether to provide platform feedback during value changes.
  /// Defaults to true.
  final bool enableFeedback;

  /// Called when the user starts dragging the slider.
  final ValueChanged<double>? onChangeStart;

  /// Called during drag with the new value.
  ///
  /// When null, the slider is visually disabled and does not respond to
  /// interaction.
  final ValueChanged<double>? onChanged;

  /// Called when the user is done selecting a new value.
  final ValueChanged<double>? onChangeEnd;

  /// The focus node for the slider.
  final FocusNode? focusNode;

  /// The semantic label for the slider's single thumb.
  final String? semanticLabel;

  /// Formats the semantic value for the slider's single thumb.
  final NakedSliderSemanticFormatterCallback? semanticFormatterCallback;

  /// Whether to hide the slider from the semantic tree.
  final bool excludeSemantics;

  double get _effectiveStep {
    final divisions = snapDivisions;
    if (divisions != null) return (max - min) / divisions;
    return (max - min) / 1000;
  }

  @override
  Widget build(BuildContext context) {
    // NakedSlider handles semantics internally, no outer Semantics needed
    return NakedSlider(
      values: [value],
      min: min,
      max: max,
      step: _effectiveStep,
      onChanged: onChanged == null
          ? null
          : (values) => onChanged!(values.single),
      onChangeStart: onChangeStart == null
          ? null
          : (values) => onChangeStart!(values.single),
      onChangeEnd: onChangeEnd == null
          ? null
          : (values) => onChangeEnd!(values.single),
      enabled: enabled,
      enableFeedback: enableFeedback,
      focusNodes: focusNode == null ? null : [focusNode],
      autofocusThumbIndex: autofocus ? 0 : null,
      semanticLabels: semanticLabel == null ? null : [semanticLabel],
      semanticFormatterCallbacks: semanticFormatterCallback == null
          ? null
          : [semanticFormatterCallback],
      excludeSemantics: excludeSemantics,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<SliderSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedSliderState.controllerOf(context),
          trackFocusHighlightMode: true,
          builder: (context, spec) {
            final thumbSpec = spec.thumb;
            final thumbSize = _resolveThumbSize(context, thumbSpec);
            final trackThickness = spec.trackThickness > 0
                ? spec.trackThickness
                : SliderSpec.defaultTrackStrokeWidth;
            final override = WidgetStateStyleOverride.maybeOf(context);
            final shouldShowThumbFocusEffect = override != null
                ? override.states.contains(WidgetState.focused)
                : state.focusedThumbIndex == 0 &&
                      RemixFocusHighlightModeProvider.of(context) ==
                          FocusHighlightMode.traditional;

            // Slider height accommodates both thumb and track:
            // - thumb.height + trackThickness: ensures thumb has clearance above/below
            // - trackThickness alone: minimum viable height
            final sliderHeight = math.max(
              thumbSize.height + trackThickness,
              trackThickness,
            );
            final horizontalOverflow = math.max(
              thumbSize.width / 2,
              trackThickness / 2,
            );
            final horizontalPadding = horizontalOverflow * 2;

            final slider = SizedBox(
              height: sliderHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Visual placement comes from Naked so LTR, RTL, and
                  // inverted tracks match the interaction layer.
                  final originVisual = state.visualPercentageOf(0);
                  final thumbVisual = state.visualPercentageAt(0);
                  final rangeStart = math.min(originVisual, thumbVisual);
                  final rangeSpan = (thumbVisual - originVisual).abs();
                  final availableWidth = math.max(
                    0.0,
                    constraints.maxWidth - horizontalPadding,
                  );
                  // The thumb is a direct child of the outer Stack, so it must
                  // re-apply the inset the track gets from its Padding, then
                  // back off half its own width to center on the track point.
                  // When the thumb is the widest element both terms cancel.
                  final thumbPosition =
                      horizontalOverflow -
                      thumbSize.width / 2 +
                      availableWidth * thumbVisual;

                  return Stack(
                    alignment: .centerLeft,
                    children: [
                      Padding(
                        padding: .symmetric(horizontal: horizontalPadding / 2),
                        child: SizedBox(
                          width: double.infinity,
                          height: constraints.maxHeight,
                          child: LayoutBuilder(
                            builder: (context, trackConstraints) {
                              final trackWidth = trackConstraints.maxWidth;
                              return Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: spec.trackWidth,
                                    child: RemixBoxWithEffects(
                                      styleSpec: _sliderRailStyle(
                                        spec.track,
                                        color: spec.trackColor,
                                        thickness: spec.trackWidth,
                                      ),
                                      containerEffects: spec.trackEffects,
                                    ),
                                  ),
                                  Positioned(
                                    left: rangeStart * trackWidth,
                                    width: rangeSpan * trackWidth,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: spec.rangeWidth,
                                        child: RemixBoxWithEffects(
                                          styleSpec: _sliderRailStyle(
                                            spec.range,
                                            color: spec.rangeColor,
                                            thickness: spec.rangeWidth,
                                          ),
                                          containerEffects: spec.rangeEffects,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(thumbPosition, 0),
                        child: RemixBoxWithEffects(
                          styleSpec: spec.thumb,
                          containerEffects:
                              (spec.thumbEffects ?? const RemixBoxEffectsSpec())
                                  .merge(
                                    shouldShowThumbFocusEffect
                                        ? spec.thumbFocusEffects
                                        : null,
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
            final blendMode = spec.blendMode;
            return blendMode == null
                ? slider
                : RemixBlendMode(blendMode: blendMode, child: slider);
          },
        );
      },
    );
  }
}

StyleSpec<BoxSpec> _sliderRailStyle(
  StyleSpec<BoxSpec> style, {
  required Color color,
  required double thickness,
}) {
  final box = style.spec;
  final decoration = switch (box.decoration) {
    final BoxDecoration value =>
      value.color == null ? value.copyWith(color: color) : value,
    null => BoxDecoration(color: color),
    final value => value,
  };
  final constraints = (box.constraints ?? const BoxConstraints()).copyWith(
    minHeight: thickness,
    maxHeight: thickness,
  );
  return style.copyWith(
    spec: box.copyWith(decoration: decoration, constraints: constraints),
  );
}

Size _resolveThumbSize(BuildContext context, StyleSpec<BoxSpec> thumb) {
  final box = thumb.spec;
  final constraints = box.constraints;

  final width = _resolveTightDimension(
    tight: constraints?.hasTightWidth ?? false,
    min: constraints?.minWidth,
    max: constraints?.maxWidth,
    fallback: SliderSpec.defaultThumbSize.width,
  );

  final height = _resolveTightDimension(
    tight: constraints?.hasTightHeight ?? false,
    min: constraints?.minHeight,
    max: constraints?.maxHeight,
    fallback: SliderSpec.defaultThumbSize.height,
  );

  final padding = box.padding?.resolve(Directionality.of(context));

  return Size(
    width + (padding?.horizontal ?? 0),
    height + (padding?.vertical ?? 0),
  );
}

double _resolveTightDimension({
  required bool tight,
  double? min,
  double? max,
  required double fallback,
}) {
  if (tight && max != null && max.isFinite) {
    return max;
  }

  final finiteMax = (max != null && max.isFinite && max > 0) ? max : null;
  if (finiteMax != null) return finiteMax;

  final finiteMin = (min != null && min.isFinite && min > 0) ? min : null;
  if (finiteMin != null) return finiteMin;

  return fallback;
}
