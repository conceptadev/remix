// Fortal theme: tokens + MixScope builder in one place.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show internal;
import 'package:mix/mix.dart';

import '../radix/colors/colors.dart' as radix;
import '../rendering/remix_surface.dart';
import 'computed.dart';

// OKLab mixing lives in computed.dart; no direct dependency here.

/// Design tokens for the Fortal UI system (powered by Radix Colors).
///
/// Provides color scales (12-step accent/gray), spacing (9-step), radius (6-step),
/// shadows (6-level), typography (9-size), and functional colors.
///
/// Example:
/// ```dart
/// Style(
///   $box.color.ref(FortalTokens.accent9),
///   $text.style.ref(FortalTokens.text3),
///   $box.padding.ref(FortalTokens.space4),
/// )
/// ```
///
/// Must be used within [FortalScope] to resolve actual values.
class FortalTokens {
  // ============================================================================
  // BACKGROUND AND SURFACE COLORS
  // ============================================================================

  /// Page background color selected for the active brightness.
  static const colorBackground = ColorToken('fortal.color.background');

  /// Neutral surface color for input fields and controls.
  static const colorSurface = ColorToken('fortal.color.surface');

  /// Solid panel background selected for the active brightness.
  static const colorPanelSolid = ColorToken('fortal.color.panel.solid');

  /// Translucent panel background with alpha transparency.
  static const colorPanelTranslucent = ColorToken(
    'fortal.color.panel.translucent',
  );

  /// Panel background selected by [FortalPanelBackground].
  static const colorPanel = ColorToken('fortal.color.panel');

  /// Backdrop blur applied to translucent floating panels.
  static const panelBlur = DoubleToken('fortal.panel.blur');

  /// Dark overlay for modals and dialogs.
  static const colorOverlay = ColorToken('fortal.color.overlay');

  // ============================================================================
  // FUNCTIONAL ACCENT COLORS
  // ============================================================================

  /// Subtle accent surface for soft button variants and chips.
  static const accentSurface = ColorToken('fortal.accent.surface');

  /// Active indicator color for progress bars and sliders.
  static const accentIndicator = ColorToken('fortal.accent.indicator');

  /// Track/rail background color for sliders and progress bars.
  static const accentTrack = ColorToken('fortal.accent.track');

  /// Mode-aware overlay used by high-contrast slider ranges.
  static const sliderHighContrastOverlay = ColorToken(
    'fortal.slider.high-contrast-overlay',
  );

  /// High contrast foreground for solid accent backgrounds.
  static const accentContrast = ColorToken('fortal.accent.contrast');

  // ============================================================================
  // FOCUS AND INTERACTION STATES
  // ============================================================================

  /// Solid focus ring color (accent step 8).
  static const focus8 = ColorToken('fortal.focus.8');

  /// Translucent focus ring color with alpha transparency.
  static const focusA8 = ColorToken('fortal.focus.a8');

  /// Mode-aware red roles used by documented validation extensions.
  static const error3 = ColorToken('fortal.error.3');
  static const error7 = ColorToken('fortal.error.7');
  static const error8 = ColorToken('fortal.error.8');
  static const error9 = ColorToken('fortal.error.9');
  static const error11 = ColorToken('fortal.error.11');
  static const error12 = ColorToken('fortal.error.12');
  static const errorA7 = ColorToken('fortal.error.a7');

  // ============================================================================
  // ACCENT COLOR SCALE (12 STEPS)
  // ============================================================================
  //
  // Fortal uses a 12-step color scale (inherited from Radix Themes) that provides semantic meaning:
  //
  // Steps 1-2:  App backgrounds (subtle → more visible)
  // Steps 3-5:  Component backgrounds (rest → hover → active)
  // Steps 6-8:  Borders (subtle → component → hover)
  // Steps 9-10: Solid backgrounds (default → hover)
  // Steps 11-12: Text (low contrast → high contrast)
  //

  /// Accent step 1 - App background, most subtle.
  static const accent1 = ColorToken('fortal.accent.1');

  /// Accent step 2 - Subtle background.
  static const accent2 = ColorToken('fortal.accent.2');

  /// Accent step 3 - Component background at rest.
  static const accent3 = ColorToken('fortal.accent.3');

  /// Accent step 4 - Component background on hover.
  static const accent4 = ColorToken('fortal.accent.4');

  /// Accent step 5 - Component background when active/pressed.
  static const accent5 = ColorToken('fortal.accent.5');

  /// Accent step 6 - Subtle borders and separators.
  static const accent6 = ColorToken('fortal.accent.6');

  /// Accent step 7 - Component borders at rest.
  static const accent7 = ColorToken('fortal.accent.7');

  /// Accent step 8 - Component borders on hover and focus.
  static const accent8 = ColorToken('fortal.accent.8');

  /// Accent step 9 - Primary solid background.
  static const accent9 = ColorToken('fortal.accent.9');

  /// Accent step 10 - Solid background on hover.
  static const accent10 = ColorToken('fortal.accent.10');

  /// Accent step 11 - Low contrast text.
  static const accent11 = ColorToken('fortal.accent.11');

  /// Accent step 12 - High contrast text.
  static const accent12 = ColorToken('fortal.accent.12');

  // ============================================================================
  // GRAY COLOR SCALE (12 STEPS)
  // ============================================================================
  //
  // The gray scale follows the same 12-step semantic structure as accent colors,
  // but provides neutral colors for text, borders, and backgrounds.
  // The specific gray variant (slate, mauve, sage, etc.) is chosen in the theme.
  //

  /// Gray step 1 - Page background.
  static const gray1 = ColorToken('fortal.gray.1');

  /// Gray step 2 - Panel and card backgrounds.
  static const gray2 = ColorToken('fortal.gray.2');

  /// Gray step 3 - Input backgrounds and pressed states.
  static const gray3 = ColorToken('fortal.gray.3');

  /// Gray step 4 - Input backgrounds on hover.
  static const gray4 = ColorToken('fortal.gray.4');

  /// Gray step 5 - Active states and disabled backgrounds.
  static const gray5 = ColorToken('fortal.gray.5');

  /// Gray step 6 - Subtle borders and dividers.
  static const gray6 = ColorToken('fortal.gray.6');

