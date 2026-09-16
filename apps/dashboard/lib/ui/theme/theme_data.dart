import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'computed.dart';
import 'radix_colors.dart' as radix;
import 'theme_scope.dart' show UiScope;
import 'tokens.dart';

/// Available accent colors matching Radix Themes names.
enum UiAccentColor {
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
enum UiGrayColor { gray, mauve, slate, sage, olive, sand }

/// Theme-level radius multipliers matching the Radix Themes presets.
enum UiRadius { none, small, medium, large, full }

/// Background treatment used by floating panels.
enum UiPanelBackground { solid, translucent }

/// Discrete theme scaling values supported by Radix Themes.
enum UiScaling {
  percent90(0.9),
  percent95(0.95),
  percent100(1.0),
  percent105(1.05),
  percent110(1.1);

  const UiScaling(this.factor);

  /// Numeric multiplier represented by this preset.
  final double factor;
}

/// Partial theme values applied by a [UiScope].
@immutable
class UiThemeConfig {
  const UiThemeConfig({
    this.accent,
    this.gray,
    this.brightness,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
  });

  final UiAccentColor? accent;
  final UiGrayColor? gray;
  final Brightness? brightness;
  final UiPanelBackground? panelBackground;
  final UiRadius? radius;
  final UiScaling? scaling;
  final bool? hasBackground;

  bool get isDark => brightness == .dark;

