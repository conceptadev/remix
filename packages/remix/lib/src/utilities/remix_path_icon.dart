import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

/// Exact nine-unit paths shared by Radix-shaped component recipes.
enum RemixPathGlyph {
  chevronDown(9),
  thickCheck(9),
  thickChevronRight(9),
  plus(15),
  minus(15),
  dash(15),
  check(15),
  caretSort(15),
  caretUp(15),
  caretDown(15),
  chevronLeft(15),
  chevronRight(15);

  const RemixPathGlyph(this.viewBoxSize);

  final double viewBoxSize;
}

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
      final applyTextScaling =
          spec.applyTextScaling ?? theme.applyTextScaling ?? false;
      if (applyTextScaling) {
        size = MediaQuery.textScalerOf(context).scale(size);
      }
      final opacity = (spec.opacity ?? theme.opacity ?? 1).clamp(0.0, 1.0);
      final baseColor = spec.color ?? theme.color ?? const Color(0xFF000000);
      final color = baseColor.withValues(alpha: baseColor.a * opacity);
      final icon = SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RemixPathIconPainter(
            glyph: glyph,
            color: color,
            shadows: spec.shadows ?? theme.shadows ?? const [],
            blendMode: spec.blendMode ?? BlendMode.srcOver,
            flipHorizontally:
                matchTextDirection &&
                (spec.textDirection ?? Directionality.of(context)) == .rtl,
          ),
        ),
      );
      return Semantics(
        label: spec.semanticsLabel,
        child: ExcludeSemantics(child: icon),
      );
    },
  );
}

class _RemixPathIconPainter extends CustomPainter {
  const _RemixPathIconPainter({
    required this.glyph,
    required this.color,
    required this.shadows,
    required this.blendMode,
    required this.flipHorizontally,
  });

  final RemixPathGlyph glyph;
  final Color color;
  final List<Shadow> shadows;
  final BlendMode blendMode;
  final bool flipHorizontally;

