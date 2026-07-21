part of 'menu.dart';

/// Wraps popup content without replacing menu behavior.
typedef RemixMenuPartWrapper =
    Widget Function(BuildContext context, Widget child);

/// A compositional menu anchored to an arbitrary trigger widget.
///
/// Entries are widgets so labels, groups, checkboxes, radio groups, and
/// recursive submenus can be composed in the same order in which they appear.
///
/// ```dart
/// RemixMenu<String>(
///   trigger: const Text('Options'),
///   entries: const [
///     RemixMenuAction(value: 'copy', child: Text('Copy')),
///     RemixMenuSeparator(),
///     RemixMenuAction(value: 'delete', child: Text('Delete')),
///   ],
///   onSelected: print,
/// )
/// ```
class RemixMenu<T> extends StatefulWidget {
  const RemixMenu({
    super.key,
    required this.trigger,
    required this.entries,
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
    this.positioning = const OverlayPositionConfig(
      side: OverlaySide.bottom,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
      collisionPadding: EdgeInsets.all(10),
    ),
    this.submenuPositioning = const OverlayPositionConfig(
      side: OverlaySide.right,
      alignment: OverlayAlignment.start,
      sideOffset: 1,
      alignmentOffset: -8,
      collisionPadding: EdgeInsets.all(10),
    ),
    this.semanticLabel,
    this.excludeSemantics = false,
    this.contentWrapper,
    this.style = const RemixMenuStyler.create(),
    this.styleSpec,
  });

  /// Widget that opens and closes the menu.
  final Widget trigger;

  /// Compositional popup entries.
  final List<Widget> entries;

  /// Optional controller for programmatic menu control.
  final MenuController? controller;

  /// Called with the value of an activated action, checkbox, or radio item.
  final ValueChanged<T>? onSelected;

  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final VoidCallback? onCanceled;
  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;
  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;
  final bool consumeOutsideTaps;
  final bool useRootOverlay;
  final bool closeOnClickOutside;
  final FocusNode? triggerFocusNode;

  /// Placement of the root popup.
  final OverlayPositionConfig positioning;

  /// Default placement inherited by recursive submenus.
  final OverlayPositionConfig submenuPositioning;

  /// Accessible name for the trigger.
  final String? semanticLabel;

  /// Whether the complete menu is hidden from accessibility services.
  final bool excludeSemantics;

  /// Optional inherited-scope wrapper around popup style resolution.
  final RemixMenuPartWrapper? contentWrapper;

  final RemixMenuStyler style;
  final RemixMenuSpec? styleSpec;

  static final styleFrom = RemixMenuStyler.new;

  @override
  State<RemixMenu<T>> createState() => _RemixMenuState<T>();
}

class _RemixMenuState<T> extends State<RemixMenu<T>> {
  final MenuController _internalController = MenuController();

  MenuController get _controller => widget.controller ?? _internalController;

  RemixMenuStyler _effectiveStyle() => RemixMenuStyler()
      .overlay(
        FlexBoxStyler()
            .direction(.vertical)
            .mainAxisSize(.min)
            .crossAxisAlignment(.stretch)
            .wrap(.intrinsicWidth()),
      )
      .merge(widget.style);

  @override
  Widget build(BuildContext context) {
    final style = _effectiveStyle();
    return NakedMenu<T>(
      controller: _controller,
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
      semanticLabel: widget.semanticLabel,
      excludeSemantics: widget.excludeSemantics,
      child: widget.trigger,
      overlayBuilder: (context, info) {
        final content = RemixStyleSpecBuilder<RemixMenuSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          builder: (context, spec) => _RemixMenuPanel(
            entries: widget.entries,
            maximumHeight: info.overlaySize.height,
            overlay: spec.overlay,
            surface: spec.surface,
            defaultItemStyle: widget.styleSpec == null ? style.$item : null,
            defaultItemStyleSpec: widget.styleSpec == null ? null : spec.item,
            defaultLabelStyle: widget.styleSpec == null ? style.$label : null,
            defaultLabelStyleSpec: widget.styleSpec == null ? null : spec.label,
            defaultDividerStyle: widget.styleSpec == null
                ? style.$divider
                : null,
            defaultDividerStyleSpec: widget.styleSpec == null
                ? null
                : spec.divider,
            submenuPositioning: widget.submenuPositioning,
            contentWrapper: widget.contentWrapper,
          ),
        );
        return widget.contentWrapper?.call(context, content) ?? content;
      },
    );
  }
}

