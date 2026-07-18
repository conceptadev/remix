// Fortal theme: tokens + MixScope builder in one place.

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

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

  /// High contrast foreground for solid accent backgrounds.
  static const accentContrast = ColorToken('fortal.accent.contrast');

  // ============================================================================
  // FOCUS AND INTERACTION STATES
  // ============================================================================

  /// Solid focus ring color (accent step 8).
  static const focus8 = ColorToken('fortal.focus.8');

  /// Translucent focus ring color with alpha transparency.
  static const focusA8 = ColorToken('fortal.focus.a8');

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
  static const blackA11 = ColorToken('fortal.black.a11');

  /// Mode-aware mixed shadow stroke.
  static const shadowStroke = ColorToken('fortal.shadow.stroke');

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

  /// Full radius (9999px) for circular shapes.
  ///
  /// Creates perfect circles and pills. Use for avatars,
  /// badges, and elements that should appear completely rounded. This stays
  /// 9999px for Fortal's circle/pill primitives; it intentionally differs from
  /// Radix Themes' theme-level `--radius-full` behavior.
  static const radiusFull = RadiusToken('fortal.radius.full');

  /// Radius used by control thumbs.
  static const radiusThumb = RadiusToken('fortal.radius.thumb');

  // ============================================================================
  // ELEVATION SHADOWS (6 LEVELS)
  // ============================================================================

  /// Shadow level 1 - Subtle elevation.
  ///
  /// Minimal shadow for slight elevation effects.
  /// Good for cards and buttons in their resting state.
  static const shadow1 = BoxShadowToken('fortal.shadow.1');

  /// Shadow level 2 - Low elevation.
  ///
  /// Light shadow for gentle elevation and hover states.
  /// Suitable for interactive elements and small modals.
  static const shadow2 = BoxShadowToken('fortal.shadow.2');

  /// Shadow level 3 - Medium elevation.
  ///
  /// Moderate shadow for clear visual separation.
  /// Good for dropdowns, tooltips, and floating elements.
  static const shadow3 = BoxShadowToken('fortal.shadow.3');

  /// Shadow level 4 - High elevation.
  ///
  /// Prominent shadow for important floating content.
  /// Suitable for modal dialogs and important overlays.
  static const shadow4 = BoxShadowToken('fortal.shadow.4');

  /// Shadow level 5 - Very high elevation.
  ///
  /// Strong shadow for primary modals and major overlays.
  /// Creates clear hierarchy and focus on important content.
  static const shadow5 = BoxShadowToken('fortal.shadow.5');

  /// Shadow level 6 - Maximum elevation.
  ///
  /// Maximum shadow depth for critical dialogs and notifications.
  /// Ensures content appears above all other interface elements.
  static const shadow6 = BoxShadowToken('fortal.shadow.6');

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
Map<MixToken, Object> _buildFortalScopeTokens(FortalThemeConfig theme) {
  final tokens = resolveFortalTokens(theme);

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
    FortalTokens.accentSurface: tokens.accent.surface,
    FortalTokens.accentIndicator: tokens.accent.indicator,
    FortalTokens.accentTrack: tokens.accent.track,
    FortalTokens.accentContrast: tokens.accent.contrast,
    FortalTokens.focus8: tokens.focus8,
    FortalTokens.focusA8: tokens.focusA8,
    // Accent steps (explicit for clarity)
    FortalTokens.accent1: tokens.accent.scale.step(1),
    FortalTokens.accent2: tokens.accent.scale.step(2),
    FortalTokens.accent3: tokens.accent.scale.step(3),
    FortalTokens.accent4: tokens.accent.scale.step(4),
    FortalTokens.accent5: tokens.accent.scale.step(5),
    FortalTokens.accent6: tokens.accent.scale.step(6),
    FortalTokens.accent7: tokens.accent.scale.step(7),
    FortalTokens.accent8: tokens.accent.scale.step(8),
    FortalTokens.accent9: tokens.accent.scale.step(9),
    FortalTokens.accent10: tokens.accent.scale.step(10),
    FortalTokens.accent11: tokens.accent.scale.step(11),
    FortalTokens.accent12: tokens.accent.scale.step(12),
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
    // Accent alpha a1..a12
    FortalTokens.accentA1: tokens.accent.scale.alphaStep(1),
    FortalTokens.accentA2: tokens.accent.scale.alphaStep(2),
    FortalTokens.accentA3: tokens.accent.scale.alphaStep(3),
    FortalTokens.accentA4: tokens.accent.scale.alphaStep(4),
    FortalTokens.accentA5: tokens.accent.scale.alphaStep(5),
    FortalTokens.accentA6: tokens.accent.scale.alphaStep(6),
    FortalTokens.accentA7: tokens.accent.scale.alphaStep(7),
    FortalTokens.accentA8: tokens.accent.scale.alphaStep(8),
    FortalTokens.accentA9: tokens.accent.scale.alphaStep(9),
    FortalTokens.accentA10: tokens.accent.scale.alphaStep(10),
    FortalTokens.accentA11: tokens.accent.scale.alphaStep(11),
    FortalTokens.accentA12: tokens.accent.scale.alphaStep(12),

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
    FortalTokens.blackA11: tokens.blackAlpha[11]!,
    FortalTokens.shadowStroke: tokens.shadowStroke,
  };

  // Build base tokens map
  final allTokens = <MixToken, Object>{
    ...colorTokens,
    // Defaults (may be overridden by JSON tokens below)
    FortalTokens.space1: 4.0 * theme.scaling,
    FortalTokens.space2: 8.0 * theme.scaling,
    FortalTokens.space3: 12.0 * theme.scaling,
    FortalTokens.space4: 16.0 * theme.scaling,
    FortalTokens.space5: 24.0 * theme.scaling,
    FortalTokens.space6: 32.0 * theme.scaling,
    FortalTokens.space7: 40.0 * theme.scaling,
    FortalTokens.space8: 48.0 * theme.scaling,
    FortalTokens.space9: 64.0 * theme.scaling,
    ..._radiusTokensFor(theme.radius, theme.scaling),

    // Layered shadows approximating Radix Themes CSS tokens. Colors are
    // resolved here (not token refs) so the shadow tokens can be consumed
    // directly by stylers.
    ...buildFortalShadows(isDark: theme.isDark, colors: tokens),
    FortalTokens.borderWidth1: 1.0,
    FortalTokens.borderWidth2: 2.0,
    FortalTokens.focusRingWidth: 2.0,
    FortalTokens.focusRingOffset: 2.0,
    FortalTokens.text1: TextStyle(
      fontSize: 12.0,
      letterSpacing: 0.0025 * 12.0,
      height: 16.0 / 12.0,
    ),
    FortalTokens.text2: TextStyle(
      fontSize: 14.0,
      letterSpacing: 0.0,
      height: 20.0 / 14.0,
    ),
    FortalTokens.text3: TextStyle(
      fontSize: 16.0,
      letterSpacing: 0.0,
      height: 24.0 / 16.0,
    ),
    FortalTokens.text4: TextStyle(
      fontSize: 18.0,
      letterSpacing: -0.0025 * 18.0,
      height: 26.0 / 18.0,
    ),
    FortalTokens.text5: TextStyle(
      fontSize: 20.0,
      letterSpacing: -0.005 * 20.0,
      height: 28.0 / 20.0,
    ),
    FortalTokens.text6: TextStyle(
      fontSize: 24.0,
      letterSpacing: -0.00625 * 24.0,
      height: 30.0 / 24.0,
    ),
    FortalTokens.text7: TextStyle(
      fontSize: 28.0,
      letterSpacing: -0.0075 * 28.0,
      height: 36.0 / 28.0,
    ),
    FortalTokens.text8: TextStyle(
      fontSize: 35.0,
      letterSpacing: -0.01 * 35.0,
      height: 40.0 / 35.0,
    ),
    FortalTokens.text9: TextStyle(
      fontSize: 60.0,
      letterSpacing: -0.025 * 60.0,
      height: 1.0,
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

Map<RadiusToken, Radius> _radiusTokensFor(FortalRadius radius, double scaling) {
  final factor = switch (radius) {
    .none => 0.0,
    .small => 0.75,
    .medium => 1.0,
    .large || .full => 1.5,
  };
  final thumb = switch (radius) {
    .none || .small => const Radius.circular(0.5),
    .medium || .large || .full => const Radius.circular(9999.0),
  };
  Radius scaled(double base) => Radius.circular(base * factor * scaling);

  return {
    FortalTokens.radius1: scaled(3.0),
    FortalTokens.radius2: scaled(4.0),
    FortalTokens.radius3: scaled(6.0),
    FortalTokens.radius4: scaled(8.0),
    FortalTokens.radius5: scaled(12.0),
    FortalTokens.radius6: scaled(16.0),
    // Fortal uses this token for true circles and pills, independent of the
    // selected theme radius. Per-component pillification is deferred.
    FortalTokens.radiusFull: const Radius.circular(9999.0),
    FortalTokens.radiusThumb: thumb,
  };
}

Map<ColorToken, Color> _buildAccentOverrideTokens(
  FortalAccentColor accent,
  FortalThemeConfig ambient,
) {
  final tokens = resolveFortalTokens(ambient.copyWith(accent: accent));
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
/// **Theme Configuration:**
/// - [accent]: The accent color scale (indigo, blue, red, etc.)
/// - [gray]: The neutral gray scale with different undertones
/// - [brightness]: Light or dark mode
/// - [radius]: The theme's corner-radius scale
/// - [scaling]: A multiplier for space and radius tokens
/// - [panelBackground]: Solid or translucent floating panels
///
/// **Color Theory:**
/// The Fortal color system builds on Radix color science for perceptual
/// uniformity and accessibility:
/// - Each color scale has 12 steps with semantic meaning
/// - Colors are designed to work together harmoniously
/// - Alpha variants provide translucency without losing saturation
/// - Dark mode uses different algorithms to maintain contrast ratios
///
/// Example:
/// ```dart
/// FortalScope(
///   accent: .blue,
///   gray: .slate,
///   brightness: .light,
///   child: MyApp(),
/// )
/// ```
///
/// The scope provides access to all design tokens through Mix styles:
/// ```dart
/// Style(
///   $box.color.ref(FortalTokens.accent9),     // Solid accent
///   $text.color.ref(FortalTokens.gray12),      // High contrast text
///   $box.padding.ref(FortalTokens.space4),     // 16px padding
///   $box.shadow.ref(FortalTokens.shadow2),     // Subtle elevation
/// )
/// ```
class FortalScope extends StatelessWidget {
  const FortalScope({
    super.key,
    this.accent = .indigo,
    this.gray = .slate,
    this.brightness = .light,
    this.radius = .medium,
    this.scaling = 1.0,
    this.panelBackground = .solid,
    this.orderOfModifiers,
    required this.child,
  }) : assert(
         scaling > 0 && scaling < double.infinity,
         'scaling must be positive and finite.',
       );

  final FortalAccentColor accent;
  final FortalGrayColor gray;
  final Brightness brightness;

  /// Corner-radius multiplier for this theme scope.
  final FortalRadius radius;

  /// Multiplies space and radius tokens only; text and component geometry do
  /// not scale in this initial API.
  final double scaling;

  /// Background treatment consumed by floating Fortal panels.
  final FortalPanelBackground panelBackground;
  final List<Type>? orderOfModifiers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final config = FortalThemeConfig(
      accent: accent,
      gray: gray,
      brightness: brightness,
      radius: radius,
      scaling: scaling,
      panelBackground: panelBackground,
    );

    return FortalTheme(
      config: config,
      child: MixScope(
        tokens: _buildFortalScopeTokens(config),
        orderOfModifiers: orderOfModifiers,
        child: child,
      ),
    );
  }
}

// OKLab mixing implemented in computed.dart; no helper here.

// (No internal helpers needed; explicit step mapping kept for clarity.)

/// Available accent colors matching Radix Themes names.
enum FortalAccentColor {
  amber,
  blue,
  bronze,
  brown,
  crimson,
  cyan,
  gold,
  grass,
  green,
  indigo,
  iris,
  jade,
  lime,
  mint,
  orange,
  pink,
  plum,
  purple,
  red,
  ruby,
  sky,
  teal,
  tomato,
  violet,
  yellow,
  // neutrals also allowed as accent for convenience
  gray,
  mauve,
  slate,
  sage,
  olive,
  sand,
}

/// Available neutral gray families matching Radix Themes names.
enum FortalGrayColor { gray, mauve, slate, sage, olive, sand }

/// Theme-level radius multipliers matching the Radix Themes presets.
enum FortalRadius { none, small, medium, large, full }

/// Background treatment used by floating panels.
enum FortalPanelBackground { solid, translucent }

/// Immutable configuration object for Fortal theme settings.
///
/// Provides a convenient way to store and pass around theme configuration,
/// including methods to create variants and apply the theme to widgets.
/// This is useful when you need to switch themes dynamically or pass
/// theme configuration through your app.
///
/// Example:
/// ```dart
/// const theme = FortalThemeConfig(
///   accent: .green,
///   gray: .sage,
///   brightness: .dark,
/// );
///
/// // Create variants
/// final lightTheme = theme.copyWith(brightness: .light);
///
/// // Apply to widgets
/// theme.createScope(child: MyApp())
/// ```
@immutable
class FortalThemeConfig {
  final FortalAccentColor accent;
  final FortalGrayColor gray;
  final Brightness brightness;

  /// Corner-radius multiplier for generated radius tokens.
  final FortalRadius radius;

  /// Multiplies space and radius tokens, not typography or hard-coded geometry.
  final double scaling;

  /// Background treatment selected for floating panels.
  final FortalPanelBackground panelBackground;

  const FortalThemeConfig({
    this.accent = .indigo,
    this.gray = .slate,
    this.brightness = .light,
    this.radius = .medium,
    this.scaling = 1.0,
    this.panelBackground = .solid,
  }) : assert(
         scaling > 0 && scaling < double.infinity,
         'scaling must be positive and finite.',
       );

  bool get isDark => brightness == .dark;

  FortalThemeConfig copyWith({
    FortalAccentColor? accent,
    FortalGrayColor? gray,
    Brightness? brightness,
    FortalRadius? radius,
    double? scaling,
    FortalPanelBackground? panelBackground,
  }) => .new(
    accent: accent ?? this.accent,
    gray: gray ?? this.gray,
    brightness: brightness ?? this.brightness,
    radius: radius ?? this.radius,
    scaling: scaling ?? this.scaling,
    panelBackground: panelBackground ?? this.panelBackground,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FortalThemeConfig &&
          accent == other.accent &&
          gray == other.gray &&
          brightness == other.brightness &&
          radius == other.radius &&
          scaling == other.scaling &&
          panelBackground == other.panelBackground;

  @override
  int get hashCode =>
      Object.hash(accent, gray, brightness, radius, scaling, panelBackground);

  Widget createScope({List<Type>? orderOfModifiers, required Widget child}) =>
      FortalScope(
        accent: accent,
        gray: gray,
        brightness: brightness,
        radius: radius,
        scaling: scaling,
        panelBackground: panelBackground,
        orderOfModifiers: orderOfModifiers,
        child: child,
      );
}

/// Makes the active [FortalThemeConfig] available to descendants.
class FortalTheme extends InheritedWidget {
  const FortalTheme({super.key, required this.config, required super.child});

  final FortalThemeConfig config;

  /// Returns the closest Fortal theme configuration.
  static FortalThemeConfig of(BuildContext context) {
    final config = maybeOf(context);
    if (config != null) return config;
    throw FlutterError.fromParts([
      ErrorSummary('No FortalTheme found.'),
      ErrorDescription(
        '${context.widget.runtimeType} tried to read the Fortal theme, but no FortalScope was found above it.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Returns the closest Fortal theme configuration, if one is available.
  static FortalThemeConfig? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FortalTheme>()?.config;

  @override
  bool updateShouldNotify(FortalTheme oldWidget) => config != oldWidget.config;
}

/// Applies a local accent and/or radius token delta to a Fortal subtree.
///
/// Per-instance overrides copy the Fortal token map at build time. For a
/// uniform list, wrap the list once instead of each individual item.
class FortalOverride extends StatefulWidget {
  const FortalOverride({
    super.key,
    this.color,
    this.radius,
    required this.child,
  });

  final FortalAccentColor? color;
  final FortalRadius? radius;
  final Widget child;

  @override
  State<FortalOverride> createState() => _FortalOverrideState();
}

class _FortalOverrideState extends State<FortalOverride> {
  // The override scope appears only when a delta is active. A global key lets
  // Flutter reparent the existing subtree across that boundary without losing
  // local control state, while retaining the no-override token-copy fast path.
  final GlobalKey _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _childKey, child: widget.child);
    if (widget.color == null && widget.radius == null) return child;

    final ambient = FortalTheme.maybeOf(context) ?? const FortalThemeConfig();
    return MixScope.inherit(
      colors: widget.color == null
          ? null
          : _buildAccentOverrideTokens(widget.color!, ambient),
      radii: widget.radius == null
          ? null
          : _radiusTokensFor(widget.radius!, ambient.scaling),
      child: child,
    );
  }
}
