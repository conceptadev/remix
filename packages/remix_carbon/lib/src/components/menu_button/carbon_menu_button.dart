import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_component_tokens.g.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_menu_size.dart';
import '../button/carbon_button.dart';
import '../menu/carbon_menu.dart';

/// A Carbon button that opens a typed action menu.
class CarbonMenuButton<T> extends StatelessWidget {
  const CarbonMenuButton({
    super.key,
    required this.label,
    required this.items,
    this.onSelected,
    this.kind = .primary,
    this.size = .lg,
    this.enabled = true,
    this.controller,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .end,
    ),
    this.onOpen,
    this.onClose,
  }) : assert(
         kind == .primary || kind == .tertiary || kind == .ghost,
         'CarbonMenuButton supports primary, tertiary, and ghost kinds.',
       );

  final String label;
  final List<RemixMenuItemData<T>> items;
  final ValueChanged<T>? onSelected;
  final CarbonButtonKind kind;
  final CarbonSize size;
  final bool enabled;
  final MenuController? controller;
  final OverlayPositionConfig positioning;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final menu =
        carbonMenuStyle(
          size: carbonMenuSizeFor(size),
        ).trigger(_carbonMenuButtonTriggerStyle(kind: kind, size: size))(
          trigger: RemixMenuTrigger(
            label: label,
            trailingIcon: CarbonIcons.chevronDown,
          ),
          items: items,
          controller: controller,
          onSelected: onSelected,
          onOpen: onOpen,
          onClose: onClose,
          positioning: positioning,
          semanticLabel: label,
        );

    if (enabled) return menu;

    return Semantics(
      button: true,
      enabled: false,
      label: label,
      child: ExcludeSemantics(child: IgnorePointer(child: menu)),
    );
  }
}

/// Carbon's compact overflow action menu.
class CarbonOverflowMenu<T> extends StatelessWidget {
  const CarbonOverflowMenu({
    super.key,
    required this.items,
    this.onSelected,
    this.semanticLabel = 'More options',
    this.enabled = true,
    this.controller,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .end,
    ),
  });

  final List<RemixMenuItemData<T>> items;
  final ValueChanged<T>? onSelected;
  final String semanticLabel;
  final bool enabled;
  final MenuController? controller;
  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    final menu =
        carbonMenuStyle().trigger(
          _carbonMenuButtonTriggerStyle(kind: .ghost, size: .md, square: true),
        )(
          trigger: const RemixMenuTrigger(
            label: '',
            icon: CarbonIcons.overflowMenuVertical,
          ),
          items: items,
          controller: controller,
          onSelected: onSelected,
          positioning: positioning,
          semanticLabel: semanticLabel,
        );

    if (enabled) return menu;

    return Semantics(
      button: true,
      enabled: false,
      label: semanticLabel,
      child: ExcludeSemantics(child: IgnorePointer(child: menu)),
    );
  }
}

MenuTriggerStyler _carbonMenuButtonTriggerStyle({
  required CarbonButtonKind kind,
  required CarbonSize size,
  bool square = false,
}) {
  final foreground = switch (kind) {
    .primary => CarbonTokens.textOnColor(),
    .tertiary || .ghost => CarbonTokens.linkPrimary(),
    .secondary || .danger || .dangerTertiary || .dangerGhost =>
      throw StateError('Unsupported Carbon menu-button kind: ${kind.name}'),
  };
  final base = MenuTriggerStyler()
      .height(size.clampTo(.xs, .lg).height)
      .padding(square ? .all(0) : .horizontal(CarbonTokens.spacing05()))
      .mainAxisAlignment(square ? .center : .spaceBetween)
      .crossAxisAlignment(.center)
      .label(.style(CarbonTokens.bodyCompact01.mix()).color(foreground))
      .icon(.size(CarbonTokens.iconSize01()).color(foreground));

  return switch (kind) {
    .primary =>
      base
          .color(CarbonComponentTokens.buttonPrimary())
          .onHovered(.color(CarbonComponentTokens.buttonPrimaryHover()))
          .onPressed(.color(CarbonComponentTokens.buttonPrimaryActive())),
    .tertiary =>
      base
          .border(
            BoxBorderMix.all(
              BorderSideMix(
                color: CarbonComponentTokens.buttonTertiary(),
                width: 1,
              ),
            ),
          )
          .onHovered(
            MenuTriggerStyler()
                .color(CarbonComponentTokens.buttonTertiaryHover())
                .label(.color(CarbonTokens.textInverse()))
                .icon(.color(CarbonTokens.iconInverse())),
          )
          .onPressed(
            MenuTriggerStyler()
                .color(CarbonComponentTokens.buttonTertiaryActive())
                .label(.color(CarbonTokens.textInverse()))
                .icon(.color(CarbonTokens.iconInverse())),
          ),
    .ghost =>
      base
          .color(const Color(0x00000000))
          .onHovered(.color(CarbonTokens.backgroundHover()))
          .onPressed(.color(CarbonTokens.backgroundActive())),
    .secondary || .danger || .dangerTertiary || .dangerGhost =>
      throw StateError('Unsupported Carbon menu-button kind: ${kind.name}'),
  };
}