/// An actionable menu entry associated with [value].
class RemixMenuAction<T> extends StatelessWidget {
  const RemixMenuAction({
    super.key,
    required this.value,
    required this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });

  final T value;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
  final bool closeOnActivate;
  final String? semanticLabel;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) => NakedMenuItem<T>(
    value: value,
    enabled: enabled,
    closeOnActivate: closeOnActivate,
    semanticLabel: semanticLabel,
    builder: (context, state, _) => _RemixMenuStatefulItem(
      controller: NakedMenuItemState.controllerOf<T>(context),
      child: child,
      leading: leading,
      trailing: trailing,
      excludeChildSemantics: semanticLabel != null,
      style: style,
    ),
  );
}

/// A controlled checkbox entry with menu-item-checkbox semantics.
class RemixMenuCheckboxItem<T> extends StatelessWidget {
  const RemixMenuCheckboxItem({
    super.key,
    required this.value,
    required this.checked,
    required this.child,
    this.onChanged,
    this.indicator,
    this.trailing,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });

  final T value;
  final bool checked;
  final Widget child;
  final ValueChanged<bool>? onChanged;
  final Widget? indicator;
  final Widget? trailing;
  final bool enabled;
  final bool closeOnActivate;
  final String? semanticLabel;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) => NakedMenuCheckboxItem<T>(
    value: value,
    checked: checked,
    onChanged: onChanged,
    enabled: enabled,
    closeOnActivate: closeOnActivate,
    semanticLabel: semanticLabel,
    builder: (context, state, _) => _RemixMenuStatefulItem(
      controller: NakedMenuItemState.controllerOf<T>(context),
      child: child,
      trailing: trailing,
      indicator: indicator,
      showIndicatorWhenSelected: true,
      excludeChildSemantics: semanticLabel != null,
      style: style,
    ),
  );
}

/// A semantic grouping of adjacent menu entries.
class RemixMenuGroup extends StatelessWidget {
  const RemixMenuGroup({super.key, required this.children, this.semanticLabel});

  final List<Widget> children;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    explicitChildNodes: true,
    label: semanticLabel,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _decorateMenuEntries(children),
    ),
  );
}

/// A noninteractive heading inside menu content.
class RemixMenuLabel extends StatelessWidget {
  const RemixMenuLabel({
    super.key,
    required this.child,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });

  final Widget child;
  final String? semanticLabel;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) {
    final scope = _RemixMenuStyleScope.of(context);
    final visual = _RemixMenuItemChrome(
      child: child,
      excludeChildSemantics: semanticLabel != null,
      style: style,
      useLabelStyle: true,
    );
    return Padding(
      padding: EdgeInsets.only(
        top: _RemixMenuAdjacentLabelScope.maybeOf(context)
            ? scope
                      .resolveLabelStyle(context, style)
                      .spec
                      .adjacentItemSpacing ??
                  0
            : 0,
      ),
      child: Semantics(header: true, label: semanticLabel, child: visual),
    );
  }
}

/// A decorative separator inside menu content.
class RemixMenuSeparator extends StatelessWidget {
  const RemixMenuSeparator({
    super.key,
    this.style = const RemixDividerStyler.create(),
  });

  final RemixDividerStyler style;

