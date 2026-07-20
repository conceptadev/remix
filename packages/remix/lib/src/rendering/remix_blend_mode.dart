import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Composites a complete subtree with [blendMode] against its backdrop.
///
/// This is the Flutter equivalent of CSS `mix-blend-mode`; layout, hit testing,
/// and semantics are unchanged.
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
    context.canvas.saveLayer(null, Paint()..blendMode = _blendMode);
    context.paintChild(child, offset);
    context.canvas.restore();
  }
}
