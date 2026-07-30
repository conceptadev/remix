part of 'popover.dart';

/// A styled, anchored overlay for supplementary interactive content.
///
/// The popover opens when [child] is tapped or activated from the keyboard.
/// [popoverChild] is rendered in the overlay using [style].
class RemixPopover extends StatelessWidget {
  const RemixPopover({
    super.key,
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
    this.style = const RemixPopoverStyler.create(),
    this.styleSpec,
  });

  /// Content displayed inside the popover overlay.
  final Widget popoverChild;

  /// Trigger that opens and closes the popover.
  final Widget child;

  /// Position of the overlay relative to [child].
  final OverlayPositionConfig positioning;

  /// Whether an outside tap is consumed after closing the popover.
  final bool consumeOutsideTaps;

  /// Whether to render in the root overlay.
  final bool useRootOverlay;

  /// Whether tapping or activating [child] toggles the popover.
  final bool openOnTap;

  /// Optional focus node for the trigger.
  final FocusNode? triggerFocusNode;

  /// Called after the popover opens.
  final VoidCallback? onOpen;

  /// Called after the popover closes.
  final VoidCallback? onClose;

  /// Intercepts a request to open the popover.
  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  /// Intercepts a request to close the popover.
  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  /// Optional controller for programmatic open and close operations.
  final MenuController? controller;

  /// Accessibility label for the built-in trigger.
  ///
  /// When [openOnTap] is false, [child] owns its accessible label and actions.
  final String? semanticLabel;

  /// Whether to hide the trigger subtree from accessibility.
  final bool excludeSemantics;

  /// Style configuration for the overlay container.
  final RemixPopoverStyler style;

  /// Optional resolved style that bypasses [style].
  final RemixPopoverSpec? styleSpec;

  static final styleFrom = RemixPopoverStyler.new;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixPopoverSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return NakedPopover(
          popoverBuilder: (context, info) {
            return RemixBoxWithEffects(
              styleSpec: spec.container,
              containerEffects: spec.containerEffects,
              child: popoverChild,
            );
          },
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
          excludeSemantics: excludeSemantics,
          child: child,
          builder: (context, state, trigger) {
            final label = openOnTap ? semanticLabel : null;
            final semantics = Semantics(
              excludeSemantics: label != null,
              expanded: state.isOpen,
              label: label,
              child: trigger!,
            );

            return openOnTap ? semantics : MergeSemantics(child: semantics);
          },
        );
      },
    );
  }
}
