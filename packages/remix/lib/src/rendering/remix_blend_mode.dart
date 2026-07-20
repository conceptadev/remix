import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Composites a canvas-painted subtree with [blendMode] against its backdrop.
///
/// This is the Flutter equivalent of CSS `mix-blend-mode`; layout, hit testing,
/// and semantics are unchanged. Composited descendants such as
/// [RepaintBoundary] are rejected because Flutter's retained layers cannot be
/// enclosed by a canvas `saveLayer`.
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
    final bounds = child.paintBounds.shift(offset);
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
