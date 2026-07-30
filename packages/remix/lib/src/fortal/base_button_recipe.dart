import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../rendering/remix_ordered_color_filter.dart';
import '../rendering/remix_box_effects.dart';
import 'fortal_theme.dart';

/// Shared Radix BaseButton metrics used by Button and IconButton recipes.
({
  double height,
  double paddingX,
  double gap,
  Radius radius,
  TextStyleToken text,
  double spinnerSize,
})
fortalBaseButtonMetrics(int size) => switch (size) {
  1 => (
    height: FortalTokens.space5(),
    paddingX: FortalTokens.space2(),
    gap: FortalTokens.space1(),
    radius: FortalTokens.radius1OrFull(),
    text: FortalTokens.text1,
    spinnerSize: FortalTokens.space3(),
  ),
  2 => (
    height: FortalTokens.space6(),
    paddingX: FortalTokens.space3(),
    gap: FortalTokens.space2(),
    radius: FortalTokens.radius2OrFull(),
    text: FortalTokens.text2,
    spinnerSize: FortalTokens.space4(),
  ),
  3 => (
    height: FortalTokens.space7(),
    paddingX: FortalTokens.space4(),
    gap: FortalTokens.space3(),
    radius: FortalTokens.radius3OrFull(),
    text: FortalTokens.text3,
    spinnerSize: FortalTokens.space4(),
  ),
  4 => (
    height: FortalTokens.space8(),
    paddingX: FortalTokens.space5(),
    gap: FortalTokens.space3(),
    radius: FortalTokens.radius4OrFull(),
    text: FortalTokens.text4,
    spinnerSize: FortalTokens.spinnerSize3(),
  ),
  _ => throw ArgumentError.value(size, 'size', 'Expected a size from 1 to 4.'),
};

/// Content-box metrics for the ghost BaseButton variant.
({double paddingX, double paddingY, double marginX, double marginY, double gap})
fortalBaseButtonGhostMetrics(int size) => switch (size) {
  1 => (
    paddingX: FortalTokens.space2(),
    paddingY: FortalTokens.space1(),
    marginX: FortalTokens.baseButtonGhostMarginX12(),
    marginY: FortalTokens.baseButtonGhostMarginY12(),
    gap: FortalTokens.space1(),
  ),
  2 => (
    paddingX: FortalTokens.space2(),
    paddingY: FortalTokens.space1(),
    marginX: FortalTokens.baseButtonGhostMarginX12(),
    marginY: FortalTokens.baseButtonGhostMarginY12(),
    gap: FortalTokens.space1(),
  ),
  3 => (
    paddingX: FortalTokens.space3(),
    paddingY: FortalTokens.baseButtonGhostPaddingY3(),
    marginX: FortalTokens.baseButtonGhostMarginX3(),
    marginY: FortalTokens.baseButtonGhostMarginY3(),
    gap: FortalTokens.space2(),
  ),
  4 => (
    paddingX: FortalTokens.space4(),
    paddingY: FortalTokens.space2(),
    marginX: FortalTokens.baseButtonGhostMarginX4(),
    marginY: FortalTokens.baseButtonGhostMarginY4(),
    gap: FortalTokens.space2(),
  ),
  _ => throw ArgumentError.value(size, 'size', 'Expected a size from 1 to 4.'),
};

/// Content-box metrics for the ghost IconButton variant.
({double padding, double margin}) fortalIconButtonGhostMetrics(int size) =>
    switch (size) {
      1 => (
        padding: FortalTokens.space1(),
        margin: FortalTokens.iconButtonGhostMargin1(),
      ),
      2 => (
        padding: FortalTokens.iconButtonGhostPadding2(),
        margin: FortalTokens.iconButtonGhostMargin2(),
      ),
      3 => (
        padding: FortalTokens.space2(),
        margin: FortalTokens.iconButtonGhostMargin3(),
      ),
      4 => (
        padding: FortalTokens.space3(),
        margin: FortalTokens.iconButtonGhostMargin4(),
      ),
      _ => throw ArgumentError.value(
        size,
        'size',
        'Expected a size from 1 to 4.',
      ),
    };

