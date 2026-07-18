/// Fortal computed tokens and functional color utilities.
///
/// Implements computed role tokens (accent-contrast, accent-track, etc.) and
/// background/overlay colors that mirror Radix Themes behavior while keeping the
/// original Radix Colors data.
///
/// Components should use these functional roles rather than raw color steps.

// Documentation for all public APIs is provided below

import 'dart:ui' show Color, Offset;

import 'package:flutter/painting.dart' show BoxShadow, ColorSwatch;
import 'package:mix/mix.dart' show BoxShadowToken;

import '../radix/colors/colors.dart';
import 'fortal_theme.dart';

// ============================================================================
// FUNCTIONAL / COMPUTED IMPLEMENTATIONS
// ============================================================================

// Computes contrast foreground color for solid accent backgrounds.
//

/// Computes solid focus ring color (accent step 8).
Color computeFocus8(RadixColorScale accent) => accent.step(8);

/// Computes translucent focus ring color (accent alpha step 8).
Color computeFocusA8(RadixColorScale accent) => accent.alphaStep(8);

// ============================================================================
// BACKGROUND / PANEL / OVERLAY
// ============================================================================

/// Computes primary page background color.
///
/// Radix Themes uses white in light mode and gray step 1 in dark mode.
Color computeColorBackground(RadixColorScale gray, {required bool isDark}) =>
    isDark ? gray.step(1) : const Color(0xFFFFFFFF);

/// Computes solid background for panels and input surfaces.
///
/// Radix Themes uses white in light mode and gray step 2 in dark mode.
Color computeColorPanelSolid(RadixColorScale gray, {required bool isDark}) =>
    isDark ? gray.step(2) : const Color(0xFFFFFFFF);

/// Computes translucent background for floating panels.
///
/// Radix Themes uses 70% white in light mode and gray alpha step 2 in dark
/// mode.
Color computeColorPanelTranslucent(
  RadixColorScale gray, {
  required bool isDark,
}) => isDark ? gray.alphaStep(2) : const Color(0xB3FFFFFF);

/// Computes the neutral control surface color.
///
/// Radix Themes uses 85% white in light mode and 25% black in dark mode.
Color computeColorSurface({required bool isDark}) =>
    isDark ? const Color(0x40000000) : const Color(0xD9FFFFFF);

/// Computes modal backdrop overlay color.
///
/// Uses black alpha step 6 (light mode) or step 8 (dark mode).
Color computeColorOverlay({required bool isDark}) =>
    isDark ? blackAlpha[8]! : blackAlpha[6]!;

/// Computes the mode-aware stroke used by elevation shadows.
Color computeShadowStroke(RadixColorScale gray, {required bool isDark}) =>
    Color.lerp(
      gray.alphaStep(isDark ? 6 : 3),
      gray.step(isDark ? 6 : 3),
      0.25,
    )!;

