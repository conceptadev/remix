/// Status of a long-running turn or activity ledger.
enum UiRunStatus {
  /// Work is in progress. Disclosures stay open.
  working,

  /// Work finished. Disclosures may collapse.
  complete,
}

/// Status of a streamed answer.
enum UiAnswerStatus {
  /// Tokens are still arriving.
  streaming,

  /// The answer finished successfully.
  complete,

  /// The answer failed.
  error,
}

/// Status of an in-transcript tool permission.
///
/// This is a machine, not a boolean loading flag. Actions are offered only
/// while [pending].
enum UiPermissionStatus {
  /// Waiting for a human decision.
  pending,

  /// A decision was submitted and is being recorded.
  deciding,

  /// The host accepted this invocation.
  allowed,

  /// The approved tool is executing.
  running,

  /// The approved tool finished.
  complete,

  /// The host refused this invocation.
  denied,

  /// Permission or execution failed.
  error,
}

/// Status of a tool execution disclosure.
enum UiExecutionStatus {
  /// Output is still arriving.
  running,

  /// The tool finished successfully.
  success,

  /// The tool failed.
  error,

  /// The host or runtime cancelled the tool.
  cancelled,
}

/// Status of one item in a task plan.
enum UiPlanItemStatus {
  /// Not started.
  pending,

  /// Currently underway.
  inProgress,

  /// Finished successfully.
  completed,

  /// Abandoned or skipped.
  cancelled,
}

/// Status of one row in an activity ledger.
enum UiActivityItemStatus {
  /// Not yet started.
  pending,

  /// The current step.
  active,

  /// Finished.
  complete,
}

/// Who authored a transcript row.
enum UiRole {
  /// The human operator.
  user,

  /// The assistant replying to the operator.
  assistant,
}

/// Whether a permission or execution is still occupying the operator.
extension UiPermissionStatusX on UiPermissionStatus {
  /// True until a terminal outcome. [pending] is working (HITL in flight)
  /// but does not keep parameter details open.
  bool get isWorking => !isSettled;

  /// True after a terminal decision or outcome.
  bool get isSettled =>
      this == UiPermissionStatus.complete ||
      this == UiPermissionStatus.denied ||
      this == UiPermissionStatus.error;

  /// True while parameter details stay open without a user toggle.
  /// Pending starts closed.
  bool get keepsDetailsOpen =>
      this == UiPermissionStatus.deciding ||
      this == UiPermissionStatus.allowed ||
      this == UiPermissionStatus.running;
}

/// Working vs settled for an execution disclosure.
extension UiExecutionStatusX on UiExecutionStatus {
  /// True while output should stay expanded.
  bool get isWorking => this == UiExecutionStatus.running;

  /// True after a terminal outcome.
  bool get isSettled => !isWorking;
}

/// Working vs settled for a streamed answer.
extension UiAnswerStatusX on UiAnswerStatus {
  /// True while tokens are still arriving.
  bool get isStreaming => this == UiAnswerStatus.streaming;

  /// True when completion actions may appear.
  bool get showsActions =>
      this == UiAnswerStatus.complete || this == UiAnswerStatus.error;
}

/// Working vs settled for a plan item.
extension UiPlanItemStatusX on UiPlanItemStatus {
  bool get isActive => this == UiPlanItemStatus.inProgress;

  bool get isDone =>
      this == UiPlanItemStatus.completed || this == UiPlanItemStatus.cancelled;
}
