part of 'slider.dart';

/// A controlled slider supporting the established scalar API and an additive
/// multi-thumb API.
///
/// Provide exactly one of [value] or [values]. Multi-thumb callbacks use the
/// `onValues...` names so the scalar callback contract remains source stable.
class RemixSlider extends StatelessWidget {
  const RemixSlider({
    super.key,
    double? value,
    this.values,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.onValuesChanged,
    this.onValuesChangeStart,
    this.onValuesChangeEnd,
    this.onHoverChange,
    this.onDragChange,
    this.onFocusChange,
    this.min = 0,
    double? max,
    double? step,
    this.snapDivisions,
    this.minSpacing = 0,
    this.orientation = Axis.horizontal,
    this.inverted = false,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.focusNodes,
    this.autofocusThumbIndex,
    this.semanticLabels,
    this.semanticFormatterCallbacks,
    this.excludeSemantics = false,
    this.style = const RemixSliderStyler.create(),
    this.styleSpec,
  }) : _value = value,
       max = max ?? (values == null ? 1 : 100),
       step = step ?? 1,
       _hasExplicitStep = step != null,
       assert(
         (value == null) != (values == null),
         'Provide exactly one of value or values.',
       ),
       assert(min < (max ?? (values == null ? 1 : 100))),
       assert(
         value == null ||
             (value >= min && value <= (max ?? (values == null ? 1 : 100))),
         'Slider value must be between min and max.',
       ),
       assert(step == null || step > 0, 'step must be positive'),
       assert(
         snapDivisions == null || snapDivisions > 0,
         'snapDivisions must be positive',
       ),
       assert(minSpacing >= 0, 'minSpacing must be non-negative');

  /// Current value for the established single-thumb API.
  final double? _value;

  /// Current value for the established single-thumb API.
  ///
  /// Multi-thumb sliders expose their values through [values].
  double get value => _value!;

  /// Current values for the additive multi-thumb API.
  final List<double>? values;

  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<List<double>>? onValuesChanged;
  final ValueChanged<List<double>>? onValuesChangeStart;
  final ValueChanged<List<double>>? onValuesChangeEnd;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onDragChange;
  final ValueChanged<bool>? onFocusChange;
  final double min;
  final double max;
  final double step;
  final bool _hasExplicitStep;

  /// Optional scalar snapping divisions retained from the original API.
  final int? snapDivisions;
  final double minSpacing;
  final Axis orientation;
  final bool inverted;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<FocusNode?>? focusNodes;
  final int? autofocusThumbIndex;
  final List<String?>? semanticLabels;
  final List<RemixSliderSemanticFormatterCallback?>? semanticFormatterCallbacks;
  final bool excludeSemantics;
  final RemixSliderStyler style;
  final RemixSliderSpec? styleSpec;

  static final styleFrom = RemixSliderStyler.new;

  List<double> get _effectiveValues => values ?? [_value!];

  double get _effectiveStep {
    final divisions = snapDivisions;
    if (divisions != null) return (max - min) / divisions;
    if (_hasExplicitStep || values != null) return step;
    return (max - min) / 1000;
  }

  ValueChanged<List<double>>? _adaptCallback(
    ValueChanged<double>? scalar,
    ValueChanged<List<double>>? multiple,
  ) {
    if (scalar == null && multiple == null) return null;
    return (values) {
      multiple?.call(values);
      if (values.length == 1) scalar?.call(values.single);
    };
  }

  @override
  Widget build(BuildContext context) => NakedSlider(
    values: _effectiveValues,
    min: min,
    max: max,
    step: _effectiveStep,
    minSpacing: minSpacing,
    orientation: orientation,
    inverted: inverted,
    onChanged: _adaptCallback(onChanged, onValuesChanged),
    onChangeStart: _adaptCallback(onChangeStart, onValuesChangeStart),
    onChangeEnd: _adaptCallback(onChangeEnd, onValuesChangeEnd),
    onHoverChange: onHoverChange,
    onDragChange: onDragChange,
    onFocusChange: onFocusChange,
    enabled: enabled,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    focusNodes: focusNodes ?? (focusNode == null ? null : [focusNode]),
    autofocusThumbIndex: autofocusThumbIndex ?? (autofocus ? 0 : null),
    semanticLabels: semanticLabels,
    semanticFormatterCallbacks: semanticFormatterCallbacks,
    excludeSemantics: excludeSemantics,
    builder: (context, state, _) => RemixStyleSpecBuilder<RemixSliderSpec>(
      style: style,
      styleSpec: styleSpec,
      controller: NakedSliderState.controllerOf(context),
      builder: (context, spec) {
        Widget visual = _RemixSliderVisual(state: state, spec: spec);
        if (spec.blendMode case final blendMode?) {
          visual = RemixBlendMode(blendMode: blendMode, child: visual);
        }
        return visual;
      },
    ),
  );
}

class _RemixSliderVisual extends StatelessWidget {
  const _RemixSliderVisual({required this.state, required this.spec});

  final NakedSliderState state;
  final RemixSliderSpec spec;

