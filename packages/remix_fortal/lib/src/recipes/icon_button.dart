import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/base_button_policy.dart';
import '../fortal/fortal.dart';

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
}) {
  final index = size.index + 1;
  final base = _fortalIconButtonBaseStyler(variant, index);
  final policy = fortalBaseButtonPolicy(
    variant: _fortalBaseButtonVariant(variant),
    highContrast: highContrast,
  );

  return _applyFortalIconButtonPolicy(
    base,
    policy,
    pressedPaddingTop: variant == .classic ? (index == 1 ? 1 : 2) : null,
  );
}

IconButtonStyler _fortalIconButtonBaseStyler(
  FortalIconButtonVariant variant,
  int size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = IconButtonStyler(
    container: .alignment(Alignment.center),
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
    style = style.width(metrics.height).height(metrics.height);
  }
  return style;
}

double _fortalIconButtonIconSize(int size) => switch (size) {
  1 => FortalTokens.space3(),
  2 => FortalTokens.space4(),
  3 => FortalTokens.spinnerSize3(),
  4 => FortalTokens.space5(),
  _ => throw ArgumentError.value(size, 'size', 'Expected a size from 1 to 4.'),
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

IconButtonStyler _applyFortalIconButtonPolicy(
  IconButtonStyler base,
  FortalBaseButtonPolicy policy, {
  required double? pressedPaddingTop,
}) {
  var pressed = _applyFortalIconButtonState(IconButtonStyler(), policy.pressed);
  if (pressedPaddingTop != null) {
    pressed = pressed.padding(.top(pressedPaddingTop));
  }

  return _applyFortalIconButtonState(base, policy.idle)
      .onHovered(
        _applyFortalIconButtonState(IconButtonStyler(), policy.hovered),
      )
      .onPressed(pressed)
      .onDisabled(
        _applyFortalIconButtonState(IconButtonStyler(), policy.disabled),
      )
      .onFocusVisible(
        _applyFortalIconButtonState(IconButtonStyler(), policy.focusVisible),
      )
      .onDisabled(
        _applyFortalIconButtonState(IconButtonStyler(), policy.disabledFocus),
      );
}

IconButtonStyler _applyFortalIconButtonState(
  IconButtonStyler style,
  FortalBaseButtonStatePolicy state,
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
