import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'menu.g.dart';

/// Radix Themes menu content sizes.
enum FortalMenuSize { size1, size2 }

/// Radix Themes menu content variants.
enum FortalMenuVariant { solid, soft }

/// Fortal menu content with Radix-owned size, variant, and contrast behavior.
@MixWidget(target: RemixMenu.new)
MenuStyler fortalMenuStyle({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) {
  final metrics = _fortalMenuMetrics(size);
  final base = MenuStyler()
      .trigger(_fortalMenuTriggerStyler(metrics))
      .overlay(
        FlexBoxStyler()
            .padding(.all(metrics.contentPadding))
            .borderRadius(.all(metrics.contentRadius))
            // Radix pins menus to the solid panel with no backdrop blur,
            // even when the theme panel background is translucent.
            .color(FortalTokens.colorPanelSolid())
            .decoration(
              BoxDecorationMix.create(boxShadow: FortalTokens.shadow5.mix()),
            )
            .clipBehavior(Clip.antiAlias),
      )
      .item(_fortalMenuItemStyler(variant, metrics, highContrast: highContrast))
      .submenuItem(
        _fortalMenuSubmenuItemStyler(
          variant,
          metrics,
          highContrast: highContrast,
        ),
      )
      .divider(_fortalMenuDividerStyler(metrics));

  return base;
}

/// Fortal item recipe for per-item style overrides.
MenuItemStyler fortalMenuItemStyle({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
  bool highContrast = false,
}) => _fortalMenuItemStyler(
  variant,
  _fortalMenuMetrics(size),
  highContrast: highContrast,
);

/// Radix has no menu-owned trigger; this mirrors the base Radix button
/// content treatment (gap, text token, icon) without button chrome.
MenuTriggerStyler _fortalMenuTriggerStyler(_FortalMenuMetrics metrics) =>
    MenuTriggerStyler()
        .crossAxisAlignment(.center)
        .spacing(metrics.triggerGap)
        .label(.style(metrics.text.mix()).color(FortalTokens.gray12()))
        .icon(.color(FortalTokens.gray12()).size(metrics.contentIconSize));

MenuItemStyler _fortalMenuItemStyler(
  FortalMenuVariant variant,
  _FortalMenuMetrics metrics, {
  required bool highContrast,
}) {
  final base = MenuItemStyler()
      .direction(.horizontal)
      .mainAxisSize(.max)
      .crossAxisAlignment(.center)
      .spacing(FortalTokens.space2())
      .height(metrics.itemHeight)
      .padding(.horizontal(metrics.leadingInset))
      .borderRadius(.all(metrics.itemRadius))
      .label(.style(metrics.text.mix()).color(FortalTokens.gray12()))
      // Radix pins only indicator/subtrigger icons (8/10px); content icons
      // follow the repo-wide text-matched sizes used by tabs and toggles.
      .leadingIcon(.color(FortalTokens.gray12()).size(metrics.contentIconSize))
      .trailingIcon(
        .color(FortalTokens.grayA11()).size(metrics.contentIconSize),
      )
      .indicator(.color(FortalTokens.gray12()).size(metrics.indicatorSize));
  final highlighted = _fortalMenuHighlightedItemStyler(
    variant,
    highContrast: highContrast,
  );
  final disabled = MenuItemStyler()
      .color(const Color(0x00000000))
      .label(.color(FortalTokens.grayA8()))
      .leadingIcon(.color(FortalTokens.grayA8()))
      .trailingIcon(.color(FortalTokens.grayA8()))
      .indicator(.color(FortalTokens.grayA8()));

  // Naked's focused item is Radix's roving `data-highlighted` item, not a
  // CSS focus ring, so this intentionally follows raw focus.
  return base
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(disabled);
}

MenuItemStyler _fortalMenuHighlightedItemStyler(
  FortalMenuVariant variant, {
  required bool highContrast,
}) {
  final solidForeground = highContrast
      ? FortalTokens.accent1()
      : FortalTokens.accentContrast();

  return switch (variant) {
    .solid =>
      MenuItemStyler()
          .color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent9(),
          )
          .label(.color(solidForeground))
          .leadingIcon(.color(solidForeground))
          .trailingIcon(.color(solidForeground))
          .indicator(.color(solidForeground)),
    .soft =>
      MenuItemStyler()
          .color(FortalTokens.accentA4())
          .trailingIcon(.color(FortalTokens.gray12())),
  };
}

MenuItemStyler _fortalMenuSubmenuItemStyler(
  FortalMenuVariant variant,
  _FortalMenuMetrics metrics, {
  required bool highContrast,
}) {
  final highlighted = _fortalMenuHighlightedItemStyler(
    variant,
    highContrast: highContrast,
  );
  final submenuOpen = MenuItemStyler()
      .color(switch (variant) {
        .solid => FortalTokens.grayA3(),
        .soft => FortalTokens.accentA3(),
      })
      .onHovered(highlighted)
      // Roving `data-highlighted` state, not a focus-visible ring.
      .onFocused(highlighted)
      .onPressed(highlighted);

  // The chevron keeps the exact Radix subtrigger icon size even though
  // content trailing icons are text-matched.
  return MenuItemStyler()
      .trailingIcon(.color(FortalTokens.gray12()).size(metrics.indicatorSize))
      .onSelected(submenuOpen);
}

DividerStyler _fortalMenuDividerStyler(_FortalMenuMetrics metrics) =>
    DividerStyler()
        .height(1)
        .margin(
          .only(
            left: metrics.leadingInset,
            right: metrics.trailingInset,
            top: FortalTokens.space2(),
            bottom: FortalTokens.space2(),
          ),
        )
        .color(FortalTokens.grayA6());

class _FortalMenuMetrics {
  const _FortalMenuMetrics({
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

_FortalMenuMetrics _fortalMenuMetrics(FortalMenuSize size) => switch (size) {
  .size1 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space1(),
    contentRadius: FortalTokens.radius3(),
    itemHeight: FortalTokens.space5(),
    itemRadius: FortalTokens.radius1(),
    leadingInset: FortalTokens.space2(),
    trailingInset: FortalTokens.space2(),
    indicatorSize: FortalTokens.selectIndicatorSize1(),
    contentIconSize: FortalTokens.space3(),
    triggerGap: FortalTokens.space1(),
    text: FortalTokens.text1,
  ),
  .size2 => _FortalMenuMetrics(
    contentPadding: FortalTokens.space2(),
    contentRadius: FortalTokens.radius4(),
    itemHeight: FortalTokens.space6(),
    itemRadius: FortalTokens.radius2(),
    leadingInset: FortalTokens.space3(),
    trailingInset: FortalTokens.space3(),
    indicatorSize: FortalTokens.selectIndicatorSize2(),
    contentIconSize: FortalTokens.space4(),
    triggerGap: FortalTokens.space2(),
    text: FortalTokens.text2,
  ),
};
