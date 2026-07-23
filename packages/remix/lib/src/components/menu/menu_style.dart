part of 'menu.dart';

/// Style configuration for [RemixMenu] overlay, items, and dividers.
extension RemixMenuStylerRemixHelpers on RemixMenuStyler {
  /// Creates a [RemixMenu] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// RemixMenuStyler()
  ///   .containerEffects(RemixBoxEffectsMix(overContent: ...))
  ///   .call<String>(
  ///     trigger: const Text('Options'),
  ///     entries: [...],
  ///   )
  /// ```
  RemixMenu<T> call<T>({
    Key? key,
    required Widget trigger,
    required List<Widget> entries,
    MenuController? controller,
    ValueChanged<T>? onSelected,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    VoidCallback? onCanceled,
    RawMenuAnchorOpenRequestedCallback? onOpenRequested,
    RawMenuAnchorCloseRequestedCallback? onCloseRequested,
    bool consumeOutsideTaps = true,
    bool useRootOverlay = false,
    bool closeOnClickOutside = true,
    FocusNode? triggerFocusNode,
    OverlayPositionConfig positioning = const OverlayPositionConfig(
      side: OverlaySide.bottom,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
      collisionPadding: EdgeInsets.all(10),
    ),
    OverlayPositionConfig? submenuPositioning,
    String? semanticLabel,
    bool excludeSemantics = false,
    RemixMenuPartWrapper? contentWrapper,
  }) {
    return RemixMenu(
      key: key,
      trigger: trigger,
      entries: entries,
      controller: controller,
      onSelected: onSelected,
      onOpen: onOpen,
      onClose: onClose,
      onCanceled: onCanceled,
      onOpenRequested: onOpenRequested,
      onCloseRequested: onCloseRequested,
      consumeOutsideTaps: consumeOutsideTaps,
      useRootOverlay: useRootOverlay,
      closeOnClickOutside: closeOnClickOutside,
      triggerFocusNode: triggerFocusNode,
      positioning: positioning,
      submenuPositioning: submenuPositioning,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      contentWrapper: contentWrapper,
      style: this,
    );
  }
}

/// Style configuration for an item in a [RemixMenu].
extension RemixMenuItemStylerRemixHelpers on RemixMenuItemStyler {
  RemixMenuItemStyler flex(FlexStyler value) {
    return merge(RemixMenuItemStyler(container: FlexBoxStyler().flex(value)));
  }
}
