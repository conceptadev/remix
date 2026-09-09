import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import 'base_button.dart';
import '../theme/theme.dart';

part 'icon_button.g.dart';

/// Radix Themes IconButton size presets.
enum FortalIconButtonSize { size1, size2, size3, size4 }

/// Radix Themes IconButton variants.
enum FortalIconButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal-themed IconButton with the Radix size, variant, and override contract.
@MixWidget(target: RemixIconButton.new)
IconButtonStyler fortalIconButtonStyle({
  FortalIconButtonVariant variant = .solid,
  FortalIconButtonSize size = .size2,
  bool highContrast = false,
  IconButtonStyler style = const IconButtonStyler.create(),
}) {
  final base = _fortalIconButtonBaseStyler(
    variant,
    _fortalBaseButtonSize(size),
  );
  final stateStyles = fortalBaseButtonStateStyles(
    variant: _fortalBaseButtonVariant(variant),
    highContrast: highContrast,
  );

  return _applyFortalIconButtonStateStyles(
    base,
    stateStyles,
    pressedPaddingTop: variant == .classic ? (size == .size1 ? 1 : 2) : null,
  ).merge(style);
}

IconButtonStyler _fortalIconButtonBaseStyler(
  FortalIconButtonVariant variant,
  FortalBaseButtonSize size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = IconButtonStyler(
    icon: .size(_fortalIconButtonIconSize(size)),
    spinner: .size(metrics.spinnerSize)
        .opacity(0.65)
        .leafRadius(FortalTokens.radius1())
        .duration(const Duration(milliseconds: 800)),
  ).borderRadius(.all(metrics.radius));

  if (variant == .ghost) {
    final ghost = fortalIconButtonGhostMetrics(size);
    style = style.padding(.all(ghost.padding)).margin(.all(ghost.margin));
  } else {
    style = style
        .container(.alignment(.center))
        .width(metrics.height)
        .height(metrics.height);
  }
  return style;
}

double _fortalIconButtonIconSize(FortalBaseButtonSize size) => switch (size) {
  .size1 => FortalTokens.space3(),
  .size2 => FortalTokens.space4(),
  .size3 => FortalTokens.spinnerSize3(),
  .size4 => FortalTokens.space5(),
};

FortalBaseButtonVariant _fortalBaseButtonVariant(
  FortalIconButtonVariant variant,
) => switch (variant) {
  .classic => .classic,
  .solid => .solid,
  .soft => .soft,
  .surface => .surface,
  .outline => .outline,
  .ghost => .ghost,
};

FortalBaseButtonSize _fortalBaseButtonSize(FortalIconButtonSize size) =>
    switch (size) {
      .size1 => .size1,
      .size2 => .size2,
      .size3 => .size3,
      .size4 => .size4,
    };

IconButtonStyler _applyFortalIconButtonStateStyles(
  IconButtonStyler base,
  FortalBaseButtonStateStyles stateStyles, {
  required double? pressedPaddingTop,
}) {
  var pressed = _applyFortalIconButtonState(
    IconButtonStyler(),
    stateStyles.pressed,
  );
  if (pressedPaddingTop != null) {
    pressed = pressed.padding(.top(pressedPaddingTop));
  }

  return _applyFortalIconButtonState(base, stateStyles.idle)
      .onHovered(
        _applyFortalIconButtonState(IconButtonStyler(), stateStyles.hovered),
      )
      .onPressed(pressed)
      .onDisabled(
        _applyFortalIconButtonState(IconButtonStyler(), stateStyles.disabled),
      )
      .onFocusVisible(
        _applyFortalIconButtonState(
          IconButtonStyler(),
          stateStyles.focusVisible,
        ),
      )
      .onDisabled(
        _applyFortalIconButtonState(
          IconButtonStyler(),
          stateStyles.disabledFocus,
        ),
      );
}

IconButtonStyler _applyFortalIconButtonState(
  IconButtonStyler style,
  FortalBaseButtonStateStyle state,
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
