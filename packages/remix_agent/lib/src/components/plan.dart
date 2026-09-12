import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/plan_item.dart';
import '../models/statuses.dart';
import '../style/functional_glyph.dart';
import '../style/live_edge.dart';

part 'plan.g.dart';

typedef AgentPlanStatusBuilder =
    Widget Function(BuildContext context, AgentPlanItem item);
typedef AgentPlanStatusLabelBuilder = String Function(AgentPlanItem item);
typedef AgentPlanIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Toggleable task plan with lifecycle-aware uncontrolled disclosure state.
class AgentPlan extends StatefulWidget {
  const AgentPlan({
    super.key,
    required this.items,
    this.title = 'Plan',
    this.emptyLabel = 'No tasks yet',
    this.semanticLabel = 'Task plan',
    this.collapseOnComplete = true,
    this.expanded,
    this.defaultExpanded = true,
    this.onExpandedChanged,
    this.statusBuilder,
    this.statusLabelBuilder,
    this.indicatorBuilder,
    this.followOutput = true,
    this.followThreshold = 48,
    this.onFollowChanged,
    this.disclosureStyle = const DisclosureStyler.create(),
    this.style = const AgentPlanStyler.create(),
    this.styleSpec,
  });

  final List<AgentPlanItem> items;
  final String title;
  final String emptyLabel;
  final String semanticLabel;
  final bool collapseOnComplete;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final AgentPlanStatusBuilder? statusBuilder;
  final AgentPlanStatusLabelBuilder? statusLabelBuilder;
  final AgentPlanIndicatorBuilder? indicatorBuilder;
  final bool followOutput;
  final double followThreshold;
  final ValueChanged<bool>? onFollowChanged;
  final DisclosureStyler disclosureStyle;
  final AgentPlanStyler style;
  final AgentPlanSpec? styleSpec;

  int get settledCount => items.where((item) => item.status.isDone).length;
  bool get isWorking => items.any((item) => !item.status.isDone);

  @override
  State<AgentPlan> createState() => _AgentPlanState();
}

class _AgentPlanState extends State<AgentPlan> {
  late bool _uncontrolledExpanded;

  bool get _expanded => widget.expanded ?? _uncontrolledExpanded;

  @override
  void initState() {
    super.initState();
    _uncontrolledExpanded = widget.expanded ?? widget.defaultExpanded;
  }

