import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

/// The Radix BaseButton size scale shared by Button and IconButton.
///
/// Deliberate: this mirrors [UiBaseButtonVariant]. Button and IconButton
/// each own a size enum, so the shared metrics need a common type — passing the
/// raw `size.index + 1` instead would drop every switch below to a wildcard and
/// defer an unknown size to a runtime throw.
enum UiBaseButtonSize { size1, size2, size3, size4 }

/// Shared Radix BaseButton metrics used by Button and IconButton recipes.
({
  double height,
  double paddingX,
  double gap,
  Radius radius,
  TextStyleToken text,
  double spinnerSize,
})
uiBaseButtonMetrics(UiBaseButtonSize size) => switch (size) {
  .size1 => (
    height: UiTokens.space5(),
    paddingX: UiTokens.space2(),
    gap: UiTokens.space1(),
    radius: UiTokens.radius1OrFull(),
    text: UiTokens.text1,
    spinnerSize: UiTokens.space3(),
  ),
  .size2 => (
    height: UiTokens.space6(),
    paddingX: UiTokens.space3(),
    gap: UiTokens.space2(),
    radius: UiTokens.radius2OrFull(),
    text: UiTokens.text2,
    spinnerSize: UiTokens.space4(),
  ),
  .size3 => (
    height: UiTokens.space7(),
    paddingX: UiTokens.space4(),
    gap: UiTokens.space3(),
    radius: UiTokens.radius3OrFull(),
    text: UiTokens.text3,
    spinnerSize: UiTokens.space4(),
  ),
  .size4 => (
    height: UiTokens.space8(),
    paddingX: UiTokens.space5(),
    gap: UiTokens.space3(),
    radius: UiTokens.radius4OrFull(),
    text: UiTokens.text4,
    spinnerSize: UiTokens.spinnerSize3(),
  ),
};

/// Default icon dimensions shared by text and icon-only button presets.
double uiBaseButtonIconSize(UiBaseButtonSize size) => switch (size) {
  .size1 => UiTokens.space3(),
  .size2 => UiTokens.space4(),
  .size3 => UiTokens.spinnerSize3(),
  .size4 => UiTokens.space5(),
};

/// Content-box metrics for the ghost BaseButton variant.
({double paddingX, double paddingY, double marginX, double marginY, double gap})
uiBaseButtonGhostMetrics(UiBaseButtonSize size) => switch (size) {
  .size1 => (
    paddingX: UiTokens.space2(),
    paddingY: UiTokens.space1(),
    marginX: UiTokens.baseButtonGhostMarginX12(),
    marginY: UiTokens.baseButtonGhostMarginY12(),
    gap: UiTokens.space1(),
  ),
  .size2 => (
    paddingX: UiTokens.space2(),
    paddingY: UiTokens.space1(),
    marginX: UiTokens.baseButtonGhostMarginX12(),
    marginY: UiTokens.baseButtonGhostMarginY12(),
    gap: UiTokens.space1(),
  ),
  .size3 => (
    paddingX: UiTokens.space3(),
    paddingY: UiTokens.baseButtonGhostPaddingY3(),
    marginX: UiTokens.baseButtonGhostMarginX3(),
    marginY: UiTokens.baseButtonGhostMarginY3(),
    gap: UiTokens.space2(),
  ),
  .size4 => (
    paddingX: UiTokens.space4(),
    paddingY: UiTokens.space2(),
    marginX: UiTokens.baseButtonGhostMarginX4(),
    marginY: UiTokens.baseButtonGhostMarginY4(),
    gap: UiTokens.space2(),
  ),
};

/// Content-box metrics for the ghost IconButton variant.
({double padding, double margin}) uiIconButtonGhostMetrics(
  UiBaseButtonSize size,
) => switch (size) {
  .size1 => (
    padding: UiTokens.space1(),
    margin: UiTokens.iconButtonGhostMargin1(),
  ),
  .size2 => (
    padding: UiTokens.iconButtonGhostPadding2(),
    margin: UiTokens.iconButtonGhostMargin2(),
  ),
  .size3 => (
    padding: UiTokens.space2(),
    margin: UiTokens.iconButtonGhostMargin3(),
  ),
  .size4 => (
    padding: UiTokens.space3(),
    margin: UiTokens.iconButtonGhostMargin4(),
  ),
};

/// Resolves a mode-aware ordered CSS filter at the component build context.
WidgetModifierConfig uiModeAwareFilter({
  required List<RemixCssColorFilterOperation> light,
  required List<RemixCssColorFilterOperation> dark,
}) => WidgetModifierConfig.modifier(
  _UiModeAwareFilterMix(light: light, dark: dark),
);

/// Explicit identity filter used to clear a higher-priority state filter.
WidgetModifierConfig uiClearFilter() =>
    uiModeAwareFilter(light: const [], dark: const []);

