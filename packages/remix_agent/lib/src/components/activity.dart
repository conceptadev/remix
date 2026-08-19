import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../behavior/collapse_when_complete.dart';
import '../behavior/live_edge.dart';
import '../models/activity_item.dart';
import '../models/statuses.dart';
import '../style/defaults.dart';
import 'disclosure.dart';
import 'marks.dart';

/// Working / completed trigger height.
const _kTriggerHeight = 28.0;

/// Completed trigger corner.
const _kTriggerRadius = 6.0;

/// Title ↔ trailing chevron.
const _kTriggerGap = 6.0;

/// Ledger column vertical inset.
const _kLedgerPadY = 8.0;

/// Ledger viewport end inset. Scrollbar is hidden; this is not the
/// conversation 12px gutter.
const _kLedgerPadEnd = 4.0;

/// Gap between ledger rows.
const _kLedgerGap = 2.0;

/// Capped viewport fade length.
const _kLedgerFade = 12.0;

/// Completed chevron rest as a fraction of muted. Hover lifts to ink.
const _kChevronRestFactor = 0.70;

/// Trailing completed-trigger chevron.
const _kChevronSize = 8.0;

/// Shared ease with the permission details reveal.
const _kEaseOut = Cubic(0.16, 1, 0.3, 1);

/// Ledger open / close. Close is shorter so collapse does not linger.
const _kRevealOpenMs = 220;
const _kRevealCloseMs = 140;

/// Closed ledger sits 4px above its rest position.
const _kRevealShift = 4.0;

/// New row enter. Opacity eases; y uses layout spring.
const _kRowEnterY = 6.0;
const _kRowEnterMs = 180;

/// Completed trigger muted → ink.
const _kHoverMs = 150;

/// Slim activity ledger.
///
/// Each item is a title plus an optional host-rendered child. The catalog
/// does not invent item kinds.
class AgentActivity extends StatefulWidget {
  /// Creates an activity ledger.
  const AgentActivity({
    super.key,
    required this.items,
    this.status = AgentRunStatus.working,
    this.collapseOnComplete = true,
    this.open,
    this.onOpenChange,
    this.maxHeight = kAgentActivityViewportHeight,
    this.title = 'Activity',
    this.style,
  });

  /// Chronological items.
  final List<AgentActivityItem> items;

  /// Overall run phase.
  final AgentRunStatus status;

  /// Collapse the ledger when [status] is complete.
  final bool collapseOnComplete;

  /// Controlled expanded state.
  final bool? open;

  /// Called when the operator toggles the disclosure.
  final ValueChanged<bool>? onOpenChange;

  /// Maximum height of the live ledger.
  final double maxHeight;

  /// Visible title. Also the working live label and completed summary.
  final String title;

  /// Optional card style. Off by default — a ledger is a list, not a card.
  final CardStyler? style;

  bool get _working => status == AgentRunStatus.working;

  @override
  State<AgentActivity> createState() => _AgentActivityState();
}

class _AgentActivityState extends State<AgentActivity> {
  final _controller = ScrollController();
  var _capped = false;
  var _userExpanded = false;

  bool get _expanded {
    return resolveCollapseWhenComplete(
      working: widget._working,
      collapseOnComplete: widget.collapseOnComplete,
      open: widget.open,
      userExpanded: _userExpanded,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncCapped());
  }

  @override
  void didUpdateWidget(AgentActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    final working = widget._working;
    if (oldWidget._working && !working && widget.collapseOnComplete) {
      _userExpanded = false;
    }
    if (!oldWidget._working && working) {
      _userExpanded = true;
    }
    if (oldWidget.status == AgentRunStatus.working &&
        widget.status == AgentRunStatus.complete) {
      _pinToTop();
    }
    if (oldWidget.open != true && widget.open == true && !working) {
      _pinToTop();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncCapped());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pinToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) {
        return;
      }
      _controller.jumpTo(0);
    });
  }

  void _syncCapped() {
    if (!mounted) {
      return;
    }
    final capped =
        _controller.hasClients && _controller.position.maxScrollExtent > 0;
    if (capped == _capped) {
      return;
    }
    setState(() => _capped = capped);
  }

  void _onOpenChange(bool next) {
    if (widget.open == null && next != _userExpanded) {
      setState(() => _userExpanded = next);
    }
    if (next && !widget._working) {
      _pinToTop();
    }
    widget.onOpenChange?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final working = widget._working;
    final expanded = _expanded;
    Widget ledger = _ActivityViewport(
      controller: _controller,
      followOutput: working,
      busy: working,
      fillHeight: working || !expanded,
      maxHeight: widget.maxHeight,
      child: ColumnBox(
        style: FlexBoxStyler()
            .crossAxisAlignment(.stretch)
            .mainAxisSize(.min)
            .spacing(_kLedgerGap)
            .padding(.symmetric(vertical: _kLedgerPadY)),
        children: [
          for (final item in widget.items)
            _ActivityRowEnter(
              key: ValueKey('agent-activity-item-${item.id}'),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: kAgentRowMinHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AgentLiveMark(
                            kind: _itemKind(item.status),
                            semanticLabel: item.status.name,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.title,
                              style: _itemTitleStyle(context, item.status),
                            ),
                          ),
                        ],
                      ),
                      if (item.child != null) ...[
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: item.child!,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (_capped) {
      ledger = Box(
        style: BoxStyler().wrap(
          WidgetModifierConfig.shaderMask(
            shaderCallback: ShaderCallbackBuilder(
              callback: (rect) => _ledgerFadeShader(rect, working: working),
            ),
            blendMode: BlendMode.dstIn,
          ),
        ),
        child: ledger,
      );
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AgentDisclosure(
          working: working,
          collapseOnComplete: widget.collapseOnComplete,
          open: widget.open,
          onOpenChange: _onOpenChange,
          semanticLabel: widget.title,
          summary: working
              ? _ActivityWorkingStatus(title: widget.title)
              : _ActivityCompletedTrigger(title: widget.title),
          // Body is a sibling so close can clip/ease; AgentDisclosure
          // unmounts its child immediately.
          child: const SizedBox.shrink(),
        ),
        _ActivityLedgerReveal(
          open: expanded,
          child: NotificationListener<ScrollMetricsNotification>(
            onNotification: (notification) {
              _syncCapped();
              return false;
            },
            child: ledger,
          ),
        ),
      ],
    );

    return Semantics(
      container: true,
      label: 'Activity',
      child: agentMaybeCard(
        context: context,
        style: widget.style,
        child: content,
      ),
    );
  }
}

