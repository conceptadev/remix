part of 'button.dart';

/// Radix Themes Button size presets.
enum FortalButtonSize { size1, size2, size3, size4 }

/// Radix Themes Button variants.
enum FortalButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal recipe for [RemixButton].
ButtonStyler fortalButtonStyler({
  FortalButtonVariant variant = .solid,
  FortalButtonSize size = .size2,
  bool highContrast = false,
}) {
  final index = size.index + 1;
  final base = _fortalButtonBaseStyler(variant, index);
  final focus = fortalFocusOutline(
    variant == .soft ? FortalTokens.accent8() : FortalTokens.focus8(),
    offset: variant == .classic || variant == .solid ? 2 : -1,
  );
  final disabledFocus = RemixSurfaceEffectsMix(
    outline: BorderSideMix(style: BorderStyle.none),
  );

  return switch (variant) {
        .classic => _fortalButtonClassic(
          base,
          size: index,
          highContrast: highContrast,
        ),
        .solid => _fortalButtonSolid(base, highContrast: highContrast),
        .soft => _fortalButtonSoft(base, highContrast: highContrast),
        .surface => _fortalButtonSurface(base, highContrast: highContrast),
        .outline => _fortalButtonOutline(base, highContrast: highContrast),
        .ghost => _fortalButtonGhost(base, highContrast: highContrast),
      }
      .onFocused(ButtonStyler().effects(focus))
      .onDisabled(ButtonStyler().effects(disabledFocus));
}

ButtonStyler _fortalButtonBaseStyler(FortalButtonVariant variant, int size) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = ButtonStyler(
    container: FlexBoxStyler(
      direction: .horizontal,
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      spacing: metrics.gap,
    ),
    label: TextStyler(style: metrics.text.mix()).fontWeight(
      variant == .ghost
          ? FortalTokens.fontWeightRegular()
          : FortalTokens.fontWeightMedium(),
    ),
    spinner: RemixSpinnerStyler(
      size: metrics.spinnerSize,
      opacity: 0.65,
      duration: const Duration(milliseconds: 800),
    ),
  ).borderRadiusAll(metrics.radius);

  if (variant == .ghost) {
    final ghost = fortalBaseButtonGhostMetrics(size);
    style = style
        .spacing(ghost.gap)
        .paddingOnly(horizontal: ghost.paddingX, vertical: ghost.paddingY)
        .marginOnly(horizontal: ghost.marginX, vertical: ghost.marginY);
  } else {
    style = style
        .height(metrics.height)
        .paddingX(metrics.paddingX)
        .icon(IconStyler(opacity: 0.9));
  }
  return style;
}

