import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../style/live_edge.dart';

part 'transcript.g.dart';

/// Chronological transcript with reader-aware live-edge following.
class AgentTranscript extends StatefulWidget {
  const AgentTranscript({
    super.key,
    required List<Widget> this.children,
    this.followOutput = true,
    this.followThreshold = 48.0,
    this.busy = false,
    this.busyLabel = 'Busy',
    this.label = 'Conversation',
    this.onFollowChanged,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
    this.style = const AgentTranscriptStyler.create(),
    this.styleSpec,
  }) : itemCount = null,
       itemBuilder = null;

  const AgentTranscript.builder({
    super.key,
    required int this.itemCount,
    required IndexedWidgetBuilder this.itemBuilder,
    this.followOutput = true,
    this.followThreshold = 48.0,
    this.busy = false,
    this.busyLabel = 'Busy',
    this.label = 'Conversation',
    this.onFollowChanged,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
    this.style = const AgentTranscriptStyler.create(),
    this.styleSpec,
  }) : children = null;

  final List<Widget>? children;
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final bool followOutput;
  final double followThreshold;
  final bool busy;
  final String busyLabel;
  final String label;
  final ValueChanged<bool>? onFollowChanged;
  final ScrollController? controller;
  final Clip clipBehavior;
  final AgentTranscriptStyler style;
  final AgentTranscriptSpec? styleSpec;

  @override
  State<AgentTranscript> createState() => _AgentTranscriptState();
}

class _AgentTranscriptState extends State<AgentTranscript> {
  ScrollController? _ownedController;
  late ScrollController _controller;
  late final AgentLiveEdgeEngine _liveEdge;

