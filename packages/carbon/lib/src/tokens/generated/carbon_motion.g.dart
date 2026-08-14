// GENERATED CODE - DO NOT MODIFY BY HAND.
// Carbon motion durations and easing curves.
//
// Source: IBM Carbon Design System (Apache-2.0)
//   repo commit 188d23202ec1092322dee92cf0df9d9958224ae4 (2026-08-13)
//   @carbon/motion 11.50.0
// Regenerate: node tool/generate_tokens.mjs
// SPDX-License-Identifier: Apache-2.0
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import 'carbon_tokens.g.dart';

/// Motion duration token values.
final Map<DurationToken, Duration> carbonDurationValues = {
  CarbonTokens.durationFast01: Duration(milliseconds: 70),
  CarbonTokens.durationFast02: Duration(milliseconds: 110),
  CarbonTokens.durationModerate01: Duration(milliseconds: 150),
  CarbonTokens.durationModerate02: Duration(milliseconds: 240),
  CarbonTokens.durationSlow01: Duration(milliseconds: 400),
  CarbonTokens.durationSlow02: Duration(milliseconds: 700),
};

/// Carbon easing curves by intent (standard/entrance/exit) and mode
/// (productive/expressive), as Flutter [Cubic] curves.
class CarbonEasings {
  CarbonEasings._();

  static const Cubic entranceExpressive = Cubic(0.0, 0.0, 0.3, 1.0);
  static const Cubic entranceProductive = Cubic(0.0, 0.0, 0.38, 0.9);
  static const Cubic exitExpressive = Cubic(0.4, 0.14, 1.0, 1.0);
  static const Cubic exitProductive = Cubic(0.2, 0.0, 1.0, 0.9);
  static const Cubic standardExpressive = Cubic(0.4, 0.14, 0.3, 1.0);
  static const Cubic standardProductive = Cubic(0.2, 0.0, 0.38, 0.9);
}