/// Builds Radix Themes elevation shadows for the active brightness.
///
/// Flutter does not support CSS inset shadows, so the first light shadow is
/// represented by its equivalent layered outer-shadow approximation.
Map<BoxShadowToken, List<BoxShadow>> buildFortalShadows({
  required bool isDark,
  required FortalThemeColors colors,
}) {
  if (isDark) {
    return {
      FortalTokens.shadow1: [
        BoxShadow(
          color: colors.gray.scale.alphaStep(6),
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[5]!,
          offset: const Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      FortalTokens.shadow2: [
        BoxShadow(
          color: colors.shadowStroke,
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[3]!,
          offset: const Offset(0, 0),
          blurRadius: 0.5,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[6]!,
          offset: const Offset(0, 1),
          blurRadius: 1,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[6]!,
          offset: const Offset(0, 2),
          blurRadius: 1,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: colors.blackAlpha[5]!,
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
        ),
      ],
      FortalTokens.shadow3: [
        BoxShadow(
          color: colors.shadowStroke,
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[3]!,
          offset: const Offset(0, 2),
          blurRadius: 3,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: colors.blackAlpha[6]!,
          offset: const Offset(0, 3),
          blurRadius: 8,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: colors.blackAlpha[7]!,
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: -4,
        ),
      ],
      FortalTokens.shadow4: [
        BoxShadow(
          color: colors.shadowStroke,
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[3]!,
          offset: const Offset(0, 8),
          blurRadius: 40,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[5]!,
          offset: const Offset(0, 12),
          blurRadius: 32,
          spreadRadius: -16,
        ),
      ],
      FortalTokens.shadow5: [
        BoxShadow(
          color: colors.shadowStroke,
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[5]!,
          offset: const Offset(0, 12),
          blurRadius: 60,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[7]!,
          offset: const Offset(0, 12),
          blurRadius: 32,
          spreadRadius: -16,
        ),
      ],
      FortalTokens.shadow6: [
        BoxShadow(
          color: colors.shadowStroke,
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: colors.blackAlpha[4]!,
          offset: const Offset(0, 12),
          blurRadius: 60,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[6]!,
          offset: const Offset(0, 16),
          blurRadius: 64,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: colors.blackAlpha[11]!,
          offset: const Offset(0, 16),
          blurRadius: 36,
          spreadRadius: -20,
        ),
      ],
    };
  }

  return {
    FortalTokens.shadow1: [
      BoxShadow(
        color: colors.gray.scale.alphaStep(5),
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 1.5),
        blurRadius: 2,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.blackAlpha[2]!,
        offset: const Offset(0, 1.5),
        blurRadius: 2,
        spreadRadius: 0,
      ),
    ],
    FortalTokens.shadow2: [
      BoxShadow(
        color: colors.shadowStroke,
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.blackAlpha[1]!,
        offset: const Offset(0, 0),
        blurRadius: 0.5,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 1),
        blurRadius: 1,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.blackAlpha[1]!,
        offset: const Offset(0, 2),
        blurRadius: 1,
        spreadRadius: -1,
      ),
      BoxShadow(
        color: colors.blackAlpha[1]!,
        offset: const Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
      ),
    ],
    FortalTokens.shadow3: [
      BoxShadow(
        color: colors.shadowStroke,
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 2),
        blurRadius: 3,
        spreadRadius: -2,
      ),
      BoxShadow(
        color: colors.blackAlpha[2]!,
        offset: const Offset(0, 3),
        blurRadius: 12,
        spreadRadius: -4,
      ),
      BoxShadow(
        color: colors.blackAlpha[2]!,
        offset: const Offset(0, 4),
        blurRadius: 16,
        spreadRadius: -8,
      ),
    ],
    FortalTokens.shadow4: [
      BoxShadow(
        color: colors.shadowStroke,
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.blackAlpha[1]!,
        offset: const Offset(0, 8),
        blurRadius: 40,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
      ),
    ],
    FortalTokens.shadow5: [
      BoxShadow(
        color: colors.shadowStroke,
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.blackAlpha[3]!,
        offset: const Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(5),
        offset: const Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
      ),
    ],
    FortalTokens.shadow6: [
      BoxShadow(
        color: colors.shadowStroke,
        offset: const Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: colors.blackAlpha[3]!,
        offset: const Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 16),
        blurRadius: 64,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.gray.scale.alphaStep(7),
        offset: const Offset(0, 16),
        blurRadius: 36,
        spreadRadius: -20,
      ),
    ],
  };
}

// ============================================================================
// RESOLVER (merged from resolver.dart)
// ============================================================================

/// Container for all computed Fortal theme colors and scales.
///
/// Holds resolved color system for a specific theme configuration.
/// Created by [resolveFortalTokens] for internal use by the token system.
class FortalThemeColors {
  final RadixColor accent;
  final RadixColor gray;
  final ColorSwatch<int> blackAlpha;
  final ColorSwatch<int> whiteAlpha;

