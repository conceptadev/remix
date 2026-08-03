part of 'checkbox.dart';

/// Radix Themes Checkbox size presets.
enum FortalCheckboxSize { size1, size2, size3 }

/// Radix Themes Checkbox variants.
enum FortalCheckboxVariant { classic, surface, soft }

/// Fortal recipe for [RemixCheckbox].
@MixWidget(target: RemixCheckbox.new)
CheckboxStyler fortalCheckboxStyle({
  FortalCheckboxVariant variant = .surface,
  FortalCheckboxSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalCheckboxMetrics(size);
  final base =
      CheckboxStyler(
        container: .size(
          metrics.size,
          metrics.size,
        ).alignment(.center).borderRadiusAll(metrics.radius),
        indicator: .size(metrics.indicatorSize),
        containerEffects: RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(),
          overContent: _fortalCheckboxLayer(),
        ),
      ).onFocused(
        .containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(
              color: FortalTokens.focus8(),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            outlineOffset: 2,
          ),
        ),
      );

  return switch (variant) {
    .classic => _fortalCheckboxClassic(base, highContrast),
    .surface => _fortalCheckboxSurface(base, highContrast),
    .soft => _fortalCheckboxSoft(base, highContrast),
  };
}

({double size, double indicatorSize, Radius radius}) _fortalCheckboxMetrics(
  FortalCheckboxSize size,
) => switch (size) {
  .size1 => (
    size: FortalTokens.checkboxSize1(),
    indicatorSize: FortalTokens.checkboxIndicatorSize1(),
    radius: FortalTokens.checkboxRadius1(),
  ),
  .size2 => (
    size: FortalTokens.space4(),
    indicatorSize: FortalTokens.checkboxIndicatorSize2(),
    radius: FortalTokens.radius1(),
  ),
  .size3 => (
    size: FortalTokens.checkboxSize3(),
    indicatorSize: FortalTokens.checkboxIndicatorSize3(),
    radius: FortalTokens.checkboxRadius3(),
  ),
};

CheckboxStyler _fortalCheckboxSurface(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler()
      .color(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentIndicator(),
      )
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxLayer(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxInsetRing(FortalTokens.grayA7()),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
            )
            .containerEffects(
              RemixBoxEffectsMix(
                overContent: _fortalCheckboxInsetRing(FortalTokens.grayA6()),
              ),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

CheckboxStyler _fortalCheckboxClassic(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler()
      .color(
        highContrast ? FortalTokens.accent12() : FortalTokens.accentIndicator(),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(
            gradients: [
              RemixLinearGradientMix(
                colors: [
                  FortalTokens.whiteA3(),
                  Colors.transparent,
                  FortalTokens.blackA1(),
                ],
              ),
            ],
            shadows: [
              RemixBoxShadowMix(
                kind: .inset,
                color: FortalTokens.whiteA4(),
                offset: const Offset(0, 0.5),
                blurRadius: 0.5,
              ),
              RemixBoxShadowMix(
                kind: .inset,
                color: FortalTokens.blackA4(),
                offset: const Offset(0, -0.5),
                blurRadius: 0.5,
              ),
            ],
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxLayer(shadows: const []),
        ),
      )
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      );

  return base
      .color(FortalTokens.colorSurface())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: _fortalCheckboxLayer(
            shadowToken: FortalTokens.shadow1Layers,
          ),
        ),
      )
      .containerEffects(
        RemixBoxEffectsMix(
          overContent: _fortalCheckboxInsetRing(FortalTokens.grayA3()),
        ),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: _fortalCheckboxLayer(
                  gradients: const [],
                  shadowToken: FortalTokens.shadow1Layers,
                ),
              ),
            )
            .containerEffects(
              RemixBoxEffectsMix(
                overContent: _fortalCheckboxLayer(shadows: const []),
              ),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

CheckboxStyler _fortalCheckboxSoft(CheckboxStyler base, bool highContrast) {
  final selected = CheckboxStyler().indicatorColor(
    highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
  );

  return base
      .color(FortalTokens.accentA5())
      .containerEffects(
        RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
      )
      .onSelected(selected)
      .onIndeterminate(selected)
      .onDisabled(
        .color(FortalTokens.grayA3())
            .containerEffects(
              RemixBoxEffectsMix(behindContent: _fortalCheckboxLayer()),
            )
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixBoxEffectLayerMix _fortalCheckboxInsetRing(Color color) =>
    _fortalCheckboxLayer(
      shadows: [RemixBoxShadowMix(kind: .inset, color: color, spreadRadius: 1)],
    );

RemixBoxEffectLayerMix _fortalCheckboxLayer({
  List<RemixLinearGradientMix>? gradients,
  List<RemixBoxShadowMix>? shadows,
  RemixBoxShadowListToken? shadowToken,
}) => RemixBoxEffectLayerMix(
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
);
