part of 'remix_box_effects.dart';

/// Routes a resolved Mix [Box] surface through the simplest valid renderer.
///
/// Ordinary surfaces remain real Mix Boxes. Only non-empty advanced effects
/// use [_RemixAdvancedSurface], while CSS-style negative margins are handled by
/// the independent outer-layout adapter.
@internal
final class RemixBoxAdapter extends StatelessWidget {
  const RemixBoxAdapter({
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
        final margin = spec.margin;
        if (effects.isEmpty && (margin == null || margin.isNonNegative)) {
          return Box(
            styleSpec: StyleSpec(spec: spec),
            child: child,
          );
        }

        final innerSpec = _withoutOuterBoxLayout(spec);
        final Widget inner;
        if (effects.isEmpty) {
          inner = Box(
            styleSpec: StyleSpec(spec: innerSpec),
            child: child,
          );
        } else {
          _validateBoxDecoration(spec.decoration);
          inner = _RemixAdvancedSurface(
            spec: innerSpec,
            containerEffects: effects,
            child: child,
          );
        }
        return _applyRemixOuterBoxLayout(
          margin: margin,
          transform: spec.transform,
          transformAlignment: spec.transformAlignment,
          child: inner,
        );
      },
    );
  }
}

/// Flex counterpart of [RemixBoxAdapter].
@internal
final class RemixFlexBoxAdapter extends StatelessWidget {
  const RemixFlexBoxAdapter({
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
        return RemixBoxAdapter(
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

void _validateBoxDecoration(Decoration? decoration) {
  final unsupported =
      (decoration != null && decoration is! BoxDecoration) ||
      decoration is BoxDecoration && decoration.shape == BoxShape.circle;
  if (!unsupported) return;

  throw FlutterError(
    'Remix box effects require a rectangular BoxDecoration. '
    'ShapeDecoration and BoxShape.circle are not supported.',
  );
}

/// Internal Box equivalent that inserts box effect layers at the decoration
/// boundary, inside constraints and outside CSS margin and transforms.
class _RemixAdvancedSurface extends StatelessWidget {
  const _RemixAdvancedSurface({
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
    return current;
  }
}