  @override
  Widget build(BuildContext context) {
    final thumbSize = _resolveThumbSize(context, spec.thumb);
    final trackThickness = math.max(0.0, spec.trackThickness);
    final horizontal = state.orientation == Axis.horizontal;
    final crossAxisExtent = math.max(
      48.0,
      math.max(horizontal ? thumbSize.height : thumbSize.width, trackThickness),
    );
    final constrained = SizedBox(
      width: horizontal ? null : trackThickness,
      height: horizontal ? trackThickness : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          assert(
            horizontal
                ? constraints.hasBoundedWidth
                : constraints.hasBoundedHeight,
            'A slider must have a bounded main-axis extent.',
          );
          final width = horizontal ? constraints.maxWidth : trackThickness;
          final height = horizontal ? trackThickness : constraints.maxHeight;
          final size = Size(
            width.isFinite ? width : constraints.minWidth,
            height.isFinite ? height : constraints.minHeight,
          );
          return SizedBox.fromSize(
            size: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: RemixBoxWithEffects(
                    key: const ValueKey('remix-slider-track'),
                    styleSpec: _withSliderFallbackColor(
                      spec.track,
                      spec.trackColor,
                    ),
                    containerEffects: spec.trackEffects,
                    child: const SizedBox.expand(),
                  ),
                ),
                _buildRange(size),
                ..._buildThumbs(size, thumbSize),
              ],
            ),
          );
        },
      ),
    );
    return SizedBox(
      width: horizontal ? null : crossAxisExtent,
      height: horizontal ? crossAxisExtent : null,
      child: Center(child: constrained),
    );
  }

  Widget _buildRange(Size size) {
    final percentages = state.values.length == 1
        ? [state.visualPercentageOf(0), state.visualPercentageAt(0)]
        : [
            state.visualPercentageAt(0),
            state.visualPercentageAt(state.values.length - 1),
          ];
    final start = math
        .min(percentages[0], percentages[1])
        .clamp(0.0, 1.0)
        .toDouble();
    final end = math
        .max(percentages[0], percentages[1])
        .clamp(0.0, 1.0)
        .toDouble();
    final horizontal = state.orientation == Axis.horizontal;
    return Positioned(
      left: horizontal ? size.width * start : 0,
      top: horizontal ? 0 : size.height * start,
      width: horizontal ? size.width * (end - start) : size.width,
      height: horizontal ? size.height : size.height * (end - start),
      child: RemixBoxWithEffects(
        key: const ValueKey('remix-slider-range'),
        styleSpec: _withSliderFallbackColor(spec.range, spec.rangeColor),
        containerEffects: spec.rangeEffects,
        child: const SizedBox.expand(),
      ),
    );
  }

  List<Widget> _buildThumbs(Size size, Size thumbSize) {
    final indices = [
      for (var index = 0; index < state.values.length; index++)
        if (index != state.activeThumbIndex) index,
      if (state.activeThumbIndex case final active?) active,
    ];
    return [for (final index in indices) _buildThumb(size, thumbSize, index)];
  }

  Widget _buildThumb(Size size, Size thumbSize, int index) {
    final percentage = state
        .visualPercentageAt(index)
        .clamp(0.0, 1.0)
        .toDouble();
    final horizontal = state.orientation == Axis.horizontal;
    final focusEffects = index == state.focusedThumbIndex
        ? spec.thumbFocusEffects
        : null;
    final effects = switch ((spec.thumbEffects, focusEffects)) {
      (final base?, final focus?) => base.merge(focus),
      (final base, null) => base,
      (null, final focus) => focus,
    };
    final thumb = RemixBoxWithEffects(
      key: ValueKey('remix-slider-thumb-$index'),
      styleSpec: spec.thumb,
      containerEffects: effects,
      child: const SizedBox.expand(),
    );
    return Positioned(
      left: horizontal
          ? size.width * percentage - thumbSize.width / 2
          : (size.width - thumbSize.width) / 2,
      top: horizontal
          ? (size.height - thumbSize.height) / 2
          : size.height * percentage - thumbSize.height / 2,
      width: thumbSize.width,
      height: thumbSize.height,
      child: thumb,
    );
  }
}

StyleSpec<BoxSpec> _withSliderFallbackColor(
  StyleSpec<BoxSpec> styleSpec,
  Color color,
) {
  final decoration = styleSpec.spec.decoration;
  final resolvedDecoration = switch (decoration) {
    null => BoxDecoration(color: color),
    BoxDecoration() when decoration.color == null => decoration.copyWith(
      color: color,
    ),
    _ => decoration,
  };
  if (identical(resolvedDecoration, decoration)) return styleSpec;
  return styleSpec.copyWith(
    spec: styleSpec.spec.copyWith(decoration: resolvedDecoration),
  );
}

Size _resolveThumbSize(BuildContext context, StyleSpec<BoxSpec> thumb) {
  final box = thumb.spec;
  final constraints = box.constraints;
  final padding = box.padding?.resolve(Directionality.of(context));
  final hasTightWidth = constraints?.hasTightWidth ?? false;
  final hasTightHeight = constraints?.hasTightHeight ?? false;
  return Size(
    _resolveTightDimension(
          tight: hasTightWidth,
          min: constraints?.minWidth,
          max: constraints?.maxWidth,
          fallback: RemixSliderSpec.defaultThumbSize.width,
        ) +
        (hasTightWidth ? 0 : padding?.horizontal ?? 0),
    _resolveTightDimension(
          tight: hasTightHeight,
          min: constraints?.minHeight,
          max: constraints?.maxHeight,
          fallback: RemixSliderSpec.defaultThumbSize.height,
        ) +
        (hasTightHeight ? 0 : padding?.vertical ?? 0),
  );
}

double _resolveTightDimension({
  required bool tight,
  double? min,
  double? max,
  required double fallback,
}) {
  if (tight && max != null && max.isFinite) return max;
  if (max != null && max.isFinite && max > 0) return max;
  if (min != null && min.isFinite && min > 0) return min;
  return fallback;
}
