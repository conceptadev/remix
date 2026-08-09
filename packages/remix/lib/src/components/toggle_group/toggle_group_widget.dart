part of 'toggle_group.dart';

/// Declarative data for one option in a [RemixToggleGroup].
class RemixToggleGroupItem<T> {
  /// The non-null value selected when this item is activated.
  ///
  /// Values in a group must be unique and must keep stable equality and hash-code
  /// behavior for the lifetime of the rendered item.
  final T value;

  /// Optional text shown in the item.
  final String? label;

  /// Optional icon shown before [label].
  final IconData? icon;

  /// Accessibility label for this item.
  ///
  /// Falls back to [label] when omitted. Icon-only items must provide this.
  final String? semanticLabel;

  /// Whether the item can receive focus and be activated.
  final bool enabled;

  /// Optional caller-owned focus node.
  final FocusNode? focusNode;

  /// Whether this item requests initial focus when the group mounts.
  final bool autofocus;

  /// Per-item style merged after the group's default item style.
  final ToggleGroupItemStyler style;

  const RemixToggleGroupItem({
    required this.value,
    this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.style = const ToggleGroupItemStyler.create(),
  }) : assert(value != null, 'Toggle group item values must be non-null'),
       assert(label != '', 'Item labels must not be empty'),
       assert(semanticLabel != '', 'Item semantic labels must not be empty'),
       assert(
         label != null || icon != null,
         'At least one of label or icon must be provided',
       ),
       assert(
         label != null || semanticLabel != null,
         'Icon-only toggle group items require a semanticLabel',
       );
}

/// A styled, single-select toggle group with roving keyboard focus.
///
/// ## Example
///
/// ```dart
/// RemixToggleGroup<String>(
///   selectedValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   items: const [
///     RemixToggleGroupItem(
///       value: 'left',
///       icon: Icons.format_align_left,
///       semanticLabel: 'Align left',
///     ),
///     RemixToggleGroupItem(
///       value: 'center',
///       icon: Icons.format_align_center,
///       semanticLabel: 'Align center',
///     ),
///     RemixToggleGroupItem(
///       value: 'right',
///       icon: Icons.format_align_right,
///       semanticLabel: 'Align right',
///     ),
///   ],
/// )
/// ```
class RemixToggleGroup<T> extends StatelessWidget {
  const RemixToggleGroup({
    super.key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const ToggleGroupStyler.create(),
    this.styleSpec,
  });

  /// Items rendered in visual and focus-traversal order.
  ///
  /// Item values must be non-null and unique. The list may be empty when
  /// [selectedValue] is null. Do not mutate the list after constructing the
  /// widget; rebuild with a new list when its contents or order change.
  final List<RemixToggleGroupItem<T>> items;

  /// The currently selected item value, or null when no item is selected.
  ///
  /// A non-null value must match exactly one item in [items]. Null is reserved
  /// as the no-selection sentinel and cannot be used as an item value.
  final T? selectedValue;

  /// Called when an item is activated with a different value.
  ///
  /// When null, the entire group is disabled, including focus, activation,
  /// semantics actions, and disabled item-state styling.
  final ValueChanged<T?>? onChanged;

  /// Whether the whole group is interactive.
  final bool enabled;

  /// Axis used for layout and arrow-key navigation.
  final Axis orientation;

  /// Whether arrow navigation wraps at the ends.
  final bool loop;

  /// Accessibility label for the group.
  final String? semanticLabel;

  /// Whether the group and all items are hidden from semantics.
  final bool excludeSemantics;

  /// Fluent visual style for the group and its default item style.
  final ToggleGroupStyler style;

  /// Optional raw style spec that bypasses fluent group style resolution.
  final ToggleGroupSpec? styleSpec;

  static final styleFrom = ToggleGroupStyler.new;

