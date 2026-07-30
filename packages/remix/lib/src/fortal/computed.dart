/// Fortal computed tokens and functional color utilities.
///
/// Implements computed role tokens (accent-contrast, accent-track, etc.) and
/// background/overlay colors that mirror Radix Themes behavior while keeping the
/// original Radix Colors data.
///
/// Components should use these functional roles rather than raw color steps.

// Documentation for all public APIs is provided below

import 'dart:math' as math;
import 'dart:ui' show Color, Offset;

import 'package:flutter/painting.dart' show BoxShadow, ColorSwatch;
import 'package:mix/mix.dart' show MixToken;

import '../radix/colors/colors.dart';
import '../rendering/remix_box_effects.dart';
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
    mixOklabPremultiplied(
      gray.alphaStep(isDark ? 6 : 3),
      gray.step(isDark ? 6 : 3),
      0.25,
    );

/// Mixes two sRGB colors in OKLab after premultiplying their channels by
/// alpha, matching CSS `color-mix(in oklab, ...)` for translucent colors.
Color mixOklabPremultiplied(Color first, Color second, double amount) {
  if (!amount.isFinite || amount < 0 || amount > 1) {
    throw ArgumentError.value(
      amount,
      'amount',
      'Expected a value from 0 to 1.',
    );
  }
  final firstWeight = 1 - amount;
  final alpha = first.a * firstWeight + second.a * amount;
  if (alpha == 0) return const Color(0x00000000);

  final firstLab = _srgbToOklab(first);
  final secondLab = _srgbToOklab(second);
  final mixedLab = (
    lightness:
        (firstLab.lightness * first.a * firstWeight +
            secondLab.lightness * second.a * amount) /
        alpha,
    a:
        (firstLab.a * first.a * firstWeight + secondLab.a * second.a * amount) /
        alpha,
    b:
        (firstLab.b * first.a * firstWeight + secondLab.b * second.a * amount) /
        alpha,
  );
  final rgb = _oklabToSrgb(mixedLab);

  return Color.from(
    alpha: alpha,
    red: rgb.red.clamp(0, 1),
    green: rgb.green.clamp(0, 1),
    blue: rgb.blue.clamp(0, 1),
  );
}

({double lightness, double a, double b}) _srgbToOklab(Color color) {
  final red = _linearizeSrgb(color.r);
  final green = _linearizeSrgb(color.g);
  final blue = _linearizeSrgb(color.b);
  final l = math
      .pow(
        0.4122214708 * red + 0.5363325363 * green + 0.0514459929 * blue,
        1 / 3,
      )
      .toDouble();
  final m = math
      .pow(
        0.2119034982 * red + 0.6806995451 * green + 0.1073969566 * blue,
        1 / 3,
      )
      .toDouble();
  final s = math
      .pow(
        0.0883024619 * red + 0.2817188376 * green + 0.6299787005 * blue,
        1 / 3,
      )
      .toDouble();

  return (
    lightness: 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    a: 1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    b: 0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s,
  );
}

({double red, double green, double blue}) _oklabToSrgb(
  ({double lightness, double a, double b}) color,
) {
  final l = math
      .pow(color.lightness + 0.3963377774 * color.a + 0.2158037573 * color.b, 3)
      .toDouble();
  final m = math
      .pow(color.lightness - 0.1055613458 * color.a - 0.0638541728 * color.b, 3)
      .toDouble();
  final s = math
      .pow(color.lightness - 0.0894841775 * color.a - 1.2914855480 * color.b, 3)
      .toDouble();

  return (
    red: _encodeSrgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
    green: _encodeSrgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
    blue: _encodeSrgb(-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s),
  );
}

double _linearizeSrgb(double channel) => channel <= 0.04045
    ? channel / 12.92
    : math.pow((channel + 0.055) / 1.055, 2.4).toDouble();

double _encodeSrgb(double channel) => channel <= 0.0031308
    ? 12.92 * channel
    : 1.055 * math.pow(channel, 1 / 2.4).toDouble() - 0.055;