  @override
  void paint(Canvas canvas, Size size) {
    final viewBoxSize = glyph.viewBoxSize;
    final scale = size.shortestSide / viewBoxSize;
    canvas.save();
    canvas.scale(scale);
    if (flipHorizontally) {
      canvas.translate(viewBoxSize, 0);
      canvas.scale(-1, 1);
    }
    final path = switch (glyph) {
      .chevronDown => _chevronDownPath(),
      .thickCheck => _thickCheckPath(),
      .thickChevronRight => _thickChevronRightPath(),
      .plus => _plusPath(),
      .minus => _minusPath(),
      .dash => _dashPath(),
      .check => _checkPath(),
      .caretSort => _caretSortPath(),
      .caretUp => _caretUpPath(),
      .caretDown => _caretDownPath(),
      .chevronLeft => _chevronLeftPath(),
      .chevronRight => _chevronRightPath(),
    };
    for (final shadow in shadows) {
      canvas.drawPath(path.shift(shadow.offset / scale), shadow.toPaint());
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..blendMode = blendMode,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_RemixPathIconPainter oldDelegate) =>
      glyph != oldDelegate.glyph ||
      color != oldDelegate.color ||
      blendMode != oldDelegate.blendMode ||
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

Path _thickChevronRightPath() => Path()
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

Path _plusPath() => Path()
  ..moveTo(8, 2.75)
  ..cubicTo(8, 2.47386, 7.77614, 2.25, 7.5, 2.25)
  ..cubicTo(7.22386, 2.25, 7, 2.47386, 7, 2.75)
  ..lineTo(7, 7)
  ..lineTo(2.75, 7)
  ..cubicTo(2.47386, 7, 2.25, 7.22386, 2.25, 7.5)
  ..cubicTo(2.25, 7.77614, 2.47386, 8, 2.75, 8)
  ..lineTo(7, 8)
  ..lineTo(7, 12.25)
  ..cubicTo(7, 12.5261, 7.22386, 12.75, 7.5, 12.75)
  ..cubicTo(7.77614, 12.75, 8, 12.5261, 8, 12.25)
  ..lineTo(8, 8)
  ..lineTo(12.25, 8)
  ..cubicTo(12.5261, 8, 12.75, 7.77614, 12.75, 7.5)
  ..cubicTo(12.75, 7.22386, 12.5261, 7, 12.25, 7)
  ..lineTo(8, 7)
  ..lineTo(8, 2.75)
  ..close();

Path _minusPath() => Path()
  ..moveTo(2.25, 7.5)
  ..cubicTo(2.25, 7.22386, 2.47386, 7, 2.75, 7)
  ..lineTo(12.25, 7)
  ..cubicTo(12.5261, 7, 12.75, 7.22386, 12.75, 7.5)
  ..cubicTo(12.75, 7.77614, 12.5261, 8, 12.25, 8)
  ..lineTo(2.75, 8)
  ..cubicTo(2.47386, 8, 2.25, 7.77614, 2.25, 7.5)
  ..close();

Path _dashPath() => Path()
  ..moveTo(5, 7.5)
  ..cubicTo(5, 7.22386, 5.22386, 7, 5.5, 7)
  ..lineTo(9.5, 7)
  ..cubicTo(9.77614, 7, 10, 7.22386, 10, 7.5)
  ..cubicTo(10, 7.77614, 9.77614, 8, 9.5, 8)
  ..lineTo(5.5, 8)
  ..cubicTo(5.22386, 8, 5, 7.77614, 5, 7.5)
  ..close();

Path _checkPath() => Path()
  ..moveTo(11.4669, 3.72684)
  ..cubicTo(11.7558, 3.91574, 11.8369, 4.30308, 11.648, 4.59198)
  ..lineTo(7.39799, 11.092)
  ..cubicTo(7.29783, 11.2452, 7.13556, 11.3467, 6.95402, 11.3699)
  ..cubicTo(6.77247, 11.3931, 6.58989, 11.3355, 6.45446, 11.2124)
  ..lineTo(3.70446, 8.71241)
  ..cubicTo(3.44905, 8.48022, 3.43023, 8.08494, 3.66242, 7.82953)
  ..cubicTo(3.89461, 7.57412, 4.28989, 7.55529, 4.5453, 7.78749)
  ..lineTo(6.75292, 9.79441)
  ..lineTo(10.6018, 3.90792)
  ..cubicTo(10.7907, 3.61902, 11.178, 3.53795, 11.4669, 3.72684)
  ..close();

Path _caretSortPath() => Path()
  ..moveTo(4.93179, 5.43179)
  ..cubicTo(4.75605, 5.60753, 4.75605, 5.89245, 4.93179, 6.06819)
  ..cubicTo(5.10753, 6.24392, 5.39245, 6.24392, 5.56819, 6.06819)
  ..lineTo(7.49999, 4.13638)
  ..lineTo(9.43179, 6.06819)
  ..cubicTo(9.60753, 6.24392, 9.89245, 6.24392, 10.0682, 6.06819)
  ..cubicTo(10.2439, 5.89245, 10.2439, 5.60753, 10.0682, 5.43179)
  ..lineTo(7.81819, 3.18179)
  ..cubicTo(7.73379, 3.0974, 7.61933, 3.04999, 7.49999, 3.04999)
  ..cubicTo(7.38064, 3.04999, 7.26618, 3.0974, 7.18179, 3.18179)
  ..lineTo(4.93179, 5.43179)
  ..close()
  ..moveTo(10.0682, 9.56819)
  ..cubicTo(10.2439, 9.39245, 10.2439, 9.10753, 10.0682, 8.93179)
  ..cubicTo(9.89245, 8.75606, 9.60753, 8.75606, 9.43179, 8.93179)
  ..lineTo(7.49999, 10.8636)
  ..lineTo(5.56819, 8.93179)
  ..cubicTo(5.39245, 8.75606, 5.10753, 8.75606, 4.93179, 8.93179)
  ..cubicTo(4.75605, 9.10753, 4.75605, 9.39245, 4.93179, 9.56819)
  ..lineTo(7.18179, 11.8182)
  ..cubicTo(7.35753, 11.9939, 7.64245, 11.9939, 7.81819, 11.8182)
  ..lineTo(10.0682, 9.56819)
  ..close();

Path _caretUpPath() => Path()
  ..moveTo(4.18179, 8.81819)
  ..cubicTo(4.00605, 8.64245, 4.00605, 8.35753, 4.18179, 8.18179)
  ..lineTo(7.18179, 5.18179)
  ..cubicTo(7.26618, 5.0974, 7.38064, 5.04999, 7.49999, 5.04999)
  ..cubicTo(7.61933, 5.04999, 7.73379, 5.0974, 7.81819, 5.18179)
  ..lineTo(10.8182, 8.18179)
  ..cubicTo(10.9939, 8.35753, 10.9939, 8.64245, 10.8182, 8.81819)
  ..cubicTo(10.6424, 8.99392, 10.3575, 8.99392, 10.1818, 8.81819)
  ..lineTo(7.49999, 6.13638)
  ..lineTo(4.81819, 8.81819)
  ..cubicTo(4.64245, 8.99392, 4.35753, 8.99392, 4.18179, 8.81819)
  ..close();

Path _caretDownPath() => Path()
  ..moveTo(4.18179, 6.18181)
  ..cubicTo(4.35753, 6.00608, 4.64245, 6.00608, 4.81819, 6.18181)
  ..lineTo(7.49999, 8.86362)
  ..lineTo(10.1818, 6.18181)
  ..cubicTo(10.3575, 6.00608, 10.6424, 6.00608, 10.8182, 6.18181)
  ..cubicTo(10.9939, 6.35755, 10.9939, 6.64247, 10.8182, 6.81821)
  ..lineTo(7.81819, 9.81821)
  ..cubicTo(7.73379, 9.9026, 7.61934, 9.95001, 7.49999, 9.95001)
  ..cubicTo(7.38064, 9.95001, 7.26618, 9.9026, 7.18179, 9.81821)
  ..lineTo(4.18179, 6.81821)
  ..cubicTo(4.00605, 6.64247, 4.00605, 6.35755, 4.18179, 6.18181)
  ..close();

Path _chevronLeftPath() => Path()
  ..moveTo(8.84182, 3.13514)
  ..cubicTo(9.04327, 3.32401, 9.05348, 3.64042, 8.86462, 3.84188)
  ..lineTo(5.43521, 7.49991)
  ..lineTo(8.86462, 11.1579)
  ..cubicTo(9.05348, 11.3594, 9.04327, 11.6758, 8.84182, 11.8647)
  ..cubicTo(8.64036, 12.0535, 8.32394, 12.0433, 8.13508, 11.8419)
  ..lineTo(4.38508, 7.84188)
  ..cubicTo(4.20477, 7.64955, 4.20477, 7.35027, 4.38508, 7.15794)
  ..lineTo(8.13508, 3.15794)
  ..cubicTo(8.32394, 2.95648, 8.64036, 2.94628, 8.84182, 3.13514)
  ..close();

Path _chevronRightPath() => Path()
  ..moveTo(6.1584, 3.13508)
  ..cubicTo(6.35985, 2.94621, 6.67627, 2.95642, 6.86514, 3.15788)
  ..lineTo(10.6151, 7.15788)
  ..cubicTo(10.7954, 7.3502, 10.7954, 7.64949, 10.6151, 7.84182)
  ..lineTo(6.86514, 11.8418)
  ..cubicTo(6.67627, 12.0433, 6.35985, 12.0535, 6.1584, 11.8646)
  ..cubicTo(5.95694, 11.6757, 5.94673, 11.3593, 6.1356, 11.1579)
  ..lineTo(9.565, 7.49985)
  ..lineTo(6.1356, 3.84182)
  ..cubicTo(5.94673, 3.64036, 5.95694, 3.32394, 6.1584, 3.13508)
  ..close();
