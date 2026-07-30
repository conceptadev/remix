import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Supplies the local paint bounds of a [CustomPainter] that paints beyond its
/// render box.
///
/// Flutter does not expose painter overflow through [RenderObject.paintBounds],
/// so canvas effects that need an exact subtree layer can opt into this narrow
/// internal contract.
@internal
abstract interface class RemixCustomPainterPaintBounds {
  Rect paintBoundsForSize(Size size);
}

/// Composites a canvas-painted subtree with [blendMode] against its backdrop.
///
/// This is the Flutter equivalent of CSS `mix-blend-mode`; layout, hit testing,
/// and semantics are unchanged. Composited descendants such as
/// [RepaintBoundary] are rejected because Flutter's retained layers cannot be
/// enclosed by a canvas `saveLayer`.
// TODO(https://github.com/conceptadev/mix/issues/994): Remove this local
// implementation once Mix provides an equivalent subtree blend-mode modifier.
class RemixBlendMode extends SingleChildRenderObjectWidget {
  const RemixBlendMode({
    super.key,
    required this.blendMode,
    required super.child,
  });

  final BlendMode blendMode;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderRemixBlendMode(blendMode);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRemixBlendMode renderObject,
  ) {
    renderObject.blendMode = blendMode;
  }
}

class _RenderRemixBlendMode extends RenderProxyBox {
  _RenderRemixBlendMode(this._blendMode);

  BlendMode _blendMode;

  BlendMode get blendMode => _blendMode;

  set blendMode(BlendMode value) {
    if (_blendMode == value) return;
    _blendMode = value;
    markNeedsPaint();
  }

  @override
  Rect get paintBounds {
    final child = this.child;
    return child == null ? super.paintBounds : _subtreePaintBounds(child);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;
    if (_blendMode == BlendMode.srcOver) {
      context.paintChild(child, offset);
      return;
    }
    if (child.isRepaintBoundary || child.needsCompositing) {
      throw FlutterError(
        'RemixBlendMode does not support composited descendants. '
        'Remove the RepaintBoundary or compositing effect below it, or use '
        'BlendMode.srcOver.',
      );
    }
    final bounds = paintBounds.shift(offset);
    context.canvas
      ..save()
      ..clipRect(bounds)
      ..saveLayer(bounds, Paint()..blendMode = _blendMode);
    context.paintChild(child, offset);
    context.canvas
      ..restore()
      ..restore();
  }
}

// Computes conservative descendant bounds while preserving explicit clips.
Rect _subtreePaintBounds(RenderObject root) {
  var bounds = _localPaintBounds(root);

  void includeDescendants(
    RenderObject parent,
    Matrix4 parentTransform,
    Rect? ancestorClip,
  ) {
    parent.visitChildren((child) {
      if (!parent.paintsChild(child)) return;

      var childClip = ancestorClip;
      if (parent.describeApproximatePaintClip(child) case final clip?) {
        final transformedClip = MatrixUtils.transformRect(
          parentTransform,
          clip,
        );
        if (_isFinite(transformedClip)) {
          childClip = childClip == null
              ? transformedClip
              : childClip.intersect(transformedClip);
          if (childClip.isEmpty) return;
        }
      }

      final childTransform = Matrix4.copy(parentTransform);
      parent.applyPaintTransform(child, childTransform);
      var childBounds = MatrixUtils.transformRect(
        childTransform,
        _localPaintBounds(child),
      );
      if (childClip != null) childBounds = childBounds.intersect(childClip);
      if (_isFinite(childBounds) && !childBounds.isEmpty) {
        bounds = bounds.expandToInclude(childBounds);
      }
      includeDescendants(child, childTransform, childClip);
    });
  }

  includeDescendants(root, Matrix4.identity(), null);
  return bounds;
}

Rect _localPaintBounds(RenderObject object) {
  var bounds = object.paintBounds;
  if (object case final RenderCustomPaint customPaint) {
    bounds = _includePainterBounds(
      bounds,
      customPaint.painter,
      customPaint.size,
    );
    bounds = _includePainterBounds(
      bounds,
      customPaint.foregroundPainter,
      customPaint.size,
    );
  }
  return bounds;
}

Rect _includePainterBounds(Rect bounds, CustomPainter? painter, Size size) {
  if (painter case final RemixCustomPainterPaintBounds boundsProvider) {
    final painterBounds = boundsProvider.paintBoundsForSize(size);
    if (!_isFinite(painterBounds) || painterBounds.isEmpty) return bounds;
    return bounds.expandToInclude(painterBounds);
  }
  return bounds;
}

bool _isFinite(Rect rect) =>
    rect.left.isFinite &&
    rect.top.isFinite &&
    rect.right.isFinite &&
    rect.bottom.isFinite;
