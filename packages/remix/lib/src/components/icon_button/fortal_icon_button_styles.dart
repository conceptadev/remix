part of 'icon_button.dart';

/// Fortal icon button size presets.
enum FortalIconButtonSize { size1, size2, size3, size4 }

/// Fortal icon button color and emphasis variants.
enum FortalIconButtonVariant { solid, soft, surface, outline, ghost }

/// Fortal-themed preset for [RemixIconButton].
RemixIconButtonStyler fortalIconButtonStyler({
  FortalIconButtonVariant variant = .solid,
  FortalIconButtonSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .solid => _fortalIconButtonSolidStyler(size, highContrast: highContrast),
    .soft => _fortalIconButtonSoftStyler(size, highContrast: highContrast),
    .surface => _fortalIconButtonSurfaceStyler(
      size,
      highContrast: highContrast,
    ),
    .outline => _fortalIconButtonOutlineStyler(
      size,
      highContrast: highContrast,
    ),
    .ghost => _fortalIconButtonGhostStyler(size, highContrast: highContrast),
  };
}

RemixIconButtonStyler _fortalIconButtonBaseStyler(FortalIconButtonSize size) {
  return RemixIconButtonStyler()
      .spinner(
        RemixSpinnerStyler(
          strokeWidth: FortalTokens.borderWidth2(),
          duration: const Duration(milliseconds: 800),
        ),
      )
      .onFocused(
        RemixIconButtonStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
        ),
      )
      .merge(_fortalIconButtonSizeStyler(size));
}

RemixIconButtonStyler _fortalIconButtonSolidStyler(
  FortalIconButtonSize size, {
  bool highContrast = false,
}) {
  return _fortalIconButtonBaseStyler(size)
      .backgroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      )
      .spinner(
        RemixSpinnerStyler().indicatorColor(
          highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
        ),
      )
      .onHovered(
        RemixIconButtonStyler().backgroundColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
        ),
      )
      .onPressed(
        RemixIconButtonStyler().backgroundColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent10(),
        ),
      )
      .onDisabled(
        RemixIconButtonStyler()
            .backgroundColor(FortalTokens.grayA3())
            .foregroundColor(FortalTokens.gray8())
            .spinner(
              RemixSpinnerStyler()
                  .indicatorColor(FortalTokens.gray8())
                  .strokeWidth(FortalTokens.borderWidth1()),
            ),
      );
}

RemixIconButtonStyler _fortalIconButtonSoftStyler(
  FortalIconButtonSize size, {
  bool highContrast = false,
}) {
  return _fortalIconButtonBaseStyler(size)
      .backgroundColor(FortalTokens.accent3())
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
      )
      .spinner(
        RemixSpinnerStyler().indicatorColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
        ),
      )
      .onHovered(
        RemixIconButtonStyler().backgroundColor(FortalTokens.accent4()),
      )
      .onPressed(
        RemixIconButtonStyler().backgroundColor(FortalTokens.accent5()),
      )
      .onDisabled(
        RemixIconButtonStyler()
            .backgroundColor(FortalTokens.grayA3())
            .foregroundColor(FortalTokens.gray8())
            .spinner(
              RemixSpinnerStyler()
                  .indicatorColor(FortalTokens.gray8())
                  .strokeWidth(FortalTokens.borderWidth1()),
            ),
      );
}

RemixIconButtonStyler _fortalIconButtonSurfaceStyler(
  FortalIconButtonSize size, {
  bool highContrast = false,
}) {
  return _fortalIconButtonBaseStyler(size)
      .backgroundColor(FortalTokens.accentA2())
      .borderAll(
        color: FortalTokens.accent6(),
        width: FortalTokens.borderWidth1(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
      )
      .spinner(
        RemixSpinnerStyler().indicatorColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
        ),
      )
      .onHovered(
        RemixIconButtonStyler().borderAll(
          color: FortalTokens.accent8(),
          width: FortalTokens.borderWidth1(),
        ),
      )
      .onDisabled(
        RemixIconButtonStyler()
            .backgroundColor(FortalTokens.grayA2())
            .foregroundColor(FortalTokens.gray8())
            .borderAll(
              color: FortalTokens.gray5(),
              width: FortalTokens.borderWidth1(),
            )
            .spinner(
              RemixSpinnerStyler()
                  .indicatorColor(FortalTokens.gray8())
                  .strokeWidth(FortalTokens.borderWidth1()),
            ),
      );
}

