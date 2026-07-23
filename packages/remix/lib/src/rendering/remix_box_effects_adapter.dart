part of 'remix_box_effects.dart';

/// A Mix [Box] that inserts advanced paint at the decoration boundary.
@internal
final class RemixBoxWithEffects extends StatelessWidget {
  const RemixBoxWithEffects({
    super.key,
    required this.styleSpec,
    this.containerEffects,
    this.child,
  });

  final StyleSpec<BoxSpec> styleSpec;
  final RemixBoxEffectsSpec? containerEffects;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final effects = containerEffects ?? const RemixBoxEffectsSpec();
    _validateEffects(effects);
    return StyleSpecBuilder<BoxSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) {
        if (effects.isEmpty &&
            (spec.margin == null || spec.margin!.isNonNegative)) {
          return Box(
            styleSpec: StyleSpec(spec: spec),
            child: child,
          );
        }
        _validateBoxDecoration(spec.decoration, effects: effects, flex: false);
        return _RemixDecoratedBox(
          spec: spec,
          containerEffects: effects,
          child: child,
        );
      },
    );
  }
}

/// A Mix [FlexBox] that inserts advanced paint at the nested Box boundary.
@internal
final class RemixFlexBoxWithEffects extends StatelessWidget {
  const RemixFlexBoxWithEffects({
    super.key,
    required this.styleSpec,
    this.direction,
    this.containerEffects,
    this.children = const [],
  });

  final StyleSpec<FlexBoxSpec> styleSpec;
  final Axis? direction;
  final RemixBoxEffectsSpec? containerEffects;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final effects = containerEffects ?? const RemixBoxEffectsSpec();
    _validateEffects(effects);
    return StyleSpecBuilder<FlexBoxSpec>(
      styleSpec: styleSpec,
      builder: (context, spec) {
        final box = spec.box?.spec;
        final margin = box?.margin;
        if (effects.isEmpty && (margin == null || margin.isNonNegative)) {
          final resolved = StyleSpec(spec: spec);
          return switch (direction) {
            Axis.horizontal => RowBox(styleSpec: resolved, children: children),
            Axis.vertical => ColumnBox(styleSpec: resolved, children: children),
            null => FlexBox(styleSpec: resolved, children: children),
          };
        }

        _validateBoxDecoration(box?.decoration, effects: effects, flex: true);
        final flex = spec.flex?.spec;
        assert(
          direction == null ||
              flex?.direction == null ||
              direction == flex!.direction,
          'The forced and styled flex directions must agree.',
        );
        final content = Flex(
          direction: flex?.direction ?? direction ?? Axis.horizontal,
          mainAxisAlignment: flex?.mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: flex?.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment:
              flex?.crossAxisAlignment ?? CrossAxisAlignment.center,
          textDirection: flex?.textDirection,
          verticalDirection: flex?.verticalDirection ?? VerticalDirection.down,
          textBaseline: flex?.textBaseline,
          clipBehavior: flex?.clipBehavior ?? Clip.none,
          spacing: flex?.spacing ?? 0,
          children: children,
        );
        return RemixBoxWithEffects(
          styleSpec: spec.box ?? const StyleSpec(spec: BoxSpec()),
          containerEffects: effects,
          child: content,
        );
      },
    );
  }
}