  /// Gray step 7 - Standard borders and outlines.
  ///
  /// Primary border color for form inputs, cards,
  /// and component boundaries.
  static const gray7 = ColorToken('fortal.gray.7');

  /// Gray step 8 - Borders on hover and focus.
  ///
  /// Interactive border states and stronger separators
  /// that need more visual weight.
  static const gray8 = ColorToken('fortal.gray.8');

  /// Gray step 9 - Solid neutral backgrounds.
  ///
  /// For neutral buttons, badges, and other elements
  /// that need a solid background without accent color.
  static const gray9 = ColorToken('fortal.gray.9');

  /// Gray step 10 - Solid neutral backgrounds on hover.
  ///
  /// Hover state for neutral solid backgrounds,
  /// providing interactive feedback.
  static const gray10 = ColorToken('fortal.gray.10');

  /// Gray step 11 - Low contrast text and secondary content.
  ///
  /// For secondary text, placeholders, and content that should
  /// be readable but not prominent.
  static const gray11 = ColorToken('fortal.gray.11');

  /// Gray step 12 - High contrast text and primary content.
  ///
  /// Primary text color for body content, headings, and any text
  /// that needs maximum readability and prominence.
  static const gray12 = ColorToken('fortal.gray.12');

  // ============================================================================
  // GRAY ROLE TOKENS (parity with generated JSON roles)
  // ============================================================================
  /// Neutral surface baseline for the selected gray scale (matches JSON surface)
  static const graySurface = ColorToken('fortal.gray.surface');

  /// Neutral indicator color (typically gray step 9)
  static const grayIndicator = ColorToken('fortal.gray.indicator');

  /// Neutral track color (typically gray step 9)
  static const grayTrack = ColorToken('fortal.gray.track');

  /// Contrast color for content over neutral solid backgrounds (white)
  static const grayContrast = ColorToken('fortal.gray.contrast');

  // ============================================================================
  // ALPHA VARIANTS (FULL 12-STEP FOR ACCENT AND GRAY)
  // ============================================================================

  // Accent alpha steps a1..a12
  static const accentA1 = ColorToken('fortal.accent.a1');
  static const accentA2 = ColorToken('fortal.accent.a2');
  static const accentA3 = ColorToken('fortal.accent.a3');
  static const accentA4 = ColorToken('fortal.accent.a4');
  static const accentA5 = ColorToken('fortal.accent.a5');
  static const accentA6 = ColorToken('fortal.accent.a6');
  static const accentA7 = ColorToken('fortal.accent.a7');
  static const accentA8 = ColorToken('fortal.accent.a8');
  static const accentA9 = ColorToken('fortal.accent.a9');
  static const accentA10 = ColorToken('fortal.accent.a10');
  static const accentA11 = ColorToken('fortal.accent.a11');
  static const accentA12 = ColorToken('fortal.accent.a12');

  // Gray alpha steps a1..a12
  static const grayA1 = ColorToken('fortal.gray.a1');
  static const grayA2 = ColorToken('fortal.gray.a2');
  static const grayA3 = ColorToken('fortal.gray.a3');
  static const grayA4 = ColorToken('fortal.gray.a4');
  static const grayA5 = ColorToken('fortal.gray.a5');
  static const grayA6 = ColorToken('fortal.gray.a6');
  static const grayA7 = ColorToken('fortal.gray.a7');
  static const grayA8 = ColorToken('fortal.gray.a8');
  static const grayA9 = ColorToken('fortal.gray.a9');
  static const grayA10 = ColorToken('fortal.gray.a10');
  static const grayA11 = ColorToken('fortal.gray.a11');
  static const grayA12 = ColorToken('fortal.gray.a12');

  // ============================================================================
  // NEUTRALS FOR SHADOWS (HELPER TOKENS)
  // ============================================================================
  /// Gray alpha steps are declared above (grayA1..grayA12).

  /// Black alpha steps used in layered shadows.
  static const blackA1 = ColorToken('fortal.black.a1');
  static const blackA2 = ColorToken('fortal.black.a2');
  static const blackA3 = ColorToken('fortal.black.a3');
  static const blackA4 = ColorToken('fortal.black.a4');
  static const blackA5 = ColorToken('fortal.black.a5');
  static const blackA6 = ColorToken('fortal.black.a6');
  static const blackA7 = ColorToken('fortal.black.a7');
  static const blackA8 = ColorToken('fortal.black.a8');
  static const blackA9 = ColorToken('fortal.black.a9');
  static const blackA10 = ColorToken('fortal.black.a10');
  static const blackA11 = ColorToken('fortal.black.a11');
  static const blackA12 = ColorToken('fortal.black.a12');

  /// White alpha steps used by layered classic-control recipes.
  static const whiteA1 = ColorToken('fortal.white.a1');
  static const whiteA2 = ColorToken('fortal.white.a2');
  static const whiteA3 = ColorToken('fortal.white.a3');
  static const whiteA4 = ColorToken('fortal.white.a4');
  static const whiteA5 = ColorToken('fortal.white.a5');
  static const whiteA6 = ColorToken('fortal.white.a6');
  static const whiteA7 = ColorToken('fortal.white.a7');
  static const whiteA8 = ColorToken('fortal.white.a8');
  static const whiteA9 = ColorToken('fortal.white.a9');
  static const whiteA10 = ColorToken('fortal.white.a10');
  static const whiteA11 = ColorToken('fortal.white.a11');
  static const whiteA12 = ColorToken('fortal.white.a12');

  /// Mode-aware mixed shadow stroke.
  static const shadowStroke = ColorToken('fortal.shadow.stroke');

  /// Premultiplied OKLab mixes used by Radix neutral one-pixel strokes.
  static const grayStroke3 = ColorToken('fortal.gray.stroke.3');
  static const grayStroke4 = ColorToken('fortal.gray.stroke.4');
  static const grayStroke5 = ColorToken('fortal.gray.stroke.5');
  static const grayStroke6 = ColorToken('fortal.gray.stroke.6');
  static const grayStroke7 = ColorToken('fortal.gray.stroke.7');

  // ============================================================================
  // SPACING SCALE (9 STEPS)
  // ============================================================================
  //
  // A consistent spacing scale based on 4px increments.
  //

  /// Space step 1 - 4px.
  ///
  /// Smallest spacing for tight layouts, borders,
  /// and fine-grained adjustments.
  static const space1 = SpaceToken('fortal.space.1');