  bool _debugItemsAreValid() {
    final values = <T>{};
    var autofocusCount = 0;

    for (final item in items) {
      if (!values.add(item.value)) {
        throw FlutterError(
          'RemixToggleGroup item values must be unique. '
          'Duplicate value: ${item.value}.',
        );
      }
      if (item.autofocus) autofocusCount += 1;
    }

    if (selectedValue != null && !values.contains(selectedValue)) {
      throw FlutterError(
        'RemixToggleGroup selectedValue must match one item. '
        'No item has value: $selectedValue.',
      );
    }

    if (autofocusCount > 1) {
      throw FlutterError('Only one item may autofocus in a RemixToggleGroup.');
    }

    return true;
  }

  /// Forces the flex [direction] onto a resolved container so the [orientation]
  /// argument wins over any direction coming from [style] or a raw [styleSpec].
  ///
  /// Applied after resolution because the raw [styleSpec] path bypasses styler
  /// merging entirely, so this is the single point that covers both paths.
  StyleSpec<FlexBoxSpec> _withOrientation(StyleSpec<FlexBoxSpec> container) {
    final flex = container.spec.flex ?? const StyleSpec(spec: FlexSpec());

    return container.copyWith(
      spec: container.spec.copyWith(
        flex: flex.copyWith(spec: flex.spec.copyWith(direction: orientation)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugItemsAreValid());

    // Direction is enforced post-resolution by _withOrientation so the same
    // behavior applies to both fluent styles and raw style specs.
    final effectiveStyle = ToggleGroupStyler(
      container: FlexBoxStyler(
        mainAxisSize: .min,
      ).wrap(.intrinsicWidth().intrinsicHeight()),
    ).merge(style);

    return NakedToggleGroup<T>(
      selectedValue: selectedValue,
      onChanged: onChanged,
      enabled: enabled,
      orientation: orientation,
      loop: loop,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      child: RemixStyleSpecBuilder<ToggleGroupSpec>(
        style: effectiveStyle,
        styleSpec: styleSpec,
        trackFocusHighlightMode: true,
        builder: (context, spec) {
          return FlexBox(
            styleSpec: _withOrientation(spec.container),
            children: [
              for (final item in items)
                _RemixToggleGroupItemWidget(
                  key: ValueKey(item.value),
                  data: item,
                  defaultStyle: styleSpec == null ? effectiveStyle : null,
                  defaultStyleSpec: styleSpec == null ? null : spec.item,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RemixToggleGroupItemWidget<T> extends StatelessWidget {
  const _RemixToggleGroupItemWidget({
    super.key,
    required this.data,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixToggleGroupItem<T> data;
  final ToggleGroupStyler? defaultStyle;
  final StyleSpec<ToggleGroupItemSpec>? defaultStyleSpec;

  StyleSpec<ToggleGroupItemSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;

    final groupStyle = defaultStyle!;
    final compositeStyle = groupStyle.merge(
      ToggleGroupStyler(item: data.style),
    );

    // Build the composite under this option's WidgetStateProvider. Mix then
    // resolves group context variants and nested item-state variants together.
    return compositeStyle.build(context).spec.item;
  }

  @override
  Widget build(BuildContext context) {
    return NakedToggleOption<T>(
      value: data.value,
      enabled: data.enabled,
      focusNode: data.focusNode,
      autofocus: data.autofocus,
      semanticLabel: data.semanticLabel ?? data.label,
      builder: (context, state, _) {
        return WidgetStateProvider(
          states: state.states,
          child: Builder(
            builder: (context) {
              return ExcludeSemantics(
                child: StyleSpecBuilder<ToggleGroupItemSpec>(
                  styleSpec: _resolveStyle(context),
                  builder: (context, spec) {
                    return RowBox(
                      styleSpec: spec.container,
                      children: [
                        if (data.icon != null)
                          StyledIcon(icon: data.icon!, styleSpec: spec.icon),
                        if (data.label != null)
                          StyledText(data.label!, styleSpec: spec.label),
                      ],
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
