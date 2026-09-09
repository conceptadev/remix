import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/activity_item.dart';
import '../models/statuses.dart';
import '../style/functional_glyph.dart';
import '../style/live_edge.dart';
import '../style/style_builder.dart';

part 'activity.g.dart';

typedef AgentActivityStatusBuilder =
    Widget Function(BuildContext context, AgentActivityItem item);
typedef AgentActivityStatusLabelBuilder =
    String Function(AgentActivityItem item);
typedef AgentActivityIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Activity ledger that is forced open and non-toggleable only while working.
class AgentActivity extends StatefulWidget {
  const AgentActivity({
    super.key,
    required this.items,
    this.status = AgentRunStatus.working,
    this.title = 'Activity',
    this.semanticLabel = 'Activity',
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
    this.style = const AgentActivityStyler.create(),
    this.styleSpec,
  });

  final List<AgentActivityItem> items;
  final AgentRunStatus status;
  final String title;
  final String semanticLabel;
  final bool collapseOnComplete;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final AgentActivityStatusBuilder? statusBuilder;
  final AgentActivityStatusLabelBuilder? statusLabelBuilder;
  final AgentActivityIndicatorBuilder? indicatorBuilder;
  final bool followOutput;
  final double followThreshold;
  final ValueChanged<bool>? onFollowChanged;
  final DisclosureStyler disclosureStyle;
  final AgentActivityStyler style;
  final AgentActivitySpec? styleSpec;

  bool get isWorking => status == AgentRunStatus.working;

  @override
  State<AgentActivity> createState() => _AgentActivityState();
}

class _AgentActivityState extends State<AgentActivity> {
  late bool _uncontrolledExpanded;

  bool get _expanded =>
      widget.isWorking ? true : (widget.expanded ?? _uncontrolledExpanded);

  @override
  void initState() {
    super.initState();
    _uncontrolledExpanded = widget.expanded ?? widget.defaultExpanded;
  }

