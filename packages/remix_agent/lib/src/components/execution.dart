import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../style/defaults.dart';
import 'disclosure.dart';
import 'transcript.dart';

/// Tool execution disclosure.
///
/// Stays open while [status] is running. Collapses when the run settles if
/// [collapseOnComplete] is true. [child] is host-rendered output.
class AgentExecution extends StatelessWidget {
  /// Creates an execution disclosure.
  const AgentExecution({
    super.key,
    required this.tool,
    required this.title,
    required this.child,
    this.status = AgentExecutionStatus.running,
    this.meta,
    this.icon,
    this.copyAction,
    this.retryAction,
    this.showActions = true,
    this.collapseOnComplete = true,
    this.open,
    this.onOpenChange,
    this.maxHeight = 220,
    this.style,
  });

  /// Tool name.
  final String tool;

  /// Visible title.
  final String title;

  /// Host-rendered output.
  final Widget child;

  /// Current machine state.
  final AgentExecutionStatus status;

  /// Optional compact metadata (duration, status code).
  final String? meta;

  /// Optional 16px kind glyph. A Mix terminal mark is used when omitted.
  final Widget? icon;

  /// Optional copy control. Shown after the run settles.
  final Widget? copyAction;

  /// Optional retry control. Shown after the run settles.
  final Widget? retryAction;

  /// When false, hide copy/retry even after the run settles.
  final bool showActions;

  /// When true, hide the body after the run settles.
  final bool collapseOnComplete;

  /// Controlled expanded state.
  final bool? open;

  /// Called when the operator toggles the disclosure.
  final ValueChanged<bool>? onOpenChange;

  /// Maximum height of the live output viewport.
  final double maxHeight;

  /// Optional card style. Off by default — the well is the surface.
  final CardStyler? style;

