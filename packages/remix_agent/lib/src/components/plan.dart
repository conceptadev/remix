import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../behavior/live_edge.dart';
import '../models/plan_item.dart';
import '../models/statuses.dart';
import '../style/defaults.dart';
import 'disclosure.dart';
import 'marks.dart';

/// Title / detail / empty copy. 14 / 20.
const _kPlanRunHeight = 20 / 14;

/// Trigger corner and focus-visible ring.
const _kTriggerRadius = 6.0;

/// Trigger horizontal inset. Viewport 8 + row 6 so the 8px caret
/// shares an edge with item marks.
const _kSummaryPadX = 14.0;

/// Task plan for a long-running agent turn.
class AgentPlan extends StatelessWidget {
  /// Creates a plan.
  const AgentPlan({
    super.key,
    required this.items,
    this.title = 'Plan',
    this.collapseOnComplete = true,
    this.open,
    this.onOpenChange,
    this.maxHeight = kAgentPlanViewportHeight,
    this.style,
  });

  /// Ordered items.
  final List<AgentPlanItem> items;

  /// Visible title.
  final String title;

  /// Collapse the list when every item is settled.
  final bool collapseOnComplete;

  /// Controlled expanded state.
  final bool? open;

  /// Called when the operator toggles the disclosure.
  final ValueChanged<bool>? onOpenChange;

  /// Maximum height of the live item list.
  final double maxHeight;

  /// Optional card style. Off by default — a plan is a list, not a card.
  final CardStyler? style;

  /// Number of completed items.
  int get completedCount => items
      .where((item) => item.status == AgentPlanItemStatus.completed)
      .length;

  /// True while any item is still pending or in progress.
  bool get isWorking =>
      items.any((item) => !item.status.isDone) && items.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final working = isWorking;
    final countLabel = '${completedCount}/${items.length}';

    final content = AgentDisclosure(
      working: working,
      collapseOnComplete: collapseOnComplete,
      open: open,
      onOpenChange: onOpenChange,
      defaultOpen: items.isEmpty,
      semanticLabel: title,
      summary: _PlanSummary(title: title, count: countLabel),
      child: _PlanViewport(
        followOutput: working,
        busy: working,
        maxHeight: maxHeight,
        child: items.isEmpty
            ? const _PlanEmpty()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final item in items)
                    _PlanItem(
                      key: ValueKey('agent-plan-item-${item.id}'),
                      item: item,
                    ),
                ],
              ),
      ),
    );

    return Semantics(
      container: true,
      label: 'Task plan',
      child: agentMaybeCard(context: context, style: style, child: content),
    );
  }
}

/// 36-floor trigger. 14px inset, one-line title, 10px, tabular count.
///
/// Not [AgentDisclosureSummary] — that row wraps the title, has no
/// focus-visible ring, and floors at 6px pad instead of 36.
class _PlanSummary extends StatefulWidget {
  const _PlanSummary({required this.title, required this.count});

  final String title;
  final String count;

  @override
  State<_PlanSummary> createState() => _PlanSummaryState();
}

class _PlanSummaryState extends State<_PlanSummary> {
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
    final shown =
        context
            .findAncestorWidgetOfExactType<Semantics>()
            ?.properties
            .expanded ??
        true;
    final ink = agentInkOf(context);

    return PressableBox(
      key: const ValueKey('agent-plan-trigger'),
      controller: _states,
      canRequestFocus: false,
      excludeFromSemantics: true,
      semanticsRole: PressableSemanticsRole.none,
      mouseCursor: SystemMouseCursors.click,
      style: BoxStyler()
          .minHeight(kAgentRowMinHeight)
          .padding(.symmetric(horizontal: _kSummaryPadX, vertical: 4))
          .alignment(.centerLeft)
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
            style: BoxStyler()
                .wrap(.opacity(0.5))
                .onHovered(BoxStyler().wrap(.opacity(1))),
            child: AgentChevron(expanded: shown),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: agentTitleOf(context),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            widget.count,
            maxLines: 1,
            style: agentMetaOf(context).copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Item list. Own viewport: the conversation transcript reserves a
/// 12px end gutter so lines don't jump; this list is px-2 with no
/// scrollbar reserve.
class _PlanViewport extends StatefulWidget {
  const _PlanViewport({
    required this.followOutput,
    required this.busy,
    required this.maxHeight,
    required this.child,
  });

  final bool followOutput;
  final bool busy;
  final double maxHeight;
  final Widget child;

  @override
  State<_PlanViewport> createState() => _PlanViewportState();
}

class _PlanViewportState extends State<_PlanViewport> {
  final _controller = ScrollController();
  late final _policy = LiveEdgePolicy(enabled: widget.followOutput);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didUpdateWidget(_PlanViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    _policy.enabled = widget.followOutput;
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      label: 'Task list',
      child: Box(
        key: const ValueKey('agent-plan-viewport'),
        style: BoxStyler().minHeight(0).maxHeight(widget.maxHeight),
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
              ),
              child: SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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

class _PlanEmpty extends StatelessWidget {
  const _PlanEmpty();

  @override
  Widget build(BuildContext context) {
    return Box(
      style: BoxStyler().padding(.symmetric(horizontal: 6, vertical: 8)),
      child: Text(
        'No tasks yet',
        style: agentBodyOf(
          context,
        ).copyWith(height: _kPlanRunHeight, color: agentMutedOf(context)),
      ),
    );
  }
}

class _PlanItem extends StatelessWidget {
  const _PlanItem({super.key, required this.item});

  final AgentPlanItem item;

  @override
  Widget build(BuildContext context) {
    final detail = item.detail;

    return Box(
      style: BoxStyler()
          .minHeight(kAgentRowMinHeight)
          .padding(.symmetric(horizontal: 6, vertical: 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _PlanMark(status: item.status),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.title,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: _titleStyle(context, item.status),
            ),
          ),
          if (detail != null) ...[
            const SizedBox(width: 10),
            Text(
              detail,
              maxLines: 1,
              style: agentBodyOf(context).copyWith(
                height: _kPlanRunHeight,
                color: agentInkOf(context).withValues(alpha: 0.55),
              ),
            ),
          ],
        ],
      ),
    );
  }

  TextStyle _titleStyle(BuildContext context, AgentPlanItemStatus status) {
    final color = switch (status) {
      AgentPlanItemStatus.inProgress => agentInkOf(context),
      AgentPlanItemStatus.pending => agentMutedOf(context),
      AgentPlanItemStatus.completed ||
      AgentPlanItemStatus.cancelled => agentCompletedOf(context),
    };
    return agentBodyOf(context).copyWith(
      height: _kPlanRunHeight,
      color: color,
      decoration: status == AgentPlanItemStatus.completed
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      decorationColor: color,
      decorationThickness: 1,
    );
  }
}

/// [AgentLiveMark] pads 4px top for stacked copy. This row is items-center
/// on one line, so balance the pad.
class _PlanMark extends StatelessWidget {
  const _PlanMark({required this.status});

  final AgentPlanItemStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: AgentLiveMark(
        kind: switch (status) {
          AgentPlanItemStatus.pending => AgentMarkKind.pending,
          AgentPlanItemStatus.inProgress => AgentMarkKind.live,
          AgentPlanItemStatus.completed => AgentMarkKind.done,
          AgentPlanItemStatus.cancelled => AgentMarkKind.cancelled,
        },
        semanticLabel: status.name,
      ),
    );
  }
}
