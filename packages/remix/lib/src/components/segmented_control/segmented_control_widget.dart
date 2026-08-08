part of 'segmented_control.dart';

/// Declarative data for one option in a [RemixSegmentedControl].
///
/// [T] must be non-nullable because `null` is reserved by the control as the
/// no-selection sentinel.
class RemixSegmentedControlItem<T extends Object> {
  /// The value selected when this segment is activated.
  ///
  /// Values must be unique and keep stable equality and hash-code behavior for
  /// the lifetime of the rendered item.
  final T value;

  /// Optional text shown in the segment.
  ///
  /// When provided, it must contain a non-whitespace character.
  final String? label;

  /// Optional icon shown before [label].
  final IconData? icon;

  /// Accessibility label for this segment.
  ///
  /// Falls back to [label] when omitted. Icon-only items must provide a value
  /// containing at least one non-whitespace character.
  final String? semanticLabel;

  /// Whether this segment can receive focus and be activated.
  final bool enabled;

  /// Optional caller-owned focus node.
  final FocusNode? focusNode;

  /// Whether this segment requests initial focus when the group mounts.
  final bool autofocus;

  /// Per-item style merged after the control's default item style.
  ///
  /// An authoritative raw `styleSpec` on the owning control bypasses this
  /// fluent style.
  final SegmentedControlItemStyler style;

  const RemixSegmentedControlItem({
    required this.value,
    this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.style = const SegmentedControlItemStyler.create(),
  }) : assert(
         label != null || icon != null,
         'At least one of label or icon must be provided',
       ),
       assert(
         label != null || semanticLabel != null,
         'Icon-only segmented control items require a semanticLabel',
       );
}

