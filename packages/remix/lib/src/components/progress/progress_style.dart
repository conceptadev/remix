part of 'progress.dart';

/// Style builder for [RemixProgress].
///
/// Use this class to style the progress container, track, and indicator.
extension RemixProgressStylerRemixHelpers on RemixProgressStyler {
  /// Sets track color
  RemixProgressStyler trackColor(Color value) {
    return merge(
      RemixProgressStyler(
        track: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets fill color
  RemixProgressStyler indicatorColor(Color value) {
    return merge(
      RemixProgressStyler(
        indicator: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Creates a [RemixProgress] widget with this style applied.
  RemixProgress call({
    Key? key,
    double? value,
    double max = 1,
    Duration duration = const Duration(seconds: 5),
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixProgress(
      key: key,
      value: value,
      max: max,
      duration: duration,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
    );
  }
}
