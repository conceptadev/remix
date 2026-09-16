import 'package:flutter/widgets.dart';

import 'statuses.dart';

/// One row in an [AgentActivity] ledger.
@immutable
class AgentActivityItem {
  /// Creates an activity row.
  const AgentActivityItem({
    required this.id,
    required this.title,
    this.status = AgentActivityItemStatus.pending,
    this.detail,
    this.child,
  });

  /// Stable identity across list updates.
  final String id;

  /// Visible title.
  final String title;

  /// Current status.
  final AgentActivityItemStatus status;

  /// Optional compact detail rendered with the activity detail style slot.
  final String? detail;

  /// Optional host-rendered detail. The catalog does not parse this child.
  final Widget? child;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentActivityItem &&
          other.runtimeType == runtimeType &&
          other.id == id &&
          other.title == title &&
          other.status == status &&
          other.detail == detail &&
          identical(other.child, child);

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    status,
    detail,
    identityHashCode(child),
  );

  @override
  String toString() =>
      'AgentActivityItem(id: $id, title: $title, status: $status, detail: $detail, child: $child)';
}