  /// Publishes this surface's focus to the styles resolved above it.
  ///
  /// `focused` has no other source here: Agent's slots resolve above any Naked
  /// control, so without this the `focus-visible` state the transcript
  /// worksheet documents could never activate.
  ///
  /// Only `focused`. The pointer-driven states do not resolve on this slot, and
  /// did not before this controller existed either — a host's `onHovered` on
  /// [AgentTranscriptSpec.viewport] has never had an effect. Passing a
  /// controller also means Mix will not mount its own pointer detector, so
  /// restoring hover would be this object's job; nothing asks for it yet.
  final WidgetStatesController _statesController = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? (_ownedController = ScrollController());
    _liveEdge = AgentLiveEdgeEngine(
      enabled: widget.followOutput,
      threshold: widget.followThreshold,
      onChanged: widget.onFollowChanged,
    );
    _scheduleFollow();
  }

  @override
  void didUpdateWidget(AgentTranscript oldWidget) {
    super.didUpdateWidget(oldWidget);
    _liveEdge
      ..enabled = widget.followOutput
      ..threshold = widget.followThreshold
      ..onChanged = widget.onFollowChanged;
    if (!identical(oldWidget.controller, widget.controller)) {
      final offset = _controller.hasClients ? _controller.offset : 0.0;
      final oldOwned = _ownedController;
      _ownedController = null;
      _controller =
          widget.controller ??
          (_ownedController = ScrollController(initialScrollOffset: offset));
      if (oldOwned != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => oldOwned.dispose());
      }
    }
    _scheduleFollow();
  }

  void _scheduleFollow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _liveEdge.follow(_controller);
    });
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    _liveEdge.handleScroll(notification, _controller);
    return notification is OverscrollNotification;
  }

  void _handleIntent(_TranscriptScrollIntent intent) {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    final target = switch (intent.kind) {
      _TranscriptScrollKind.lineUp => position.pixels - 50,
      _TranscriptScrollKind.lineDown => position.pixels + 50,
      _TranscriptScrollKind.pageUp =>
        position.pixels - position.viewportDimension * 0.8,
      _TranscriptScrollKind.pageDown =>
        position.pixels + position.viewportDimension * 0.8,
      _TranscriptScrollKind.home => position.minScrollExtent,
      _TranscriptScrollKind.end => position.maxScrollExtent,
    };
    position.jumpTo(
      target
          .clamp(position.minScrollExtent, position.maxScrollExtent)
          .toDouble(),
    );
    _liveEdge.handlePosition(position);
  }

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<AgentTranscriptSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      controller: _statesController,
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.label,
        value: widget.busy ? widget.busyLabel : null,
        child: FocusableActionDetector(
          onFocusChange: (focused) =>
              _statesController.update(WidgetState.focused, focused),
          shortcuts: _transcriptShortcuts,
          actions: <Type, Action<Intent>>{
            _TranscriptScrollIntent: CallbackAction<_TranscriptScrollIntent>(
              onInvoke: (intent) {
                _handleIntent(intent);
                return null;
              },
            ),
          },
          child: Box(
            styleSpec: spec.viewport,
            child: LayoutBuilder(
              builder: (context, constraints) =>
                  NotificationListener<ScrollMetricsNotification>(
                    onNotification: (notification) {
                      if (notification.depth == 0 && _liveEdge.following) {
                        _scheduleFollow();
                      }
                      return false;
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _handleScroll,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          overscroll: false,
                          physics: const ClampingScrollPhysics(),
                        ),
                        child: _buildList(
                          spec,
                          shrinkWrap: !constraints.hasBoundedHeight,
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(AgentTranscriptSpec spec, {required bool shrinkWrap}) {
    final children = widget.children;
    final count = children?.length ?? widget.itemCount!;
    final spacing = spec.spacing ?? 0;
    assert(spacing >= 0, 'AgentTranscript spacing must be non-negative.');
    return ListView.separated(
      controller: _controller,
      shrinkWrap: shrinkWrap,
      physics: const ClampingScrollPhysics(),
      clipBehavior: widget.clipBehavior,
      itemCount: count,
      itemBuilder: (context, index) => Box(
        styleSpec: spec.item,
        child: children?[index] ?? widget.itemBuilder!(context, index),
      ),
      separatorBuilder: (context, index) => SizedBox(height: spacing),
    );
  }

  @override
  void dispose() {
    _ownedController?.dispose();
    _statesController.dispose();
    super.dispose();
  }
}

enum _TranscriptScrollKind { lineUp, lineDown, pageUp, pageDown, home, end }

class _TranscriptScrollIntent extends Intent {
  const _TranscriptScrollIntent(this.kind);
  final _TranscriptScrollKind kind;
}

const _transcriptShortcuts = <ShortcutActivator, Intent>{
  SingleActivator(LogicalKeyboardKey.arrowUp): _TranscriptScrollIntent(
    _TranscriptScrollKind.lineUp,
  ),
  SingleActivator(LogicalKeyboardKey.arrowDown): _TranscriptScrollIntent(
    _TranscriptScrollKind.lineDown,
  ),
  SingleActivator(LogicalKeyboardKey.pageUp): _TranscriptScrollIntent(
    _TranscriptScrollKind.pageUp,
  ),
  SingleActivator(LogicalKeyboardKey.pageDown): _TranscriptScrollIntent(
    _TranscriptScrollKind.pageDown,
  ),
  SingleActivator(LogicalKeyboardKey.home): _TranscriptScrollIntent(
    _TranscriptScrollKind.home,
  ),
  SingleActivator(LogicalKeyboardKey.end): _TranscriptScrollIntent(
    _TranscriptScrollKind.end,
  ),
};

@MixableSpec(target: AgentTranscript.new)
@immutable
final class AgentTranscriptSpec with _$AgentTranscriptSpec {
  @override
  final StyleSpec<BoxSpec> viewport;
  @override
  final StyleSpec<BoxSpec> item;
  @override
  final double? spacing;

  const AgentTranscriptSpec({
    StyleSpec<BoxSpec>? viewport,
    StyleSpec<BoxSpec>? item,
    this.spacing,
  }) : viewport = viewport ?? const StyleSpec(spec: BoxSpec()),
       item = item ?? const StyleSpec(spec: BoxSpec());
}
