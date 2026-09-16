import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/activity_item.dart';
import '../models/statuses.dart';
import '../support/disclosure.dart';
import '../support/functional_glyph.dart';
import '../support/live_edge.dart';

part 'activity.g.dart';

typedef UiActivityStatusBuilder =
    Widget Function(BuildContext context, UiActivityItem item);
typedef UiActivityStatusLabelBuilder = String Function(UiActivityItem item);
typedef UiActivityIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Activity ledger that is forced open and non-toggleable only while working.
class UiActivity extends StatefulWidget {
  const UiActivity({
    super.key,
    required this.items,
    this.status = UiRunStatus.working,
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
    this.style = const UiActivityStyler.create(),
    this.styleSpec,
  });

  final List<UiActivityItem> items;
  final UiRunStatus status;
  final String title;
  final String semanticLabel;
  final bool collapseOnComplete;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final UiActivityStatusBuilder? statusBuilder;
  final UiActivityStatusLabelBuilder? statusLabelBuilder;
  final UiActivityIndicatorBuilder? indicatorBuilder;
  final bool followOutput;
  final double followThreshold;
  final ValueChanged<bool>? onFollowChanged;
  final DisclosureStyler disclosureStyle;
  final UiActivityStyler style;
  final UiActivitySpec? styleSpec;

  bool get isWorking => status == UiRunStatus.working;

  /// Number of completed rows in the activity ledger.
  int get settledCount => items
      .where((item) => item.status == UiActivityItemStatus.complete)
      .length;

  @override
  State<UiActivity> createState() => _UiActivityState();
}

class _UiActivityState extends State<UiActivity> {
  late final UiDisclosureEngine _disclosure;

  bool get _expanded => widget.isWorking ? true : (_disclosure.value);

  @override
  void initState() {
    super.initState();
    _disclosure = UiDisclosureEngine(
      value: widget.expanded,
      defaultValue: widget.defaultExpanded,
    );
  }

  @override
  void didUpdateWidget(UiActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disclosure.reconcile(widget.expanded);
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
    if (_disclosure.request(next)) setState(() {});
    widget.onExpandedChanged?.call(next);
  }

  String _statusLabel(UiActivityItem item) =>
      widget.statusLabelBuilder?.call(item) ??
      switch (item.status) {
        UiActivityItemStatus.pending => 'Pending',
        UiActivityItemStatus.active => 'Active',
        UiActivityItemStatus.complete => 'Complete',
      };

  UiFunctionalGlyphKind _statusGlyph(UiActivityItemStatus status) =>
      switch (status) {
        UiActivityItemStatus.pending => .pending,
        UiActivityItemStatus.active => .active,
        UiActivityItemStatus.complete => .completed,
      };

  StyleSpec<BoxSpec> _statusContainer(
    UiActivitySpec spec,
    UiActivityItemStatus status,
  ) => switch (status) {
    UiActivityItemStatus.pending => spec.pendingItem,
    UiActivityItemStatus.active => spec.activeItem,
    UiActivityItemStatus.complete => spec.completedItem,
  };

  StyleSpec<IconSpec> _statusStyle(
    UiActivitySpec spec,
    UiActivityItemStatus status,
  ) => switch (status) {
    UiActivityItemStatus.pending => spec.pendingStatus,
    UiActivityItemStatus.active => spec.activeStatus,
    UiActivityItemStatus.complete => spec.completedStatus,
  };

  Widget _defaultStatus(
    BuildContext context,
    UiActivitySpec spec,
    UiActivityItem item,
  ) => StyleSpecBuilder<IconSpec>(
    styleSpec: _statusStyle(spec, item.status),
    builder: (context, iconSpec) =>
        UiFunctionalGlyph(kind: _statusGlyph(item.status), spec: iconSpec),
  );

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<UiActivitySpec>(
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
              // Preserve the count alignment and expansion cue while working.
              // RemixDisclosure keeps the forced-open header non-toggleable.
              UiDisclosureIndicator(
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
            child: UiLiveEdgeScrollView(
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
                          key: ValueKey('ui-activity-item-${item.id}'),
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

@MixableSpec(target: UiActivity.new)
@immutable
final class UiActivitySpec with _$UiActivitySpec {
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
  final StyleSpec<IconSpec> pendingStatus;
  @override
  final StyleSpec<IconSpec> activeStatus;
  @override
  final StyleSpec<IconSpec> completedStatus;

  const UiActivitySpec({
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
    StyleSpec<IconSpec>? pendingStatus,
    StyleSpec<IconSpec>? activeStatus,
    StyleSpec<IconSpec>? completedStatus,
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
       pendingStatus = pendingStatus ?? const StyleSpec(spec: IconSpec()),
       activeStatus = activeStatus ?? const StyleSpec(spec: IconSpec()),
       completedStatus = completedStatus ?? const StyleSpec(spec: IconSpec());
}
