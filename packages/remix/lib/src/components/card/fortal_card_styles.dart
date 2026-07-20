part of 'card.dart';

/// Radix Themes Card size presets.
enum FortalCardSize { size1, size2, size3, size4, size5 }

/// Radix Themes Card variants.
enum FortalCardVariant { surface, classic, ghost }

/// Fortal recipe for [RemixCard].
RemixCardStyler fortalCardStyler({
  FortalCardVariant variant = .surface,
  FortalCardSize size = .size1,
}) {
  final metrics = _fortalCardMetrics(size);
  final base = RemixCardStyler()
      .paddingAll(metrics.padding)
      .borderRadiusAll(metrics.radius)
      .clipBehavior(Clip.antiAlias)
      .onFocused(
        RemixCardStyler().overlay(
          RemixSurfaceLayerMix(
            borderRadius: BorderRadiusMix.all(metrics.radius),
            outlineColor: FortalTokens.focus8(),
            outlineWidth: 2,
            outlineOffset: -1,
          ),
        ),
      );

  return switch (variant) {
    .surface => _fortalCardSurface(base, metrics.radius),
    .classic => _fortalCardClassic(base, metrics.radius),
    .ghost => _fortalCardGhost(base, metrics.radius, metrics.ghostMargin),
  };
}

({double padding, double ghostMargin, Radius radius}) _fortalCardMetrics(
  FortalCardSize size,
) => switch (size) {
  .size1 => (
    padding: FortalTokens.space3(),
    ghostMargin: FortalTokens.cardGhostMargin1(),
    radius: FortalTokens.radius4(),
  ),
  .size2 => (
    padding: FortalTokens.space4(),
    ghostMargin: FortalTokens.cardGhostMargin2(),
    radius: FortalTokens.radius4(),
  ),
  .size3 => (
    padding: FortalTokens.space5(),
    ghostMargin: FortalTokens.cardGhostMargin3(),
    radius: FortalTokens.radius5(),
  ),
  .size4 => (
    padding: FortalTokens.space6(),
    ghostMargin: FortalTokens.cardGhostMargin4(),
    radius: FortalTokens.radius5(),
  ),
  .size5 => (
    padding: FortalTokens.space8(),
    ghostMargin: FortalTokens.cardGhostMargin5(),
    radius: FortalTokens.radius6(),
  ),
};

RemixCardStyler _fortalCardSurface(RemixCardStyler base, Radius radius) {
  final open = RemixCardStyler()
      .surface(_fortalCardPanel(radius))
      .overlay(_fortalCardSurfaceStroke(radius, FortalTokens.grayStroke7()));
  final activeFocus = RemixCardStyler()
      .surface(_fortalCardActiveFocus(radius))
      .onSelected(open);
  final pressed = RemixCardStyler()
      .overlay(_fortalCardSurfaceStroke(radius, FortalTokens.grayStroke6()))
      .onFocused(activeFocus)
      .onSelected(open);

  return base
      .surface(_fortalCardPanel(radius))
      .overlay(_fortalCardSurfaceStroke(radius, FortalTokens.grayStroke5()))
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixCardStyler _fortalCardClassic(RemixCardStyler base, Radius radius) {
  final open = RemixCardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .surface(
        _fortalCardPanel(
          radius,
          shadowToken: FortalTokens.cardClassicHoverOuterShadows,
        ),
      )
      .overlay(
        RemixSurfaceLayerMix(
          borderRadius: BorderRadiusMix.all(radius),
          shadowToken: FortalTokens.cardClassicHoverInnerShadows,
        ),
      );
  final pressed = RemixCardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .surface(
        RemixSurfaceLayerMix(
          borderRadius: BorderRadiusMix.all(radius),
          shadowToken: FortalTokens.cardClassicActiveOuterShadows,
        ),
      )
      .overlay(
        RemixSurfaceLayerMix(
          borderRadius: BorderRadiusMix.all(radius),
          shadowToken: FortalTokens.cardClassicActiveInnerShadows,
        ),
      )
      .onFocused(
        RemixCardStyler()
            .surface(_fortalCardActiveFocus(radius))
            .onSelected(open),
      )
      .onSelected(open);

  return base
      .animate(AnimationConfig.ease(const Duration(milliseconds: 120)))
      .surface(
        _fortalCardPanel(
          radius,
          shadowToken: FortalTokens.cardClassicOuterShadows,
        ),
      )
      .overlay(
        RemixSurfaceLayerMix(
          borderRadius: BorderRadiusMix.all(radius),
          shadowToken: FortalTokens.cardClassicInnerShadows,
        ),
      )
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixCardStyler _fortalCardGhost(
  RemixCardStyler base,
  Radius radius,
  double ghostMargin,
) {
  final focused = RemixCardStyler().surface(
    _fortalCardFill(FortalTokens.accentA2(), radius),
  );
  final open = RemixCardStyler()
      .surface(_fortalCardFill(FortalTokens.grayA3(), radius))
      .onFocused(focused);
  final pressed = RemixCardStyler()
      .surface(_fortalCardFill(FortalTokens.grayA4(), radius))
      .onFocused(focused)
      .onSelected(open);

  return base
      .marginAll(ghostMargin)
      .surface(_fortalCardFill(Colors.transparent, radius))
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixSurfaceLayerMix _fortalCardPanel(
  Radius radius, {
  RemixPaintShadowListToken? shadowToken,
}) => RemixSurfaceLayerMix(
  gradients: [
    RemixLinearGradientMix(
      colors: [FortalTokens.colorPanel(), FortalTokens.colorPanel()],
    ),
  ],
  gradientInsets: const [1],
  shadowToken: shadowToken,
  borderRadius: BorderRadiusMix.all(radius),
  backdropBlur: FortalTokens.panelBlur(),
);

RemixSurfaceLayerMix _fortalCardActiveFocus(Radius radius) =>
    RemixSurfaceLayerMix(
      gradients: [
        RemixLinearGradientMix(
          colors: [FortalTokens.accentA2(), FortalTokens.accentA2()],
        ),
        RemixLinearGradientMix(
          colors: [FortalTokens.colorPanel(), FortalTokens.colorPanel()],
        ),
      ],
      gradientInsets: const [1, 1],
      borderRadius: BorderRadiusMix.all(radius),
    );

RemixSurfaceLayerMix _fortalCardSurfaceStroke(Radius radius, Color color) =>
    RemixSurfaceLayerMix(
      shadows: [
        RemixPaintShadowMix(color: color, spreadRadius: 1, shapeInset: 1),
      ],
      borderRadius: BorderRadiusMix.all(radius),
    );

RemixSurfaceLayerMix _fortalCardFill(Color color, Radius radius) =>
    RemixSurfaceLayerMix(
      color: color,
      borderRadius: BorderRadiusMix.all(radius),
    );

/// Fortal-themed Card with the Radix size and variant contract.
class FortalCard extends StatelessWidget {
  const FortalCard({
    super.key,
    this.variant = .surface,
    this.size = .size1,
    this.child,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.focusOnTap = false,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalCardVariant variant;
  final FortalCardSize size;
  final Widget? child;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool focusOnTap;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onPressChange;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) =>
      fortalCardStyler(variant: variant, size: size).call(
        key: key,
        child: child,
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        mouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        focusNode: focusNode,
        autofocus: autofocus,
        focusOnTap: focusOnTap,
        onFocusChange: onFocusChange,
        onHoverChange: onHoverChange,
        onPressChange: onPressChange,
        semanticLabel: semanticLabel,
        excludeSemantics: excludeSemantics,
      );
}
