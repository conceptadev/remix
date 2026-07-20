part of 'spinner.dart';

/// Resolved visual values for an eight-leaf [RemixSpinner].
@MixableSpec()
class RemixSpinnerSpec with _$RemixSpinnerSpec {
  @override
  final double? size;

  /// Explicit color override. When absent the spinner uses inherited color.
  @override
  final Color? color;

  /// Opacity applied to the complete spinner before per-leaf fading.
  @override
  final double? opacity;

  /// Corner radius of each leaf.
  @override
  final Radius? leafRadius;

  /// Duration of one complete leaf-fade cycle.
  @override
  final Duration? duration;

  const RemixSpinnerSpec({
    this.size,
    this.color,
    this.opacity,
    this.leafRadius,
    this.duration,
  });
}
