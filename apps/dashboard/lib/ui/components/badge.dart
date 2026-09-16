import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'badge.g.dart';

/// Radix Themes Badge size presets.
enum UiBadgeSize { size1, size2, size3 }

/// Radix Themes Badge variants.
enum UiBadgeVariant { solid, soft, surface, outline }

/// Ui-themed Badge with the Radix size, variant, and override contract.
@MixWidget(target: RemixBadge.new)
BadgeStyler uiBadgeStyle({
  UiBadgeVariant variant = .soft,
  UiBadgeSize size = .size1,
  bool highContrast = false,
  BadgeStyler style = const BadgeStyler.create(),
}) {
  final base = _uiBadgeBaseStyler(size);
  return (switch (variant) {
    .solid =>
      base
          .color(highContrast ? UiTokens.accent12() : UiTokens.accent9())
          .labelColor(
            highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
          ),
    .soft =>
      base
          .color(UiTokens.accentA3())
          .labelColor(
            // Step 11 is Radix low-contrast text, not WCAG AA 4.5:1 on
            // accentA3 over colorPanelSolid. highContrast promotes accent12.
            highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
          ),
    .surface =>
      base
          .color(UiTokens.accentSurface())
          .containerEffects(
            RemixBoxEffectsMix.behindContent(
              uiInsetSurface(strokes: [UiTokens.accentA6()]),
            ),
          )
          .labelColor(
            highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
          ),
    .outline =>
      base
          .containerEffects(
            RemixBoxEffectsMix.behindContent(
              uiInsetSurface(
                strokes: [
                  highContrast ? UiTokens.accentA7() : UiTokens.accentA8(),
                  if (highContrast) UiTokens.grayA11(),
                ],
              ),
            ),
          )
          .labelColor(
            highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
          ),
  }).merge(style);
}

BadgeStyler _uiBadgeBaseStyler(UiBadgeSize size) {
  final radius = _uiBadgeRadius(size);
  return BadgeStyler(
    container: .padding(_uiBadgePadding(size)),
    label: .style(
      _uiBadgeText(size).mix(),
    ).fontWeight(UiTokens.fontWeightMedium()),
  ).borderRadius(.all(radius));
}

TextStyleToken _uiBadgeText(UiBadgeSize size) => switch (size) {
  .size1 || .size2 => UiTokens.text1,
  .size3 => UiTokens.text2,
};

EdgeInsetsGeometryMix _uiBadgePadding(UiBadgeSize size) => switch (size) {
  .size1 => EdgeInsetsGeometryMix.symmetric(
    horizontal: UiTokens.badgePaddingX1(),
    vertical: UiTokens.badgePaddingY1(),
  ),
  .size2 => EdgeInsetsGeometryMix.symmetric(
    horizontal: UiTokens.space2(),
    vertical: UiTokens.space1(),
  ),
  .size3 => EdgeInsetsGeometryMix.symmetric(
    horizontal: UiTokens.badgePaddingX3(),
    vertical: UiTokens.space1(),
  ),
};

Radius _uiBadgeRadius(UiBadgeSize size) => switch (size) {
  .size1 => UiTokens.radius1OrFull(),
  .size2 || .size3 => UiTokens.radius2OrFull(),
};
