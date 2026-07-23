part of 'select.dart';

/// Wraps one visual part of a select without replacing its behavior.
typedef RemixSelectPartWrapper =
    Widget Function(BuildContext context, Widget child);

/// Builds a Select glyph while preserving the resolved icon style slot.
typedef RemixSelectIconBuilder =
    Widget Function(BuildContext context, StyleSpec<IconSpec> styleSpec);

// ============================================================================
// DATA CLASSES - Trigger and Select Entries
// ============================================================================

/// Data class representing a select trigger.
///
/// Used with [RemixSelect] to define the trigger button that opens the dropdown.
/// Displays placeholder text when no value is selected, or the selected value's label.
class RemixSelectTrigger {
  /// Placeholder text to display when no value is selected.
  final String placeholder;

  /// Optional icon to display before the label/placeholder.
  /// When provided, icon appears in leading position (before text).
  final IconData? icon;

  const RemixSelectTrigger({required this.placeholder, this.icon});
}

/// A structural entry rendered in a [RemixSelect] content popup.
sealed class RemixSelectEntry<T> {
  const RemixSelectEntry();
}

/// A selectable option.
class RemixSelectItem<T> extends RemixSelectEntry<T> {
  /// The value associated with this option.
  /// Passed to onChanged callback when selected.
  final T value;

  /// The text label to display.
  final String label;

  /// Whether this option can be selected.
  final bool enabled;

  /// The style for the item.
  final RemixSelectMenuItemStyler style;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  const RemixSelectItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.style = const RemixSelectMenuItemStyler.create(),
    this.semanticLabel,
  }) : super();
}

/// A semantic and visual group of select entries.
class RemixSelectGroup<T> extends RemixSelectEntry<T> {
  const RemixSelectGroup({required this.entries, this.semanticLabel}) : super();

  /// Entries contained by this group.
  final List<RemixSelectEntry<T>> entries;

  /// Optional accessible name for the group boundary.
  final String? semanticLabel;
}

/// A non-selectable label inside select content.
class RemixSelectLabel<T> extends RemixSelectEntry<T> {
  const RemixSelectLabel({
    required this.label,
    this.semanticLabel,
    this.style = const RemixSelectLabelStyler.create(),
  }) : super();

  /// Visible label text.
  final String label;

  /// Optional accessible name overriding [label].
  final String? semanticLabel;

  /// Per-label visual style merged after the select's default label style.
  final RemixSelectLabelStyler style;
}

/// A decorative separator inside select content.
class RemixSelectSeparator<T> extends RemixSelectEntry<T> {
  const RemixSelectSeparator({this.style = const BoxStyler.create()}) : super();

  /// Per-separator visual style merged after the select default.
  final BoxStyler style;
}

// ============================================================================
// REMIX SELECT - Main select widget
// ============================================================================

/// A customizable select component with data-driven API.
///
/// Uses a declarative trigger plus sealed content entries.
/// Form input component for selecting a single value from a dropdown list.
///
/// ## Example
///
/// ```dart
/// RemixSelect<String>(
///   trigger: RemixSelectTrigger(placeholder: 'Select a fruit'),
///   entries: [
///     RemixSelectItem(value: 'apple', label: 'Apple'),
///     RemixSelectItem(value: 'banana', label: 'Banana'),
///     RemixSelectItem(value: 'orange', label: 'Orange'),
///   ],
///   selectedValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
/// )
/// ```
class RemixSelect<T> extends StatefulWidget {
  const RemixSelect({
    super.key,
    required this.trigger,
    required this.entries,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
      sideOffset: 4,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.open,
    this.onOpenChanged,
    this.enabled = true,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
    this.triggerWrapper,
    this.contentWrapper,
    this.triggerChevronBuilder,
    this.itemIndicatorBuilder,
    this.style = const RemixSelectStyler.create(),
    this.styleSpec,
  });

  /// The trigger data that defines the select's button.
  final RemixSelectTrigger trigger;

  /// Structured content entries.
  final List<RemixSelectEntry<T>> entries;

  /// The currently selected value.
  final T? selectedValue;

  /// Overlay positioning configuration for the dropdown.
  final OverlayPositionConfig positioning;

