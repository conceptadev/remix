// GENERATED CODE - DO NOT MODIFY BY HAND.
// Carbon layout values (spacing, sizes and breakpoints).
//
// Source: IBM Carbon Design System (Apache-2.0)
//   repo commit 188d23202ec1092322dee92cf0df9d9958224ae4 (2026-08-13)
//   @carbon/layout 11.57.0
// Regenerate: node tool/generate_tokens.mjs
// SPDX-License-Identifier: Apache-2.0
import 'package:mix/mix.dart';

import '../carbon_token_types.dart';
import 'carbon_tokens.g.dart';

/// Fixed spacing, container, icon and control-size token values (logical px).
final Map<SpaceToken, double> carbonSpacingValues = {
  CarbonTokens.spacing01: 2.0,
  CarbonTokens.spacing02: 4.0,
  CarbonTokens.spacing03: 8.0,
  CarbonTokens.spacing04: 12.0,
  CarbonTokens.spacing05: 16.0,
  CarbonTokens.spacing06: 24.0,
  CarbonTokens.spacing07: 32.0,
  CarbonTokens.spacing08: 40.0,
  CarbonTokens.spacing09: 48.0,
  CarbonTokens.spacing10: 64.0,
  CarbonTokens.spacing11: 80.0,
  CarbonTokens.spacing12: 96.0,
  CarbonTokens.spacing13: 160.0,
  CarbonTokens.container01: 24.0,
  CarbonTokens.container02: 32.0,
  CarbonTokens.container03: 40.0,
  CarbonTokens.container04: 48.0,
  CarbonTokens.container05: 64.0,
  CarbonTokens.iconSize01: 16.0,
  CarbonTokens.iconSize02: 20.0,
  CarbonTokens.sizeLarge: 48.0,
  CarbonTokens.sizeMedium: 40.0,
  CarbonTokens.sizeSmall: 32.0,
  CarbonTokens.sizeXLarge: 64.0,
  CarbonTokens.sizeXSmall: 24.0,
  CarbonTokens.sizeXxLarge: 80.0,
};

/// Responsive breakpoints, ordered small to large.
const List<CarbonBreakpointData> carbonBreakpoints = [
  CarbonBreakpointData(name: 'sm', width: 320.0, columns: 4, margin: 0.0),
  CarbonBreakpointData(name: 'md', width: 672.0, columns: 8, margin: 16.0),
  CarbonBreakpointData(name: 'lg', width: 1056.0, columns: 16, margin: 16.0),
  CarbonBreakpointData(name: 'xlg', width: 1312.0, columns: 16, margin: 16.0),
  CarbonBreakpointData(name: 'max', width: 1584.0, columns: 16, margin: 24.0),
];

/// Control sizes (default heights) in logical pixels, keyed by size name.
const Map<String, double> carbonControlSizePx = {
  'large': 48.0,
  'medium': 40.0,
  'small': 32.0,
  'xLarge': 64.0,
  'xSmall': 24.0,
  'xxLarge': 80.0,
};
