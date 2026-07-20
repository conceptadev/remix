part of 'popover.dart';

/// Style configuration for a [RemixPopover] overlay container.
extension RemixPopoverStylerRemixHelpers on RemixPopoverStyler {
  /// Sets the popover background color.
  RemixPopoverStyler backgroundColor(Color value) => color(value);

  /// Creates a [RemixPopover] with this style applied.
  RemixPopover call({
    Key? key,
    required Widget popoverChild,
    required Widget child,
    double? width,
    double? minWidth,
    double? maxWidth,
    double? height,
    double? minHeight,
    double? maxHeight,
    bool matchTriggerWidth = false,
    OverlayPositionConfig positioning = const OverlayPositionConfig(),
    bool consumeOutsideTaps = true,
    bool useRootOverlay = false,
    bool openOnTap = true,
    GlobalKey? anchorKey,
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
      width: width,
      minWidth: minWidth,
      maxWidth: maxWidth,
      height: height,
      minHeight: minHeight,
      maxHeight: maxHeight,
      matchTriggerWidth: matchTriggerWidth,
      positioning: positioning,
      consumeOutsideTaps: consumeOutsideTaps,
      useRootOverlay: useRootOverlay,
      openOnTap: openOnTap,
      anchorKey: anchorKey,
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
