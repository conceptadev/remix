import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../behavior/collapse_when_complete.dart';
import '../models/permission_parameter.dart';
import '../models/statuses.dart';
import '../style/defaults.dart';
import 'disclosure.dart';

const _kEaseOut = Cubic(0.16, 1, 0.3, 1);
const _kDetailsOpenMs = 220;
const _kDetailsCloseMs = 140;
const _kFooterMs = 220;
const _kFooterReduceMs = 120;
const _kMotionShift = 4.0;
const _kDetailsChevron = 14.0;
const _kDetailsTriggerRadius = 6.0;

/// In-transcript tool permission.
///
/// Offers allow once and deny while [status] is pending. Always allow
/// is shown only when [onAlwaysAllow] is set. The card stays in the
/// transcript after the decision.
class AgentPermission extends StatelessWidget {
  /// Creates a permission card.
  const AgentPermission({
    super.key,
    required this.tool,
    this.title,
    this.description,
    this.status = AgentPermissionStatus.pending,
    this.parameters = const [],
    this.showParameters = true,
    this.detailsOpen,
    this.onDetailsOpenChange,
    this.onAllowOnce,
    this.onAlwaysAllow,
    this.onDeny,
    this.allowOnceLabel = 'Allow once',
    this.alwaysAllowLabel = 'Always allow',
    this.denyLabel = 'Deny',
    this.parameterOrientation = Axis.horizontal,
    this.style,
  });

  /// Tool name shown to the operator.
  final String tool;

  /// Optional headline. Defaults to a generic allow question.
  final String? title;

  /// Optional supporting copy.
  final String? description;

  /// Current machine state. Not a boolean loading flag.
  final AgentPermissionStatus status;

  /// Inspectable arguments.
  final List<AgentPermissionParameter> parameters;

  /// When false, hide the parameter list even if [parameters] is nonempty.
  final bool showParameters;

  /// Controlled details expansion.
  final bool? detailsOpen;

  /// Called when details open or close.
  final ValueChanged<bool>? onDetailsOpenChange;

  /// Allow this invocation only.
  final VoidCallback? onAllowOnce;

  /// Remember access and allow.
  final VoidCallback? onAlwaysAllow;

  /// Refuse this invocation.
  final VoidCallback? onDeny;

  final String allowOnceLabel;
  final String alwaysAllowLabel;
  final String denyLabel;

  /// How parameter rows lay out. Horizontal is a shrinking 7rem-max label.
  final Axis parameterOrientation;

  /// Optional card style.
  final CardStyler? style;

