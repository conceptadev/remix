// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popover.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's Popover recipe.
///
/// Remix owns the rendering, the overlay, the anchor positioning, the
/// dismiss-on-outside-tap behavior, focus, and the popover accessibility
/// semantics; this recipe supplies only the floating panel's surface.
///
/// A popover sits *over* arbitrary content, so its edge is doing real work:
/// it is what tells a reader where the panel stops and the page resumes. That
/// edge is a `border` hairline plus a soft drop shadow. The fill is
/// `background`, the same token the page uses, because this vocabulary has no
/// separate surface step — see the theme's own comments if you add one.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundPopover(
///   popoverChild: filters,
///   child: PlaygroundButton.outline(label: 'Filter'),
/// )
/// ```
class PlaygroundPopover extends StatelessWidget {
  const PlaygroundPopover({
    super.key,
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
      style: playgroundPopoverStyle(style: this.style),
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
