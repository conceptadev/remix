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
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: FortalTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: -1,
          ),
        ),
      );

  return switch (variant) {
    .surface => _fortalCardSurface(base),
    .classic => _fortalCardClassic(base),
    .ghost => _fortalCardGhost(base, metrics.ghostMargin),
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

RemixCardStyler _fortalCardSurface(RemixCardStyler base) {
  base = base.containerEffects(
    RemixBoxEffectsMix(backdropBlur: FortalTokens.panelBlur()),
  );
  final open = RemixCardStyler()
      .containerEffects(RemixBoxEffectsMix(behindContent: _fortalCardPanel()))
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCardSurfaceStroke(FortalTokens.grayStroke7()),
        ),
      );
  final activeFocus = RemixCardStyler()
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCardActiveFocus()),
      )
      .onSelected(open);
  final pressed = RemixCardStyler()
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCardSurfaceStroke(FortalTokens.grayStroke6()),
        ),
      )
      .onFocused(activeFocus)
      .onSelected(open);

  return base
      .containerEffects(RemixBoxEffectsMix(behindContent: _fortalCardPanel()))
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCardSurfaceStroke(FortalTokens.grayStroke5()),
        ),
      )
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixCardStyler _fortalCardClassic(RemixCardStyler base) {
  base = base.containerEffects(
    RemixBoxEffectsMix(backdropBlur: FortalTokens.panelBlur()),
  );
  final open = RemixCardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCardPanel(
            shadowToken: FortalTokens.cardClassicHoverOuterShadows,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: RemixBoxEffectLayerMix(
            shadowToken: FortalTokens.cardClassicHoverInnerShadows,
          ),
        ),
      );
  final pressed = RemixCardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: RemixBoxEffectLayerMix(
            shadowToken: FortalTokens.cardClassicActiveOuterShadows,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: RemixBoxEffectLayerMix(
            shadowToken: FortalTokens.cardClassicActiveInnerShadows,
          ),
        ),
      )
      .onFocused(
        .containerEffects(
          RemixBoxEffectsMix(behindContent: _fortalCardActiveFocus()),
        ).onSelected(open),
      )
      .onSelected(open);

  return base
      .animate(AnimationConfig.ease(const Duration(milliseconds: 120)))
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCardPanel(
            shadowToken: FortalTokens.cardClassicOuterShadows,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: RemixBoxEffectLayerMix(
            shadowToken: FortalTokens.cardClassicInnerShadows,
          ),
        ),
      )
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixCardStyler _fortalCardGhost(RemixCardStyler base, double ghostMargin) {
  final focused = RemixCardStyler().color(FortalTokens.accentA2());
  final open = RemixCardStyler()
      .color(FortalTokens.grayA3())
      .onFocused(focused);
  final pressed = RemixCardStyler()
      .color(FortalTokens.grayA4())
      .onFocused(focused)
      .onSelected(open);

  return base
      .marginAll(ghostMargin)
      .color(Colors.transparent)
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixBoxEffectLayerMix _fortalCardPanel({
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: [
    RemixLinearGradientMix(
      colors: [FortalTokens.colorPanel(), FortalTokens.colorPanel()],
    ),
  ],
  gradientInsets: const [1],
  shadowToken: shadowToken,
);

RemixBoxEffectLayerMix _fortalCardActiveFocus() => RemixBoxEffectLayerMix(
  gradients: [
    RemixLinearGradientMix(
      colors: [FortalTokens.accentA2(), FortalTokens.accentA2()],
    ),
    RemixLinearGradientMix(
      colors: [FortalTokens.colorPanel(), FortalTokens.colorPanel()],
    ),
  ],
  gradientInsets: const [1, 1],
);

RemixBoxEffectLayerMix _fortalCardSurfaceStroke(Color color) =>
    RemixBoxEffectLayerMix(
      shadows: [
        RemixBoxShadowMix(color: color, spreadRadius: 1, shapeInset: 1),
      ],
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

  const FortalCard.surface({
    super.key,
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
  }) : variant = .surface;

  const FortalCard.classic({
    super.key,
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
  }) : variant = .classic;

  const FortalCard.ghost({
    super.key,
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
  }) : variant = .ghost;

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