  @override
  void didUpdateWidget(AgentPlan oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != null && widget.expanded == null) {
      _uncontrolledExpanded = oldWidget.expanded!;
    }
    final wasWorking = oldWidget.isWorking;
    final working = widget.isWorking;
    if (wasWorking && !working && widget.collapseOnComplete) {
      _request(false);
    } else if (!wasWorking && working) {
      _request(true);
    }
  }

  void _request(bool next) {
    if (widget.expanded == null && next != _uncontrolledExpanded) {
      setState(() => _uncontrolledExpanded = next);
    }
    widget.onExpandedChanged?.call(next);
  }

  String _statusLabel(AgentPlanItem item) =>
      widget.statusLabelBuilder?.call(item) ??
      switch (item.status) {
        AgentPlanItemStatus.pending => 'Pending',
        AgentPlanItemStatus.inProgress => 'In progress',
        AgentPlanItemStatus.completed => 'Completed',
        AgentPlanItemStatus.cancelled => 'Cancelled',
      };

  AgentFunctionalGlyphKind _statusGlyph(AgentPlanItemStatus status) =>
      switch (status) {
        AgentPlanItemStatus.pending => .pending,
        AgentPlanItemStatus.inProgress => .active,
        AgentPlanItemStatus.completed => .completed,
        AgentPlanItemStatus.cancelled => .cancelled,
      };

  StyleSpec<BoxSpec> _statusContainer(
    AgentPlanSpec spec,
    AgentPlanItemStatus status,
  ) => switch (status) {
    AgentPlanItemStatus.pending => spec.pendingItem,
    AgentPlanItemStatus.inProgress => spec.activeItem,
    AgentPlanItemStatus.completed => spec.completedItem,
    AgentPlanItemStatus.cancelled => spec.cancelledItem,
  };

  StyleSpec<IconSpec> _statusStyle(
    AgentPlanSpec spec,
    AgentPlanItemStatus status,
  ) => switch (status) {
    AgentPlanItemStatus.pending => spec.pendingStatus,
    AgentPlanItemStatus.inProgress => spec.activeStatus,
    AgentPlanItemStatus.completed => spec.completedStatus,
    AgentPlanItemStatus.cancelled => spec.cancelledStatus,
  };

  Widget _defaultStatus(
    BuildContext context,
    AgentPlanSpec spec,
    AgentPlanItem item,
  ) {
    return StyleSpecBuilder<IconSpec>(
      styleSpec: _statusStyle(spec, item.status),
      builder: (context, iconSpec) =>
          AgentFunctionalGlyph(kind: _statusGlyph(item.status), spec: iconSpec),
    );
  }

  Widget _indicator(BuildContext context, AgentPlanSpec spec, bool expanded) =>
      agentDisclosureIndicator(
        context,
        styleSpec: spec.indicator,
        expanded: expanded,
        builder: widget.indicatorBuilder,
      );

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<AgentPlanSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        child: RemixDisclosure(
          expanded: _expanded,
          onExpandedChanged: _request,
          semanticLabel: widget.title,
          style: widget.disclosureStyle,
          triggerBuilder: (context, state, trigger) => Row(
            children: [
              Expanded(child: trigger!),
              _indicator(context, spec, state.isExpanded),
            ],
          ),
          trigger: Row(
            children: [
              Expanded(
                child: StyledText(widget.title, styleSpec: spec.summaryTitle),
              ),
              StyledText(
                '${widget.settledCount}/${widget.items.length}',
                styleSpec: spec.count,
              ),
            ],
          ),
          content: Box(
            styleSpec: spec.viewport,
            child: widget.items.isEmpty
                ? StyledText(widget.emptyLabel, styleSpec: spec.itemDetail)
                : AgentLiveEdgeScrollView(
                    followOutput: widget.followOutput,
                    followThreshold: widget.followThreshold,
                    onFollowChanged: widget.onFollowChanged,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final item in widget.items)
                          Semantics(
                            container: true,
                            excludeSemantics: true,
                            label: [
                              item.title,
                              if (item.detail != null) item.detail!,
                              _statusLabel(item),
                            ].join(', '),
                            child: Box(
                              styleSpec: _statusContainer(spec, item.status),
                              child: RowBox(
                                key: ValueKey('agent-plan-item-${item.id}'),
                                styleSpec: spec.item,
                                children: [
                                  widget.statusBuilder?.call(context, item) ??
                                      _defaultStatus(context, spec, item),
                                  Expanded(
                                    child: StyledText(
                                      item.title,
                                      styleSpec: spec.itemTitle,
                                    ),
                                  ),
                                  if (item.detail != null)
                                    StyledText(
                                      item.detail!,
                                      styleSpec: spec.itemDetail,
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

@MixableSpec(target: AgentPlan.new)
@immutable
final class AgentPlanSpec with _$AgentPlanSpec {
  @override
  final StyleSpec<BoxSpec> viewport;
  @override
  final StyleSpec<FlexBoxSpec> item;
  @override
  final StyleSpec<TextSpec> summaryTitle;
  @override
  final StyleSpec<TextSpec> itemTitle;
  @override
  final StyleSpec<TextSpec> itemDetail;
  @override
  final StyleSpec<TextSpec> count;
  @override
  final StyleSpec<IconSpec> indicator;
  @override
  final StyleSpec<BoxSpec> pendingItem;
  @override
  final StyleSpec<BoxSpec> activeItem;
  @override
  final StyleSpec<BoxSpec> completedItem;
  @override
  final StyleSpec<BoxSpec> cancelledItem;
  @override
  final StyleSpec<IconSpec> pendingStatus;
  @override
  final StyleSpec<IconSpec> activeStatus;
  @override
  final StyleSpec<IconSpec> completedStatus;
  @override
  final StyleSpec<IconSpec> cancelledStatus;

  const AgentPlanSpec({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<FlexBoxSpec>? item,
    StyleSpec<TextSpec>? summaryTitle,
    StyleSpec<TextSpec>? itemTitle,
    StyleSpec<TextSpec>? itemDetail,
    StyleSpec<TextSpec>? count,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingItem,
    StyleSpec<BoxSpec>? activeItem,
    StyleSpec<BoxSpec>? completedItem,
    StyleSpec<BoxSpec>? cancelledItem,
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
    StyleSpec<IconSpec>? cancelledStatus,
  }) : viewport = viewport ?? const StyleSpec(spec: BoxSpec()),
       item = item ?? const StyleSpec(spec: FlexBoxSpec()),
       summaryTitle = summaryTitle ?? const StyleSpec(spec: TextSpec()),
       itemTitle = itemTitle ?? const StyleSpec(spec: TextSpec()),
       itemDetail = itemDetail ?? const StyleSpec(spec: TextSpec()),
       count = count ?? const StyleSpec(spec: TextSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       pendingItem = pendingItem ?? const StyleSpec(spec: BoxSpec()),
       activeItem = activeItem ?? const StyleSpec(spec: BoxSpec()),
       completedItem = completedItem ?? const StyleSpec(spec: BoxSpec()),
       cancelledItem = cancelledItem ?? const StyleSpec(spec: BoxSpec()),
       pendingStatus = pendingStatus ?? const StyleSpec(spec: IconSpec()),
       activeStatus = activeStatus ?? const StyleSpec(spec: IconSpec()),
       completedStatus = completedStatus ?? const StyleSpec(spec: IconSpec()),
       cancelledStatus = cancelledStatus ?? const StyleSpec(spec: IconSpec());
}
