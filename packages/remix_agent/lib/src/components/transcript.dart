import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../behavior/live_edge.dart';
import '../style/defaults.dart';

/// Reader-aware transcript viewport.
///
/// Follows streamed growth only while the reader stays at the live edge.
/// User scroll or drag away releases follow. Returning to the edge
/// re-attaches. Nested scrollables do not count as leaving the edge.
class AgentTranscript extends StatefulWidget {
  /// Creates a live-edge transcript.
  const AgentTranscript({
    super.key,
    required this.child,
    this.followOutput = true,
    this.followThreshold = kDefaultLiveEdgeThreshold,
    this.busy = false,
    this.label = 'Conversation',
    this.onFollowChange,
    this.controller,
    this.padding,
    this.maxHeight,
    this.clipBehavior = Clip.hardEdge,
  });

  /// Transcript contents. Typically a column of [AgentMessage] rows.
  final Widget child;

  /// When false, the viewport never auto-follows.
  final bool followOutput;

  /// Pixels from the end that still count as following.
  final double followThreshold;

  /// Marks the log as waiting for more content.
  final bool busy;

  /// Accessible name for the scrollable log.
  final String label;

  /// Reports follow / release.
  final ValueChanged<bool>? onFollowChange;

  /// Optional external scroll controller.
  final ScrollController? controller;

  /// Inset around [child].
  final EdgeInsetsGeometry? padding;

  /// Optional viewport cap.
  final double? maxHeight;

  /// How overflow is clipped. Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  @override
  State<AgentTranscript> createState() => AgentTranscriptState();
}

/// State exposed so tests can read the shipped [ScrollController].
class AgentTranscriptState extends State<AgentTranscript> {
  ScrollController? _owned;
  late final LiveEdgePolicy policy;
  var _focusVisible = false;

  ScrollController get controller => widget.controller ?? _owned!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _owned = ScrollController();
    }
    policy = LiveEdgePolicy(
      threshold: widget.followThreshold,
      enabled: widget.followOutput,
      onFollowChange: widget.onFollowChange,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didUpdateWidget(AgentTranscript oldWidget) {
    super.didUpdateWidget(oldWidget);
    policy.enabled = widget.followOutput;
    policy.threshold = widget.followThreshold;
    policy.onFollowChange = widget.onFollowChange;
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _follow());
  }

  @override
  void dispose() {
    _owned?.dispose();
    super.dispose();
  }

  Future<void> _follow() {
    if (!mounted) {
      return Future<void>.value();
    }
    return policy.followIfNeeded(controller);
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    // Contain overscroll so glow/bounce cannot chain out of the log.
    if (notification is OverscrollNotification) {
      return true;
    }
    if (policy.isProgrammatic) {
      return false;
    }
    // Content-size changes also emit scroll notifications. Only pointer or
    // wheel input should release or re-attach follow.
    final fromPointer =
        notification is ScrollUpdateNotification &&
        notification.dragDetails != null;
    final fromUser = notification is UserScrollNotification;
    if (!fromPointer && !fromUser) {
      return false;
    }
    if (controller.hasClients) {
      policy.handleUserScroll(controller.position);
    }
    return false;
  }

  void _scrollByIntent(_TranscriptScrollIntent intent) {
    if (!controller.hasClients) {
      return;
    }
    final position = controller.position;
    if (!position.hasPixels || !position.hasContentDimensions) {
      return;
    }
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
    policy.handleUserScroll(position);
  }

  EdgeInsetsGeometry get _padding {
    const gutter = EdgeInsetsDirectional.only(end: kAgentScrollbarGutter);
    return widget.padding == null ? gutter : gutter.add(widget.padding!);
  }

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    return Semantics(
      container: true,
      liveRegion: widget.busy,
      label: widget.label,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // min-h-0 so a flex host can shrink the log. h-full when the host
          // already has a definite height; stay shrink-wrapped when unbounded
          // so Column/maxHeight callers (activity, execution) stay compact.
          var chrome = BoxStyler().minHeight(0);
          if (constraints.hasBoundedHeight) {
            final cap = widget.maxHeight;
            chrome = chrome.height(
              cap == null
                  ? constraints.maxHeight
                  : cap < constraints.maxHeight
                  ? cap
                  : constraints.maxHeight,
            );
          } else if (widget.maxHeight != null) {
            chrome = chrome.maxHeight(widget.maxHeight!);
          }
          if (constraints.hasBoundedWidth) {
            chrome = chrome.width(constraints.maxWidth);
          }
          if (_focusVisible) {
            chrome = chrome.foregroundDecoration(
              .border(
                .color(ink)
                    .width(kAgentFocusRingWidth)
                    .strokeAlign(BorderSide.strokeAlignInside),
              ),
            );
          }

          return FocusableActionDetector(
            shortcuts: _transcriptScrollShortcuts,
            actions: <Type, Action<Intent>>{
              _TranscriptScrollIntent: CallbackAction<_TranscriptScrollIntent>(
                onInvoke: (intent) {
                  _scrollByIntent(intent);
                  return null;
                },
              ),
            },
            onShowFocusHighlight: (show) {
              if (_focusVisible == show) {
                return;
              }
              setState(() => _focusVisible = show);
            },
            child: Box(
              style: chrome,
              child: ClipRect(
                clipBehavior: widget.clipBehavior,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    overscroll: false,
                    physics: const ClampingScrollPhysics(),
                  ),
                  child: NotificationListener<ScrollMetricsNotification>(
                    onNotification: (notification) {
                      if (notification.depth == 0 && policy.following) {
                        _follow();
                      }
                      return false;
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _onNotification,
                      child: SingleChildScrollView(
                        controller: controller,
                        padding: _padding,
                        physics: const ClampingScrollPhysics(),
                        clipBehavior: widget.clipBehavior,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum _TranscriptScrollKind { lineUp, lineDown, pageUp, pageDown, home, end }

class _TranscriptScrollIntent extends Intent {
  const _TranscriptScrollIntent(this.kind);

  final _TranscriptScrollKind kind;
}

const _transcriptScrollShortcuts = <ShortcutActivator, Intent>{
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