ButtonStyler _fortalButtonClassic(
  ButtonStyler base, {
  required int size,
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  final activePadding = size == 1 ? 1.0 : 2.0;
  return _fortalButtonForeground(base, foreground)
      .color(highContrast ? FortalTokens.accent12() : FortalTokens.accent9())
      .effects(
        RemixSurfaceEffectsMix(
          background: fortalClassicBaseButtonSurface(
            highContrast: highContrast,
          ),
        ),
      )
      .onHovered(
        ButtonStyler()
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalClassicBaseButtonSurface(
                  highContrast: highContrast,
                  hovered: true,
                ),
              ),
            )
            .wrap(
              highContrast
                  ? fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.contrast(0.88),
                        RemixCssColorFilterOperation.saturate(1.1),
                        RemixCssColorFilterOperation.brightness(1.1),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.contrast(0.88),
                        RemixCssColorFilterOperation.saturate(1.3),
                        RemixCssColorFilterOperation.brightness(1.14),
                      ],
                    )
                  : fortalClearFilter(),
            ),
      )
      .onPressed(
        ButtonStyler()
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalClassicBaseButtonSurface(
                  highContrast: highContrast,
                  pressed: true,
                ),
              ),
            )
            .paddingTop(activePadding)
            .wrap(
              highContrast
                  ? fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.contrast(0.82),
                        RemixCssColorFilterOperation.saturate(1.2),
                        RemixCssColorFilterOperation.brightness(1.16),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(0.95),
                        RemixCssColorFilterOperation.saturate(1.2),
                      ],
                    )
                  : fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.brightness(0.92),
                        RemixCssColorFilterOperation.saturate(1.1),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(1.08),
                      ],
                    ),
            ),
      )
      .onDisabled(
        _fortalButtonForeground(ButtonStyler(), FortalTokens.grayA8())
            .color(FortalTokens.gray2())
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalClassicBaseButtonSurface(
                  highContrast: false,
                  disabled: true,
                ),
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

ButtonStyler _fortalButtonSolid(
  ButtonStyler base, {
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  final idle = highContrast ? FortalTokens.accent12() : FortalTokens.accent9();
  return _fortalButtonForeground(base, foreground)
      .color(idle)
      .onHovered(
        ButtonStyler()
            .color(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
            )
            .wrap(
              highContrast
                  ? fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.contrast(0.88),
                        RemixCssColorFilterOperation.saturate(1.1),
                        RemixCssColorFilterOperation.brightness(1.1),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.contrast(0.88),
                        RemixCssColorFilterOperation.saturate(1.3),
                        RemixCssColorFilterOperation.brightness(1.18),
                      ],
                    )
                  : fortalClearFilter(),
            ),
      )
      .onPressed(
        ButtonStyler()
            .color(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
            )
            .wrap(
              highContrast
                  ? fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.contrast(0.82),
                        RemixCssColorFilterOperation.saturate(1.2),
                        RemixCssColorFilterOperation.brightness(1.16),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(0.95),
                        RemixCssColorFilterOperation.saturate(1.2),
                      ],
                    )
                  : fortalModeAwareFilter(
                      light: const [
                        RemixCssColorFilterOperation.brightness(0.92),
                        RemixCssColorFilterOperation.saturate(1.1),
                      ],
                      dark: const [
                        RemixCssColorFilterOperation.brightness(1.08),
                      ],
                    ),
            ),
      )
      .onDisabled(
        _fortalButtonForeground(ButtonStyler(), FortalTokens.grayA8())
            .color(FortalTokens.grayA3())
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

ButtonStyler _fortalButtonSoft(
  ButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentA3())
        .onHovered(ButtonStyler().color(FortalTokens.accentA4()))
        .onPressed(ButtonStyler().color(FortalTokens.accentA5()))
        .onDisabled(_fortalButtonDisabledFill());

ButtonStyler _fortalButtonSurface(
  ButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentSurface())
        .effects(
          RemixSurfaceEffectsMix(
            background: fortalInsetSurface(strokes: [FortalTokens.accentA7()]),
          ),
        )
        .onHovered(
          ButtonStyler()
              .color(FortalTokens.accentSurface())
              .effects(
                RemixSurfaceEffectsMix(
                  background: fortalInsetSurface(
                    strokes: [FortalTokens.accentA8()],
                  ),
                ),
              ),
        )
        .onPressed(
          ButtonStyler()
              .color(FortalTokens.accentA3())
              .effects(
                RemixSurfaceEffectsMix(
                  background: fortalInsetSurface(
                    strokes: [FortalTokens.accentA8()],
                  ),
                ),
              ),
        )
        .onDisabled(
          _fortalButtonForeground(ButtonStyler(), FortalTokens.grayA8())
              .color(FortalTokens.grayA2())
              .effects(
                RemixSurfaceEffectsMix(
                  background: fortalInsetSurface(
                    strokes: [FortalTokens.grayA6()],
                  ),
                ),
              )
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

ButtonStyler _fortalButtonOutline(
  ButtonStyler base, {
  required bool highContrast,
}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  return _fortalButtonForeground(
        base,
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      )
      .effects(
        RemixSurfaceEffectsMix(
          background: fortalInsetSurface(strokes: strokes),
        ),
      )
      .onHovered(
        ButtonStyler()
            .color(FortalTokens.accentA2())
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalInsetSurface(strokes: strokes),
              ),
            ),
      )
      .onPressed(
        ButtonStyler()
            .color(FortalTokens.accentA3())
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalInsetSurface(strokes: strokes),
              ),
            ),
      )
      .onDisabled(
        _fortalButtonForeground(ButtonStyler(), FortalTokens.grayA8())
            .color(Colors.transparent)
            .effects(
              RemixSurfaceEffectsMix(
                background: fortalInsetSurface(
                  strokes: [FortalTokens.grayA7()],
                ),
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1)),
      );
}

ButtonStyler _fortalButtonGhost(
  ButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(Colors.transparent)
        .onHovered(ButtonStyler().color(FortalTokens.accentA3()))
        .onPressed(ButtonStyler().color(FortalTokens.accentA4()))
        .onDisabled(
          _fortalButtonForeground(
            ButtonStyler(),
            FortalTokens.grayA8(),
          ).color(Colors.transparent).spinner(RemixSpinnerStyler().opacity(1)),
        );

ButtonStyler _fortalButtonDisabledFill() => _fortalButtonForeground(
  ButtonStyler(),
  FortalTokens.grayA8(),
).color(FortalTokens.grayA3()).spinner(RemixSpinnerStyler().opacity(1));

ButtonStyler _fortalButtonForeground(ButtonStyler style, Color color) => style
    .label(TextStyler().color(color))
    .icon(IconStyler(color: color))
    .spinner(RemixSpinnerStyler().color(color));

/// Fortal-themed Button with the Radix size, variant, and override contract.
class FortalButton extends StatelessWidget {
  const FortalButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  final FortalButtonVariant variant;
  final FortalButtonSize size;
  final FortalAccentColor? color;
  final FortalRadius? radius;
  final bool highContrast;
  final Widget child;
  final RemixButtonLoadingBuilder? loadingBuilder;
  final bool loading;
  final bool enabled;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: color,
      radius: radius,
      child:
          fortalButtonStyler(
            variant: variant,
            size: size,
            highContrast: highContrast,
          ).call(
            key: key,
            child: child,
            loadingBuilder: loadingBuilder,
            loading: loading,
            enabled: enabled,
            onPressed: onPressed,
            onLongPress: onLongPress,
            focusNode: focusNode,
            autofocus: autofocus,
            enableFeedback: enableFeedback,
            semanticLabel: semanticLabel,
            semanticHint: semanticHint,
            excludeSemantics: excludeSemantics,
            mouseCursor: mouseCursor,
          ),
    );
  }
}
