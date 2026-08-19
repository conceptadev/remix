import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  testWidgets('ordinary catalog widgets need no Overlay or Navigator', (
    tester,
  ) async {
    await tester.pumpWidget(
      MixScope.empty(
        child: WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (_, _) {
            return const DefaultTextStyle(
              style: TextStyle(color: Color(0xFF18181B), fontSize: 14),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AgentComposer(),
                    AgentMessage(
                      role: AgentRole.assistant,
                      child: Text('Hello'),
                    ),
                    AgentAnswer(
                      status: AgentAnswerStatus.complete,
                      child: Text('Answer'),
                    ),
                    AgentPermission(tool: 'demo.tool'),
                    AgentExecution(
                      tool: 'demo.tool',
                      title: 'Run',
                      status: AgentExecutionStatus.success,
                      child: Text('done'),
                    ),
                    AgentPlan(
                      items: [AgentPlanItem(id: '1', title: 'One')],
                    ),
                    AgentActivity(
                      status: AgentRunStatus.complete,
                      items: [AgentActivityItem(id: '1', title: 'Step')],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(AgentComposer), findsOneWidget);
    expect(find.byType(AgentPermission), findsOneWidget);
    expect(find.byType(Overlay), findsNothing);
    expect(find.byType(Navigator), findsNothing);
  });
}