/// 28px muted live label. Host [AgentActivity.title], no chevron.
class _ActivityWorkingStatus extends StatelessWidget {
  const _ActivityWorkingStatus({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Box(
        key: const ValueKey('agent-activity-trigger'),
        style: BoxStyler().height(_kTriggerHeight).alignment(.centerLeft),
        child: Text(
          title,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: agentBodyOf(context).copyWith(color: agentMutedOf(context)),
        ),
      ),
    );
  }
}

/// 28px 14/medium muted summary, 6px gap, trailing chevron.
///
/// Shrink-wraps to the title+chevron cluster so the 6px focus-visible
/// ring hugs that run. Chevron is quieter at rest (muted/70) and lifts
/// to ink with the title on group hover.
///
/// Not [AgentDisclosureSummary] — that row is a 15/semibold titled
/// disclosure with a leading chevron and trailing count.
class _ActivityCompletedTrigger extends StatefulWidget {
  const _ActivityCompletedTrigger({required this.title});

  final String title;

  @override
  State<_ActivityCompletedTrigger> createState() =>
      _ActivityCompletedTriggerState();
}

class _ActivityCompletedTriggerState extends State<_ActivityCompletedTrigger> {
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
    final expanded =
        context
            .findAncestorWidgetOfExactType<Semantics>()
            ?.properties
            .expanded ??
        true;
    final ink = agentInkOf(context);
    final muted = agentMutedOf(context);
    final reduce = MediaQuery.disableAnimationsOf(context);
    final hover = reduce
        ? AnimationConfig.linear(Duration.zero)
        : AnimationConfig.ease(_kHoverMs.ms);