  @override
  Widget build(BuildContext context) {
    final working = status.isWorking;
    final statusLabel = _statusLabel;
    final revealActions =
        showActions &&
        status.isSettled &&
        (copyAction != null || retryAction != null);

    final content = AgentDisclosure(
      working: working,
      collapseOnComplete: collapseOnComplete,
      open: open,
      onOpenChange: onOpenChange,
      semanticLabel: title,
      summary: _ExecutionTrigger(
        title: title,
        tool: tool,
        meta: meta,
        icon: icon,
        status: status,
        statusLabel: statusLabel,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 24, top: 6),
        child: Box(
          key: const ValueKey('agent-execution-well'),
          style: _outputWellStyle(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                style: _logRunOf(context),
                child: AgentTranscript(
                  followOutput: working,
                  busy: working,
                  label: 'Tool output',
                  maxHeight: maxHeight,
                  // 12 all sides; omit end so the transcript gutter is the end 12.
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    top: 12,
                    bottom: 12,
                  ),
                  child: child,
                ),
              ),
              if (revealActions)
                Padding(
                  key: const ValueKey('agent-execution-footer'),
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
                  child: Row(
                    children: [
                      if (copyAction != null)
                        _ExecutionAction(
                          key: const ValueKey('agent-execution-copy'),
                          child: copyAction!,
                        ),
                      if (copyAction != null && retryAction != null)
                        const SizedBox(width: 2),
                      if (retryAction != null)
                        _ExecutionAction(
                          key: const ValueKey('agent-execution-retry'),
                          child: retryAction!,
                        ),
                      const Spacer(),
                      Text(
                        statusLabel,
                        maxLines: 1,
                        style: _quietRunOf(context),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return Semantics(
      container: true,
      label: 'Tool execution',
      child: agentMaybeCard(context: context, style: style, child: content),
    );
  }

  String get _statusLabel {
    return switch (status) {
      AgentExecutionStatus.running => 'Running',
      AgentExecutionStatus.success => 'Completed',
      AgentExecutionStatus.error => 'Failed',
      AgentExecutionStatus.cancelled => 'Cancelled',
    };
  }
}

/// Leading kind slot. 16+8 gap lines up with the 24px well indent.
const _kIconSlot = 16.0;

/// Trailing expand chevron.
const _kChevron = 14.0;

/// Status mark beside the trigger label.
const _kStatusMark = 12.0;

/// Trigger corner and focus-visible ring.
const _kTriggerRadius = 6.0;

/// One-line trigger. Not [AgentDisclosureSummary] — that row wraps the title,
/// substitutes meta for status, and floors at 6px pad instead of 36.
class _ExecutionTrigger extends StatefulWidget {
  const _ExecutionTrigger({
    required this.title,
    required this.tool,
    required this.status,
    required this.statusLabel,
    this.meta,
    this.icon,
  });

  final String title;
  final String tool;
  final AgentExecutionStatus status;
  final String statusLabel;
  final String? meta;
  final Widget? icon;

  @override
  State<_ExecutionTrigger> createState() => _ExecutionTriggerState();
}

class _ExecutionTriggerState extends State<_ExecutionTrigger> {
  final _states = WidgetStatesController();
  FocusNode? _ancestor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final node = Focus.maybeOf(context);
    if (!identical(node, _ancestor)) {
      _ancestor?.removeListener(_syncFocus);
      _ancestor = node;
      _ancestor?.addListener(_syncFocus);
    }
    _syncFocus();
  }

  @override
  void dispose() {
    _ancestor?.removeListener(_syncFocus);
    _states.dispose();
    super.dispose();
  }

  void _syncFocus() {
    _states.focused = _ancestor?.hasFocus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Disclosure rebuilds this summary on toggle. The expand inherited
    // widget stays private to disclosure.dart.
    final expanded =
        context
            .findAncestorWidgetOfExactType<Semantics>()
            ?.properties
            .expanded ??
        true;
    final ink = agentInkOf(context);
    final muted = agentMutedOf(context);
    final reduce = MediaQuery.disableAnimationsOf(context);

    return PressableBox(
      key: const ValueKey('agent-execution-trigger'),
      controller: _states,
      canRequestFocus: false,
      excludeFromSemantics: true,
      semanticsRole: PressableSemanticsRole.none,
      mouseCursor: SystemMouseCursors.click,
      style: BoxStyler()
          .minHeight(kAgentRowMinHeight)
          .padding(.symmetric(vertical: 4))
          .borderRadius(.circular(_kTriggerRadius))
          .onFocusVisible(
            .foregroundDecoration(
              .border(
                .color(ink)
                    .width(kAgentFocusRingWidth)
                    .strokeAlign(BorderSide.strokeAlignInside),
              ).borderRadius(.circular(_kTriggerRadius)),
            ),
          ),
      child: Row(
        children: [
          Box(
            key: const ValueKey('agent-execution-icon'),
            style: BoxStyler().size(_kIconSlot, _kIconSlot).alignment(.center),
            child: IconTheme(
              data: IconThemeData(size: _kIconSlot, color: muted),
              child:
                  widget.icon ??
                  ExcludeSemantics(
                    child: CustomPaint(
                      size: const Size(_kIconSlot, _kIconSlot),
                      painter: _KindGlyphPainter(color: muted),
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: _titleRunOf(context),
                  ),
                ),
                if (widget.meta != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    widget.meta!,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: agentMetaOf(context),
                  ),
                ],
                const SizedBox(width: 8),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.tool,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: _toolRunOf(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusMark(status: widget.status),
              const SizedBox(width: 4),
              Text(
                widget.statusLabel,
                maxLines: 1,
                style: _statusRunOf(context),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Box(
            key: const ValueKey('agent-execution-chevron'),
            style: BoxStyler()
                .size(_kChevron, _kChevron)
                .alignment(.center)
                .wrap(.opacity(0.50))
                .onHovered(BoxStyler().wrap(.opacity(0.62))),
            child: Box(
              style: BoxStyler()
                  .size(_kChevron, _kChevron)
                  .rotate(expanded ? math.pi : 0)
                  .animate(
                    reduce
                        ? .linear(Duration.zero)
                        : AnimationConfig.springDescription(
                            mass: 0.55,
                            stiffness: 460,
                            damping: 30,
                          ),
                  ),
              child: CustomPaint(
                size: const Size(_kChevron, _kChevron),
                painter: _DownChevronPainter(color: ink),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 28×28 muted 6px-radius hover-wash. Same chrome as the answer slots.
class _ExecutionAction extends StatelessWidget {
  const _ExecutionAction({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    return PressableBox(
      canRequestFocus: false,
      excludeFromSemantics: true,
      semanticsRole: PressableSemanticsRole.none,
      mouseCursor: MouseCursor.defer,
      style: BoxStyler()
          .size(kAgentActionSize, kAgentActionSize)
          .alignment(.center)
          .clipBehavior(Clip.hardEdge)
          .borderRadius(.circular(kAgentActionRadius))
          .onHovered(.color(ink.withValues(alpha: 0.06))),
      child: DefaultTextStyle.merge(style: agentMetaOf(context), child: child),
    );
  }
}

/// 12px host-ink mark. Spinner while running; check, x, or slash when settled.
class _StatusMark extends StatelessWidget {
  const _StatusMark({required this.status});

  final AgentExecutionStatus status;

  @override
  Widget build(BuildContext context) {
    final color = agentMutedOf(context);
    if (status == AgentExecutionStatus.running) {
      return ExcludeSemantics(
        child: RemixSpinner(
          key: const ValueKey('agent-execution-status-mark'),
          style: SpinnerStyler()
              .size(_kStatusMark)
              .strokeWidth(1.4)
              .indicatorColor(color),
        ),
      );
    }

    return ExcludeSemantics(
      child: CustomPaint(
        key: const ValueKey('agent-execution-status-mark'),
        size: const Size(_kStatusMark, _kStatusMark),
        painter: _StatusMarkPainter(color: color, status: status),
      ),
    );
  }
}

/// Clipped wash. Pad lives on the log so the footer can sit on the shell.
BoxStyler _outputWellStyle(BuildContext context) {
  return BoxStyler()
      .color(agentInkOf(context).withValues(alpha: 0.08))
      .borderRadius(.circular(kAgentControlRadius))
      .clipBehavior(Clip.antiAlias);
}

TextStyle _titleRunOf(BuildContext context) {
  return DefaultTextStyle.of(context).style.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    color: agentInkOf(context).withValues(alpha: 0.90),
  );
}

TextStyle _logRunOf(BuildContext context) {
  return agentBodyOf(context).copyWith(
    fontFamily: 'monospace',
    color: agentInkOf(context).withValues(alpha: 0.80),
  );
}

TextStyle _toolRunOf(BuildContext context) {
  return _quietRunOf(context).copyWith(fontFamily: 'monospace');
}

TextStyle _statusRunOf(BuildContext context) {
  return _quietRunOf(
    context,
  ).copyWith(fontWeight: FontWeight.w500, color: agentMutedOf(context));
}

TextStyle _quietRunOf(BuildContext context) {
  return DefaultTextStyle.of(context).style.copyWith(
    fontSize: 11,
    height: 1.35,
    fontWeight: FontWeight.w400,
    color: agentInkOf(context).withValues(alpha: 0.55),
  );
}

class _KindGlyphPainter extends CustomPainter {
  const _KindGlyphPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final s = size.shortestSide;
    final inset = s * 1.5 / 16;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(inset, inset, s - inset * 2, s - inset * 2),
        Radius.circular(s * 2 / 16),
      ),
      stroke,
    );
    canvas.drawPath(
      Path()
        ..moveTo(s * 4.5 / 16, s * 7 / 16)
        ..lineTo(s * 6.5 / 16, s * 9 / 16)
        ..lineTo(s * 4.5 / 16, s * 11 / 16),
      stroke,
    );
  }

  @override
  bool shouldRepaint(_KindGlyphPainter oldDelegate) =>
      color != oldDelegate.color;
}

class _DownChevronPainter extends CustomPainter {
  const _DownChevronPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final s = size.shortestSide;
    canvas.drawPath(
      Path()
        ..moveTo(s * 3.5 / 14, s * 5.25 / 14)
        ..lineTo(s * 7 / 14, s * 8.75 / 14)
        ..lineTo(s * 10.5 / 14, s * 5.25 / 14),
      paint,
    );
  }

  @override
  bool shouldRepaint(_DownChevronPainter oldDelegate) =>
      color != oldDelegate.color;
}

class _StatusMarkPainter extends CustomPainter {
  const _StatusMarkPainter({required this.color, required this.status});

  final Color color;
  final AgentExecutionStatus status;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final s = size.shortestSide;
    final o = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(o, s / 2 - 0.6, stroke);
    switch (status) {
      case AgentExecutionStatus.success:
        canvas.drawPath(
          Path()
            ..moveTo(s * 3.2 / 12, s * 6.2 / 12)
            ..lineTo(s * 5.2 / 12, s * 8.2 / 12)
            ..lineTo(s * 8.8 / 12, s * 4.2 / 12),
          stroke,
        );
      case AgentExecutionStatus.error:
        canvas.drawLine(
          Offset(s * 4.1 / 12, s * 4.1 / 12),
          Offset(s * 7.9 / 12, s * 7.9 / 12),
          stroke,
        );
        canvas.drawLine(
          Offset(s * 7.9 / 12, s * 4.1 / 12),
          Offset(s * 4.1 / 12, s * 7.9 / 12),
          stroke,
        );
      case AgentExecutionStatus.cancelled:
        canvas.drawLine(
          Offset(s * 3.4 / 12, s * 3.4 / 12),
          Offset(s * 8.6 / 12, s * 8.6 / 12),
          stroke,
        );
      case AgentExecutionStatus.running:
        break;
    }
  }

  @override
  bool shouldRepaint(_StatusMarkPainter oldDelegate) {
    return color != oldDelegate.color || status != oldDelegate.status;
  }
}
