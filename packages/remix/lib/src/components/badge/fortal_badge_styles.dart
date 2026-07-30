part of 'badge.dart';

/// Radix Themes Badge size presets.
enum FortalBadgeSize { size1, size2, size3 }

/// Radix Themes Badge variants.
enum FortalBadgeVariant { solid, soft, surface, outline }

/// Fortal-themed Badge with the Radix size, variant, and override contract.
@MixWidget(target: RemixBadge.new)
RemixBadgeStyler fortalBadgeStyle({
  FortalBadgeVariant variant = .soft,
  FortalBadgeSize size = .size1,
  bool highContrast = false,
}) {
  final base = _fortalBadgeBaseStyler(size);
  return switch (variant) {
    .solid =>
      base
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .foregroundColor(
            highContrast
                ? FortalTokens.accent1()
                : FortalTokens.accentContrast(),
          ),
    .soft =>
      base
          .color(FortalTokens.accentA3())
          .foregroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
          ),
    .surface =>
      base
          .color(FortalTokens.accentSurface())
          .containerEffects(
            RemixBoxEffectsMix(
              behindContent: fortalInsetSurface(
                strokes: [FortalTokens.accentA6()],
              ),
            ),
          )
          .foregroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
          ),
    .outline =>
      base
          .containerEffects(
            RemixBoxEffectsMix(
              behindContent: fortalInsetSurface(
                strokes: [
                  highContrast
                      ? FortalTokens.accentA7()
                      : FortalTokens.accentA8(),
                  if (highContrast) FortalTokens.grayA11(),
                ],
              ),
            ),
          )
          .foregroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
          ),
  };
}

RemixBadgeStyler _fortalBadgeBaseStyler(FortalBadgeSize size) {
  final radius = _fortalBadgeRadius(size);
  return RemixBadgeStyler(
    container: .padding(_fortalBadgePadding(size)),
    label: .style(
      _fortalBadgeText(size).mix(),
    ).fontWeight(FortalTokens.fontWeightMedium()),
  ).borderRadiusAll(radius);
}

TextStyleToken _fortalBadgeText(FortalBadgeSize size) => switch (size) {
  .size1 || .size2 => FortalTokens.text1,
  .size3 => FortalTokens.text2,
};

EdgeInsetsGeometryMix _fortalBadgePadding(FortalBadgeSize size) =>
    switch (size) {
      .size1 => EdgeInsetsGeometryMix.symmetric(
        horizontal: FortalTokens.badgePaddingX1(),
        vertical: FortalTokens.badgePaddingY1(),
      ),
      .size2 => EdgeInsetsGeometryMix.symmetric(
        horizontal: FortalTokens.space2(),
        vertical: FortalTokens.space1(),
      ),
      .size3 => EdgeInsetsGeometryMix.symmetric(
        horizontal: FortalTokens.badgePaddingX3(),
        vertical: FortalTokens.space1(),
      ),
    };

Radius _fortalBadgeRadius(FortalBadgeSize size) => switch (size) {
  .size1 => FortalTokens.radius1OrFull(),
  .size2 || .size3 => FortalTokens.radius2OrFull(),
};
