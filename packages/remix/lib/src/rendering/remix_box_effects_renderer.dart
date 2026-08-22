part of 'remix_box_effects.dart';

/// Internal Box equivalent that inserts box effect layers at the decoration
/// boundary, inside constraints and outside CSS margin and transforms.
class _RemixBoxEffectsRenderer extends StatelessWidget {
  const _RemixBoxEffectsRenderer({
    required this.spec,
    required this.effects,
    this.child,
  });

  final BoxSpec spec;
  final RemixBoxEffectsSpec effects;
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
        effects.behindContent ?? const RemixBoxEffectLayerSpec();

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

    if (effects.backdropBlur > 0) {
      current = ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: effects.backdropBlur,
            sigmaY: effects.backdropBlur,
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
        effects.overContent != null && !effects.overContent!.isEmpty;
    final hasOutline =
        effects.outline.style != BorderStyle.none && effects.outline.width > 0;
    if (hasForeground || hasOutline) {
      current = CustomPaint(
        foregroundPainter: _RemixBoxEffectsForegroundPainter(
          containerEffects: effects,
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