  UiThemeConfig copyWith({
    UiAccentColor? accent,
    UiGrayColor? gray,
    Brightness? brightness,
    UiPanelBackground? panelBackground,
    UiRadius? radius,
    UiScaling? scaling,
    bool? hasBackground,
  }) => UiThemeConfig(
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
      other is UiThemeConfig &&
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
      UiScope(
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

/// Fully resolved theme values inherited by a Ui subtree.
@immutable
class UiThemeData extends UiThemeConfig {
  const UiThemeData({
    required UiAccentColor super.accent,
    required UiGrayColor super.gray,
    required Brightness super.brightness,
    required UiPanelBackground super.panelBackground,
    required UiRadius super.radius,
    required UiScaling super.scaling,
    required bool super.hasBackground,
  });

  @override
  UiAccentColor get accent => super.accent!;
  @override
  UiGrayColor get gray => super.gray!;
  @override
  Brightness get brightness => super.brightness!;
  @override
  UiPanelBackground get panelBackground => super.panelBackground!;
  @override
  UiRadius get radius => super.radius!;
  @override
  UiScaling get scaling => super.scaling!;
  @override
  bool get hasBackground => super.hasBackground!;

  @override
  bool get isDark => brightness == .dark;

  @override
  UiThemeData copyWith({
    UiAccentColor? accent,
    UiGrayColor? gray,
    Brightness? brightness,
    UiPanelBackground? panelBackground,
    UiRadius? radius,
    UiScaling? scaling,
    bool? hasBackground,
  }) => UiThemeData(
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
      other is UiThemeData &&
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

/// Builds the token map for a Ui scope. Used by [UiScope].
Map<MixToken<Object?>, Object> buildUiScopeTokens(UiThemeData theme) {
  final tokens = resolveUiTokens(theme);
  final scaling = theme.scaling.factor;
  final shadows = buildUiShadows(isDark: theme.isDark, colors: tokens);

  final colorTokens = {
    // Role and functional tokens
    UiTokens.colorBackground: tokens.colorBackground,
    UiTokens.colorSurface: tokens.colorSurface,
    UiTokens.segmentedControlIndicatorBackground: theme.isDark
        ? tokens.gray.scale.alphaStep(3)
        : tokens.colorBackground,
    UiTokens.colorPanelSolid: tokens.colorPanelSolid,
    UiTokens.colorPanelTranslucent: tokens.colorPanelTranslucent,
    UiTokens.colorPanel: theme.panelBackground == .solid
        ? tokens.colorPanelSolid
        : tokens.colorPanelTranslucent,
    UiTokens.colorOverlay: tokens.colorOverlay,
    UiTokens.sliderHighContrastOverlay: theme.isDark
        ? const Color(0x00000000)
        : tokens.blackAlpha[8]!,
    UiTokens.error3: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(3),
    UiTokens.error7: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(7),
    UiTokens.error8: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(8),
    UiTokens.error9: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(9),
    UiTokens.error11: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(11),
    UiTokens.error12: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .step(12),
    UiTokens.errorA7: (theme.isDark ? radix.red.dark : radix.red.light).scale
        .alphaStep(7),
    ..._accentColorTokens(tokens),
    // Gray steps
    UiTokens.gray1: tokens.gray.scale.step(1),
    UiTokens.gray2: tokens.gray.scale.step(2),
    UiTokens.gray3: tokens.gray.scale.step(3),
    UiTokens.gray4: tokens.gray.scale.step(4),
    UiTokens.gray5: tokens.gray.scale.step(5),
    UiTokens.gray6: tokens.gray.scale.step(6),
    UiTokens.gray7: tokens.gray.scale.step(7),
    UiTokens.gray8: tokens.gray.scale.step(8),
    UiTokens.gray9: tokens.gray.scale.step(9),
    UiTokens.gray10: tokens.gray.scale.step(10),
    UiTokens.gray11: tokens.gray.scale.step(11),
    UiTokens.gray12: tokens.gray.scale.step(12),
    // Gray role tokens (from resolved colors)
    UiTokens.graySurface: tokens.gray.surface,
    UiTokens.grayIndicator: tokens.gray.indicator,
    UiTokens.grayTrack: tokens.gray.track,
    UiTokens.grayContrast: tokens.gray.contrast,
    // Gray alpha a1..a12
    UiTokens.grayA1: tokens.gray.scale.alphaStep(1),
    UiTokens.grayA2: tokens.gray.scale.alphaStep(2),
    UiTokens.grayA3: tokens.gray.scale.alphaStep(3),
    UiTokens.grayA4: tokens.gray.scale.alphaStep(4),
    UiTokens.grayA5: tokens.gray.scale.alphaStep(5),
    UiTokens.grayA6: tokens.gray.scale.alphaStep(6),
    UiTokens.grayA7: tokens.gray.scale.alphaStep(7),
    UiTokens.grayA8: tokens.gray.scale.alphaStep(8),
    UiTokens.grayA9: tokens.gray.scale.alphaStep(9),
    UiTokens.grayA10: tokens.gray.scale.alphaStep(10),
    UiTokens.grayA11: tokens.gray.scale.alphaStep(11),
    UiTokens.grayA12: tokens.gray.scale.alphaStep(12),
    // Neutral helpers derived from primitives
    UiTokens.blackA1: tokens.blackAlpha[1]!,
    UiTokens.blackA2: tokens.blackAlpha[2]!,
    UiTokens.blackA3: tokens.blackAlpha[3]!,
    UiTokens.blackA4: tokens.blackAlpha[4]!,
    UiTokens.blackA5: tokens.blackAlpha[5]!,
    UiTokens.blackA6: tokens.blackAlpha[6]!,
    UiTokens.blackA7: tokens.blackAlpha[7]!,
    UiTokens.blackA8: tokens.blackAlpha[8]!,
    UiTokens.blackA9: tokens.blackAlpha[9]!,
    UiTokens.blackA10: tokens.blackAlpha[10]!,
    UiTokens.blackA11: tokens.blackAlpha[11]!,
    UiTokens.blackA12: tokens.blackAlpha[12]!,
    UiTokens.whiteA1: tokens.whiteAlpha[1]!,
    UiTokens.whiteA2: tokens.whiteAlpha[2]!,
    UiTokens.whiteA3: tokens.whiteAlpha[3]!,
    UiTokens.whiteA4: tokens.whiteAlpha[4]!,
    UiTokens.whiteA5: tokens.whiteAlpha[5]!,
    UiTokens.whiteA6: tokens.whiteAlpha[6]!,
    UiTokens.whiteA7: tokens.whiteAlpha[7]!,
    UiTokens.whiteA8: tokens.whiteAlpha[8]!,
    UiTokens.whiteA9: tokens.whiteAlpha[9]!,
    UiTokens.whiteA10: tokens.whiteAlpha[10]!,
    UiTokens.whiteA11: tokens.whiteAlpha[11]!,
    UiTokens.whiteA12: tokens.whiteAlpha[12]!,
    UiTokens.shadowStroke: tokens.shadowStroke,
    UiTokens.grayStroke3: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(3),
      tokens.gray.scale.step(3),
      0.25,
    ),
    UiTokens.grayStroke4: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(4),
      tokens.gray.scale.step(4),
      0.25,
    ),
    UiTokens.grayStroke5: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(5),
      tokens.gray.scale.step(5),
      0.25,
    ),
    UiTokens.grayStroke6: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(6),
      tokens.gray.scale.step(6),
      0.25,
    ),
    UiTokens.grayStroke7: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(7),
      tokens.gray.scale.step(7),
      0.25,
    ),
    UiTokens.dataTableBorder: mixOklabPremultiplied(
      tokens.gray.scale.alphaStep(5),
      tokens.gray.scale.step(6),
      0.5,
    ),
  };
  final allTokens = <MixToken<Object?>, Object>{
    ...colorTokens,
    UiTokens.panelBlur: theme.panelBackground == UiPanelBackground.translucent
        ? 64.0
        : 0.0,
    UiTokens.space1: 4.0 * scaling,
    UiTokens.space2: 8.0 * scaling,
    UiTokens.space3: 12.0 * scaling,
    UiTokens.space4: 16.0 * scaling,
    UiTokens.space5: 24.0 * scaling,
    UiTokens.space6: 32.0 * scaling,
    UiTokens.space7: 40.0 * scaling,
    UiTokens.space8: 48.0 * scaling,
    UiTokens.space9: 64.0 * scaling,
    UiTokens.spinnerSize3: 20.0 * scaling,
    UiTokens.dataTableRowHeight1: 36.0 * scaling,
    UiTokens.dataTableRowHeight2: 44.0 * scaling,
    UiTokens.toggleGap1: 2.0 * scaling,
    UiTokens.toggleGap3: 6.0 * scaling,
    UiTokens.avatarSize6: 80.0 * scaling,
    UiTokens.avatarSize7: 96.0 * scaling,
    UiTokens.avatarSize8: 128.0 * scaling,
    UiTokens.avatarSize9: 160.0 * scaling,
    UiTokens.avatarIconSize1: 12.0 * scaling,
    UiTokens.avatarIconSize2: 16.0 * scaling,
    UiTokens.avatarIconSize3: 20.0 * scaling,
    UiTokens.avatarIconSize4: 24.0 * scaling,
    UiTokens.avatarIconSize5: 32.0 * scaling,
    UiTokens.avatarIconSize6: 40.0 * scaling,
    UiTokens.avatarIconSize7: 48.0 * scaling,
    UiTokens.avatarIconSize8: 64.0 * scaling,
    UiTokens.avatarIconSize9: 80.0 * scaling,
    UiTokens.badgePaddingX1: 6.0 * scaling,
    UiTokens.badgePaddingY1: 2.0 * scaling,
    UiTokens.badgePaddingX3: 10.0 * scaling,
    UiTokens.checkboxSize1: 14.0 * scaling,
    UiTokens.checkboxSize3: 20.0 * scaling,
    UiTokens.checkboxIndicatorSize1: 9.0 * scaling,
    UiTokens.checkboxIndicatorSize2: 10.0 * scaling,
    UiTokens.checkboxIndicatorSize3: 12.0 * scaling,
    UiTokens.checkboxGroupItemGap1: 6.0 * scaling,
    UiTokens.checkboxGroupItemGap2: 7.0 * scaling,
    UiTokens.checkboxGroupItemGap3: 8.0 * scaling,
    UiTokens.radioIndicatorSize1: 5.6 * scaling,
    UiTokens.radioIndicatorSize2: 6.4 * scaling,
    UiTokens.radioIndicatorSize3: 8.0 * scaling,
    UiTokens.checkboxRadius1: _scaledRadiusToken(
      theme.radius,
      scaling,
      3.0 * 0.875,
    ),
    UiTokens.checkboxRadius3: _scaledRadiusToken(
      theme.radius,
      scaling,
      3.0 * 1.25,
    ),
    UiTokens.switchHeight2: 20.0 * scaling,
    UiTokens.switchWidth1: 28.0 * scaling,
    UiTokens.switchWidth2: 35.0 * scaling,
    UiTokens.switchWidth3: 42.0 * scaling,
    UiTokens.switchThumbSize1: 16.0 * scaling - 2.0,
    UiTokens.switchThumbSize2: 20.0 * scaling - 2.0,
    UiTokens.switchThumbSize3: 24.0 * scaling - 2.0,
    UiTokens.progressHeight2: 6.0 * scaling,
    UiTokens.sliderTrackSize1: 6.0 * scaling,
    UiTokens.sliderTrackSize2: 8.0 * scaling,
    UiTokens.sliderTrackSize3: 10.0 * scaling,
    UiTokens.sliderThumbSize1: 13.0 * scaling,
    UiTokens.sliderThumbSize2: 16.0 * scaling,
    UiTokens.sliderThumbSize3: 19.0 * scaling,
    UiTokens.textFieldPadding1: 6.0 * scaling,
    UiTokens.textFieldPadding2: 8.0 * scaling,
    UiTokens.textFieldPadding3: 12.0 * scaling,
    UiTokens.textAreaMinHeight3: 80.0,
    UiTokens.dataListRowGap3: 20.0 * scaling,
    UiTokens.dataListLabelMinWidth: 120.0,
    UiTokens.tabInnerPaddingY1: 2.0 * scaling,
    UiTokens.tabActiveLetterSpacing1: -0.12 * scaling,
    UiTokens.tabActiveLetterSpacing2: -0.14 * scaling,
    UiTokens.selectSpace1Half: 6.0 * scaling,
    UiTokens.selectIndicatorWidth1: 20.0 * scaling,
    UiTokens.selectIndicatorSize1: 8.0 * scaling,
    UiTokens.selectIndicatorSize2: 10.0 * scaling,
    UiTokens.selectGhostMarginX12: -8.0 * scaling,
    UiTokens.selectGhostMarginY12: -4.0 * scaling,
    UiTokens.selectGhostMarginX3: -12.0 * scaling,
    UiTokens.selectGhostMarginY3: -6.0 * scaling,
    ..._radiusTokensFor(theme.radius, scaling),

    // Exact layered Radix shadow tokens, resolved for the active color scales.
    ...shadows,
    UiTokens.sliderClassicDisabledTrackShadows: _scaleShadowOpacity(
      shadows[UiTokens.shadow1Layers]! as List<RemixBoxShadow>,
      0.5,
    ),
    UiTokens.cardClassicOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .idle,
    ),
    UiTokens.cardClassicInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .idle,
    ),
    UiTokens.cardClassicHoverOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .hovered,
    ),
    UiTokens.cardClassicHoverInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .hovered,
    ),
    UiTokens.cardClassicActiveOuterShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .outer,
      state: .active,
    ),
    UiTokens.cardClassicActiveInnerShadows: _cardClassicShadows(
      tokens,
      isDark: theme.isDark,
      layer: .inner,
      state: .active,
    ),
    UiTokens.selectTriggerClassicShadows: _selectClassicShadows(
      tokens,
      isDark: theme.isDark,
    ),
    UiTokens.selectTriggerClassicHoverShadows: [
      _insetShadow(tokens.gray.scale.alphaStep(3), spread: 1),
      ..._selectClassicShadows(tokens, isDark: theme.isDark),
    ],
    UiTokens.baseButtonClassicDisabledShadows:
        _baseButtonClassicDisabledShadows(tokens, isDark: theme.isDark),
    UiTokens.baseButtonClassicShadows: _baseButtonClassicShadows(
      tokens,
      isDark: theme.isDark,
      highContrast: false,
    ),
    UiTokens.baseButtonClassicHighContrastShadows: _baseButtonClassicShadows(
      tokens,
      isDark: theme.isDark,
      highContrast: true,
    ),
    UiTokens.baseButtonClassicActiveShadows: _baseButtonClassicActiveShadows(
      tokens,
      highContrast: false,
    ),
    UiTokens.baseButtonClassicActiveHighContrastShadows:
        _baseButtonClassicActiveShadows(tokens, highContrast: true),
    UiTokens.baseButtonClassicAfterInset: theme.isDark ? 1.0 : 2.0,
    UiTokens.baseButtonGhostPaddingY3: 6.0 * scaling,
    UiTokens.baseButtonGhostMarginX12: -8.0 * scaling,
    UiTokens.baseButtonGhostMarginY12: -4.0 * scaling,
    UiTokens.baseButtonGhostMarginX3: -12.0 * scaling,
    UiTokens.baseButtonGhostMarginY3: -6.0 * scaling,
    UiTokens.baseButtonGhostMarginX4: -16.0 * scaling,
    UiTokens.baseButtonGhostMarginY4: -8.0 * scaling,
    UiTokens.iconButtonGhostPadding2: 6.0 * scaling,
    UiTokens.iconButtonGhostMargin1: -4.0 * scaling,
    UiTokens.iconButtonGhostMargin2: -6.0 * scaling,
    UiTokens.iconButtonGhostMargin3: -8.0 * scaling,
    UiTokens.iconButtonGhostMargin4: -12.0 * scaling,
    UiTokens.cardGhostMargin1: -12.0 * scaling,
    UiTokens.cardGhostMargin2: -16.0 * scaling,
    UiTokens.cardGhostMargin3: -24.0 * scaling,
    UiTokens.cardGhostMargin4: -32.0 * scaling,
    UiTokens.cardGhostMargin5: -48.0 * scaling,
    UiTokens.borderWidth1: 1.0,
    UiTokens.borderWidth2: 2.0,
    UiTokens.focusRingWidth: 2.0,
    UiTokens.focusRingOffset: 2.0,
    UiTokens.text1: TextStyle(
      fontSize: 12.0 * scaling,
      letterSpacing: 0.0025 * 12.0 * scaling,
      height: 16.0 / 12.0,
    ),
    UiTokens.text2: TextStyle(
      fontSize: 14.0 * scaling,
      letterSpacing: 0.0,
      height: 20.0 / 14.0,
    ),
    UiTokens.text3: TextStyle(
      fontSize: 16.0 * scaling,
      letterSpacing: 0.0,
      height: 24.0 / 16.0,
    ),
    UiTokens.accordionText2: TextStyle(
      fontSize: 15.0 * scaling,
      letterSpacing: 0.0,
      height: 20.0 / 15.0,
    ),
    UiTokens.text4: TextStyle(
      fontSize: 18.0 * scaling,
      letterSpacing: -0.0025 * 18.0 * scaling,
      height: 26.0 / 18.0,
    ),
    UiTokens.text5: TextStyle(
      fontSize: 20.0 * scaling,
      letterSpacing: -0.005 * 20.0 * scaling,
      height: 28.0 / 20.0,
    ),
    UiTokens.text6: TextStyle(
      fontSize: 24.0 * scaling,
      letterSpacing: -0.00625 * 24.0 * scaling,
      height: 30.0 / 24.0,
    ),
    UiTokens.text7: TextStyle(
      fontSize: 28.0 * scaling,
      letterSpacing: -0.0075 * 28.0 * scaling,
      height: 36.0 / 28.0,
    ),
    UiTokens.text8: TextStyle(
      fontSize: 35.0 * scaling,
      letterSpacing: -0.01 * 35.0 * scaling,
      height: 40.0 / 35.0,
    ),
    UiTokens.text9: TextStyle(
      fontSize: 60.0 * scaling,
      letterSpacing: -0.025 * 60.0 * scaling,
      height: 1.0,
    ),
    UiTokens.avatarFallback1One: _avatarFallbackText(
      fontSize: 14,
      letterSpacing: 0.0025 * 12,
      scaling: scaling,
    ),
    UiTokens.avatarFallback1Two: _avatarFallbackText(
      fontSize: 12,
      letterSpacing: 0.0025 * 12,
      scaling: scaling,
    ),
    UiTokens.avatarFallback2One: _avatarFallbackText(
      fontSize: 16,
      letterSpacing: 0,
      scaling: scaling,
    ),
    UiTokens.avatarFallback2Two: _avatarFallbackText(
      fontSize: 14,
      letterSpacing: 0,
      scaling: scaling,
    ),
    UiTokens.avatarFallback3One: _avatarFallbackText(
      fontSize: 18,
      letterSpacing: 0,
      scaling: scaling,
    ),
    UiTokens.avatarFallback3Two: _avatarFallbackText(
      fontSize: 16,
      letterSpacing: 0,
      scaling: scaling,
    ),
    UiTokens.avatarFallback4One: _avatarFallbackText(
      fontSize: 20,
      letterSpacing: -0.0025 * 18,
      scaling: scaling,
    ),
    UiTokens.avatarFallback4Two: _avatarFallbackText(
      fontSize: 18,
      letterSpacing: -0.0025 * 18,
      scaling: scaling,
    ),
    UiTokens.avatarFallback5: _avatarFallbackText(
      fontSize: 24,
      letterSpacing: -0.00625 * 24,
      scaling: scaling,
    ),
    UiTokens.avatarFallback6: _avatarFallbackText(
      fontSize: 28,
      letterSpacing: -0.0075 * 28,
      scaling: scaling,
    ),
    UiTokens.avatarFallback7: _avatarFallbackText(
      fontSize: 28,
      letterSpacing: -0.0075 * 28,
      scaling: scaling,
    ),
    UiTokens.avatarFallback8: _avatarFallbackText(
      fontSize: 35,
      letterSpacing: -0.01 * 35,
      scaling: scaling,
    ),
    UiTokens.avatarFallback9: _avatarFallbackText(
      fontSize: 60,
      letterSpacing: -0.025 * 60,
      scaling: scaling,
    ),

    // Font weights (token values)
    UiTokens.fontWeightLight: FontWeight.w300,
    UiTokens.fontWeightRegular: FontWeight.w400,
    UiTokens.fontWeightMedium: FontWeight.w500,
    // Match Radix Themes font weights (bold = 700)
    UiTokens.fontWeightBold: FontWeight.w700,

    // Durations (token values)
    UiTokens.transitionFast: const Duration(milliseconds: 100),
    UiTokens.transitionSlow: const Duration(milliseconds: 300),
    UiTokens.skeletonPulseDuration: const Duration(milliseconds: 1000),
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
  UiThemeColors colors, {
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
  UiThemeColors colors, {
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
  UiThemeColors colors, {
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
  UiThemeColors colors, {
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
  UiThemeColors colors, {
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

Map<RadiusToken, Radius> _radiusTokensFor(UiRadius radius, double scaling) {
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
    UiTokens.radius1: radius1,
    UiTokens.radius2: radius2,
    UiTokens.radius3: radius3,
    UiTokens.radius4: radius4,
    UiTokens.radius5: radius5,
    UiTokens.radius6: radius6,
    UiTokens.radiusFull: full,
    UiTokens.radiusThumb: thumb,
    UiTokens.radiusCircle: const Radius.circular(9999.0),
    UiTokens.radius1OrFull: larger(radius1, full),
    UiTokens.radius2OrFull: larger(radius2, full),
    UiTokens.radius3OrFull: larger(radius3, full),
    UiTokens.radius4OrFull: larger(radius4, full),
    UiTokens.radius5OrFull: larger(radius5, full),
    UiTokens.radius6OrFull: larger(radius6, full),
    UiTokens.radius1OrThumb: larger(radius1, thumb),
    UiTokens.radius2OrThumb: larger(radius2, thumb),
    UiTokens.progressRadius1: progressRadius(4.0 * scaling),
    UiTokens.progressRadius2: progressRadius(6.0 * scaling),
    UiTokens.progressRadius3: progressRadius(8.0 * scaling),
    UiTokens.sliderTrackRadius1: progressRadius(6.0 * scaling),
    UiTokens.sliderTrackRadius2: progressRadius(8.0 * scaling),
    UiTokens.sliderTrackRadius3: progressRadius(10.0 * scaling),
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

double _radiusFactor(UiRadius radius) => switch (radius) {
  .none => 0.0,
  .small => 0.75,
  .medium => 1.0,
  .large || .full => 1.5,
};

Radius _scaledRadiusToken(UiRadius radius, double scaling, double base) =>
    Radius.circular(base * scaling * _radiusFactor(radius));

Map<ColorToken, Color> _accentColorTokens(UiThemeColors tokens) {
  final scale = tokens.accent.scale;

  return {
    UiTokens.accentSurface: tokens.accent.surface,
    UiTokens.accentIndicator: tokens.accent.indicator,
    UiTokens.accentTrack: tokens.accent.track,
    UiTokens.accentContrast: tokens.accent.contrast,
    UiTokens.focus8: tokens.focus8,
    UiTokens.focusA5: tokens.focusA5,
    UiTokens.focusA8: tokens.focusA8,
    UiTokens.accent1: scale.step(1),
    UiTokens.accent2: scale.step(2),
    UiTokens.accent3: scale.step(3),
    UiTokens.accent4: scale.step(4),
    UiTokens.accent5: scale.step(5),
    UiTokens.accent6: scale.step(6),
    UiTokens.accent7: scale.step(7),
    UiTokens.accent8: scale.step(8),
    UiTokens.accent9: scale.step(9),
    UiTokens.accent10: scale.step(10),
    UiTokens.accent11: scale.step(11),
    UiTokens.accent12: scale.step(12),
    UiTokens.accentA1: scale.alphaStep(1),
    UiTokens.accentA2: scale.alphaStep(2),
    UiTokens.accentA3: scale.alphaStep(3),
    UiTokens.accentA4: scale.alphaStep(4),
    UiTokens.accentA5: scale.alphaStep(5),
    UiTokens.accentA6: scale.alphaStep(6),
    UiTokens.accentA7: scale.alphaStep(7),
    UiTokens.accentA8: scale.alphaStep(8),
    UiTokens.accentA9: scale.alphaStep(9),
    UiTokens.accentA10: scale.alphaStep(10),
    UiTokens.accentA11: scale.alphaStep(11),
    UiTokens.accentA12: scale.alphaStep(12),
  };
}
