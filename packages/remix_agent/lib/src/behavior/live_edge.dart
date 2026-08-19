import 'package:flutter/widgets.dart';

/// Distance from the end, in logical pixels, that still counts as following.
const double kDefaultLiveEdgeThreshold = 56;

/// Follow / release policy for a growing transcript or output viewport.
///
/// Follows while the reader stays within [threshold] of the end. A user
/// scroll or drag away from the end releases follow. Returning to the edge
/// re-attaches. Programmatic jumps used to keep the live edge in view are
/// latched so they are not mistaken for user navigation.
class LiveEdgePolicy {
  /// Creates a live-edge policy.
  LiveEdgePolicy({
    this.threshold = kDefaultLiveEdgeThreshold,
    this.enabled = true,
    this.onFollowChange,
  });

  /// Pixels from [ScrollPosition.maxScrollExtent] that still count as the edge.
  double threshold;

  /// When false, the policy never follows and never reports changes.
  bool enabled;

  /// Called when [following] flips.
  ValueChanged<bool>? onFollowChange;

  var _following = true;
  var _programmatic = false;

  /// Whether new growth should pin to the end.
  bool get following => enabled && _following;

  /// Whether a programmatic follow is in flight.
  bool get isProgrammatic => _programmatic;

  /// True when [position] is within [threshold] of the end.
  bool isNearEnd(ScrollMetrics position) {
    final remaining = position.maxScrollExtent - position.pixels;
    return remaining <= threshold;
  }

  /// Record a user-driven scroll. Ignored while a programmatic follow runs.
  void handleUserScroll(ScrollMetrics position) {
    if (!enabled || _programmatic) {
      return;
    }
    final near = isNearEnd(position);
    if (_following && !near) {
      _setFollowing(false);
    } else if (!_following && near) {
      _setFollowing(true);
    }
  }

  /// Pin to the end when [following] is true.
  Future<void> followIfNeeded(ScrollController controller) async {
    if (!following || !controller.hasClients) {
      return;
    }
    final position = controller.position;
    if (!position.hasPixels || !position.hasContentDimensions) {
      return;
    }
    final target = position.maxScrollExtent;
    if ((target - position.pixels).abs() < 0.5) {
      return;
    }
    _programmatic = true;
    try {
      // Jump, don't animate. The contract is "stay on the live edge", not
      // a motion sequence. Animation would also race content-size updates.
      position.jumpTo(target);
    } finally {
      _programmatic = false;
    }
  }

  /// Treat the next scroll notifications as programmatic.
  void beginProgrammatic() {
    _programmatic = true;
  }

  /// End the programmatic latch.
  void endProgrammatic() {
    _programmatic = false;
  }

  void _setFollowing(bool value) {
    if (_following == value) {
      return;
    }
    _following = value;
    onFollowChange?.call(value);
  }
}
