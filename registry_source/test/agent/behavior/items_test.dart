import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registry_source/agent.dart';

void main() {
  test('plan items compare every value field and hash equally', () {
    final first = AgentPlanItem(id: 'one', title: 'Step', detail: 'detail');
    final second = AgentPlanItem(id: 'one', title: 'Step', detail: 'detail');
    expect(identical(first, second), isFalse);
    expect(first, second);
    expect(first.hashCode, second.hashCode);
    for (final other in const [
      AgentPlanItem(id: 'two', title: 'Step', detail: 'detail'),
      AgentPlanItem(id: 'one', title: 'Other', detail: 'detail'),
      AgentPlanItem(
        id: 'one',
        title: 'Step',
        status: .completed,
        detail: 'detail',
      ),
      AgentPlanItem(id: 'one', title: 'Step'),
    ]) {
      expect(first, isNot(other));
    }
    expect(first.toString(), contains('detail: detail'));
    expect(
      AgentPlanItem(id: 'one', title: 'Step'),
      AgentPlanItem(id: 'one', title: 'Step'),
    );
  });

  test('activity values include nullable fields and child identity', () {
    final child = SizedBox(height: 10);
    final first = AgentActivityItem(
      id: 'one',
      title: 'Step',
      detail: 'detail',
      child: child,
    );
    final second = AgentActivityItem(
      id: 'one',
      title: 'Step',
      detail: 'detail',
      child: child,
    );
    expect(first, second);
    expect(first.hashCode, second.hashCode);
    for (final other in [
      AgentActivityItem(
        id: 'two',
        title: 'Step',
        detail: 'detail',
        child: child,
      ),
      AgentActivityItem(
        id: 'one',
        title: 'Other',
        detail: 'detail',
        child: child,
      ),
      AgentActivityItem(
        id: 'one',
        title: 'Step',
        status: .complete,
        detail: 'detail',
        child: child,
      ),
      AgentActivityItem(id: 'one', title: 'Step', child: child),
      const AgentActivityItem(id: 'one', title: 'Step', detail: 'detail'),
      AgentActivityItem(
        id: 'one',
        title: 'Step',
        detail: 'detail',
        child: SizedBox(height: 10),
      ),
    ]) {
      expect(first, isNot(other));
    }
    expect(first.toString(), contains('detail: detail'));
    final empty = AgentActivityItem(id: 'one', title: 'Step');
    final same = AgentActivityItem(id: 'one', title: 'Step');
    expect(empty, same);
    expect(empty.hashCode, same.hashCode);
  });
}
