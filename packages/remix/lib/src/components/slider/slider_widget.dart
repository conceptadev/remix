part of 'slider.dart';

/// A controlled, arbitrary multi-thumb slider.
///
/// [values] is nonempty and ascending. Pointer, keyboard, and semantic input
/// is delegated to [NakedSlider], while this widget owns visual composition.
class RemixSlider extends StatelessWidget {
  const RemixSlider({
    super.key,
    required this.values,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.onHoverChange,
    this.onDragChange,
    this.onFocusChange,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.minSpacing = 0,
    this.orientation = Axis.horizontal,
    this.inverted = false,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNodes,
    this.autofocusThumbIndex,
    this.semanticLabels,
    this.semanticFormatterCallbacks,
    this.excludeSemantics = false,
    this.style = const RemixSliderStyler.create(),
    this.styleSpec,
  }) : assert(min < max, 'min must be less than max'),
       assert(step > 0, 'step must be positive'),
       assert(minSpacing >= 0, 'minSpacing must be non-negative');

  /// Current controlled values in ascending order.
  final List<double> values;

  /// Called with the complete value list when a thumb requests a change.
  final ValueChanged<List<double>>? onChanged;

  final ValueChanged<List<double>>? onChangeStart;
  final ValueChanged<List<double>>? onChangeEnd;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onDragChange;
  final ValueChanged<bool>? onFocusChange;
  final double min;
  final double max;
  final double step;
  final double minSpacing;
  final Axis orientation;
  final bool inverted;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final List<FocusNode?>? focusNodes;
  final int? autofocusThumbIndex;
  final List<String?>? semanticLabels;
  final List<RemixSliderSemanticFormatterCallback?>? semanticFormatterCallbacks;
  final bool excludeSemantics;
  final RemixSliderStyler style;
  final RemixSliderSpec? styleSpec;

  static final styleFrom = RemixSliderStyler.new;

  @override
  Widget build(BuildContext context) => NakedSlider(
    values: values,
    min: min,
    max: max,
    step: step,
    minSpacing: minSpacing,
    orientation: orientation,
    inverted: inverted,
    onChanged: onChanged,
    onChangeStart: onChangeStart,
    onChangeEnd: onChangeEnd,
    onHoverChange: onHoverChange,
    onDragChange: onDragChange,
    onFocusChange: onFocusChange,
    enabled: enabled,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    focusNodes: focusNodes,
    autofocusThumbIndex: autofocusThumbIndex,
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
                  child: remixSurfaceBox(
                    key: const ValueKey('remix-slider-track'),
                    styleSpec: spec.track,
                    effects: spec.trackEffects,
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
      child: remixSurfaceBox(
        key: const ValueKey('remix-slider-range'),
        styleSpec: spec.range,
        effects: spec.rangeEffects,
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
    final thumb = remixSurfaceBox(
      key: ValueKey('remix-slider-thumb-$index'),
      styleSpec: spec.thumb,
      effects: effects,
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
