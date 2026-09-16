import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../support/disclosure.dart';
import '../support/functional_glyph.dart';
import '../support/live_edge.dart';

part 'execution.g.dart';

typedef UiExecutionStatusLabelBuilder =
    String Function(UiExecutionStatus status);
typedef UiExecutionStatusBuilder =
    Widget Function(BuildContext context, UiExecutionStatus status);
typedef UiExecutionIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Toggleable tool execution output with lifecycle-driven open requests.
class UiExecution extends StatefulWidget {
  const UiExecution({
    super.key,
    required this.tool,
    required this.title,
    required this.child,
    this.status = UiExecutionStatus.running,
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
    this.style = const UiExecutionStyler.create(),
    this.styleSpec,
  });

  final String tool;
  final String title;
  final Widget child;
  final UiExecutionStatus status;
  final String? meta;
  final Widget? icon;
  final VoidCallback? onCopy;
  final VoidCallback? onRetry;
  final RemixIconButtonIconBuilder? copyIconBuilder;
  final RemixIconButtonIconBuilder? retryIconBuilder;
  final UiExecutionIndicatorBuilder? indicatorBuilder;
  final UiExecutionStatusBuilder? statusBuilder;
  final UiExecutionStatusLabelBuilder? statusLabelBuilder;
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
  final UiExecutionStyler style;
  final UiExecutionSpec? styleSpec;

  @override
  State<UiExecution> createState() => _UiExecutionState();
}

class _UiExecutionState extends State<UiExecution> {
  late final UiDisclosureEngine _disclosure;

  bool get _expanded => _disclosure.value;

  @override
  void initState() {
    super.initState();
    _disclosure = UiDisclosureEngine(
      value: widget.expanded,
      defaultValue: widget.defaultExpanded,
    );
  }

  @override
  void didUpdateWidget(UiExecution oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disclosure.reconcile(widget.expanded);
    if (!oldWidget.status.isWorking && widget.status.isWorking) {
      _request(true);
    } else if (oldWidget.status.isWorking &&
        !widget.status.isWorking &&
        widget.collapseOnComplete) {
      _request(false);
    }
  }

  void _request(bool next) {
    if (_disclosure.request(next)) setState(() {});
    widget.onExpandedChanged?.call(next);
  }

  String get _statusLabel =>
      widget.statusLabelBuilder?.call(widget.status) ??
      switch (widget.status) {
        UiExecutionStatus.running => 'Running',
        UiExecutionStatus.success => 'Completed',
        UiExecutionStatus.error => 'Failed',
        UiExecutionStatus.cancelled => 'Cancelled',
      };

  StyleSpec<BoxSpec> _statusContainer(UiExecutionSpec spec) =>
      switch (widget.status) {
        UiExecutionStatus.running => spec.runningStatus,
        UiExecutionStatus.success => spec.successStatus,
        UiExecutionStatus.error => spec.errorStatus,
        UiExecutionStatus.cancelled => spec.cancelledStatus,
      };

  UiFunctionalGlyphKind get _statusGlyph => switch (widget.status) {
    UiExecutionStatus.running => .loading,
    UiExecutionStatus.success => .completedCircle,
    UiExecutionStatus.error => .errorCircle,
    UiExecutionStatus.cancelled => .cancelledCircle,
  };

  Widget _toolIcon(UiExecutionSpec spec) {
    final icon = widget.icon;
    if (icon != null) return icon;
    return StyleSpecBuilder<IconSpec>(
      styleSpec: spec.toolIcon,
      builder: (context, iconSpec) =>
          UiFunctionalGlyph(kind: .tool, spec: iconSpec),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<UiExecutionSpec>(
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
                UiDisclosureIndicator(
                  styleSpec: spec.indicator,
                  expanded: state.isExpanded,
                  builder: widget.indicatorBuilder,
                ),
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
                            builder: (context, iconSpec) => UiFunctionalGlyph(
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
                  // Deliberately not an UiTranscript. That installs
                  // Arrow/Page/Home/End shortcuts and its own Semantics
                  // container, and an execution card is normally nested inside
                  // a host transcript: the inner list shrink-wraps to a zero
                  // scroll extent but its action still consumes those intents,
                  // so focus landing here stopped the outer transcript from
                  // scrolling, and its `busy` value announced the status a
                  // second time. This is the primitive plan and activity use.
                  Semantics(
                    label: widget.outputLabel,
                    child: UiLiveEdgeScrollView(
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
                                (context, iconSpec, icon) => UiFunctionalGlyph(
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
                                (context, iconSpec, icon) => UiFunctionalGlyph(
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

@MixableSpec(target: UiExecution.new)
@immutable
final class UiExecutionSpec with _$UiExecutionSpec {
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

  const UiExecutionSpec({
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
