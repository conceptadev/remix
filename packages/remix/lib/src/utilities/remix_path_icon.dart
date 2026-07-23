import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Exact nine-unit paths shared by Radix-shaped component recipes.
enum RemixPathGlyph { chevronDown, chevronRight, thickCheck }

/// Paints a resolved icon spec with one of the pinned Radix vector paths.
class RemixPathIcon extends StatelessWidget {
  const RemixPathIcon({
    super.key,
    required this.glyph,
    required this.styleSpec,
    this.matchTextDirection = false,
  });

  final RemixPathGlyph glyph;
  final StyleSpec<IconSpec> styleSpec;
  final bool matchTextDirection;

  @override
  Widget build(BuildContext context) => StyleSpecBuilder<IconSpec>(
    styleSpec: styleSpec,
    builder: (context, spec) {
      final theme = IconTheme.of(context);
      var size = spec.size ?? theme.size ?? 9;
      if (spec.applyTextScaling == true) {
        size = MediaQuery.textScalerOf(context).scale(size);
      }
      final opacity = (spec.opacity ?? theme.opacity ?? 1).clamp(0.0, 1.0);
      final baseColor = spec.color ?? theme.color ?? const Color(0xFF000000);
      final color = baseColor.withValues(alpha: baseColor.a * opacity);
      return SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RemixPathIconPainter(
            glyph: glyph,
            color: color,
            shadows: spec.shadows ?? const [],
            flipHorizontally:
                matchTextDirection && Directionality.of(context) == .rtl,
          ),
        ),
      );
    },
  );
}

class _RemixPathIconPainter extends CustomPainter {
  const _RemixPathIconPainter({
    required this.glyph,
    required this.color,
    required this.shadows,
    required this.flipHorizontally,
  });

  final RemixPathGlyph glyph;
  final Color color;
  final List<Shadow> shadows;
  final bool flipHorizontally;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / 9;
    canvas.save();
    canvas.scale(scale);
    if (flipHorizontally) {
      canvas.translate(9, 0);
      canvas.scale(-1, 1);
    }
    final path = switch (glyph) {
      .chevronDown => _chevronDownPath(),
      .chevronRight => _chevronRightPath(),
      .thickCheck => _thickCheckPath(),
    };
    for (final shadow in shadows) {
      canvas.drawPath(path.shift(shadow.offset / scale), shadow.toPaint());
    }
    canvas.drawPath(path, Paint()..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_RemixPathIconPainter oldDelegate) =>
      glyph != oldDelegate.glyph ||
      color != oldDelegate.color ||
      flipHorizontally != oldDelegate.flipHorizontally ||
      !listEquals(shadows, oldDelegate.shadows);
}

Path _chevronDownPath() => Path()
  ..moveTo(0.135232, 3.15803)
  ..cubicTo(0.324102, 2.95657, 0.640521, 2.94637, 0.841971, 3.13523)
  ..lineTo(4.5, 6.56464)
  ..lineTo(8.158, 3.13523)
  ..cubicTo(8.3595, 2.94637, 8.6759, 2.95657, 8.8648, 3.15803)
  ..cubicTo(9.0536, 3.35949, 9.0434, 3.67591, 8.842, 3.86477)
  ..lineTo(4.84197, 7.6148)
  ..cubicTo(4.64964, 7.7951, 4.35036, 7.7951, 4.15803, 7.6148)
  ..lineTo(0.158031, 3.86477)
  ..cubicTo(-0.0434285, 3.67591, -0.0536285, 3.35949, 0.135232, 3.15803)
  ..close();

Path _chevronRightPath() => Path()
  ..moveTo(3.23826, 0.201711)
  ..cubicTo(3.54108, -0.0809141, 4.01567, -0.0645489, 4.29829, 0.238264)
  ..lineTo(7.79829, 3.98826)
  ..cubicTo(8.06724, 4.27642, 8.06724, 4.72359, 7.79829, 5.01174)
  ..lineTo(4.29829, 8.76174)
  ..cubicTo(4.01567, 9.06455, 3.54108, 9.08092, 3.23826, 8.79829)
  ..cubicTo(2.93545, 8.51567, 2.91909, 8.04108, 3.20171, 7.73826)
  ..lineTo(6.22409, 4.5)
  ..lineTo(3.20171, 1.26174)
  ..cubicTo(2.91909, 0.958928, 2.93545, 0.484337, 3.23826, 0.201711)
  ..close();

Path _thickCheckPath() => Path()
  ..moveTo(8.53547, 0.62293)
  ..cubicTo(8.88226, 0.849446, 8.97976, 1.3142, 8.75325, 1.66099)
  ..lineTo(4.5083, 8.1599)
  ..cubicTo(4.38833, 8.34356, 4.19397, 8.4655, 3.9764, 8.49358)
  ..cubicTo(3.75883, 8.52167, 3.53987, 8.45309, 3.3772, 8.30591)
  ..lineTo(0.616113, 5.80777)
  ..cubicTo(0.308959, 5.52987, 0.285246, 5.05559, 0.563148, 4.74844)
  ..cubicTo(0.84105, 4.44128, 1.31533, 4.41757, 1.62249, 4.69547)
  ..lineTo(3.73256, 6.60459)
  ..lineTo(7.49741, 0.840706)
  ..cubicTo(7.72393, 0.493916, 8.18868, 0.396414, 8.53547, 0.62293)
  ..close();
