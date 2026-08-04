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
/// handling ordinary, checkbox, radio, submenu, and divider data.
sealed class RemixMenuItemData<T> {
  const RemixMenuItemData({this.key});

  /// Optional caller-owned identity for the rendered item root.
  final Key? key;
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

  /// Per-item visual style applied after [MenuStyler.item].
  final MenuItemStyler style;

  const RemixMenuItem({
    super.key,
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const MenuItemStyler.create(),
  }) : assert(label != '', 'Item labels must not be empty'),
       assert(semanticLabel != '', 'Item semantic labels must not be empty');
}

/// A controlled checkbox item in a [RemixMenu].
///
/// Activation can invoke both the root [RemixMenu.onSelected] callback with
/// [value] and [onChanged] with the toggled checked value, in that order.
final class RemixMenuCheckboxItem<T> extends RemixMenuItemData<T> {
  const RemixMenuCheckboxItem({
    super.key,
    required this.value,
    required this.label,
    required this.checked,
    this.onChanged,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const MenuItemStyler.create(),
  }) : assert(label != '', 'Item labels must not be empty'),
       assert(semanticLabel != '', 'Item semantic labels must not be empty');

  /// The value reported to [RemixMenu.onSelected].
  final T value;

  /// The visible item label.
  final String label;

  /// The controlled checked state.
  final bool checked;

  /// Called with the toggled checked state after root selection is reported.
  final ValueChanged<bool>? onChanged;

  /// Optional icon before the label.
  final IconData? leadingIcon;

  /// Optional content icon in the trailing slot.
  final IconData? trailingIcon;

  /// Whether the item participates in interaction.
  final bool enabled;

  /// Whether activation closes the complete menu hierarchy.
  final bool closeOnActivate;

  /// Optional accessible name. Defaults to [label].
  final String? semanticLabel;

  /// Per-item visual style applied after the menu-wide shared and checkbox
  /// item styles.
  final MenuItemStyler style;
}

/// A controlled mutually exclusive section in a [RemixMenu].
///
/// The list must not be mutated while a panel is being built. A panel takes an
/// immutable snapshot and requires [value] to match exactly one unique item.
/// The group is behavioral; configure menu-wide row visuals with
/// [MenuStyler.radioItem] or override an individual radio item's style.
final class RemixMenuRadioGroup<T> extends RemixMenuItemData<T> {
  const RemixMenuRadioGroup({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
  }) : assert(value != null, 'Radio group values must not be null');

  /// The non-null controlled selected value required by Naked.
  final T value;

  /// The radio items in this section.
  final List<RemixMenuRadioItem<T>> items;

  /// Called after root selection is reported, including for [value] itself.
  final ValueChanged<T>? onChanged;

  /// Whether every item in the group participates in interaction.
  final bool enabled;
}

/// A selectable item in a [RemixMenuRadioGroup].
final class RemixMenuRadioItem<T> {
  const RemixMenuRadioItem({
    this.key,
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const MenuItemStyler.create(),
  }) : assert(label != '', 'Item labels must not be empty'),
       assert(semanticLabel != '', 'Item semantic labels must not be empty');

  /// Optional caller-owned identity for the rendered radio item root.
  final Key? key;

  /// The value reported to both root and group callbacks.
  final T value;

  /// The visible item label.
  final String label;

  /// Optional icon before the label.
  final IconData? leadingIcon;

  /// Optional content icon in the trailing slot.
  final IconData? trailingIcon;

  /// Whether this item participates in interaction.
  final bool enabled;

  /// Whether activation closes the complete menu hierarchy.
  final bool closeOnActivate;

  /// Optional accessible name. Defaults to [label].
  final String? semanticLabel;

  /// Per-item visual style applied after the menu-wide shared and radio item
  /// styles.
  final MenuItemStyler style;
}

/// A recursively nestable submenu in a [RemixMenu].
///
/// The list must not be mutated while a panel is being built. Each nested
/// panel consumes an immutable snapshot independently from its parent.
final class RemixMenuSubmenu<T> extends RemixMenuItemData<T> {
  const RemixMenuSubmenu({
    super.key,
    required this.label,
    required this.items,
    this.leadingIcon,
    this.trailingIcon,
    this.controller,
    this.enabled = true,
    this.hoverDelay = const Duration(milliseconds: 100),
    this.positioning = const OverlayPositionConfig(
      side: OverlaySide.right,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
    ),
    this.focusNode,
    this.semanticLabel,
    this.onOpen,
    this.onClose,
    this.style = const MenuItemStyler.create(),
  }) : assert(label != '', 'Item labels must not be empty'),
       assert(semanticLabel != '', 'Item semantic labels must not be empty');

