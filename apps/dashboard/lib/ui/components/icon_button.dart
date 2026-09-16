import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import 'base_button.dart';
import '../theme/theme.dart';

part 'icon_button.g.dart';

/// Radix Themes IconButton size presets.
enum UiIconButtonSize { size1, size2, size3, size4 }

/// Radix Themes IconButton variants.
enum UiIconButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Ui-themed IconButton with the Radix size, variant, and override contract.
@MixWidget(target: RemixIconButton.new)
IconButtonStyler uiIconButtonStyle({
  UiIconButtonVariant variant = .solid,
  UiIconButtonSize size = .size2,
  bool highContrast = false,
  IconButtonStyler style = const IconButtonStyler.create(),
}) {
  final base = _uiIconButtonBaseStyler(variant, _uiBaseButtonSize(size));
  final stateStyles = uiBaseButtonStateStyles(
    variant: _uiBaseButtonVariant(variant),
    highContrast: highContrast,
  );

  return _applyUiIconButtonStateStyles(
    base,
    stateStyles,
    pressedPaddingTop: variant == .classic ? (size == .size1 ? 1 : 2) : null,
  ).merge(style);
}

IconButtonStyler _uiIconButtonBaseStyler(
  UiIconButtonVariant variant,
  UiBaseButtonSize size,
) {
  final metrics = uiBaseButtonMetrics(size);
  var style = IconButtonStyler(
    icon: .size(uiBaseButtonIconSize(size)),
    spinner: .size(metrics.spinnerSize)
        .opacity(0.65)
        .leafRadius(UiTokens.radius1())
        .duration(const Duration(milliseconds: 800)),
  ).borderRadius(.all(metrics.radius));

  if (variant == .ghost) {
    final ghost = uiIconButtonGhostMetrics(size);
    style = style.padding(.all(ghost.padding)).margin(.all(ghost.margin));
  } else {
    style = style
        .container(.alignment(.center))
        .width(metrics.height)
        .height(metrics.height);
  }
  return style;
}

UiBaseButtonVariant _uiBaseButtonVariant(UiIconButtonVariant variant) =>
    switch (variant) {
      .classic => .classic,
      .solid => .solid,
      .soft => .soft,
      .surface => .surface,
      .outline => .outline,
      .ghost => .ghost,
    };

UiBaseButtonSize _uiBaseButtonSize(UiIconButtonSize size) => switch (size) {
  .size1 => .size1,
  .size2 => .size2,
  .size3 => .size3,
  .size4 => .size4,
};

IconButtonStyler _applyUiIconButtonStateStyles(
  IconButtonStyler base,
  UiBaseButtonStateStyles stateStyles, {
  required double? pressedPaddingTop,
}) {
  var pressed = _applyUiIconButtonState(
    IconButtonStyler(),
    stateStyles.pressed,
  );
  if (pressedPaddingTop != null) {
    pressed = pressed.padding(.top(pressedPaddingTop));
  }

  return _applyUiIconButtonState(base, stateStyles.idle)
      .onHovered(
        _applyUiIconButtonState(IconButtonStyler(), stateStyles.hovered),
      )
      .onPressed(pressed)
      .onDisabled(
        _applyUiIconButtonState(IconButtonStyler(), stateStyles.disabled),
      )
      .onFocusVisible(
        _applyUiIconButtonState(IconButtonStyler(), stateStyles.focusVisible),
      )
      .onDisabled(
        _applyUiIconButtonState(IconButtonStyler(), stateStyles.disabledFocus),
      );
}

IconButtonStyler _applyUiIconButtonState(
  IconButtonStyler style,
  UiBaseButtonStateStyle state,
) {
  var result = style;
  final foreground = state.foreground;
  if (foreground != null) {
    result = result.icon(.color(foreground)).spinner(.color(foreground));
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
