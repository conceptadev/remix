part of 'menu.dart';

// ============================================================================
// DATA CLASSES - Trigger and Menu Item Hierarchy
// ============================================================================

/// Data class representing a menu trigger.
///
/// Used with [RemixMenu] to define the trigger button that opens the menu.
/// The trigger displays an optional icon (leading position) and label text.
class RemixMenuTrigger {
  /// The text label to display in the trigger.
  final String label;

  /// Optional icon to display before the label.
  /// When provided, icon appears in leading position (before text).
  final IconData? icon;

  const RemixMenuTrigger({required this.label, this.icon});
}

/// Base sealed class for all menu item types.
///
/// This ensures type safety and exhaustive pattern matching when
/// handling menu items. Use [RemixMenuItem] for selectable items
/// and [RemixMenuDivider] for visual separators.
sealed class RemixMenuItemData<T> {
  const RemixMenuItemData();
}

/// Data class representing a selectable menu item.
///
/// Used with [RemixMenu]'s items list to define selectable menu items.
final class RemixMenuItem<T> extends RemixMenuItemData<T> {
  /// The value associated with this menu item.
  /// Passed to onSelected callback when item is activated.
  final T value;

  /// The text label to display.
  final String label;

  /// Icon to display before the label.
  final IconData? leadingIcon;

  /// Icon to display after the label.
  final IconData? trailingIcon;

  /// Whether this item can be selected.
  final bool enabled;

  /// Whether the menu closes when this item is activated.
  final bool closeOnActivate;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// The style for the menu item.
  final MenuItemStyler style;

  const RemixMenuItem({
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const MenuItemStyler.create(),
  });
}

/// Data class representing a menu divider.
///
/// Used with [RemixMenu]'s items list to visually separate groups of items.
final class RemixMenuDivider<T> extends RemixMenuItemData<T> {
  const RemixMenuDivider();
}

// ============================================================================
// REMIX MENU - Main menu widget
// ============================================================================

/// A customizable menu component with data-driven API.
///
/// Uses a simple, declarative API with data classes for trigger and items.
/// All styling is centralized in [MenuStyler] and passed directly to children.
///
/// ## Example
///
/// ```dart
/// // Simple usage - controller created automatically
/// RemixMenu<String>(
///   trigger: RemixMenuTrigger(label: 'Options', icon: Icons.more_vert),
///   items: <RemixMenuItemData<String>>[
///     RemixMenuItem(value: 'copy', label: 'Copy', leadingIcon: Icons.copy),
///     RemixMenuItem(value: 'paste', label: 'Paste', leadingIcon: Icons.paste),
///     RemixMenuDivider(),
///     RemixMenuItem(value: 'delete', label: 'Delete', leadingIcon: Icons.delete),
///   ],
///   onSelected: (value) => debugPrint('Selected: $value'),
///   style: fortalMenuStyle(),
/// )
///
/// // Advanced usage - provide controller for programmatic control
/// final menuController = MenuController();
/// RemixMenu<String>(
///   controller: menuController,
///   trigger: RemixMenuTrigger(label: 'Options'),
///   items: [...],
///   onSelected: (value) => debugPrint(value),
/// )
/// ```
class RemixMenu<T> extends StatefulWidget {
  const RemixMenu({
    super.key,
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
    this.style = const MenuStyler.create(),
    this.styleSpec,
  });

  /// The trigger data that defines the menu's button.
  final RemixMenuTrigger trigger;

  /// The list of menu items and dividers.
  /// Use [RemixMenuItem] for selectable items and [RemixMenuDivider] for separators.
  final List<RemixMenuItemData<T>> items;

  /// Optional controller for programmatic control of the menu state.
  /// If not provided, an internal controller will be created automatically.
  final MenuController? controller;

  /// Called when an item is selected.
  final ValueChanged<T>? onSelected;

  /// Called when the menu opens.
  final VoidCallback? onOpen;

  /// Called when the menu closes.
  final VoidCallback? onClose;

  /// Called when the menu closes without a selection.
  final VoidCallback? onCanceled;

  /// Open/close interceptors (for example, to drive animations).
  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  /// Whether taps outside the overlay close the menu.
  final bool closeOnClickOutside;

  /// Whether outside taps on the trigger are consumed.
  final bool consumeOutsideTaps;

  /// Whether to target the root overlay instead of the nearest ancestor.
  final bool useRootOverlay;

  /// Optional focus node for the trigger.
  final FocusNode? triggerFocusNode;

  /// Overlay positioning configuration.
  final OverlayPositionConfig positioning;

  /// The style configuration for the menu.
  final MenuStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final MenuSpec? styleSpec;

  static final styleFrom = MenuStyler.new;