  @override
  Widget build(BuildContext context) {
    final scope = _RemixMenuStyleScope.of(context);
    final itemSpec = scope
        .resolveItemStyle(context, const RemixMenuItemStyler.create())
        .spec;
    final extraLeadingInset = scope.hasCheckableItems
        ? (itemSpec.checkableLeadingInset ?? 0) - (itemSpec.leadingInset ?? 0)
        : 0.0;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: extraLeadingInset.clamp(0, double.infinity).toDouble(),
      ),
      child: StyleSpecBuilder<RemixDividerSpec>(
        styleSpec: scope.resolveDividerStyle(context, style),
        builder: (context, spec) => RemixDivider(styleSpec: spec),
      ),
    );
  }
}

/// Provides controlled selection to typed [RemixMenuRadioItem] descendants.
class RemixMenuRadioGroup<T> extends StatelessWidget {
  const RemixMenuRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
    this.enabled = true,
    this.semanticLabel,
  });

  final T value;
  final ValueChanged<T>? onChanged;
  final List<Widget> children;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => NakedMenuRadioGroup<T>(
    value: value,
    onChanged: onChanged,
    enabled: enabled,
    child: Semantics(
      container: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _decorateMenuEntries(children),
      ),
    ),
  );
}

/// A mutually exclusive entry inside a [RemixMenuRadioGroup].
class RemixMenuRadioItem<T> extends StatelessWidget {
  const RemixMenuRadioItem({
    super.key,
    required this.value,
    required this.child,
    this.indicator,
    this.trailing,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });

  final T value;
  final Widget child;
  final Widget? indicator;
  final Widget? trailing;
  final bool enabled;
  final bool closeOnActivate;
  final String? semanticLabel;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) => NakedMenuRadioItem<T>(
    value: value,
    enabled: enabled,
    closeOnActivate: closeOnActivate,
    semanticLabel: semanticLabel,
    builder: (context, state, _) => _RemixMenuStatefulItem(
      controller: NakedMenuItemState.controllerOf<T>(context),
      child: child,
      trailing: trailing,
      indicator: indicator,
      showIndicatorWhenSelected: true,
      excludeChildSemantics: semanticLabel != null,
      style: style,
    ),
  );
}

/// A recursively nestable submenu entry.
class RemixMenuSubmenu<T> extends StatelessWidget {
  const RemixMenuSubmenu({
    super.key,
    required this.child,
    required this.entries,
    this.trailing,
    this.controller,
    this.enabled = true,
    this.hoverDelay = const Duration(milliseconds: 100),
    this.positioning,
    this.focusNode,
    this.semanticLabel,
    this.onOpen,
    this.onClose,
    this.style = const RemixMenuItemStyler.create(),
  });

  final Widget child;
  final List<Widget> entries;
  final Widget? trailing;
  final MenuController? controller;
  final bool enabled;
  final Duration hoverDelay;
  final OverlayPositionConfig? positioning;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) {
    final scope = _RemixMenuStyleScope.of(context);
    return NakedMenuSubmenu<T>(
      controller: controller,
      enabled: enabled,
      hoverDelay: hoverDelay,
      positioning: positioning ?? scope.submenuPositioning,
      focusNode: focusNode,
      semanticLabel: semanticLabel,
      onOpen: onOpen,
      onClose: onClose,
      overlayBuilder: (context, info) => scope.buildSubmenuPanel(
        context,
        entries,
        maximumHeight: info.overlaySize.height,
      ),
      builder: (context, state, _) => _RemixMenuStatefulItem(
        controller: NakedMenuState.controllerOf(context),
        additionalStates: {if (state.isOpen) WidgetState.selected},
        child: child,
        trailing: trailing,
        showDefaultChevron: trailing == null,
        excludeChildSemantics: semanticLabel != null,
        style: style,
      ),
    );
  }
}

class _RemixMenuPanel extends StatelessWidget {
  const _RemixMenuPanel({
    required this.entries,
    required this.maximumHeight,
    required this.overlay,
    required this.surface,
    required this.defaultItemStyle,
    required this.defaultItemStyleSpec,
    required this.defaultLabelStyle,
    required this.defaultLabelStyleSpec,
    required this.defaultDividerStyle,
    required this.defaultDividerStyleSpec,
    required this.submenuPositioning,
    required this.contentWrapper,
  });

