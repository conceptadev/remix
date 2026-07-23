part of 'badge.dart';

/// Radix Themes Badge size presets.
enum FortalBadgeSize { size1, size2, size3 }

/// Radix Themes Badge variants.
enum FortalBadgeVariant { solid, soft, surface, outline }

/// Fortal recipe for [RemixBadge].
RemixBadgeStyler fortalBadgeStyler({
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
              behindContent: _fortalBadgeInsetStroke(FortalTokens.accentA6()),
            ),
          )
          .foregroundColor(
            highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
          ),
    .outline =>
      base
          .containerEffects(
            RemixBoxEffectsMix(
              behindContent: RemixBoxEffectLayerMix(
                shadows: [
                  RemixBoxShadowMix(
                    kind: RemixBoxShadowKind.inset,
                    color: highContrast
                        ? FortalTokens.accentA7()
                        : FortalTokens.accentA8(),
                    spreadRadius: 1,
                  ),
                  if (highContrast)
                    RemixBoxShadowMix(
                      kind: RemixBoxShadowKind.inset,
                      color: FortalTokens.grayA11(),
                      spreadRadius: 1,
                    ),
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
    container: BoxStyler(padding: _fortalBadgePadding(size)),
    label: TextStyler(
      style: _fortalBadgeText(size).mix(),
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

RemixBoxEffectLayerMix _fortalBadgeInsetStroke(Color color) =>
    RemixBoxEffectLayerMix(
      shadows: [
        RemixBoxShadowMix(
          kind: RemixBoxShadowKind.inset,
          color: color,
          spreadRadius: 1,
        ),
      ],
    );

/// Fortal-themed Badge with the Radix size, variant, and override contract.
class FortalBadge extends StatelessWidget {
  const FortalBadge({
    super.key,
    this.variant = .soft,
    this.size = .size1,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
  });

  const FortalBadge.solid({
    super.key,
    this.size = .size1,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
  }) : variant = .solid;

  const FortalBadge.soft({
    super.key,
    this.size = .size1,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
  }) : variant = .soft;

  const FortalBadge.surface({
    super.key,
    this.size = .size1,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
  }) : variant = .surface;

  const FortalBadge.outline({
    super.key,
    this.size = .size1,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
  }) : variant = .outline;

  final FortalBadgeVariant variant;
  final FortalBadgeSize size;
  final FortalAccentColor? color;
  final FortalRadius? radius;
  final bool highContrast;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: color,
      radius: radius,
      child: fortalBadgeStyler(
        variant: variant,
        size: size,
        highContrast: highContrast,
      ).call(key: key, child: child),
    );
  }
}
