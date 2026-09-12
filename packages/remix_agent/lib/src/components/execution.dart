import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../style/functional_glyph.dart';
import '../style/live_edge.dart';

part 'execution.g.dart';

typedef AgentExecutionStatusLabelBuilder =
    String Function(AgentExecutionStatus status);
typedef AgentExecutionStatusBuilder =
    Widget Function(BuildContext context, AgentExecutionStatus status);
typedef AgentExecutionIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Toggleable tool execution output with lifecycle-driven open requests.
class AgentExecution extends StatefulWidget {
  const AgentExecution({
    super.key,
    required this.tool,
    required this.title,
    required this.child,
    this.status = AgentExecutionStatus.running,
    this.meta,
    this.icon,
    this.onCopy,
    this.onRetry,
    this.copyIconBuilder,
    this.retryIconBuilder,
    this.indicatorBuilder,
    this.statusBuilder,
    this.statusLabelBuilder,
    this.copyLabel = 'Copy output',
    this.retryLabel = 'Retry execution',
    this.outputLabel = 'Tool output',
    this.showActions = true,
    this.collapseOnComplete = true,
    this.expanded,
    this.defaultExpanded = true,
    this.onExpandedChanged,
    this.semanticLabel = 'Tool execution',
    this.surfaceStyle = const CardStyler.create(),
    this.disclosureStyle = const DisclosureStyler.create(),
    this.copyStyle = const IconButtonStyler.create(),
    this.retryStyle = const IconButtonStyler.create(),
    this.style = const AgentExecutionStyler.create(),
    this.styleSpec,
  });

  final String tool;
  final String title;
  final Widget child;
  final AgentExecutionStatus status;
  final String? meta;
  final Widget? icon;
  final VoidCallback? onCopy;
  final VoidCallback? onRetry;
  final RemixIconButtonIconBuilder? copyIconBuilder;
  final RemixIconButtonIconBuilder? retryIconBuilder;
  final AgentExecutionIndicatorBuilder? indicatorBuilder;
  final AgentExecutionStatusBuilder? statusBuilder;
  final AgentExecutionStatusLabelBuilder? statusLabelBuilder;
  final String copyLabel;
  final String retryLabel;
  final String outputLabel;
  final bool showActions;
  final bool collapseOnComplete;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final String semanticLabel;
  final CardStyler surfaceStyle;
  final DisclosureStyler disclosureStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
  final AgentExecutionStyler style;
  final AgentExecutionSpec? styleSpec;

  @override
  State<AgentExecution> createState() => _AgentExecutionState();
}

class _AgentExecutionState extends State<AgentExecution> {
  late bool _uncontrolledExpanded;

  bool get _expanded => widget.expanded ?? _uncontrolledExpanded;

  @override
  void initState() {
    super.initState();
    _uncontrolledExpanded = widget.expanded ?? widget.defaultExpanded;
  }