/// Builds Radix Themes elevation shadows for the active brightness.
Map<MixToken, Object> buildFortalShadows({
  required bool isDark,
  required FortalThemeColors colors,
}) {
  if (isDark) {
    final shadows = <String, List<RemixBoxShadow>>{
      'shadow1': [
        _shadow(
          colors.gray.scale.alphaStep(3),
          kind: .inset,
          offset: const Offset(0, -1),
          blur: 1,
        ),
        _shadow(colors.gray.scale.alphaStep(3), kind: .inset, spread: 1),
        _shadow(
          colors.blackAlpha[5]!,
          kind: .inset,
          offset: const Offset(0, 3),
          blur: 4,
        ),
        _shadow(colors.gray.scale.alphaStep(4), kind: .inset, spread: 1),
      ],
      'shadow2': [
        _shadow(colors.shadowStroke, spread: 1),
        _shadow(colors.blackAlpha[3]!, blur: 0.5),
        _shadow(colors.blackAlpha[6]!, offset: const Offset(0, 1), blur: 1),
        _shadow(
          colors.blackAlpha[6]!,
          offset: const Offset(0, 2),
          blur: 1,
          spread: -1,
        ),
        _shadow(colors.blackAlpha[5]!, offset: const Offset(0, 1), blur: 3),
      ],
      'shadow3': [
        _shadow(colors.shadowStroke, spread: 1),
        _shadow(
          colors.blackAlpha[3]!,
          offset: const Offset(0, 2),
          blur: 3,
          spread: -2,
        ),
        _shadow(
          colors.blackAlpha[6]!,
          offset: const Offset(0, 3),
          blur: 8,
          spread: -2,
        ),
        _shadow(
          colors.blackAlpha[7]!,
          offset: const Offset(0, 4),
          blur: 12,
          spread: -4,
        ),
      ],
      'shadow4': [
        _shadow(colors.shadowStroke, spread: 1),
        _shadow(colors.blackAlpha[3]!, offset: const Offset(0, 8), blur: 40),
        _shadow(
          colors.blackAlpha[5]!,
          offset: const Offset(0, 12),
          blur: 32,
          spread: -16,
        ),
      ],
      'shadow5': [
        _shadow(colors.shadowStroke, spread: 1),
        _shadow(colors.blackAlpha[5]!, offset: const Offset(0, 12), blur: 60),
        _shadow(
          colors.blackAlpha[7]!,
          offset: const Offset(0, 12),
          blur: 32,
          spread: -16,
        ),
      ],
      'shadow6': [
        _shadow(colors.shadowStroke, spread: 1),
        _shadow(colors.blackAlpha[4]!, offset: const Offset(0, 12), blur: 60),
        _shadow(colors.blackAlpha[6]!, offset: const Offset(0, 16), blur: 64),
        _shadow(
          colors.blackAlpha[11]!,
          offset: const Offset(0, 16),
          blur: 36,
          spread: -20,
        ),
      ],
    };
    return _fortalShadowTokens(shadows);
  }

  final shadows = <String, List<RemixBoxShadow>>{
    'shadow1': [
      _shadow(colors.gray.scale.alphaStep(5), kind: .inset, spread: 1),
      _shadow(
        colors.gray.scale.alphaStep(2),
        kind: .inset,
        offset: const Offset(0, 1.5),
        blur: 2,
      ),
      _shadow(
        colors.blackAlpha[2]!,
        kind: .inset,
        offset: const Offset(0, 1.5),
        blur: 2,
      ),
    ],
    'shadow2': [
      _shadow(colors.shadowStroke, spread: 1),
      _shadow(colors.blackAlpha[1]!, blur: 0.5),
      _shadow(
        colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 1),
        blur: 1,
      ),
      _shadow(
        colors.blackAlpha[1]!,
        offset: const Offset(0, 2),
        blur: 1,
        spread: -1,
      ),
      _shadow(colors.blackAlpha[1]!, offset: const Offset(0, 1), blur: 3),
    ],
    'shadow3': [
      _shadow(colors.shadowStroke, spread: 1),
      _shadow(
        colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 2),
        blur: 3,
        spread: -2,
      ),
      _shadow(
        colors.blackAlpha[2]!,
        offset: const Offset(0, 3),
        blur: 12,
        spread: -4,
      ),
      _shadow(
        colors.blackAlpha[2]!,
        offset: const Offset(0, 4),
        blur: 16,
        spread: -8,
      ),
    ],
    'shadow4': [
      _shadow(colors.shadowStroke, spread: 1),
      _shadow(colors.blackAlpha[1]!, offset: const Offset(0, 8), blur: 40),
      _shadow(
        colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 12),
        blur: 32,
        spread: -16,
      ),
    ],
    'shadow5': [
      _shadow(colors.shadowStroke, spread: 1),
      _shadow(colors.blackAlpha[3]!, offset: const Offset(0, 12), blur: 60),
      _shadow(
        colors.gray.scale.alphaStep(5),
        offset: const Offset(0, 12),
        blur: 32,
        spread: -16,
      ),
    ],
    'shadow6': [
      _shadow(colors.shadowStroke, spread: 1),
      _shadow(colors.blackAlpha[3]!, offset: const Offset(0, 12), blur: 60),
      _shadow(
        colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 16),
        blur: 64,
      ),
      _shadow(
        colors.gray.scale.alphaStep(7),
        offset: const Offset(0, 16),
        blur: 36,
        spread: -20,
      ),
    ],
  };
  return _fortalShadowTokens(shadows);
}

Map<MixToken, Object> _fortalShadowTokens(
  Map<String, List<RemixBoxShadow>> shadows,
) {
  final shadow1 = shadows['shadow1']!;
  return {
    FortalTokens.shadow1: _ordinaryShadows(shadow1),
    FortalTokens.shadow1Layers: shadow1,
    FortalTokens.shadow2: _ordinaryShadows(shadows['shadow2']!),
    FortalTokens.shadow3: _ordinaryShadows(shadows['shadow3']!),
    FortalTokens.shadow4: _ordinaryShadows(shadows['shadow4']!),
    FortalTokens.shadow5: _ordinaryShadows(shadows['shadow5']!),
    FortalTokens.shadow6: _ordinaryShadows(shadows['shadow6']!),
  };
}

List<BoxShadow> _ordinaryShadows(List<RemixBoxShadow> shadows) => [
  for (final shadow in shadows)
    BoxShadow(
      color: shadow.color,
      offset: shadow.offset,
      blurRadius: shadow.blurRadius,
      spreadRadius: shadow.spreadRadius,
    ),
];

RemixBoxShadow _shadow(
  Color color, {
  RemixBoxShadowKind kind = RemixBoxShadowKind.outer,
  Offset offset = Offset.zero,
  double blur = 0,
  double spread = 0,
}) => RemixBoxShadow(
  kind: kind,
  color: color,
  offset: offset,
  blurRadius: blur,
  spreadRadius: spread,
);

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
  'gray': gray,
  'mauve': mauve,
  'slate': slate,
  'sage': sage,
  'olive': olive,
  'sand': sand,
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
  final accentColor = theme.accent ?? FortalAccentColor.indigo;
  final grayColor = theme.gray ?? FortalGrayColor.slate;
  final String accentName = accentColor.name;
  final String grayName = grayColor.name;
  final RadixColorTheme grayTheme = _grayThemesByName[grayName]!;
  final RadixColorTheme accentTheme = accentColor == .gray
      ? grayTheme
      : _accentThemesByName[accentName]!;
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
