part of 'select.dart';

// ============================================================================
// DATA CLASSES - Trigger and Select Item
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

/// Data class representing a selectable option.
///
/// Used with [RemixSelect]'s items list to define selectable options.
class RemixSelectItem<T> {
  /// The value associated with this option.
  /// Passed to onChanged callback when selected.
  final T value;

  /// The text label to display.
  final String label;

  /// Whether this option can be selected.
  final bool enabled;

  /// The style for the item.
  final SelectMenuItemStyler style;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  const RemixSelectItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.style = const SelectMenuItemStyler.create(),
    this.semanticLabel,
  });
}

// ============================================================================
// REMIX SELECT - Main select widget
// ============================================================================

/// A customizable select component with data-driven API.
///
/// Uses a simple, declarative API with data classes for trigger and items.
/// Form input component for selecting a single value from a dropdown list.
///
/// ## Example
///
/// ```dart
/// RemixSelect<String>(
///   trigger: RemixSelectTrigger(placeholder: 'Select a fruit'),
///   items: [
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
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .center,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.closeOnSelect = true,
    this.focusNode,
    this.style = const SelectStyler.create(),
    this.styleSpec,
  });

  /// The trigger data that defines the select's button.
  final RemixSelectTrigger trigger;

  /// The list of selectable items.
  final List<RemixSelectItem<T>> items;

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

  /// Whether the select is enabled and can be interacted with.
  final bool enabled;

  /// The mouse cursor for the select trigger.
  final MouseCursor mouseCursor;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether to automatically close the dropdown when an item is selected.
  final bool closeOnSelect;

  /// Optional focus node to control focus behavior.
  final FocusNode? focusNode;

  /// The style configuration for the select.
  final SelectStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final SelectSpec? styleSpec;

  static final styleFrom = SelectStyler.new;

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

  SelectStyler _buildStyle() {
    return SelectStyler()
        .trigger(
          SelectTriggerStyler().mainAxisSize(.min).wrap(.intrinsicWidth()),
        )
        .menuContainer(
          FlexBoxStyler().mainAxisSize(.min).wrap(.intrinsicWidth()),
        )
        .merge(widget.style);
  }

  Widget _buildOverlayMenu(
    SelectSpec spec,
    Prop<StyleSpec<SelectMenuItemSpec>>? defaultItemStyle,
  ) {
    final menuContainerSpec = spec.menuContainer;

    return _AnimatedOverlayMenu(
      controller: animationController,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      content: spec.content,
      menuContainer: menuContainerSpec,
      children: widget.items
          .map(
            (item) => _RemixSelectItemWidget(
              data: item,
              defaultStyle: widget.styleSpec == null ? defaultItemStyle : null,
              defaultStyleSpec: widget.styleSpec == null ? null : spec.item,
            ),
          )
          .toList(),
    );
  }

  RemixSelectItem<T>? _findSelectedItem() {
    final selectedValue = widget.selectedValue;
    if (selectedValue == null) return null;

    RemixSelectItem<T>? selectedItem;
    for (final item in widget.items) {
      if (item.value == selectedValue) {
        selectedItem = item;
        break;
      }
    }

    assert(
      selectedItem != null,
      'RemixSelect: selectedValue "$selectedValue" not found in items. '
      'Ensure selectedValue matches one of the item values.',
    );

    return selectedItem;
  }

  void _handleChanged(T? value) => widget.onChanged?.call(value);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle();
    final selectedItem = _findSelectedItem();

    return NakedSelect<T>(
      overlayBuilder: (context, info) {
        return RemixStyleSpecBuilder<SelectSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          builder: (context, spec) => _buildOverlayMenu(spec, style.$item),
        );
      },
      value: widget.selectedValue,
      onChanged: _handleChanged,
      closeOnSelect: widget.closeOnSelect,
      enabled: widget.enabled,
      mouseCursor: widget.mouseCursor,
      triggerFocusNode: widget.focusNode,
      semanticLabel: widget.semanticLabel,
      positioning: widget.positioning,
      onOpen: () {
        animationController.forward();
        widget.onOpen?.call();
      },
      onClose: () {
        animationController.reverse();
        widget.onClose?.call();
      },
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<SelectSpec>(
          style: style,
          styleSpec: widget.styleSpec,
          controller: NakedSelectState.controllerOf<T>(context),
          builder: (context, spec) {
            final triggerSpec = spec.trigger;

            return _RemixSelectTriggerWidget(
              trigger: widget.trigger,
              displayLabel: selectedItem?.label ?? widget.trigger.placeholder,
              isPlaceholder: selectedItem == null,
              isOpen: state.isOpen,
              styleSpec: triggerSpec,
            );
          },
        );
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
    required this.menuContainer,
    required this.children,
  });

  final AnimationController controller;
  final Duration duration;
  final Curve curve;
  final StyleSpec<SelectContentSpec> content;
  final StyleSpec<FlexBoxSpec> menuContainer;
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
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Opacity(
            opacity: fadeAnimation.value,
            child: StyleSpecBuilder<SelectContentSpec>(
              styleSpec: widget.content,
              builder: (context, spec) => RemixBoxWithEffects(
                styleSpec: spec.container,
                containerEffects: spec.containerEffects,
                child: ColumnBox(
                  styleSpec: widget.menuContainer,
                  children: widget.children,
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
    required this.isOpen,
    required this.styleSpec,
  });

  final RemixSelectTrigger trigger;
  final String displayLabel;
  final bool isPlaceholder;
  final bool isOpen;
  final StyleSpec<SelectTriggerSpec> styleSpec;

  @override
  Widget build(BuildContext context) {
    return StyleSpecBuilder<SelectTriggerSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) {
        return RemixFlexBoxWithEffects(
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
            Transform.rotate(
              angle: isOpen ? math.pi : 0,
              child: Opacity(
                opacity: spec.chevronOpacity ?? 1,
                child: RemixPathIcon(
                  key: const ValueKey('fortal-select-chevron'),
                  glyph: RemixPathGlyph.chevronDown,
                  styleSpec: spec.chevron,
                ),
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
  });

  final RemixSelectItem<T> data;
  final Prop<StyleSpec<SelectMenuItemSpec>>? defaultStyle;
  final StyleSpec<SelectMenuItemSpec>? defaultStyleSpec;

  StyleSpec<SelectMenuItemSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;

    final itemStyle = MixOps.merge(
      defaultStyle,
      Prop.maybeMix<StyleSpec<SelectMenuItemSpec>>(data.style),
    );

    return MixOps.resolve(context, itemStyle) ??
        const StyleSpec(spec: SelectMenuItemSpec());
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
                    builder: (context, spec) => RowBox(
                      styleSpec: spec.container,
                      children: [
                        // ignore: avoid-flexible-outside-flex
                        Expanded(
                          child: StyledText(data.label, styleSpec: spec.text),
                        ),
                        if (states.isSelected)
                          Box(
                            styleSpec: spec.indicator,
                            child: RemixPathIcon(
                              key: const ValueKey('fortal-select-indicator'),
                              glyph: RemixPathGlyph.thickCheck,
                              styleSpec: spec.icon,
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