  /// Space step 2 - 8px.
  ///
  /// Small spacing for component padding and margins.
  /// Good for button padding and form element spacing.
  static const space2 = SpaceToken('fortal.space.2');

  /// Space step 3 - 12px.
  ///
  /// Medium-small spacing for comfortable padding
  /// and moderate element separation.
  static const space3 = SpaceToken('fortal.space.3');

  /// Space step 4 - 16px.
  ///
  /// Standard spacing for most layouts. Good default
  /// for card padding and section margins.
  static const space4 = SpaceToken('fortal.space.4');

  /// Space step 5 - 24px.
  ///
  /// Medium spacing for generous padding and
  /// comfortable separation between sections.
  static const space5 = SpaceToken('fortal.space.5');

  /// Space step 6 - 32px.
  ///
  /// Large spacing for significant visual separation
  /// and generous component padding.
  static const space6 = SpaceToken('fortal.space.6');

  /// Space step 7 - 40px.
  ///
  /// Extra large spacing for major layout sections
  /// and prominent visual separation.
  static const space7 = SpaceToken('fortal.space.7');

  /// Space step 8 - 48px.
  ///
  /// Very large spacing for significant page sections
  /// and major layout boundaries.
  static const space8 = SpaceToken('fortal.space.8');

  /// Space step 9 - 64px.
  ///
  /// Maximum spacing for major page sections
  /// and substantial layout separation.
  static const space9 = SpaceToken('fortal.space.9');

  /// Spinner size 3 - 20px at 100% scaling.
  ///
  /// Radix defines this as 1.25 times space 4, so it needs its own resolved
  /// token rather than arithmetic on an unresolved token reference.
  static const spinnerSize3 = DoubleToken('fortal.spinner.size.3');

  /// Compact gap shared by size-1 toggle extensions (2px at 100% scaling).
  static const toggleGap1 = DoubleToken('fortal.toggle.gap.1');

  /// Comfortable gap shared by size-3 toggle extensions (6px at 100%).
  static const toggleGap3 = DoubleToken('fortal.toggle.gap.3');

  /// Avatar sizes expressed as scaled pixels rather than spacing steps.
  static const avatarSize6 = DoubleToken('fortal.avatar.size.6');
  static const avatarSize7 = DoubleToken('fortal.avatar.size.7');
  static const avatarSize8 = DoubleToken('fortal.avatar.size.8');
  static const avatarSize9 = DoubleToken('fortal.avatar.size.9');

  /// Badge measurements that are fractional spacing expressions upstream.
  static const badgePaddingX1 = DoubleToken('fortal.badge.padding-x.1');
  static const badgePaddingY1 = DoubleToken('fortal.badge.padding-y.1');
  static const badgePaddingX3 = DoubleToken('fortal.badge.padding-x.3');

  /// Checkbox dimensions expressed as scaled pixels by Radix Themes.
  static const checkboxSize1 = DoubleToken('fortal.checkbox.size.1');
  static const checkboxSize3 = DoubleToken('fortal.checkbox.size.3');
  static const checkboxIndicatorSize1 = DoubleToken(
    'fortal.checkbox.indicator-size.1',
  );
  static const checkboxIndicatorSize2 = DoubleToken(
    'fortal.checkbox.indicator-size.2',
  );
  static const checkboxIndicatorSize3 = DoubleToken(
    'fortal.checkbox.indicator-size.3',
  );

  /// Radio indicators are 40% of their control size in Radix Themes.
  ///
  /// These values need dedicated tokens because arithmetic on an unresolved
  /// token reference would destroy its identity before Mix can resolve it.
  static const radioIndicatorSize1 = DoubleToken(
    'fortal.radio.indicator-size.1',
  );
  static const radioIndicatorSize2 = DoubleToken(
    'fortal.radio.indicator-size.2',
  );
  static const radioIndicatorSize3 = DoubleToken(
    'fortal.radio.indicator-size.3',
  );

  /// Checkbox radii derived from fractional radius-step expressions.
  static const checkboxRadius1 = RadiusToken('fortal.checkbox.radius.1');
  static const checkboxRadius3 = RadiusToken('fortal.checkbox.radius.3');

  /// Switch geometry that cannot be derived from unresolved token references.
  static const switchHeight2 = DoubleToken('fortal.switch.height.2');
  static const switchWidth1 = DoubleToken('fortal.switch.width.1');
  static const switchWidth2 = DoubleToken('fortal.switch.width.2');
  static const switchWidth3 = DoubleToken('fortal.switch.width.3');
  static const switchThumbSize1 = DoubleToken('fortal.switch.thumb-size.1');
  static const switchThumbSize2 = DoubleToken('fortal.switch.thumb-size.2');
  static const switchThumbSize3 = DoubleToken('fortal.switch.thumb-size.3');

  /// Progress geometry derived from scaled fractional upstream expressions.
  static const progressHeight2 = DoubleToken('fortal.progress.height.2');
  static const progressRadius1 = RadiusToken('fortal.progress.radius.1');
  static const progressRadius2 = RadiusToken('fortal.progress.radius.2');
  static const progressRadius3 = RadiusToken('fortal.progress.radius.3');

  /// Slider geometry expressed as scaled Radix component dimensions.
  static const sliderTrackSize1 = DoubleToken('fortal.slider.track-size.1');
  static const sliderTrackSize2 = DoubleToken('fortal.slider.track-size.2');
  static const sliderTrackSize3 = DoubleToken('fortal.slider.track-size.3');
  static const sliderThumbSize1 = DoubleToken('fortal.slider.thumb-size.1');
  static const sliderThumbSize2 = DoubleToken('fortal.slider.thumb-size.2');
  static const sliderThumbSize3 = DoubleToken('fortal.slider.thumb-size.3');
  static const sliderTrackRadius1 = RadiusToken('fortal.slider.track-radius.1');
  static const sliderTrackRadius2 = RadiusToken('fortal.slider.track-radius.2');
  static const sliderTrackRadius3 = RadiusToken('fortal.slider.track-radius.3');

  /// TextField content insets after its fixed one-pixel border.
  static const textFieldPadding1 = DoubleToken('fortal.text-field.padding.1');
  static const textFieldPadding2 = DoubleToken('fortal.text-field.padding.2');
  static const textFieldPadding3 = DoubleToken('fortal.text-field.padding.3');