  @override
  void didUpdateWidget(AgentExecution oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != null && widget.expanded == null) {
      _uncontrolledExpanded = oldWidget.expanded!;
    }
    if (!oldWidget.status.isWorking && widget.status.isWorking) {
      _request(true);
    } else if (oldWidget.status.isWorking &&
        !widget.status.isWorking &&
        widget.collapseOnComplete) {
      _request(false);
    }
  }

  void _request(bool next) {
    if (widget.expanded == null && next != _uncontrolledExpanded) {
      setState(() => _uncontrolledExpanded = next);
    }
    widget.onExpandedChanged?.call(next);
  }

  String get _statusLabel =>
      widget.statusLabelBuilder?.call(widget.status) ??
      switch (widget.status) {
        AgentExecutionStatus.running => 'Running',
        AgentExecutionStatus.success => 'Completed',
        AgentExecutionStatus.error => 'Failed',
        AgentExecutionStatus.cancelled => 'Cancelled',
      };

  StyleSpec<BoxSpec> _statusContainer(AgentExecutionSpec spec) =>
      switch (widget.status) {
        AgentExecutionStatus.running => spec.runningStatus,
        AgentExecutionStatus.success => spec.successStatus,
        AgentExecutionStatus.error => spec.errorStatus,
        AgentExecutionStatus.cancelled => spec.cancelledStatus,
      };

  AgentFunctionalGlyphKind get _statusGlyph => switch (widget.status) {
    AgentExecutionStatus.running => .loading,
    AgentExecutionStatus.success => .completedCircle,
    AgentExecutionStatus.error => .errorCircle,
    AgentExecutionStatus.cancelled => .cancelledCircle,
  };

  Widget _indicator(
    BuildContext context,
    AgentExecutionSpec spec,
    bool expanded,
  ) => agentDisclosureIndicator(
    context,
    styleSpec: spec.indicator,
    expanded: expanded,
    builder: widget.indicatorBuilder,
  );

  Widget _toolIcon(AgentExecutionSpec spec) {
    final icon = widget.icon;
    if (icon != null) return icon;
    return StyleSpecBuilder<IconSpec>(
      styleSpec: spec.toolIcon,
      builder: (context, iconSpec) =>
          AgentFunctionalGlyph(kind: .tool, spec: iconSpec),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<AgentExecutionSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        value: '${widget.tool}, $_statusLabel',
        child: RemixCard(
          style: widget.surfaceStyle,
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
            trigger: RowBox(
              styleSpec: spec.header,
              children: [
                _toolIcon(spec),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText(widget.title, styleSpec: spec.title),
                      StyledText(widget.tool, styleSpec: spec.tool),
                    ],
                  ),
                ),
                if (widget.meta != null)
                  StyledText(widget.meta!, styleSpec: spec.meta),
                Box(
                  styleSpec: _statusContainer(spec),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.statusBuilder?.call(context, widget.status) ??
                          StyleSpecBuilder<IconSpec>(
                            styleSpec: spec.statusIcon,
                            builder: (context, iconSpec) =>
                                AgentFunctionalGlyph(
                                  kind: _statusGlyph,
                                  spec: iconSpec,
                                ),
                          ),
                      StyledText(_statusLabel, styleSpec: spec.status),
                    ],
                  ),
                ),
              ],
            ),
            content: Box(
              styleSpec: spec.output,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Deliberately not an AgentTranscript. That installs
                  // Arrow/Page/Home/End shortcuts and its own Semantics
                  // container, and an execution card is normally nested inside
                  // a host transcript: the inner list shrink-wraps to a zero
                  // scroll extent but its action still consumes those intents,
                  // so focus landing here stopped the outer transcript from
                  // scrolling, and its `busy` value announced the status a
                  // second time. This is the primitive plan and activity use.
                  Semantics(
                    label: widget.outputLabel,
                    child: AgentLiveEdgeScrollView(
                      followOutput: widget.status.isWorking,
                      child: widget.child,
                    ),
                  ),
                  if (widget.showActions && widget.status.isSettled)
                    RowBox(
                      styleSpec: spec.actions,
                      children: [
                        if (widget.onCopy != null)
                          RemixIconButton(
                            icon: null,
                            iconBuilder:
                                widget.copyIconBuilder ??
                                (context, iconSpec, icon) =>
                                    AgentFunctionalGlyph(
                                      kind: .copy,
                                      spec: iconSpec,
                                    ),
                            semanticLabel: widget.copyLabel,
                            onPressed: widget.onCopy,
                            style: widget.copyStyle,
                          ),
                        if (widget.onRetry != null)
                          RemixIconButton(
                            icon: null,
                            iconBuilder:
                                widget.retryIconBuilder ??
                                (context, iconSpec, icon) =>
                                    AgentFunctionalGlyph(
                                      kind: .retry,
                                      spec: iconSpec,
                                    ),
                            semanticLabel: widget.retryLabel,
                            onPressed: widget.onRetry,
                            style: widget.retryStyle,
                          ),
                      ],
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

@MixableSpec(target: AgentExecution.new)
@immutable
final class AgentExecutionSpec with _$AgentExecutionSpec {
  @override
  final StyleSpec<FlexBoxSpec> header;
  @override
  final StyleSpec<BoxSpec> output;
  @override
  final StyleSpec<FlexBoxSpec> actions;
  @override
  final StyleSpec<TextSpec> tool;
  @override
  final StyleSpec<TextSpec> title;
  @override
  final StyleSpec<TextSpec> meta;
  @override
  final StyleSpec<TextSpec> status;
  @override
  final StyleSpec<IconSpec> toolIcon;
  @override
  final StyleSpec<IconSpec> statusIcon;
  @override
  final StyleSpec<IconSpec> indicator;
  @override
  final StyleSpec<BoxSpec> runningStatus;
  @override
  final StyleSpec<BoxSpec> successStatus;
  @override
  final StyleSpec<BoxSpec> errorStatus;
  @override
  final StyleSpec<BoxSpec> cancelledStatus;

  const AgentExecutionSpec({
    StyleSpec<FlexBoxSpec>? header,
    StyleSpec<BoxSpec>? output,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<TextSpec>? tool,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? meta,
    StyleSpec<TextSpec>? status,
    StyleSpec<IconSpec>? toolIcon,
    StyleSpec<IconSpec>? statusIcon,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? runningStatus,
    StyleSpec<BoxSpec>? successStatus,
    StyleSpec<BoxSpec>? errorStatus,
    StyleSpec<BoxSpec>? cancelledStatus,
  }) : header = header ?? const StyleSpec(spec: FlexBoxSpec()),
       output = output ?? const StyleSpec(spec: BoxSpec()),
       actions = actions ?? const StyleSpec(spec: FlexBoxSpec()),
       tool = tool ?? const StyleSpec(spec: TextSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       meta = meta ?? const StyleSpec(spec: TextSpec()),
       status = status ?? const StyleSpec(spec: TextSpec()),
       toolIcon = toolIcon ?? const StyleSpec(spec: IconSpec()),
       statusIcon = statusIcon ?? const StyleSpec(spec: IconSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       runningStatus = runningStatus ?? const StyleSpec(spec: BoxSpec()),
       successStatus = successStatus ?? const StyleSpec(spec: BoxSpec()),
       errorStatus = errorStatus ?? const StyleSpec(spec: BoxSpec()),
       cancelledStatus = cancelledStatus ?? const StyleSpec(spec: BoxSpec());
}
