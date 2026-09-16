import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../support/disclosure.dart';
import '../support/functional_glyph.dart';

part 'permission.g.dart';

typedef PlaygroundPermissionStatusLabelBuilder =
    String Function(PlaygroundPermissionStatus status);
typedef PlaygroundPermissionStatusBuilder =
    Widget Function(BuildContext context, PlaygroundPermissionStatus status);
typedef PlaygroundPermissionIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// In-transcript permission request composed from Remix controls.
class PlaygroundPermission extends StatefulWidget {
  const PlaygroundPermission({
    super.key,
    required this.tool,
    this.requestId,
    this.title = 'Allow this tool to run?',
    this.description,
    this.status = PlaygroundPermissionStatus.pending,
    this.parameters = const [],
    this.showParameters = true,
    this.detailsExpanded,
    this.defaultDetailsExpanded = false,
    this.onDetailsExpandedChanged,
    this.onAllowOnce,
    this.onAlwaysAllow,
    this.onDeny,
    this.statusLabelBuilder,
    this.statusBuilder,
    this.indicatorBuilder,
    this.allowOnceLabel = 'Allow once',
    this.alwaysAllowLabel = 'Always allow',
    this.denyLabel = 'Deny',
    this.detailsLabel = 'View details',
    this.semanticLabel = 'Tool permission',
    this.parameterOrientation = Axis.horizontal,
    this.surfaceStyle = const CardStyler.create(),
    this.detailsStyle = const DisclosureStyler.create(),
    this.parametersStyle = const DataListStyler.create(),
    this.allowOnceStyle = const ButtonStyler.create(),
    this.alwaysAllowStyle = const ButtonStyler.create(),
    this.denyStyle = const ButtonStyler.create(),
    this.style = const PlaygroundPermissionStyler.create(),
    this.styleSpec,
  });

  final Object? requestId;
  final String tool;
  final String title;
  final String? description;
  final PlaygroundPermissionStatus status;
  final List<RemixDataListItem> parameters;
  final bool showParameters;
  final bool? detailsExpanded;
  final bool defaultDetailsExpanded;
  final ValueChanged<bool>? onDetailsExpandedChanged;
  final VoidCallback? onAllowOnce;
  final VoidCallback? onAlwaysAllow;
  final VoidCallback? onDeny;
  final PlaygroundPermissionStatusLabelBuilder? statusLabelBuilder;
  final PlaygroundPermissionStatusBuilder? statusBuilder;
  final PlaygroundPermissionIndicatorBuilder? indicatorBuilder;
  final String allowOnceLabel;
  final String alwaysAllowLabel;
  final String denyLabel;
  final String detailsLabel;
  final String semanticLabel;
  final Axis parameterOrientation;
  final CardStyler surfaceStyle;
  final DisclosureStyler detailsStyle;
  final DataListStyler parametersStyle;
  final ButtonStyler allowOnceStyle;
  final ButtonStyler alwaysAllowStyle;
  final ButtonStyler denyStyle;
  final PlaygroundPermissionStyler style;
  final PlaygroundPermissionSpec? styleSpec;

  @override
  State<PlaygroundPermission> createState() => _PlaygroundPermissionState();
}

class _PlaygroundPermissionState extends State<PlaygroundPermission> {
  late final PlaygroundDisclosureEngine _disclosure;
  bool _decisionSubmitted = false;

  bool get _detailsExpanded => _disclosure.value;

  @override
  void initState() {
    super.initState();
    _disclosure = PlaygroundDisclosureEngine(
      value: widget.detailsExpanded,
      defaultValue:
          widget.status.keepsDetailsOpen || widget.defaultDetailsExpanded,
    );
  }

  @override
  void didUpdateWidget(PlaygroundPermission oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disclosure.reconcile(widget.detailsExpanded);
    final returnedToPending =
        oldWidget.status != PlaygroundPermissionStatus.pending &&
        widget.status == PlaygroundPermissionStatus.pending;
    final newPendingRequest =
        oldWidget.requestId != widget.requestId &&
        widget.status == PlaygroundPermissionStatus.pending;
    if (returnedToPending || newPendingRequest) _decisionSubmitted = false;

    if (!oldWidget.status.keepsDetailsOpen && widget.status.keepsDetailsOpen) {
      _requestDetails(true);
    } else if (!oldWidget.status.isSettled && widget.status.isSettled) {
      _requestDetails(false);
    }
  }

  void _requestDetails(bool next) {
    if (_disclosure.request(next)) setState(() {});
    widget.onDetailsExpandedChanged?.call(next);
  }

