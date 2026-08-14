part of 'progress.dart';

/// Style builder for [RemixProgress].
///
/// Use this class to style the progress container, track, indicator, and track
/// layout container.
extension RemixProgressStylerRemixHelpers on ProgressStyler {
  /// Sets track color
  ProgressStyler trackColor(Color value) {
    return merge(
      ProgressStyler(
        track: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets fill color
  ProgressStyler indicatorColor(Color value) {
    return merge(
      ProgressStyler(
        indicator: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }
}