    return Align(
      alignment: Alignment.centerLeft,
      child: PressableBox(
        key: const ValueKey('agent-activity-trigger'),
        controller: _states,
        canRequestFocus: false,
        excludeFromSemantics: true,
        semanticsRole: PressableSemanticsRole.none,
        mouseCursor: SystemMouseCursors.click,
        style: BoxStyler()
            .height(_kTriggerHeight)
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: StyledText(
                widget.title,
                style: TextStyler()
                    .fontSize(14)
                    .height(1.45)
                    .fontWeight(FontWeight.w500)
                    .color(muted)
                    .maxLines(1)
                    .softWrap(false)
                    .overflow(TextOverflow.ellipsis)
                    .onHovered(.color(ink))
                    .animate(hover),
              ),
            ),
            const SizedBox(width: _kTriggerGap),
            Box(
              style: BoxStyler()
                  .wrap(.opacity(muted.a * _kChevronRestFactor))
                  .onHovered(BoxStyler().wrap(.opacity(1)))
                  .animate(hover),
              child: ExcludeSemantics(
                child: CustomPaint(
                  size: const Size(_kChevronSize, _kChevronSize),
                  painter: _ActivityChevronPainter(
                    color: ink,
                    expanded: expanded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Live ledger. Own viewport: the conversation transcript reserves a
/// 12px end gutter so line width does not jump; this list is 4px end
/// pad with the scrollbar hidden.
class _ActivityViewport extends StatefulWidget {
  const _ActivityViewport({
    required this.controller,
    required this.followOutput,
    required this.busy,
    required this.fillHeight,
    required this.maxHeight,
    required this.child,
  });

  final ScrollController controller;
  final bool followOutput;
  final bool busy;
  final bool fillHeight;
  final double maxHeight;
  final Widget child;

  @override
  State<_ActivityViewport> createState() => _ActivityViewportState();
}

class _ActivityViewportState extends State<_ActivityViewport> {
  late final _policy = LiveEdgePolicy(enabled: widget.followOutput);

  ScrollController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didUpdateWidget(_ActivityViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    _policy.enabled = widget.followOutput;
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  Future<void> _follow() {
    if (!mounted) {
      return Future<void>.value();
    }
    return _policy.followIfNeeded(_controller);
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (notification is OverscrollNotification) {
      return true;
    }
    if (_policy.isProgrammatic) {
      return false;
    }
    final fromPointer =
        notification is ScrollUpdateNotification &&
        notification.dragDetails != null;
    final fromUser = notification is UserScrollNotification;
    if (!fromPointer && !fromUser) {
      return false;
    }
    if (_controller.hasClients) {
      _policy.handleUserScroll(_controller.position);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: widget.busy,
      label: 'Activity log',
      child: Box(
        key: const ValueKey('agent-activity-viewport'),
        style: widget.fillHeight
            ? BoxStyler().height(widget.maxHeight)
            : BoxStyler().minHeight(0).maxHeight(widget.maxHeight),
        child: NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            if (notification.depth == 0 && _policy.following) {
              _follow();
            }
            return false;
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
                physics: const ClampingScrollPhysics(),
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsetsDirectional.only(end: _kLedgerPadEnd),
                physics: const ClampingScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Clip/ease the ledger to the viewport height. Working fills the well,
/// so heightFactor 1 is [AgentActivity.maxHeight].
class _ActivityLedgerReveal extends StatelessWidget {
  const _ActivityLedgerReveal({required this.open, required this.child});

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
          : Duration(milliseconds: open ? _kRevealOpenMs : _kRevealCloseMs),
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
                offset: Offset(0, reduce ? 0 : (1 - t) * -_kRevealShift),
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

/// New rows ease from opacity 0 / +6px y. Reduced motion snaps.
class _ActivityRowEnter extends StatefulWidget {
  const _ActivityRowEnter({super.key, required this.child});

  final Widget child;

  @override
  State<_ActivityRowEnter> createState() => _ActivityRowEnterState();
}

class _ActivityRowEnterState extends State<_ActivityRowEnter> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final visible = reduce || _visible;
    return Box(
      style: BoxStyler()
          .wrap(.opacity(visible ? 1 : 0))
          .animate(
            reduce
                ? AnimationConfig.linear(Duration.zero)
                : AnimationConfig.curve(
                    duration: _kRowEnterMs.ms,
                    curve: _kEaseOut,
                  ),
          ),
      child: Box(
        style: BoxStyler()
            .translate(0, visible ? 0 : _kRowEnterY)
            .animate(
              reduce
                  ? AnimationConfig.linear(Duration.zero)
                  : AnimationConfig.springDescription(
                      mass: 0.6,
                      stiffness: 360,
                      damping: 32,
                    ),
            ),
        child: widget.child,
      ),
    );
  }
}

/// 8px stroke painted in ink. [AgentChevron] is muted and cannot lift
/// to ink on group hover.
class _ActivityChevronPainter extends CustomPainter {
  const _ActivityChevronPainter({required this.color, required this.expanded});

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
  bool shouldRepaint(_ActivityChevronPainter oldDelegate) {
    return color != oldDelegate.color || expanded != oldDelegate.expanded;
  }
}

Shader _ledgerFadeShader(Rect rect, {required bool working}) {
  final extent = rect.height <= 0
      ? 0.0
      : (_kLedgerFade / rect.height).clamp(0.0, 1.0);
  if (working) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [Color(0x00000000), Color(0xFF000000)],
      stops: [0, extent],
    ).createShader(rect);
  }
  final bottom = (1 - extent).clamp(0.0, 1.0);
  final topStop = extent <= bottom ? extent : bottom * 0.5;
  final bottomStop = extent <= bottom ? bottom : 0.5 + bottom * 0.5;
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: const [
      Color(0x00000000),
      Color(0xFF000000),
      Color(0xFF000000),
      Color(0x00000000),
    ],
    stops: [0, topStop, bottomStop, 1],
  ).createShader(rect);
}

TextStyle _itemTitleStyle(
  BuildContext context,
  AgentActivityItemStatus status,
) {
  return switch (status) {
    AgentActivityItemStatus.active => agentBodyOf(context),
    AgentActivityItemStatus.complete => agentCompletedOfStyle(context),
    AgentActivityItemStatus.pending => agentBodyOf(
      context,
    ).copyWith(color: agentMutedOf(context)),
  };
}

AgentMarkKind _itemKind(AgentActivityItemStatus status) {
  return switch (status) {
    AgentActivityItemStatus.pending => AgentMarkKind.pending,
    AgentActivityItemStatus.active => AgentMarkKind.live,
    AgentActivityItemStatus.complete => AgentMarkKind.done,
  };
}
