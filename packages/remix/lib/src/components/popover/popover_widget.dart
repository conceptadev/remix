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
    this.width,
    this.minWidth,
    this.maxWidth,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.matchTriggerWidth = false,
    this.positioning = const OverlayPositionConfig(),
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
    this.style = const RemixPopoverStyler.create(),
    this.styleSpec,
  }) : assert(width == null || width >= 0),
       assert(minWidth == null || minWidth >= 0),
       assert(maxWidth == null || maxWidth >= 0),
       assert(height == null || height >= 0),
       assert(minHeight == null || minHeight >= 0),
       assert(maxHeight == null || maxHeight >= 0),
       assert(
         minWidth == null || maxWidth == null || minWidth <= maxWidth,
         'minWidth must not exceed maxWidth',
       ),
       assert(
         minHeight == null || maxHeight == null || minHeight <= maxHeight,
         'minHeight must not exceed maxHeight',
       );

  /// Content displayed inside the popover overlay.
  final Widget popoverChild;

  /// Trigger that opens and closes the popover.
  final Widget child;

  /// Preferred content width, clamped by [minWidth] and [maxWidth].
  final double? width;

  /// Minimum content width.
  final double? minWidth;

  /// Maximum content width.
  final double? maxWidth;

  /// Preferred content height, clamped by [minHeight] and [maxHeight].
  final double? height;

  /// Minimum content height.
  final double? minHeight;

  /// Maximum content height.
  final double? maxHeight;

  /// Whether content must be at least as wide as its trigger.
  final bool matchTriggerWidth;

  /// Position of the overlay relative to [child].
  final OverlayPositionConfig positioning;

  /// Whether an outside tap is consumed after closing the popover.
  final bool consumeOutsideTaps;

  /// Whether to render in the root overlay.
  final bool useRootOverlay;

  /// Whether tapping or activating [child] toggles the popover.
  final bool openOnTap;

  /// Optional key for a separate widget used as the positioning anchor.
  ///
  /// When null, [child] supplies both interaction and positioning geometry.
  final GlobalKey? anchorKey;

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
            final triggerWidth = info.anchorRect.width;
            final effectiveMinWidth = matchTriggerWidth
                ? (minWidth == null || triggerWidth > minWidth!
                      ? triggerWidth
                      : minWidth!)
                : minWidth ?? 0;
            final effectiveMaxWidth = maxWidth == null
                ? double.infinity
                : (maxWidth! < effectiveMinWidth
                      ? effectiveMinWidth
                      : maxWidth!);

            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: effectiveMinWidth,
                maxWidth: effectiveMaxWidth,
                minHeight: minHeight ?? 0,
                maxHeight: maxHeight ?? double.infinity,
              ),
              child: SizedBox(
                width: width,
                height: height,
                child: RemixSurfaceBox(
                  styleSpec: spec.container,
                  surface: spec.surface,
                  child: SingleChildScrollView(
                    primary: false,
                    child: popoverChild,
                  ),
                ),
              ),
            );
          },
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
          excludeSemantics: excludeSemantics,
          child: child,
          builder: (context, state, trigger) {
            final label = openOnTap ? semanticLabel : null;
            final triggerStates = <WidgetState>{
              ...state.states,
              if (state.isOpen) WidgetState.selected,
            };
            final semantics = Semantics(
              excludeSemantics: label != null,
              expanded: state.isOpen,
              label: label,
              child: WidgetStateProvider(
                states: triggerStates,
                child: trigger!,
              ),
            );

            return openOnTap ? semantics : MergeSemantics(child: semantics);
          },
        );
      },
    );
  }
}
