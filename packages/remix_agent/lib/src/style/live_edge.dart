import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Shared private-package live-edge state machine.
class AgentLiveEdgeEngine {
  AgentLiveEdgeEngine({
    required this.enabled,
    required this.threshold,
    this.onChanged,
  });

  bool enabled;
  double threshold;
  ValueChanged<bool>? onChanged;
  bool following = true;
  bool _programmatic = false;

  void handleScroll(
    ScrollNotification notification,
    ScrollController controller,
  ) {
    if (_programmatic || !controller.hasClients) return;
    final fromDrag =
        notification is ScrollUpdateNotification &&
        notification.dragDetails != null;
    final fromUserDirection =
        notification is UserScrollNotification &&
        notification.direction != ScrollDirection.idle;
    if (fromDrag || fromUserDirection) handlePosition(controller.position);
  }

  void handlePosition(ScrollPosition position) {
    final distance = position.maxScrollExtent - position.pixels;
    _setFollowing(distance <= threshold);
  }

  void follow(ScrollController controller) {
    if (!enabled || !following || !controller.hasClients) return;
    final position = controller.position;
    if (!position.hasContentDimensions) return;
    _programmatic = true;
    position.jumpTo(position.maxScrollExtent);
    _programmatic = false;
  }

  void _setFollowing(bool next) {
    if (following == next) return;
    following = next;
    onChanged?.call(next);
  }
}

/// Small non-lazy scroll view used by plan and activity ledgers.
class AgentLiveEdgeScrollView extends StatefulWidget {
  const AgentLiveEdgeScrollView({
    super.key,
    required this.child,
    this.followOutput = true,
    this.followThreshold = 48,
    this.onFollowChanged,
  });

  final Widget child;
  final bool followOutput;
  final double followThreshold;
  final ValueChanged<bool>? onFollowChanged;

  @override
  State<AgentLiveEdgeScrollView> createState() =>
      _AgentLiveEdgeScrollViewState();
}

class _AgentLiveEdgeScrollViewState extends State<AgentLiveEdgeScrollView> {
  late final ScrollController _controller;
  late final AgentLiveEdgeEngine _liveEdge;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _liveEdge = AgentLiveEdgeEngine(
      enabled: widget.followOutput,
      threshold: widget.followThreshold,
      onChanged: widget.onFollowChanged,
    );
    _scheduleFollow();
  }

  @override
  void didUpdateWidget(AgentLiveEdgeScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _liveEdge
      ..enabled = widget.followOutput
      ..threshold = widget.followThreshold
      ..onChanged = widget.onFollowChanged;
    _scheduleFollow();
  }

  void _scheduleFollow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _liveEdge.follow(_controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        if (notification.depth == 0 && _liveEdge.following) _scheduleFollow();
        return false;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.depth == 0) {
            _liveEdge.handleScroll(notification, _controller);
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: _controller,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
