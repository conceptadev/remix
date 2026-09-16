import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'menu.g.dart';

/// Radix Themes menu content sizes.
enum UiMenuSize { size1, size2 }

/// Radix Themes menu content variants.
enum UiMenuVariant { solid, soft }

/// Ui menu content with Radix-owned size, variant, and contrast behavior.
@MixWidget(target: RemixMenu.new)
MenuStyler uiMenuStyle({
  UiMenuVariant variant = .solid,
  UiMenuSize size = .size2,
  bool highContrast = false,
  MenuStyler style = const MenuStyler.create(),
}) {
  final metrics = _uiMenuMetrics(size);
  final base = MenuStyler()
      .trigger(_uiMenuTriggerStyler(metrics))
      .overlay(
        FlexBoxStyler()
            .padding(.all(metrics.contentPadding))
            .borderRadius(.all(metrics.contentRadius))
            // Radix pins menus to the solid panel with no backdrop blur,
            // even when the theme panel background is translucent.
            .color(UiTokens.colorPanelSolid())
            .decoration(
              BoxDecorationMix.create(boxShadow: UiTokens.shadow5.mix()),
            )
            .clipBehavior(Clip.antiAlias),
      )
      .item(_uiMenuItemStyler(variant, metrics, highContrast: highContrast))
      .submenuItem(
        _uiMenuSubmenuItemStyler(variant, metrics, highContrast: highContrast),
      )
      .divider(_uiMenuDividerStyler(metrics));

  return base.merge(style);
}

/// Ui item recipe for per-item style overrides.
MenuItemStyler uiMenuItemStyle({
  UiMenuVariant variant = .solid,
  UiMenuSize size = .size2,
  bool highContrast = false,
}) => _uiMenuItemStyler(
  variant,
  _uiMenuMetrics(size),
  highContrast: highContrast,
);

/// Radix has no menu-owned trigger; this mirrors the base Radix button
/// content treatment (gap, text token, icon) without button chrome.
MenuTriggerStyler _uiMenuTriggerStyler(_UiMenuMetrics metrics) =>
    MenuTriggerStyler()
        .spacing(metrics.triggerGap)
        .label(.style(metrics.text.mix()).color(UiTokens.gray12()))
        .icon(.color(UiTokens.gray12()).size(metrics.contentIconSize));

MenuItemStyler _uiMenuItemStyler(
  UiMenuVariant variant,
  _UiMenuMetrics metrics, {
  required bool highContrast,
}) {
  final base = MenuItemStyler()
      .direction(.horizontal)
      .spacing(UiTokens.space2())
      .height(metrics.itemHeight)
      .padding(.horizontal(metrics.leadingInset))
      .borderRadius(.all(metrics.itemRadius))
      .label(.style(metrics.text.mix()).color(UiTokens.gray12()))
      // Radix pins only indicator/subtrigger icons (8/10px); content icons
      // follow the repo-wide text-matched sizes used by tabs and toggles.
      .leadingIcon(.color(UiTokens.gray12()).size(metrics.contentIconSize))
      .trailingIcon(.color(UiTokens.grayA11()).size(metrics.contentIconSize))
      .indicator(.color(UiTokens.gray12()).size(metrics.indicatorSize));
  final highlighted = _uiMenuHighlightedItemStyler(
    variant,
    highContrast: highContrast,
  );
  final disabled = MenuItemStyler()
      .color(const Color(0x00000000))
      .label(.color(UiTokens.grayA8()))
      .leadingIcon(.color(UiTokens.grayA8()))
      .trailingIcon(.color(UiTokens.grayA8()))
      .indicator(.color(UiTokens.grayA8()));

  // Naked's focused item is Radix's roving `data-highlighted` item, not a
  // CSS focus ring, so this intentionally follows raw focus.
  return base
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(disabled);
}

MenuItemStyler _uiMenuHighlightedItemStyler(
  UiMenuVariant variant, {
  required bool highContrast,
}) {
  final solidForeground = highContrast
      ? UiTokens.accent1()
      : UiTokens.accentContrast();

  return switch (variant) {
    .solid =>
      MenuItemStyler()
          .color(highContrast ? UiTokens.accent12() : UiTokens.accent9())
          .label(.color(solidForeground))
          .leadingIcon(.color(solidForeground))
          .trailingIcon(.color(solidForeground))
          .indicator(.color(solidForeground)),
    .soft =>
      MenuItemStyler()
          .color(UiTokens.accentA4())
          .trailingIcon(.color(UiTokens.gray12())),
  };
}

MenuItemStyler _uiMenuSubmenuItemStyler(
  UiMenuVariant variant,
  _UiMenuMetrics metrics, {
  required bool highContrast,
}) {
  final highlighted = _uiMenuHighlightedItemStyler(
    variant,
    highContrast: highContrast,
  );
  final submenuOpen = MenuItemStyler()
      .color(switch (variant) {
        .solid => UiTokens.grayA3(),
        .soft => UiTokens.accentA3(),
      })
      .onHovered(highlighted)
      // Roving `data-highlighted` state, not a focus-visible ring.
      .onFocused(highlighted)
      .onPressed(highlighted);

  // The chevron keeps the exact Radix subtrigger icon size even though
  // content trailing icons are text-matched.
  return MenuItemStyler()
      .trailingIcon(.color(UiTokens.gray12()).size(metrics.indicatorSize))
      .onSelected(submenuOpen);
}

DividerStyler _uiMenuDividerStyler(_UiMenuMetrics metrics) => DividerStyler()
    .height(1)
    .margin(
      .only(
        left: metrics.leadingInset,
        right: metrics.trailingInset,
        top: UiTokens.space2(),
        bottom: UiTokens.space2(),
      ),
    )
    .color(UiTokens.grayA6());

class _UiMenuMetrics {
  const _UiMenuMetrics({
    required this.contentPadding,
    required this.contentRadius,
    required this.itemHeight,
    required this.itemRadius,
    required this.leadingInset,
    required this.trailingInset,
    required this.indicatorSize,
    required this.contentIconSize,
    required this.triggerGap,
    required this.text,
  });

  final double contentPadding;
  final Radius contentRadius;
  final double itemHeight;
  final Radius itemRadius;
  final double leadingInset;
  final double trailingInset;
  final double indicatorSize;
  final double contentIconSize;
  final double triggerGap;
  final TextStyleToken text;
}

_UiMenuMetrics _uiMenuMetrics(UiMenuSize size) => switch (size) {
  .size1 => _UiMenuMetrics(
    contentPadding: UiTokens.space1(),
    contentRadius: UiTokens.radius3(),
    itemHeight: UiTokens.space5(),
    itemRadius: UiTokens.radius1(),
    leadingInset: UiTokens.space2(),
    trailingInset: UiTokens.space2(),
    indicatorSize: UiTokens.selectIndicatorSize1(),
    contentIconSize: UiTokens.space3(),
    triggerGap: UiTokens.space1(),
    text: UiTokens.text1,
  ),
  .size2 => _UiMenuMetrics(
    contentPadding: UiTokens.space2(),
    contentRadius: UiTokens.radius4(),
    itemHeight: UiTokens.space6(),
    itemRadius: UiTokens.radius2(),
    leadingInset: UiTokens.space3(),
    trailingInset: UiTokens.space3(),
    indicatorSize: UiTokens.selectIndicatorSize2(),
    contentIconSize: UiTokens.space4(),
    triggerGap: UiTokens.space2(),
    text: UiTokens.text2,
  ),
};
