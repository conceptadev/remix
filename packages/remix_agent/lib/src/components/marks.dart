import 'package:flutter/widgets.dart';

import '../style/defaults.dart';

/// How a progress mark paints.
enum AgentMarkKind {
  /// Not started. Empty ring.
  pending,

  /// Current step. Filled.
  live,

  /// Finished. Faint fill.
  done,

  /// Abandoned. Empty ring, muted.
  cancelled,
}

/// 6px status mark. The one loud signal on a quiet list.
class AgentLiveMark extends StatelessWidget {
  /// Creates a status mark.
  const AgentLiveMark({super.key, required this.kind, this.semanticLabel});

  final AgentMarkKind kind;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    final muted = agentMutedOf(context);
    final color = switch (kind) {
      AgentMarkKind.live => ink,
      AgentMarkKind.done => ink.withValues(alpha: 0.28),
      AgentMarkKind.pending || AgentMarkKind.cancelled => muted,
    };
    final filled = kind == AgentMarkKind.live || kind == AgentMarkKind.done;

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CustomPaint(
            size: const Size(6, 6),
            painter: _MarkPainter(color: color, filled: filled),
          ),
        ),
      ),
    );
  }
}

/// 8px stroke chevron. Replaces placeholder carets.
class AgentChevron extends StatelessWidget {
  /// Creates a chevron. [expanded] points down; otherwise end-ward.
  const AgentChevron({super.key, required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: const Size(8, 8),
        painter: _ChevronPainter(
          color: agentMutedOf(context),
          expanded: expanded,
        ),
      ),
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter({required this.color, required this.filled});

  final Color color;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.shortestSide / 2 - (filled ? 0 : 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter oldDelegate) {
    return color != oldDelegate.color || filled != oldDelegate.filled;
  }
}

class _ChevronPainter extends CustomPainter {
  const _ChevronPainter({required this.color, required this.expanded});

  final Color color;
  final bool expanded;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    if (expanded) {
      path
        ..moveTo(1, 2.5)
        ..lineTo(4, 5.5)
        ..lineTo(7, 2.5);
    } else {
      path
        ..moveTo(2.5, 1)
        ..lineTo(5.5, 4)
        ..lineTo(2.5, 7);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter oldDelegate) {
    return color != oldDelegate.color || expanded != oldDelegate.expanded;
  }
}
