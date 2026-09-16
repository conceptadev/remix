import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'radio.g.dart';

/// Ui radio size presets.
enum UiRadioSize {
  /// Compact radio.
  size1,

  /// Default radio.
  size2,

  /// Large radio.
  size3,
}

/// Ui radio color variants.
enum UiRadioVariant {
  /// Raised treatment with Radix's classic shadow and gradient layers.
  classic,

  /// Surface treatment with neutral border.
  surface,

  /// Soft accent treatment.
  soft,
}

/// Ui-themed preset for [RemixRadio].
@MixWidget(target: RemixRadio.new)
RadioStyler uiRadioStyle({
  UiRadioVariant variant = .surface,
  UiRadioSize size = .size2,
  bool highContrast = false,
  RadioStyler style = const RadioStyler.create(),
}) {
  return (switch (variant) {
    .classic => _uiRadioClassicStyler(size, highContrast: highContrast),
    .surface => _uiRadioSurfaceStyler(size, highContrast: highContrast),
    .soft => _uiRadioSoftStyler(size, highContrast: highContrast),
  }).merge(style);
}

RadioStyler _uiRadioBaseStyler(UiRadioSize size) {
  final metrics = _uiRadioMetrics(size);
  return RadioStyler(
    container: .size(
      metrics.size,
      metrics.size,
    ).alignment(.center).borderRadius(.all(UiTokens.radiusCircle())),
    indicator: .size(
      metrics.indicatorSize,
      metrics.indicatorSize,
    ).borderRadius(.all(UiTokens.radiusCircle())),
    containerEffects: RemixBoxEffectsMix(
      behindContent: RemixBoxEffectLayerMix(),
      overContent: RemixBoxEffectLayerMix(),
    ),
  ).onFocusVisible(
    .containerEffects(
      RemixBoxEffectsMix(
        outline: BorderSideMix(
          color: UiTokens.focus8(),
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        outlineOffset: 2,
      ),
    ),
  );
}

RadioStyler _uiRadioClassicStyler(
  UiRadioSize size, {
  required bool highContrast,
}) {
  final selectedColor = highContrast
      ? UiTokens.accent12()
      : UiTokens.accentIndicator();
  return _uiRadioBaseStyler(size)
      .color(UiTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(
          RemixBoxEffectLayerMix(shadowToken: UiTokens.shadow1Layers),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          uiInsetSurface(strokes: [UiTokens.gray7()]),
        ),
      )
      .indicatorColor(
        highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
      )
      .onSelected(
        .color(selectedColor)
            .containerEffects(
              RemixBoxEffectsMix.behindContent(
                RemixBoxEffectLayerMix(
                  gradients: [
                    RemixLinearGradientMix(
                      colors: [
                        UiTokens.whiteA3(),
                        const Color(0x00000000),
                        UiTokens.blackA3(),
                      ],
                    ),
                  ],
                  shadows: [
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: UiTokens.whiteA4(),
                      offset: const Offset(0, 0.5),
                      blurRadius: 0.5,
                    ),
                    RemixBoxShadowMix(
                      kind: .inset,
                      color: UiTokens.blackA4(),
                      offset: const Offset(0, -0.5),
                      blurRadius: 0.5,
                    ),
                  ],
                ),
              ),
            )
            .indicatorColor(
              highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
            ),
      )
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(
                RemixBoxEffectLayerMix(shadowToken: UiTokens.shadow1Layers),
              ),
            )
            .containerEffects(
              RemixBoxEffectsMix.overContent(
                RemixBoxEffectLayerMix(shadows: const []),
              ),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}

RadioStyler _uiRadioSurfaceStyler(
  UiRadioSize size, {
  required bool highContrast,
}) {
  return _uiRadioBaseStyler(size)
      .color(UiTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
      )
      .containerEffects(
        RemixBoxEffectsMix.overContent(
          uiInsetSurface(strokes: [UiTokens.grayA7()]),
        ),
      )
      .indicator(
        .color(UiTokens.accent9()).borderRadius(.all(UiTokens.radiusCircle())),
      )
      .onSelected(
        .color(highContrast ? UiTokens.accent12() : UiTokens.accentIndicator())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .containerEffects(
              RemixBoxEffectsMix.overContent(
                RemixBoxEffectLayerMix(shadows: const []),
              ),
            )
            .indicatorColor(
              highContrast ? UiTokens.accent1() : UiTokens.accentContrast(),
            ),
      )
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .containerEffects(
              RemixBoxEffectsMix.overContent(
                uiInsetSurface(strokes: [UiTokens.grayA6()]),
              ),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}

RadioStyler _uiRadioSoftStyler(UiRadioSize size, {required bool highContrast}) {
  return _uiRadioBaseStyler(size)
      .color(UiTokens.accentA4())
      .containerEffects(
        RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
      )
      .indicator(
        .color(
          highContrast ? UiTokens.accent12() : UiTokens.accent11(),
        ).borderRadius(.all(UiTokens.radiusCircle())),
      )
      .onSelected(
        .color(UiTokens.accentA4())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .indicator(
              .color(highContrast ? UiTokens.accent12() : UiTokens.accent11()),
            ),
      )
      .onDisabled(
        .color(UiTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix.behindContent(RemixBoxEffectLayerMix()),
            )
            .indicatorColor(UiTokens.grayA8()),
      );
}

({double size, double indicatorSize}) _uiRadioMetrics(UiRadioSize size) =>
    switch (size) {
      .size1 => (
        size: UiTokens.checkboxSize1(),
        indicatorSize: UiTokens.radioIndicatorSize1(),
      ),
      .size2 => (
        size: UiTokens.space4(),
        indicatorSize: UiTokens.radioIndicatorSize2(),
      ),
      .size3 => (
        size: UiTokens.checkboxSize3(),
        indicatorSize: UiTokens.radioIndicatorSize3(),
      ),
    };
