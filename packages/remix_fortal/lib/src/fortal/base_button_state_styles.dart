import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'base_button_recipe.dart';
import 'fortal_theme.dart';

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