  /// Called when the selected value changes.
  ///
  /// When null, selection changes are ignored, but an enabled select can still
  /// open so its options can be inspected.
  final ValueChanged<T?>? onChanged;

  /// Called when the dropdown opens.
  final VoidCallback? onOpen;

  /// Called when the dropdown closes.
  final VoidCallback? onClose;

  /// Controls whether the dropdown is open.
  ///
  /// When null, the select owns its open state. When non-null, interaction
  /// requests are reported through [onOpenChanged] and the overlay continues
  /// to follow this value until the owner rebuilds it.
  final bool? open;

  /// Called when user interaction requests a controlled open-state change.
  final ValueChanged<bool>? onOpenChanged;

  /// Whether the select is enabled and can be interacted with.
  final bool enabled;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether to automatically close the dropdown when an item is selected.
  final bool closeOnSelect;

  /// Optional focus node to control focus behavior.
  final FocusNode? focusNode;

  /// Optional inherited-scope wrapper around trigger style resolution.
  final RemixSelectPartWrapper? triggerWrapper;

  /// Optional inherited-scope wrapper around popup-content style resolution.
  final RemixSelectPartWrapper? contentWrapper;

  /// Optional visual replacement for the trigger chevron.
  final RemixSelectIconBuilder? triggerChevronBuilder;

  /// Optional visual replacement for the selected-item indicator.
  final RemixSelectIconBuilder? itemIndicatorBuilder;

  /// The style configuration for the select.
  final RemixSelectStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixSelectSpec? styleSpec;

  static final styleFrom = RemixSelectStyler.new;

  @override
  State<RemixSelect<T>> createState() => _RemixSelectState<T>();
}