  /// Exact uppercase fallback typography for each Avatar size.
  static const avatarFallback1One = TextStyleToken(
    'fortal.avatar.fallback.1.one',
  );
  static const avatarFallback1Two = TextStyleToken(
    'fortal.avatar.fallback.1.two',
  );
  static const avatarFallback2One = TextStyleToken(
    'fortal.avatar.fallback.2.one',
  );
  static const avatarFallback2Two = TextStyleToken(
    'fortal.avatar.fallback.2.two',
  );
  static const avatarFallback3One = TextStyleToken(
    'fortal.avatar.fallback.3.one',
  );
  static const avatarFallback3Two = TextStyleToken(
    'fortal.avatar.fallback.3.two',
  );
  static const avatarFallback4One = TextStyleToken(
    'fortal.avatar.fallback.4.one',
  );
  static const avatarFallback4Two = TextStyleToken(
    'fortal.avatar.fallback.4.two',
  );
  static const avatarFallback5 = TextStyleToken('fortal.avatar.fallback.5');
  static const avatarFallback6 = TextStyleToken('fortal.avatar.fallback.6');
  static const avatarFallback7 = TextStyleToken('fortal.avatar.fallback.7');
  static const avatarFallback8 = TextStyleToken('fortal.avatar.fallback.8');
  static const avatarFallback9 = TextStyleToken('fortal.avatar.fallback.9');

  /// Tabs size 1 inner vertical padding - 2px at 100% scaling.
  static const tabInnerPaddingY1 = DoubleToken('fortal.tabs.inner-padding-y.1');

  /// Tabs size 1 active tracking - -0.12px at 100% scaling.
  static const tabActiveLetterSpacing1 = DoubleToken(
    'fortal.tabs.active-letter-spacing.1',
  );

  /// Tabs size 2 active tracking - -0.14px at 100% scaling.
  static const tabActiveLetterSpacing2 = DoubleToken(
    'fortal.tabs.active-letter-spacing.2',
  );

  /// Select's 1.5 × space-1 measurement (6px at 100% scaling).
  static const selectSpace1Half = DoubleToken('fortal.select.space.1-half');

  /// Select size-1 indicator column width (20px at 100% scaling).
  static const selectIndicatorWidth1 = DoubleToken(
    'fortal.select.indicator-width.1',
  );

  /// Select size-1 check size (8px at 100% scaling).
  static const selectIndicatorSize1 = DoubleToken(
    'fortal.select.indicator-size.1',
  );

  /// Select size-2/3 check size (10px at 100% scaling).
  static const selectIndicatorSize2 = DoubleToken(
    'fortal.select.indicator-size.2',
  );

  /// Negative margins that cancel Select ghost-trigger padding.
  static const selectGhostMarginX12 = DoubleToken(
    'fortal.select.ghost-margin-x.1-2',
  );
  static const selectGhostMarginY12 = DoubleToken(
    'fortal.select.ghost-margin-y.1-2',
  );
  static const selectGhostMarginX3 = DoubleToken(
    'fortal.select.ghost-margin-x.3',
  );
  static const selectGhostMarginY3 = DoubleToken(
    'fortal.select.ghost-margin-y.3',
  );

  // ============================================================================
  // BORDER RADIUS SCALE (6 STEPS + FULL)
  // ============================================================================

  /// Radius step 1 - 3px.
  ///
  /// Subtle rounding for small elements like buttons
  /// and form inputs. Provides gentle softening of corners.
  static const radius1 = RadiusToken('fortal.radius.1');

  /// Radius step 2 - 4px.
  ///
  /// Small radius for compact components and minor rounding.
  /// Good for small badges and tight layouts.
  static const radius2 = RadiusToken('fortal.radius.2');

  /// Radius step 3 - 6px.
  ///
  /// Medium radius for standard components like buttons
  /// and cards. Balances modern look with usability.
  static const radius3 = RadiusToken('fortal.radius.3');

  /// Radius step 4 - 8px.
  ///
  /// Large radius for prominent components and generous rounding.
  /// Good for larger buttons and feature cards.
  static const radius4 = RadiusToken('fortal.radius.4');

  /// Radius step 5 - 12px.
  ///
  /// Extra large radius for major components and modern aesthetics.
  /// Suitable for large cards and prominent interface elements.
  static const radius5 = RadiusToken('fortal.radius.5');

  /// Radius step 6 - 16px.
  ///
  /// Very large radius for distinctive styling and major components.
  /// Creates a soft, friendly appearance for large interface elements.
  static const radius6 = RadiusToken('fortal.radius.6');

  /// Theme-level full radius, enabled only by [FortalRadius.full].
  static const radiusFull = RadiusToken('fortal.radius.full');

  /// Radius used by control thumbs.
  static const radiusThumb = RadiusToken('fortal.radius.thumb');

  /// Fixed circle radius for shapes that stay circular across theme presets.
  static const radiusCircle = RadiusToken('fortal.radius.circle');

  /// Radius step 1 promoted to a pill when the theme radius is full.
  static const radius1OrFull = RadiusToken('fortal.radius.1-or-full');

  /// Radius step 2 promoted to a pill when the theme radius is full.
  static const radius2OrFull = RadiusToken('fortal.radius.2-or-full');

  /// Radius step 3 promoted to a pill when the theme radius is full.
  static const radius3OrFull = RadiusToken('fortal.radius.3-or-full');

  /// Radius step 4 promoted to a pill when the theme radius is full.
  static const radius4OrFull = RadiusToken('fortal.radius.4-or-full');

  /// Radius step 5 promoted to a pill when the theme radius is full.
  static const radius5OrFull = RadiusToken('fortal.radius.5-or-full');

  /// Radius step 6 promoted to a pill when the theme radius is full.
  static const radius6OrFull = RadiusToken('fortal.radius.6-or-full');

  /// Radius step 1 promoted to the control-thumb radius when larger.
  static const radius1OrThumb = RadiusToken('fortal.radius.1-or-thumb');

  /// Radius step 2 promoted to the control-thumb radius when larger.
  static const radius2OrThumb = RadiusToken('fortal.radius.2-or-thumb');

  // ============================================================================
  // ELEVATION SHADOWS (6 LEVELS)
  // ============================================================================

