part of 'menu.dart';

/// Size scale for Fortal menu triggers and items.
enum FortalMenuSize {
  /// Compact menu controls.
  size1,

  /// Default menu controls.
  size2,
}

/// Visual variants for Fortal menu controls.
enum FortalMenuVariant {
  /// High-emphasis menu trigger and item hover treatment.
  solid,

  /// Subtle accent-backed menu trigger and item hover treatment.
  soft,
}

/// Fortal-themed preset for [RemixMenu].
RemixMenuStyler fortalMenuStyler({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
}) {
  return switch (variant) {
    .solid => _fortalMenuSolidStyler(size),
    .soft => _fortalMenuSoftStyler(size),
  };
}

RemixMenuStyler _fortalMenuBaseStyler(FortalMenuSize size) {
  return RemixMenuStyler()
      .trigger(
        RemixMenuTriggerStyler()
            .borderRadius(BorderRadiusMix.all(FortalTokens.radius2()))
            .label(
              TextStyler(
                style: TextStyleMix(
                  color: FortalTokens.gray12(),
                  fontSize: 14,
                  fontWeight: .w500,
                ),
              ),
            )
            .icon(IconStyler(color: FortalTokens.gray11(), size: 16)),
      )
      .overlay(
        FlexBoxStyler(
          decoration: BoxDecorationMix(
            border: BorderMix.all(
              BorderSideMix(
                color: FortalTokens.gray7(),
                width: FortalTokens.borderWidth1(),
              ),
            ),
            borderRadius: BorderRadiusMix.all(FortalTokens.radius3()),
            color: FortalTokens.colorPanel(),
          ),
          padding: EdgeInsetsMix.all(FortalTokens.space1()),
        ).marginTop(8)
        // Radix --shadow-5, sourced from the shared mode-aware shadow tokens
        // so the light/dark layer recipes stay defined once in
        // buildFortalShadows.
        .decoration(
          BoxDecorationMix.create(boxShadow: FortalTokens.shadow5.mix()),
        ),
      )
      .divider(
        RemixDividerStyler()
            .margin(EdgeInsetsMix.symmetric(vertical: FortalTokens.space1()))
            .height(FortalTokens.borderWidth1())
            .color(FortalTokens.gray6()),
      )
      .merge(_fortalMenuSizeStyler(size));
}

RemixMenuStyler _fortalMenuSolidStyler([FortalMenuSize size = .size2]) {
  return _fortalMenuBaseStyler(size)
      .trigger(
        RemixMenuTriggerStyler()
            .icon(IconStyler(color: FortalTokens.accentContrast(), size: 16))
            .spacing(8)
            .color(FortalTokens.accent9())
            .label(TextStyler().color(FortalTokens.accentContrast())),
      )
      .item(_fortalMenuItemSolidStyler(size));
}

RemixMenuStyler _fortalMenuSoftStyler([FortalMenuSize size = .size2]) {
  return _fortalMenuBaseStyler(size)
      .trigger(
        RemixMenuTriggerStyler()
            .decoration(BoxDecorationMix(color: FortalTokens.accent3()))
            .label(
              TextStyler(
                style: TextStyleMix(
                  color: FortalTokens.accent11(),
                  fontSize: 14,
                  fontWeight: .w500,
                ),
              ),
            )
            .icon(IconStyler(color: FortalTokens.accent11(), size: 16)),
      )
      .item(_fortalMenuItemSoftStyler(size));
}

RemixMenuStyler _fortalMenuSizeStyler(FortalMenuSize size) {
  return switch (size) {
    .size1 => RemixMenuStyler().trigger(
      RemixMenuTriggerStyler().padding(
        EdgeInsetsMix.symmetric(
          vertical: FortalTokens.space1(),
          horizontal: FortalTokens.space2(),
        ),
      ),
    ),
    .size2 => RemixMenuStyler().trigger(
      RemixMenuTriggerStyler().padding(
        EdgeInsetsMix.symmetric(
          vertical: FortalTokens.space2(),
          horizontal: FortalTokens.space3(),
        ),
      ),
    ),
  };
}

