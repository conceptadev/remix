part of 'radio.dart';

/// Fortal radio size presets.
enum FortalRadioSize {
  /// Compact radio.
  size1,

  /// Default radio.
  size2,

  /// Large radio.
  size3,
}

/// Fortal radio color variants.
enum FortalRadioVariant {
  /// Surface treatment with neutral border.
  surface,

  /// Soft accent treatment.
  soft,
}

/// Fortal-themed preset for [RemixRadio].
RemixRadioStyler fortalRadioStyler({
  FortalRadioVariant variant = .surface,
  FortalRadioSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .surface => _fortalRadioSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalRadioSoftStyler(size, highContrast: highContrast),
  };
}

RemixRadioStyler _fortalRadioBaseStyler(FortalRadioSize size) {
  return RemixRadioStyler()
      .onFocused(
        RemixRadioStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
        ),
      )
      .merge(_fortalRadioSizeStyler(size));
}

RemixRadioStyler _fortalRadioSurfaceStyler(
  FortalRadioSize size, {
  bool highContrast = false,
}) {
  return _fortalRadioBaseStyler(size)
      .fillColor(FortalTokens.colorSurface())
      .borderAll(
        color: FortalTokens.gray6(),
        width: FortalTokens.borderWidth1(),
      )
      .borderRadiusAll(FortalTokens.radiusFull())
      .indicator(
        BoxStyler()
            .color(FortalTokens.accent9())
            .borderRadiusAll(FortalTokens.radiusFull()),
      )
      .onSelected(
        RemixRadioStyler()
            .fillColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
            )
            .borderAll(
              color: highContrast
                  ? FortalTokens.accent12()
                  : FortalTokens.accent9(),
              width: FortalTokens.borderWidth1(),
            )
            .indicator(
              BoxStyler().color(
                highContrast
                    ? FortalTokens.accent1()
                    : FortalTokens.accentContrast(),
              ),
            ),
      )
      .onDisabled(
        RemixRadioStyler()
            .fillColor(FortalTokens.gray3())
            .borderAll(
              color: FortalTokens.gray6(),
              width: FortalTokens.borderWidth1(),
            )
            .indicator(BoxStyler().color(FortalTokens.gray9())),
      );
}

RemixRadioStyler _fortalRadioSoftStyler(
  FortalRadioSize size, {
  bool highContrast = false,
}) {
  return _fortalRadioBaseStyler(size)
      .fillColor(FortalTokens.accentA4())
      .borderRadiusAll(FortalTokens.radiusFull())
      .indicator(
        BoxStyler()
            .color(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .borderRadiusAll(FortalTokens.radiusFull()),
      )
      .onSelected(
        RemixRadioStyler()
            .fillColor(FortalTokens.accentA4())
            .indicator(
              BoxStyler().color(
                highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accent11(),
              ),
            ),
      )
      .onDisabled(
        RemixRadioStyler()
            .fillColor(FortalTokens.gray3())
            .indicator(BoxStyler().color(FortalTokens.gray7())),
      );
}

RemixRadioStyler _fortalRadioSizeStyler(FortalRadioSize size) {
  return switch (size) {
    .size1 => RemixRadioStyler(
      container: BoxStyler().width(16.0).height(16.0).alignment(.center),
      indicator: BoxStyler().width(6.0).height(6.0),
    ),
    .size2 => RemixRadioStyler(
      container: BoxStyler().width(20.0).height(20.0).alignment(.center),
      indicator: BoxStyler().width(8.0).height(8.0),
    ),
    .size3 => RemixRadioStyler(
      container: BoxStyler().width(24.0).height(24.0).alignment(.center),
      indicator: BoxStyler().width(10.0).height(10.0),
    ),
  };
}

/// Fortal-themed preset for [RemixRadio].
class FortalRadio<T> extends StatelessWidget {
  const FortalRadio({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  });

  /// Surface treatment with neutral border.
  const FortalRadio.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : variant = FortalRadioVariant.surface;

  /// Soft accent treatment.
  const FortalRadio.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.value,
    this.enabled = true,
    this.toggleable = false,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : variant = FortalRadioVariant.soft;

  final FortalRadioVariant variant;

  final FortalRadioSize size;

  /// Optional accent color override for this radio subtree.
  final FortalAccentColor? color;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final T value;

  final bool enabled;

  final bool toggleable;

  final MouseCursor? mouseCursor;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      child:
          fortalRadioStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call<T>(
            key: this.key,
            value: this.value,
            enabled: this.enabled,
            toggleable: this.toggleable,
            mouseCursor: this.mouseCursor,
            focusNode: this.focusNode,
            autofocus: this.autofocus,
          ),
    );
  }
}