void _validateEffects(RemixBoxEffectsSpec containerEffects) {
  if (!containerEffects.backdropBlur.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.backdropBlur must be finite. '
      'Received ${containerEffects.backdropBlur}.',
    );
  }
  if (containerEffects.backdropBlur < 0) {
    throw FlutterError(
      'RemixBoxEffectsSpec.backdropBlur must be non-negative. '
      'Received ${containerEffects.backdropBlur}.',
    );
  }
  if (!containerEffects.outline.width.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outline.width must be finite. '
      'Received ${containerEffects.outline.width}.',
    );
  }
  if (containerEffects.outline.width < 0) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outline.width must be non-negative. '
      'Received ${containerEffects.outline.width}.',
    );
  }
  if (!containerEffects.outlineOffset.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outlineOffset must be finite. '
      'Received ${containerEffects.outlineOffset}.',
    );
  }
  if (containerEffects.outline.style != BorderStyle.none &&
      containerEffects.outline.strokeAlign != BorderSide.strokeAlignInside) {
    throw FlutterError(
      'Remix box effects outlines must use BorderSide.strokeAlignInside.',
    );
  }
  if (containerEffects.behindContent case final layer?) {
    _validateEffectLayer(layer, 'behindContent');
  }
  if (containerEffects.overContent case final layer?) {
    _validateEffectLayer(layer, 'overContent');
  }
}

void _validateEffectLayer(RemixBoxEffectLayerSpec layer, String name) {
  if (layer.gradientInsets.isNotEmpty &&
      layer.gradientInsets.length != layer.gradients.length) {
    throw FlutterError(
      'RemixBoxEffectsSpec.$name.gradientInsets must be empty or match the '
      'gradients length.',
    );
  }
  for (final inset in layer.gradientInsets) {
    if (!inset.isFinite || inset < 0) {
      throw FlutterError(
        'RemixBoxEffectsSpec.$name.gradientInsets must contain finite '
        'non-negative values. Received ${layer.gradientInsets}.',
      );
    }
  }
  for (var index = 0; index < layer.shadows.length; index++) {
    final shadow = layer.shadows[index];
    final path = 'RemixBoxEffectsSpec.$name.shadows[$index]';
    if (!shadow.offset.dx.isFinite || !shadow.offset.dy.isFinite) {
      throw FlutterError(
        '$path.offset must contain finite values. Received ${shadow.offset}.',
      );
    }
    if (!shadow.blurRadius.isFinite || shadow.blurRadius < 0) {
      throw FlutterError(
        '$path.blurRadius must be finite and non-negative. '
        'Received ${shadow.blurRadius}.',
      );
    }
    if (!shadow.spreadRadius.isFinite) {
      throw FlutterError(
        '$path.spreadRadius must be finite. '
        'Received ${shadow.spreadRadius}.',
      );
    }
    if (!shadow.shapeInset.isFinite || shadow.shapeInset < 0) {
      throw FlutterError(
        '$path.shapeInset must be finite and non-negative. '
        'Received ${shadow.shapeInset}.',
      );
    }
  }
}

void _validateBoxDecoration(
  Decoration? decoration, {
  required RemixBoxEffectsSpec effects,
  required bool flex,
}) {
  final unsupported =
      (decoration != null && decoration is! BoxDecoration) ||
      decoration is BoxDecoration && decoration.shape == BoxShape.circle;
  if (!unsupported) return;

  if (effects.isEmpty) {
    throw FlutterError(
      'Negative Remix ${flex ? 'FlexBox' : 'Box'} margins require a '
      'rectangular BoxDecoration.',
    );
  }
  throw FlutterError(
    'Remix box effects require a rectangular BoxDecoration. '
    'ShapeDecoration and BoxShape.circle are not supported.',
  );
}

/// Internal Box equivalent that inserts box effect layers at the decoration
/// boundary, inside constraints and margin.
class _RemixDecoratedBox extends StatelessWidget {
  const _RemixDecoratedBox({
    required this.spec,
    required this.containerEffects,
    this.child,
  });

  final BoxSpec spec;
  final RemixBoxEffectsSpec containerEffects;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Widget? current = child;
    if (child == null) {
      current = spec.constraints == null || !spec.constraints!.isTight
          ? LimitedBox(
              maxWidth: 0,
              maxHeight: 0,
              child: ConstrainedBox(constraints: const BoxConstraints.expand()),
            )
          : const SizedBox.shrink();
    } else if (spec.alignment != null) {
      current = Align(alignment: spec.alignment!, child: current);
    }