  @override
  Widget build(BuildContext context) {
    final resolvedTitle = title ?? 'Allow this tool to run?';
    final pending = status == AgentPermissionStatus.pending;
    final showDetails = showParameters && parameters.isNotEmpty;
    // Pending starts closed and stays toggleable. Deciding/running use
    // collapse-when-complete so the operator can watch the arguments.
    final detailsWorking =
        status == AgentPermissionStatus.deciding ||
        status == AgentPermissionStatus.running;
    final ink = agentInkOf(context);

    return Semantics(
      container: true,
      label: 'Tool permission',
      child: SizedBox(
        width: double.infinity,
        child: RemixCard(
          style: style ?? agentPermissionStyle(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  kAgentPermissionPad,
                  kAgentPermissionPad,
                  kAgentPermissionPad,
                  showDetails ? 8 : kAgentPermissionPad,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: _PermissionStatusWell(status: status),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      resolvedTitle,
                                      style: agentTitleOf(context),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      tool,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: agentMetaOf(
                                        context,
                                      ).copyWith(fontFamily: 'monospace'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              RemixBadge(
                                label: _statusLabel,
                                style: _statusBadgeStyle(context, status),
                              ),
                            ],
                          ),
                          if (description != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              description!,
                              style: agentBodyOf(context).copyWith(
                                height: 20 / 14,
                                color: agentMutedOf(context),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (showDetails)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    kAgentPermissionPad,
                    0,
                    kAgentPermissionPad,
                    kAgentPermissionPad,
                  ),
                  child: _PermissionDetails(
                    working: detailsWorking,
                    defaultOpen: false,
                    open: detailsOpen,
                    onOpenChange: onDetailsOpenChange,
                    child: Padding(
                      padding: const EdgeInsets.only(top: kAgentPermissionPad),
                      child: _PermissionParameters(
                        parameters: parameters,
                        orientation: parameterOrientation,
                      ),
                    ),
                  ),
                ),
              _PermissionFooterReveal(
                visible: pending,
                child: DecoratedBox(
                  key: const ValueKey('agent-permission-footer'),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: ink.withValues(alpha: 0.16)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      kAgentPermissionPad,
                      12,
                      kAgentPermissionPad,
                      12,
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        RemixButton(
                          key: const ValueKey('agent-permission-allow-once'),
                          label: allowOnceLabel,
                          onPressed: onAllowOnce,
                          style: agentAllowButtonStyle(context),
                        ),
                        if (onAlwaysAllow != null)
                          RemixButton(
                            key: const ValueKey(
                              'agent-permission-always-allow',
                            ),
                            label: alwaysAllowLabel,
                            onPressed: onAlwaysAllow,
                            style: agentAlwaysButtonStyle(context),
                          ),
                        RemixButton(
                          key: const ValueKey('agent-permission-deny'),
                          label: denyLabel,
                          onPressed: onDeny,
                          style: agentDenyButtonStyle(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _statusLabel {
    return switch (status) {
      AgentPermissionStatus.pending => 'Permission required',
      AgentPermissionStatus.deciding => 'Recording',
      AgentPermissionStatus.allowed => 'Allowed',
      AgentPermissionStatus.running => 'Running',
      AgentPermissionStatus.complete => 'Complete',
      AgentPermissionStatus.denied => 'Denied',
      AgentPermissionStatus.error => 'Error',
    };
  }
}

Color _dangerInk(Color ink) {
  return ink.computeLuminance() > 0.45
      ? const Color(0xFFB42318)
      : const Color(0xFFF97066);
}

Color _paperOf(Color ink) {
  return ink.computeLuminance() > 0.45
      ? const Color(0xFF111111)
      : const Color(0xFFFFFFFF);
}

BadgeStyler _statusBadgeStyle(
  BuildContext context,
  AgentPermissionStatus status,
) {
  final ink = agentInkOf(context);
  final danger = _dangerInk(ink);
  final (fill, stroke, label) = switch (status) {
    AgentPermissionStatus.pending => (
      ink.withValues(alpha: 0.12),
      ink.withValues(alpha: 0.22),
      ink,
    ),
    AgentPermissionStatus.deciding || AgentPermissionStatus.running => (
      ink.withValues(alpha: 0.10),
      ink.withValues(alpha: 0.20),
      ink.withValues(alpha: 0.78),
    ),
    AgentPermissionStatus.allowed || AgentPermissionStatus.complete => (
      ink.withValues(alpha: 0.06),
      ink.withValues(alpha: 0.14),
      agentMutedOf(context),
    ),
    AgentPermissionStatus.denied || AgentPermissionStatus.error => (
      danger.withValues(alpha: 0.12),
      danger.withValues(alpha: 0.28),
      danger,
    ),
  };
  return BadgeStyler()
      .color(fill)
      .padding(.symmetric(horizontal: 8, vertical: 2))
      .borderRadius(.circular(999))
      .border(.all(.color(stroke).width(1)))
      .label(
        TextStyler().fontSize(11).fontWeight(FontWeight.w500).color(label),
      );
}

class _PermissionStatusWell extends StatelessWidget {
  const _PermissionStatusWell({required this.status});

  final AgentPermissionStatus status;

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    final busy =
        status == AgentPermissionStatus.deciding ||
        status == AgentPermissionStatus.running;
    final paper = _paperOf(ink);

    return ExcludeSemantics(
      child: Box(
        key: const ValueKey('agent-permission-status-well'),
        style: BoxStyler()
            .size(kAgentPermissionWellSize, kAgentPermissionWellSize)
            .alignment(Alignment.center)
            .borderRadius(.circular(kAgentControlRadius))
            .border(.all(.color(ink.withValues(alpha: 0.16)).width(1)))
            .color(paper),
        child: busy
            ? RemixSpinner(
                style: SpinnerStyler()
                    .size(16)
                    .strokeWidth(1.5)
                    .indicatorColor(agentMutedOf(context)),
              )
            : _PermissionStatusMark(status: status),
      ),
    );
  }
}

/// 16px permission / check / close / alert. Busy uses [RemixSpinner].
class _PermissionStatusMark extends StatelessWidget {
  const _PermissionStatusMark({required this.status});

  final AgentPermissionStatus status;

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    final muted = agentMutedOf(context);
    final (color, kind) = switch (status) {
      AgentPermissionStatus.allowed => (ink, _WellMarkKind.check),
      AgentPermissionStatus.complete => (
        ink.withValues(alpha: 0.28),
        _WellMarkKind.check,
      ),
      AgentPermissionStatus.error => (_dangerInk(ink), _WellMarkKind.alert),
      AgentPermissionStatus.denied => (muted, _WellMarkKind.close),
      AgentPermissionStatus.pending ||
      AgentPermissionStatus.deciding ||
      AgentPermissionStatus.running => (muted, _WellMarkKind.permission),
    };

    return CustomPaint(
      size: const Size(16, 16),
      painter: _WellMarkPainter(color: color, kind: kind),
    );
  }
}

enum _WellMarkKind { permission, check, close, alert }

class _WellMarkPainter extends CustomPainter {
  const _WellMarkPainter({required this.color, required this.kind});

  final Color color;
  final _WellMarkKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final s = size.shortestSide;
    final o = Offset(size.width / 2, size.height / 2);
    switch (kind) {
      case _WellMarkKind.permission:
        final shield = Path()
          ..moveTo(o.dx, s * 1.5 / 16)
          ..lineTo(s * 13.2 / 16, s * 3.6 / 16)
          ..lineTo(s * 13.2 / 16, s * 8.6 / 16)
          ..cubicTo(
            s * 13.2 / 16,
            s * 11.8 / 16,
            s * 10.6 / 16,
            s * 14.1 / 16,
            o.dx,
            s * 15 / 16,
          )
          ..cubicTo(
            s * 5.4 / 16,
            s * 14.1 / 16,
            s * 2.8 / 16,
            s * 11.8 / 16,
            s * 2.8 / 16,
            s * 8.6 / 16,
          )
          ..lineTo(s * 2.8 / 16, s * 3.6 / 16)
          ..close();
        canvas.drawPath(shield, stroke);
        canvas.drawPath(
          Path()
            ..moveTo(s * 5.4 / 16, s * 8.1 / 16)
            ..lineTo(s * 7.2 / 16, s * 9.9 / 16)
            ..lineTo(s * 10.8 / 16, s * 6.2 / 16),
          stroke,
        );
      case _WellMarkKind.check:
        canvas.drawPath(
          Path()
            ..moveTo(s * 3.2 / 16, s * 8.4 / 16)
            ..lineTo(s * 6.6 / 16, s * 11.8 / 16)
            ..lineTo(s * 12.8 / 16, s * 4.4 / 16),
          stroke,
        );
      case _WellMarkKind.close:
        canvas.drawLine(
          Offset(s * 4.2 / 16, s * 4.2 / 16),
          Offset(s * 11.8 / 16, s * 11.8 / 16),
          stroke,
        );
        canvas.drawLine(
          Offset(s * 11.8 / 16, s * 4.2 / 16),
          Offset(s * 4.2 / 16, s * 11.8 / 16),
          stroke,
        );
      case _WellMarkKind.alert:
        canvas.drawCircle(o, s * 6.4 / 16, stroke);
        canvas.drawLine(
          Offset(o.dx, s * 4.6 / 16),
          Offset(o.dx, s * 8.6 / 16),
          stroke,
        );
        canvas.drawCircle(
          Offset(o.dx, s * 11.2 / 16),
          s * 0.7 / 16,
          Paint()..color = color,
        );
    }
  }

  @override
  bool shouldRepaint(_WellMarkPainter oldDelegate) {
    return color != oldDelegate.color || kind != oldDelegate.kind;
  }
}

class _PermissionDetails extends StatefulWidget {
  const _PermissionDetails({
    required this.working,
    required this.defaultOpen,
    required this.open,
    required this.onOpenChange,
    required this.child,
  });

  final bool working;
  final bool defaultOpen;
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final Widget child;

  @override
  State<_PermissionDetails> createState() => _PermissionDetailsState();
}

class _PermissionDetailsState extends State<_PermissionDetails> {
  late var _userExpanded = widget.defaultOpen;

  bool get _expanded {
    return resolveCollapseWhenComplete(
      working: widget.working,
      collapseOnComplete: true,
      open: widget.open,
      defaultOpen: widget.defaultOpen,
      userExpanded: _userExpanded,
    );
  }

  @override
  void didUpdateWidget(_PermissionDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.working && !widget.working) {
      _userExpanded = widget.defaultOpen;
    }
    if (!oldWidget.working && widget.working) {
      _userExpanded = true;
    }
  }

  void _onOpenChange(bool next) {
    if (widget.open == null) {
      setState(() => _userExpanded = next);
    }
    widget.onOpenChange?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AgentDisclosure(
          working: widget.working,
          open: widget.open,
          defaultOpen: widget.defaultOpen,
          collapseOnComplete: true,
          onOpenChange: _onOpenChange,
          semanticLabel: 'Tool details',
          summary: Padding(
            padding: const EdgeInsets.only(left: kAgentPermissionWellSize + 12),
            child: _ViewDetailsSummary(expanded: _expanded),
          ),
          // Body is a sibling so close can clip/fade; AgentDisclosure
          // unmounts its child immediately.
          child: const SizedBox.shrink(),
        ),
        _PermissionDetailsReveal(open: _expanded, child: widget.child),
      ],
    );
  }
}

class _ViewDetailsSummary extends StatefulWidget {
  const _ViewDetailsSummary({required this.expanded});

  final bool expanded;

  @override
  State<_ViewDetailsSummary> createState() => _ViewDetailsSummaryState();
}

class _ViewDetailsSummaryState extends State<_ViewDetailsSummary> {
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
    final ink = agentInkOf(context);
    final muted = agentMutedOf(context);
    final reduce = MediaQuery.disableAnimationsOf(context);

    return PressableBox(
      key: const ValueKey('agent-permission-details-trigger'),
      controller: _states,
      canRequestFocus: false,
      excludeFromSemantics: true,
      semanticsRole: PressableSemanticsRole.none,
      mouseCursor: SystemMouseCursors.click,
      style: BoxStyler()
          .borderRadius(.circular(_kDetailsTriggerRadius))
          .onFocusVisible(
            .foregroundDecoration(
              .border(
                .color(ink)
                    .width(kAgentFocusRingWidth)
                    .strokeAlign(BorderSide.strokeAlignInside),
              ).borderRadius(.circular(_kDetailsTriggerRadius)),
            ),
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyledText(
            'View details',
            style: TextStyler()
                .fontSize(12)
                .height(1.35)
                .fontWeight(FontWeight.w500)
                .color(muted)
                .onHovered(.color(ink)),
          ),
          const SizedBox(width: 4),
          Box(
            style: BoxStyler()
                .size(_kDetailsChevron, _kDetailsChevron)
                .rotate(widget.expanded ? math.pi : 0)
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
              size: const Size(_kDetailsChevron, _kDetailsChevron),
              painter: _DownChevronPainter(color: muted),
            ),
          ),
        ],
      ),
    );
  }
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