  /// The visible submenu trigger label.
  final String label;

  /// The nested menu items.
  final List<RemixMenuItemData<T>> items;

  /// Optional icon before the label.
  final IconData? leadingIcon;

  /// Optional trailing icon replacing the default directional chevron.
  final IconData? trailingIcon;

  /// Optional controller for programmatic submenu control.
  final MenuController? controller;

  /// Whether the submenu trigger participates in interaction.
  final bool enabled;

  /// Delay before pointer hover opens or closes the submenu.
  final Duration hoverDelay;

  /// Child-panel placement relative to the submenu trigger.
  final OverlayPositionConfig positioning;

  /// Optional caller-owned focus node for the submenu trigger.
  final FocusNode? focusNode;

  /// Optional accessible name. Defaults to [label].
  final String? semanticLabel;

  /// Called after the submenu opens.
  final VoidCallback? onOpen;

  /// Called after the submenu closes.
  final VoidCallback? onClose;

  /// Per-trigger visual style applied after the menu-wide shared and submenu
  /// item styles.
  final MenuItemStyler style;
}

/// Data class representing a menu divider.
///
/// Used with [RemixMenu]'s items list to visually separate groups of items.
final class RemixMenuDivider<T> extends RemixMenuItemData<T> {
  const RemixMenuDivider({super.key});
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

