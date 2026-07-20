part of 'spinner.dart';

/// Paints the eight independently fading leaves used by Radix Themes Spinner.
class RemixSpinnerPainter extends CustomPainter {
  RemixSpinnerPainter({
    required this.animation,
    required this.color,
    required this.opacity,
    required this.leafRadius,
  }) : super(repaint: animation);

  static const int leafCount = 8;

  /// Linear phase from zero to one over one complete fade cycle.
  final Animation<double> animation;

  /// Resolved current color inherited by every leaf.
  final Color color;

  /// Opacity applied to the complete spinner.
  final double opacity;

  /// Corner radius of each leaf.
  final Radius leafRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final extent = min(size.width, size.height);
    final leaf = Rect.fromLTWH(
      -extent * 0.125 / 2,
      -extent / 2,
      extent * 0.125,
      extent * 0.3,
    );
    final paint = Paint();
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    for (var index = 0; index < leafCount; index++) {
      // CSS delays are -8/8, -7/8, ... -1/8 of a cycle.
      final phase = (animation.value + (leafCount - index) / leafCount) % 1;
      final leafOpacity = 1 - 0.75 * phase;
      paint.color = color.withValues(alpha: color.a * opacity * leafOpacity);

      canvas.save();
      canvas.rotate(index * pi / 4);
      canvas.drawRRect(RRect.fromRectAndRadius(leaf, leafRadius), paint);
      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(RemixSpinnerPainter oldDelegate) =>
      animation != oldDelegate.animation ||
      color != oldDelegate.color ||
      opacity != oldDelegate.opacity ||
      leafRadius != oldDelegate.leafRadius;
}
