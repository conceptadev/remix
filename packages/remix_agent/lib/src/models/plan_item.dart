import 'statuses.dart';

/// One row in an [AgentPlan].
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
}
