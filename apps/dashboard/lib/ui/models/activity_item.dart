import 'package:flutter/widgets.dart';

import 'statuses.dart';

/// One row in an [UiActivity] ledger.
@immutable
class UiActivityItem {
  /// Creates an activity row.
  const UiActivityItem({
    required this.id,
    required this.title,
    this.status = UiActivityItemStatus.pending,
    this.detail,
    this.child,
  });

  /// Stable identity across list updates.
  final String id;

  /// Visible title.
  final String title;

  /// Current status.
  final UiActivityItemStatus status;

  /// Optional compact detail rendered with the activity detail style slot.
  final String? detail;

  /// Optional host-rendered detail. The catalog does not parse this child.
  final Widget? child;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiActivityItem &&
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
      'UiActivityItem(id: $id, title: $title, status: $status, detail: $detail, child: $child)';
}