  final List<Widget> entries;
  final double maximumHeight;
  final StyleSpec<FlexBoxSpec> overlay;
  final RemixSurfaceLayerSpec? surface;
  final Prop<StyleSpec<RemixMenuItemSpec>>? defaultItemStyle;
  final StyleSpec<RemixMenuItemSpec>? defaultItemStyleSpec;
  final Prop<StyleSpec<RemixMenuItemSpec>>? defaultLabelStyle;
  final StyleSpec<RemixMenuItemSpec>? defaultLabelStyleSpec;
  final Prop<StyleSpec<RemixDividerSpec>>? defaultDividerStyle;
  final StyleSpec<RemixDividerSpec>? defaultDividerStyleSpec;
  final OverlayPositionConfig submenuPositioning;
  final RemixMenuPartWrapper? contentWrapper;

  @override
  Widget build(BuildContext context) {
    return _RemixMenuStyleScope(
      hasCheckableItems: _menuEntriesContainCheckable(entries),
      overlay: overlay,
      surface: surface,
      defaultItemStyle: defaultItemStyle,
      defaultItemStyleSpec: defaultItemStyleSpec,
      defaultLabelStyle: defaultLabelStyle,
      defaultLabelStyleSpec: defaultLabelStyleSpec,
      defaultDividerStyle: defaultDividerStyle,
      defaultDividerStyleSpec: defaultDividerStyleSpec,
      submenuPositioning: submenuPositioning,
      contentWrapper: contentWrapper,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maximumHeight),
        child: RemixSurfaceFlexBox(
          styleSpec: overlay,
          direction: Axis.vertical,
          surface: surface,
          children: [
            // ignore: avoid-flexible-outside-flex
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _decorateMenuEntries(entries),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemixMenuStyleScope extends InheritedWidget {
  const _RemixMenuStyleScope({
    required this.hasCheckableItems,
    required this.overlay,
    required this.surface,
    required this.defaultItemStyle,
    required this.defaultItemStyleSpec,
    required this.defaultLabelStyle,
    required this.defaultLabelStyleSpec,
    required this.defaultDividerStyle,
    required this.defaultDividerStyleSpec,
    required this.submenuPositioning,
    required this.contentWrapper,
    required super.child,
  });

  final bool hasCheckableItems;
  final StyleSpec<FlexBoxSpec> overlay;
  final RemixSurfaceLayerSpec? surface;
  final Prop<StyleSpec<RemixMenuItemSpec>>? defaultItemStyle;
  final StyleSpec<RemixMenuItemSpec>? defaultItemStyleSpec;
  final Prop<StyleSpec<RemixMenuItemSpec>>? defaultLabelStyle;
  final StyleSpec<RemixMenuItemSpec>? defaultLabelStyleSpec;
  final Prop<StyleSpec<RemixDividerSpec>>? defaultDividerStyle;
  final StyleSpec<RemixDividerSpec>? defaultDividerStyleSpec;
  final OverlayPositionConfig submenuPositioning;
  final RemixMenuPartWrapper? contentWrapper;

  static _RemixMenuStyleScope of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_RemixMenuStyleScope>();
    assert(
      scope != null,
      'Remix menu entries must be descendants of RemixMenu content.',
    );
    return scope!;
  }

  StyleSpec<RemixMenuItemSpec> resolveItemStyle(
    BuildContext context,
    RemixMenuItemStyler style,
  ) {
    if (defaultItemStyleSpec case final raw?) return raw;
    return MixOps.resolve(
          context,
          MixOps.merge(
            defaultItemStyle,
            Prop.maybeMix<StyleSpec<RemixMenuItemSpec>>(style),
          ),
        ) ??
        const StyleSpec(spec: RemixMenuItemSpec());
  }

  StyleSpec<RemixMenuItemSpec> resolveLabelStyle(
    BuildContext context,
    RemixMenuItemStyler style,
  ) {
    if (defaultLabelStyleSpec case final raw?) return raw;
    return MixOps.resolve(
          context,
          MixOps.merge(
            defaultLabelStyle,
            Prop.maybeMix<StyleSpec<RemixMenuItemSpec>>(style),
          ),
        ) ??
        const StyleSpec(spec: RemixMenuItemSpec());
  }

  StyleSpec<RemixDividerSpec> resolveDividerStyle(
    BuildContext context,
    RemixDividerStyler style,
  ) {
    if (defaultDividerStyleSpec case final raw?) return raw;
    return MixOps.resolve(
          context,
          MixOps.merge(
            defaultDividerStyle,
            Prop.maybeMix<StyleSpec<RemixDividerSpec>>(style),
          ),
        ) ??
        const StyleSpec(spec: RemixDividerSpec());
  }

  Widget buildSubmenuPanel(
    BuildContext context,
    List<Widget> entries, {
    required double maximumHeight,
  }) {
    final panel = _RemixMenuPanel(
      entries: entries,
      maximumHeight: maximumHeight,
      overlay: overlay,
      surface: surface,
      defaultItemStyle: defaultItemStyle,
      defaultItemStyleSpec: defaultItemStyleSpec,
      defaultLabelStyle: defaultLabelStyle,
      defaultLabelStyleSpec: defaultLabelStyleSpec,
      defaultDividerStyle: defaultDividerStyle,
      defaultDividerStyleSpec: defaultDividerStyleSpec,
      submenuPositioning: submenuPositioning,
      contentWrapper: contentWrapper,
    );
    return contentWrapper?.call(context, panel) ?? panel;
  }

  @override
  bool updateShouldNotify(_RemixMenuStyleScope oldWidget) =>
      hasCheckableItems != oldWidget.hasCheckableItems ||
      overlay != oldWidget.overlay ||
      surface != oldWidget.surface ||
      defaultItemStyle != oldWidget.defaultItemStyle ||
      defaultItemStyleSpec != oldWidget.defaultItemStyleSpec ||
      defaultLabelStyle != oldWidget.defaultLabelStyle ||
      defaultLabelStyleSpec != oldWidget.defaultLabelStyleSpec ||
      defaultDividerStyle != oldWidget.defaultDividerStyle ||
      defaultDividerStyleSpec != oldWidget.defaultDividerStyleSpec ||
      submenuPositioning != oldWidget.submenuPositioning ||
      contentWrapper != oldWidget.contentWrapper;
}

class _RemixMenuStatefulItem extends StatelessWidget {
  const _RemixMenuStatefulItem({
    required this.controller,
    required this.child,
    required this.excludeChildSemantics,
    required this.style,
    this.additionalStates = const {},
    this.leading,
    this.trailing,
    this.indicator,
    this.showIndicatorWhenSelected = false,
    this.showDefaultChevron = false,
  });

  final WidgetStatesController controller;
  final Set<WidgetState> additionalStates;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? indicator;
  final bool showIndicatorWhenSelected;
  final bool showDefaultChevron;
  final bool excludeChildSemantics;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) {
      final states = {...controller.value, ...additionalStates};
      return WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) => _RemixMenuItemChrome(
            child: child,
            leading: leading,
            trailing: trailing,
            indicator: indicator,
            showIndicator:
                showIndicatorWhenSelected &&
                states.contains(WidgetState.selected),
            showDefaultChevron: showDefaultChevron,
            excludeChildSemantics: excludeChildSemantics,
            style: style,
          ),
        ),
      );
    },
  );
}

