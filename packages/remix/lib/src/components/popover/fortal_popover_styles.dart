part of 'popover.dart';

/// Fortal popover size presets matching Radix Themes 3.3.0.
enum FortalPopoverSize { size1, size2, size3, size4 }

/// Fortal-themed preset for [RemixPopover].
RemixPopoverStyler fortalPopoverStyler({
  FortalPopoverSize size = FortalPopoverSize.size2,
}) {
  final radius = switch (size) {
    FortalPopoverSize.size1 ||
    FortalPopoverSize.size2 => FortalTokens.radius4(),
    FortalPopoverSize.size3 ||
    FortalPopoverSize.size4 => FortalTokens.radius5(),
  };
  final padding = switch (size) {
    FortalPopoverSize.size1 => FortalTokens.space3(),
    FortalPopoverSize.size2 => FortalTokens.space4(),
    FortalPopoverSize.size3 => FortalTokens.space5(),
    FortalPopoverSize.size4 => FortalTokens.space6(),
  };

  return RemixPopoverStyler()
      .paddingAll(padding)
      .borderRadiusAll(radius)
      .color(FortalTokens.colorPanel())
      .effects(
        RemixSurfaceEffectsMix(
          backdropBlur: FortalTokens.panelBlur(),
          background: RemixSurfaceLayerMix(shadowToken: FortalTokens.shadow5),
        ),
      );
}

/// Fortal-themed preset for [RemixPopover].
class FortalPopover extends StatelessWidget {
  const FortalPopover({
    super.key,
    this.size = FortalPopoverSize.size2,
    required this.popoverChild,
    required this.child,
    this.width,
    this.minWidth,
    this.maxWidth = 480,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.matchTriggerWidth = true,
    this.positioning = const OverlayPositionConfig(sideOffset: 8),
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.openOnTap = true,
    this.anchorKey,
    this.triggerFocusNode,
    this.onOpen,
    this.onClose,
    this.onOpenRequested,
    this.onCloseRequested,
    this.controller,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalPopoverSize size;

  final Widget popoverChild;

  final Widget child;

  final double? width;

  final double? minWidth;

  final double? maxWidth;

  final double? height;

  final double? minHeight;

  final double? maxHeight;

  final bool matchTriggerWidth;

  final OverlayPositionConfig positioning;

  final bool consumeOutsideTaps;

  final bool useRootOverlay;

  final bool openOnTap;

  final GlobalKey? anchorKey;

  final FocusNode? triggerFocusNode;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  final MenuController? controller;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) => fortalPopoverStyler(size: size).call(
    key: key,
    popoverChild: popoverChild,
    child: child,
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
  );
}
