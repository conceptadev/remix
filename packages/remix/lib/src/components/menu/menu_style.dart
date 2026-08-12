part of 'menu.dart';

/// Style configuration for [RemixMenu] trigger, overlay, shared and semantic
/// item defaults, and dividers.
extension RemixMenuStylerRemixHelpers on MenuStyler {
  /// Creates a [RemixMenu] widget with this style applied.
  ///
  /// Example:
  /// ```dart
  /// final appMenuStyle = MenuStyler()
  ///     .trigger(...)
  ///     .overlay(...)
  ///     .item(sharedItemStyle)
  ///     .radioItem(radioItemStyle);
  ///
  /// return appMenuStyle.call<String>(
  ///     trigger: RemixMenuTrigger(label: 'Options'),
  ///     items: [...],
  ///   );
  /// ```
  RemixMenu<T> call<T>({
    Key? key,
    required RemixMenuTrigger trigger,
    required List<RemixMenuItemData<T>> items,
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
    OverlayPositionConfig positioning = const OverlayPositionConfig(),
  }) {
    return RemixMenu(
      key: key,
      trigger: trigger,
      items: items,
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
      style: this,
    );
  }
}