  /// Shadow level 1 - Subtle elevation.
  ///
  /// Minimal shadow for slight elevation effects.
  /// Good for cards and buttons in their resting state.
  static const shadow1 = RemixPaintShadowListToken('fortal.shadow.1');

  /// Half-opacity shadow-1 layers used by a disabled classic slider track.
  static const sliderClassicDisabledTrackShadows = RemixPaintShadowListToken(
    'fortal.slider.classic.disabled-track-shadows',
  );

  /// Shadow level 2 - Low elevation.
  ///
  /// Light shadow for gentle elevation and hover states.
  /// Suitable for interactive elements and small modals.
  static const shadow2 = RemixPaintShadowListToken('fortal.shadow.2');

  /// Shadow level 3 - Medium elevation.
  ///
  /// Moderate shadow for clear visual separation.
  /// Good for dropdowns, tooltips, and floating elements.
  static const shadow3 = RemixPaintShadowListToken('fortal.shadow.3');

  /// Shadow level 4 - High elevation.
  ///
  /// Prominent shadow for important floating content.
  /// Suitable for modal dialogs and important overlays.
  static const shadow4 = RemixPaintShadowListToken('fortal.shadow.4');

  /// Shadow level 5 - Very high elevation.
  ///
  /// Strong shadow for primary modals and major overlays.
  /// Creates clear hierarchy and focus on important content.
  static const shadow5 = RemixPaintShadowListToken('fortal.shadow.5');

  /// Shadow level 6 - Maximum elevation.
  ///
  /// Maximum shadow depth for critical dialogs and notifications.
  /// Ensures content appears above all other interface elements.
  static const shadow6 = RemixPaintShadowListToken('fortal.shadow.6');

  /// Card classic outer and inset-pseudo-element shadow lists.
  static const cardClassicOuterShadows = RemixPaintShadowListToken(
    'fortal.card.classic.outer-shadows',
  );
  static const cardClassicInnerShadows = RemixPaintShadowListToken(
    'fortal.card.classic.inner-shadows',
  );
  static const cardClassicHoverOuterShadows = RemixPaintShadowListToken(
    'fortal.card.classic.hover.outer-shadows',
  );
  static const cardClassicHoverInnerShadows = RemixPaintShadowListToken(
    'fortal.card.classic.hover.inner-shadows',
  );
  static const cardClassicActiveOuterShadows = RemixPaintShadowListToken(
    'fortal.card.classic.active.outer-shadows',
  );
  static const cardClassicActiveInnerShadows = RemixPaintShadowListToken(
    'fortal.card.classic.active.inner-shadows',
  );

  /// Mode-aware inset layers for a classic Select trigger.
  static const selectTriggerClassicShadows = RemixPaintShadowListToken(
    'fortal.select.trigger.classic.shadows',
  );

  /// Mode-aware open/hover layers for a classic Select trigger.
  static const selectTriggerClassicHoverShadows = RemixPaintShadowListToken(
    'fortal.select.trigger.classic.hover-shadows',
  );

  /// Mode-aware disabled layers shared by classic button-shaped controls.
  static const baseButtonClassicDisabledShadows = RemixPaintShadowListToken(
    'fortal.base-button.classic.disabled.shadows',
  );

  /// Mode-aware classic Button/IconButton layers.
  static const baseButtonClassicShadows = RemixPaintShadowListToken(
    'fortal.base-button.classic.shadows',
  );
  static const baseButtonClassicHighContrastShadows = RemixPaintShadowListToken(
    'fortal.base-button.classic.high-contrast.shadows',
  );
  static const baseButtonClassicActiveShadows = RemixPaintShadowListToken(
    'fortal.base-button.classic.active.shadows',
  );
  static const baseButtonClassicActiveHighContrastShadows =
      RemixPaintShadowListToken(
        'fortal.base-button.classic.active.high-contrast.shadows',
      );
  static const baseButtonClassicAfterInset = DoubleToken(
    'fortal.base-button.classic.after-inset',
  );
  static const baseButtonGhostPaddingY3 = DoubleToken(
    'fortal.base-button.ghost.padding-y.3',
  );
  static const baseButtonGhostMarginX12 = DoubleToken(
    'fortal.base-button.ghost.margin-x.1-2',
  );
  static const baseButtonGhostMarginY12 = DoubleToken(
    'fortal.base-button.ghost.margin-y.1-2',
  );
  static const baseButtonGhostMarginX3 = DoubleToken(
    'fortal.base-button.ghost.margin-x.3',
  );
  static const baseButtonGhostMarginY3 = DoubleToken(
    'fortal.base-button.ghost.margin-y.3',
  );
  static const baseButtonGhostMarginX4 = DoubleToken(
    'fortal.base-button.ghost.margin-x.4',
  );
  static const baseButtonGhostMarginY4 = DoubleToken(
    'fortal.base-button.ghost.margin-y.4',
  );
  static const iconButtonGhostPadding2 = DoubleToken(
    'fortal.icon-button.ghost.padding.2',
  );
  static const iconButtonGhostMargin1 = DoubleToken(
    'fortal.icon-button.ghost.margin.1',
  );
  static const iconButtonGhostMargin2 = DoubleToken(
    'fortal.icon-button.ghost.margin.2',
  );
  static const iconButtonGhostMargin3 = DoubleToken(
    'fortal.icon-button.ghost.margin.3',
  );
  static const iconButtonGhostMargin4 = DoubleToken(
    'fortal.icon-button.ghost.margin.4',
  );
  static const cardGhostMargin1 = DoubleToken('fortal.card.ghost.margin.1');
  static const cardGhostMargin2 = DoubleToken('fortal.card.ghost.margin.2');
  static const cardGhostMargin3 = DoubleToken('fortal.card.ghost.margin.3');
  static const cardGhostMargin4 = DoubleToken('fortal.card.ghost.margin.4');
  static const cardGhostMargin5 = DoubleToken('fortal.card.ghost.margin.5');

  // ============================================================================
  // BORDER AND STROKE WIDTHS
  // ============================================================================

  /// Standard border width (1px).
  ///
  /// Default border thickness for most components like inputs,
  /// cards, and dividers. Provides clear boundaries without visual weight.
  static const borderWidth1 = SpaceToken('fortal.border.width.1');

