part of 'remix_box_effects.dart';

/// Routes a resolved Mix [Box] through the simplest compatible renderer.
///
/// Ordinary boxes stay on Mix's standard renderer. Advanced effects use the
/// dedicated [_RemixBoxEffectsRenderer], while CSS-style negative margins are
/// handled by the independent outer-layout adapter.
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
        if (_canUseStandardMixRendering(effects: effects, margin: margin)) {
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
          inner = _RemixBoxEffectsRenderer(
            spec: innerSpec,
            effects: effects,
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
        if (_canUseStandardMixRendering(
          effects: effects,
          margin: box?.margin,
        )) {
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

bool _canUseStandardMixRendering({
  required RemixBoxEffectsSpec effects,
  EdgeInsetsGeometry? margin,
}) => effects.isEmpty && (margin == null || margin.isNonNegative);

/// Validates at the adapter boundary so every rendering path rejects the same
/// unsupported values before choosing an implementation.
void _validateEffects(RemixBoxEffectsSpec effects) {
  if (!effects.backdropBlur.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.backdropBlur must be finite. '
      'Received ${effects.backdropBlur}.',
    );
  }
  if (effects.backdropBlur < 0) {
    throw FlutterError(
      'RemixBoxEffectsSpec.backdropBlur must be non-negative. '
      'Received ${effects.backdropBlur}.',
    );
  }
  if (!effects.outline.width.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outline.width must be finite. '
      'Received ${effects.outline.width}.',
    );
  }
  if (effects.outline.width < 0) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outline.width must be non-negative. '
      'Received ${effects.outline.width}.',
    );
  }
  if (!effects.outlineOffset.isFinite) {
    throw FlutterError(
      'RemixBoxEffectsSpec.outlineOffset must be finite. '
      'Received ${effects.outlineOffset}.',
    );
  }
  if (effects.outline.style != BorderStyle.none &&
      effects.outline.strokeAlign != BorderSide.strokeAlignInside) {
    throw FlutterError(
      'Remix box effects outlines must use BorderSide.strokeAlignInside.',
    );
  }
  if (effects.behindContent case final layer?) {
    _validateEffectLayer(layer, 'behindContent');
  }
  if (effects.overContent case final layer?) {
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
