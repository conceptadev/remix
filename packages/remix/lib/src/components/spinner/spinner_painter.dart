part of 'spinner.dart';

/// Paints the eight independently fading leaves used by Radix Themes Spinner.
class RemixLeafSpinnerPainter extends CustomPainter {
  RemixLeafSpinnerPainter({
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
  bool shouldRepaint(RemixLeafSpinnerPainter oldDelegate) =>
      animation != oldDelegate.animation ||
      color != oldDelegate.color ||
      opacity != oldDelegate.opacity ||
      leafRadius != oldDelegate.leafRadius;
}

/// Paints the established rotating circular indicator and optional track.
class RemixSpinnerPainter extends CustomPainter {
  RemixSpinnerPainter({
    required this.animation,
    required this.strokeWidth,
    required this.indicatorColor,
    this.trackColor,
    this.trackStrokeWidth,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final double strokeWidth;
  final Color indicatorColor;
  final Color? trackColor;
  final double? trackStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final indicatorThickness = strokeWidth * 2;
    final trackThickness = trackColor == null
        ? 0.0
        : 2 * (trackStrokeWidth ?? strokeWidth);
    final radius =
        min(size.width, size.height) / 2 -
        max(indicatorThickness, trackThickness);

    if (trackColor case final color?) {
      canvas.drawCircle(
        .zero,
        radius,
        Paint()
          ..style = .stroke
          ..strokeWidth = 2 * (trackStrokeWidth ?? strokeWidth)
          ..color = color,
      );
    }
    canvas.drawArc(
      Rect.fromCircle(center: .zero, radius: radius),
      pi / 3 + animation.value * 2 * pi,
      2 * pi / 3,
      false,
      Paint()
        ..style = .stroke
        ..strokeWidth = indicatorThickness
        ..color = indicatorColor,
    );
  }

  @override
  bool shouldRepaint(RemixSpinnerPainter oldDelegate) =>
      animation != oldDelegate.animation ||
      strokeWidth != oldDelegate.strokeWidth ||
      indicatorColor != oldDelegate.indicatorColor ||
      trackColor != oldDelegate.trackColor ||
      trackStrokeWidth != oldDelegate.trackStrokeWidth;
}