  /// Thick border width (2px).
  ///
  /// Heavier border for emphasis, selected states, and components
  /// that need stronger visual definition.
  static const borderWidth2 = SpaceToken('fortal.border.width.2');

  /// Focus ring border width (2px).
  ///
  /// Standard width for focus outlines to ensure accessibility
  /// compliance and clear keyboard navigation feedback.
  static const focusRingWidth = SpaceToken('fortal.focus.ring.width');

  /// Focus ring offset distance from element edge.
  ///
  /// Space between the component border and focus ring,
  /// ensuring the focus indicator doesn't interfere with the element.
  static const focusRingOffset = SpaceToken('fortal.focus.ring.offset');

  // ============================================================================
  // TYPOGRAPHY SCALE (9 LEVELS)
  // ============================================================================
  //
  // Text sizes with carefully tuned line heights and letter spacing
  // for optimal readability across all scales.
  //

  /// Text size 1 - 12px (Small labels and metadata).
  ///
  /// Smallest readable text for labels, captions, and secondary metadata.
  /// Includes tight letter spacing for improved legibility at small sizes.
  static const text1 = TextStyleToken('fortal.text.1');

  /// Text size 2 - 14px (Standard UI text).
  ///
  /// Default size for most interface text including buttons,
  /// form labels, and secondary content.
  static const text2 = TextStyleToken('fortal.text.2');

  /// Text size 3 - 16px (Body text and primary content).
  ///
  /// Ideal for body text and primary content. Provides excellent
  /// readability for extended reading on all device types.
  static const text3 = TextStyleToken('fortal.text.3');

  /// Accordion size-2 text (15px with a 20px line box at 100% scaling).
  ///
  /// Accordion is a Fortal extension, so this intermediate size is kept
  /// separate from the upstream Radix typography scale.
  static const accordionText2 = TextStyleToken('fortal.accordion.text.2');

  /// Text size 4 - 18px (Prominent body text).
  ///
  /// For important content that needs more visual weight than
  /// standard body text but isn't quite a heading.
  static const text4 = TextStyleToken('fortal.text.4');

  /// Text size 5 - 20px (Small headings).
  ///
  /// For minor headings, subheadings, and content that needs
  /// to stand out from body text.
  static const text5 = TextStyleToken('fortal.text.5');

  /// Text size 6 - 24px (Medium headings).
  ///
  /// Standard heading size for section titles and important content.
  /// Good balance between prominence and page economy.
  static const text6 = TextStyleToken('fortal.text.6');

  /// Text size 7 - 28px (Large headings).
  ///
  /// For major page headings and important announcements.
  /// Creates strong visual hierarchy and draws attention.
  static const text7 = TextStyleToken('fortal.text.7');

  /// Text size 8 - 35px (Extra large headings).
  ///
  /// For hero text, page titles, and major content sections.
  /// Strong negative letter spacing improves appearance at large sizes.
  static const text8 = TextStyleToken('fortal.text.8');

  /// Text size 9 - 60px (Display text).
  ///
  /// Maximum text size for hero sections and display typography.
  /// Includes significant negative letter spacing and tight line height.
  static const text9 = TextStyleToken('fortal.text.9');

  // ============================================================================
  // FONT WEIGHT TOKENS
  // ============================================================================

  /// Light font weight (300).
  ///
  /// Optional lighter weight occasionally used in display typography or
  /// subdued text. Provided for parity with Radix token set.
  static const fontWeightLight = FontWeightToken('fortal.font.weight.light');

  /// Regular font weight (400).
  ///
  /// Standard weight for body text and most interface elements.
  /// Provides good readability without visual strain.
  static const fontWeightRegular = FontWeightToken(
    'fortal.font.weight.regular',
  );

  /// Medium font weight (500).
  ///
  /// Slightly heavier than regular for UI elements that need
  /// more visual weight, like active states and button text.
  static const fontWeightMedium = FontWeightToken('fortal.font.weight.medium');

  /// Bold font weight (700).
  ///
  /// For headings and content that needs strong emphasis.
  /// Provides clear hierarchy without being too heavy.
  static const fontWeightBold = FontWeightToken('fortal.font.weight.bold');

  // ============================================================================
  // ANIMATION DURATIONS
  // ============================================================================

  /// Fast animation duration (100ms).
  ///
  /// For quick micro-interactions like hover states and button presses.
  /// Provides immediate feedback without feeling sluggish.
  static const transitionFast = DurationToken('fortal.transition.fast');

  /// Slow animation duration (300ms).
  ///
  /// For more substantial transitions like modal appearances,
  /// page transitions, and complex state changes.
  static const transitionSlow = DurationToken('fortal.transition.slow');
}

