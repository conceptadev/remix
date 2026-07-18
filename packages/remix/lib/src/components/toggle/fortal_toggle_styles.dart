part of 'toggle.dart';

/// Fortal toggle size presets.
enum FortalToggleSize { size1, size2, size3 }

/// Fortal toggle color and border variants.
enum FortalToggleVariant { ghost, outline }

/// Fortal-themed preset for [RemixToggle].
RemixToggleStyler fortalToggleStyler({
  FortalToggleVariant variant = .ghost,
  FortalToggleSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .ghost => _fortalToggleGhostStyler(size, highContrast: highContrast),
    .outline => _fortalToggleOutlineStyler(size, highContrast: highContrast),
  };
}

RemixToggleStyler _fortalToggleBaseStyler(FortalToggleSize size) {
  return RemixToggleStyler()
      .container(FlexBoxStyler().mainAxisSize(.min))
      .foregroundColor(FortalTokens.gray12())
      .labelFontWeight(.w500)
      .onFocused(
        RemixToggleStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
        ),
      )
      .onDisabled(
        RemixToggleStyler()
            .backgroundColor(FortalTokens.grayA3())
            .foregroundColor(FortalTokens.gray8()),
      )
      .merge(_fortalToggleSizeStyler(size));
}

RemixToggleStyler _fortalToggleGhostStyler(
  FortalToggleSize size, {
  bool highContrast = false,
}) {
  return _fortalToggleBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .onHovered(RemixToggleStyler().backgroundColor(FortalTokens.grayA3()))
      .onSelected(
        RemixToggleStyler()
            .backgroundColor(FortalTokens.accent3())
            .foregroundColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            ),
      );
}

RemixToggleStyler _fortalToggleOutlineStyler(
  FortalToggleSize size, {
  bool highContrast = false,
}) {
  return _fortalToggleBaseStyler(size)
      .backgroundColor(Colors.transparent)
      .borderAll(
        color: FortalTokens.gray7(),
        width: FortalTokens.borderWidth1(),
        strokeAlign: BorderSide.strokeAlignInside,
      )
      .onHovered(RemixToggleStyler().backgroundColor(FortalTokens.grayA3()))
      .onSelected(
        RemixToggleStyler()
            .backgroundColor(FortalTokens.accentA3())
            .foregroundColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .borderAll(color: FortalTokens.accentA5()),
      );
}

RemixToggleStyler _fortalToggleSizeStyler(FortalToggleSize size) {
  return switch (size) {
    .size1 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space2())
          .paddingY(FortalTokens.space1())
          .borderRadiusAll(FortalTokens.radius2())
          .spacing(2),
      label: TextStyler()
          .fontSize(12.0)
          .height(16.0 / 12.0)
          .letterSpacing(0.0025),
      icon: IconStyler(size: 12),
    ),
    .size2 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space3())
          .paddingY(FortalTokens.space2())
          .borderRadiusAll(FortalTokens.radius2())
          .spacing(4),
      label: TextStyler().fontSize(14.0).height(20.0 / 14.0).letterSpacing(0.0),
      icon: IconStyler(size: 16),
    ),
    .size3 => RemixToggleStyler(
      container: FlexBoxStyler()
          .paddingX(FortalTokens.space4())
          .paddingY(FortalTokens.space2())
          .borderRadiusAll(FortalTokens.radius3())
          .spacing(6),
      label: TextStyler().fontSize(16.0).height(24.0 / 16.0).letterSpacing(0.0),
      icon: IconStyler(size: 20),
    ),
  };
}

/// Fortal-themed preset for [RemixToggle].
class FortalToggle extends StatelessWidget {
  const FortalToggle({
    super.key,
    this.variant = .ghost,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalToggle.ghost({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalToggleVariant.ghost;

  const FortalToggle.outline({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalToggleVariant.outline;

  final FortalToggleVariant variant;

  final FortalToggleSize size;

  /// Optional accent color override for this toggle subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this toggle subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final bool selected;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final String? label;

  final IconData? icon;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticLabel;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalToggleStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call(
            key: this.key,
            selected: this.selected,
            onChanged: this.onChanged,
            enabled: this.enabled,
            label: this.label,
            icon: this.icon,
            enableFeedback: this.enableFeedback,
            focusNode: this.focusNode,
            autofocus: this.autofocus,
            semanticLabel: this.semanticLabel,
            mouseCursor: this.mouseCursor,
          ),
    );
  }
}
