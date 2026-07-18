part of 'card.dart';

/// Fortal card size presets.
enum FortalCardSize { size1, size2, size3 }

/// Fortal card surface variants.
enum FortalCardVariant { surface, classic, ghost }

/// Fortal-themed preset for [RemixCard].
RemixCardStyler fortalCardStyler({
  FortalCardVariant variant = .surface,
  FortalCardSize size = .size2,
}) {
  return switch (variant) {
    .surface => _fortalCardSurfaceStyler(size),
    .classic => _fortalCardClassicStyler(size),
    .ghost => _fortalCardGhostStyler(size),
  };
}

RemixCardStyler _fortalCardBaseStyler(FortalCardSize size) {
  return RemixCardStyler().merge(_fortalCardSizeStyler(size));
}

RemixCardStyler _fortalCardSurfaceStyler([FortalCardSize size = .size2]) {
  return _fortalCardBaseStyler(size)
      .borderAll(
        color: FortalTokens.gray6(),
        width: FortalTokens.borderWidth1(),
      )
      .borderRadiusAll(FortalTokens.radius5());
}

RemixCardStyler _fortalCardClassicStyler([FortalCardSize size = .size2]) {
  return _fortalCardBaseStyler(size)
      .backgroundColor(FortalTokens.graySurface())
      .borderAll(
        color: FortalTokens.gray6(),
        width: FortalTokens.borderWidth1(),
      )
      .shadow(
        BoxShadowMix()
            .color(FortalTokens.grayA3())
            .offset(x: 0, y: 2)
            .blurRadius(3)
            .spreadRadius(0),
      )
      .borderRadiusAll(FortalTokens.radius5())
      .merge(RemixCardStyler(container: BoxStyler()));
}

RemixCardStyler _fortalCardGhostStyler([FortalCardSize size = .size2]) {
  return _fortalCardBaseStyler(size).backgroundColor(Colors.transparent);
}

RemixCardStyler _fortalCardSizeStyler(FortalCardSize size) {
  return switch (size) {
    .size1 => RemixCardStyler().paddingAll(FortalTokens.space4()),
    .size2 => RemixCardStyler().paddingAll(FortalTokens.space5()),
    .size3 => RemixCardStyler().paddingAll(FortalTokens.space6()),
  };
}

/// Fortal-themed preset for [RemixCard].
class FortalCard extends StatelessWidget {
  const FortalCard({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.child,
  });

  const FortalCard.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.child,
  }) : variant = FortalCardVariant.surface;

  const FortalCard.classic({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.child,
  }) : variant = FortalCardVariant.classic;

  const FortalCard.ghost({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.child,
  }) : variant = FortalCardVariant.ghost;

  final FortalCardVariant variant;

  final FortalCardSize size;

  /// Optional accent color override for this card subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this card subtree.
  final FortalRadius? radius;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalCardStyler(
        variant: this.variant,
        size: this.size,
      ).call(key: this.key, child: this.child),
    );
  }
}