/// Builds the token map for a Fortal scope. Used by [FortalScope].
Map<MixToken, Object> _buildFortalScopeTokens(FortalThemeData theme) {
  final tokens = resolveFortalTokens(theme);
  final scaling = theme.scaling.factor;
  final shadows = buildFortalShadows(isDark: theme.isDark, colors: tokens);

  final colorTokens = {
    // Role and functional tokens
    FortalTokens.colorBackground: tokens.colorBackground,
    FortalTokens.colorSurface: tokens.colorSurface,
    FortalTokens.colorPanelSolid: tokens.colorPanelSolid,
    FortalTokens.colorPanelTranslucent: tokens.colorPanelTranslucent,
    FortalTokens.colorPanel: theme.panelBackground == .solid
        ? tokens.colorPanelSolid
        : tokens.colorPanelTranslucent,
    FortalTokens.colorOverlay: tokens.colorOverlay,
    FortalTokens.sliderHighContrastOverlay: theme.isDark
        ? Colors.transparent
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
    FortalTokens.toggleGap1: 2.0 * scaling,
    FortalTokens.toggleGap3: 6.0 * scaling,
    FortalTokens.avatarSize6: 80.0 * scaling,
    FortalTokens.avatarSize7: 96.0 * scaling,
    FortalTokens.avatarSize8: 128.0 * scaling,
    FortalTokens.avatarSize9: 160.0 * scaling,
    FortalTokens.badgePaddingX1: 6.0 * scaling,
    FortalTokens.badgePaddingY1: 2.0 * scaling,
    FortalTokens.badgePaddingX3: 10.0 * scaling,
    FortalTokens.checkboxSize1: 14.0 * scaling,
    FortalTokens.checkboxSize3: 20.0 * scaling,
    FortalTokens.checkboxIndicatorSize1: 9.0 * scaling,
    FortalTokens.checkboxIndicatorSize2: 10.0 * scaling,
    FortalTokens.checkboxIndicatorSize3: 12.0 * scaling,
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
    FortalTokens.textFieldPadding1: 6.0 * scaling - 1.0,
    FortalTokens.textFieldPadding2: 8.0 * scaling - 1.0,
    FortalTokens.textFieldPadding3: 12.0 * scaling - 1.0,
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
      shadows[FortalTokens.shadow1]!,
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

List<RemixPaintShadow> _cardClassicShadows(
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

  RemixPaintShadow shadow(
    Color color, {
    Offset offset = Offset.zero,
    double blur = 0,
    required double spread,
  }) => RemixPaintShadow(
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
    shadow(Colors.transparent, spread: inner ? 1 : 0),
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

RemixPaintShadow _insetShadow(
  Color color, {
  Offset offset = Offset.zero,
  double blur = 0,
  double spread = 0,
  double shapeInset = 0,
}) => RemixPaintShadow(
  kind: RemixPaintShadowKind.inset,
  color: color,
  offset: offset,
  blurRadius: blur,
  spreadRadius: spread,
  shapeInset: shapeInset,
);

List<RemixPaintShadow> _selectClassicShadows(
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

List<RemixPaintShadow> _baseButtonClassicDisabledShadows(
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

List<RemixPaintShadow> _baseButtonClassicShadows(
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

List<RemixPaintShadow> _baseButtonClassicActiveShadows(
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

List<RemixPaintShadow> _scaleShadowOpacity(
  List<RemixPaintShadow> shadows,
  double factor,
) => [
  for (final shadow in shadows)
    RemixPaintShadow(
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

Map<MixToken, Object> _buildAccentOverrideTokens(
  FortalAccentColor accent,
  FortalThemeData ambient,
) {
  final tokens = resolveFortalTokens(ambient.copyWith(accentColor: accent));
  return {
    ..._accentColorTokens(tokens),
    FortalTokens.baseButtonClassicShadows: _baseButtonClassicShadows(
      tokens,
      isDark: ambient.isDark,
      highContrast: false,
    ),
    FortalTokens.baseButtonClassicHighContrastShadows:
        _baseButtonClassicShadows(
          tokens,
          isDark: ambient.isDark,
          highContrast: true,
        ),
    FortalTokens.baseButtonClassicActiveShadows:
        _baseButtonClassicActiveShadows(tokens, highContrast: false),
    FortalTokens.baseButtonClassicActiveHighContrastShadows:
        _baseButtonClassicActiveShadows(tokens, highContrast: true),
  };
}

Map<ColorToken, Color> _accentColorTokens(FortalThemeColors tokens) {
  final scale = tokens.accent.scale;

  return {
    FortalTokens.accentSurface: tokens.accent.surface,
    FortalTokens.accentIndicator: tokens.accent.indicator,
    FortalTokens.accentTrack: tokens.accent.track,
    FortalTokens.accentContrast: tokens.accent.contrast,
    FortalTokens.focus8: tokens.focus8,
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

/// Widget that provides Fortal design tokens to its subtree via [MixScope].
///
/// Use [FortalScope] at the root of your app (or around any subtree that uses
/// Fortal styles) so that [FortalTokens] resolve to actual values.
///
/// Root scopes should wrap the app widget so inherited platform appearance is
/// available without depending on Material:
///
/// ```dart
/// FortalScope(
///   child: WidgetsApp(...),
/// )
/// ```
class FortalScope extends StatefulWidget {
  const FortalScope({
    super.key,
    this.appearance,
    this.accentColor,
    this.grayColor,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
    this.orderOfModifiers,
    required this.child,
  });

  final FortalAppearance? appearance;
  final FortalAccentColor? accentColor;
  final FortalGrayColor? grayColor;
  final FortalPanelBackground? panelBackground;
  final FortalRadius? radius;
  final FortalScaling? scaling;
  final bool? hasBackground;
  final List<Type>? orderOfModifiers;
  final Widget child;

  @override
  State<FortalScope> createState() => _FortalScopeState();
}

class _FortalScopeState extends State<FortalScope> with WidgetsBindingObserver {
  late Brightness _platformBrightness;

  @override
  void initState() {
    super.initState();
    _platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == _platformBrightness) return;
    setState(() => _platformBrightness = brightness);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = FortalThemeConfig(
      appearance: widget.appearance,
      accentColor: widget.accentColor,
      grayColor: widget.grayColor,
      panelBackground: widget.panelBackground,
      radius: widget.radius,
      scaling: widget.scaling,
      hasBackground: widget.hasBackground,
    );
    final data = _resolveFortalTheme(
      config,
      parent: FortalTheme.maybeOf(context),
      platformBrightness: _platformBrightness,
    );
    final tokens = _buildFortalScopeTokens(data);
    Widget result = MixScope(
      tokens: tokens,
      orderOfModifiers: widget.orderOfModifiers,
      child: widget.child,
    );
    if (data.hasBackground) {
      result = ColoredBox(
        color: tokens[FortalTokens.colorBackground]! as Color,
        child: result,
      );
    }

    return FortalTheme(data: data, child: result);
  }
}

/// Available accent colors matching Radix Themes names.
enum FortalAccentColor {
  gray,
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

/// Appearance behavior for a Fortal theme scope.
enum FortalAppearance { inherit, light, dark }

/// Available neutral gray families matching Radix Themes names.
enum FortalGrayColor { auto, gray, mauve, slate, sage, olive, sand }

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
    this.appearance,
    this.accentColor,
    this.grayColor,
    this.panelBackground,
    this.radius,
    this.scaling,
    this.hasBackground,
  });

  final FortalAppearance? appearance;
  final FortalAccentColor? accentColor;
  final FortalGrayColor? grayColor;
  final FortalPanelBackground? panelBackground;
  final FortalRadius? radius;
  final FortalScaling? scaling;
  final bool? hasBackground;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FortalThemeConfig &&
          appearance == other.appearance &&
          accentColor == other.accentColor &&
          grayColor == other.grayColor &&
          panelBackground == other.panelBackground &&
          radius == other.radius &&
          scaling == other.scaling &&
          hasBackground == other.hasBackground;

  @override
  int get hashCode => Object.hash(
    appearance,
    accentColor,
    grayColor,
    panelBackground,
    radius,
    scaling,
    hasBackground,
  );

  Widget createScope({List<Type>? orderOfModifiers, required Widget child}) =>
      FortalScope(
        appearance: appearance,
        accentColor: accentColor,
        grayColor: grayColor,
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
class FortalThemeData {
  const FortalThemeData({
    required this.appearance,
    required this.accentColor,
    required this.grayColor,
    required this.panelBackground,
    required this.radius,
    required this.scaling,
    required this.hasBackground,
  }) : assert(appearance != FortalAppearance.inherit),
       assert(grayColor != FortalGrayColor.auto);

  final FortalAppearance appearance;
  final FortalAccentColor accentColor;
  final FortalGrayColor grayColor;
  final FortalPanelBackground panelBackground;
  final FortalRadius radius;
  final FortalScaling scaling;
  final bool hasBackground;

  Brightness get brightness =>
      appearance == .dark ? Brightness.dark : Brightness.light;

  bool get isDark => appearance == .dark;

  FortalThemeData copyWith({
    FortalAppearance? appearance,
    FortalAccentColor? accentColor,
    FortalGrayColor? grayColor,
    FortalPanelBackground? panelBackground,
    FortalRadius? radius,
    FortalScaling? scaling,
    bool? hasBackground,
  }) => FortalThemeData(
    appearance: appearance ?? this.appearance,
    accentColor: accentColor ?? this.accentColor,
    grayColor: grayColor ?? this.grayColor,
    panelBackground: panelBackground ?? this.panelBackground,
    radius: radius ?? this.radius,
    scaling: scaling ?? this.scaling,
    hasBackground: hasBackground ?? this.hasBackground,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FortalThemeData &&
          appearance == other.appearance &&
          accentColor == other.accentColor &&
          grayColor == other.grayColor &&
          panelBackground == other.panelBackground &&
          radius == other.radius &&
          scaling == other.scaling &&
          hasBackground == other.hasBackground;

  @override
  int get hashCode => Object.hash(
    appearance,
    accentColor,
    grayColor,
    panelBackground,
    radius,
    scaling,
    hasBackground,
  );
}

FortalThemeData _resolveFortalTheme(
  FortalThemeConfig config, {
  FortalThemeData? parent,
  required Brightness platformBrightness,
}) {
  final appearance = switch (config.appearance) {
    .light => FortalAppearance.light,
    .dark => FortalAppearance.dark,
    null || .inherit =>
      parent?.appearance ??
          (platformBrightness == .dark
              ? FortalAppearance.dark
              : FortalAppearance.light),
  };
  final accentColor =
      config.accentColor ?? parent?.accentColor ?? FortalAccentColor.indigo;
  final grayColor = switch (config.grayColor) {
    null => parent?.grayColor ?? _matchingGrayColor(accentColor),
    .auto => _matchingGrayColor(accentColor),
    final gray => gray,
  };
  final hasExplicitAppearance =
      config.appearance == .light || config.appearance == .dark;

  return FortalThemeData(
    appearance: appearance,
    accentColor: accentColor,
    grayColor: grayColor,
    panelBackground:
        config.panelBackground ??
        parent?.panelBackground ??
        FortalPanelBackground.translucent,
    radius: config.radius ?? parent?.radius ?? FortalRadius.medium,
    scaling: config.scaling ?? parent?.scaling ?? FortalScaling.percent100,
    hasBackground:
        config.hasBackground ?? (parent == null || hasExplicitAppearance),
  );
}

FortalGrayColor _matchingGrayColor(FortalAccentColor accent) =>
    switch (accent) {
      .tomato ||
      .red ||
      .ruby ||
      .crimson ||
      .pink ||
      .plum ||
      .purple ||
      .violet => .mauve,
      .iris || .indigo || .blue || .sky || .cyan => .slate,
      .teal || .jade || .mint || .green => .sage,
      .grass || .lime => .olive,
      .yellow || .amber || .orange || .brown || .gold || .bronze => .sand,
      .gray => .gray,
    };

/// Makes the active [FortalThemeData] available to descendants.
class FortalTheme extends InheritedWidget {
  const FortalTheme({super.key, required this.data, required super.child});

  final FortalThemeData data;

  /// Returns the closest resolved Fortal theme.
  static FortalThemeData of(BuildContext context) {
    final data = maybeOf(context);
    if (data != null) return data;
    throw FlutterError.fromParts([
      ErrorSummary('No FortalTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the Fortal theme, but no FortalScope was found above it.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Returns the closest resolved Fortal theme, if one is available.
  static FortalThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FortalTheme>()?.data;

  @override
  bool updateShouldNotify(FortalTheme oldWidget) => data != oldWidget.data;
}

/// Internal component-only accent and radius token delta.
///
/// Public subtree theming uses [FortalScope]. This type remains visible only to
/// Remix component libraries and is hidden from the package entrypoint.
@internal
class FortalComponentOverride extends StatefulWidget {
  const FortalComponentOverride({
    super.key,
    this.color,
    this.radius,
    required this.child,
  });

  final FortalAccentColor? color;
  final FortalRadius? radius;
  final Widget child;

  @override
  State<FortalComponentOverride> createState() =>
      _FortalComponentOverrideState();
}

class _FortalComponentOverrideState extends State<FortalComponentOverride> {
  // The override scope appears only when a delta is active. A global key lets
  // Flutter reparent the existing subtree across that boundary without losing
  // local control state, while retaining the no-override token-copy fast path.
  final GlobalKey _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _childKey, child: widget.child);
    if (widget.color == null && widget.radius == null) return child;

    final ambient =
        FortalTheme.maybeOf(context) ??
        _resolveFortalTheme(
          const FortalThemeConfig(),
          platformBrightness:
              WidgetsBinding.instance.platformDispatcher.platformBrightness,
        );
    return MixScope.inherit(
      tokens: widget.color == null
          ? null
          : _buildAccentOverrideTokens(widget.color!, ambient),
      radii: widget.radius == null
          ? null
          : _radiusTokensFor(widget.radius!, ambient.scaling.factor),
      child: child,
    );
  }
}
