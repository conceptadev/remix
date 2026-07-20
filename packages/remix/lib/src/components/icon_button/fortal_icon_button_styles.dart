part of 'icon_button.dart';

/// Radix Themes IconButton size presets.
enum FortalIconButtonSize { size1, size2, size3, size4 }

/// Radix Themes IconButton variants.
enum FortalIconButtonVariant { classic, solid, soft, surface, outline, ghost }

/// Fortal recipe for [RemixIconButton].
RemixIconButtonStyler fortalIconButtonStyler({
  FortalIconButtonVariant variant = .solid,
  FortalIconButtonSize size = .size2,
  bool highContrast = false,
}) {
  final index = size.index + 1;
  final metrics = fortalBaseButtonMetrics(index);
  final base = _fortalIconButtonBaseStyler(variant, index);
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
        .classic => _fortalIconButtonClassic(
          base,
          metrics.radius,
          size: index,
          highContrast: highContrast,
        ),
        .solid => _fortalIconButtonSolid(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .soft => _fortalIconButtonSoft(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .surface => _fortalIconButtonSurface(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .outline => _fortalIconButtonOutline(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
        .ghost => _fortalIconButtonGhost(
          base,
          metrics.radius,
          highContrast: highContrast,
        ),
      }
      .onFocused(RemixIconButtonStyler().overlay(focus))
      .onDisabled(RemixIconButtonStyler().overlay(disabledFocus));
}

RemixIconButtonStyler _fortalIconButtonBaseStyler(
  FortalIconButtonVariant variant,
  int size,
) {
  final metrics = fortalBaseButtonMetrics(size);
  var style = RemixIconButtonStyler(
    container: BoxStyler(alignment: Alignment.center),
    icon: IconStyler(size: _fortalIconButtonIconSize(size)),
    spinner: RemixSpinnerStyler(
      size: metrics.spinnerSize,
      opacity: 0.65,
      duration: const Duration(milliseconds: 800),
    ),
  ).borderRadiusAll(metrics.radius);

  if (variant == .ghost) {
    final ghost = fortalIconButtonGhostMetrics(size);
    style = style.paddingAll(ghost.padding).marginAll(ghost.margin);
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

RemixIconButtonStyler _fortalIconButtonClassic(
  RemixIconButtonStyler base,
  Radius radius, {
  required int size,
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .surface(
        fortalClassicBaseButtonSurface(
          radius: radius,
          highContrast: highContrast,
        ),
      )
      .onHovered(
        RemixIconButtonStyler()
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
        RemixIconButtonStyler()
            .surface(
              fortalClassicBaseButtonSurface(
                radius: radius,
                highContrast: highContrast,
                pressed: true,
              ),
            )
            .paddingTop(size == 1 ? 1 : 2)
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
        _fortalIconButtonForeground(
              RemixIconButtonStyler(),
              FortalTokens.grayA8(),
            )
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

RemixIconButtonStyler _fortalIconButtonSolid(
  RemixIconButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .surface(
        _fortalIconButtonFill(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          radius,
        ),
      )
      .onHovered(
        RemixIconButtonStyler()
            .surface(
              _fortalIconButtonFill(
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
        RemixIconButtonStyler()
            .surface(
              _fortalIconButtonFill(
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
        _fortalIconButtonForeground(
              RemixIconButtonStyler(),
              FortalTokens.grayA8(),
            )
            .surface(_fortalIconButtonFill(FortalTokens.grayA3(), radius))
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

RemixIconButtonStyler _fortalIconButtonSoft(
  RemixIconButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .surface(_fortalIconButtonFill(FortalTokens.accentA3(), radius))
        .onHovered(
          RemixIconButtonStyler().surface(
            _fortalIconButtonFill(FortalTokens.accentA4(), radius),
          ),
        )
        .onPressed(
          RemixIconButtonStyler().surface(
            _fortalIconButtonFill(FortalTokens.accentA5(), radius),
          ),
        )
        .onDisabled(_fortalIconButtonDisabledFill(radius));

RemixIconButtonStyler _fortalIconButtonSurface(
  RemixIconButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
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
          RemixIconButtonStyler().surface(
            fortalInsetSurface(
              radius: radius,
              color: FortalTokens.accentSurface(),
              strokes: [FortalTokens.accentA8()],
            ),
          ),
        )
        .onPressed(
          RemixIconButtonStyler().surface(
            fortalInsetSurface(
              radius: radius,
              color: FortalTokens.accentA3(),
              strokes: [FortalTokens.accentA8()],
            ),
          ),
        )
        .onDisabled(
          _fortalIconButtonForeground(
                RemixIconButtonStyler(),
                FortalTokens.grayA8(),
              )
              .surface(
                fortalInsetSurface(
                  radius: radius,
                  color: FortalTokens.grayA2(),
                  strokes: [FortalTokens.grayA6()],
                ),
              )
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixIconButtonStyler _fortalIconButtonOutline(
  RemixIconButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  return _fortalIconButtonForeground(
        base,
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      )
      .surface(fortalInsetSurface(radius: radius, strokes: strokes))
      .onHovered(
        RemixIconButtonStyler().surface(
          fortalInsetSurface(
            radius: radius,
            color: FortalTokens.accentA2(),
            strokes: strokes,
          ),
        ),
      )
      .onPressed(
        RemixIconButtonStyler().surface(
          fortalInsetSurface(
            radius: radius,
            color: FortalTokens.accentA3(),
            strokes: strokes,
          ),
        ),
      )
      .onDisabled(
        _fortalIconButtonForeground(
              RemixIconButtonStyler(),
              FortalTokens.grayA8(),
            )
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

RemixIconButtonStyler _fortalIconButtonGhost(
  RemixIconButtonStyler base,
  Radius radius, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .surface(_fortalIconButtonFill(Colors.transparent, radius))
        .onHovered(
          RemixIconButtonStyler().surface(
            _fortalIconButtonFill(FortalTokens.accentA3(), radius),
          ),
        )
        .onPressed(
          RemixIconButtonStyler().surface(
            _fortalIconButtonFill(FortalTokens.accentA4(), radius),
          ),
        )
        .onDisabled(
          _fortalIconButtonForeground(
                RemixIconButtonStyler(),
                FortalTokens.grayA8(),
              )
              .surface(_fortalIconButtonFill(Colors.transparent, radius))
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixIconButtonStyler _fortalIconButtonDisabledFill(Radius radius) =>
    _fortalIconButtonForeground(RemixIconButtonStyler(), FortalTokens.grayA8())
        .surface(_fortalIconButtonFill(FortalTokens.grayA3(), radius))
        .spinner(RemixSpinnerStyler().opacity(1));

RemixIconButtonStyler _fortalIconButtonForeground(
  RemixIconButtonStyler style,
  Color color,
) => style
    .icon(IconStyler().color(color))
    .spinner(RemixSpinnerStyler().color(color));

RemixSurfaceLayerMix _fortalIconButtonFill(Color color, Radius radius) =>
    RemixSurfaceLayerMix(
      color: color,
      borderRadius: BorderRadiusMix.all(radius),
    );

/// Fortal-themed IconButton with the Radix size, variant, and override contract.
class FortalIconButton extends StatelessWidget {
  const FortalIconButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.child,
    required this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : assert(semanticLabel != '');

  final FortalIconButtonVariant variant;
  final FortalIconButtonSize size;
  final FortalAccentColor? color;
  final FortalRadius? radius;
  final bool highContrast;
  final Widget child;
  final String semanticLabel;
  final RemixIconButtonLoadingBuilder? loadingBuilder;
  final bool loading;
  final bool enabled;
  final bool enableFeedback;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticHint;
  final bool excludeSemantics;
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: color,
      radius: radius,
      child:
          fortalIconButtonStyler(
            variant: variant,
            size: size,
            highContrast: highContrast,
          ).call(
            key: key,
            child: child,
            semanticLabel: semanticLabel,
            loadingBuilder: loadingBuilder,
            loading: loading,
            enabled: enabled,
            enableFeedback: enableFeedback,
            onPressed: onPressed,
            onLongPress: onLongPress,
            focusNode: focusNode,
            autofocus: autofocus,
            semanticHint: semanticHint,
            excludeSemantics: excludeSemantics,
            mouseCursor: mouseCursor,
          ),
    );
  }
}