class _RemixSelectState<T> extends State<RemixSelect<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  RemixSelectStyler _buildStyle() {
    return RemixSelectStyler()
        .trigger(
          RemixSelectTriggerStyler().mainAxisSize(.min).wrap(.intrinsicWidth()),
        )
        .content(RemixSelectContentStyler().wrap(.intrinsicWidth()))
        .merge(widget.style);
  }

  Widget _buildOverlayMenu(
    RemixSelectSpec spec,
    RawMenuOverlayInfo info,
    Prop<StyleSpec<RemixSelectMenuItemSpec>>? defaultItemStyle,
    Prop<StyleSpec<RemixSelectLabelSpec>>? defaultLabelStyle,
    Prop<StyleSpec<BoxSpec>>? defaultSeparatorStyle,
  ) {
    return _AnimatedOverlayMenu(
      controller: animationController,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      content: spec.content,
      minimumWidth: info.anchorRect.width,
      maximumHeight: info.overlaySize.height,
      children: _buildEntries(
        widget.entries,
        defaultItemStyle: widget.styleSpec == null ? defaultItemStyle : null,
        defaultItemStyleSpec: widget.styleSpec == null ? null : spec.item,
        defaultLabelStyle: widget.styleSpec == null ? defaultLabelStyle : null,
        defaultLabelStyleSpec: widget.styleSpec == null ? null : spec.label,
        defaultSeparatorStyle: widget.styleSpec == null
            ? defaultSeparatorStyle
            : null,
        defaultSeparatorStyleSpec: widget.styleSpec == null
            ? null
            : spec.separator,
      ),
    );
  }

  List<Widget> _buildEntries(
    List<RemixSelectEntry<T>> entries, {
    required Prop<StyleSpec<RemixSelectMenuItemSpec>>? defaultItemStyle,
    required StyleSpec<RemixSelectMenuItemSpec>? defaultItemStyleSpec,
    required Prop<StyleSpec<RemixSelectLabelSpec>>? defaultLabelStyle,
    required StyleSpec<RemixSelectLabelSpec>? defaultLabelStyleSpec,
    required Prop<StyleSpec<BoxSpec>>? defaultSeparatorStyle,
    required StyleSpec<BoxSpec>? defaultSeparatorStyleSpec,
  }) {
    final children = <Widget>[];
    RemixSelectEntry<T>? previous;
    for (final entry in entries) {
      final child = switch (entry) {
        RemixSelectItem<T>() => _RemixSelectItemWidget<T>(
          data: entry,
          defaultStyle: defaultItemStyle,
          defaultStyleSpec: defaultItemStyleSpec,
          indicatorBuilder: widget.itemIndicatorBuilder,
        ),
        RemixSelectLabel<T>() => _RemixSelectLabelWidget<T>(
          data: entry,
          followsItem: previous is RemixSelectItem<T>,
          defaultStyle: defaultLabelStyle,
          defaultStyleSpec: defaultLabelStyleSpec,
        ),
        RemixSelectSeparator<T>() => _RemixSelectSeparatorWidget<T>(
          data: entry,
          defaultStyle: defaultSeparatorStyle,
          defaultStyleSpec: defaultSeparatorStyleSpec,
        ),
        RemixSelectGroup<T>() => _RemixSelectGroupWidget<T>(
          semanticLabel: entry.semanticLabel,
          children: _buildEntries(
            entry.entries,
            defaultItemStyle: defaultItemStyle,
            defaultItemStyleSpec: defaultItemStyleSpec,
            defaultLabelStyle: defaultLabelStyle,
            defaultLabelStyleSpec: defaultLabelStyleSpec,
            defaultSeparatorStyle: defaultSeparatorStyle,
            defaultSeparatorStyleSpec: defaultSeparatorStyleSpec,
          ),
        ),
      };
      children.add(child);
      previous = entry;
    }
    return children;
  }

  RemixSelectItem<T>? _findItem(List<RemixSelectEntry<T>> entries, T value) {
    for (final entry in entries) {
      switch (entry) {
        case RemixSelectItem<T>():
          if (entry.value == value) return entry;
        case RemixSelectGroup<T>():
          final nested = _findItem(entry.entries, value);
          if (nested != null) return nested;
        case RemixSelectLabel<T>() || RemixSelectSeparator<T>():
          break;
      }
    }
    return null;
  }

  String _getDisplayLabel() {
    final selectedValue = widget.selectedValue;
    if (selectedValue == null) return widget.trigger.placeholder;

    final selectedItem = _findItem(widget.entries, selectedValue);
    if (selectedItem != null) return selectedItem.label;

    assert(
      selectedItem != null,
      'RemixSelect: selectedValue "$selectedValue" not found in entries. '
      'Ensure selectedValue matches a RemixSelectItem value.',
    );

    // Gracefully degrade in release mode - show placeholder
    return widget.trigger.placeholder;
  }

  void _validateUniqueValues() {
    final seen = <T>[];

    void visit(List<RemixSelectEntry<T>> entries) {
      for (final entry in entries) {
        switch (entry) {
          case RemixSelectItem<T>():
            if (seen.any((value) => value == entry.value)) {
              throw FlutterError(
                'RemixSelect contains duplicate item value "${entry.value}". '
                'Every RemixSelectItem value must be unique, including items '
                'inside groups.',
              );
            }
            seen.add(entry.value);
          case RemixSelectGroup<T>():
            visit(entry.entries);
          case RemixSelectLabel<T>() || RemixSelectSeparator<T>():
            break;
        }
      }
    }

    visit(widget.entries);
  }

  void _handleChanged(T? value) => widget.onChanged?.call(value);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _validateUniqueValues();
    final style = _buildStyle();

    return NakedSelect<T>(
      overlayBuilder: (context, info) {
        final content = RemixStyleSpecBuilder<RemixSelectSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          builder: (context, spec) => _buildOverlayMenu(
            spec,
            info,
            style.$item,
            style.$label,
            style.$separator,
          ),
        );
        return widget.contentWrapper?.call(context, content) ?? content;
      },
      value: widget.selectedValue,
      onChanged: _handleChanged,
      closeOnSelect: widget.closeOnSelect,
      enabled: widget.enabled,
      triggerFocusNode: widget.focusNode,
      semanticLabel: widget.semanticLabel,
      positioning: widget.positioning,
      open: widget.open,
      onOpenChanged: widget.onOpenChanged,
      onOpen: () {
        animationController.forward();
        widget.onOpen?.call();
      },
      onClose: () {
        animationController.reverse();
        widget.onClose?.call();
      },
      builder: (context, state, _) {
        final controller = NakedSelectState.controllerOf<T>(context);
        final trigger = ListenableBuilder(
          listenable: controller,
          builder: (context, _) => WidgetStateProvider(
            states: {
              ...controller.value,
              if (state.isOpen) WidgetState.selected,
            },
            child: RemixStyleSpecBuilder<RemixSelectSpec>(
              style: style,
              styleSpec: widget.styleSpec,
              builder: (context, spec) => _RemixSelectTriggerWidget(
                trigger: widget.trigger,
                displayLabel: _getDisplayLabel(),
                isPlaceholder: widget.selectedValue == null,
                styleSpec: spec.trigger,
                chevronBuilder: widget.triggerChevronBuilder,
              ),
            ),
          ),
        );
        return widget.triggerWrapper?.call(context, trigger) ?? trigger;
      },
    );
  }
}

