part of 'select.dart';

/// Radix Themes Select root size presets.
enum FortalSelectSize { size1, size2, size3 }

/// Radix Themes Select trigger variants.
enum FortalSelectTriggerVariant { classic, surface, soft, ghost }

/// Radix Themes Select content variants.
enum FortalSelectContentVariant { solid, soft }

/// Fortal recipe for a complete Select.
RemixSelectStyler fortalSelectStyler({
  FortalSelectTriggerVariant triggerVariant = .surface,
  FortalSelectContentVariant contentVariant = .solid,
  FortalSelectSize size = .size2,
  bool contentHighContrast = false,
}) {
  return RemixSelectStyler()
      .trigger(_fortalSelectTriggerStyler(triggerVariant, size))
      .content(_fortalSelectContentStyler(size))
      .item(
        _fortalSelectItemStyler(
          contentVariant,
          size,
          highContrast: contentHighContrast,
        ),
      )
      .label(_fortalSelectLabelStyler(size))
      .separator(_fortalSelectSeparatorStyler(size));
}

RemixSelectTriggerStyler _fortalSelectTriggerStyler(
  FortalSelectTriggerVariant variant,
  FortalSelectSize size,
) {
  final radius = _fortalSelectTriggerRadius(size);
  final base = RemixSelectTriggerStyler()
      .direction(.horizontal)
      .mainAxisAlignment(.spaceBetween)
      .crossAxisAlignment(.center)
      .borderRadiusAll(radius)
      .label(_fortalSelectTriggerText(size, color: FortalTokens.gray12()))
      .placeholder(
        _fortalSelectTriggerText(size, color: FortalTokens.grayA10()),
      )
      .icon(IconStyler(color: FortalTokens.gray12()))
      .chevron(
        IconStyler(color: FortalTokens.gray12(), size: size == .size3 ? 11 : 9),
      )
      .onFocused(
        RemixSelectTriggerStyler().effects(
          RemixSurfaceEffectsMix(foreground: _fortalSelectFocusRing()),
        ),
      )
      .merge(_fortalSelectTriggerSizeStyler(variant, size));

  return switch (variant) {
    .classic => _fortalSelectClassicTrigger(base),
    .surface => _fortalSelectSurfaceTrigger(base),
    .soft => _fortalSelectSoftTrigger(base),
    .ghost => _fortalSelectGhostTrigger(base),
  };
}

TextStyler _fortalSelectTriggerText(FortalSelectSize size, {Color? color}) {
  final token = switch (size) {
    .size1 => FortalTokens.text1,
    .size2 => FortalTokens.text2,
    .size3 => FortalTokens.text3,
  };
  return TextStyler(style: token.mix())
      .fontWeight(FortalTokens.fontWeightRegular())
      .color(color ?? FortalTokens.gray12());
}

Radius _fortalSelectTriggerRadius(FortalSelectSize size) => switch (size) {
  .size1 => FortalTokens.radius1OrFull(),
  .size2 => FortalTokens.radius2OrFull(),
  .size3 => FortalTokens.radius3OrFull(),
};

RemixSelectTriggerStyler _fortalSelectTriggerSizeStyler(
  FortalSelectTriggerVariant variant,
  FortalSelectSize size,
) {
  final style = RemixSelectTriggerStyler().spacing(switch (size) {
    .size1 => FortalTokens.space1(),
    .size2 => FortalTokens.selectSpace1Half(),
    .size3 => FortalTokens.space2(),
  });
  if (variant == .ghost) {
    return switch (size) {
      .size1 || .size2 =>
        style
            .paddingX(FortalTokens.space2())
            .paddingY(FortalTokens.space1())
            .marginX(FortalTokens.selectGhostMarginX12())
            .marginY(FortalTokens.selectGhostMarginY12()),
      .size3 =>
        style
            .paddingX(FortalTokens.space3())
            .paddingY(FortalTokens.selectSpace1Half())
            .marginX(FortalTokens.selectGhostMarginX3())
            .marginY(FortalTokens.selectGhostMarginY3()),
    };
  }
  return switch (size) {
    .size1 =>
      style.height(FortalTokens.space5()).paddingX(FortalTokens.space2()),
    .size2 =>
      style.height(FortalTokens.space6()).paddingX(FortalTokens.space3()),
    .size3 =>
      style.height(FortalTokens.space7()).paddingX(FortalTokens.space4()),
  };
}

RemixSurfaceLayerMix _fortalSelectFocusRing() {
  return RemixSurfaceLayerMix(
    shadows: [
      RemixPaintShadowMix(color: FortalTokens.focus8(), spreadRadius: 1),
      RemixPaintShadowMix(
        kind: RemixPaintShadowKind.inset,
        color: FortalTokens.focus8(),
        spreadRadius: 1,
      ),
    ],
  );
}

