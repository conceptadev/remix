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
  /// Raised treatment with Radix's classic shadow and gradient layers.
  classic,

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
    .classic => _fortalRadioClassicStyler(size, highContrast: highContrast),
    .surface => _fortalRadioSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalRadioSoftStyler(size, highContrast: highContrast),
  };
}

RemixRadioStyler _fortalRadioBaseStyler(FortalRadioSize size) {
  final metrics = _fortalRadioMetrics(size);
  return RemixRadioStyler(
    container: BoxStyler()
        .size(metrics.size, metrics.size)
        .alignment(.center)
        .borderRadiusAll(FortalTokens.radiusCircle()),
    indicator: BoxStyler()
        .size(metrics.indicatorSize, metrics.indicatorSize)
        .borderRadiusAll(FortalTokens.radiusCircle()),
    surface: _fortalRadioLayer(),
    overlay: _fortalRadioLayer(),
  ).onFocused(
    RemixRadioStyler().overlay(
      _fortalRadioLayer(
        outlineColor: FortalTokens.focus8(),
        outlineWidth: 2,
        outlineOffset: 2,
      ),
    ),
  );
}

RemixRadioStyler _fortalRadioClassicStyler(
  FortalRadioSize size, {
  required bool highContrast,
}) {
  final selectedColor = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accentIndicator();
  return _fortalRadioBaseStyler(size)
      .surface(
        _fortalRadioLayer(
          color: FortalTokens.colorSurface(),
          shadowToken: FortalTokens.shadow1,
        ),
      )
      .overlay(_fortalRadioInsetRing(FortalTokens.gray7()))
      .indicatorColor(
        highContrast ? FortalTokens.accent1() : FortalTokens.accentContrast(),
      )
      .onSelected(
        RemixRadioStyler()
            .surface(
              _fortalRadioLayer(
                color: selectedColor,
                gradients: [
                  RemixLinearGradientMix(
                    colors: [
                      FortalTokens.whiteA3(),
                      Colors.transparent,
                      FortalTokens.blackA3(),
                    ],
                  ),
                ],
                shadows: [
                  RemixPaintShadowMix(
                    kind: .inset,
                    color: FortalTokens.whiteA4(),
                    offset: const Offset(0, 0.5),
                    blurRadius: 0.5,
                  ),
                  RemixPaintShadowMix(
                    kind: .inset,
                    color: FortalTokens.blackA4(),
                    offset: const Offset(0, -0.5),
                    blurRadius: 0.5,
                  ),
                ],
              ),
            )
            .indicatorColor(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
      )
      .onDisabled(
        RemixRadioStyler()
            .surface(
              _fortalRadioLayer(
                color: FortalTokens.grayA3(),
                shadowToken: FortalTokens.shadow1,
              ),
            )
            .overlay(_fortalRadioLayer(shadows: const []))
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixRadioStyler _fortalRadioSurfaceStyler(
  FortalRadioSize size, {
  required bool highContrast,
}) {
  return _fortalRadioBaseStyler(size)
      .surface(_fortalRadioLayer(color: FortalTokens.colorSurface()))
      .overlay(_fortalRadioInsetRing(FortalTokens.grayA7()))
      .indicator(
        BoxStyler()
            .color(FortalTokens.accent9())
            .borderRadiusAll(FortalTokens.radiusCircle()),
      )
      .onSelected(
        RemixRadioStyler()
            .surface(
              _fortalRadioLayer(
                color: highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accentIndicator(),
              ),
            )
            .overlay(_fortalRadioLayer(shadows: const []))
            .indicatorColor(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
      )
      .onDisabled(
        RemixRadioStyler()
            .surface(_fortalRadioLayer(color: FortalTokens.grayA3()))
            .overlay(_fortalRadioInsetRing(FortalTokens.grayA6()))
            .indicatorColor(FortalTokens.grayA8()),
      );
}

RemixRadioStyler _fortalRadioSoftStyler(
  FortalRadioSize size, {
  required bool highContrast,
}) {
  return _fortalRadioBaseStyler(size)
      .surface(_fortalRadioLayer(color: FortalTokens.accentA4()))
      .indicator(
        BoxStyler()
            .color(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .borderRadiusAll(FortalTokens.radiusCircle()),
      )
      .onSelected(
        RemixRadioStyler()
            .surface(_fortalRadioLayer(color: FortalTokens.accentA4()))
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
            .surface(_fortalRadioLayer(color: FortalTokens.grayA3()))
            .indicatorColor(FortalTokens.grayA8()),
      );
}

({double size, double indicatorSize}) _fortalRadioMetrics(
  FortalRadioSize size,
) => switch (size) {
  .size1 => (
    size: FortalTokens.checkboxSize1(),
    indicatorSize: FortalTokens.radioIndicatorSize1(),
  ),
  .size2 => (
    size: FortalTokens.space4(),
    indicatorSize: FortalTokens.radioIndicatorSize2(),
  ),
  .size3 => (
    size: FortalTokens.checkboxSize3(),
    indicatorSize: FortalTokens.radioIndicatorSize3(),
  ),
};

RemixSurfaceLayerMix _fortalRadioInsetRing(Color color) => _fortalRadioLayer(
  shadows: [RemixPaintShadowMix(kind: .inset, color: color, spreadRadius: 1)],
);

RemixSurfaceLayerMix _fortalRadioLayer({
  Color? color,
  List<RemixLinearGradientMix>? gradients,
  List<RemixPaintShadowMix>? shadows,
  RemixPaintShadowListToken? shadowToken,
  Color? outlineColor,
  double? outlineWidth,
  double? outlineOffset,
}) => RemixSurfaceLayerMix(
  color: color,
  gradients: gradients,
  shadows: shadows,
  shadowToken: shadowToken,
  borderRadius: BorderRadiusMix.all(FortalTokens.radiusCircle()),
  outlineColor: outlineColor,
  outlineWidth: outlineWidth,
  outlineOffset: outlineOffset,
);

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
    return FortalComponentOverride(
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

/// Typed selection scope for a set of [FortalRadio] widgets.
class FortalRadioGroup<T> extends StatelessWidget {
  const FortalRadioGroup({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
  });

  /// The currently selected group value.
  final T? value;

  /// Called when a radio requests a new selection. Null disables the group.
  final ValueChanged<T?>? onChanged;

  /// The subtree containing the group's radio items and labels.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      RemixRadioGroup<T>(groupValue: value, onChanged: onChanged, child: child);
}
