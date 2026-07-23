part of 'remix_box_effects.dart';

Decoration _backgroundDecoration(Decoration decoration) {
  if (decoration is BoxDecoration) {
    return BoxDecoration(
      color: decoration.color,
      image: decoration.image,
      borderRadius: decoration.borderRadius,
      gradient: decoration.gradient,
      backgroundBlendMode: decoration.backgroundBlendMode,
      shape: decoration.shape,
    );
  }
  return decoration;
}

Decoration? _decorationShadow(Decoration decoration) {
  if (decoration case BoxDecoration(
    :final boxShadow?,
  ) when boxShadow.isNotEmpty) {
    return BoxDecoration(
      borderRadius: decoration.borderRadius,
      boxShadow: boxShadow,
      shape: decoration.shape,
    );
  }
  return null;
}

class _RemixDecorationClipper extends CustomClipper<Path> {
  const _RemixDecorationClipper({
    required this.textDirection,
    required this.decoration,
  });

  final TextDirection? textDirection;
  final Decoration decoration;

  @override
  Path getClip(Size size) => decoration.getClipPath(
    Offset.zero & size,
    textDirection ?? TextDirection.ltr,
  );

  @override
  bool shouldReclip(_RemixDecorationClipper oldClipper) =>
      decoration != oldClipper.decoration ||
      textDirection != oldClipper.textDirection;
}

enum _BoxEffectPaintPhase { all, outer, inner, outline }

class _RemixBoxBorderPainter extends CustomPainter {
  const _RemixBoxBorderPainter({
    required this.border,
    required this.borderRadius,
    required this.textDirection,
  });

  final BoxBorder border;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(
      canvas,
      Offset.zero & size,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      textDirection: textDirection,
    );
  }

  @override
  bool shouldRepaint(_RemixBoxBorderPainter oldDelegate) =>
      border != oldDelegate.border ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection;
}

class _RemixBoxEffectsForegroundPainter extends CustomPainter
    implements RemixCustomPainterPaintBounds {
  const _RemixBoxEffectsForegroundPainter({
    required this.containerEffects,
    required this.borderRadius,
    required this.textDirection,
  });

  final RemixBoxEffectsSpec containerEffects;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (containerEffects.overContent case final overContent?) {
      _RemixBoxEffectLayerPainter(
        spec: overContent,
        borderRadius: borderRadius,
        textDirection: textDirection,
        phase: _BoxEffectPaintPhase.all,
      ).paint(canvas, size);
    }

    _RemixBoxEffectLayerPainter(
      spec: const RemixBoxEffectLayerSpec(),
      borderRadius: borderRadius,
      textDirection: textDirection,
      phase: _BoxEffectPaintPhase.outline,
      outline: containerEffects.outline,
      outlineOffset: containerEffects.outlineOffset,
    ).paint(canvas, size);
  }

  @override
  bool hitTest(Offset position) => false;

  @override
  Rect paintBoundsForSize(Size size) {
    var bounds = _boxEffectPaintBounds(
      const RemixBoxEffectLayerSpec(),
      size,
      borderRadius: borderRadius,
      includeOuterShadows: false,
      includeOutline: true,
      outline: containerEffects.outline,
      outlineOffset: containerEffects.outlineOffset,
    );
    if (containerEffects.overContent case final overContent?) {
      bounds = bounds.expandToInclude(
        _boxEffectPaintBounds(
          overContent,
          size,
          borderRadius: borderRadius,
          includeOuterShadows: true,
          includeOutline: false,
        ),
      );
    }
    return bounds;
  }

  @override
  bool shouldRepaint(_RemixBoxEffectsForegroundPainter oldDelegate) =>
      containerEffects != oldDelegate.containerEffects ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection;
}