RemixIconButtonStyler _fortalIconButtonOutlineStyler(
  FortalIconButtonSize size, {
  bool highContrast = false,
}) {
  return _fortalIconButtonBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .borderAll(
        color: FortalTokens.accent7(),
        width: FortalTokens.borderWidth1(),
      )
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
      )
      .spinner(
        RemixSpinnerStyler().indicatorColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
        ),
      )
      .onHovered(
        RemixIconButtonStyler()
            .backgroundColor(FortalTokens.accentA2())
            .borderAll(
              color: FortalTokens.accent8(),
              width: FortalTokens.borderWidth1(),
            ),
      )
      .onDisabled(
        RemixIconButtonStyler()
            .foregroundColor(FortalTokens.gray8())
            .borderAll(color: FortalTokens.gray5())
            .spinner(
              RemixSpinnerStyler()
                  .indicatorColor(FortalTokens.gray8())
                  .strokeWidth(FortalTokens.borderWidth1()),
            ),
      );
}

RemixIconButtonStyler _fortalIconButtonGhostStyler(
  FortalIconButtonSize size, {
  bool highContrast = false,
}) {
  return _fortalIconButtonBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .foregroundColor(
        highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
      )
      .spinner(
        RemixSpinnerStyler().indicatorColor(
          highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
        ),
      )
      .onHovered(
        RemixIconButtonStyler().backgroundColor(FortalTokens.accentA3()),
      )
      .onPressed(
        RemixIconButtonStyler().backgroundColor(FortalTokens.accentA4()),
      )
      .onDisabled(
        RemixIconButtonStyler()
            .foregroundColor(FortalTokens.gray8())
            .spinner(RemixSpinnerStyler().indicatorColor(FortalTokens.gray8())),
      );
}

RemixIconButtonStyler _fortalIconButtonSizeStyler(FortalIconButtonSize size) {
  final style = RemixIconButtonStyler();

  return switch (size) {
    .size1 =>
      style
          .width(24.0)
          .height(24.0)
          .borderRadiusAll(FortalTokens.radius2())
          .iconSize(12.0)
          .spinner(RemixSpinnerStyler(size: 12.0)),
    .size2 =>
      style
          .width(32.0)
          .height(32.0)
          .borderRadiusAll(FortalTokens.radius3())
          .iconSize(16.0)
          .spinner(RemixSpinnerStyler(size: 16.0)),
    .size3 =>
      style
          .width(40.0)
          .height(40.0)
          .borderRadiusAll(FortalTokens.radius4())
          .iconSize(20.0)
          .spinner(RemixSpinnerStyler(size: 20.0)),
    .size4 =>
      style
          .width(48.0)
          .height(48.0)
          .borderRadiusAll(FortalTokens.radius5())
          .iconSize(24.0)
          .spinner(RemixSpinnerStyler(size: 24.0)),
  };
}

/// Fortal-themed preset for [RemixIconButton].
class FortalIconButton extends StatelessWidget {
  const FortalIconButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalIconButton.solid({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.solid;

  const FortalIconButton.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.soft;

  const FortalIconButton.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.surface;

  const FortalIconButton.outline({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.outline;

  const FortalIconButton.ghost({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.ghost;

  final FortalIconButtonVariant variant;

  final FortalIconButtonSize size;

  /// Optional accent color override for this icon button subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this icon button subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final IconData icon;

  final RemixIconButtonIconBuilder? iconBuilder;

  final RemixIconButtonLoadingBuilder? loadingBuilder;

  final bool loading;

  final bool enabled;

  final bool enableFeedback;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalIconButtonStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
            icon: this.icon,
            iconBuilder: this.iconBuilder,
            loadingBuilder: this.loadingBuilder,
            loading: this.loading,
            enabled: this.enabled,
            enableFeedback: this.enableFeedback,
            onPressed: this.onPressed,
            onLongPress: this.onLongPress,
            focusNode: this.focusNode,
            autofocus: this.autofocus,
            semanticLabel: this.semanticLabel,
            semanticHint: this.semanticHint,
            excludeSemantics: this.excludeSemantics,
            mouseCursor: this.mouseCursor,
          ),
    );
  }
}
