import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/plan_item.dart';
import '../models/statuses.dart';
import '../support/disclosure.dart';
import '../support/functional_glyph.dart';
import '../support/live_edge.dart';

part 'plan.g.dart';

typedef PlaygroundPlanStatusBuilder =
    Widget Function(BuildContext context, PlaygroundPlanItem item);
typedef PlaygroundPlanStatusLabelBuilder =
    String Function(PlaygroundPlanItem item);
typedef PlaygroundPlanIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Toggleable task plan with lifecycle-aware uncontrolled disclosure state.
class PlaygroundPlan extends StatefulWidget {
  const PlaygroundPlan({
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
    this.style = const PlaygroundPlanStyler.create(),
    this.styleSpec,
  });

  final List<PlaygroundPlanItem> items;
  final String title;
  final String emptyLabel;
  final String semanticLabel;
  final bool collapseOnComplete;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final PlaygroundPlanStatusBuilder? statusBuilder;
  final PlaygroundPlanStatusLabelBuilder? statusLabelBuilder;
  final PlaygroundPlanIndicatorBuilder? indicatorBuilder;
  final bool followOutput;
  final double followThreshold;
  final ValueChanged<bool>? onFollowChanged;
  final DisclosureStyler disclosureStyle;
  final PlaygroundPlanStyler style;
  final PlaygroundPlanSpec? styleSpec;

  int get settledCount => items.where((item) => item.status.isDone).length;
  bool get isWorking => items.any((item) => !item.status.isDone);

  @override
  State<PlaygroundPlan> createState() => _PlaygroundPlanState();
}

class _PlaygroundPlanState extends State<PlaygroundPlan> {
  late final PlaygroundDisclosureEngine _disclosure;

  bool get _expanded => _disclosure.value;

  @override
  void initState() {
    super.initState();
    _disclosure = PlaygroundDisclosureEngine(
      value: widget.expanded,
      defaultValue: widget.defaultExpanded,
    );
  }

  @override
  void didUpdateWidget(PlaygroundPlan oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disclosure.reconcile(widget.expanded);
    final wasWorking = oldWidget.isWorking;
    final working = widget.isWorking;
    if (wasWorking && !working && widget.collapseOnComplete) {
      _request(false);
    } else if (!wasWorking && working) {
      _request(true);
    }
  }

  void _request(bool next) {
    if (_disclosure.request(next)) setState(() {});
    widget.onExpandedChanged?.call(next);
  }

  String _statusLabel(PlaygroundPlanItem item) =>
      widget.statusLabelBuilder?.call(item) ??
      switch (item.status) {
        PlaygroundPlanItemStatus.pending => 'Pending',
        PlaygroundPlanItemStatus.inProgress => 'In progress',
        PlaygroundPlanItemStatus.completed => 'Completed',
        PlaygroundPlanItemStatus.cancelled => 'Cancelled',
      };

  PlaygroundFunctionalGlyphKind _statusGlyph(PlaygroundPlanItemStatus status) =>
      switch (status) {
        PlaygroundPlanItemStatus.pending => .pending,
        PlaygroundPlanItemStatus.inProgress => .active,
        PlaygroundPlanItemStatus.completed => .completed,
        PlaygroundPlanItemStatus.cancelled => .cancelled,
      };

  StyleSpec<BoxSpec> _statusContainer(
    PlaygroundPlanSpec spec,
    PlaygroundPlanItemStatus status,
  ) => switch (status) {
    PlaygroundPlanItemStatus.pending => spec.pendingItem,
    PlaygroundPlanItemStatus.inProgress => spec.activeItem,
    PlaygroundPlanItemStatus.completed => spec.completedItem,
    PlaygroundPlanItemStatus.cancelled => spec.cancelledItem,
  };

  StyleSpec<IconSpec> _statusStyle(
    PlaygroundPlanSpec spec,
    PlaygroundPlanItemStatus status,
  ) => switch (status) {
    PlaygroundPlanItemStatus.pending => spec.pendingStatus,
    PlaygroundPlanItemStatus.inProgress => spec.activeStatus,
    PlaygroundPlanItemStatus.completed => spec.completedStatus,
    PlaygroundPlanItemStatus.cancelled => spec.cancelledStatus,
  };

  Widget _defaultStatus(
    BuildContext context,
    PlaygroundPlanSpec spec,
    PlaygroundPlanItem item,
  ) {
    return StyleSpecBuilder<IconSpec>(
      styleSpec: _statusStyle(spec, item.status),
      builder: (context, iconSpec) => PlaygroundFunctionalGlyph(
        kind: _statusGlyph(item.status),
        spec: iconSpec,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<PlaygroundPlanSpec>(
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
              PlaygroundDisclosureIndicator(
                styleSpec: spec.indicator,
                expanded: state.isExpanded,
                builder: widget.indicatorBuilder,
              ),
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
                : PlaygroundLiveEdgeScrollView(
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
                                key: ValueKey(
                                  'playground-plan-item-${item.id}',
                                ),
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

@MixableSpec(target: PlaygroundPlan.new)
@immutable
final class PlaygroundPlanSpec with _$PlaygroundPlanSpec {
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

  const PlaygroundPlanSpec({
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
