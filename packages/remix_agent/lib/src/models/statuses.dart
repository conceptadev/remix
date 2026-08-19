/// Status of a long-running agent turn or activity ledger.
enum AgentRunStatus {
  /// Work is in progress. Disclosures stay open.
  working,

  /// Work finished. Disclosures may collapse.
  complete,
}

/// Status of a streamed answer.
enum AgentAnswerStatus {
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
enum AgentPermissionStatus {
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
enum AgentExecutionStatus {
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
enum AgentPlanItemStatus {
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
enum AgentActivityItemStatus {
  /// Not yet started.
  pending,

  /// The current step.
  active,

  /// Finished.
  complete,
}

/// Who authored a transcript row.
enum AgentRole {
  /// The human operator.
  user,

  /// The agent.
  assistant,
}

/// Whether a permission or execution is still occupying the operator.
extension AgentPermissionStatusX on AgentPermissionStatus {
  /// True while the card should stay expanded.
  bool get isWorking =>
      this == AgentPermissionStatus.pending ||
      this == AgentPermissionStatus.deciding ||
      this == AgentPermissionStatus.running;

  /// True after a terminal decision or outcome.
  bool get isSettled =>
      this == AgentPermissionStatus.complete ||
      this == AgentPermissionStatus.denied ||
      this == AgentPermissionStatus.error;
}

/// Working vs settled for an execution disclosure.
extension AgentExecutionStatusX on AgentExecutionStatus {
  /// True while output should stay expanded.
  bool get isWorking => this == AgentExecutionStatus.running;

  /// True after a terminal outcome.
  bool get isSettled => !isWorking;
}

/// Working vs settled for a streamed answer.
extension AgentAnswerStatusX on AgentAnswerStatus {
  /// True while tokens are still arriving.
  bool get isStreaming => this == AgentAnswerStatus.streaming;

  /// True when completion actions may appear.
  bool get showsActions =>
      this == AgentAnswerStatus.complete || this == AgentAnswerStatus.error;
}

/// Working vs settled for a plan item.
extension AgentPlanItemStatusX on AgentPlanItemStatus {
  bool get isActive => this == AgentPlanItemStatus.inProgress;

  bool get isDone =>
      this == AgentPlanItemStatus.completed ||
      this == AgentPlanItemStatus.cancelled;
}