class _PermissionDetailsReveal extends StatelessWidget {
  const _PermissionDetailsReveal({required this.open, required this.child});

  final bool open;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final tEnd = open ? 1.0 : 0.0;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: tEnd, end: tEnd),
      duration: reduce
          ? Duration.zero
          : Duration(milliseconds: open ? _kDetailsOpenMs : _kDetailsCloseMs),
      curve: _kEaseOut,
      builder: (context, t, child) {
        if (t <= 0 && !open) {
          return const SizedBox.shrink();
        }
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: t,
            child: Opacity(
              opacity: t,
              child: Transform.translate(
                offset: Offset(0, reduce ? 0 : (1 - t) * -_kMotionShift),
                child: SizedBox(width: double.infinity, child: child),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _PermissionFooterReveal extends StatelessWidget {
  const _PermissionFooterReveal({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final tEnd = visible ? 1.0 : 0.0;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: tEnd, end: tEnd),
      duration: Duration(milliseconds: reduce ? _kFooterReduceMs : _kFooterMs),
      curve: _kEaseOut,
      builder: (context, t, child) {
        if (t <= 0 && !visible) {
          return const SizedBox.shrink();
        }
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, visible && !reduce ? (1 - t) * _kMotionShift : 0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _PermissionParameters extends StatelessWidget {
  const _PermissionParameters({
    required this.parameters,
    required this.orientation,
  });

  final List<AgentPermissionParameter> parameters;
  final Axis orientation;

  @override
  Widget build(BuildContext context) {
    final muted = agentMetaOf(context);
    final valueStyle = muted.copyWith(
      fontFamily: 'monospace',
      color: agentInkOf(context).withValues(alpha: 0.85),
    );

    return Box(
      key: const ValueKey('agent-permission-parameters'),
      style: agentWellStyle(context),
      child: orientation == Axis.vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < parameters.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _verticalRow(parameters[i], muted, valueStyle),
                ],
              ],
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                var labelWidth = kAgentParameterLabelWidth;
                if (constraints.hasBoundedWidth) {
                  final available = constraints.maxWidth - 12;
                  if (available < labelWidth) {
                    labelWidth = available < 0 ? 0.0 : available;
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < parameters.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _horizontalRow(
                        parameters[i],
                        muted,
                        valueStyle,
                        labelWidth,
                      ),
                    ],
                  ],
                );
              },
            ),
    );
  }

  Widget _verticalRow(
    AgentPermissionParameter parameter,
    TextStyle muted,
    TextStyle valueStyle,
  ) {
    return Column(
      key: ValueKey(parameter.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          key: ValueKey('agent-permission-label-${parameter.id}'),
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: kAgentParameterLabelWidth,
          ),
          child: Text(parameter.label, style: muted),
        ),
        const SizedBox(height: 2),
        parameter.child ??
            Text(
              key: ValueKey('agent-permission-value-${parameter.id}'),
              _breakable(parameter.value!),
              style: valueStyle,
            ),
      ],
    );
  }

  Widget _horizontalRow(
    AgentPermissionParameter parameter,
    TextStyle muted,
    TextStyle valueStyle,
    double labelWidth,
  ) {
    return Row(
      key: ValueKey(parameter.id),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          key: ValueKey('agent-permission-label-${parameter.id}'),
          width: labelWidth,
          child: Text(
            parameter.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: muted,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              parameter.child ??
              Text(
                key: ValueKey('agent-permission-value-${parameter.id}'),
                _breakable(parameter.value!),
                style: valueStyle,
              ),
        ),
      ],
    );
  }
}

/// Soft-wrap opportunities inside long tokens. Flutter only breaks on spaces.
String _breakable(String value) {
  final buffer = StringBuffer();
  var run = 0;
  for (final rune in value.runes) {
    buffer.writeCharCode(rune);
    if (rune <= 0x20) {
      run = 0;
      continue;
    }
    run++;
    if (run == 16) {
      buffer.write('\u200b');
      run = 0;
    }
  }
  return buffer.toString();
}