/// An equal-segment, single-select control with roving keyboard focus.
///
/// This deliberately parallels [RemixToggleGroup] instead of wrapping it.
/// Both controls compose Naked's headless toggle primitives, but a segmented
/// control owns a persistent track, equal segment layout, and effects-aware
/// item surfaces as a distinct public visual anatomy.
///
/// [orientation] and per-item disabled state are Flutter extensions to the
/// Radix Segmented Control model. Activating the selected segment never clears
/// the controlled selection.
///
/// [T] must be non-nullable. A null [selectedValue] represents no selection.
class RemixSegmentedControl<T extends Object> extends StatelessWidget {
  const RemixSegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const SegmentedControlStyler.create(),
    this.styleSpec,
  });

  /// Items rendered in visual and focus-traversal order.
  ///
  /// Item values are non-null by type and must be unique. The list may be empty
  /// when [selectedValue] is null. Do not mutate the list during a build;
  /// rebuild with a new list when its contents or order change.
  final List<RemixSegmentedControlItem<T>> items;

  /// The currently selected item value, or null when no item is selected.
  final T? selectedValue;

  /// Called with the non-null value of an activated inactive segment.
  ///
  /// The control never emits null or clears the selection through this
  /// callback; null is reserved for the controlled [selectedValue] sentinel.
  ///
  /// When null, the entire control is disabled, including focus, activation,
  /// semantics actions, and disabled track/item styling.
  final ValueChanged<T>? onChanged;

  /// Whether the entire control is interactive.
  final bool enabled;

  /// Axis used for layout and arrow-key navigation.
  final Axis orientation;

  /// Whether arrow navigation wraps at the ends.
  final bool loop;

  /// Accessibility label for the control.
  ///
  /// When provided, it must contain a non-whitespace character.
  final String? semanticLabel;

  /// Whether the control and all segments are hidden from semantics.
  final bool excludeSemantics;

  /// Fluent visual style for the track and its default item style.
  final SegmentedControlStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final SegmentedControlSpec? styleSpec;

  static final styleFrom = SegmentedControlStyler.new;

  bool _debugConfigurationIsValid(List<RemixSegmentedControlItem<T>> snapshot) {
    final controlSemanticLabel = semanticLabel;
    assert(
      controlSemanticLabel == null || controlSemanticLabel.trim().isNotEmpty,
      'RemixSegmentedControl semanticLabel must not be blank.',
    );

    final values = <T>{};
    var autofocusCount = 0;

    for (final item in snapshot) {
      final label = item.label;
      final semanticLabel = item.semanticLabel;
      assert(
        label == null || label.trim().isNotEmpty,
        'RemixSegmentedControl item labels must not be blank.',
      );
      assert(
        semanticLabel == null || semanticLabel.trim().isNotEmpty,
        'RemixSegmentedControl item semantic labels must not be blank.',
      );
      if (!values.add(item.value)) {
        throw FlutterError(
          'RemixSegmentedControl item values must be unique. '
          'Duplicate value: ${item.value}.',
        );
      }
      if (item.autofocus) autofocusCount += 1;
    }

    if (selectedValue != null && !values.contains(selectedValue)) {
      throw FlutterError(
        'RemixSegmentedControl selectedValue must match one item. '
        'No item has value: $selectedValue.',
      );
    }

    if (autofocusCount > 1) {
      throw FlutterError(
        'Only one item may autofocus in a RemixSegmentedControl.',
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = List<RemixSegmentedControlItem<T>>.unmodifiable(items);
    assert(_debugConfigurationIsValid(snapshot));

    final handleChanged = onChanged;
    final groupDisabled = !enabled || handleChanged == null;

    return NakedToggleGroup<T>(
      selectedValue: selectedValue,
      onChanged: handleChanged == null
          ? null
          : (value) {
              if (value != null) handleChanged(value);
            },
      enabled: enabled,
      orientation: orientation,
      loop: loop,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      child: WidgetStateProvider(
        states: groupDisabled ? const {WidgetState.disabled} : const {},
        child: RemixStyleSpecBuilder<SegmentedControlSpec>(
          style: style,
          styleSpec: styleSpec,
          builder: (context, spec) {
            final textDirection = Directionality.of(context);
            return StyleSpecBuilder<BoxSpec>(
              key: const ValueKey('RemixSegmentedControl.track'),
              styleSpec: spec.container,
              builder: (context, trackSpec) {
                final fillMainAxis = spec.mainAxisSize == MainAxisSize.max;
                final track = Box(
                  styleSpec: StyleSpec(spec: trackSpec),
                  child: _EqualSegmentLayout(
                    orientation: orientation,
                    spacing: spec.spacing ?? 0,
                    textDirection: textDirection,
                    fillMainAxis: fillMainAxis,
                    children: [
                      for (final item in snapshot)
                        KeyedSubtree(
                          key: ValueKey(item.value),
                          child: _RemixSegmentedControlItemWidget<T>(
                            data: item,
                            defaultStyle: styleSpec == null ? style : null,
                            defaultStyleSpec: styleSpec == null
                                ? null
                                : spec.item,
                          ),
                        ),
                    ],
                  ),
                );
                return Align(
                  alignment: AlignmentDirectional.topStart,
                  widthFactor: orientation == Axis.horizontal && fillMainAxis
                      ? null
                      : 1,
                  heightFactor: orientation == Axis.vertical && fillMainAxis
                      ? null
                      : 1,
                  child: track,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _RemixSegmentedControlItemWidget<T extends Object>
    extends StatelessWidget {
  const _RemixSegmentedControlItemWidget({
    super.key,
    required this.data,
    this.defaultStyle,
    this.defaultStyleSpec,
  });

  final RemixSegmentedControlItem<T> data;
  final SegmentedControlStyler? defaultStyle;
  final StyleSpec<SegmentedControlItemSpec>? defaultStyleSpec;

  StyleSpec<SegmentedControlItemSpec> _resolveStyle(BuildContext context) {
    final rawDefault = defaultStyleSpec;
    if (rawDefault != null) return rawDefault;

    final compositeStyle = defaultStyle!.merge(
      SegmentedControlStyler(item: data.style),
    );

    return compositeStyle.build(context).spec.item;
  }

  @override
  Widget build(BuildContext context) {
    // Naked emits focus and option properties on nested semantics nodes.
    // Collapse them into one named, focusable option node.
    return MergeSemantics(
      child: NakedToggleOption<T>(
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
                  child: StyleSpecBuilder<SegmentedControlItemSpec>(
                    styleSpec: _resolveStyle(context),
                    builder: (context, spec) {
                      return RemixBoxWithEffects(
                        styleSpec: spec.container,
                        containerEffects: spec.containerEffects,
                        // Equal segments make most surfaces wider than their
                        // content, so center the main-axis free space the way
                        // Radix's segmented control item label does. This must
                        // stay on the Row: a default container alignment would
                        // make the Box expand into bounded loose constraints
                        // during the layout's cross-axis measurement pass. An
                        // explicit item container alignment still overrides by
                        // shrink-wrapping the Row.
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: spec.spacing ?? 0,
                          children: [
                            if (data.icon != null)
                              StyledIcon(
                                icon: data.icon!,
                                styleSpec: spec.icon,
                              ),
                            if (data.label != null)
                              Flexible(
                                child: StyledText(
                                  data.label!,
                                  styleSpec: spec.label,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _EqualSegmentLayout extends MultiChildRenderObjectWidget {
  const _EqualSegmentLayout({
    required this.orientation,
    required this.spacing,
    required this.textDirection,
    required this.fillMainAxis,
    required super.children,
  });

  final Axis orientation;
  final double spacing;
  final TextDirection textDirection;
  final bool fillMainAxis;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderEqualSegmentLayout(
      orientation: orientation,
      spacing: spacing,
      textDirection: textDirection,
      fillMainAxis: fillMainAxis,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderEqualSegmentLayout renderObject,
  ) {
    renderObject
      ..orientation = orientation
      ..spacing = spacing
      ..textDirection = textDirection
      ..fillMainAxis = fillMainAxis;
  }
}

class _EqualSegmentParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderEqualSegmentLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _EqualSegmentParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _EqualSegmentParentData> {
  _RenderEqualSegmentLayout({
    required Axis orientation,
    required double spacing,
    required TextDirection textDirection,
    required bool fillMainAxis,
  }) : assert(spacing.isFinite && spacing >= 0.0),
       _orientation = orientation,
       _spacing = spacing,
       _textDirection = textDirection,
       _fillMainAxis = fillMainAxis;

  Axis _orientation;
  double _spacing;
  TextDirection _textDirection;
  bool _fillMainAxis;

  Axis get orientation => _orientation;
  set orientation(Axis value) {
    if (_orientation == value) return;
    _orientation = value;
    markNeedsLayout();
  }

  double get spacing => _spacing;
  set spacing(double value) {
    assert(value.isFinite && value >= 0.0);
    if (_spacing == value) return;
    _spacing = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  bool get fillMainAxis => _fillMainAxis;
  set fillMainAxis(bool value) {
    if (_fillMainAxis == value) return;
    _fillMainAxis = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _EqualSegmentParentData) {
      child.parentData = _EqualSegmentParentData();
    }
  }

  double _saturatingProduct(double value, int factor) {
    if (value <= 0.0 || factor <= 0) return 0.0;
    if (!value.isFinite || value > double.maxFinite / factor) {
      return double.maxFinite;
    }
    return value * factor;
  }

  double _saturatingSum(double first, double second) {
    if (!first.isFinite ||
        !second.isFinite ||
        first > double.maxFinite - second) {
      return double.maxFinite;
    }
    return first + second;
  }

  int get _gapCount => math.max(0, childCount - 1);

  double get _totalSpacing => _saturatingProduct(spacing, _gapCount);

  /// The gap actually used once [mainExtent] is known, clamped so the gaps can
  /// never consume the whole track and starve every segment.
  ///
  /// Layout and the intrinsic queries must agree on this, so it lives in one
  /// place: reporting an intrinsic extent derived from the raw [spacing] makes
  /// an `IntrinsicWidth`/`IntrinsicHeight` parent size the track to zero while
  /// real layout would have given each segment a positive share.
  double _effectiveSpacingFor(double mainExtent) {
    final gapCount = _gapCount;
    if (gapCount == 0 || spacing < mainExtent / gapCount) return spacing;

    return math.min(spacing, mainExtent / childCount);
  }

  /// Each segment's share of [mainExtent], used by the cross-axis intrinsic
  /// overrides to ask children what they need at their real segment size.
  double _intrinsicChildMainExtent(double mainExtent) {
    if (childCount == 0) return mainExtent;
    final totalSpacing = _saturatingProduct(
      _effectiveSpacingFor(mainExtent),
      _gapCount,
    );

    return math.max(0.0, (mainExtent - totalSpacing) / childCount);
  }

  /// Main-axis extent of [childCount] equal segments plus the gaps between
  /// them, each segment sized from the largest child.
  ///
  /// [minimum] selects each child's minimum intrinsic extent, which is what the
  /// `computeMin*` overrides must report; layout and the `computeMax*`
  /// overrides ask for the maximum. Deliberate: conflating the two makes an
  /// intrinsic-sizing parent believe the track cannot shrink, so labels
  /// overflow instead of wrapping.
  double _desiredMainExtent(double crossExtent, {required bool minimum}) =>
      _saturatingSum(
        _saturatingProduct(
          _largestIntrinsicMainExtent(crossExtent, minimum: minimum),
          childCount,
        ),
        _totalSpacing,
      );

  double _largestIntrinsicMainExtent(
    double crossExtent, {
    required bool minimum,
  }) {
    var largest = 0.0;
    var child = firstChild;
    while (child != null) {
      var extent = _childMainExtent(child, crossExtent, minimum: minimum);
      // An unbounded maximum falls back to that child's minimum so a single
      // child cannot push the whole track to infinity. A minimum has no
      // smaller fallback; the saturating helpers clamp it downstream.
      if (!minimum && !extent.isFinite) {
        extent = _childMainExtent(child, crossExtent, minimum: true);
      }
      largest = math.max(largest, extent);
      child = childAfter(child);
    }
    return largest;
  }

  double _childMainExtent(
    RenderBox child,
    double crossExtent, {
    required bool minimum,
  }) {
    return switch ((orientation, minimum)) {
      (Axis.horizontal, true) => child.getMinIntrinsicWidth(crossExtent),
      (Axis.horizontal, false) => child.getMaxIntrinsicWidth(crossExtent),
      (Axis.vertical, true) => child.getMinIntrinsicHeight(crossExtent),
      (Axis.vertical, false) => child.getMaxIntrinsicHeight(crossExtent),
    };
  }

  ({double mainExtent, double effectiveSpacing}) _mainAxisLayout(
    BoxConstraints constraints,
  ) {
    final count = childCount;
    if (count == 0) {
      return (mainExtent: 0, effectiveSpacing: spacing);
    }
    final crossExtent = orientation == Axis.horizontal
        ? constraints.maxHeight
        : constraints.maxWidth;
    // Layout wants the natural size, which is the maximum intrinsic extent.
    final desiredMainExtent = _desiredMainExtent(crossExtent, minimum: false);
    final maxMainExtent = orientation == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    final minMainExtent = orientation == Axis.horizontal
        ? constraints.minWidth
        : constraints.minHeight;

    final mainExtent = switch (maxMainExtent) {
      final extent
          when extent.isFinite && (fillMainAxis || minMainExtent == extent) =>
        extent,
      final extent when extent.isFinite => desiredMainExtent.clamp(
        minMainExtent,
        extent,
      ),
      _ => math.max(desiredMainExtent, minMainExtent),
    };
    return (
      mainExtent: mainExtent,
      effectiveSpacing: _effectiveSpacingFor(mainExtent),
    );
  }

  BoxConstraints _childConstraints(
    BoxConstraints constraints,
    double childMainExtent, {
    double? childCrossExtent,
  }) {
    return switch (orientation) {
      Axis.horizontal => BoxConstraints(
        minWidth: childMainExtent,
        maxWidth: childMainExtent,
        minHeight: childCrossExtent ?? 0,
        maxHeight: childCrossExtent ?? constraints.maxHeight,
      ),
      Axis.vertical => BoxConstraints(
        minWidth: childCrossExtent ?? 0,
        maxWidth: childCrossExtent ?? constraints.maxWidth,
        minHeight: childMainExtent,
        maxHeight: childMainExtent,
      ),
    };
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final count = childCount;
    if (count == 0) return constraints.constrain(Size.zero);

    final layout = _mainAxisLayout(constraints);
    final mainExtent = layout.mainExtent;
    final totalSpacing = _saturatingProduct(
      layout.effectiveSpacing,
      math.max(0, count - 1),
    );
    final childMainExtent = math.max(0.0, (mainExtent - totalSpacing) / count);
    final childConstraints = _childConstraints(constraints, childMainExtent);
    var largestCrossExtent = 0.0;
    var child = firstChild;
    while (child != null) {
      final childSize = child.getDryLayout(childConstraints);
      largestCrossExtent = math.max(
        largestCrossExtent,
        orientation == Axis.horizontal ? childSize.height : childSize.width,
      );
      child = childAfter(child);
    }

    return constraints.constrain(
      orientation == Axis.horizontal
          ? Size(mainExtent, largestCrossExtent)
          : Size(largestCrossExtent, mainExtent),
    );
  }

  @override
  void performLayout() {
    final count = childCount;
    if (count == 0) {
      size = constraints.constrain(Size.zero);
      return;
    }

    final layout = _mainAxisLayout(constraints);
    final mainExtent = layout.mainExtent;
    final effectiveSpacing = layout.effectiveSpacing;
    final totalSpacing = _saturatingProduct(
      effectiveSpacing,
      math.max(0, count - 1),
    );
    final childMainExtent = math.max(0.0, (mainExtent - totalSpacing) / count);
    final childConstraints = _childConstraints(constraints, childMainExtent);
    var largestCrossExtent = 0.0;
    var child = firstChild;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);
      largestCrossExtent = math.max(
        largestCrossExtent,
        orientation == Axis.horizontal ? child.size.height : child.size.width,
      );
      child = childAfter(child);
    }

    size = constraints.constrain(
      orientation == Axis.horizontal
          ? Size(mainExtent, largestCrossExtent)
          : Size(largestCrossExtent, mainExtent),
    );

    final childCrossExtent = orientation == Axis.horizontal
        ? size.height
        : size.width;
    final fillConstraints = _childConstraints(
      constraints,
      childMainExtent,
      childCrossExtent: childCrossExtent,
    );
    var offset = orientation == Axis.horizontal && textDirection == .rtl
        ? size.width
        : 0.0;
    child = firstChild;
    while (child != null) {
      child.layout(fillConstraints, parentUsesSize: true);
      final parentData = child.parentData! as _EqualSegmentParentData;
      if (orientation == Axis.horizontal) {
        if (textDirection == .rtl) offset -= child.size.width;
        parentData.offset = Offset(offset, 0);
        offset += textDirection == .rtl
            ? -effectiveSpacing
            : child.size.width + effectiveSpacing;
      } else {
        parentData.offset = Offset(0, offset);
        offset += child.size.height + effectiveSpacing;
      }
      child = childAfter(child);
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (orientation == Axis.horizontal) {
      return _desiredMainExtent(height, minimum: true);
    }
    var largest = 0.0;
    var child = firstChild;
    final childHeight = _intrinsicChildMainExtent(height);
    while (child != null) {
      largest = math.max(largest, child.getMinIntrinsicWidth(childHeight));
      child = childAfter(child);
    }
    return largest;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (orientation == Axis.horizontal) {
      return _desiredMainExtent(height, minimum: false);
    }
    var largest = 0.0;
    var child = firstChild;
    final childHeight = _intrinsicChildMainExtent(height);
    while (child != null) {
      largest = math.max(largest, child.getMaxIntrinsicWidth(childHeight));
      child = childAfter(child);
    }
    return largest;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (orientation == Axis.vertical) {
      return _desiredMainExtent(width, minimum: true);
    }
    var largest = 0.0;
    var child = firstChild;
    final childWidth = _intrinsicChildMainExtent(width);
    while (child != null) {
      largest = math.max(largest, child.getMinIntrinsicHeight(childWidth));
      child = childAfter(child);
    }
    return largest;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (orientation == Axis.vertical) {
      return _desiredMainExtent(width, minimum: false);
    }
    var largest = 0.0;
    var child = firstChild;
    final childWidth = _intrinsicChildMainExtent(width);
    while (child != null) {
      largest = math.max(largest, child.getMaxIntrinsicHeight(childWidth));
      child = childAfter(child);
    }
    return largest;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
