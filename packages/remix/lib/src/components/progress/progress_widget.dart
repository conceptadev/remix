part of 'progress.dart';

/// The [RemixProgress] widget is used to display a progress bar that indicates a
/// completion percentage between 0 and 1. It can be customized using the
/// [style] parameter to fit different design needs.
///
/// ## Example
///
/// ```dart
/// RemixProgress(
///   value: 0.5,
/// )
/// ```
class RemixProgress extends StatelessWidget {
  const RemixProgress({
    super.key,
    required this.value,
    this.semanticsLabel,
    this.semanticsValue,
    this.style = const RemixProgressStyler.create(),
    this.styleSpec,
  }) : assert(
         value >= 0 && value <= 1,
         'Progress value must be between 0 and 1',
       );

  static final styleFrom = RemixProgressStyler.new;

  /// The progress value between 0 and 1.
  ///
  /// This value determines how much of the progress bar is filled.
  /// A value of 0 means empty, while 1 means completely filled.
  final double value;

  /// The accessible name exposed when this progress bar is not decorative.
  final String? semanticsLabel;

  /// Optional progress value expressed as a number from 0 to 100 or a
  /// percentage.
  ///
  /// Defaults to the rounded 0–100 value when [semanticsLabel] is provided.
  final String? semanticsValue;

  /// The style configuration for the progress bar.
  final RemixProgressStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixProgressSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    final progress = RemixStyleSpecBuilder<RemixProgressSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return Box(
          styleSpec: spec.container,
          child: Stack(
            children: [
              // Track background
              RemixBoxWithEffects(
                styleSpec: spec.track,
                containerEffects: spec.trackEffects,
              ),
              // Indicator foreground based on value
              LayoutBuilder(
                builder: (context, constraints) {
                  final biggestSize = constraints.biggest;

                  return SizedBox(
                    width: biggestSize.width * value.clamp(0.0, 1.0),
                    child: RemixBoxWithEffects(
                      styleSpec: spec.indicator,
                      containerEffects: spec.indicatorEffects,
                    ),
                  );
                },
              ),
              // Track container (for any additional styling)
              Box(styleSpec: spec.trackContainer),
            ],
          ),
        );
      },
    );

    if (semanticsLabel == null && semanticsValue == null) return progress;

    return Semantics(
      role: SemanticsRole.progressBar,
      label: semanticsLabel,
      value: semanticsValue ?? '${(value * 100).round()}',
      minValue: '0',
      maxValue: '100',
      child: progress,
    );
  }
}
