import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'progress.g.dart';

/// Ui progress size presets.
enum UiProgressSize { size1, size2, size3 }

/// Ui progress color variants.
enum UiProgressVariant { classic, surface, soft }

/// Ui-themed preset for [RemixProgress].
@MixWidget(target: RemixProgress.new)
ProgressStyler uiProgressStyle({
  UiProgressVariant variant = .surface,
  UiProgressSize size = .size2,
  bool highContrast = false,
  ProgressStyler style = const ProgressStyler.create(),
}) {
  return (switch (variant) {
    .classic => _uiProgressClassicStyler(size, highContrast: highContrast),
    .surface => _uiProgressSurfaceStyler(size, highContrast: highContrast),
    .soft => _uiProgressSoftStyler(size, highContrast: highContrast),
  }).merge(style);
}

ProgressStyler _uiProgressBaseStyler(UiProgressSize size) {
  final metrics = _uiProgressMetrics(size);
  return ProgressStyler(
    container: .width(.infinity)
        .height(metrics.height)
        .borderRadius(.all(metrics.radius))
        .clipBehavior(.antiAlias),
    track: .width(.infinity).height(metrics.height),
    indicator: .height(metrics.height).borderRadius(.all(metrics.radius)),
    trackEffects: RemixBoxEffectsMix(
      behindContent: _uiProgressLayer(),
      overContent: _uiProgressLayer(),
    ),
    indicatorEffects: RemixBoxEffectsMix(
      behindContent: _uiProgressLayer(),
      overContent: _uiProgressLayer(),
    ),
  );
}

ProgressStyler _uiProgressClassicStyler(
  UiProgressSize size, {
  required bool highContrast,
}) {
  return _uiProgressBaseStyler(size)
      .trackColor(UiTokens.grayA3())
      .trackEffects(
        RemixBoxEffectsMix.overContent(
          _uiProgressLayer(shadowToken: UiTokens.shadow1Layers),
        ),
      )
      .indicatorColor(
        highContrast ? UiTokens.accent12() : UiTokens.accentTrack(),
      );
}

ProgressStyler _uiProgressSurfaceStyler(
  UiProgressSize size, {
  required bool highContrast,
}) {
  return _uiProgressBaseStyler(size)
      .trackColor(UiTokens.grayA3())
      .trackEffects(
        RemixBoxEffectsMix.overContent(
          _uiProgressLayer(
            shadows: [
              RemixBoxShadowMix(
                kind: .inset,
                color: UiTokens.grayA4(),
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      )
      .indicatorColor(
        highContrast ? UiTokens.accent12() : UiTokens.accentTrack(),
      );
}

ProgressStyler _uiProgressSoftStyler(
  UiProgressSize size, {
  required bool highContrast,
}) {
  return _uiProgressBaseStyler(size)
      .trackColor(UiTokens.grayA4())
      .track(.foregroundDecoration(BoxDecorationMix(color: UiTokens.whiteA1())))
      .indicatorColor(highContrast ? UiTokens.accent12() : UiTokens.accent8())
      .indicator(
        .foregroundDecoration(
          BoxDecorationMix(color: highContrast ? null : UiTokens.accentA5()),
        ),
      );
}

({double height, Radius radius}) _uiProgressMetrics(UiProgressSize size) =>
    switch (size) {
      .size1 => (height: UiTokens.space1(), radius: UiTokens.progressRadius1()),
      .size2 => (
        height: UiTokens.progressHeight2(),
        radius: UiTokens.progressRadius2(),
      ),
      .size3 => (height: UiTokens.space2(), radius: UiTokens.progressRadius3()),
    };

RemixBoxEffectLayerMix _uiProgressLayer({
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(shadows: shadows, shadowToken: shadowToken);
