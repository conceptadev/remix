import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:remix/remix.dart'
    show
        RemixBoxEffectLayerMix,
        RemixBoxEffectsMix,
        RemixCssColorFilterOperation,
        RemixLinearGradientMix,
        RemixOrderedColorFilterModifier;

import '../theme/theme.dart';

/// The Radix BaseButton size scale shared by Button and IconButton.
///
/// Deliberate: this mirrors [FortalBaseButtonVariant]. Button and IconButton
/// each own a size enum, so the shared metrics need a common type — passing the
/// raw `size.index + 1` instead would drop every switch below to a wildcard and
/// defer an unknown size to a runtime throw.
enum FortalBaseButtonSize { size1, size2, size3, size4 }

/// Shared Radix BaseButton metrics used by Button and IconButton recipes.
({
  double height,
  double paddingX,
  double gap,
  Radius radius,
  TextStyleToken text,
  double spinnerSize,
})
fortalBaseButtonMetrics(FortalBaseButtonSize size) => switch (size) {
  .size1 => (
    height: FortalTokens.space5(),
    paddingX: FortalTokens.space2(),
    gap: FortalTokens.space1(),
    radius: FortalTokens.radius1OrFull(),
    text: FortalTokens.text1,
    spinnerSize: FortalTokens.space3(),
  ),
  .size2 => (
    height: FortalTokens.space6(),
    paddingX: FortalTokens.space3(),
    gap: FortalTokens.space2(),
    radius: FortalTokens.radius2OrFull(),
    text: FortalTokens.text2,
    spinnerSize: FortalTokens.space4(),
  ),
  .size3 => (
    height: FortalTokens.space7(),
    paddingX: FortalTokens.space4(),
    gap: FortalTokens.space3(),
    radius: FortalTokens.radius3OrFull(),
    text: FortalTokens.text3,
    spinnerSize: FortalTokens.space4(),
  ),
  .size4 => (
    height: FortalTokens.space8(),
    paddingX: FortalTokens.space5(),
    gap: FortalTokens.space3(),
    radius: FortalTokens.radius4OrFull(),
    text: FortalTokens.text4,
    spinnerSize: FortalTokens.spinnerSize3(),
  ),
};

/// Content-box metrics for the ghost BaseButton variant.
({double paddingX, double paddingY, double marginX, double marginY, double gap})
fortalBaseButtonGhostMetrics(FortalBaseButtonSize size) => switch (size) {
  .size1 => (
    paddingX: FortalTokens.space2(),
    paddingY: FortalTokens.space1(),
    marginX: FortalTokens.baseButtonGhostMarginX12(),
    marginY: FortalTokens.baseButtonGhostMarginY12(),
    gap: FortalTokens.space1(),
  ),
  .size2 => (
    paddingX: FortalTokens.space2(),
    paddingY: FortalTokens.space1(),
    marginX: FortalTokens.baseButtonGhostMarginX12(),
    marginY: FortalTokens.baseButtonGhostMarginY12(),
    gap: FortalTokens.space1(),
  ),
  .size3 => (
    paddingX: FortalTokens.space3(),
    paddingY: FortalTokens.baseButtonGhostPaddingY3(),
    marginX: FortalTokens.baseButtonGhostMarginX3(),
    marginY: FortalTokens.baseButtonGhostMarginY3(),
    gap: FortalTokens.space2(),
  ),
  .size4 => (
    paddingX: FortalTokens.space4(),
    paddingY: FortalTokens.space2(),
    marginX: FortalTokens.baseButtonGhostMarginX4(),
    marginY: FortalTokens.baseButtonGhostMarginY4(),
    gap: FortalTokens.space2(),
  ),
};

