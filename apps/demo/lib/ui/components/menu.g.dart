// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal menu content with Radix-owned size, variant, and contrast behavior.
class FortalMenu<T> extends StatelessWidget {
  const FortalMenu({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.highContrast = false,
    this.style = const MenuStyler.create(),
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
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const FortalMenu.solid({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const MenuStyler.create(),
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
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalMenuVariant.solid;

  const FortalMenu.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const MenuStyler.create(),
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
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalMenuVariant.soft;

  final FortalMenuVariant variant;

  final FortalMenuSize size;

  final bool highContrast;

  final MenuStyler style;

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

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixMenu<T>(
      key: this.key,
      style: fortalMenuStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
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
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
