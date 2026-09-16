import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Shared private-package live-edge state machine.
class UiLiveEdgeEngine {
  UiLiveEdgeEngine({
    required this._enabled,
    required this.threshold,
    this.onChanged,
  });

  bool _enabled;
  bool get enabled => _enabled;

  set enabled(bool value) {
    // An explicit false-to-true transition is the host's resume action.
    // Ordinary rebuilds with follow enabled must preserve a reader's release.
    if (value && !_enabled) _following = true;
    _enabled = value;
  }

  double threshold;
  ValueChanged<bool>? onChanged;
  bool _following = true;
  bool _programmatic = false;

  bool get following => _following;

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
    _following = next;
    onChanged?.call(next);
  }
}

/// Small non-lazy scroll view used by plan and activity ledgers.
class UiLiveEdgeScrollView extends StatefulWidget {
  const UiLiveEdgeScrollView({
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
  State<UiLiveEdgeScrollView> createState() => _UiLiveEdgeScrollViewState();
}

class _UiLiveEdgeScrollViewState extends State<UiLiveEdgeScrollView> {
  late final ScrollController _controller;
  late final UiLiveEdgeEngine _liveEdge;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _liveEdge = UiLiveEdgeEngine(
      enabled: widget.followOutput,
      threshold: widget.followThreshold,
      onChanged: widget.onFollowChanged,
    );
    _scheduleFollow();
  }

  @override
  void didUpdateWidget(UiLiveEdgeScrollView oldWidget) {
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
