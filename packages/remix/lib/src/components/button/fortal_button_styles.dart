part of 'button.dart';

/// Radix Themes Button size presets.
enum FortalButtonSize { size1, size2, size3, size4 }

/// Radix Themes Button variants.
enum FortalButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal recipe for [RemixButton].
RemixButtonStyler fortalButtonStyler({
  FortalButtonVariant variant = .solid,
  FortalButtonSize size = .size2,
  bool highContrast = false,
}) {
  final index = size.index + 1;
  final metrics = fortalBaseButtonMetrics(index);
  final base = _fortalButtonBaseStyler(variant, index);
  final focus = fortalFocusOutline(
    metrics.radius,
    variant == .soft ? FortalTokens.accent8() : FortalTokens.focus8(),
    offset: variant == .classic || variant == .solid ? 2 : -1,
  );
  final disabledFocus = RemixSurfaceLayerMix(
    borderRadius: BorderRadiusMix.all(metrics.radius),
    outlineColor: Colors.transparent,
    outlineWidth: 0,
  );

  return switch (variant) {
        .classic => _fortalButtonClassic(
          base,
          metrics.radius,
          size: index,
          highContrast: highContrast,
        ),
        .solid => _fortalButtonSolid(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .soft => _fortalButtonSoft(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .surface => _fortalButtonSurface(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .outline => _fortalButtonOutline(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .ghost => _fortalButtonGhost(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
      }
      .onFocused(RemixButtonStyler().overlay(focus))
      .onDisabled(RemixButtonStyler().overlay(disabledFocus));
}

RemixButtonStyler _fortalButtonBaseStyler(
  FortalButtonVariant variant,
  int size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = RemixButtonStyler(
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

RemixButtonStyler _fortalButtonClassic(
  RemixButtonStyler base,
  Radius radius, {
  required int size,
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  final activePadding = size == 1 ? 1.0 : 2.0;
  return _fortalButtonForeground(base, foreground)
      .surface(
        fortalClassicBaseButtonSurface(
          radius: radius,
          highContrast: highContrast,
        ),
      )
      .onHovered(
        RemixButtonStyler()
            .surface(
              fortalClassicBaseButtonSurface(
                radius: radius,
                highContrast: highContrast,
                hovered: true,
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
        RemixButtonStyler()
            .surface(
              fortalClassicBaseButtonSurface(
                radius: radius,
                highContrast: highContrast,
                pressed: true,
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
        _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
            .surface(
              fortalClassicBaseButtonSurface(
                radius: radius,
                highContrast: false,
                disabled: true,
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

RemixButtonStyler _fortalButtonSolid(
  RemixButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  final idle = highContrast ? FortalTokens.accent12() : FortalTokens.accent9();
  return _fortalButtonForeground(base, foreground)
      .surface(_fortalButtonFill(idle, radius))
      .onHovered(
        RemixButtonStyler()
            .surface(
              _fortalButtonFill(
                highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accent10(),
                radius,
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
                        RemixCssColorFilterOperation.brightness(1.18),
                      ],
                    )
                  : fortalClearFilter(),
            ),
      )
      .onPressed(
        RemixButtonStyler()
            .surface(
              _fortalButtonFill(
                highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accent10(),
                radius,
              ),
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
        _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
            .surface(_fortalButtonFill(FortalTokens.grayA3(), radius))
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

RemixButtonStyler _fortalButtonSoft(
  RemixButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .surface(_fortalButtonFill(FortalTokens.accentA3(), radius))
        .onHovered(
          RemixButtonStyler().surface(
            _fortalButtonFill(FortalTokens.accentA4(), radius),
          ),
        )
        .onPressed(
          RemixButtonStyler().surface(
            _fortalButtonFill(FortalTokens.accentA5(), radius),
          ),
        )
        .onDisabled(_fortalButtonDisabledFill(radius));

RemixButtonStyler _fortalButtonSurface(
  RemixButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .surface(
          fortalInsetSurface(
            radius: radius,
            color: FortalTokens.accentSurface(),
            strokes: [FortalTokens.accentA7()],
          ),
        )
        .onHovered(
          RemixButtonStyler().surface(
            fortalInsetSurface(
              radius: radius,
              color: FortalTokens.accentSurface(),
              strokes: [FortalTokens.accentA8()],
            ),
          ),
        )
        .onPressed(
          RemixButtonStyler().surface(
            fortalInsetSurface(
              radius: radius,
              color: FortalTokens.accentA3(),
              strokes: [FortalTokens.accentA8()],
            ),
          ),
        )
        .onDisabled(
          _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
              .surface(
                fortalInsetSurface(
                  radius: radius,
                  color: FortalTokens.grayA2(),
                  strokes: [FortalTokens.grayA6()],
                ),
              )
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixButtonStyler _fortalButtonOutline(
  RemixButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  return _fortalButtonForeground(
        base,
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      )
      .surface(fortalInsetSurface(radius: radius, strokes: strokes))
      .onHovered(
        RemixButtonStyler().surface(
          fortalInsetSurface(
            radius: radius,
            color: FortalTokens.accentA2(),
            strokes: strokes,
          ),
        ),
      )
      .onPressed(
        RemixButtonStyler().surface(
          fortalInsetSurface(
            radius: radius,
            color: FortalTokens.accentA3(),
            strokes: strokes,
          ),
        ),
      )
      .onDisabled(
        _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
            .surface(
              fortalInsetSurface(
                radius: radius,
                color: Colors.transparent,
                strokes: [FortalTokens.grayA7()],
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1)),
      );
}

RemixButtonStyler _fortalButtonGhost(
  RemixButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .surface(_fortalButtonFill(Colors.transparent, radius))
        .onHovered(
          RemixButtonStyler().surface(
            _fortalButtonFill(FortalTokens.accentA3(), radius),
          ),
        )
        .onPressed(
          RemixButtonStyler().surface(
            _fortalButtonFill(FortalTokens.accentA4(), radius),
          ),
        )
        .onDisabled(
          _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
              .surface(_fortalButtonFill(Colors.transparent, radius))
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixButtonStyler _fortalButtonDisabledFill(Radius radius) =>
    _fortalButtonForeground(RemixButtonStyler(), FortalTokens.grayA8())
        .surface(_fortalButtonFill(FortalTokens.grayA3(), radius))
        .spinner(RemixSpinnerStyler().opacity(1));

RemixButtonStyler _fortalButtonForeground(
  RemixButtonStyler style,
  Color color,
) => style
    .label(TextStyler().color(color))
    .icon(IconStyler(color: color))
    .spinner(RemixSpinnerStyler().color(color));

RemixSurfaceLayerMix _fortalButtonFill(Color color, Radius radius) =>
    RemixSurfaceLayerMix(
      color: color,
      borderRadius: BorderRadiusMix.all(radius),
    );

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
