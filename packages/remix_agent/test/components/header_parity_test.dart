import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

const _items = [
  AgentActivityItem(
    id: 'read',
    title: 'Read',
    status: AgentActivityItemStatus.complete,
  ),
  AgentActivityItem(
    id: 'map',
    title: 'Map',
    status: AgentActivityItemStatus.active,
  ),
];

void main() {
  testWidgets('activity counts settled rows the way a plan does', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentActivity(items: _items, status: AgentRunStatus.complete),
    );

    expect(find.text('1/2'), findsOneWidget);
  });

  testWidgets(
    'the count survives the working state, while the ledger is forced open',
    (tester) async {
      await pumpAgent(tester, const AgentActivity(items: _items));

      expect(find.text('1/2'), findsOneWidget);
    },
  );

  testWidgets('the chevron keeps its slot while working, so the count holds '
      'one right edge', (tester) async {
    Widget ledger(AgentRunStatus status) => SizedBox(
      width: 400,
      child: AgentActivity(items: _items, status: status),
    );

    await pumpAgent(tester, ledger(AgentRunStatus.working));
    final working = tester.getTopRight(find.text('1/2'));

    await pumpAgent(tester, ledger(AgentRunStatus.complete));
    final settled = tester.getTopRight(find.text('1/2'));

    expect(working.dx, settled.dx);
  });

  for (final running in [false, true]) {
    testWidgets(
      'composer action has its own semantics bounds (running: $running)',
      (tester) async {
        final semantics = tester.ensureSemantics();
        await pumpAgent(
          tester,
          SizedBox(
            width: 400,
            child: AgentComposer(
              initialValue: 'go',
              onSubmit: (_) {},
              running: running,
              onStop: () {},
            ),
          ),
          overlay: true,
        );

        // Without the container boundary the button and the text area merge, and
        // the button's accessible bounds grow to the whole card.
        final send = tester.getRect(
          find.byKey(
            ValueKey(running ? 'agent-composer-stop' : 'agent-composer-send'),
          ),
        );
        final node = tester.getSemantics(
          find.byKey(
            ValueKey(running ? 'agent-composer-stop' : 'agent-composer-send'),
          ),
        );

        expect(node.label, running ? 'Stop' : 'Send');
        expect(node.rect.size.width, closeTo(send.width, 0.01));
        expect(node.rect.size.height, closeTo(send.height, 0.01));
        semantics.dispose();
      },
    );
  }
}