  void _submit(VoidCallback? callback) {
    if (_decisionSubmitted ||
        widget.status != PlaygroundPermissionStatus.pending ||
        callback == null) {
      return;
    }
    setState(() => _decisionSubmitted = true);
    callback();
  }

  String get _statusLabel =>
      widget.statusLabelBuilder?.call(widget.status) ??
      switch (widget.status) {
        PlaygroundPermissionStatus.pending => 'Permission required',
        PlaygroundPermissionStatus.deciding => 'Recording',
        PlaygroundPermissionStatus.allowed => 'Allowed',
        PlaygroundPermissionStatus.running => 'Running',
        PlaygroundPermissionStatus.complete => 'Complete',
        PlaygroundPermissionStatus.denied => 'Denied',
        PlaygroundPermissionStatus.error => 'Error',
      };

  PlaygroundFunctionalGlyphKind get _statusGlyph => switch (widget.status) {
    PlaygroundPermissionStatus.pending => .permission,
    PlaygroundPermissionStatus.deciding => .loading,
    PlaygroundPermissionStatus.allowed => .completed,
    PlaygroundPermissionStatus.running => .loading,
    PlaygroundPermissionStatus.complete => .completed,
    PlaygroundPermissionStatus.denied => .cancelled,
    PlaygroundPermissionStatus.error => .error,
  };

  StyleSpec<BoxSpec> _statusContainer(PlaygroundPermissionSpec spec) =>
      switch (widget.status) {
        PlaygroundPermissionStatus.pending => spec.pendingStatus,
        PlaygroundPermissionStatus.deciding => spec.decidingStatus,
        PlaygroundPermissionStatus.allowed => spec.allowedStatus,
        PlaygroundPermissionStatus.running => spec.runningStatus,
        PlaygroundPermissionStatus.complete => spec.completedStatus,
        PlaygroundPermissionStatus.denied => spec.deniedStatus,
        PlaygroundPermissionStatus.error => spec.errorStatus,
      };