  /// The declarative ordinary, compound, submenu, and divider data.
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
            return _RemixMenuItemsPanel<T>(
              items: widget.items,
              overlayStyleSpec: spec.overlay,
              containerEffects: spec.containerEffects,
              dividerStyleSpec: spec.divider,
              hasRootSelectionCallback: widget.onSelected != null,
              itemStyles: widget.styleSpec == null
                  ? _RemixMenuItemStyles.fromStyler(style)
                  : _RemixMenuItemStyles.fromSpec(spec),
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

enum _RemixMenuItemKind { ordinary, checkbox, radio, submenu }

/// Carries either unresolved fluent styles or one fully resolved raw spec.
///
/// Keeping the complete menu style together makes the base-to-semantic merge
/// order explicit without threading a parallel set of fields through every
/// recursive submenu panel.
final class _RemixMenuItemStyles {
  const _RemixMenuItemStyles.fromStyler(MenuStyler this.styler) : spec = null;

  const _RemixMenuItemStyles.fromSpec(MenuSpec this.spec) : styler = null;

  final MenuStyler? styler;
  final MenuSpec? spec;

  StyleSpec<MenuItemSpec> resolve(
    BuildContext context,
    _RemixMenuItemKind kind,
    MenuItemStyler itemStyle,
  ) {
    final resolvedSpec = spec;
    if (resolvedSpec != null) {
      return switch (kind) {
        .ordinary => resolvedSpec.item,
        .checkbox => resolvedSpec.checkboxItem ?? resolvedSpec.item,
        .radio => resolvedSpec.radioItem ?? resolvedSpec.item,
        .submenu => resolvedSpec.submenuItem ?? resolvedSpec.item,
      };
    }

    final fluentStyle = styler!;
    final semanticStyle = switch (kind) {
      .ordinary => null,
      .checkbox => fluentStyle.$checkboxItem,
      .radio => fluentStyle.$radioItem,
      .submenu => fluentStyle.$submenuItem,
    };
    final menuStyle = MixOps.merge(fluentStyle.$item, semanticStyle);
    final mergedStyle = MixOps.merge(
      menuStyle,
      Prop.maybeMix<StyleSpec<MenuItemSpec>>(itemStyle),
    );

    return MixOps.resolve(context, mergedStyle) ??
        const StyleSpec(spec: MenuItemSpec());
  }
}

/// One renderer intentionally serves root and recursive submenu overlays so
/// item, divider, decoration, and choice-row layout cannot drift.
class _RemixMenuItemsPanel<T> extends StatelessWidget {
  const _RemixMenuItemsPanel({
    required this.items,
    required this.overlayStyleSpec,
    required this.containerEffects,
    required this.dividerStyleSpec,
    required this.hasRootSelectionCallback,
    required this.itemStyles,
  });

  final List<RemixMenuItemData<T>> items;
  final StyleSpec<FlexBoxSpec> overlayStyleSpec;
  final RemixBoxEffectsSpec? containerEffects;
  final StyleSpec<DividerSpec> dividerStyleSpec;
  final bool hasRootSelectionCallback;
  final _RemixMenuItemStyles itemStyles;

  @override
  Widget build(BuildContext context) {
    final snapshot = List<RemixMenuItemData<T>>.unmodifiable(items);
    final hasChoiceItems = snapshot.any(
      (item) =>
          item is RemixMenuCheckboxItem<T> || item is RemixMenuRadioGroup<T>,
    );

    return RemixFlexBoxWithEffects(
      styleSpec: overlayStyleSpec,
      direction: Axis.vertical,
      containerEffects: containerEffects,
      children: snapshot
          .map(
            (item) => switch (item) {
              RemixMenuItem<T>() => _buildOrdinaryItem(item, hasChoiceItems),
              RemixMenuCheckboxItem<T>() => _buildCheckboxItem(
                item,
                hasChoiceItems,
              ),
              RemixMenuRadioGroup<T>() => _buildRadioGroup(
                item,
                hasChoiceItems,
              ),
              RemixMenuSubmenu<T>() => _buildSubmenu(item, hasChoiceItems),
              RemixMenuDivider<T>() => StyleSpecBuilder(
                key: item.key,
                styleSpec: dividerStyleSpec,
                builder: (context, dividerSpec) =>
                    RemixDivider(styleSpec: dividerSpec),
              ),
            },
          )
          .toList(growable: false),
    );
  }

  Widget _buildOrdinaryItem(RemixMenuItem<T> item, bool reserveChoiceSlot) {
    return NakedMenuItem<T>(
      key: item.key,
      value: item.value,
      enabled: item.enabled,
      semanticLabel: item.semanticLabel ?? item.label,
      closeOnActivate: item.closeOnActivate,
      builder: (context, state, _) => _RemixMenuItemContent(
        label: item.label,
        leadingIcon: item.leadingIcon,
        trailingIcon: item.trailingIcon,
        style: item.style,
        kind: .ordinary,
        controller: NakedMenuItemState.controllerOf<T>(context),
        reserveChoiceSlot: reserveChoiceSlot,
        itemStyles: itemStyles,
      ),
    );
  }

  Widget _buildCheckboxItem(
    RemixMenuCheckboxItem<T> item,
    bool reserveChoiceSlot,
  ) {
    return NakedMenuCheckboxItem<T>(
      key: item.key,
      value: item.value,
      checked: item.checked,
      onChanged: item.onChanged,
      // Deliberate duplication of Naked's enabled formula: Naked's root menu
      // scope installs an internal selection handler even when the public
      // onSelected is null, so its own callback guard can never disable an
      // item. Remix must gate on the public callbacks itself.
      enabled:
          item.enabled && (item.onChanged != null || hasRootSelectionCallback),
      semanticLabel: item.semanticLabel ?? item.label,
      closeOnActivate: item.closeOnActivate,
      builder: (context, state, _) => _RemixMenuItemContent(
        label: item.label,
        leadingIcon: item.leadingIcon,
        trailingIcon: item.trailingIcon,
        showIndicator: item.checked,
        style: item.style,
        kind: .checkbox,
        controller: NakedMenuItemState.controllerOf<T>(context),
        reserveChoiceSlot: reserveChoiceSlot,
        itemStyles: itemStyles,
      ),
    );
  }

  Widget _buildRadioGroup(
    RemixMenuRadioGroup<T> group,
    bool reserveChoiceSlot,
  ) {
    final radioItems = List<RemixMenuRadioItem<T>>.unmodifiable(group.items);
    assert(
      radioItems.isNotEmpty,
      'Radio groups must contain at least one item',
    );
    assert(
      radioItems.map((item) => item.value).toSet().length == radioItems.length,
      'Radio group item values must be unique',
    );
    assert(
      radioItems.where((item) => item.value == group.value).length == 1,
      'A radio group value must match exactly one item',
    );

    return NakedMenuRadioGroup<T>(
      key: group.key,
      value: group.value,
      onChanged: group.onChanged,
      enabled: group.enabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: overlayStyleSpec.spec.flex?.spec.spacing ?? 0,
        verticalDirection:
            overlayStyleSpec.spec.flex?.spec.verticalDirection ??
            VerticalDirection.down,
        children: radioItems
            .map(
              (item) => NakedMenuRadioItem<T>(
                key: item.key,
                value: item.value,
                // Same public-callback gate as checkbox items; see
                // _buildCheckboxItem for why Naked cannot own this.
                enabled:
                    item.enabled &&
                    (group.onChanged != null || hasRootSelectionCallback),
                semanticLabel: item.semanticLabel ?? item.label,
                closeOnActivate: item.closeOnActivate,
                builder: (context, state, _) => _RemixMenuItemContent(
                  label: item.label,
                  leadingIcon: item.leadingIcon,
                  trailingIcon: item.trailingIcon,
                  showIndicator: item.value == group.value,
                  style: item.style,
                  kind: .radio,
                  controller: NakedMenuItemState.controllerOf<T>(context),
                  reserveChoiceSlot: reserveChoiceSlot,
                  itemStyles: itemStyles,
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  Widget _buildSubmenu(RemixMenuSubmenu<T> submenu, bool reserveChoiceSlot) {
    return NakedMenuSubmenu<T>(
      key: submenu.key,
      controller: submenu.controller,
      enabled: submenu.enabled,
      hoverDelay: submenu.hoverDelay,
      positioning: submenu.positioning,
      focusNode: submenu.focusNode,
      semanticLabel: submenu.semanticLabel ?? submenu.label,
      onOpen: submenu.onOpen,
      onClose: submenu.onClose,
      overlayBuilder: (context, info) => _RemixMenuItemsPanel<T>(
        items: submenu.items,
        overlayStyleSpec: overlayStyleSpec,
        containerEffects: containerEffects,
        dividerStyleSpec: dividerStyleSpec,
        hasRootSelectionCallback: hasRootSelectionCallback,
        itemStyles: itemStyles,
      ),
      builder: (context, state, _) => _RemixMenuItemContent(
        label: submenu.label,
        leadingIcon: submenu.leadingIcon,
        trailingIcon: submenu.trailingIcon,
        submenuOpen: state.isOpen,
        style: submenu.style,
        kind: .submenu,
        controller: NakedMenuState.controllerOf(context),
        reserveChoiceSlot: reserveChoiceSlot,
        itemStyles: itemStyles,
      ),
    );
  }
}

class _RemixMenuItemContent extends StatelessWidget {
  const _RemixMenuItemContent({
    required this.label,
    required this.style,
    required this.kind,
    required this.controller,
    required this.reserveChoiceSlot,
    required this.itemStyles,
    this.leadingIcon,
    this.trailingIcon,
    this.showIndicator = false,
    this.submenuOpen = false,
  });

  static const _defaultIndicatorSize = 9.0;

  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool showIndicator;
  final bool submenuOpen;
  final MenuItemStyler style;
  final _RemixMenuItemKind kind;
  final WidgetStatesController controller;
  final bool reserveChoiceSlot;
  final _RemixMenuItemStyles itemStyles;

  StyleSpec<MenuItemSpec> _resolveStyle(BuildContext context) =>
      itemStyles.resolve(context, kind, style);

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          final states = <WidgetState>{
            ...controller.value,
            if (submenuOpen) WidgetState.selected,
          };
          return WidgetStateProvider(
            states: states,
            child: Builder(
              builder: (context) => StyleSpecBuilder<MenuItemSpec>(
                styleSpec: _resolveStyle(context),
                builder: (context, spec) => _buildRow(context, spec),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRow(BuildContext context, MenuItemSpec spec) {
    final flexSpec = spec.container.spec.flex?.spec;
    final itemAxis = flexSpec?.direction ?? Axis.horizontal;
    final indicatorSize = spec.indicator.spec.size ?? _defaultIndicatorSize;
    final indicatorSpec = spec.indicator.spec.size == null
        ? spec.indicator.copyWith(
            spec: spec.indicator.spec.copyWith(size: indicatorSize),
          )
        : spec.indicator;

    Widget? trailing;
    if (trailingIcon != null) {
      trailing = StyledIcon(icon: trailingIcon!, styleSpec: spec.trailingIcon);
    } else if (kind == .submenu) {
      trailing = RemixPathIcon(
        key: ValueKey('remix-menu-submenu-chevron-$label'),
        glyph: RemixPathGlyph.thickChevronRight,
        styleSpec: spec.trailingIcon,
        matchTextDirection: true,
      );
    }

    return FlexBox(
      styleSpec: spec.container,
      children: [
        if (reserveChoiceSlot)
          SizedBox.square(
            dimension: indicatorSize,
            child: showIndicator
                ? RemixPathIcon(
                    key: ValueKey('remix-menu-indicator-$label'),
                    glyph: RemixPathGlyph.thickCheck,
                    styleSpec: indicatorSpec,
                  )
                : null,
          ),
        if (leadingIcon != null)
          StyledIcon(icon: leadingIcon!, styleSpec: spec.leadingIcon),
        if (itemAxis == Axis.horizontal)
          Expanded(child: StyledText(label, styleSpec: spec.label))
        else
          StyledText(label, styleSpec: spec.label),
        if (trailing != null) trailing,
      ],
    );
  }
}