/// Creates a Fortal-themed [RemixMenuItemStyler].
RemixMenuItemStyler fortalMenuItemStyler({
  FortalMenuVariant variant = .solid,
  FortalMenuSize size = .size2,
}) {
  return switch (variant) {
    .solid => _fortalMenuItemSolidStyler(size),
    .soft => _fortalMenuItemSoftStyler(size),
  };
}

RemixMenuItemStyler _fortalMenuItemBaseStyler(FortalMenuSize size) {
  return RemixMenuItemStyler()
      .borderRadius(BorderRadiusMix.all(FortalTokens.radius2()))
      .label(
        TextStyler(
          style: TextStyleMix(color: FortalTokens.gray12(), fontSize: 14),
        ),
      )
      .leadingIcon(IconStyler(color: FortalTokens.gray11(), size: 16))
      .trailingIcon(IconStyler(color: FortalTokens.gray11(), size: 16))
      .merge(_fortalMenuItemSizeStyler(size));
}

RemixMenuItemStyler _fortalMenuItemSolidStyler([FortalMenuSize size = .size2]) {
  return _fortalMenuItemBaseStyler(size)
      .color(FortalTokens.graySurface())
      .onHovered(
        RemixMenuItemStyler()
            .color(FortalTokens.accent9())
            .label(TextStyler().color(FortalTokens.accentContrast())),
      );
}

RemixMenuItemStyler _fortalMenuItemSoftStyler([FortalMenuSize size = .size2]) {
  return _fortalMenuItemBaseStyler(size)
      .decoration(BoxDecorationMix(color: Colors.transparent))
      .onHovered(
        RemixMenuItemStyler()
            .decoration(BoxDecorationMix(color: FortalTokens.accentA3()))
            .label(
              TextStyler(
                style: TextStyleMix(
                  color: FortalTokens.accent11(),
                  fontSize: 14,
                ),
              ),
            )
            .leadingIcon(IconStyler(color: FortalTokens.accent11(), size: 16))
            .trailingIcon(IconStyler(color: FortalTokens.accent11(), size: 16)),
      );
}

RemixMenuItemStyler _fortalMenuItemSizeStyler(FortalMenuSize size) {
  return switch (size) {
    .size1 => RemixMenuItemStyler().padding(
      EdgeInsetsMix.symmetric(
        vertical: FortalTokens.space1(),
        horizontal: FortalTokens.space1(),
      ),
    ),
    .size2 => RemixMenuItemStyler().padding(
      EdgeInsetsMix.symmetric(
        vertical: FortalTokens.space2(),
        horizontal: FortalTokens.space2(),
      ),
    ),
  };
}

/// Fortal-themed preset for [RemixMenu].
class FortalMenu<T> extends StatelessWidget {
  const FortalMenu({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.color,
    this.radius,
    required this.trigger,
    required this.items,
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
    this.positioning = const OverlayPositionConfig(),
  });

  /// High-emphasis menu trigger and item hover treatment.
  const FortalMenu.solid({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    required this.trigger,
    required this.items,
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
    this.positioning = const OverlayPositionConfig(),
  }) : variant = FortalMenuVariant.solid;

  /// Subtle accent-backed menu trigger and item hover treatment.
  const FortalMenu.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    required this.trigger,
    required this.items,
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
    this.positioning = const OverlayPositionConfig(),
  }) : variant = FortalMenuVariant.soft;

  final FortalMenuVariant variant;

  final FortalMenuSize size;

  /// Optional accent color override for this menu subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this menu subtree.
  final FortalRadius? radius;

  final RemixMenuTrigger trigger;

  final List<RemixMenuItemData<T>> items;

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

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalMenuStyler(variant: this.variant, size: this.size).call<T>(
        key: this.key,
        trigger: this.trigger,
        items: this.items,
        controller: this.controller,
        onSelected: this.onSelected,
        onOpen: this.onOpen,
        onClose: this.onClose,
        onCanceled: this.onCanceled,
        onOpenRequested: this.onOpenRequested,
        onCloseRequested: this.onCloseRequested,
        consumeOutsideTaps: this.consumeOutsideTaps,
        useRootOverlay: this.useRootOverlay,
        closeOnClickOutside: this.closeOnClickOutside,
        triggerFocusNode: this.triggerFocusNode,
        positioning: this.positioning,
      ),
    );
  }
}