  // Horizontal by default; callers may stack actions without losing the
  // action slot's box, modifiers, or nested style resolution.
  StyleSpec<FlexBoxSpec> _actionsStyle(PlaygroundPermissionSpec spec) {
    final actions = spec.actions.spec;
    final flex = actions.flex ?? const StyleSpec(spec: FlexSpec());
    return spec.actions.copyWith(
      spec: actions.copyWith(
        flex: flex.copyWith(
          spec: flex.spec.copyWith(
            direction: flex.spec.direction ?? Axis.horizontal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<PlaygroundPermissionSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        child: RemixCard(
          style: widget.surfaceStyle,
          child: Box(
            styleSpec: spec.content,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RowBox(
                  styleSpec: spec.header,
                  children: [
                    StyleSpecBuilder<IconSpec>(
                      styleSpec: spec.toolIcon,
                      builder: (context, iconSpec) => PlaygroundFunctionalGlyph(
                        kind: .tool,
                        spec: iconSpec,
                      ),
                    ),
                    Expanded(
                      child: StyledText(widget.title, styleSpec: spec.title),
                    ),
                  ],
                ),
                StyledText(widget.tool, styleSpec: spec.tool),
                if (widget.description != null)
                  StyledText(widget.description!, styleSpec: spec.description),
                Box(
                  styleSpec: _statusContainer(spec),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.statusBuilder?.call(context, widget.status) ??
                          StyleSpecBuilder<IconSpec>(
                            styleSpec: spec.statusIcon,
                            builder: (context, iconSpec) =>
                                PlaygroundFunctionalGlyph(
                                  kind: _statusGlyph,
                                  spec: iconSpec,
                                ),
                          ),
                      Flexible(
                        child: StyledText(_statusLabel, styleSpec: spec.status),
                      ),
                    ],
                  ),
                ),
                if (widget.showParameters && widget.parameters.isNotEmpty)
                  RemixDisclosure(
                    expanded: _detailsExpanded,
                    onExpandedChanged: _requestDetails,
                    semanticLabel: widget.detailsLabel,
                    style: widget.detailsStyle,
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
                    trigger: StyledText(
                      widget.detailsLabel,
                      styleSpec: spec.detailsLabel,
                    ),
                    content: RemixDataList(
                      items: widget.parameters,
                      orientation: widget.parameterOrientation,
                      style: widget.parametersStyle,
                    ),
                  ),
                if (widget.status == PlaygroundPermissionStatus.pending)
                  FlexBox(
                    styleSpec: _actionsStyle(spec),
                    children: [
                      RemixButton(
                        key: const ValueKey('playground-permission-allow-once'),
                        label: widget.allowOnceLabel,
                        enabled: !_decisionSubmitted,
                        onPressed: widget.onAllowOnce == null
                            ? null
                            : () => _submit(widget.onAllowOnce),
                        style: widget.allowOnceStyle,
                      ),
                      if (widget.onAlwaysAllow != null)
                        RemixButton(
                          key: const ValueKey(
                            'playground-permission-always-allow',
                          ),
                          label: widget.alwaysAllowLabel,
                          enabled: !_decisionSubmitted,
                          onPressed: () => _submit(widget.onAlwaysAllow),
                          style: widget.alwaysAllowStyle,
                        ),
                      RemixButton(
                        key: const ValueKey('playground-permission-deny'),
                        label: widget.denyLabel,
                        enabled: !_decisionSubmitted,
                        onPressed: widget.onDeny == null
                            ? null
                            : () => _submit(widget.onDeny),
                        style: widget.denyStyle,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@MixableSpec(target: PlaygroundPermission.new)
@immutable
final class PlaygroundPermissionSpec with _$PlaygroundPermissionSpec {
  @override
  final StyleSpec<BoxSpec> content;
  @override
  final StyleSpec<FlexBoxSpec> header;
  @override
  final StyleSpec<FlexBoxSpec> actions;
  @override
  final StyleSpec<TextSpec> title;
  @override
  final StyleSpec<TextSpec> tool;
  @override
  final StyleSpec<TextSpec> description;
  @override
  final StyleSpec<TextSpec> status;
  @override
  final StyleSpec<TextSpec> detailsLabel;
  @override
  final StyleSpec<IconSpec> toolIcon;
  @override
  final StyleSpec<IconSpec> statusIcon;
  @override
  final StyleSpec<IconSpec> indicator;
  @override
  final StyleSpec<BoxSpec> pendingStatus;
  @override
  final StyleSpec<BoxSpec> decidingStatus;
  @override
  final StyleSpec<BoxSpec> allowedStatus;
  @override
  final StyleSpec<BoxSpec> runningStatus;
  @override
  final StyleSpec<BoxSpec> completedStatus;
  @override
  final StyleSpec<BoxSpec> deniedStatus;
  @override
  final StyleSpec<BoxSpec> errorStatus;

  const PlaygroundPermissionSpec({
    StyleSpec<BoxSpec>? content,
    StyleSpec<FlexBoxSpec>? header,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? tool,
    StyleSpec<TextSpec>? description,
    StyleSpec<TextSpec>? status,
    StyleSpec<TextSpec>? detailsLabel,
    StyleSpec<IconSpec>? toolIcon,
    StyleSpec<IconSpec>? statusIcon,
    StyleSpec<IconSpec>? indicator,
    StyleSpec<BoxSpec>? pendingStatus,
    StyleSpec<BoxSpec>? decidingStatus,
    StyleSpec<BoxSpec>? allowedStatus,
    StyleSpec<BoxSpec>? runningStatus,
    StyleSpec<BoxSpec>? completedStatus,
    StyleSpec<BoxSpec>? deniedStatus,
    StyleSpec<BoxSpec>? errorStatus,
  }) : content = content ?? const StyleSpec(spec: BoxSpec()),
       header = header ?? const StyleSpec(spec: FlexBoxSpec()),
       actions = actions ?? const StyleSpec(spec: FlexBoxSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       tool = tool ?? const StyleSpec(spec: TextSpec()),
       description = description ?? const StyleSpec(spec: TextSpec()),
       status = status ?? const StyleSpec(spec: TextSpec()),
       detailsLabel = detailsLabel ?? const StyleSpec(spec: TextSpec()),
       toolIcon = toolIcon ?? const StyleSpec(spec: IconSpec()),
       statusIcon = statusIcon ?? const StyleSpec(spec: IconSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec()),
       pendingStatus = pendingStatus ?? const StyleSpec(spec: BoxSpec()),
       decidingStatus = decidingStatus ?? const StyleSpec(spec: BoxSpec()),
       allowedStatus = allowedStatus ?? const StyleSpec(spec: BoxSpec()),
       runningStatus = runningStatus ?? const StyleSpec(spec: BoxSpec()),
       completedStatus = completedStatus ?? const StyleSpec(spec: BoxSpec()),
       deniedStatus = deniedStatus ?? const StyleSpec(spec: BoxSpec()),
       errorStatus = errorStatus ?? const StyleSpec(spec: BoxSpec());
}
