import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_menu.g.dart';

/// Sizes supported by Carbon menu rows.
enum CarbonMenuSize { xSmall, small, medium, large }

typedef CarbonMenuTrigger = RemixMenuTrigger;
typedef CarbonMenuItemData<T> = RemixMenuItemData<T>;
typedef CarbonMenuItem<T> = RemixMenuItem<T>;
typedef CarbonMenuCheckboxItem<T> = RemixMenuCheckboxItem<T>;
typedef CarbonMenuRadioGroup<T> = RemixMenuRadioGroup<T>;
typedef CarbonMenuRadioItem<T> = RemixMenuRadioItem<T>;
typedef CarbonMenuSubmenu<T> = RemixMenuSubmenu<T>;
typedef CarbonMenuDivider<T> = RemixMenuDivider<T>;

const _carbonMenuLayer = ContextToken(_resolveCarbonMenuLayer);
const _carbonMenuHover = ContextToken(_resolveCarbonMenuHover);
const _carbonMenuBorder = ContextToken(_resolveCarbonMenuBorder);

Color _resolveCarbonMenuLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonMenuHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

Color _resolveCarbonMenuBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

double _carbonMenuItemHeight(CarbonMenuSize size) => switch (size) {
  .xSmall => CarbonTokens.sizeXSmall(),
  .small => CarbonTokens.sizeSmall(),
  .medium => CarbonTokens.sizeMedium(),
  .large => CarbonTokens.sizeLarge(),
};

/// Carbon menu recipe generated over [RemixMenu].
@MixWidget(target: RemixMenu.new)
MenuStyler carbonMenuStyle({CarbonMenuSize size = .small}) {
  final itemHeight = _carbonMenuItemHeight(size);
  final item = carbonMenuItemStyle(size: size);

  return MenuStyler()
      .trigger(
        MenuTriggerStyler()
            .height(CarbonTokens.sizeMedium())
            .padding(
              EdgeInsetsGeometryMix.directional(
                start: CarbonTokens.spacing05(),
                end: CarbonTokens.spacing05(),
              ),
            )
            .crossAxisAlignment(.center)
            .spacing(CarbonTokens.spacing03())
            .label(
              .style(
                CarbonTokens.bodyCompact01.mix(),
              ).color(CarbonTokens.textPrimary()),
            )
            .icon(
              .size(
                CarbonTokens.iconSize01(),
              ).color(CarbonTokens.iconPrimary()),
            ),
      )
      .overlay(
        FlexBoxStyler()
            .minWidth(160)
            .maxWidth(288)
            .padding(.vertical(CarbonTokens.spacing02()))
            .color(_carbonMenuLayer())
            .border(
              BoxBorderMix.all(
                BorderSideMix(color: _carbonMenuBorder(), width: 1),
              ),
            )
            .decoration(
              BoxDecorationMix.boxShadow([
                BoxShadowMix(
                  color: CarbonTokens.shadow(),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ]),
            )
            .clipBehavior(.antiAlias),
      )
      .item(item.height(itemHeight))
      .checkboxItem(item.height(itemHeight))
      .radioItem(item.height(itemHeight))
      .submenuItem(item.height(itemHeight))
      .divider(
        DividerStyler()
            .height(1)
            .margin(.vertical(CarbonTokens.spacing02()))
            .color(_carbonMenuBorder()),
      );
}

/// Shared Carbon menu-item recipe for menu-wide and per-item styling.
MenuItemStyler carbonMenuItemStyle({CarbonMenuSize size = .small}) {
  final itemHeight = _carbonMenuItemHeight(size);
  final highlighted = MenuItemStyler()
      .color(_carbonMenuHover())
      .label(.color(CarbonTokens.textPrimary()))
      .leadingIcon(.color(CarbonTokens.iconPrimary()))
      .trailingIcon(.color(CarbonTokens.iconPrimary()))
      .indicator(.color(CarbonTokens.iconPrimary()));

  return MenuItemStyler()
      .direction(.horizontal)
      .mainAxisSize(.max)
      .crossAxisAlignment(.center)
      .height(itemHeight)
      .padding(.horizontal(CarbonTokens.spacing05()))
      .spacing(CarbonTokens.spacing03())
      .label(
        .style(
          CarbonTokens.bodyShort01.mix(),
        ).color(CarbonTokens.textSecondary()),
      )
      .leadingIcon(
        .size(CarbonTokens.iconSize01()).color(CarbonTokens.iconSecondary()),
      )
      .trailingIcon(
        .size(CarbonTokens.iconSize01()).color(CarbonTokens.iconSecondary()),
      )
      .indicator(
        .size(CarbonTokens.iconSize01()).color(CarbonTokens.iconPrimary()),
      )
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onDisabled(
        MenuItemStyler()
            .color(_carbonMenuLayer())
            .label(.color(CarbonTokens.textDisabled()))
            .leadingIcon(.color(CarbonTokens.iconDisabled()))
            .trailingIcon(.color(CarbonTokens.iconDisabled()))
            .indicator(.color(CarbonTokens.iconDisabled())),
      );
}