  @override
  void didUpdateWidget(AgentActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != null && widget.expanded == null) {
      _uncontrolledExpanded = oldWidget.expanded!;
    }
    if (!oldWidget.isWorking && widget.isWorking) {
      _request(true, lifecycle: true);
    } else if (oldWidget.isWorking &&
        !widget.isWorking &&
        widget.collapseOnComplete) {
      _request(false, lifecycle: true);
    }
  }

  void _request(bool next, {bool lifecycle = false}) {
    if (widget.isWorking && !lifecycle) return;
    if (widget.expanded == null && next != _uncontrolledExpanded) {
      setState(() => _uncontrolledExpanded = next);
    }
    widget.onExpandedChanged?.call(next);
  }

  String _statusLabel(AgentActivityItem item) =>
      widget.statusLabelBuilder?.call(item) ??
      switch (item.status) {
        AgentActivityItemStatus.pending => 'Pending',
        AgentActivityItemStatus.active => 'Active',
        AgentActivityItemStatus.complete => 'Complete',
      };

  AgentFunctionalGlyphKind _statusGlyph(AgentActivityItemStatus status) =>
      switch (status) {
        AgentActivityItemStatus.pending => .pending,
        AgentActivityItemStatus.active => .active,
        AgentActivityItemStatus.complete => .completed,
      };

  StyleSpec<BoxSpec> _statusContainer(
    AgentActivitySpec spec,
    AgentActivityItemStatus status,
  ) => switch (status) {
    AgentActivityItemStatus.pending => spec.pendingItem,
    AgentActivityItemStatus.active => spec.activeItem,
    AgentActivityItemStatus.complete => spec.completedItem,
  };

  StyleSpec<IconSpec> _statusStyle(
    AgentActivitySpec spec,
    AgentActivityItemStatus status,
  ) => switch (status) {
    AgentActivityItemStatus.pending => spec.pendingStatus,
    AgentActivityItemStatus.active => spec.activeStatus,
    AgentActivityItemStatus.complete => spec.completedStatus,
  };

  Widget _defaultStatus(
    BuildContext context,
    AgentActivitySpec spec,
    AgentActivityItem item,
  ) => StyleSpecBuilder<IconSpec>(
    styleSpec: _statusStyle(spec, item.status),
    builder: (context, iconSpec) =>
        AgentFunctionalGlyph(kind: _statusGlyph(item.status), spec: iconSpec),
  );

  Widget _indicator(
    BuildContext context,
    AgentActivitySpec spec,
    bool expanded,
  ) =>
      widget.indicatorBuilder?.call(context, expanded) ??
      StyleSpecBuilder<IconSpec>(
        styleSpec: spec.indicator,
        builder: (context, iconSpec) => AgentFunctionalGlyph(
          kind: .chevron,
          spec: iconSpec,
          expanded: expanded,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AgentStyleBuilder<AgentActivitySpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        child: RemixDisclosure(
          expanded: _expanded,
          enabled: !widget.isWorking,
          onExpandedChanged: _request,
          semanticLabel: widget.title,
          style: widget.disclosureStyle,
          triggerBuilder: (context, state, trigger) => Row(
            children: [
              Expanded(child: trigger!),
              if (!widget.isWorking)
                _indicator(context, spec, state.isExpanded),
            ],
          ),
          trigger: StyledText(widget.title, styleSpec: spec.summaryTitle),
          content: Box(
            styleSpec: spec.viewport,
            child: AgentLiveEdgeScrollView(
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
                      explicitChildNodes: true,
                      label: [
                        item.title,
                        if (item.detail != null) item.detail!,
                        _statusLabel(item),
                      ].join(', '),
                      child: Box(
                        styleSpec: _statusContainer(spec, item.status),
                        child: RowBox(
                          key: ValueKey('agent-activity-item-${item.id}'),
                          styleSpec: spec.item,
                          children: [
                            ExcludeSemantics(
                              child:
                                  widget.statusBuilder?.call(context, item) ??
                                  _defaultStatus(context, spec, item),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExcludeSemantics(
                                    child: StyledText(
                                      item.title,
                                      styleSpec: spec.itemTitle,
                                    ),
                                  ),
                                  if (item.detail != null)
                                    ExcludeSemantics(
                                      child: StyledText(
                                        item.detail!,
                                        styleSpec: spec.itemDetail,
                                      ),
                                    ),
                                  if (item.child != null) item.child!,
                                ],
                              ),
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

@MixableSpec(target: AgentActivity.new)
@immutable
final class AgentActivitySpec with _$AgentActivitySpec {
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
  final StyleSpec<IconSpec> indicator;
  @override
  final StyleSpec<BoxSpec> pendingItem;
  @override
  final StyleSpec<BoxSpec> activeItem;
  @override
  final StyleSpec<BoxSpec> completedItem;
  @override
  final StyleSpec<IconSpec> pendingStatus;
  @override
  final StyleSpec<IconSpec> activeStatus;
  @override
  final StyleSpec<IconSpec> completedStatus;

  const AgentActivitySpec({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<FlexBoxSpec>? item,
    StyleSpec<TextSpec>? summaryTitle,
    StyleSpec<TextSpec>? itemTitle,
    StyleSpec<TextSpec>? itemDetail,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingItem,
    StyleSpec<BoxSpec>? activeItem,
    StyleSpec<BoxSpec>? completedItem,
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
  }) : viewport = viewport ?? const StyleSpec(spec: BoxSpec()),
       item = item ?? const StyleSpec(spec: FlexBoxSpec()),
       summaryTitle = summaryTitle ?? const StyleSpec(spec: TextSpec()),
       itemTitle = itemTitle ?? const StyleSpec(spec: TextSpec()),
       itemDetail = itemDetail ?? const StyleSpec(spec: TextSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       pendingItem = pendingItem ?? const StyleSpec(spec: BoxSpec()),
       activeItem = activeItem ?? const StyleSpec(spec: BoxSpec()),
       completedItem = completedItem ?? const StyleSpec(spec: BoxSpec()),
       pendingStatus = pendingStatus ?? const StyleSpec(spec: IconSpec()),
       activeStatus = activeStatus ?? const StyleSpec(spec: IconSpec()),
       completedStatus = completedStatus ?? const StyleSpec(spec: IconSpec());
}