/// Content-box metrics for the ghost IconButton variant.
({double padding, double margin}) fortalIconButtonGhostMetrics(
  FortalBaseButtonSize size,
) => switch (size) {
  .size1 => (
    padding: FortalTokens.space1(),
    margin: FortalTokens.iconButtonGhostMargin1(),
  ),
  .size2 => (
    padding: FortalTokens.iconButtonGhostPadding2(),
    margin: FortalTokens.iconButtonGhostMargin2(),
  ),
  .size3 => (
    padding: FortalTokens.space2(),
    margin: FortalTokens.iconButtonGhostMargin3(),
  ),
  .size4 => (
    padding: FortalTokens.space3(),
    margin: FortalTokens.iconButtonGhostMargin4(),
  ),
};

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
            const Color(0x00000000),
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
      const Color(0x00000000),
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
        colors: [FortalTokens.blackA1(), const Color(0x00000000)],
      )
    else ...[
      RemixLinearGradientMix(
        colors: [
          const Color(0x00000000),
          const Color(0x00000000),
          FortalTokens.grayA4(),
          FortalTokens.grayA4(),
        ],
        stops: const [0, 0.5, 0.5, 1],
      ),
      RemixLinearGradientMix(
        colors: [
          const Color(0x00000000),
          const Color(0x00000000),
          baseColor,
          baseColor,
        ],
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

/// Shared Radix BaseButton variants implemented by Button and IconButton.
enum FortalBaseButtonVariant { classic, solid, soft, surface, outline, ghost }

/// One visual-state style fragment from the shared BaseButton recipe.
final class FortalBaseButtonStateStyle {
  const FortalBaseButtonStateStyle({
    this.foreground,
    this.background,
    this.effects,
    this.modifier,
    this.spinnerOpacity,
  });

  final Color? foreground;
  final Color? background;
  final RemixBoxEffectsMix? effects;
  final WidgetModifierConfig? modifier;
  final double? spinnerOpacity;
}

/// Visual state styles shared by the concrete Button and IconButton stylers.
final class FortalBaseButtonStateStyles {
  const FortalBaseButtonStateStyles({
    required this.idle,
    required this.hovered,
    required this.pressed,
    required this.disabled,
    required this.focusVisible,
    required this.disabledFocus,
  });

  final FortalBaseButtonStateStyle idle;
  final FortalBaseButtonStateStyle hovered;
  final FortalBaseButtonStateStyle pressed;
  final FortalBaseButtonStateStyle disabled;
  final FortalBaseButtonStateStyle focusVisible;
  final FortalBaseButtonStateStyle disabledFocus;
}

FortalBaseButtonStateStyles fortalBaseButtonStateStyles({
  required FortalBaseButtonVariant variant,
  required bool highContrast,
}) {
  final states = switch (variant) {
    .classic => _classicStateStyles(highContrast: highContrast),
    .solid => _solidStateStyles(highContrast: highContrast),
    .soft => _softStateStyles(highContrast: highContrast),
    .surface => _surfaceStateStyles(highContrast: highContrast),
    .outline => _outlineStateStyles(highContrast: highContrast),
    .ghost => _ghostStateStyles(highContrast: highContrast),
  };
  final focusColor = switch (variant) {
    .soft => FortalTokens.accent8(),
    .classic ||
    .solid ||
    .surface ||
    .outline ||
    .ghost => FortalTokens.focus8(),
  };
  final focusOffset = switch (variant) {
    .classic || .solid => 2.0,
    .soft || .surface || .outline || .ghost => -1.0,
  };

  return FortalBaseButtonStateStyles(
    idle: states.idle,
    hovered: states.hovered,
    pressed: states.pressed,
    disabled: states.disabled,
    focusVisible: FortalBaseButtonStateStyle(
      effects: fortalFocusOutline(focusColor, offset: focusOffset),
    ),
    disabledFocus: FortalBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.outline(
        BorderSideMix(style: BorderStyle.none),
      ),
    ),
  );
}

typedef _InteractionStateStyles = ({
  FortalBaseButtonStateStyle idle,
  FortalBaseButtonStateStyle hovered,
  FortalBaseButtonStateStyle pressed,
  FortalBaseButtonStateStyle disabled,
});

_InteractionStateStyles _classicStateStyles({required bool highContrast}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();

  return (
    idle: FortalBaseButtonStateStyle(
      foreground: foreground,
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent9(),
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(highContrast: highContrast),
      ),
    ),
    hovered: FortalBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(
          highContrast: highContrast,
          hovered: true,
        ),
      ),
      modifier: _hoverFilter(highContrast, classic: true),
    ),
    pressed: FortalBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(
          highContrast: highContrast,
          pressed: true,
        ),
      ),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: FortalBaseButtonStateStyle(
      foreground: FortalTokens.grayA8(),
      background: FortalTokens.gray2(),
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(highContrast: false, disabled: true),
      ),
      spinnerOpacity: 1,
      modifier: fortalClearFilter(),
    ),
  );
}

