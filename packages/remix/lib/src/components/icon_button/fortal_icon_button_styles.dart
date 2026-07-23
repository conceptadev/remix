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
  final base = _fortalIconButtonBaseStyler(variant, index);
  final focus = fortalFocusOutline(
    variant == .soft ? FortalTokens.accent8() : FortalTokens.focus8(),
    offset: variant == .classic || variant == .solid ? 2 : -1,
  );
  final disabledFocus = RemixBoxEffectsMix(
    outline: BorderSideMix(style: BorderStyle.none),
  );

  return switch (variant) {
        .classic => _fortalIconButtonClassic(
          base,
          size: index,
          highContrast: highContrast,
        ),
        .solid => _fortalIconButtonSolid(base, highContrast: highContrast),
        .soft => _fortalIconButtonSoft(base, highContrast: highContrast),
        .surface => _fortalIconButtonSurface(base, highContrast: highContrast),
        .outline => _fortalIconButtonOutline(base, highContrast: highContrast),
        .ghost => _fortalIconButtonGhost(base, highContrast: highContrast),
      }
      .onFocused(RemixIconButtonStyler().containerEffects(focus))
      .onDisabled(RemixIconButtonStyler().containerEffects(disabledFocus));
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
  RemixIconButtonStyler base, {
  required int size,
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .color(highContrast ? FortalTokens.accent12() : FortalTokens.accent9())
      .containerEffects(
        RemixBoxEffectsMix(
          behindContent: fortalClassicBaseButtonSurface(
            highContrast: highContrast,
          ),
        ),
      )
      .onHovered(
        RemixIconButtonStyler()
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalClassicBaseButtonSurface(
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
        RemixIconButtonStyler()
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalClassicBaseButtonSurface(
                  highContrast: highContrast,
                  pressed: true,
                ),
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
            .color(FortalTokens.gray2())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalClassicBaseButtonSurface(
                  highContrast: false,
                  disabled: true,
                ),
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

RemixIconButtonStyler _fortalIconButtonSolid(
  RemixIconButtonStyler base, {
  required bool highContrast,
}) {
  final foreground = highContrast
      ? FortalTokens.gray1()
      : FortalTokens.accentContrast();
  return _fortalIconButtonForeground(base, foreground)
      .color(highContrast ? FortalTokens.accent12() : FortalTokens.accent9())
      .onHovered(
        RemixIconButtonStyler()
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
        RemixIconButtonStyler()
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
        _fortalIconButtonForeground(
              RemixIconButtonStyler(),
              FortalTokens.grayA8(),
            )
            .color(FortalTokens.grayA3())
            .spinner(RemixSpinnerStyler().opacity(1))
            .wrap(fortalClearFilter()),
      );
}

RemixIconButtonStyler _fortalIconButtonSoft(
  RemixIconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentA3())
        .onHovered(RemixIconButtonStyler().color(FortalTokens.accentA4()))
        .onPressed(RemixIconButtonStyler().color(FortalTokens.accentA5()))
        .onDisabled(_fortalIconButtonDisabledFill());

RemixIconButtonStyler _fortalIconButtonSurface(
  RemixIconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(FortalTokens.accentSurface())
        .containerEffects(
          RemixBoxEffectsMix(
            behindContent: fortalInsetSurface(
              strokes: [FortalTokens.accentA7()],
            ),
          ),
        )
        .onHovered(
          RemixIconButtonStyler()
              .color(FortalTokens.accentSurface())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: fortalInsetSurface(
                    strokes: [FortalTokens.accentA8()],
                  ),
                ),
              ),
        )
        .onPressed(
          RemixIconButtonStyler()
              .color(FortalTokens.accentA3())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: fortalInsetSurface(
                    strokes: [FortalTokens.accentA8()],
                  ),
                ),
              ),
        )
        .onDisabled(
          _fortalIconButtonForeground(
                RemixIconButtonStyler(),
                FortalTokens.grayA8(),
              )
              .color(FortalTokens.grayA2())
              .containerEffects(
                RemixBoxEffectsMix(
                  behindContent: fortalInsetSurface(
                    strokes: [FortalTokens.grayA6()],
                  ),
                ),
              )
              .spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixIconButtonStyler _fortalIconButtonOutline(
  RemixIconButtonStyler base, {
  required bool highContrast,
}) {
  final strokes = highContrast
      ? [FortalTokens.accentA7(), FortalTokens.grayA11()]
      : [FortalTokens.accentA8()];
  return _fortalIconButtonForeground(
        base,
        highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
      )
      .containerEffects(
        RemixBoxEffectsMix(behindContent: fortalInsetSurface(strokes: strokes)),
      )
      .onHovered(
        RemixIconButtonStyler()
            .color(FortalTokens.accentA2())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalInsetSurface(strokes: strokes),
              ),
            ),
      )
      .onPressed(
        RemixIconButtonStyler()
            .color(FortalTokens.accentA3())
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalInsetSurface(strokes: strokes),
              ),
            ),
      )
      .onDisabled(
        _fortalIconButtonForeground(
              RemixIconButtonStyler(),
              FortalTokens.grayA8(),
            )
            .color(Colors.transparent)
            .containerEffects(
              RemixBoxEffectsMix(
                behindContent: fortalInsetSurface(
                  strokes: [FortalTokens.grayA7()],
                ),
              ),
            )
            .spinner(RemixSpinnerStyler().opacity(1)),
      );
}

RemixIconButtonStyler _fortalIconButtonGhost(
  RemixIconButtonStyler base, {
  required bool highContrast,
}) =>
    _fortalIconButtonForeground(
          base,
          highContrast ? FortalTokens.accent12() : FortalTokens.accentA11(),
        )
        .color(Colors.transparent)
        .onHovered(RemixIconButtonStyler().color(FortalTokens.accentA3()))
        .onPressed(RemixIconButtonStyler().color(FortalTokens.accentA4()))
        .onDisabled(
          _fortalIconButtonForeground(
            RemixIconButtonStyler(),
            FortalTokens.grayA8(),
          ).color(Colors.transparent).spinner(RemixSpinnerStyler().opacity(1)),
        );

RemixIconButtonStyler _fortalIconButtonDisabledFill() =>
    _fortalIconButtonForeground(
      RemixIconButtonStyler(),
      FortalTokens.grayA8(),
    ).color(FortalTokens.grayA3()).spinner(RemixSpinnerStyler().opacity(1));

RemixIconButtonStyler _fortalIconButtonForeground(
  RemixIconButtonStyler style,
  Color color,
) => style
    .icon(IconStyler().color(color))
    .spinner(RemixSpinnerStyler().color(color));

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

  const FortalIconButton.classic({
    super.key,
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
  }) : variant = .classic,
       assert(semanticLabel != '');

  const FortalIconButton.solid({
    super.key,
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
  }) : variant = .solid,
       assert(semanticLabel != '');

  const FortalIconButton.soft({
    super.key,
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
  }) : variant = .soft,
       assert(semanticLabel != '');

  const FortalIconButton.surface({
    super.key,
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
  }) : variant = .surface,
       assert(semanticLabel != '');

  const FortalIconButton.outline({
    super.key,
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
  }) : variant = .outline,
       assert(semanticLabel != '');

  const FortalIconButton.ghost({
    super.key,
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
  }) : variant = .ghost,
       assert(semanticLabel != '');

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