class _AnimatedOverlayMenu extends StatefulWidget {
  const _AnimatedOverlayMenu({
    required this.controller,
    required this.duration,
    required this.curve,
    required this.content,
    required this.minimumWidth,
    required this.maximumHeight,
    required this.children,
  });

  final AnimationController controller;
  final Duration duration;
  final Curve curve;
  final StyleSpec<RemixSelectContentSpec> content;
  final double minimumWidth;
  final double maximumHeight;
  final List<Widget> children;

  @override
  State<_AnimatedOverlayMenu> createState() => _AnimatedOverlayMenuState();
}

class _AnimatedOverlayMenuState extends State<_AnimatedOverlayMenu> {
  late final Animation<double> scaleAnimation;
  late final CurvedAnimation _fadeCurve;
  late final CurvedAnimation _scaleCurve;

  Animation<double> get fadeAnimation => _fadeCurve;

  @override
  void initState() {
    super.initState();

    widget.controller.duration = widget.duration;
    _fadeCurve = CurvedAnimation(
      parent: widget.controller,
      curve: widget.curve,
    );
    _scaleCurve = CurvedAnimation(
      parent: widget.controller,
      curve: widget.curve,
    );
    scaleAnimation = _scaleCurve.drive(Tween<double>(begin: 0.95, end: 1.0));
  }

