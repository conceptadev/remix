import 'package:flutter/widgets.dart';

import '../tokens/generated/carbon_motion.g.dart';

/// Carbon motion intent.
enum CarbonMotionIntent { standard, entrance, exit }

/// Carbon motion mode. Productive is calm and utilitarian; expressive is used
/// sparingly for moments that deserve emphasis.
enum CarbonMotionMode { productive, expressive }

/// Access to Carbon easing curves and reduced-motion-aware helpers.
///
/// Component recipes should route durations and curves through these helpers so
/// they honor the platform "reduce motion" accessibility setting instead of
/// treating every state change as expressive.
class CarbonMotion {
  const CarbonMotion._();

  /// The Carbon [Cubic] curve for an [intent] and [mode].
  static Cubic curve(CarbonMotionIntent intent, CarbonMotionMode mode) {
    return switch ((intent, mode)) {
      (CarbonMotionIntent.standard, CarbonMotionMode.productive) =>
        CarbonEasings.standardProductive,
      (CarbonMotionIntent.standard, CarbonMotionMode.expressive) =>
        CarbonEasings.standardExpressive,
      (CarbonMotionIntent.entrance, CarbonMotionMode.productive) =>
        CarbonEasings.entranceProductive,
      (CarbonMotionIntent.entrance, CarbonMotionMode.expressive) =>
        CarbonEasings.entranceExpressive,
      (CarbonMotionIntent.exit, CarbonMotionMode.productive) =>
        CarbonEasings.exitProductive,
      (CarbonMotionIntent.exit, CarbonMotionMode.expressive) =>
        CarbonEasings.exitExpressive,
    };
  }

  /// Whether the platform requests reduced motion for [context].
  static bool reducedMotionOf(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// Collapses [value] to [Duration.zero] when reduced motion is requested.
  static Duration duration(BuildContext context, Duration value) =>
      reducedMotionOf(context) ? .zero : value;

  /// Returns a linear curve when reduced motion is requested, else [value].
  static Curve resolveCurve(BuildContext context, Curve value) =>
      reducedMotionOf(context) ? Curves.linear : value;
}
