import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'card.g.dart';

/// Radix Themes Card size presets.
enum UiCardSize { size1, size2, size3, size4, size5 }

/// Radix Themes Card variants.
enum UiCardVariant { surface, classic, ghost }

/// Ui-themed Card with the Radix size and variant contract.
@MixWidget(target: RemixCard.new)
CardStyler uiCardStyle({
  UiCardVariant variant = .surface,
  UiCardSize size = .size1,
  CardStyler style = const CardStyler.create(),
}) {
  final metrics = _uiCardMetrics(size);
  final base = CardStyler()
      .padding(.all(metrics.padding))
      .borderRadius(.all(metrics.radius))
      .clipBehavior(Clip.antiAlias)
      .onFocusVisible(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: UiTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: -1,
          ),
        ),
      );

  return (switch (variant) {
    .surface => _uiCardSurface(base),
    .classic => _uiCardClassic(base),
    .ghost => _uiCardGhost(base, metrics.ghostMargin),
  }).merge(style);
}

({double padding, double ghostMargin, Radius radius}) _uiCardMetrics(
  UiCardSize size,
) => switch (size) {
  .size1 => (
    padding: UiTokens.space3(),
    ghostMargin: UiTokens.cardGhostMargin1(),
    radius: UiTokens.radius4(),
  ),
  .size2 => (
    padding: UiTokens.space4(),
    ghostMargin: UiTokens.cardGhostMargin2(),
    radius: UiTokens.radius4(),
  ),
  .size3 => (
    padding: UiTokens.space5(),
    ghostMargin: UiTokens.cardGhostMargin3(),
    radius: UiTokens.radius5(),
  ),
  .size4 => (
    padding: UiTokens.space6(),
    ghostMargin: UiTokens.cardGhostMargin4(),
    radius: UiTokens.radius5(),
  ),
  .size5 => (
    padding: UiTokens.space8(),
    ghostMargin: UiTokens.cardGhostMargin5(),
    radius: UiTokens.radius6(),
  ),
};

CardStyler _uiCardSurface(CardStyler base) {
  base = base.containerEffects(
    RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()),
  );
  final open = CardStyler()
      .containerEffects(RemixBoxEffectsMix.behindContent(_uiCardPanel()))
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          _uiCardSurfaceStroke(UiTokens.grayStroke7()),
        ),
      );
  final activeFocus = CardStyler()
      .containerEffects(RemixBoxEffectsMix.behindContent(_uiCardActiveFocus()))
      .onSelected(open);
  final pressed = CardStyler()
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          _uiCardSurfaceStroke(UiTokens.grayStroke6()),
        ),
      )
      .onFocusVisible(activeFocus)
      .onSelected(open);

  return base
      .containerEffects(RemixBoxEffectsMix.behindContent(_uiCardPanel()))
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          _uiCardSurfaceStroke(UiTokens.grayStroke5()),
        ),
      )
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

CardStyler _uiCardClassic(CardStyler base) {
  base = base.containerEffects(
    RemixBoxEffectsMix.backdropBlur(UiTokens.panelBlur()),
  );
  final open = CardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          _uiCardPanel(shadowToken: UiTokens.cardClassicHoverOuterShadows),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(
            shadowToken: UiTokens.cardClassicHoverInnerShadows,
          ),
        ),
      );
  final pressed = CardStyler()
      .animate(AnimationConfig.ease(const Duration(milliseconds: 40)))
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          RemixBoxEffectLayerMix(
            shadowToken: UiTokens.cardClassicActiveOuterShadows,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(
            shadowToken: UiTokens.cardClassicActiveInnerShadows,
          ),
        ),
      )
      .onFocusVisible(
        .containerEffects(
          RemixBoxEffectsMix.behindContent(_uiCardActiveFocus()),
        ).onSelected(open),
      )
      .onSelected(open);

  return base
      .animate(AnimationConfig.ease(const Duration(milliseconds: 120)))
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          _uiCardPanel(shadowToken: UiTokens.cardClassicOuterShadows),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          RemixBoxEffectLayerMix(shadowToken: UiTokens.cardClassicInnerShadows),
        ),
      )
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

CardStyler _uiCardGhost(CardStyler base, double ghostMargin) {
  final focused = CardStyler().color(UiTokens.accentA2());
  final open = CardStyler().color(UiTokens.grayA3()).onFocusVisible(focused);
  final pressed = CardStyler()
      .color(UiTokens.grayA4())
      .onFocusVisible(focused)
      .onSelected(open);

  return base
      .margin(.all(ghostMargin))
      .color(const Color(0x00000000))
      .onHovered(open)
      .onPressed(pressed)
      .onSelected(open.onPressed(open));
}

RemixBoxEffectLayerMix _uiCardPanel({RemixBoxShadowListToken? shadowToken}) =>
    RemixBoxEffectLayerMix(
      gradients: [
        RemixLinearGradientMix(
          colors: [UiTokens.colorPanel(), UiTokens.colorPanel()],
        ),
      ],
      gradientInsets: const [1],
      shadowToken: shadowToken,
    );

RemixBoxEffectLayerMix _uiCardActiveFocus() => RemixBoxEffectLayerMix(
  gradients: [
    RemixLinearGradientMix(colors: [UiTokens.accentA2(), UiTokens.accentA2()]),
    RemixLinearGradientMix(
      colors: [UiTokens.colorPanel(), UiTokens.colorPanel()],
    ),
  ],
  gradientInsets: const [1, 1],
);

RemixBoxEffectLayerMix _uiCardSurfaceStroke(Color color) =>
    RemixBoxEffectLayerMix(
      shadows: [
        RemixBoxShadowMix(color: color, spreadRadius: 1, shapeInset: 1),
      ],
    );
