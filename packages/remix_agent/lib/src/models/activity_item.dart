import 'package:flutter/widgets.dart';

import 'statuses.dart';

/// One row in an [AgentActivity] ledger.
class AgentActivityItem {
  /// Creates an activity row.
  const AgentActivityItem({
    required this.id,
    required this.title,
    this.status = AgentActivityItemStatus.pending,
    this.child,
  });

  /// Stable identity across list updates.
  final String id;

  /// Visible title.
  final String title;

  /// Current status.
  final AgentActivityItemStatus status;

  /// Optional host-rendered detail. The catalog does not parse this child.
  final Widget? child;
}
