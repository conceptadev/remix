import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'computed.dart';
import 'radix_colors.dart' as radix;
import 'theme_scope.dart' show FortalScope;
import 'tokens.dart';

/// Available accent colors matching Radix Themes names.
enum FortalAccentColor {
  gray,
  mauve,
  slate,
  sage,
  olive,
  sand,
  gold,
  bronze,
  brown,
  yellow,
  amber,
  orange,
  tomato,
  red,
  ruby,
  crimson,
  pink,
  plum,
  purple,
  violet,
  iris,
  indigo,
  blue,
  cyan,
  teal,
  jade,
  green,
  grass,
  lime,
  mint,
  sky,
}

/// Available neutral gray families matching Radix Themes names.
enum FortalGrayColor { gray, mauve, slate, sage, olive, sand }

/// Theme-level radius multipliers matching the Radix Themes presets.
enum FortalRadius { none, small, medium, large, full }

/// Background treatment used by floating panels.
enum FortalPanelBackground { solid, translucent }

/// Discrete theme scaling values supported by Radix Themes.
enum FortalScaling {
  percent90(0.9),
  percent95(0.95),
  percent100(1.0),
  percent105(1.05),
  percent110(1.1);

  const FortalScaling(this.factor);

  /// Numeric multiplier represented by this preset.
  final double factor;
}

/// Partial theme values applied by a [FortalScope].
@immutable
class FortalThemeConfig {
  const FortalThemeConfig({
    this.accent,
    this.gray,
    this.brightness,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
  });

  final FortalAccentColor? accent;
  final FortalGrayColor? gray;
  final Brightness? brightness;
  final FortalPanelBackground? panelBackground;
  final FortalRadius? radius;
  final FortalScaling? scaling;
  final bool? hasBackground;

  bool get isDark => brightness == .dark;

  FortalThemeConfig copyWith({
    FortalAccentColor? accent,
    FortalGrayColor? gray,
    Brightness? brightness,
    FortalPanelBackground? panelBackground,
    FortalRadius? radius,
    FortalScaling? scaling,
    bool? hasBackground,
  }) => FortalThemeConfig(
    accent: accent ?? this.accent,
    gray: gray ?? this.gray,
    brightness: brightness ?? this.brightness,
    panelBackground: panelBackground ?? this.panelBackground,
    radius: radius ?? this.radius,
    scaling: scaling ?? this.scaling,
    hasBackground: hasBackground ?? this.hasBackground,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FortalThemeConfig &&
          accent == other.accent &&
          gray == other.gray &&
          brightness == other.brightness &&
          panelBackground == other.panelBackground &&
          radius == other.radius &&
          scaling == other.scaling &&
          hasBackground == other.hasBackground;

  @override
  int get hashCode => Object.hash(
    accent,
    gray,
    brightness,
    panelBackground,
    radius,
    scaling,
    hasBackground,
  );

  Widget createScope({List<Type>? orderOfModifiers, required Widget child}) =>
      FortalScope(
        accent: accent,
        gray: gray,
        brightness: brightness,
        panelBackground: panelBackground,
        radius: radius,
        scaling: scaling,
        hasBackground: hasBackground,
        orderOfModifiers: orderOfModifiers,
        child: child,
      );
}

/// Fully resolved theme values inherited by a Fortal subtree.
@immutable
class FortalThemeData extends FortalThemeConfig {
  const FortalThemeData({
    required this.accent,
    required this.gray,
    required this.brightness,
    required this.panelBackground,
    required this.radius,
    required this.scaling,
    required this.hasBackground,
  }) : super(
         accent: accent,
         gray: gray,
         brightness: brightness,
         panelBackground: panelBackground,
         radius: radius,
         scaling: scaling,
         hasBackground: hasBackground,
       );

  @override
  final FortalAccentColor accent;
  @override
  final FortalGrayColor gray;
  @override
  final Brightness brightness;
  @override
  final FortalPanelBackground panelBackground;
  @override
  final FortalRadius radius;
  @override
  final FortalScaling scaling;
  @override
  final bool hasBackground;

  @override
  bool get isDark => brightness == .dark;