  @override
  void dispose() {
    _fadeCurve.dispose();
    _scaleCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.minimumWidth,
            maxHeight: widget.maximumHeight,
          ),
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Opacity(
              opacity: fadeAnimation.value,
              child: StyleSpecBuilder<RemixSelectContentSpec>(
                styleSpec: widget.content,
                builder: (context, spec) => remixBoxWithEffects(
                  key: const ValueKey('remix-select-content-surface'),
                  styleSpec: spec.container,
                  containerEffects: spec.containerEffects,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// INTERNAL WIDGETS - Trigger, Item, and Label
// ============================================================================

/// Internal widget for rendering the select trigger.
class _RemixSelectTriggerWidget extends StatelessWidget {
  const _RemixSelectTriggerWidget({
    required this.trigger,
    required this.displayLabel,
    required this.isPlaceholder,
    required this.styleSpec,
    this.chevronBuilder,
  });

  final RemixSelectTrigger trigger;
  final String displayLabel;
  final bool isPlaceholder;
  final StyleSpec<RemixSelectTriggerSpec> styleSpec;
  final RemixSelectIconBuilder? chevronBuilder;

  @override
  Widget build(BuildContext context) {
    return StyleSpecBuilder<RemixSelectTriggerSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) {
        return remixFlexBoxWithEffects(
          key: const ValueKey('remix-select-trigger-surface'),
          styleSpec: spec.container,
          direction: Axis.horizontal,
          containerEffects: spec.containerEffects,
          children: [
            if (trigger.icon != null)
              StyledIcon(icon: trigger.icon!, styleSpec: spec.icon),
            // ignore: avoid-flexible-outside-flex
            Expanded(
              child: Opacity(
                opacity: isPlaceholder ? spec.placeholderOpacity ?? 1 : 1,
                child: StyledText(
                  displayLabel,
                  styleSpec: isPlaceholder ? spec.placeholder : spec.label,
                ),
              ),
            ),
            Opacity(
              opacity: spec.chevronOpacity ?? 1,
              child:
                  chevronBuilder?.call(context, spec.chevron) ??
                  StyledIcon(
                    icon: Icons.keyboard_arrow_down,
                    styleSpec: spec.chevron,
                  ),
            ),
          ],
        );
      },
    );
  }
}

/// Internal widget for rendering a selectable item.
class _RemixSelectItemWidget<T> extends StatelessWidget {
  const _RemixSelectItemWidget({
    required this.data,
    this.defaultStyle,
    this.defaultStyleSpec,
    this.indicatorBuilder,
  });

  final RemixSelectItem<T> data;
  final Prop<StyleSpec<RemixSelectMenuItemSpec>>? defaultStyle;
  final StyleSpec<RemixSelectMenuItemSpec>? defaultStyleSpec;
  final RemixSelectIconBuilder? indicatorBuilder;

  StyleSpec<RemixSelectMenuItemSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;

    final itemStyle = MixOps.merge(
      defaultStyle,
      Prop.maybeMix<StyleSpec<RemixSelectMenuItemSpec>>(data.style),
    );

    return MixOps.resolve(context, itemStyle) ??
        const StyleSpec(spec: RemixSelectMenuItemSpec());
  }

  @override
  Widget build(BuildContext context) {
    return NakedSelectOption<T>(
      value: data.value,
      enabled: data.enabled,
      semanticLabel: data.semanticLabel ?? data.label,
      builder: (context, states, _) {
        final controller = NakedSelectOptionState.controllerOf<T>(context);

        return ExcludeSemantics(
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return WidgetStateProvider(
                states: controller.value,
                child: Builder(
                  builder: (context) => StyleSpecBuilder(
                    styleSpec: _resolveStyle(context),
                    builder: (context, spec) => Stack(
                      children: [
                        RowBox(
                          styleSpec: spec.container,
                          children: [
                            // ignore: avoid-flexible-outside-flex
                            Expanded(
                              child: StyledText(
                                data.label,
                                styleSpec: spec.text,
                              ),
                            ),
                          ],
                        ),
                        PositionedDirectional(
                          start: 0,
                          top: 0,
                          bottom: 0,
                          child: Box(
                            styleSpec: spec.indicator,
                            child:
                                controller.value.contains(WidgetState.selected)
                                ? indicatorBuilder?.call(context, spec.icon) ??
                                      StyledIcon(
                                        icon: Icons.check,
                                        styleSpec: spec.icon,
                                      )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _RemixSelectGroupWidget<T> extends StatelessWidget {
  const _RemixSelectGroupWidget({
    required this.semanticLabel,
    required this.children,
  });

  final String? semanticLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _RemixSelectLabelWidget<T> extends StatelessWidget {
  const _RemixSelectLabelWidget({
    required this.data,
    required this.followsItem,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixSelectLabel<T> data;
  final bool followsItem;
  final Prop<StyleSpec<RemixSelectLabelSpec>>? defaultStyle;
  final StyleSpec<RemixSelectLabelSpec>? defaultStyleSpec;

  StyleSpec<RemixSelectLabelSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;
    return MixOps.resolve(
          context,
          MixOps.merge(
            defaultStyle,
            Prop.maybeMix<StyleSpec<RemixSelectLabelSpec>>(data.style),
          ),
        ) ??
        const StyleSpec(spec: RemixSelectLabelSpec());
  }

  @override
  Widget build(BuildContext context) {
    return StyleSpecBuilder<RemixSelectLabelSpec>(
      styleSpec: _resolveStyle(context),
      builder: (context, spec) => Padding(
        padding: EdgeInsets.only(
          top: followsItem ? spec.adjacentItemSpacing ?? 0 : 0,
        ),
        child: Semantics(
          header: true,
          label: data.semanticLabel ?? data.label,
          child: ExcludeSemantics(
            child: RowBox(
              styleSpec: spec.container,
              children: [StyledText(data.label, styleSpec: spec.text)],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemixSelectSeparatorWidget<T> extends StatelessWidget {
  const _RemixSelectSeparatorWidget({
    required this.data,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixSelectSeparator<T> data;
  final Prop<StyleSpec<BoxSpec>>? defaultStyle;
  final StyleSpec<BoxSpec>? defaultStyleSpec;

  StyleSpec<BoxSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;
    return MixOps.resolve(
          context,
          MixOps.merge(
            defaultStyle,
            Prop.maybeMix<StyleSpec<BoxSpec>>(data.style),
          ),
        ) ??
        const StyleSpec(spec: BoxSpec());
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(child: Box(styleSpec: _resolveStyle(context)));
  }
}
