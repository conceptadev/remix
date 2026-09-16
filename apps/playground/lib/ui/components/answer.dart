import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../support/disclosure.dart';
import '../support/functional_glyph.dart';

part 'answer.g.dart';

typedef PlaygroundAnswerSourcesIndicatorBuilder =
    Widget Function(BuildContext context, bool expanded);

/// Streaming answer surface with host-owned content and feedback.
class PlaygroundAnswer extends StatefulWidget {
  const PlaygroundAnswer({
    super.key,
    required this.child,
    this.streamId,
    this.status = PlaygroundAnswerStatus.streaming,
    this.onCopy,
    this.onRetry,
    this.copyIconBuilder,
    this.retryIconBuilder,
    this.sourcesIndicatorBuilder,
    this.copyLabel = 'Copy answer',
    this.retryLabel = 'Retry answer',
    this.showActions,
    this.feedback,
    this.sourcesContent,
    this.sourcesExpanded,
    this.defaultSourcesExpanded = false,
    this.onSourcesExpandedChanged,
    this.sourcesLabel = 'Sources',
    this.semanticLabel = 'Answer',
    this.surfaceStyle = const CardStyler.create(),
    this.sourcesStyle = const DisclosureStyler.create(),
    this.copyStyle = const IconButtonStyler.create(),
    this.retryStyle = const IconButtonStyler.create(),
    this.style = const PlaygroundAnswerStyler.create(),
    this.styleSpec,
  });

  final Widget child;
  final Object? streamId;
  final PlaygroundAnswerStatus status;
  final VoidCallback? onCopy;
  final VoidCallback? onRetry;
  final RemixIconButtonIconBuilder? copyIconBuilder;
  final RemixIconButtonIconBuilder? retryIconBuilder;
  final PlaygroundAnswerSourcesIndicatorBuilder? sourcesIndicatorBuilder;
  final String copyLabel;
  final String retryLabel;
  final bool? showActions;
  final Widget? feedback;
  final Widget? sourcesContent;
  final bool? sourcesExpanded;
  final bool defaultSourcesExpanded;
  final ValueChanged<bool>? onSourcesExpandedChanged;
  final String sourcesLabel;
  final String semanticLabel;
  final CardStyler surfaceStyle;
  final DisclosureStyler sourcesStyle;
  final IconButtonStyler copyStyle;
  final IconButtonStyler retryStyle;
  final PlaygroundAnswerStyler style;
  final PlaygroundAnswerSpec? styleSpec;

  @override
  State<PlaygroundAnswer> createState() => _PlaygroundAnswerState();
}

class _PlaygroundAnswerState extends State<PlaygroundAnswer> {
  late final PlaygroundDisclosureEngine _disclosure;

  bool get _sourcesExpanded => _disclosure.value;

  @override
  void initState() {
    super.initState();
    _disclosure = PlaygroundDisclosureEngine(
      value: widget.sourcesExpanded,
      defaultValue: widget.defaultSourcesExpanded,
    );
  }

  @override
  void didUpdateWidget(PlaygroundAnswer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disclosure.reconcile(widget.sourcesExpanded);
    final beganStreaming =
        !oldWidget.status.isStreaming && widget.status.isStreaming;
    final newStreamingIdentity =
        oldWidget.streamId != widget.streamId && widget.status.isStreaming;
    if (beganStreaming || newStreamingIdentity) _requestSources(false);
  }

  void _requestSources(bool next) {
    if (_disclosure.request(next)) setState(() {});
    widget.onSourcesExpandedChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final revealActions =
        !widget.status.isStreaming &&
        (widget.showActions ?? widget.status.showsActions);
    return RemixStyleSpecBuilder<PlaygroundAnswerSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        child: RemixCard(
          style: widget.surfaceStyle,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                liveRegion: widget.status.isStreaming,
                child: Box(styleSpec: spec.body, child: widget.child),
              ),
              if (widget.sourcesContent != null)
                RemixDisclosure(
                  expanded: _sourcesExpanded,
                  onExpandedChanged: _requestSources,
                  semanticLabel: widget.sourcesLabel,
                  style: widget.sourcesStyle,
                  triggerBuilder: (context, state, trigger) => Row(
                    children: [
                      Expanded(child: trigger!),
                      PlaygroundDisclosureIndicator(
                        styleSpec: spec.indicator,
                        expanded: state.isExpanded,
                        builder: widget.sourcesIndicatorBuilder,
                      ),
                    ],
                  ),
                  trigger: StyledText(
                    widget.sourcesLabel,
                    styleSpec: spec.sourcesLabel,
                  ),
                  content: widget.sourcesContent!,
                ),
              if (revealActions)
                RowBox(
                  styleSpec: spec.actions,
                  children: [
                    if (widget.onCopy != null)
                      RemixIconButton(
                        icon: null,
                        iconBuilder:
                            widget.copyIconBuilder ??
                            (context, iconSpec, icon) =>
                                PlaygroundFunctionalGlyph(
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
                                PlaygroundFunctionalGlyph(
                                  kind: .retry,
                                  spec: iconSpec,
                                ),
                        semanticLabel: widget.retryLabel,
                        onPressed: widget.onRetry,
                        style: widget.retryStyle,
                      ),
                    if (widget.status == PlaygroundAnswerStatus.complete &&
                        widget.feedback != null)
                      Box(styleSpec: spec.feedback, child: widget.feedback),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

@MixableSpec(target: PlaygroundAnswer.new)
@immutable
final class PlaygroundAnswerSpec with _$PlaygroundAnswerSpec {
  @override
  final StyleSpec<BoxSpec> body;
  @override
  final StyleSpec<FlexBoxSpec> actions;
  @override
  final StyleSpec<BoxSpec> feedback;
  @override
  final StyleSpec<TextSpec> sourcesLabel;
  @override
  final StyleSpec<IconSpec> indicator;

  const PlaygroundAnswerSpec({
    StyleSpec<BoxSpec>? body,
    StyleSpec<FlexBoxSpec>? actions,
    StyleSpec<BoxSpec>? feedback,
    StyleSpec<TextSpec>? sourcesLabel,
    StyleSpec<IconSpec>? indicator,
  }) : body = body ?? const StyleSpec(spec: BoxSpec()),
       actions = actions ?? const StyleSpec(spec: FlexBoxSpec()),
       feedback = feedback ?? const StyleSpec(spec: BoxSpec()),
       sourcesLabel = sourcesLabel ?? const StyleSpec(spec: TextSpec()),
       indicator = indicator ?? const StyleSpec(spec: IconSpec());
}