  @override
  FortalThemeData copyWith({
    FortalAccentColor? accent,
    FortalGrayColor? gray,
    Brightness? brightness,
    FortalPanelBackground? panelBackground,
    FortalRadius? radius,
    FortalScaling? scaling,
    bool? hasBackground,
  }) => FortalThemeData(
    accent: accent ?? this.accent,
    gray: gray ?? this.gray,
    brightness: brightness ?? this.brightness,
    panelBackground: panelBackground ?? this.panelBackground,
    radius: radius ?? this.radius,
    scaling: scaling ?? this.scaling,
    hasBackground: hasBackground ?? this.hasBackground,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FortalThemeData &&
          accent == other.accent &&
          gray == other.gray &&
          brightness == other.brightness &&
          panelBackground == other.panelBackground &&
          radius == other.radius &&
          scaling == other.scaling &&
          hasBackground == other.hasBackground;

  @override
  int get hashCode => Object.hash(
    accent,
    gray,
    brightness,
    panelBackground,
    radius,
    scaling,
    hasBackground,
  );
}

/// Builds the token map for a Fortal scope. Used by [FortalScope].
Map<MixToken, Object> buildFortalScopeTokens(FortalThemeData theme) {
  final tokens = resolveFortalTokens(theme);
  final scaling = theme.scaling.factor;
  final shadows = buildFortalShadows(isDark: theme.isDark, colors: tokens);

  final colorTokens = {
    // Role and functional tokens
    FortalTokens.colorBackground: tokens.colorBackground,
    FortalTokens.colorSurface: tokens.colorSurface,
    FortalTokens.segmentedControlIndicatorBackground: theme.isDark
        ? tokens.gray.scale.alphaStep(3)
        : tokens.colorBackground,
    FortalTokens.colorPanelSolid: tokens.colorPanelSolid,
    FortalTokens.colorPanelTranslucent: tokens.colorPanelTranslucent,
    FortalTokens.colorPanel: theme.panelBackground == .solid
        ? tokens.colorPanelSolid
        : tokens.colorPanelTranslucent,
    FortalTokens.colorOverlay: tokens.colorOverlay,
    FortalTokens.sliderHighContrastOverlay: theme.isDark
        ? const Color(0x00000000)
        : tokens.blackAlpha[8]!,
    FortalTokens.error3: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(3),
    FortalTokens.error7: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(7),
    FortalTokens.error8: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(8),
    FortalTokens.error9: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(9),
    FortalTokens.error11: (theme.isDark ? radix.red.dark : radix.red.light)
        .scale
        .step(11),
    FortalTokens.error12: (theme.isDark ? radix.red.dark : radix.red.light)
        .scale
        .step(12),
    FortalTokens.errorA7: (theme.isDark ? radix.red.dark : radix.red.light)
        .scale
        .alphaStep(7),
    ..._accentColorTokens(tokens),
    // Gray steps
    FortalTokens.gray1: tokens.gray.scale.step(1),
    FortalTokens.gray2: tokens.gray.scale.step(2),
    FortalTokens.gray3: tokens.gray.scale.step(3),
    FortalTokens.gray4: tokens.gray.scale.step(4),
    FortalTokens.gray5: tokens.gray.scale.step(5),
    FortalTokens.gray6: tokens.gray.scale.step(6),
    FortalTokens.gray7: tokens.gray.scale.step(7),
    FortalTokens.gray8: tokens.gray.scale.step(8),
    FortalTokens.gray9: tokens.gray.scale.step(9),
    FortalTokens.gray10: tokens.gray.scale.step(10),
    FortalTokens.gray11: tokens.gray.scale.step(11),
    FortalTokens.gray12: tokens.gray.scale.step(12),
    // Gray role tokens (from resolved colors)
    FortalTokens.graySurface: tokens.gray.surface,
    FortalTokens.grayIndicator: tokens.gray.indicator,
    FortalTokens.grayTrack: tokens.gray.track,
    FortalTokens.grayContrast: tokens.gray.contrast,
    // Gray alpha a1..a12
    FortalTokens.grayA1: tokens.gray.scale.alphaStep(1),
    FortalTokens.grayA2: tokens.gray.scale.alphaStep(2),
    FortalTokens.grayA3: tokens.gray.scale.alphaStep(3),
    FortalTokens.grayA4: tokens.gray.scale.alphaStep(4),
    FortalTokens.grayA5: tokens.gray.scale.alphaStep(5),
    FortalTokens.grayA6: tokens.gray.scale.alphaStep(6),
    FortalTokens.grayA7: tokens.gray.scale.alphaStep(7),
    FortalTokens.grayA8: tokens.gray.scale.alphaStep(8),
    FortalTokens.grayA9: tokens.gray.scale.alphaStep(9),
    FortalTokens.grayA10: tokens.gray.scale.alphaStep(10),
    FortalTokens.grayA11: tokens.gray.scale.alphaStep(11),
    FortalTokens.grayA12: tokens.gray.scale.alphaStep(12),
    // Neutral helpers derived from primitives
    FortalTokens.blackA1: tokens.blackAlpha[1]!,
    FortalTokens.blackA2: tokens.blackAlpha[2]!,
    FortalTokens.blackA3: tokens.blackAlpha[3]!,
    FortalTokens.blackA4: tokens.blackAlpha[4]!,
    FortalTokens.blackA5: tokens.blackAlpha[5]!,
    FortalTokens.blackA6: tokens.blackAlpha[6]!,
    FortalTokens.blackA7: tokens.blackAlpha[7]!,
    FortalTokens.blackA8: tokens.blackAlpha[8]!,
    FortalTokens.blackA9: tokens.blackAlpha[9]!,
    FortalTokens.blackA10: tokens.blackAlpha[10]!,
    FortalTokens.blackA11: tokens.blackAlpha[11]!,
    FortalTokens.blackA12: tokens.blackAlpha[12]!,
    FortalTokens.whiteA1: tokens.whiteAlpha[1]!,
    FortalTokens.whiteA2: tokens.whiteAlpha[2]!,
    FortalTokens.whiteA3: tokens.whiteAlpha[3]!,
    FortalTokens.whiteA4: tokens.whiteAlpha[4]!,
    FortalTokens.whiteA5: tokens.whiteAlpha[5]!,
    FortalTokens.whiteA6: tokens.whiteAlpha[6]!,
    FortalTokens.whiteA7: tokens.whiteAlpha[7]!,
    FortalTokens.whiteA8: tokens.whiteAlpha[8]!,
    FortalTokens.whiteA9: tokens.whiteAlpha[9]!,
    FortalTokens.whiteA10: tokens.whiteAlpha[10]!,
    FortalTokens.whiteA11: tokens.whiteAlpha[11]!,
    FortalTokens.whiteA12: tokens.whiteAlpha[12]!,
    FortalTokens.shadowStroke: tokens.shadowStroke,
    FortalTokens.grayStroke3: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(3),
      tokens.gray.scale.step(3),
      0.25,
    ),
    FortalTokens.grayStroke4: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(4),
      tokens.gray.scale.step(4),
      0.25,
    ),
    FortalTokens.grayStroke5: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(5),
      tokens.gray.scale.step(5),
      0.25,
    ),
    FortalTokens.grayStroke6: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(6),
      tokens.gray.scale.step(6),
      0.25,
    ),
    FortalTokens.grayStroke7: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(7),
      tokens.gray.scale.step(7),
      0.25,
    ),
    FortalTokens.dataTableBorder: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(5),
      tokens.gray.scale.step(6),
      0.5,
    ),
  };

  // Build base tokens map
  final allTokens = <MixToken, Object>{
    ...colorTokens,
    // Defaults (may be overridden by JSON tokens below)
    FortalTokens.panelBlur:
        theme.panelBackground == FortalPanelBackground.translucent ? 64.0 : 0.0,
    FortalTokens.space1: 4.0 * scaling,
    FortalTokens.space2: 8.0 * scaling,
    FortalTokens.space3: 12.0 * scaling,
    FortalTokens.space4: 16.0 * scaling,
    FortalTokens.space5: 24.0 * scaling,
    FortalTokens.space6: 32.0 * scaling,
    FortalTokens.space7: 40.0 * scaling,
    FortalTokens.space8: 48.0 * scaling,
    FortalTokens.space9: 64.0 * scaling,
    FortalTokens.spinnerSize3: 20.0 * scaling,
    FortalTokens.dataTableRowHeight1: 36.0 * scaling,
    FortalTokens.dataTableRowHeight2: 44.0 * scaling,
    FortalTokens.toggleGap1: 2.0 * scaling,
    FortalTokens.toggleGap3: 6.0 * scaling,
    FortalTokens.avatarSize6: 80.0 * scaling,
    FortalTokens.avatarSize7: 96.0 * scaling,
    FortalTokens.avatarSize8: 128.0 * scaling,
    FortalTokens.avatarSize9: 160.0 * scaling,
    FortalTokens.avatarIconSize1: 12.0 * scaling,
    FortalTokens.avatarIconSize2: 16.0 * scaling,
    FortalTokens.avatarIconSize3: 20.0 * scaling,
    FortalTokens.avatarIconSize4: 24.0 * scaling,
    FortalTokens.avatarIconSize5: 32.0 * scaling,
    FortalTokens.avatarIconSize6: 40.0 * scaling,
    FortalTokens.avatarIconSize7: 48.0 * scaling,
    FortalTokens.avatarIconSize8: 64.0 * scaling,
    FortalTokens.avatarIconSize9: 80.0 * scaling,
    FortalTokens.badgePaddingX1: 6.0 * scaling,
    FortalTokens.badgePaddingY1: 2.0 * scaling,
    FortalTokens.badgePaddingX3: 10.0 * scaling,
    FortalTokens.checkboxSize1: 14.0 * scaling,
    FortalTokens.checkboxSize3: 20.0 * scaling,
    FortalTokens.checkboxIndicatorSize1: 9.0 * scaling,
    FortalTokens.checkboxIndicatorSize2: 10.0 * scaling,
    FortalTokens.checkboxIndicatorSize3: 12.0 * scaling,
    FortalTokens.checkboxGroupItemGap1: 6.0 * scaling,
    FortalTokens.checkboxGroupItemGap2: 7.0 * scaling,
    FortalTokens.checkboxGroupItemGap3: 8.0 * scaling,
    FortalTokens.radioIndicatorSize1: 5.6 * scaling,
    FortalTokens.radioIndicatorSize2: 6.4 * scaling,
    FortalTokens.radioIndicatorSize3: 8.0 * scaling,
    FortalTokens.checkboxRadius1: _scaledRadiusToken(
      theme.radius,
      scaling,
      3.0 * 0.875,
    ),
    FortalTokens.checkboxRadius3: _scaledRadiusToken(
      theme.radius,
      scaling,
      3.0 * 1.25,
    ),
    FortalTokens.switchHeight2: 20.0 * scaling,
    FortalTokens.switchWidth1: 28.0 * scaling,
    FortalTokens.switchWidth2: 35.0 * scaling,
    FortalTokens.switchWidth3: 42.0 * scaling,
    FortalTokens.switchThumbSize1: 16.0 * scaling - 2.0,
    FortalTokens.switchThumbSize2: 20.0 * scaling - 2.0,
    FortalTokens.switchThumbSize3: 24.0 * scaling - 2.0,
    FortalTokens.progressHeight2: 6.0 * scaling,
    FortalTokens.sliderTrackSize1: 6.0 * scaling,
    FortalTokens.sliderTrackSize2: 8.0 * scaling,
    FortalTokens.sliderTrackSize3: 10.0 * scaling,
    FortalTokens.sliderThumbSize1: 13.0 * scaling,
    FortalTokens.sliderThumbSize2: 16.0 * scaling,
    FortalTokens.sliderThumbSize3: 19.0 * scaling,
    FortalTokens.textFieldPadding1: 6.0 * scaling,
    FortalTokens.textFieldPadding2: 8.0 * scaling,
    FortalTokens.textFieldPadding3: 12.0 * scaling,
    FortalTokens.textAreaMinHeight3: 80.0,
    FortalTokens.dataListRowGap3: 20.0 * scaling,
    FortalTokens.dataListLabelMinWidth: 120.0,
    FortalTokens.tabInnerPaddingY1: 2.0 * scaling,
    FortalTokens.tabActiveLetterSpacing1: -0.12 * scaling,
    FortalTokens.tabActiveLetterSpacing2: -0.14 * scaling,
    FortalTokens.selectSpace1Half: 6.0 * scaling,
    FortalTokens.selectIndicatorWidth1: 20.0 * scaling,
    FortalTokens.selectIndicatorSize1: 8.0 * scaling,
    FortalTokens.selectIndicatorSize2: 10.0 * scaling,
    FortalTokens.selectGhostMarginX12: -8.0 * scaling,
    FortalTokens.selectGhostMarginY12: -4.0 * scaling,
    FortalTokens.selectGhostMarginX3: -12.0 * scaling,
    FortalTokens.selectGhostMarginY3: -6.0 * scaling,
    ..._radiusTokensFor(theme.radius, scaling),

    // Exact layered Radix shadow tokens, resolved for the active color scales.
    ...shadows,
    FortalTokens.sliderClassicDisabledTrackShadows: _scaleShadowOpacity(
      shadows[FortalTokens.shadow1Layers]! as List<RemixBoxShadow>,
      0.5,
    ),
    FortalTokens.cardClassicOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .idle,
    ),
    FortalTokens.cardClassicInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .idle,
    ),
    FortalTokens.cardClassicHoverOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .hovered,
    ),
    FortalTokens.cardClassicHoverInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .hovered,
    ),
    FortalTokens.cardClassicActiveOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .active,
    ),
    FortalTokens.cardClassicActiveInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .active,
    ),
    FortalTokens.selectTriggerClassicShadows: _selectClassicShadows(
      tokens,
      isDark: theme.isDark,
    ),
    FortalTokens.selectTriggerClassicHoverShadows: [
      _insetShadow(tokens.gray.scale.alphaStep(3), spread: 1),
      ..._selectClassicShadows(tokens, isDark: theme.isDark),
    ],
    FortalTokens.baseButtonClassicDisabledShadows:
        _baseButtonClassicDisabledShadows(tokens, isDark: theme.isDark),
    FortalTokens.baseButtonClassicShadows: _baseButtonClassicShadows(
      tokens,
      isDark: theme.isDark,
      highContrast: false,
    ),
    FortalTokens.baseButtonClassicHighContrastShadows:
        _baseButtonClassicShadows(
          tokens,
          isDark: theme.isDark,
          highContrast: true,
        ),
    FortalTokens.baseButtonClassicActiveShadows:
        _baseButtonClassicActiveShadows(tokens, highContrast: false),
    FortalTokens.baseButtonClassicActiveHighContrastShadows:
        _baseButtonClassicActiveShadows(tokens, highContrast: true),
    FortalTokens.baseButtonClassicAfterInset: theme.isDark ? 1.0 : 2.0,
    FortalTokens.baseButtonGhostPaddingY3: 6.0 * scaling,
    FortalTokens.baseButtonGhostMarginX12: -8.0 * scaling,
    FortalTokens.baseButtonGhostMarginY12: -4.0 * scaling,
    FortalTokens.baseButtonGhostMarginX3: -12.0 * scaling,
    FortalTokens.baseButtonGhostMarginY3: -6.0 * scaling,
    FortalTokens.baseButtonGhostMarginX4: -16.0 * scaling,
    FortalTokens.baseButtonGhostMarginY4: -8.0 * scaling,
    FortalTokens.iconButtonGhostPadding2: 6.0 * scaling,
    FortalTokens.iconButtonGhostMargin1: -4.0 * scaling,
    FortalTokens.iconButtonGhostMargin2: -6.0 * scaling,
    FortalTokens.iconButtonGhostMargin3: -8.0 * scaling,
    FortalTokens.iconButtonGhostMargin4: -12.0 * scaling,
    FortalTokens.cardGhostMargin1: -12.0 * scaling,
    FortalTokens.cardGhostMargin2: -16.0 * scaling,
    FortalTokens.cardGhostMargin3: -24.0 * scaling,
    FortalTokens.cardGhostMargin4: -32.0 * scaling,
    FortalTokens.cardGhostMargin5: -48.0 * scaling,
    FortalTokens.borderWidth1: 1.0,
    FortalTokens.borderWidth2: 2.0,
    FortalTokens.focusRingWidth: 2.0,
    FortalTokens.focusRingOffset: 2.0,
    FortalTokens.text1: TextStyle(
      fontSize: 12.0 * scaling,
      letterSpacing: 0.0025 * 12.0 * scaling,
      height: 16.0 / 12.0,
    ),
    FortalTokens.text2: TextStyle(
      fontSize: 14.0 * scaling,
      letterSpacing: 0.0,
      height: 20.0 / 14.0,
    ),
    FortalTokens.text3: TextStyle(
      fontSize: 16.0 * scaling,
      letterSpacing: 0.0,
      height: 24.0 / 16.0,
    ),
    FortalTokens.accordionText2: TextStyle(
      fontSize: 15.0 * scaling,
      letterSpacing: 0.0,
      height: 20.0 / 15.0,
    ),
    FortalTokens.text4: TextStyle(
      fontSize: 18.0 * scaling,
      letterSpacing: -0.0025 * 18.0 * scaling,
      height: 26.0 / 18.0,
    ),
    FortalTokens.text5: TextStyle(
      fontSize: 20.0 * scaling,
      letterSpacing: -0.005 * 20.0 * scaling,
      height: 28.0 / 20.0,
    ),
    FortalTokens.text6: TextStyle(
      fontSize: 24.0 * scaling,
      letterSpacing: -0.00625 * 24.0 * scaling,
      height: 30.0 / 24.0,
    ),
    FortalTokens.text7: TextStyle(
      fontSize: 28.0 * scaling,
      letterSpacing: -0.0075 * 28.0 * scaling,
      height: 36.0 / 28.0,
    ),
    FortalTokens.text8: TextStyle(
      fontSize: 35.0 * scaling,
      letterSpacing: -0.01 * 35.0 * scaling,
      height: 40.0 / 35.0,
    ),
    FortalTokens.text9: TextStyle(
      fontSize: 60.0 * scaling,
      letterSpacing: -0.025 * 60.0 * scaling,
      height: 1.0,
    ),
    FortalTokens.avatarFallback1One: _avatarFallbackText(
      fontSize: 14,
      letterSpacing: 0.0025 * 12,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback1Two: _avatarFallbackText(
      fontSize: 12,
      letterSpacing: 0.0025 * 12,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback2One: _avatarFallbackText(
      fontSize: 16,
      letterSpacing: 0,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback2Two: _avatarFallbackText(
      fontSize: 14,
      letterSpacing: 0,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback3One: _avatarFallbackText(
      fontSize: 18,
      letterSpacing: 0,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback3Two: _avatarFallbackText(
      fontSize: 16,
      letterSpacing: 0,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback4One: _avatarFallbackText(
      fontSize: 20,
      letterSpacing: -0.0025 * 18,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback4Two: _avatarFallbackText(
      fontSize: 18,
      letterSpacing: -0.0025 * 18,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback5: _avatarFallbackText(
      fontSize: 24,
      letterSpacing: -0.00625 * 24,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback6: _avatarFallbackText(
      fontSize: 28,
      letterSpacing: -0.0075 * 28,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback7: _avatarFallbackText(
      fontSize: 28,
      letterSpacing: -0.0075 * 28,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback8: _avatarFallbackText(
      fontSize: 35,
      letterSpacing: -0.01 * 35,
      scaling: scaling,
    ),
    FortalTokens.avatarFallback9: _avatarFallbackText(
      fontSize: 60,
      letterSpacing: -0.025 * 60,
      scaling: scaling,
    ),

    // Font weights (token values)
    FortalTokens.fontWeightLight: FontWeight.w300,
    FortalTokens.fontWeightRegular: FontWeight.w400,
    FortalTokens.fontWeightMedium: FontWeight.w500,
    // Match Radix Themes font weights (bold = 700)
    FortalTokens.fontWeightBold: FontWeight.w700,

    // Durations (token values)
    FortalTokens.transitionFast: Duration(milliseconds: 100),
    FortalTokens.transitionSlow: Duration(milliseconds: 300),
    FortalTokens.skeletonPulseDuration: Duration(milliseconds: 1000),
  };

  return allTokens;
}

TextStyle _avatarFallbackText({
  required double fontSize,
  required double letterSpacing,
  required double scaling,
}) => TextStyle(
  fontSize: fontSize * scaling,
  letterSpacing: letterSpacing * scaling,
  height: 1,
);

enum _CardShadowLayer { outer, inner }

enum _CardShadowState { idle, hovered, active }

List<RemixBoxShadow> _cardClassicShadows(
  FortalThemeColors colors, {
  required bool isDark,
  required _CardShadowLayer layer,
  required _CardShadowState state,
}) {
  final inner = layer == _CardShadowLayer.inner;
  final shapeInset = inner ? 1.0 : 0.0;
  final border = switch ((isDark, state)) {
    (true, _) => mixOklabPremultiplied(
      colors.gray.scale.alphaStep(6),
      colors.gray.scale.step(6),
      0.25,
    ),
    (false, _CardShadowState.hovered) => mixOklabPremultiplied(
      colors.gray.scale.alphaStep(4),
      colors.gray.scale.step(4),
      0.25,
    ),
    (false, _) => mixOklabPremultiplied(
      colors.gray.scale.alphaStep(3),
      colors.gray.scale.step(3),
      0.25,
    ),
  };

  RemixBoxShadow shadow(
    Color color, {
    Offset offset = Offset.zero,
    double blur = 0,
    required double spread,
  }) => RemixBoxShadow(
    color: color,
    offset: offset,
    blurRadius: blur,
    spreadRadius: spread,
    shapeInset: shapeInset,
  );

  if (state == _CardShadowState.hovered) {
    if (isDark) {
      return [
        shadow(border, spread: inner ? 1 : 0),
        shadow(colors.gray.scale.alphaStep(4), blur: 1, spread: inner ? 1 : 0),
        shadow(
          colors.gray.scale.alphaStep(4),
          blur: 1,
          spread: inner ? -1 : -2,
        ),
        shadow(
          colors.gray.scale.alphaStep(3),
          blur: 3,
          spread: inner ? -2 : -3,
        ),
        shadow(
          colors.gray.scale.alphaStep(3),
          blur: 12,
          spread: inner ? -2 : -3,
        ),
        shadow(
          colors.gray.scale.alphaStep(7),
          blur: 16,
          spread: inner ? -8 : -9,
        ),
      ];
    }
    return [
      shadow(border, spread: inner ? 1 : 0),
      shadow(
        colors.blackAlpha[1]!,
        offset: const Offset(0, 1),
        blur: 1,
        spread: inner ? 1 : 0,
      ),
      shadow(
        colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 2),
        blur: 1,
        spread: inner ? -1 : -2,
      ),
      shadow(
        colors.blackAlpha[1]!,
        offset: const Offset(0, 2),
        blur: 3,
        spread: inner ? -2 : -3,
      ),
      shadow(
        colors.gray.scale.alphaStep(3),
        offset: const Offset(0, 3),
        blur: 12,
        spread: inner ? -4 : -5,
      ),
      shadow(
        colors.blackAlpha[1]!,
        offset: const Offset(0, 4),
        blur: 16,
        spread: inner ? -8 : -9,
      ),
    ];
  }

  final active = state == _CardShadowState.active;
  final subtle = isDark ? colors.blackAlpha[3]! : colors.blackAlpha[1]!;
  final middle = isDark
      ? colors.blackAlpha[6]!
      : colors.gray.scale.alphaStep(active ? 4 : 2);
  final bottom = isDark ? colors.blackAlpha[5]! : colors.blackAlpha[1]!;
  return [
    shadow(border, spread: inner ? 1 : 0),
    shadow(const Color(0x00000000), spread: inner ? 1 : 0),
    shadow(subtle, spread: inner ? 0.5 : 0),
    shadow(middle, offset: const Offset(0, 1), blur: 1, spread: inner ? 0 : -1),
    shadow(
      isDark ? colors.blackAlpha[6]! : colors.blackAlpha[1]!,
      offset: const Offset(0, 2),
      blur: 1,
      spread: inner ? -1 : -2,
    ),
    shadow(bottom, offset: const Offset(0, 1), blur: 3, spread: inner ? 0 : -1),
  ];
}

RemixBoxShadow _insetShadow(
  Color color, {
  Offset offset = Offset.zero,
  double blur = 0,
  double spread = 0,
  double shapeInset = 0,
}) => RemixBoxShadow(
  kind: RemixBoxShadowKind.inset,
  color: color,
  offset: offset,
  blurRadius: blur,
  spreadRadius: spread,
  shapeInset: shapeInset,
);

List<RemixBoxShadow> _selectClassicShadows(
  FortalThemeColors colors, {
  required bool isDark,
}) {
  if (isDark) {
    return [
      _insetShadow(colors.whiteAlpha[4]!, spread: 1),
      _insetShadow(colors.whiteAlpha[4]!, offset: const Offset(0, 1), blur: 1),
      _insetShadow(colors.blackAlpha[9]!, offset: const Offset(0, -1), blur: 1),
    ];
  }
  return [
    _insetShadow(colors.gray.scale.alphaStep(5), spread: 1),
    _insetShadow(colors.whiteAlpha[11]!, offset: const Offset(0, 2), blur: 1),
    _insetShadow(
      colors.gray.scale.alphaStep(4),
      offset: const Offset(0, -2),
      blur: 1,
    ),
  ];
}

List<RemixBoxShadow> _baseButtonClassicDisabledShadows(
  FortalThemeColors colors, {
  required bool isDark,
}) {
  if (isDark) {
    return [
      _insetShadow(colors.gray.scale.alphaStep(5), spread: 1),
      _insetShadow(
        colors.gray.scale.alphaStep(2),
        offset: const Offset(0, 4),
        blur: 2,
        spread: -2,
      ),
      _insetShadow(
        colors.gray.scale.alphaStep(5),
        offset: const Offset(0, 1),
        blur: 1,
      ),
      _insetShadow(colors.blackAlpha[3]!, offset: const Offset(0, -1), blur: 1),
      _insetShadow(colors.gray.scale.alphaStep(2), spread: 1),
    ];
  }
  return [
    _insetShadow(colors.gray.scale.alphaStep(4), spread: 1),
    _insetShadow(
      colors.gray.scale.alphaStep(3),
      offset: const Offset(0, -2),
      blur: 1,
    ),
    _insetShadow(
      colors.whiteAlpha[9]!,
      offset: const Offset(0, 4),
      blur: 2,
      spread: -2,
    ),
    _insetShadow(
      colors.whiteAlpha[9]!,
      offset: const Offset(0, 2),
      blur: 1,
      spread: -1,
    ),
  ];
}

List<RemixBoxShadow> _baseButtonClassicShadows(
  FortalThemeColors colors, {
  required bool isDark,
  required bool highContrast,
}) {
  final accent = highContrast
      ? colors.accent.scale.step(12)
      : colors.accent.scale.step(9);
  if (isDark) {
    return [
      _insetShadow(
        colors.whiteAlpha[4]!,
        offset: const Offset(0, 2),
        blur: 3,
        spread: -1,
        shapeInset: 1,
      ),
      _insetShadow(colors.whiteAlpha[2]!, spread: 1),
      _insetShadow(
        colors.whiteAlpha[3]!,
        offset: const Offset(0, 4),
        blur: 2,
        spread: -2,
      ),
      _insetShadow(colors.whiteAlpha[6]!, offset: const Offset(0, 1), blur: 1),
      _insetShadow(colors.blackAlpha[6]!, offset: const Offset(0, -1), blur: 1),
      _insetShadow(accent, spread: 1),
    ];
  }
  return [
    _insetShadow(
      colors.whiteAlpha[4]!,
      offset: const Offset(0, 2),
      blur: 3,
      spread: -1,
      shapeInset: 2,
    ),
    _insetShadow(colors.gray.scale.alphaStep(4), spread: 1),
    _insetShadow(
      colors.gray.scale.alphaStep(3),
      offset: const Offset(0, -2),
      blur: 1,
    ),
    _insetShadow(accent, spread: 1),
    _insetShadow(
      colors.whiteAlpha[9]!,
      offset: const Offset(0, 4),
      blur: 2,
      spread: -2,
    ),
    _insetShadow(
      colors.whiteAlpha[9]!,
      offset: const Offset(0, 2),
      blur: 1,
      spread: -1,
    ),
  ];
}

List<RemixBoxShadow> _baseButtonClassicActiveShadows(
  FortalThemeColors colors, {
  required bool highContrast,
}) {
  final accent = highContrast
      ? colors.accent.scale.step(12)
      : colors.accent.scale.step(9);
  return [
    _insetShadow(
      colors.gray.scale.alphaStep(4),
      offset: const Offset(0, 4),
      blur: 2,
      spread: -2,
    ),
    _insetShadow(
      colors.gray.scale.alphaStep(7),
      offset: const Offset(0, 1),
      blur: 1,
    ),
    _insetShadow(colors.gray.scale.alphaStep(5), spread: 1),
    _insetShadow(accent, spread: 1),
    _insetShadow(
      colors.gray.scale.alphaStep(3),
      offset: const Offset(0, 3),
      blur: 2,
    ),
    _insetShadow(colors.whiteAlpha[7]!, spread: 1),
    _insetShadow(colors.whiteAlpha[5]!, offset: const Offset(0, -2), blur: 1),
  ];
}

Map<RadiusToken, Radius> _radiusTokensFor(FortalRadius radius, double scaling) {
  final factor = _radiusFactor(radius);
  final thumb = switch (radius) {
    .none || .small => const Radius.circular(0.5),
    .medium || .large || .full => const Radius.circular(9999.0),
  };
  Radius scaled(double base) => Radius.circular(base * factor * scaling);
  Radius larger(Radius first, Radius second) => Radius.elliptical(
    first.x > second.x ? first.x : second.x,
    first.y > second.y ? first.y : second.y,
  );
  final radius1 = scaled(3.0);
  final radius2 = scaled(4.0);
  final radius3 = scaled(6.0);
  final radius4 = scaled(8.0);
  final radius5 = scaled(12.0);
  final radius6 = scaled(16.0);
  final full = radius == .full ? const Radius.circular(9999.0) : Radius.zero;
  Radius progressRadius(double height) {
    final thumbBase = switch (radius) {
      .none || .small => 0.5,
      .medium || .large || .full => 9999.0,
    };
    return Radius.circular(math.max(factor * height / 3, factor * thumbBase));
  }

  return {
    FortalTokens.radius1: radius1,
    FortalTokens.radius2: radius2,
    FortalTokens.radius3: radius3,
    FortalTokens.radius4: radius4,
    FortalTokens.radius5: radius5,
    FortalTokens.radius6: radius6,
    FortalTokens.radiusFull: full,
    FortalTokens.radiusThumb: thumb,
    FortalTokens.radiusCircle: const Radius.circular(9999.0),
    FortalTokens.radius1OrFull: larger(radius1, full),
    FortalTokens.radius2OrFull: larger(radius2, full),
    FortalTokens.radius3OrFull: larger(radius3, full),
    FortalTokens.radius4OrFull: larger(radius4, full),
    FortalTokens.radius5OrFull: larger(radius5, full),
    FortalTokens.radius6OrFull: larger(radius6, full),
    FortalTokens.radius1OrThumb: larger(radius1, thumb),
    FortalTokens.radius2OrThumb: larger(radius2, thumb),
    FortalTokens.progressRadius1: progressRadius(4.0 * scaling),
    FortalTokens.progressRadius2: progressRadius(6.0 * scaling),
    FortalTokens.progressRadius3: progressRadius(8.0 * scaling),
    FortalTokens.sliderTrackRadius1: progressRadius(6.0 * scaling),
    FortalTokens.sliderTrackRadius2: progressRadius(8.0 * scaling),
    FortalTokens.sliderTrackRadius3: progressRadius(10.0 * scaling),
  };
}

List<RemixBoxShadow> _scaleShadowOpacity(
  List<RemixBoxShadow> shadows,
  double factor,
) => [
  for (final shadow in shadows)
    RemixBoxShadow(
      kind: shadow.kind,
      color: shadow.color.withValues(alpha: shadow.color.a * factor),
      offset: shadow.offset,
      blurRadius: shadow.blurRadius,
      spreadRadius: shadow.spreadRadius,
      shapeInset: shadow.shapeInset,
    ),
];

double _radiusFactor(FortalRadius radius) => switch (radius) {
  .none => 0.0,
  .small => 0.75,
  .medium => 1.0,
  .large || .full => 1.5,
};

Radius _scaledRadiusToken(FortalRadius radius, double scaling, double base) =>
    Radius.circular(base * scaling * _radiusFactor(radius));

Map<ColorToken, Color> _accentColorTokens(FortalThemeColors tokens) {
  final scale = tokens.accent.scale;

  return {
    FortalTokens.accentSurface: tokens.accent.surface,
    FortalTokens.accentIndicator: tokens.accent.indicator,
    FortalTokens.accentTrack: tokens.accent.track,
    FortalTokens.accentContrast: tokens.accent.contrast,
    FortalTokens.focus8: tokens.focus8,
    FortalTokens.focusA5: tokens.focusA5,
    FortalTokens.focusA8: tokens.focusA8,
    FortalTokens.accent1: scale.step(1),
    FortalTokens.accent2: scale.step(2),
    FortalTokens.accent3: scale.step(3),
    FortalTokens.accent4: scale.step(4),
    FortalTokens.accent5: scale.step(5),
    FortalTokens.accent6: scale.step(6),
    FortalTokens.accent7: scale.step(7),
    FortalTokens.accent8: scale.step(8),
    FortalTokens.accent9: scale.step(9),
    FortalTokens.accent10: scale.step(10),
    FortalTokens.accent11: scale.step(11),
    FortalTokens.accent12: scale.step(12),
    FortalTokens.accentA1: scale.alphaStep(1),
    FortalTokens.accentA2: scale.alphaStep(2),
    FortalTokens.accentA3: scale.alphaStep(3),
    FortalTokens.accentA4: scale.alphaStep(4),
    FortalTokens.accentA5: scale.alphaStep(5),
    FortalTokens.accentA6: scale.alphaStep(6),
    FortalTokens.accentA7: scale.alphaStep(7),
    FortalTokens.accentA8: scale.alphaStep(8),
    FortalTokens.accentA9: scale.alphaStep(9),
    FortalTokens.accentA10: scale.alphaStep(10),
    FortalTokens.accentA11: scale.alphaStep(11),
    FortalTokens.accentA12: scale.alphaStep(12),
  };
}
