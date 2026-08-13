import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'base_button_recipe.dart';
import 'fortal_theme.dart';

/// Shared Radix BaseButton variants implemented by Button and IconButton.
enum FortalBaseButtonVariant { classic, solid, soft, surface, outline, ghost }

/// One resolved visual-state fragment from the shared BaseButton recipe.
final class FortalBaseButtonStatePolicy {
  const FortalBaseButtonStatePolicy({
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

/// State policy shared by the concrete Button and IconButton stylers.
final class FortalBaseButtonPolicy {
  const FortalBaseButtonPolicy({
    required this.idle,
    required this.hovered,
    required this.pressed,
    required this.disabled,
    required this.focusVisible,
    required this.disabledFocus,
  });

  final FortalBaseButtonStatePolicy idle;
  final FortalBaseButtonStatePolicy hovered;
  final FortalBaseButtonStatePolicy pressed;
  final FortalBaseButtonStatePolicy disabled;
  final FortalBaseButtonStatePolicy focusVisible;
  final FortalBaseButtonStatePolicy disabledFocus;
}

FortalBaseButtonPolicy fortalBaseButtonPolicy({
  required FortalBaseButtonVariant variant,
  required bool highContrast,
}) {
  final states = switch (variant) {
    .classic => _classicPolicy(highContrast: highContrast),
    .solid => _solidPolicy(highContrast: highContrast),
    .soft => _softPolicy(highContrast: highContrast),
    .surface => _surfacePolicy(highContrast: highContrast),
    .outline => _outlinePolicy(highContrast: highContrast),
    .ghost => _ghostPolicy(highContrast: highContrast),
  };
  final focusColor = variant == .soft
      ? FortalTokens.accent8()
      : FortalTokens.focus8();
  final focusOffset = variant == .classic || variant == .solid ? 2.0 : -1.0;

  return FortalBaseButtonPolicy(
    idle: states.idle,
    hovered: states.hovered,
    pressed: states.pressed,
    disabled: states.disabled,
    focusVisible: FortalBaseButtonStatePolicy(
      effects: fortalFocusOutline(focusColor, offset: focusOffset),
    ),
    disabledFocus: FortalBaseButtonStatePolicy(
      effects: RemixBoxEffectsMix.outline(
        BorderSideMix(style: BorderStyle.none),
      ),
    ),
  );
}

typedef _InteractionStates = ({
  FortalBaseButtonStatePolicy idle,
  FortalBaseButtonStatePolicy hovered,
  FortalBaseButtonStatePolicy pressed,
  FortalBaseButtonStatePolicy disabled,
});

_InteractionStates _classicPolicy({required bool highContrast}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();

  return (
    idle: FortalBaseButtonStatePolicy(
      foreground: foreground,
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent9(),
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(highContrast: highContrast),
      ),
    ),
    hovered: FortalBaseButtonStatePolicy(
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(
          highContrast: highContrast,
          hovered: true,
        ),
      ),
      modifier: _hoverFilter(highContrast, classic: true),
    ),
    pressed: FortalBaseButtonStatePolicy(
      effects: RemixBoxEffectsMix.behindContent(
        fortalClassicBaseButtonSurface(
          highContrast: highContrast,
          pressed: true,
        ),
      ),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: FortalBaseButtonStatePolicy(
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

_InteractionStates _solidPolicy({required bool highContrast}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();

  return (
    idle: FortalBaseButtonStatePolicy(
      foreground: foreground,
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent9(),
    ),
    hovered: FortalBaseButtonStatePolicy(
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent10(),
      modifier: _hoverFilter(highContrast, classic: false),
    ),
    pressed: FortalBaseButtonStatePolicy(
      background: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accent10(),
      modifier: _pressedFilter(highContrast),
    ),
    disabled: FortalBaseButtonStatePolicy(
      foreground: FortalTokens.grayA8(),
      background: FortalTokens.grayA3(),
      spinnerOpacity: 1,
      modifier: fortalClearFilter(),
    ),
  );
}

_InteractionStates _softPolicy({required bool highContrast}) => (
  idle: FortalBaseButtonStatePolicy(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: FortalTokens.accentA3(),
  ),
  hovered: FortalBaseButtonStatePolicy(background: FortalTokens.accentA4()),
  pressed: FortalBaseButtonStatePolicy(background: FortalTokens.accentA5()),
  disabled: FortalBaseButtonStatePolicy(
    foreground: FortalTokens.grayA8(),
    background: FortalTokens.grayA3(),
    spinnerOpacity: 1,
  ),
);

_InteractionStates _surfacePolicy({required bool highContrast}) => (
  idle: FortalBaseButtonStatePolicy(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: FortalTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA7()]),
    ),
  ),
  hovered: FortalBaseButtonStatePolicy(
    background: FortalTokens.accentSurface(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA8()]),
    ),
  ),
  pressed: FortalBaseButtonStatePolicy(
    background: FortalTokens.accentA3(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.accentA8()]),
    ),
  ),
  disabled: FortalBaseButtonStatePolicy(
    foreground: FortalTokens.grayA8(),
    background: FortalTokens.grayA2(),
    effects: RemixBoxEffectsMix.behindContent(
      fortalInsetSurface(strokes: [FortalTokens.grayA6()]),
    ),
    spinnerOpacity: 1,
  ),
);

_InteractionStates _outlinePolicy({required bool highContrast}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  final effects = RemixBoxEffectsMix.behindContent(
    fortalInsetSurface(strokes: strokes),
  );

  return (
    idle: FortalBaseButtonStatePolicy(
      foreground: highContrast
          ? FortalTokens.accent12()
          : FortalTokens.accentA11(),
      effects: effects,
    ),
    hovered: FortalBaseButtonStatePolicy(
      background: FortalTokens.accentA2(),
      effects: effects,
    ),
    pressed: FortalBaseButtonStatePolicy(
      background: FortalTokens.accentA3(),
      effects: effects,
    ),
    disabled: FortalBaseButtonStatePolicy(
      foreground: FortalTokens.grayA8(),
      background: const Color(0x00000000),
      effects: RemixBoxEffectsMix.behindContent(
        fortalInsetSurface(strokes: [FortalTokens.grayA7()]),
      ),
      spinnerOpacity: 1,
    ),
  );
}

_InteractionStates _ghostPolicy({required bool highContrast}) => (
  idle: FortalBaseButtonStatePolicy(
    foreground: highContrast
        ? FortalTokens.accent12()
        : FortalTokens.accentA11(),
    background: const Color(0x00000000),
  ),
  hovered: FortalBaseButtonStatePolicy(background: FortalTokens.accentA3()),
  pressed: FortalBaseButtonStatePolicy(background: FortalTokens.accentA4()),
  disabled: FortalBaseButtonStatePolicy(
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
