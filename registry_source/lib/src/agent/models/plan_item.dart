import 'package:flutter/foundation.dart';

import 'statuses.dart';

/// One row in an [AgentPlan].
@immutable
class AgentPlanItem {
  /// Creates a plan item.
  const AgentPlanItem({
    required this.id,
    required this.title,
    this.status = AgentPlanItemStatus.pending,
    this.detail,
  });

  /// Stable identity across list updates.
  final String id;

  /// Visible title.
  final String title;

  /// Current status.
  final AgentPlanItemStatus status;

  /// Optional compact metadata (elapsed time, percent, path).
  final String? detail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentPlanItem &&
          other.runtimeType == runtimeType &&
          other.id == id &&
          other.title == title &&
          other.status == status &&
          other.detail == detail;

  @override
  int get hashCode => Object.hash(runtimeType, id, title, status, detail);

  @override
  String toString() =>
      'AgentPlanItem(id: $id, title: $title, status: $status, detail: $detail)';
}
