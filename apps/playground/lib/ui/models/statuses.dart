/// Status of a long-running turn or activity ledger.
enum PlaygroundRunStatus {
  /// Work is in progress. Disclosures stay open.
  working,

  /// Work finished. Disclosures may collapse.
  complete,
}

/// Status of a streamed answer.
enum PlaygroundAnswerStatus {
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
enum PlaygroundPermissionStatus {
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
enum PlaygroundExecutionStatus {
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
enum PlaygroundPlanItemStatus {
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
enum PlaygroundActivityItemStatus {
  /// Not yet started.
  pending,

  /// The current step.
  active,

  /// Finished.
  complete,
}

/// Who authored a transcript row.
enum PlaygroundRole {
  /// The human operator.
  user,

  /// The assistant replying to the operator.
  assistant,
}

/// Whether a permission or execution is still occupying the operator.
extension PlaygroundPermissionStatusX on PlaygroundPermissionStatus {
  /// True until a terminal outcome. [pending] is working (HITL in flight)
  /// but does not keep parameter details open.
  bool get isWorking => !isSettled;

  /// True after a terminal decision or outcome.
  bool get isSettled =>
      this == PlaygroundPermissionStatus.complete ||
      this == PlaygroundPermissionStatus.denied ||
      this == PlaygroundPermissionStatus.error;

  /// True while parameter details stay open without a user toggle.
  /// Pending starts closed.
  bool get keepsDetailsOpen =>
      this == PlaygroundPermissionStatus.deciding ||
      this == PlaygroundPermissionStatus.allowed ||
      this == PlaygroundPermissionStatus.running;
}

/// Working vs settled for an execution disclosure.
extension PlaygroundExecutionStatusX on PlaygroundExecutionStatus {
  /// True while output should stay expanded.
  bool get isWorking => this == PlaygroundExecutionStatus.running;

  /// True after a terminal outcome.
  bool get isSettled => !isWorking;
}

/// Working vs settled for a streamed answer.
extension PlaygroundAnswerStatusX on PlaygroundAnswerStatus {
  /// True while tokens are still arriving.
  bool get isStreaming => this == PlaygroundAnswerStatus.streaming;

  /// True when completion actions may appear.
  bool get showsActions =>
      this == PlaygroundAnswerStatus.complete ||
      this == PlaygroundAnswerStatus.error;
}

/// Working vs settled for a plan item.
extension PlaygroundPlanItemStatusX on PlaygroundPlanItemStatus {
  bool get isActive => this == PlaygroundPlanItemStatus.inProgress;

  bool get isDone =>
      this == PlaygroundPlanItemStatus.completed ||
      this == PlaygroundPlanItemStatus.cancelled;
}