_InteractionStateStyles _solidStateStyles({required bool highContrast}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();

  return (
    idle: FortalBaseButtonStateStyle(
      foreground: foreground,
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent9(),
    ),
    hovered: FortalBaseButtonStateStyle(
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent10(),
      modifier: _hoverFilter(highContrast, classic: false),
    ),
    pressed: FortalBaseButtonStateStyle(
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent10(),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: FortalBaseButtonStateStyle(
      foreground: FortalTokens.grayA8(),
      background: FortalTokens.grayA3(),
      spinnerOpacity: 1,
      modifier: fortalClearFilter(),
    ),
  );
}

_InteractionStateStyles _softStateStyles({required bool highContrast}) => (
  idle: FortalBaseButtonStateStyle(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: FortalTokens.accentA3(),
  ),
  hovered: FortalBaseButtonStateStyle(background: FortalTokens.accentA4()),
  pressed: FortalBaseButtonStateStyle(background: FortalTokens.accentA5()),
  disabled: FortalBaseButtonStateStyle(
    foreground: FortalTokens.grayA8(),
    background: FortalTokens.grayA3(),
    spinnerOpacity: 1,
  ),
);

_InteractionStateStyles _surfaceStateStyles({required bool highContrast}) => (
  idle: FortalBaseButtonStateStyle(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: FortalTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA7()]),
    ),
  ),
  hovered: FortalBaseButtonStateStyle(
    background: FortalTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA8()]),
    ),
  ),
  pressed: FortalBaseButtonStateStyle(
    background: FortalTokens.accentA3(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA8()]),
    ),
  ),
  disabled: FortalBaseButtonStateStyle(
    foreground: FortalTokens.grayA8(),
    background: FortalTokens.grayA2(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.grayA6()]),
    ),
    spinnerOpacity: 1,
  ),
);

_InteractionStateStyles _outlineStateStyles({required bool highContrast}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  final effects = RemixBoxEffectsMix.behindContent(
    fortalInsetSurface(strokes: strokes),
  );

  return (
    idle: FortalBaseButtonStateStyle(
      foreground: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accentA11(),
      effects: effects,
    ),
    hovered: FortalBaseButtonStateStyle(
      background: FortalTokens.accentA2(),
      effects: effects,
    ),
    pressed: FortalBaseButtonStateStyle(
      background: FortalTokens.accentA3(),
      effects: effects,
    ),
    disabled: FortalBaseButtonStateStyle(
      foreground: FortalTokens.grayA8(),
      background: const Color(0x00000000),
      effects: RemixBoxEffectsMix.behindContent(
        fortalInsetSurface(strokes: [FortalTokens.grayA7()]),
      ),
      spinnerOpacity: 1,
    ),
  );
}

_InteractionStateStyles _ghostStateStyles({required bool highContrast}) => (
  idle: FortalBaseButtonStateStyle(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: const Color(0x00000000),
  ),
  hovered: FortalBaseButtonStateStyle(background: FortalTokens.accentA3()),
  pressed: FortalBaseButtonStateStyle(background: FortalTokens.accentA4()),
  disabled: FortalBaseButtonStateStyle(
    foreground: FortalTokens.grayA8(),
    background: const Color(0x00000000),
    spinnerOpacity: 1,
  ),
);

WidgetModifierConfig _hoverFilter(bool highContrast, {required bool classic}) {
  if (!highContrast) return fortalClearFilter();

  return fortalModeAwareFilter(
    light: const [
      RemixCssColorFilterOperation.contrast(0.88),
      RemixCssColorFilterOperation.saturate(1.1),
      RemixCssColorFilterOperation.brightness(1.1),
    ],
    dark: [
      const RemixCssColorFilterOperation.contrast(0.88),
      const RemixCssColorFilterOperation.saturate(1.3),
      RemixCssColorFilterOperation.brightness(classic ? 1.14 : 1.18),
    ],
  );
}

WidgetModifierConfig _pressedFilter(bool highContrast) {
  if (highContrast) {
    return fortalModeAwareFilter(
      light: const [
        RemixCssColorFilterOperation.contrast(0.82),
        RemixCssColorFilterOperation.saturate(1.2),
        RemixCssColorFilterOperation.brightness(1.16),
      ],
      dark: const [
        RemixCssColorFilterOperation.brightness(0.95),
        RemixCssColorFilterOperation.saturate(1.2),
      ],
    );
  }

  return fortalModeAwareFilter(
    light: const [
      RemixCssColorFilterOperation.brightness(0.92),
      RemixCssColorFilterOperation.saturate(1.1),
    ],
    dark: const [RemixCssColorFilterOperation.brightness(1.08)],
  );
}