class _RemixBoxEffectLayerPainter extends CustomPainter
    implements RemixCustomPainterPaintBounds {
  const _RemixBoxEffectLayerPainter({
    required this.spec,
    required this.borderRadius,
    required this.textDirection,
    required this.phase,
    this.outline = BorderSide.none,
    this.outlineOffset = 0,
  });

  final RemixBoxEffectLayerSpec spec;
  final BorderRadius borderRadius;
  final TextDirection? textDirection;
  final _BoxEffectPaintPhase phase;
  final BorderSide outline;
  final double outlineOffset;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rect = Offset.zero & size;
    final shape = borderRadius.toRRect(rect);

    if (phase == _BoxEffectPaintPhase.outline) {
      _paintOutline(canvas, shape);
      return;
    }
    if (phase != _BoxEffectPaintPhase.inner) {
      _paintOuterShadows(canvas, shape);
    }
    if (phase != _BoxEffectPaintPhase.outer) {
      _paintInnerLayers(canvas, rect, shape);
    }
    if (phase == _BoxEffectPaintPhase.all) {
      _paintOutline(canvas, shape);
    }
  }

  void _paintOuterShadows(Canvas canvas, RRect shape) {
    for (final shadow in spec.shadows.reversed) {
      if (shadow.kind != RemixBoxShadowKind.outer || shadow.color.a == 0) {
        continue;
      }
      final targetShape = shape.deflate(shadow.shapeInset);
      final shadowShape = targetShape
          .inflate(shadow.spreadRadius)
          .shift(shadow.offset);
      if (shadowShape.outerRect.isEmpty) continue;
      final paint = BoxShadow(
        color: shadow.color,
        blurRadius: shadow.blurRadius,
      ).toPaint();

      final blurExtent = ui.Shadow.convertRadiusToSigma(shadow.blurRadius) * 3;
      final shadowBounds = shadowShape.outerRect
          .inflate(blurExtent)
          .expandToInclude(targetShape.outerRect);
      // Isolate the knockout so it cannot erase the filtered backdrop.
      canvas.saveLayer(shadowBounds, Paint());
      canvas.drawRRect(shadowShape, paint);
      canvas.drawRRect(targetShape, Paint()..blendMode = BlendMode.dstOut);
      canvas.restore();
    }
  }

  void _paintOutline(Canvas canvas, RRect shape) {
    if (outline.style == BorderStyle.none || outline.width <= 0) return;
    final inner = shape.inflate(outlineOffset);
    final outer = shape.inflate(outlineOffset + outline.width);
    if (outer.outerRect.isEmpty) return;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(outer);
    if (!inner.outerRect.isEmpty) path.addRRect(inner);
    canvas.drawPath(path, Paint()..color = outline.color);
  }

  void _paintInnerLayers(Canvas canvas, Rect rect, RRect shape) {
    canvas.save();
    canvas.clipRRect(shape, doAntiAlias: true);

    for (var index = spec.gradients.length - 1; index >= 0; index--) {
      final gradient = spec.gradients[index];
      final inset = spec.gradientInsets.isEmpty
          ? 0.0
          : spec.gradientInsets[index];
      final gradientShape = inset == 0 ? shape : shape.deflate(inset);
      if (gradientShape.outerRect.isEmpty) continue;
      final gradientRect = gradientShape.outerRect;
      canvas.save();
      canvas.clipRRect(gradientShape, doAntiAlias: true);
      canvas.drawRect(
        gradientRect,
        Paint()
          ..shader = gradient.createShader(
            gradientRect,
            textDirection: textDirection,
          ),
      );
      canvas.restore();
    }
    canvas.restore();

    for (final shadow in spec.shadows.reversed) {
      if (shadow.kind == RemixBoxShadowKind.inset) {
        _paintInsetShadow(canvas, shape, shadow);
      }
    }
  }

  void _paintInsetShadow(Canvas canvas, RRect shape, RemixBoxShadow shadow) {
    final targetShape = shape.deflate(shadow.shapeInset);
    if (targetShape.outerRect.isEmpty) return;
    final hole = targetShape.deflate(shadow.spreadRadius).shift(shadow.offset);
    if (hole.outerRect.isEmpty) {
      canvas.drawRRect(targetShape, Paint()..color = shadow.color);
      return;
    }

    final blurExtent = shadow.blurRadius * 2 + 1;
    final layerBounds = targetShape.outerRect
        .expandToInclude(hole.outerRect)
        .inflate(blurExtent);
    canvas.saveLayer(layerBounds, Paint());
    if (shadow.blurRadius > 0) {
      final sigma = ui.Shadow.convertRadiusToSigma(shadow.blurRadius);
      canvas.saveLayer(
        layerBounds,
        Paint()
          ..imageFilter = ui.ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
            tileMode: TileMode.decal,
          ),
      );
    }
    final shadowPath = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(layerBounds)
      ..addRRect(hole);
    canvas.drawPath(shadowPath, Paint()..color = shadow.color);
    if (shadow.blurRadius > 0) canvas.restore();
    final outsideShape = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(layerBounds)
      ..addRRect(targetShape);
    canvas.drawPath(
      outsideShape,
      Paint()
        ..color = const Color(0xFFFFFFFF)
        ..blendMode = BlendMode.dstOut,
    );
    canvas.restore();
  }

  @override
  bool hitTest(Offset position) => false;

  @override
  Rect paintBoundsForSize(Size size) => _boxEffectPaintBounds(
    spec,
    size,
    borderRadius: borderRadius,
    includeOuterShadows:
        phase != _BoxEffectPaintPhase.inner &&
        phase != _BoxEffectPaintPhase.outline,
    includeOutline:
        phase == _BoxEffectPaintPhase.all ||
        phase == _BoxEffectPaintPhase.outline,
    outline: outline,
    outlineOffset: outlineOffset,
  );

  @override
  bool shouldRepaint(_RemixBoxEffectLayerPainter oldDelegate) =>
      spec != oldDelegate.spec ||
      borderRadius != oldDelegate.borderRadius ||
      textDirection != oldDelegate.textDirection ||
      phase != oldDelegate.phase ||
      outline != oldDelegate.outline ||
      outlineOffset != oldDelegate.outlineOffset;
}

Rect _boxEffectPaintBounds(
  RemixBoxEffectLayerSpec spec,
  Size size, {
  required BorderRadius borderRadius,
  required bool includeOuterShadows,
  required bool includeOutline,
  BorderSide outline = BorderSide.none,
  double outlineOffset = 0,
}) {
  var bounds = Offset.zero & size;
  final shape = borderRadius.toRRect(bounds);

  if (includeOuterShadows) {
    for (final shadow in spec.shadows) {
      if (shadow.kind != RemixBoxShadowKind.outer || shadow.color.a == 0) {
        continue;
      }
      final shadowShape = shape
          .deflate(shadow.shapeInset)
          .inflate(shadow.spreadRadius)
          .shift(shadow.offset);
      if (shadowShape.outerRect.isEmpty) continue;
      final blurExtent = ui.Shadow.convertRadiusToSigma(shadow.blurRadius) * 3;
      bounds = bounds.expandToInclude(
        shadowShape.outerRect.inflate(blurExtent),
      );
    }
  }

  if (includeOutline &&
      outline.style != BorderStyle.none &&
      outline.color.a > 0 &&
      outline.width > 0) {
    final outlineShape = shape.inflate(outlineOffset + outline.width);
    if (!outlineShape.outerRect.isEmpty) {
      bounds = bounds.expandToInclude(outlineShape.outerRect);
    }
  }

  return bounds;
}