RemixSurfaceLayerMix _fortalSelectInsetStroke(Color color) {
  return RemixSurfaceLayerMix(
    shadows: [
      RemixPaintShadowMix(
        kind: RemixPaintShadowKind.inset,
        color: color,
        spreadRadius: 1,
      ),
    ],
  );
}

RemixSelectTriggerStyler _fortalSelectSurfaceTrigger(
  RemixSelectTriggerStyler base,
) {
  return base
      .chevronOpacity(0.9)
      .color(FortalTokens.colorSurface())
      .effects(
        RemixSurfaceEffectsMix(
          background: _fortalSelectInsetStroke(
            FortalTokens.grayA7(),
          ).merge(RemixSurfaceLayerMix()),
        ),
      )
      .onHovered(
        RemixSelectTriggerStyler().effects(
          RemixSurfaceEffectsMix(
            background: _fortalSelectInsetStroke(FortalTokens.grayA8()),
          ),
        ),
      )
      .onSelected(
        RemixSelectTriggerStyler().effects(
          RemixSurfaceEffectsMix(
            background: _fortalSelectInsetStroke(FortalTokens.grayA8()),
          ),
        ),
      )
      .onDisabled(
        RemixSelectTriggerStyler()
            .color(FortalTokens.grayA2())
            .label(TextStyler().color(FortalTokens.grayA11()))
            .icon(IconStyler(color: FortalTokens.grayA9()))
            .chevron(IconStyler(color: FortalTokens.grayA9()))
            .effects(
              RemixSurfaceEffectsMix(
                background: _fortalSelectInsetStroke(
                  FortalTokens.grayA6(),
                ).merge(RemixSurfaceLayerMix()),
              ),
            ),
      );
}

RemixSelectTriggerStyler _fortalSelectClassicTrigger(
  RemixSelectTriggerStyler base,
) {
  final idleSurface = RemixSurfaceLayerMix(
    gradients: _fortalSelectClassicGradients(hovered: false),
    gradientInsets: const [2, 2, 0],
    shadowToken: FortalTokens.selectTriggerClassicShadows,
  );
  final hoverSurface = RemixSurfaceLayerMix(
    gradients: _fortalSelectClassicGradients(hovered: true),
    gradientInsets: const [2, 2, 0],
    shadowToken: FortalTokens.selectTriggerClassicHoverShadows,
  );
  final disabledSurface = RemixSurfaceLayerMix(
    gradients: [
      RemixLinearGradientMix(
        colors: [
          FortalTokens.blackA1(),
          Colors.transparent,
          FortalTokens.whiteA1(),
        ],
        stops: const [-0.2, 0.5, 1],
      ),
      RemixLinearGradientMix(
        colors: [FortalTokens.grayA2(), FortalTokens.grayA2()],
      ),
    ],
    gradientInsets: const [2, 2],
    shadowToken: FortalTokens.baseButtonClassicDisabledShadows,
  );
  return base
      .chevronOpacity(0.9)
      .color(FortalTokens.gray1())
      .effects(RemixSurfaceEffectsMix(background: idleSurface))
      .onHovered(
        RemixSelectTriggerStyler().effects(
          RemixSurfaceEffectsMix(background: hoverSurface),
        ),
      )
      .onSelected(
        RemixSelectTriggerStyler().effects(
          RemixSurfaceEffectsMix(background: hoverSurface),
        ),
      )
      .onDisabled(
        RemixSelectTriggerStyler()
            .color(FortalTokens.gray2())
            .label(TextStyler().color(FortalTokens.grayA11()))
            .icon(IconStyler(color: FortalTokens.grayA9()))
            .chevron(IconStyler(color: FortalTokens.grayA9()))
            .effects(RemixSurfaceEffectsMix(background: disabledSurface)),
      );
}

List<RemixLinearGradientMix> _fortalSelectClassicGradients({
  required bool hovered,
}) {
  return [
    RemixLinearGradientMix(
      colors: [
        FortalTokens.blackA1(),
        Colors.transparent,
        FortalTokens.whiteA1(),
      ],
      stops: [hovered ? -0.15 : -0.2, 0.5, hovered ? 1.2 : 1.3],
    ),
    RemixLinearGradientMix(
      colors: hovered
          ? [FortalTokens.gray2(), FortalTokens.gray1()]
          : [FortalTokens.colorSurface(), Colors.transparent],
    ),
    RemixLinearGradientMix(
      colors: [FortalTokens.gray2(), FortalTokens.gray1()],
    ),
  ];
}

