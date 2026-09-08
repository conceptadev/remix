import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('empty plan shows configurable copy and zero count', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentPlan(items: [], emptyLabel: 'Waiting for tasks'),
    );

    expect(find.text('Waiting for tasks'), findsOneWidget);
    expect(find.text('0/0'), findsOneWidget);
  });

  testWidgets('cancelled and completed items both count as settled', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentPlan(
        collapseOnComplete: false,
        items: [
          AgentPlanItem(
            id: 'done',
            title: 'Done',
            status: AgentPlanItemStatus.completed,
          ),
          AgentPlanItem(
            id: 'cancelled',
            title: 'Cancelled',
            status: AgentPlanItemStatus.cancelled,
          ),
        ],
      ),
    );

    expect(find.text('2/2'), findsOneWidget);
  });

  testWidgets('active plan remains directly toggleable', (tester) async {
    await pumpAgent(
      tester,
      const AgentPlan(
        items: [
          AgentPlanItem(
            id: 'active',
            title: 'Active step',
            status: AgentPlanItemStatus.inProgress,
          ),
        ],
      ),
    );

    expect(find.text('Active step'), findsOneWidget);
    await tester.tap(find.text('Plan'));
    await tester.pumpAndSettle();
    expect(find.text('Active step'), findsNothing);
    await tester.tap(find.text('Plan'));
    await tester.pumpAndSettle();
    expect(find.text('Active step'), findsOneWidget);
  });
}
