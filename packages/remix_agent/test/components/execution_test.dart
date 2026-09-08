import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('tool identifier is rendered with the execution title', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentExecution(
        tool: 'terminal.run',
        title: 'Focused tests',
        child: Text('output'),
      ),
    );

    expect(find.text('terminal.run'), findsOneWidget);
    expect(find.text('Focused tests'), findsOneWidget);
  });

  testWidgets('copy and retry actions appear only after settlement', (
    tester,
  ) async {
    Widget execution(AgentExecutionStatus status) => AgentExecution(
      tool: 'tool',
      title: 'Run',
      status: status,
      collapseOnComplete: false,
      onCopy: () {},
      onRetry: () {},
      child: const Text('output'),
    );

    await pumpAgent(tester, execution(AgentExecutionStatus.running));
    expect(find.bySemanticsLabel('Copy output'), findsNothing);
    expect(find.bySemanticsLabel('Retry execution'), findsNothing);

    await pumpAgent(tester, execution(AgentExecutionStatus.error));
    expect(find.bySemanticsLabel('Copy output'), findsOneWidget);
    expect(find.bySemanticsLabel('Retry execution'), findsOneWidget);
  });

  testWidgets('execution status and indicator builders are replaceable', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentExecution(
        tool: 'tool',
        title: 'Run',
        statusBuilder: (context, status) =>
            const SizedBox(key: ValueKey('custom-execution-status')),
        indicatorBuilder: (context, expanded) =>
            const SizedBox(key: ValueKey('custom-execution-indicator')),
        child: const Text('output'),
      ),
    );

    expect(
      find.byKey(const ValueKey('custom-execution-status')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('custom-execution-indicator')),
      findsOneWidget,
    );
  });
}