  // Functional colors
  final Color colorBackground;
  final Color colorSurface;
  final Color colorPanelSolid;
  final Color colorPanelTranslucent;
  final Color colorOverlay;
  final Color shadowStroke;

  // Focus
  final Color focus8;
  final Color focusA8;

  const FortalThemeColors({
    required this.accent,
    required this.gray,
    required this.blackAlpha,
    required this.whiteAlpha,
    required this.colorBackground,
    required this.colorSurface,
    required this.colorPanelSolid,
    required this.colorPanelTranslucent,
    required this.colorOverlay,
    required this.shadowStroke,
    required this.focus8,
    required this.focusA8,
  });
}

// Map by enum .name to generated RadixColorTheme instances (light/dark contained).
const Map<String, RadixColorTheme> _accentThemesByName = {
  'amber': amber,
  'blue': blue,
  'bronze': bronze,
  'brown': brown,
  'crimson': crimson,
  'cyan': cyan,
  'gold': gold,
  'grass': grass,
  'green': green,
  'indigo': indigo,
  'iris': iris,
  'jade': jade,
  'lime': lime,
  'mint': mint,
  'orange': orange,
  'pink': pink,
  'plum': plum,
  'purple': purple,
  'red': red,
  'ruby': ruby,
  'sky': sky,
  'teal': teal,
  'tomato': tomato,
  'violet': violet,
  'yellow': yellow,
  // neutrals also exist as accent enums for convenience
  'gray': gray,
  'mauve': mauve,
  'slate': slate,
  'sage': sage,
  'olive': olive,
  'sand': sand,
};

const Map<String, RadixColorTheme> _grayThemesByName = {
  'gray': gray,
  'mauve': mauve,
  'slate': slate,
  'sage': sage,
  'olive': olive,
  'sand': sand,
};

/// Resolves all computed tokens for a theme configuration.
FortalThemeColors resolveFortalTokens(FortalThemeConfig theme) {
  // Pick light/dark RadixColor for accent and neutral using enum .name keys
  final String accentName = theme.accent.name;
  final String grayName = theme.gray.name;
  final RadixColorTheme accentTheme = _accentThemesByName[accentName]!;
  final RadixColorTheme grayTheme = _grayThemesByName[grayName]!;
  final RadixColor accentRC = theme.isDark
      ? accentTheme.dark
      : accentTheme.light;
  final RadixColor grayRC = theme.isDark ? grayTheme.dark : grayTheme.light;

  // Extract scales
  final RadixColorScale accent = accentRC.scale;
  final RadixColorScale gray = grayRC.scale;

  // Neutral alpha swatches
  final ColorSwatch<int> blackA = blackAlpha;
  final ColorSwatch<int> whiteA = whiteAlpha;

  // Backgrounds/panels/overlay
  final Color colorBackground = computeColorBackground(
    gray,
    isDark: theme.isDark,
  );
  final Color colorPanelSolid = computeColorPanelSolid(
    gray,
    isDark: theme.isDark,
  );
  final Color colorPanelTranslucent = computeColorPanelTranslucent(
    gray,
    isDark: theme.isDark,
  );
  final Color colorSurface = computeColorSurface(isDark: theme.isDark);
  final Color colorOverlay = computeColorOverlay(isDark: theme.isDark);
  final Color shadowStroke = computeShadowStroke(gray, isDark: theme.isDark);

  // Focus
  final Color focus8 = computeFocus8(accent);
  final Color focusA8 = computeFocusA8(accent);

  return FortalThemeColors(
    accent: accentRC,
    gray: grayRC,
    blackAlpha: blackA,
    whiteAlpha: whiteA,
    colorBackground: colorBackground,
    colorSurface: colorSurface,
    colorPanelSolid: colorPanelSolid,
    colorPanelTranslucent: colorPanelTranslucent,
    colorOverlay: colorOverlay,
    shadowStroke: shadowStroke,
    focus8: focus8,
    focusA8: focusA8,
  );
}