/// Exact classic BaseButton surface for a visual state.
RemixBoxEffectLayerMix uiClassicBaseButtonSurface({
  required bool highContrast,
  bool hovered = false,
  bool pressed = false,
  bool disabled = false,
}) {
  final inset = UiTokens.baseButtonClassicAfterInset();
  if (disabled) {
    return RemixBoxEffectLayerMix(
      gradients: [
        RemixLinearGradientMix(
          colors: [
            UiTokens.blackA1(),
            const Color(0x00000000),
            UiTokens.whiteA1(),
          ],
          stops: const [-0.2, 0.4, 1],
        ),
        RemixLinearGradientMix(colors: [UiTokens.grayA2(), UiTokens.grayA2()]),
      ],
      gradientInsets: [inset, inset],
      shadowToken: UiTokens.baseButtonClassicDisabledShadows,
    );
  }

  final baseColor = highContrast ? UiTokens.accent12() : UiTokens.accent9();
  final afterColor = hovered && !highContrast ? UiTokens.accent10() : baseColor;
  final pseudoGradient = RemixLinearGradientMix(
    colors: [
      highContrast
          ? hovered || pressed
                ? UiTokens.blackA5()
                : UiTokens.blackA3()
          : hovered
          ? UiTokens.blackA2()
          : pressed
          ? UiTokens.blackA2()
          : UiTokens.blackA1(),
      const Color(0x00000000),
      highContrast
          ? pressed
                ? UiTokens.whiteA3()
                : UiTokens.whiteA2()
          : hovered || pressed
          ? UiTokens.whiteA3()
          : UiTokens.whiteA2(),
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
        colors: [UiTokens.blackA1(), const Color(0x00000000)],
      )
    else ...[
      RemixLinearGradientMix(
        colors: [
          const Color(0x00000000),
          const Color(0x00000000),
          UiTokens.grayA4(),
          UiTokens.grayA4(),
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
              ? UiTokens.baseButtonClassicActiveHighContrastShadows
              : UiTokens.baseButtonClassicActiveShadows
        : highContrast
        ? UiTokens.baseButtonClassicHighContrastShadows
        : UiTokens.baseButtonClassicShadows,
  );
}

final class _UiModeAwareFilterMix
    extends ModifierMix<RemixOrderedColorFilterModifier> {
  const _UiModeAwareFilterMix({required this.light, required this.dark});

  final List<RemixCssColorFilterOperation> light;
  final List<RemixCssColorFilterOperation> dark;

  @override
  RemixOrderedColorFilterModifier resolve(BuildContext context) =>
      RemixOrderedColorFilterModifier(
        UiTheme.of(context).isDark ? dark : light,
      );

  @override
  _UiModeAwareFilterMix merge(_UiModeAwareFilterMix? other) => other ?? this;

  @override
  List<Object?> get props => [light, dark];
}

/// Shared Radix BaseButton variants implemented by Button and IconButton.
enum UiBaseButtonVariant { classic, solid, soft, surface, outline, ghost }

/// One visual-state style fragment from the shared BaseButton recipe.
final class UiBaseButtonStateStyle {
  const UiBaseButtonStateStyle({
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
final class UiBaseButtonStateStyles {
  const UiBaseButtonStateStyles({
    required this.idle,
    required this.hovered,
    required this.pressed,
    required this.disabled,
    required this.focusVisible,
    required this.disabledFocus,
  });

  final UiBaseButtonStateStyle idle;
  final UiBaseButtonStateStyle hovered;
  final UiBaseButtonStateStyle pressed;
  final UiBaseButtonStateStyle disabled;
  final UiBaseButtonStateStyle focusVisible;
  final UiBaseButtonStateStyle disabledFocus;
}

UiBaseButtonStateStyles uiBaseButtonStateStyles({
  required UiBaseButtonVariant variant,
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
    .soft => UiTokens.accent8(),
    .classic || .solid || .surface || .outline || .ghost => UiTokens.focus8(),
  };
  final focusOffset = switch (variant) {
    .classic || .solid => 2.0,
    .soft || .surface || .outline || .ghost => -1.0,
  };

  return UiBaseButtonStateStyles(
    idle: states.idle,
    hovered: states.hovered,
    pressed: states.pressed,
    disabled: states.disabled,
    focusVisible: UiBaseButtonStateStyle(
      effects: uiFocusOutline(focusColor, offset: focusOffset),
    ),
    disabledFocus: UiBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.outline(
        BorderSideMix(style: BorderStyle.none),
      ),
    ),
  );
}

typedef _InteractionStateStyles = ({
  UiBaseButtonStateStyle idle,
  UiBaseButtonStateStyle hovered,
  UiBaseButtonStateStyle pressed,
  UiBaseButtonStateStyle disabled,
});

_InteractionStateStyles _classicStateStyles({required bool highContrast}) {
  final foreground = highContrast
      ? UiTokens.gray1()
      : UiTokens.accentContrast();

  return (
    idle: UiBaseButtonStateStyle(
      foreground: foreground,
      background: highContrast ? UiTokens.accent12() : UiTokens.accent9(),
      effects: RemixBoxEffectsMix.behindContent(
        uiClassicBaseButtonSurface(highContrast: highContrast),
      ),
    ),
    hovered: UiBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.behindContent(
        uiClassicBaseButtonSurface(highContrast: highContrast, hovered: true),
      ),
      modifier: _hoverFilter(highContrast, classic: true),
    ),
    pressed: UiBaseButtonStateStyle(
      effects: RemixBoxEffectsMix.behindContent(
        uiClassicBaseButtonSurface(highContrast: highContrast, pressed: true),
      ),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: UiBaseButtonStateStyle(
      foreground: UiTokens.grayA8(),
      background: UiTokens.gray2(),
      effects: RemixBoxEffectsMix.behindContent(
        uiClassicBaseButtonSurface(highContrast: false, disabled: true),
      ),
      spinnerOpacity: 1,
      modifier: uiClearFilter(),
    ),
  );
}

_InteractionStateStyles _solidStateStyles({required bool highContrast}) {
  final foreground = highContrast
      ? UiTokens.gray1()
      : UiTokens.accentContrast();

  return (
    idle: UiBaseButtonStateStyle(
      foreground: foreground,
      background: highContrast ? UiTokens.accent12() : UiTokens.accent9(),
    ),
    hovered: UiBaseButtonStateStyle(
      background: highContrast ? UiTokens.accent12() : UiTokens.accent10(),
      modifier: _hoverFilter(highContrast, classic: false),
    ),
    pressed: UiBaseButtonStateStyle(
      background: highContrast ? UiTokens.accent12() : UiTokens.accent10(),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: UiBaseButtonStateStyle(
      foreground: UiTokens.grayA8(),
      background: UiTokens.grayA3(),
      spinnerOpacity: 1,
      modifier: uiClearFilter(),
    ),
  );
}

_InteractionStateStyles _softStateStyles({required bool highContrast}) => (
  idle: UiBaseButtonStateStyle(
    foreground: highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
    background: UiTokens.accentA3(),
  ),
  hovered: UiBaseButtonStateStyle(background: UiTokens.accentA4()),
  pressed: UiBaseButtonStateStyle(background: UiTokens.accentA5()),
  disabled: UiBaseButtonStateStyle(
    foreground: UiTokens.grayA8(),
    background: UiTokens.grayA3(),
    spinnerOpacity: 1,
  ),
);

_InteractionStateStyles _surfaceStateStyles({required bool highContrast}) => (
  idle: UiBaseButtonStateStyle(
    foreground: highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
    background: UiTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      uiInsetSurface(strokes: [UiTokens.accentA7()]),
    ),
  ),
  hovered: UiBaseButtonStateStyle(
    background: UiTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      uiInsetSurface(strokes: [UiTokens.accentA8()]),
    ),
  ),
  pressed: UiBaseButtonStateStyle(
    background: UiTokens.accentA3(),
    effects: RemixBoxEffectsMix.behindContent(
      uiInsetSurface(strokes: [UiTokens.accentA8()]),
    ),
  ),
  disabled: UiBaseButtonStateStyle(
    foreground: UiTokens.grayA8(),
    background: UiTokens.grayA2(),
    effects: RemixBoxEffectsMix.behindContent(
      uiInsetSurface(strokes: [UiTokens.grayA6()]),
    ),
    spinnerOpacity: 1,
  ),
);

_InteractionStateStyles _outlineStateStyles({required bool highContrast}) {
  final strokes = highContrast
      ? [UiTokens.accentA7(), UiTokens.grayA11()]
      : [UiTokens.accentA8()];
  final effects = RemixBoxEffectsMix.behindContent(
    uiInsetSurface(strokes: strokes),
  );

  return (
    idle: UiBaseButtonStateStyle(
      foreground: highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
      effects: effects,
    ),
    hovered: UiBaseButtonStateStyle(
      background: UiTokens.accentA2(),
      effects: effects,
    ),
    pressed: UiBaseButtonStateStyle(
      background: UiTokens.accentA3(),
      effects: effects,
    ),
    disabled: UiBaseButtonStateStyle(
      foreground: UiTokens.grayA8(),
      background: const Color(0x00000000),
      effects: RemixBoxEffectsMix.behindContent(
        uiInsetSurface(strokes: [UiTokens.grayA7()]),
      ),
      spinnerOpacity: 1,
    ),
  );
}

_InteractionStateStyles _ghostStateStyles({required bool highContrast}) => (
  idle: UiBaseButtonStateStyle(
    foreground: highContrast ? UiTokens.accent12() : UiTokens.accentA11(),
    background: const Color(0x00000000),
  ),
  hovered: UiBaseButtonStateStyle(background: UiTokens.accentA3()),
  pressed: UiBaseButtonStateStyle(background: UiTokens.accentA4()),
  disabled: UiBaseButtonStateStyle(
    foreground: UiTokens.grayA8(),
    background: const Color(0x00000000),
    spinnerOpacity: 1,
  ),
);

WidgetModifierConfig _hoverFilter(bool highContrast, {required bool classic}) {
  if (!highContrast) return uiClearFilter();

  return uiModeAwareFilter(
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
    return uiModeAwareFilter(
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

  return uiModeAwareFilter(
    light: const [
      RemixCssColorFilterOperation.brightness(0.92),
      RemixCssColorFilterOperation.saturate(1.1),
    ],
    dark: const [RemixCssColorFilterOperation.brightness(1.08)],
  );
}
