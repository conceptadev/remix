// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Menu recipe.
///
/// Remix owns the rendering, the overlay, the anchor positioning, keyboard
/// traversal, submenu timing, dismissal, and the menu accessibility
/// semantics; this recipe supplies the trigger, the floating panel, and every
/// kind of row inside it.
///
/// One recipe covers all of them, because `MenuSpec` carries each row kind as
/// a field: `item` is the default, and `checkboxItem`, `radioItem`, and
/// `submenuItem` fall back to it unless a recipe says otherwise. Setting only
/// `item` is what keeps a menu looking like one list rather than four.
///
/// The panel is the same `background` fill and `border` hairline the popover
/// uses. The two files are deliberately separate — the components have
/// separate update stories — but the values are meant to match, so a menu and
/// a popover anchored to adjacent buttons do not read as two systems.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat a row's hover fill has to be declared
/// as a hover fragment too.
class PlaygroundMenu<T> extends StatelessWidget {
  const PlaygroundMenu({
    super.key,
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
      style: playgroundMenuStyle(style: this.style),
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