  @override
  State<RemixMenu<T>> createState() => _RemixMenuState<T>();
}

class _RemixMenuState<T> extends State<RemixMenu<T>> {
  late final MenuController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? MenuController();
  }

  // Note: MenuController doesn't require disposal - it's not a ChangeNotifier

  MenuStyler _buildStyle() {
    return MenuStyler()
        .trigger(MenuTriggerStyler().mainAxisSize(.min))
        .overlay(FlexBoxStyler().mainAxisSize(.min).wrap(.intrinsicWidth()))
        .merge(widget.style);
  }

  MenuController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle();

    return NakedMenu<T>(
      // Render items list with direct spec passing
      overlayBuilder: (context, info) {
        return RemixStyleSpecBuilder<MenuSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          builder: (context, spec) {
            return RemixFlexBoxWithEffects(
              styleSpec: spec.overlay,
              direction: Axis.vertical,
              containerEffects: spec.containerEffects,
              children: widget.items.map((item) {
                // Pattern matching ensures exhaustiveness
                return switch (item) {
                  RemixMenuItem<T>() => _RemixMenuItemWidget(
                    data: item,
                    defaultStyle: widget.styleSpec == null ? style.$item : null,
                    defaultStyleSpec: widget.styleSpec == null
                        ? null
                        : spec.item,
                  ),
                  RemixMenuDivider<T>() => StyleSpecBuilder(
                    styleSpec: spec.divider,
                    builder: (context, dividerSpec) =>
                        RemixDivider(styleSpec: dividerSpec),
                  ),
                };
              }).toList(),
            );
          },
        );
      },
      controller: _effectiveController,
      onSelected: widget.onSelected,
      onOpen: widget.onOpen,
      onClose: widget.onClose,
      onCanceled: widget.onCanceled,
      onOpenRequested: widget.onOpenRequested,
      onCloseRequested: widget.onCloseRequested,
      consumeOutsideTaps: widget.consumeOutsideTaps,
      useRootOverlay: widget.useRootOverlay,
      closeOnClickOutside: widget.closeOnClickOutside,
      triggerFocusNode: widget.triggerFocusNode,
      positioning: widget.positioning,
      // Render trigger from RemixMenuTrigger data
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<MenuSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          controller: NakedMenuState.controllerOf(context),
          builder: (context, spec) {
            return StyleSpecBuilder(
              styleSpec: spec.trigger,
              builder: (context, triggerSpec) => RowBox(
                styleSpec: triggerSpec.container,
                children: [
                  if (widget.trigger.icon != null)
                    StyledIcon(
                      icon: widget.trigger.icon!,
                      styleSpec: triggerSpec.icon,
                    ),
                  StyledText(
                    widget.trigger.label,
                    styleSpec: triggerSpec.label,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ============================================================================
// INTERNAL WIDGETS - Render data classes to actual widgets
// ============================================================================

/// Internal widget that renders [RemixMenuItem] data with provided styling.
///
/// Receives styling directly from parent [RemixMenu] via styleSpec parameter.
class _RemixMenuItemWidget<T> extends StatelessWidget {
  const _RemixMenuItemWidget({
    required this.data,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixMenuItem<T> data;
  final Prop<StyleSpec<MenuItemSpec>>? defaultStyle;
  final StyleSpec<MenuItemSpec>? defaultStyleSpec;

  StyleSpec<MenuItemSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;

    final itemStyle = MixOps.merge(
      defaultStyle,
      Prop.maybeMix<StyleSpec<MenuItemSpec>>(data.style),
    );

    return MixOps.resolve(context, itemStyle) ??
        const StyleSpec(spec: MenuItemSpec());
  }

  @override
  Widget build(BuildContext context) {
    return NakedMenuItem<T>(
      value: data.value,
      enabled: data.enabled,
      semanticLabel: data.semanticLabel ?? data.label,
      closeOnActivate: data.closeOnActivate,
      builder: (context, state, _) {
        final controller = NakedMenuItemState.controllerOf<T>(context);

        return ExcludeSemantics(
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return WidgetStateProvider(
                states: controller.value,
                child: Builder(
                  builder: (context) {
                    return StyleSpecBuilder<MenuItemSpec>(
                      styleSpec: _resolveStyle(context),
                      builder: (context, spec) {
                        return FlexBox(
                          styleSpec: spec.container,
                          children: [
                            if (data.leadingIcon != null)
                              StyledIcon(
                                icon: data.leadingIcon!,
                                styleSpec: spec.leadingIcon,
                              ),
                            StyledText(data.label, styleSpec: spec.label),
                            if (data.trailingIcon != null)
                              StyledIcon(
                                icon: data.trailingIcon!,
                                styleSpec: spec.trailingIcon,
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
