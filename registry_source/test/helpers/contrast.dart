import 'package:flutter/painting.dart';

/// WCAG 2 contrast ratio of two colors using relative luminance.
double contrastRatio(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final lighter = firstLuminance > secondLuminance
      ? firstLuminance
      : secondLuminance;
  final darker = firstLuminance > secondLuminance
      ? secondLuminance
      : firstLuminance;

  return (lighter + 0.05) / (darker + 0.05);
}

/// Contrast of [foreground] after src-over compositing onto [fill] onto [panel].
///
/// Soft badges paint accentA11 (or accent12 when `highContrast: true`) over
/// accentA3 over colorPanelSolid -- a badge sitting on a card.
double compositedContrast({
  required Color foreground,
  required Color fill,
  required Color panel,
}) {
  final background = Color.alphaBlend(fill, panel);
  return contrastRatio(Color.alphaBlend(foreground, background), background);
}
