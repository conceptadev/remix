part of 'toggle_group.dart';

/// Fortal toggle-group size presets.
enum FortalToggleGroupSize { size1, size2, size3 }

/// Fortal toggle-group color treatments.
enum FortalToggleGroupVariant { soft, surface }

/// Fortal-themed segmented-control preset for [RemixToggleGroup].
RemixToggleGroupStyler fortalToggleGroupStyler({
  FortalToggleGroupVariant variant = .soft,
  FortalToggleGroupSize size = .size2,
  bool highContrast = false,
}) {
  final (
    selectedColor,
    selectedHoverColor,
    selectedPressedColor,
  ) = switch (variant) {
    .soft => (
      FortalTokens.accent3(),
      FortalTokens.accent4(),
      FortalTokens.accent5(),
    ),
    .surface => (
      FortalTokens.accentSurface(),
      FortalTokens.accentA4(),
      FortalTokens.accentA5(),
    ),
  };
  final selectedForeground = highContrast
      ? FortalTokens.accent12()
      : FortalTokens.accent11();

  return RemixToggleGroupStyler(
    container: FlexBoxStyler(
      decoration: BoxDecorationMix(
        border: BorderMix.all(
          BorderSideMix(
            color: FortalTokens.gray7(),
            width: FortalTokens.borderWidth1(),
          ),
        ),
        color: FortalTokens.colorSurface(),
      ),
      clipBehavior: .hardEdge,
      mainAxisSize: .min,
      spacing: 0,
    ),
    item: RemixToggleGroupItemStyler()
        .alignment(.center)
        .foregroundColor(FortalTokens.gray11())
        .labelFontWeight(FortalTokens.fontWeightMedium())
        .onHovered(
          RemixToggleGroupItemStyler().backgroundColor(FortalTokens.grayA3()),
        )
        .onPressed(
          RemixToggleGroupItemStyler().backgroundColor(FortalTokens.grayA4()),
        )
        .onSelected(
          RemixToggleGroupItemStyler()
              .backgroundColor(selectedColor)
              .foregroundColor(selectedForeground)
              .onHovered(
                RemixToggleGroupItemStyler().backgroundColor(
                  selectedHoverColor,
                ),
              )
              .onPressed(
                RemixToggleGroupItemStyler().backgroundColor(
                  selectedPressedColor,
                ),
              ),
        )
        .onFocused(
          RemixToggleGroupItemStyler().borderAll(
            color: FortalTokens.focusA8(),
            width: FortalTokens.focusRingWidth(),
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        )
        .onDisabled(
          RemixToggleGroupItemStyler()
              .backgroundColor(FortalTokens.grayA3())
              .foregroundColor(FortalTokens.gray8()),
        ),
  ).merge(_fortalToggleGroupSizeStyler(size));
}

RemixToggleGroupStyler _fortalToggleGroupSizeStyler(
  FortalToggleGroupSize size,
) {
  return switch (size) {
    .size1 => RemixToggleGroupStyler(
      container: FlexBoxStyler().borderRadiusAll(FortalTokens.radius2()),
      item: RemixToggleGroupItemStyler(
        container: FlexBoxStyler()
            .paddingX(FortalTokens.space2())
            .paddingY(FortalTokens.space1())
            .spacing(FortalTokens.toggleGap1()),
        label: TextStyler(style: FortalTokens.text1.mix()),
        icon: IconStyler(size: FortalTokens.space3()),
      ),
    ),
    .size2 => RemixToggleGroupStyler(
      container: FlexBoxStyler().borderRadiusAll(FortalTokens.radius2()),
      item: RemixToggleGroupItemStyler(
        container: FlexBoxStyler()
            .paddingX(FortalTokens.space3())
            .paddingY(FortalTokens.space2())
            .spacing(FortalTokens.space1()),
        label: TextStyler(style: FortalTokens.text2.mix()),
        icon: IconStyler(size: FortalTokens.space4()),
      ),
    ),
    .size3 => RemixToggleGroupStyler(
      container: FlexBoxStyler().borderRadiusAll(FortalTokens.radius3()),
      item: RemixToggleGroupItemStyler(
        container: FlexBoxStyler()
            .paddingX(FortalTokens.space4())
            .paddingY(FortalTokens.space2())
            .spacing(FortalTokens.toggleGap3()),
        label: TextStyler(style: FortalTokens.text3.mix()),
        icon: IconStyler(size: FortalTokens.spinnerSize3()),
      ),
    ),
  };
}

/// Fortal-themed segmented-control preset for [RemixToggleGroup].
class FortalToggleGroup<T> extends StatelessWidget {
  const FortalToggleGroup({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalToggleGroupVariant variant;

  final FortalToggleGroupSize size;

  /// Optional accent color override for this toggle-group subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this toggle-group subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final List<RemixToggleGroupItem<T>> items;

  final T? selectedValue;

  final ValueChanged<T?>? onChanged;

  final bool enabled;

  final Axis orientation;

  final bool loop;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalToggleGroupStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call<T>(
            key: this.key,
            items: this.items,
            selectedValue: this.selectedValue,
            onChanged: this.onChanged,
            enabled: this.enabled,
            orientation: this.orientation,
            loop: this.loop,
            semanticLabel: this.semanticLabel,
            excludeSemantics: this.excludeSemantics,
          ),
    );
  }
}