RemixSelectTriggerStyler _fortalSelectSoftTrigger(
  RemixSelectTriggerStyler base,
) {
  return base
      .label(TextStyler().color(FortalTokens.accent12()))
      .placeholder(TextStyler().color(FortalTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(IconStyler(color: FortalTokens.accent12()))
      .chevron(IconStyler(color: FortalTokens.accent12()))
      .color(FortalTokens.accentA3())
      .onHovered(RemixSelectTriggerStyler().color(FortalTokens.accentA4()))
      .onSelected(RemixSelectTriggerStyler().color(FortalTokens.accentA4()))
      .onDisabled(
        RemixSelectTriggerStyler()
            .label(TextStyler().color(FortalTokens.grayA11()))
            .icon(IconStyler(color: FortalTokens.grayA9()))
            .chevron(IconStyler(color: FortalTokens.grayA9()))
            .color(FortalTokens.grayA3()),
      );
}

RemixSelectTriggerStyler _fortalSelectGhostTrigger(
  RemixSelectTriggerStyler base,
) {
  return base
      .label(TextStyler().color(FortalTokens.accent12()))
      .placeholder(TextStyler().color(FortalTokens.accent12()))
      .placeholderOpacity(0.6)
      .icon(IconStyler(color: FortalTokens.accent12()))
      .chevron(IconStyler(color: FortalTokens.accent12()))
      .color(Colors.transparent)
      .onHovered(RemixSelectTriggerStyler().color(FortalTokens.accentA3()))
      .onSelected(RemixSelectTriggerStyler().color(FortalTokens.accentA3()))
      .onDisabled(
        RemixSelectTriggerStyler()
            .label(TextStyler().color(FortalTokens.grayA11()))
            .icon(IconStyler(color: FortalTokens.grayA9()))
            .chevron(IconStyler(color: FortalTokens.grayA9()))
            .color(Colors.transparent),
      );
}

RemixSelectContentStyler _fortalSelectContentStyler(FortalSelectSize size) {
  final radius = size == .size1
      ? FortalTokens.radius3()
      : FortalTokens.radius4();
  return RemixSelectContentStyler()
      .paddingAll(
        size == .size1 ? FortalTokens.space1() : FortalTokens.space2(),
      )
      .borderRadiusAll(radius)
      .color(FortalTokens.colorPanel())
      .clipBehavior(Clip.antiAlias)
      .effects(
        RemixSurfaceEffectsMix(
          backdropBlur: FortalTokens.panelBlur(),
          background: RemixSurfaceLayerMix(shadowToken: FortalTokens.shadow5),
        ),
      );
}

RemixSelectMenuItemStyler _fortalSelectItemStyler(
  FortalSelectContentVariant variant,
  FortalSelectSize size, {
  required bool highContrast,
}) {
  final metrics = _fortalSelectContentMetrics(size);
  final base = RemixSelectMenuItemStyler()
      .direction(.horizontal)
      .crossAxisAlignment(.center)
      .height(metrics.itemHeight)
      .paddingX(metrics.indicatorWidth)
      .borderRadiusAll(metrics.itemRadius)
      .text(
        TextStyler(style: metrics.itemText.mix()).color(FortalTokens.gray12()),
      )
      .indicator(
        BoxStyler(
          alignment: .center,
          constraints: BoxConstraintsMix.width(metrics.indicatorWidth),
        ),
      )
      .icon(
        IconStyler(color: FortalTokens.gray12(), size: metrics.indicatorSize),
      );

  final highlighted = switch (variant) {
    .solid =>
      RemixSelectMenuItemStyler()
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .text(
            TextStyler().color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .iconColor(
            highContrast
                ? FortalTokens.accent1()
                : FortalTokens.accentContrast(),
          ),
    .soft => RemixSelectMenuItemStyler().color(FortalTokens.accentA4()),
  };

  return base
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(
        RemixSelectMenuItemStyler()
            .color(Colors.transparent)
            .text(TextStyler().color(FortalTokens.grayA8()))
            .iconColor(FortalTokens.grayA8()),
      );
}

RemixSelectLabelStyler _fortalSelectLabelStyler(FortalSelectSize size) {
  final metrics = _fortalSelectContentMetrics(size);
  return RemixSelectLabelStyler()
      .direction(.horizontal)
      .crossAxisAlignment(.center)
      .height(metrics.itemHeight)
      .paddingX(metrics.indicatorWidth)
      .text(
        TextStyler(
          style: metrics.labelText.mix(),
        ).color(FortalTokens.grayA10()),
      )
      .adjacentItemSpacing(FortalTokens.space2());
}

BoxStyler _fortalSelectSeparatorStyler(FortalSelectSize size) {
  final metrics = _fortalSelectContentMetrics(size);
  return BoxStyler()
      .height(1)
      .marginOnly(
        left: metrics.indicatorWidth,
        right: metrics.separatorMarginRight,
        top: FortalTokens.space2(),
        bottom: FortalTokens.space2(),
      )
      .color(FortalTokens.grayA6());
}

({
  double itemHeight,
  double indicatorWidth,
  double indicatorSize,
  double separatorMarginRight,
  Radius itemRadius,
  TextStyleToken itemText,
  TextStyleToken labelText,
})
_fortalSelectContentMetrics(FortalSelectSize size) => switch (size) {
  .size1 => (
    itemHeight: FortalTokens.space5(),
    indicatorWidth: FortalTokens.selectIndicatorWidth1(),
    indicatorSize: FortalTokens.selectIndicatorSize1(),
    separatorMarginRight: FortalTokens.space2(),
    itemRadius: FortalTokens.radius1(),
    itemText: FortalTokens.text1,
    labelText: FortalTokens.text1,
  ),
  .size2 => (
    itemHeight: FortalTokens.space6(),
    indicatorWidth: FortalTokens.space5(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    separatorMarginRight: FortalTokens.space3(),
    itemRadius: FortalTokens.radius2(),
    itemText: FortalTokens.text2,
    labelText: FortalTokens.text2,
  ),
  .size3 => (
    itemHeight: FortalTokens.space6(),
    indicatorWidth: FortalTokens.space5(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    separatorMarginRight: FortalTokens.space3(),
    itemRadius: FortalTokens.radius2(),
    itemText: FortalTokens.text3,
    labelText: FortalTokens.text2,
  ),
};

Widget _fortalSelectChevronBuilder(
  BuildContext context,
  StyleSpec<IconSpec> styleSpec,
) => RemixPathIcon(
  key: const ValueKey('fortal-select-chevron'),
  glyph: RemixPathGlyph.chevronDown,
  styleSpec: styleSpec,
);

Widget _fortalSelectIndicatorBuilder(
  BuildContext context,
  StyleSpec<IconSpec> styleSpec,
) => RemixPathIcon(
  key: const ValueKey('fortal-select-indicator'),
  glyph: RemixPathGlyph.thickCheck,
  styleSpec: styleSpec,
);

/// Fortal-themed Select with Radix-owned trigger and content configuration.
class FortalSelect<T> extends StatelessWidget {
  const FortalSelect({
    super.key,
    this.triggerVariant = .surface,
    this.contentVariant = .solid,
    this.size = .size2,
    this.triggerColor,
    this.triggerRadius,
    this.contentColor,
    this.contentHighContrast = false,
    required this.trigger,
    required this.entries,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
      sideOffset: 4,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.open,
    this.onOpenChanged,
    this.enabled = true,
    this.closeOnSelect = true,
    this.semanticLabel,
    this.focusNode,
  });

  final FortalSelectTriggerVariant triggerVariant;
  final FortalSelectContentVariant contentVariant;
  final FortalSelectSize size;
  final FortalAccentColor? triggerColor;
  final FortalRadius? triggerRadius;
  final FortalAccentColor? contentColor;
  final bool contentHighContrast;
  final RemixSelectTrigger trigger;
  final List<RemixSelectEntry<T>> entries;
  final T? selectedValue;
  final OverlayPositionConfig positioning;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final bool? open;
  final ValueChanged<bool>? onOpenChanged;
  final bool enabled;
  final bool closeOnSelect;
  final String? semanticLabel;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return fortalSelectStyler(
      triggerVariant: triggerVariant,
      contentVariant: contentVariant,
      size: size,
      contentHighContrast: contentHighContrast,
    ).call<T>(
      trigger: trigger,
      entries: entries,
      selectedValue: selectedValue,
      positioning: positioning,
      onChanged: onChanged,
      onOpen: onOpen,
      onClose: onClose,
      open: open,
      onOpenChanged: onOpenChanged,
      enabled: enabled,
      closeOnSelect: closeOnSelect,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      triggerWrapper: (context, child) => FortalComponentOverride(
        color: triggerColor,
        radius: triggerRadius,
        child: child,
      ),
      contentWrapper: (context, child) =>
          FortalComponentOverride(color: contentColor, child: child),
      triggerChevronBuilder: _fortalSelectChevronBuilder,
      itemIndicatorBuilder: _fortalSelectIndicatorBuilder,
    );
  }
}