    final decorationPadding = spec.decoration?.padding;
    final padding = switch ((spec.padding, decorationPadding)) {
      (null, final value) => value,
      (final value, null) => value,
      (final value?, final decoration?) => value.add(decoration),
    };
    if (padding != null) current = Padding(padding: padding, child: current);

    final decoration =
        spec.decoration as BoxDecoration? ?? const BoxDecoration();
    final textDirection = Directionality.maybeOf(context);
    final borderRadius = (decoration.borderRadius ?? BorderRadius.zero).resolve(
      textDirection,
    );
    final behindContent =
        containerEffects.behindContent ?? const RemixBoxEffectLayerSpec();

    // Box fill -> advanced behindContent -> border -> child.
    if (decoration.border case final border?) {
      current = CustomPaint(
        painter: _RemixBoxBorderPainter(
          border: border,
          borderRadius: borderRadius,
          textDirection: textDirection,
        ),
        child: current,
      );
    }
    if (!behindContent.isEmpty) {
      current = CustomPaint(
        painter: _RemixBoxEffectLayerPainter(
          spec: behindContent,
          borderRadius: borderRadius,
          textDirection: textDirection,
          phase: _BoxEffectPaintPhase.inner,
        ),
        child: current,
      );
    }
    current = DecoratedBox(
      decoration: _backgroundDecoration(decoration),
      child: current,
    );

    if (containerEffects.backdropBlur > 0) {
      current = ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: containerEffects.backdropBlur,
            sigmaY: containerEffects.backdropBlur,
          ),
          child: current,
        ),
      );
    }

    // Clip decorated content without clipping box effect shadows or outlines.
    if (spec.clipBehavior case final clip? when clip != Clip.none) {
      current = ClipPath(
        clipper: _RemixDecorationClipper(
          textDirection: textDirection,
          decoration: decoration,
        ),
        clipBehavior: clip,
        child: current,
      );
    }

    if (_decorationShadow(decoration) case final shadow?) {
      current = DecoratedBox(decoration: shadow, child: current);
    }
    if (!behindContent.isEmpty) {
      current = CustomPaint(
        painter: _RemixBoxEffectLayerPainter(
          spec: behindContent,
          borderRadius: borderRadius,
          textDirection: textDirection,
          phase: _BoxEffectPaintPhase.outer,
        ),
        child: current,
      );
    }
    if (spec.foregroundDecoration case final overContent?) {
      current = DecoratedBox(
        decoration: overContent,
        position: DecorationPosition.foreground,
        child: current,
      );
    }
    final hasForeground =
        containerEffects.overContent != null &&
        !containerEffects.overContent!.isEmpty;
    final hasOutline =
        containerEffects.outline.style != BorderStyle.none &&
        containerEffects.outline.width > 0;
    if (hasForeground || hasOutline) {
      current = CustomPaint(
        foregroundPainter: _RemixBoxEffectsForegroundPainter(
          containerEffects: containerEffects,
          borderRadius: borderRadius,
          textDirection: textDirection,
        ),
        child: current,
      );
    }
    if (spec.constraints case final constraints?) {
      current = ConstrainedBox(constraints: constraints, child: current);
    }
    if (spec.margin case final margin?) {
      current = margin.isNonNegative
          ? Padding(padding: margin, child: current)
          : _RemixNegativeMargin(margin: margin, child: current);
    }
    if (spec.transform case final transform?) {
      current = Transform(
        transform: transform,
        alignment: spec.transformAlignment,
        child: current,
      );
    }
    return current;
  }
}

/// Lays out a child using CSS margin arithmetic when one or more insets are
/// negative.
///
/// Flutter's [Padding] intentionally rejects negative values, while Radix's
/// ghost controls use a negative margin to cancel their visual padding in
/// surrounding layout. This render object keeps the padded child paintable at
/// its full size while reporting the margin-adjusted footprint to its parent.
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
  Rect get semanticBounds => paintBounds;

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
