import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/base_button_state_styles.dart';
import '../fortal/fortal.dart';

part 'button.g.dart';

/// Radix Themes Button size presets.
enum FortalButtonSize { size1, size2, size3, size4 }

/// Radix Themes Button variants.
enum FortalButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal-themed Button with the Radix size, variant, and override contract.
@MixWidget(target: RemixButton.new)
ButtonStyler fortalButtonStyle({
  FortalButtonVariant variant = .solid,
  FortalButtonSize size = .size2,
  bool highContrast = false,
}) {
  final base = _fortalButtonBaseStyler(variant, _fortalBaseButtonSize(size));
  final stateStyles = fortalBaseButtonStateStyles(
    variant: _fortalBaseButtonVariant(variant),
    highContrast: highContrast,
  );

  return _applyFortalButtonStateStyles(
    base,
    stateStyles,
    pressedPaddingTop: variant == .classic ? (size == .size1 ? 1 : 2) : null,
  );
}

ButtonStyler _fortalButtonBaseStyler(
  FortalButtonVariant variant,
  FortalBaseButtonSize size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = ButtonStyler(
    container: .direction(.horizontal)
        .mainAxisAlignment(.center)
        .mainAxisSize(.min)
        .crossAxisAlignment(.center)
        .spacing(metrics.gap),
    label: .style(metrics.text.mix()).fontWeight(
      variant == .ghost
          ? FortalTokens.fontWeightRegular()
          : FortalTokens.fontWeightMedium(),
    ),
    spinner: .size(metrics.spinnerSize)
        .opacity(0.65)
        .leafRadius(FortalTokens.radius1())
        .duration(const Duration(milliseconds: 800)),
  ).borderRadius(.all(metrics.radius));

  if (variant == .ghost) {
    final ghost = fortalBaseButtonGhostMetrics(size);
    style = style
        .spacing(ghost.gap)
        .padding(
          .symmetric(horizontal: ghost.paddingX, vertical: ghost.paddingY),
        )
        .margin(.symmetric(horizontal: ghost.marginX, vertical: ghost.marginY));
  } else {
    style = style
        .minHeight(metrics.height)
        .padding(.horizontal(metrics.paddingX))
        .icon(.opacity(0.9));
  }
  return style;
}

FortalBaseButtonVariant _fortalBaseButtonVariant(FortalButtonVariant variant) =>
    switch (variant) {
      .classic => .classic,
      .solid => .solid,
      .soft => .soft,
      .surface => .surface,
      .outline => .outline,
      .ghost => .ghost,
    };

FortalBaseButtonSize _fortalBaseButtonSize(FortalButtonSize size) =>
    switch (size) {
      .size1 => .size1,
      .size2 => .size2,
      .size3 => .size3,
      .size4 => .size4,
    };

ButtonStyler _applyFortalButtonStateStyles(
  ButtonStyler base,
  FortalBaseButtonStateStyles stateStyles, {
  required double? pressedPaddingTop,
}) {
  var pressed = _applyFortalButtonState(ButtonStyler(), stateStyles.pressed);
  if (pressedPaddingTop != null) {
    pressed = pressed.padding(.top(pressedPaddingTop));
  }

  return _applyFortalButtonState(base, stateStyles.idle)
      .onHovered(_applyFortalButtonState(ButtonStyler(), stateStyles.hovered))
      .onPressed(pressed)
      .onDisabled(_applyFortalButtonState(ButtonStyler(), stateStyles.disabled))
      .onFocusVisible(
        _applyFortalButtonState(ButtonStyler(), stateStyles.focusVisible),
      )
      .onDisabled(
        _applyFortalButtonState(ButtonStyler(), stateStyles.disabledFocus),
      );
}

ButtonStyler _applyFortalButtonState(
  ButtonStyler style,
  FortalBaseButtonStateStyle state,
) {
  var result = style;
  final foreground = state.foreground;
  if (foreground != null) {
    result = result
        .label(.color(foreground))
        .icon(.color(foreground))
        .spinner(.color(foreground));
  }
  if (state.background != null) {
    result = result.color(state.background!);
  }
  if (state.effects != null) {
    result = result.containerEffects(state.effects!);
  }
  if (state.spinnerOpacity != null) {
    result = result.spinner(.opacity(state.spinnerOpacity!));
  }
  if (state.modifier != null) {
    result = result.wrap(state.modifier!);
  }
  return result;
}
