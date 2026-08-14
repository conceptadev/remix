import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../loading/carbon_loading.dart';

/// Carbon inline-loading states.
enum CarbonInlineLoadingStatus { inactive, active, finished, error }

/// A compact Carbon status line for in-place asynchronous work.
class CarbonInlineLoading extends StatefulWidget {
  const CarbonInlineLoading({
    super.key,
    required this.label,
    this.status = .active,
    this.onSuccess,
  });

  final String label;
  final CarbonInlineLoadingStatus status;

  /// Invoked once each time [status] enters [CarbonInlineLoadingStatus.finished].
  final VoidCallback? onSuccess;

  @override
  State<CarbonInlineLoading> createState() => _CarbonInlineLoadingState();
}

class _CarbonInlineLoadingState extends State<CarbonInlineLoading> {
  var _successNotified = false;

  @override
  void initState() {
    super.initState();
    _scheduleSuccessIfNeeded();
  }

  @override
  void didUpdateWidget(CarbonInlineLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != .finished) {
      _successNotified = false;
    }
    _scheduleSuccessIfNeeded();
  }

  void _scheduleSuccessIfNeeded() {
    if (widget.status != .finished ||
        _successNotified ||
        widget.onSuccess == null) {
      return;
    }
    _successNotified = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.status == .finished) {
        widget.onSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final terminal = widget.status == .finished || widget.status == .error;
    final statusValue = switch (widget.status) {
      .inactive => 'Inactive',
      .active => 'In progress',
      .finished => 'Complete',
      .error => 'Error',
    };

    return Semantics(
      label: widget.label,
      value: statusValue,
      liveRegion: terminal,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 32,
          child: Row(
            mainAxisSize: .min,
            spacing: CarbonTokens.spacing03.resolve(context),
            children: [
              _statusIndicator(context),
              StyledText(
                widget.label,
                style: TextStyler()
                    .style(CarbonTokens.label02.mix())
                    .color(CarbonTokens.textPrimary()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusIndicator(BuildContext context) => switch (widget.status) {
    .inactive => const SizedBox.square(dimension: 16),
    .active => RemixSpinner(style: carbonLoadingStyle(small: true)),
    .finished => CustomPaint(
      size: const Size.square(16),
      painter: _InlineStatusPainter(
        color: CarbonTokens.supportSuccess.resolve(context),
        error: false,
      ),
    ),
    .error => CustomPaint(
      size: const Size.square(16),
      painter: _InlineStatusPainter(
        color: CarbonTokens.supportError.resolve(context),
        error: true,
      ),
    ),
  };
}

class _InlineStatusPainter extends CustomPainter {
  const _InlineStatusPainter({required this.color, required this.error});

  final Color color;
  final bool error;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final stroke = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.75
      ..strokeCap = ui.StrokeCap.square;
    canvas.drawCircle(
      ui.Offset(size.width / 2, size.height / 2),
      size.shortestSide / 2 - 1,
      stroke,
    );
    if (error) {
      canvas
        ..drawLine(
          ui.Offset(size.width * 0.34, size.height * 0.34),
          ui.Offset(size.width * 0.66, size.height * 0.66),
          stroke,
        )
        ..drawLine(
          ui.Offset(size.width * 0.66, size.height * 0.34),
          ui.Offset(size.width * 0.34, size.height * 0.66),
          stroke,
        );
    } else {
      final check = ui.Path()
        ..moveTo(size.width * 0.28, size.height * 0.52)
        ..lineTo(size.width * 0.44, size.height * 0.68)
        ..lineTo(size.width * 0.73, size.height * 0.35);
      canvas.drawPath(check, stroke);
    }
  }

  @override
  bool shouldRepaint(_InlineStatusPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.error != error;
}
