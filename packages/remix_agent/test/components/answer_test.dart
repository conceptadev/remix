import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('error answers expose retry actions but not feedback', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.error,
        onCopy: () {},
        onRetry: () {},
        feedback: const Text('Helpful'),
        child: const Text('failed'),
      ),
    );

    expect(find.bySemanticsLabel('Copy answer'), findsOneWidget);
    expect(find.bySemanticsLabel('Retry answer'), findsOneWidget);
    expect(find.text('Helpful'), findsNothing);
  });

  testWidgets(
    'completed answers insert host feedback without a wrapper action',
    (tester) async {
      await pumpAgent(
        tester,
        const AgentAnswer(
          status: AgentAnswerStatus.complete,
          feedback: Text('Helpful'),
          child: Text('done'),
        ),
      );

      expect(find.text('Helpful'), findsOneWidget);
      expect(find.bySemanticsLabel('Helpful'), findsOneWidget);
    },
  );

  testWidgets('showActions false hides callbacks after completion', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.complete,
        showActions: false,
        onCopy: () {},
        onRetry: () {},
        child: const Text('done'),
      ),
    );

    expect(find.bySemanticsLabel('Copy answer'), findsNothing);
    expect(find.bySemanticsLabel('Retry answer'), findsNothing);
  });

  testWidgets('sources indicator builder receives expansion state', (
    tester,
  ) async {
    final states = <bool>[];
    await pumpAgent(
      tester,
      AgentAnswer(
        sourcesContent: const Text('source'),
        sourcesIndicatorBuilder: (context, expanded) {
          states.add(expanded);
          return const SizedBox(key: ValueKey('custom-sources-indicator'));
        },
        child: const Text('answer'),
      ),
    );
    expect(states.last, isFalse);

    await tester.tap(find.text('Sources'));
    await tester.pumpAndSettle();
    expect(states.last, isTrue);
    expect(
      find.byKey(const ValueKey('custom-sources-indicator')),
      findsOneWidget,
    );
  });
}
