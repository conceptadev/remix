part of 'progress.dart';

/// Fortal progress size presets.
enum FortalProgressSize { size1, size2, size3 }

/// Fortal progress color variants.
enum FortalProgressVariant { classic, surface, soft }

/// Fortal-themed preset for [RemixProgress].
@MixWidget(target: RemixProgress.new)
RemixProgressStyler fortalProgressStyle({
  FortalProgressVariant variant = .surface,
  FortalProgressSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .classic => _fortalProgressClassicStyler(size, highContrast: highContrast),
    .surface => _fortalProgressSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalProgressSoftStyler(size, highContrast: highContrast),
  };
}

RemixProgressStyler _fortalProgressBaseStyler(FortalProgressSize size) {
  final metrics = _fortalProgressMetrics(size);
  return RemixProgressStyler(
    container: .width(.infinity)
        .height(metrics.height)
        .borderRadiusAll(metrics.radius)
        .clipBehavior(.antiAlias),
    track: .width(.infinity).height(metrics.height),
    indicator: .height(metrics.height).borderRadiusAll(metrics.radius),
    trackEffects: RemixBoxEffectsMix(
      behindContent: _fortalProgressLayer(),
      overContent: _fortalProgressLayer(),
    ),
    indicatorEffects: RemixBoxEffectsMix(
      behindContent: _fortalProgressLayer(),
      overContent: _fortalProgressLayer(),
    ),
  );
}

RemixProgressStyler _fortalProgressClassicStyler(
  FortalProgressSize size, {
  required bool highContrast,
}) {
  return _fortalProgressBaseStyler(size)
      .trackColor(FortalTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix(behindContent: _fortalProgressLayer()))
      .trackEffects(
        RemixBoxEffectsMix(
          overContent: _fortalProgressLayer(
            shadowToken: FortalTokens.shadow1Layers,
          ),
        ),
      )
      .indicatorEffects(
        RemixBoxEffectsMix(behindContent: _fortalProgressLayer()),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentTrack(),
      );
}

RemixProgressStyler _fortalProgressSurfaceStyler(
  FortalProgressSize size, {
  required bool highContrast,
}) {
  return _fortalProgressBaseStyler(size)
      .trackColor(FortalTokens.grayA3())
      .trackEffects(RemixBoxEffectsMix(behindContent: _fortalProgressLayer()))
      .trackEffects(
        RemixBoxEffectsMix(
          overContent: _fortalProgressLayer(
            shadows: [
              RemixBoxShadowMix(
                kind: .inset,
                color: FortalTokens.grayA4(),
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      )
      .indicatorEffects(
        RemixBoxEffectsMix(behindContent: _fortalProgressLayer()),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentTrack(),
      );
}

RemixProgressStyler _fortalProgressSoftStyler(
  FortalProgressSize size, {
  required bool highContrast,
}) {
  return _fortalProgressBaseStyler(size)
      .trackColor(FortalTokens.grayA4())
      .track(
        .foregroundDecoration(BoxDecorationMix(color: FortalTokens.whiteA1())),
      )
      .trackEffects(RemixBoxEffectsMix(behindContent: _fortalProgressLayer()))
      .trackEffects(RemixBoxEffectsMix(overContent: _fortalProgressLayer()))
      .indicatorEffects(
        RemixBoxEffectsMix(behindContent: _fortalProgressLayer()),
      )
      .indicatorEffects(RemixBoxEffectsMix(overContent: _fortalProgressLayer()))
      .indicatorColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent8(),
      )
      .indicator(
        .foregroundDecoration(
          BoxDecorationMix(
            color: highContrast ? null : FortalTokens.accentA5(),
          ),
        ),
      );
}

({double height, Radius radius}) _fortalProgressMetrics(
  FortalProgressSize size,
) => switch (size) {
  .size1 => (
    height: FortalTokens.space1(),
    radius: FortalTokens.progressRadius1(),
  ),
  .size2 => (
    height: FortalTokens.progressHeight2(),
    radius: FortalTokens.progressRadius2(),
  ),
  .size3 => (
    height: FortalTokens.space2(),
    radius: FortalTokens.progressRadius3(),
  ),
};

RemixBoxEffectLayerMix _fortalProgressLayer({
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(shadows: shadows, shadowToken: shadowToken);