/// A CSS outline that does not affect layout.
RemixBoxEffectsMix fortalFocusOutline(Color color, {required double offset}) =>
    RemixBoxEffectsMix(
      outline: BorderSideMix(
        color: color,
        width: 2,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      outlineOffset: offset,
    );

/// A one-pixel inset stroke, optionally layered over a fill.
RemixBoxEffectLayerMix fortalInsetSurface({required List<Color> strokes}) =>
    RemixBoxEffectLayerMix(
      shadows: [
        for (final stroke in strokes)
          RemixBoxShadowMix(
            kind: RemixBoxShadowKind.inset,
            color: stroke,
            spreadRadius: 1,
          ),
      ],
    );

/// Resolves a mode-aware ordered CSS filter at the component build context.
WidgetModifierConfig fortalModeAwareFilter({
  required List<RemixCssColorFilterOperation> light,
  required List<RemixCssColorFilterOperation> dark,
}) => WidgetModifierConfig.modifier(
  _FortalModeAwareFilterMix(light: light, dark: dark),
);

/// Explicit identity filter used to clear a higher-priority state filter.
WidgetModifierConfig fortalClearFilter() =>
    fortalModeAwareFilter(light: const [], dark: const []);

/// Exact classic BaseButton surface for a visual state.
RemixBoxEffectLayerMix fortalClassicBaseButtonSurface({
  required bool highContrast,
  bool hovered = false,
  bool pressed = false,
  bool disabled = false,
}) {
  final inset = FortalTokens.baseButtonClassicAfterInset();
  if (disabled) {
    return RemixBoxEffectLayerMix(
      gradients: [
        RemixLinearGradientMix(
          colors: [
            FortalTokens.blackA1(),
            Colors.transparent,
            FortalTokens.whiteA1(),
          ],
          stops: const [-0.2, 0.4, 1],
        ),
        RemixLinearGradientMix(
          colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
        ),
      ],
      gradientInsets: [inset, inset],
      shadowToken: FortalTokens.baseButtonClassicDisabledShadows,
    );
  }

  final baseColor = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accent9();
  final afterColor = hovered && !highContrast
      ? FortalTokens.accent10()
      : baseColor;
  final pseudoGradient = RemixLinearGradientMix(
    colors: [
      highContrast
          ? hovered || pressed
                ? FortalTokens.blackA5()
                : FortalTokens.blackA3()
          : hovered
          ? FortalTokens.blackA2()
          : pressed
          ? FortalTokens.blackA2()
          : FortalTokens.blackA1(),
      Colors.transparent,
      highContrast
          ? pressed
                ? FortalTokens.whiteA3()
                : FortalTokens.whiteA2()
          : hovered || pressed
          ? FortalTokens.whiteA3()
          : FortalTokens.whiteA2(),
    ],
    stops: hovered && !highContrast
        ? const [-0.15, 0.425, 1]
        : const [0, 0.5, 1],
  );
  final gradients = <RemixLinearGradientMix>[
    pseudoGradient,
    RemixLinearGradientMix(colors: [afterColor, afterColor]),
    if (pressed)
      RemixLinearGradientMix(
        colors: [FortalTokens.blackA1(), Colors.transparent],
      )
    else ...[
      RemixLinearGradientMix(
        colors: [
          Colors.transparent,
          Colors.transparent,
          FortalTokens.grayA4(),
          FortalTokens.grayA4(),
        ],
        stops: const [0, 0.5, 0.5, 1],
      ),
      RemixLinearGradientMix(
        colors: [Colors.transparent, Colors.transparent, baseColor, baseColor],
        stops: const [0, 0.5, 0.8, 1],
      ),
    ],
  ];
  return RemixBoxEffectLayerMix(
    gradients: gradients,
    gradientInsets: [inset, inset, ...List.filled(gradients.length - 2, 0)],
    shadowToken: pressed
        ? highContrast
              ? FortalTokens.baseButtonClassicActiveHighContrastShadows
              : FortalTokens.baseButtonClassicActiveShadows
        : highContrast
        ? FortalTokens.baseButtonClassicHighContrastShadows
        : FortalTokens.baseButtonClassicShadows,
  );
}

final class _FortalModeAwareFilterMix
    extends ModifierMix<RemixOrderedColorFilterModifier> {
  const _FortalModeAwareFilterMix({required this.light, required this.dark});

  final List<RemixCssColorFilterOperation> light;
  final List<RemixCssColorFilterOperation> dark;

  @override
  RemixOrderedColorFilterModifier resolve(BuildContext context) =>
      RemixOrderedColorFilterModifier(
        FortalTheme.of(context).isDark ? dark : light,
      );

  @override
  _FortalModeAwareFilterMix merge(_FortalModeAwareFilterMix? other) =>
      other ?? this;

  @override
  List<Object?> get props => [light, dark];
}
