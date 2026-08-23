part of 'remix_box_effects.dart';

BoxSpec _withoutOuterBoxLayout(BoxSpec spec) => BoxSpec(
  alignment: spec.alignment,
  padding: spec.padding,
  constraints: spec.constraints,
  decoration: spec.decoration,
  foregroundDecoration: spec.foregroundDecoration,
  clipBehavior: spec.clipBehavior,
);

/// Applies resolved Box layout operations that sit outside decoration and
/// constraints.
///
/// Keeping this separate from advanced effects allows an effects-free Box to
/// use Mix's normal renderer even when it has a CSS-style negative margin.
Widget _applyRemixOuterBoxLayout({
  required EdgeInsetsGeometry? margin,
  required Matrix4? transform,
  required AlignmentGeometry? transformAlignment,
  required Widget child,
}) {
  Widget current = child;
  if (margin != null) {
    current = margin.isNonNegative
        ? Padding(padding: margin, child: current)
        : _RemixNegativeMargin(margin: margin, child: current);
  }
  if (transform != null) {
    current = Transform(
      transform: transform,
      alignment: transformAlignment,
      child: current,
    );
  }
  return current;
}

/// Lays out a child using CSS margin arithmetic when one or more insets are
/// negative.
///
/// Flutter's [Padding] intentionally rejects negative values, while Radix's
/// ghost controls use a negative margin to cancel their visual padding in
/// surrounding layout. This render object keeps the padded child paintable at
/// its full size while reporting the margin-adjusted footprint to its parent.
/// If the negative totals exceed the child's extent, that reported footprint
/// clamps to zero. Overflow remains hit-testable here, although an ancestor's
/// own bounds can still prevent the hit test from reaching this render object.
class _RemixNegativeMargin extends SingleChildRenderObjectWidget {
  const _RemixNegativeMargin({required this.margin, required super.child});

  final EdgeInsetsGeometry margin;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderRemixNegativeMargin(
        margin: margin,
        textDirection: Directionality.maybeOf(context),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRemixNegativeMargin renderObject,
  ) {
    renderObject
      ..margin = margin
      ..textDirection = Directionality.maybeOf(context);
  }
}

class _RenderRemixNegativeMargin extends RenderShiftedBox {
  _RenderRemixNegativeMargin({
    required EdgeInsetsGeometry margin,
    required TextDirection? textDirection,
    RenderBox? child,
  }) : _margin = margin,
       _textDirection = textDirection,
       super(child);

  EdgeInsets? _resolvedMarginCache;

  EdgeInsets get _resolvedMargin =>
      _resolvedMarginCache ??= margin.resolve(textDirection);

  EdgeInsetsGeometry get margin => _margin;
  EdgeInsetsGeometry _margin;

  set margin(EdgeInsetsGeometry value) {
    if (_margin == value) return;
    _margin = value;
    _markNeedsResolution();
  }

  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;

  set textDirection(TextDirection? value) {
    if (_textDirection == value) return;
    _textDirection = value;
    _markNeedsResolution();
  }

  void _markNeedsResolution() {
    _resolvedMarginCache = null;
    markNeedsLayout();
  }

  double _intrinsicExtent(double childExtent, double marginExtent) =>
      math.max(0, childExtent + marginExtent);

  @override
  double computeMinIntrinsicWidth(double height) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMinIntrinsicWidth(math.max(0, height - resolved.vertical)) ?? 0,
      resolved.horizontal,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMaxIntrinsicWidth(math.max(0, height - resolved.vertical)) ?? 0,
      resolved.horizontal,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMinIntrinsicHeight(math.max(0, width - resolved.horizontal)) ??
          0,
      resolved.vertical,
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final resolved = _resolvedMargin;
    return _intrinsicExtent(
      child?.getMaxIntrinsicHeight(math.max(0, width - resolved.horizontal)) ??
          0,
      resolved.vertical,
    );
  }

  Size _constrainOuterSize(BoxConstraints constraints, Size childSize) {
    final resolved = _resolvedMargin;
    return constraints.constrain(
      Size(
        math.max(0, childSize.width + resolved.horizontal),
        math.max(0, childSize.height + resolved.vertical),
      ),
    );
  }

  @override
  @protected
  Size computeDryLayout(covariant BoxConstraints constraints) {
    final resolved = _resolvedMargin;
    final currentChild = child;
    if (currentChild == null) {
      return constraints.constrain(
        Size(math.max(0, resolved.horizontal), math.max(0, resolved.vertical)),
      );
    }
    return _constrainOuterSize(
      constraints,
      currentChild.getDryLayout(constraints.deflate(resolved)),
    );
  }

  @override
  double? computeDryBaseline(
    covariant BoxConstraints constraints,
    TextBaseline baseline,
  ) {
    final currentChild = child;
    if (currentChild == null) return null;
    final resolved = _resolvedMargin;
    final childBaseline = currentChild.getDryBaseline(
      constraints.deflate(resolved),
      baseline,
    );
    return childBaseline == null ? null : childBaseline + resolved.top;
  }

  @override
  void performLayout() {
    final resolved = _resolvedMargin;
    final currentChild = child;
    if (currentChild == null) {
      size = constraints.constrain(
        Size(math.max(0, resolved.horizontal), math.max(0, resolved.vertical)),
      );
      return;
    }

    currentChild.layout(constraints.deflate(resolved), parentUsesSize: true);
    (currentChild.parentData! as BoxParentData).offset = Offset(
      resolved.left,
      resolved.top,
    );
    size = _constrainOuterSize(constraints, currentChild.size);
  }

  @override
  Rect get paintBounds {
    final currentChild = child;
    if (currentChild == null) return Offset.zero & size;
    final offset = (currentChild.parentData! as BoxParentData).offset;
    return (Offset.zero & size).expandToInclude(
      currentChild.paintBounds.shift(offset),
    );
  }

  @override
  Rect get semanticBounds {
    final currentChild = child;
    if (currentChild == null) return Offset.zero & size;
    final offset = (currentChild.parentData! as BoxParentData).offset;
    return (Offset.zero & size).expandToInclude(
      currentChild.semanticBounds.shift(offset),
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (child == null || !hasSize) return false;
    if (!hitTestChildren(result, position: position)) return false;
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin))
      ..add(
        EnumProperty<TextDirection>(
          'textDirection',
          textDirection,
          defaultValue: null,
        ),
      );
  }
}
