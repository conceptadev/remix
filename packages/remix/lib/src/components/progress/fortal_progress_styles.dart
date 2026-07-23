part of 'progress.dart';

/// Fortal progress size presets.
enum FortalProgressSize { size1, size2, size3 }

/// Fortal progress color variants.
enum FortalProgressVariant { classic, surface, soft }

/// Fortal-themed preset for [RemixProgress].
RemixProgressStyler fortalProgressStyler({
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
    container: BoxStyler()
        .width(.infinity)
        .height(metrics.height)
        .borderRadiusAll(metrics.radius)
        .clipBehavior(.antiAlias),
    track: BoxStyler().width(.infinity).height(metrics.height),
    indicator: BoxStyler()
        .height(metrics.height)
        .borderRadiusAll(metrics.radius),
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
          overContent: _fortalProgressLayer(shadowToken: FortalTokens.shadow1),
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
        BoxStyler().foregroundDecoration(
          BoxDecorationMix(color: FortalTokens.whiteA1()),
        ),
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
        BoxStyler().foregroundDecoration(
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

/// Fortal-themed preset for [RemixProgress].
class FortalProgress extends StatelessWidget {
  const FortalProgress({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.value,
    this.max = 100,
    this.duration = const Duration(seconds: 5),
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const FortalProgress.classic({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.value,
    this.max = 100,
    this.duration = const Duration(seconds: 5),
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = .classic;

  const FortalProgress.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.value,
    this.max = 100,
    this.duration = const Duration(seconds: 5),
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = .surface;

  const FortalProgress.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    this.value,
    this.max = 100,
    this.duration = const Duration(seconds: 5),
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = .soft;

  final FortalProgressVariant variant;

  final FortalProgressSize size;

  /// Optional accent color override for this progress subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this progress subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  /// Current progress, or null for the indeterminate animation.
  final double? value;

  /// Maximum determinate value.
  final double max;

  /// Initial indeterminate growth duration.
  final Duration duration;

  /// Accessible label for the operation.
  final String? semanticLabel;

  /// Whether to remove progress semantics from the tree.
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalProgressStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
            value: this.value,
            max: this.max,
            duration: this.duration,
            semanticLabel: this.semanticLabel,
            excludeSemantics: this.excludeSemantics,
          ),
    );
  }
}
