import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  test('permission machine is not a boolean', () {
    expect(AgentPermissionStatus.values, hasLength(7));
    expect(AgentPermissionStatus.pending.isWorking, isTrue);
    expect(AgentPermissionStatus.denied.isSettled, isTrue);
    expect(AgentPermissionStatus.running.isWorking, isTrue);
  });

  test('execution and answer expose working vs actions', () {
    expect(AgentExecutionStatus.running.isWorking, isTrue);
    expect(AgentExecutionStatus.success.isSettled, isTrue);
    expect(AgentAnswerStatus.streaming.showsActions, isFalse);
    expect(AgentAnswerStatus.complete.showsActions, isTrue);
    expect(AgentAnswerStatus.error.showsActions, isTrue);
  });

  test('plan items report active and done', () {
    expect(AgentPlanItemStatus.inProgress.isActive, isTrue);
    expect(AgentPlanItemStatus.completed.isDone, isTrue);
    expect(AgentPlanItemStatus.cancelled.isDone, isTrue);
    expect(AgentPlanItemStatus.pending.isDone, isFalse);
  });
}
