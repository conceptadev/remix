// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popover.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed preset for [RemixPopover].
///
/// The generated [UiPopover] defaults to [UiPopoverSize.size2], a
/// 480-pixel maximum width, and no arrow.
class UiPopover extends StatelessWidget {
  const UiPopover({
    super.key,
    this.size = UiPopoverSize.size2,
    this.style = const PopoverStyler.create(),
    required this.popoverChild,
    required this.child,
    this.positioning = const OverlayPositionConfig(),
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.openOnTap = true,
    this.triggerFocusNode,
    this.onOpen,
    this.onClose,
    this.onOpenRequested,
    this.onCloseRequested,
    this.controller,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final UiPopoverSize size;

  final PopoverStyler style;

  final Widget popoverChild;

  final Widget child;

  final OverlayPositionConfig positioning;

  final bool consumeOutsideTaps;

  final bool useRootOverlay;

  final bool openOnTap;

  final FocusNode? triggerFocusNode;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  final MenuController? controller;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixPopover(
      key: this.key,
      style: uiPopoverStyle(size: this.size, style: this.style),
      popoverChild: this.popoverChild,
      child: this.child,
      positioning: this.positioning,
      consumeOutsideTaps: this.consumeOutsideTaps,
      useRootOverlay: this.useRootOverlay,
      openOnTap: this.openOnTap,
      triggerFocusNode: this.triggerFocusNode,
      onOpen: this.onOpen,
      onClose: this.onClose,
      onOpenRequested: this.onOpenRequested,
      onCloseRequested: this.onCloseRequested,
      controller: this.controller,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
