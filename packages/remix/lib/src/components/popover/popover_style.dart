part of 'popover.dart';

/// Style configuration for a [RemixPopover] overlay container.
extension RemixPopoverStylerRemixHelpers on PopoverStyler {
  /// Creates a [RemixPopover] with this style applied.
  RemixPopover call({
    Key? key,
    required Widget popoverChild,
    required Widget child,
    OverlayPositionConfig positioning = const OverlayPositionConfig(),
    bool consumeOutsideTaps = true,
    bool useRootOverlay = false,
    bool openOnTap = true,
    FocusNode? triggerFocusNode,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    RawMenuAnchorOpenRequestedCallback? onOpenRequested,
    RawMenuAnchorCloseRequestedCallback? onCloseRequested,
    MenuController? controller,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixPopover(
      key: key,
      popoverChild: popoverChild,
      positioning: positioning,
      consumeOutsideTaps: consumeOutsideTaps,
      useRootOverlay: useRootOverlay,
      openOnTap: openOnTap,
      triggerFocusNode: triggerFocusNode,
      onOpen: onOpen,
      onClose: onClose,
      onOpenRequested: onOpenRequested,
      onCloseRequested: onCloseRequested,
      controller: controller,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      style: this,
      child: child,
    );
  }
}
