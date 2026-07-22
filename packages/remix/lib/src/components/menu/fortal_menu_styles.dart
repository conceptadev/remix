part of 'menu.dart';

/// Radix Themes menu content sizes.
enum FortalMenuSize { size1, size2 }

/// Radix Themes menu content variants.
enum FortalMenuVariant { solid, soft }

/// Fortal recipe for menu content and every structured entry type.
RemixMenuStyler fortalMenuStyler({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalMenuMetrics(size);
  return RemixMenuStyler()
      .overlay(
        FlexBoxStyler()
            .paddingAll(metrics.contentPadding)
            .borderRadiusAll(metrics.contentRadius)
            .color(FortalTokens.colorPanel())
            .clipBehavior(Clip.antiAlias),
      )
      .effects(
        RemixSurfaceEffectsMix(
          backdropBlur: FortalTokens.panelBlur(),
          background: RemixSurfaceLayerMix(shadowToken: FortalTokens.shadow5),
        ),
      )
      .item(_fortalMenuItemStyler(variant, metrics, highContrast: highContrast))
      .label(_fortalMenuLabelStyler(metrics))
      .divider(_fortalMenuDividerStyler(metrics));
}

/// Fortal item recipe for per-entry style overrides.
RemixMenuItemStyler fortalMenuItemStyler({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) => _fortalMenuItemStyler(
  variant,
  _fortalMenuMetrics(size),
  highContrast: highContrast,
);

RemixMenuItemStyler _fortalMenuItemStyler(
  FortalMenuVariant variant,
  _FortalMenuMetrics metrics, {
  required bool highContrast,
}) {
  final base = RemixMenuItemStyler()
      .direction(.horizontal)
      .mainAxisSize(.max)
      .crossAxisAlignment(.center)
      .spacing(FortalTokens.space2())
      .height(metrics.itemHeight)
      .borderRadiusAll(metrics.itemRadius)
      .label(TextStyler(style: metrics.text.mix()).color(FortalTokens.gray12()))
      .leadingIcon(
        IconStyler(color: FortalTokens.gray12(), size: metrics.indicatorSize),
      )
      .trailingIcon(
        IconStyler(color: FortalTokens.gray12(), size: metrics.indicatorSize),
      )
      .indicator(BoxStyler().alignment(.center))
      .indicatorIcon(
        IconStyler(color: FortalTokens.gray12(), size: metrics.indicatorSize),
      )
      .leadingInset(metrics.leadingInset)
      .checkableLeadingInset(metrics.checkableLeadingInset)
      .trailingInset(metrics.trailingInset);

  final highlighted = switch (variant) {
    .solid =>
      RemixMenuItemStyler()
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .label(
            TextStyler().color(
              highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .leadingIcon(
            IconStyler(
              color: highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .trailingIcon(
            IconStyler(
              color: highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          )
          .indicatorIcon(
            IconStyler(
              color: highContrast
                  ? FortalTokens.accent1()
                  : FortalTokens.accentContrast(),
            ),
          ),
    .soft => RemixMenuItemStyler().color(FortalTokens.accentA4()),
  };
  final submenuOpen = RemixMenuItemStyler().color(
    variant == .solid ? FortalTokens.grayA3() : FortalTokens.accentA3(),
  );
  final disabled = RemixMenuItemStyler()
      .color(Colors.transparent)
      .label(TextStyler().color(FortalTokens.grayA8()))
      .leadingIcon(IconStyler(color: FortalTokens.grayA8()))
      .trailingIcon(IconStyler(color: FortalTokens.grayA8()))
      .indicatorIcon(IconStyler(color: FortalTokens.grayA8()));

  return base
      .onSelected(submenuOpen)
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(disabled);
}

RemixMenuItemStyler _fortalMenuLabelStyler(_FortalMenuMetrics metrics) =>
    RemixMenuItemStyler()
        .direction(.horizontal)
        .mainAxisSize(.max)
        .crossAxisAlignment(.center)
        .height(metrics.itemHeight)
        .label(
          TextStyler(style: metrics.text.mix()).color(FortalTokens.grayA10()),
        )
        .leadingInset(metrics.leadingInset)
        .checkableLeadingInset(metrics.checkableLeadingInset)
        .trailingInset(metrics.trailingInset)
        .adjacentItemSpacing(FortalTokens.space2());

RemixDividerStyler _fortalMenuDividerStyler(_FortalMenuMetrics metrics) =>
    RemixDividerStyler()
        .height(1)
        .marginOnly(
          left: metrics.leadingInset,
          right: metrics.trailingInset,
          top: FortalTokens.space2(),
          bottom: FortalTokens.space2(),
        )
        .color(FortalTokens.grayA6());

class _FortalMenuMetrics {
  const _FortalMenuMetrics({
    required this.contentPadding,
    required this.contentRadius,
    required this.itemHeight,
    required this.itemRadius,
    required this.leadingInset,
    required this.checkableLeadingInset,
    required this.trailingInset,
    required this.indicatorSize,
    required this.text,
  });

  final double contentPadding;
  final Radius contentRadius;
  final double itemHeight;
  final Radius itemRadius;
  final double leadingInset;
  final double checkableLeadingInset;
  final double trailingInset;
  final double indicatorSize;
  final TextStyleToken text;
}

_FortalMenuMetrics _fortalMenuMetrics(FortalMenuSize size) => switch (size) {
  .size1 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space1(),
    contentRadius: FortalTokens.radius3(),
    itemHeight: FortalTokens.space5(),
    itemRadius: FortalTokens.radius1(),
    leadingInset: FortalTokens.space2(),
    checkableLeadingInset: FortalTokens.selectIndicatorWidth1(),
    trailingInset: FortalTokens.space2(),
    indicatorSize: FortalTokens.selectIndicatorSize1(),
    text: FortalTokens.text1,
  ),
  .size2 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space2(),
    contentRadius: FortalTokens.radius4(),
    itemHeight: FortalTokens.space6(),
    itemRadius: FortalTokens.radius2(),
    leadingInset: FortalTokens.space3(),
    checkableLeadingInset: FortalTokens.space5(),
    trailingInset: FortalTokens.space3(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    text: FortalTokens.text2,
  ),
};

OverlayPositionConfig _fortalMenuSubmenuPositioning(
  FortalMenuSize size,
  TextDirection direction,
) => OverlayPositionConfig(
  side: direction == TextDirection.rtl ? OverlaySide.left : OverlaySide.right,
  alignment: OverlayAlignment.start,
  sideOffset: 1,
  alignmentOffset: size == .size1 ? -4 : -8,
  collisionPadding: const EdgeInsets.all(10),
);

/// Fortal menu content with Radix-owned size, variant, and contrast behavior.
class FortalMenu<T> extends StatelessWidget {
  const FortalMenu({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.highContrast = false,
    required this.trigger,
    required this.entries,
    this.controller,
    this.onSelected,
    this.onOpen,
    this.onClose,
    this.onCanceled,
    this.onOpenRequested,
    this.onCloseRequested,
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.closeOnClickOutside = true,
    this.triggerFocusNode,
    this.positioning = const OverlayPositionConfig(
      side: OverlaySide.bottom,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
      collisionPadding: EdgeInsets.all(10),
    ),
    this.submenuPositioning,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalMenuVariant variant;
  final FortalMenuSize size;

  /// Optional accent color override for menu content and items.
  final FortalAccentColor? color;

  /// Whether solid highlights use accent step 12 and accent step 1.
  final bool highContrast;

  final Widget trigger;
  final List<Widget> entries;
  final MenuController? controller;
  final ValueChanged<T>? onSelected;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final VoidCallback? onCanceled;
  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;
  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;
  final bool consumeOutsideTaps;
  final bool useRootOverlay;
  final bool closeOnClickOutside;
  final FocusNode? triggerFocusNode;
  final OverlayPositionConfig positioning;
  final OverlayPositionConfig? submenuPositioning;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) =>
      fortalMenuStyler(
        variant: variant,
        size: size,
        highContrast: highContrast,
      ).call<T>(
        key: key,
        trigger: trigger,
        entries: entries,
        controller: controller,
        onSelected: onSelected,
        onOpen: onOpen,
        onClose: onClose,
        onCanceled: onCanceled,
        onOpenRequested: onOpenRequested,
        onCloseRequested: onCloseRequested,
        consumeOutsideTaps: consumeOutsideTaps,
        useRootOverlay: useRootOverlay,
        closeOnClickOutside: closeOnClickOutside,
        triggerFocusNode: triggerFocusNode,
        positioning: positioning,
        submenuPositioning:
            submenuPositioning ??
            _fortalMenuSubmenuPositioning(size, Directionality.of(context)),
        semanticLabel: semanticLabel,
        excludeSemantics: excludeSemantics,
        contentWrapper: (context, child) =>
            FortalComponentOverride(color: color, child: child),
      );
}