class _RemixMenuItemChrome extends StatelessWidget {
  const _RemixMenuItemChrome({
    required this.child,
    required this.excludeChildSemantics,
    required this.style,
    this.leading,
    this.trailing,
    this.indicator,
    this.showIndicator = false,
    this.showDefaultChevron = false,
    this.useLabelStyle = false,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? indicator;
  final bool showIndicator;
  final bool showDefaultChevron;
  final bool excludeChildSemantics;
  final bool useLabelStyle;
  final RemixMenuItemStyler style;

  @override
  Widget build(BuildContext context) {
    final scope = _RemixMenuStyleScope.of(context);
    final styleSpec = useLabelStyle
        ? scope.resolveLabelStyle(context, style)
        : scope.resolveItemStyle(context, style);
    return StyleSpecBuilder<RemixMenuItemSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) {
        final leadingInset = scope.hasCheckableItems
            ? spec.checkableLeadingInset ?? spec.leadingInset ?? 0
            : spec.leadingInset ?? 0;
        final trailingInset = spec.trailingInset ?? 0;
        final content = remixInheritedContentStyle(
          child: child,
          text: spec.label,
        );
        final effectiveContent = excludeChildSemantics
            ? ExcludeSemantics(child: content)
            : content;
        final effectiveIndicator = showIndicator
            ? indicator ??
                  RemixPathIcon(
                    glyph: RemixPathGlyph.thickCheck,
                    styleSpec: spec.indicatorIcon,
                  )
            : null;
        final effectiveTrailing = showDefaultChevron
            ? RemixPathIcon(
                glyph: RemixPathGlyph.chevronRight,
                styleSpec: spec.trailingIcon,
                matchTextDirection: true,
              )
            : trailing;

        return StyleSpecBuilder<FlexBoxSpec>(
          styleSpec: spec.container,
          builder: (context, containerSpec) {
            final spacing = containerSpec.flex?.spec.spacing ?? 0;
            final row = Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: spacing,
              children: [
                if (leading != null)
                  remixInheritedContentStyle(
                    child: leading!,
                    icon: spec.leadingIcon,
                  ),
                // ignore: avoid-flexible-outside-flex
                Expanded(child: effectiveContent),
                if (effectiveTrailing != null)
                  remixInheritedContentStyle(
                    child: effectiveTrailing,
                    icon: spec.trailingIcon,
                  ),
              ],
            );
            return Stack(
              children: [
                FlexBox(
                  styleSpec: spec.container,
                  children: [
                    // ignore: avoid-flexible-outside-flex
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: leadingInset,
                          end: trailingInset,
                        ),
                        child: row,
                      ),
                    ),
                  ],
                ),
                if (effectiveIndicator != null)
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    bottom: 0,
                    width: leadingInset,
                    child: Box(
                      styleSpec: spec.indicator,
                      child: effectiveIndicator,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _RemixMenuAdjacentLabelScope extends InheritedWidget {
  const _RemixMenuAdjacentLabelScope({required super.child});

  static bool maybeOf(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_RemixMenuAdjacentLabelScope>() !=
      null;

  @override
  bool updateShouldNotify(_RemixMenuAdjacentLabelScope oldWidget) => false;
}

List<Widget> _decorateMenuEntries(List<Widget> entries) {
  final result = <Widget>[];
  Widget? previous;
  for (final entry in entries) {
    result.add(
      entry is RemixMenuLabel && _isInteractiveMenuEntry(previous)
          ? _RemixMenuAdjacentLabelScope(child: entry)
          : entry,
    );
    previous = entry;
  }
  return result;
}

bool _isInteractiveMenuEntry(Widget? widget) =>
    widget is RemixMenuAction ||
    widget is RemixMenuCheckboxItem ||
    widget is RemixMenuRadioItem ||
    widget is RemixMenuSubmenu;

bool _menuEntriesContainCheckable(List<Widget> entries) {
  for (final entry in entries) {
    if (entry is RemixMenuCheckboxItem || entry is RemixMenuRadioItem) {
      return true;
    }
    if (entry is RemixMenuGroup &&
        _menuEntriesContainCheckable(entry.children)) {
      return true;
    }
    if (entry is RemixMenuRadioGroup &&
        _menuEntriesContainCheckable(entry.children)) {
      return true;
    }
  }
  return false;
}
