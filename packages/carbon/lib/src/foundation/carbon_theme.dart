import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import '../tokens/generated/carbon_component_tokens.g.dart';
import '../tokens/generated/carbon_themes.g.dart';
import '../tokens/generated/carbon_layout.g.dart';
import '../tokens/generated/carbon_motion.g.dart';
import '../tokens/generated/carbon_type.g.dart';

/// The four official IBM Carbon themes.
///
/// White and Gray 10 are light; Gray 90 and Gray 100 are dark. The names mirror
/// Carbon's own theme identifiers so documentation and design hand-offs line up.
enum CarbonTheme {
  /// White theme (lightest).
  white,

  /// Gray 10 theme (light).
  g10,

  /// Gray 90 theme (dark).
  g90,

  /// Gray 100 theme (darkest).
  g100;

  /// The Flutter [Brightness] that matches this theme.
  Brightness get brightness => switch (this) {
    .white || .g10 => .light,
    .g90 || .g100 => .dark,
  };

  /// Whether this is one of Carbon's dark themes.
  bool get isDark => brightness == .dark;
}

/// Optional, typed overrides applied on top of a theme's generated maps.
///
/// Overrides are merged when the scope's token map is built; the generated
/// theme maps themselves are never mutated.
@immutable
class CarbonThemeOverrides {
  const CarbonThemeOverrides({this.colors = const {}, this.fontFamily});

  /// Role or component color tokens to override.
  final Map<ColorToken, Color> colors;

  /// Font family applied to every text style token (e.g. an `IBM Plex Sans`
  /// family the app has bundled). When null the platform default font is used.
  final String? fontFamily;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarbonThemeOverrides &&
          other.fontFamily == fontFamily &&
          mapEquals(other.colors, colors);

  @override
  int get hashCode => Object.hash(
    fontFamily,
    Object.hashAllUnordered(
      colors.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );
}

// Base token maps are pure functions of the theme, so they are built once per
// theme and shared. Returning the identical instance also lets MixScope's
// dependents short-circuit equality checks on rebuilds that change nothing.
final Map<CarbonTheme, Map<MixToken, Object>> _baseTokenMaps = {};

Map<MixToken, Object> _baseTokenMapFor(CarbonTheme theme) {
  return _baseTokenMaps.putIfAbsent(theme, () {
    final roleColors = switch (theme) {
      .white => carbonRoleColorsWhite,
      .g10 => carbonRoleColorsG10,
      .g90 => carbonRoleColorsG90,
      .g100 => carbonRoleColorsG100,
    };
    final componentColors = switch (theme) {
      .white => carbonComponentColorsWhite,
      .g10 => carbonComponentColorsG10,
      .g90 => carbonComponentColorsG90,
      .g100 => carbonComponentColorsG100,
    };

    return Map.unmodifiable(<MixToken, Object>{
      ...roleColors,
      ...componentColors,
      ...carbonSpacingValues,
      ...carbonTextStyleTokens,
      ...carbonDurationValues,
      ...carbonFontWeightValues,
    });
  });
}

/// Builds the full `MixScope` token map for [theme].
///
/// Combines theme-dependent role and component colors with theme-independent
/// spacing, type, motion and font-weight values, then applies [overrides].
/// With no overrides this returns a cached, unmodifiable map, so repeated
/// scope rebuilds are allocation-free.
Map<MixToken, Object> buildCarbonTokenMap(
  CarbonTheme theme, {
  CarbonThemeOverrides overrides = const CarbonThemeOverrides(),
}) {
  final base = _baseTokenMapFor(theme);
  final fontFamily = overrides.fontFamily;
  if (fontFamily == null && overrides.colors.isEmpty) return base;

  return {
    ...base,
    if (fontFamily != null)
      ...carbonTextStyleTokens.map(
        (k, v) => MapEntry(k, v.copyWith(fontFamily: fontFamily)),
      ),
    // Overrides win over generated values.
    ...overrides.colors,
  };
}
