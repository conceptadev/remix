import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registry_source/agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets(
    'message releases the last controlled value and ignores new defaults',
    (tester) async {
      final requests = <bool>[];
      Future<void> pump(bool? expanded, bool defaultExpanded) async {
        await pumpAgent(
          tester,
          AgentMessageCollapsible(
            expanded: expanded,
            defaultExpanded: defaultExpanded,
            onExpandedChanged: requests.add,
            style: AgentMessageCollapsibleStyler(collapsedHeight: 20),
            child: const SizedBox(height: 100, child: Text('Long message')),
          ),
        );
        await tester.pumpAndSettle();
      }

      await pump(true, false);
      await tester.tap(find.text('Show less'));
      await tester.pump();
      await tester.tap(find.text('Show less'));
      await tester.pump();
      expect(requests, [false, false]);
      expect(find.text('Show less'), findsOneWidget);

      await pump(null, false);
      expect(find.text('Show less'), findsOneWidget);
      expect(requests, [false, false]);
      await tester.tap(find.text('Show less'));
      await tester.pumpAndSettle();
      expect(find.text('Show more'), findsOneWidget);
      await pump(null, true);
      expect(find.text('Show more'), findsOneWidget);
      expect(requests, [false, false, false]);
    },
  );

  testWidgets(
    'plan releases control before applying a simultaneous completion',
    (tester) async {
      final requests = <bool>[];
      Future<void> pump(bool? expanded, AgentPlanItemStatus status) =>
          pumpAgent(
            tester,
            AgentPlan(
              expanded: expanded,
              onExpandedChanged: requests.add,
              items: [AgentPlanItem(id: 'one', title: 'Step', status: status)],
            ),
          );
      await pump(true, .inProgress);
      await pump(null, .completed);
      await tester.pumpAndSettle();
      expect(requests, [false]);
      expect(find.text('Step'), findsNothing);
      await tester.tap(find.text('Plan'));
      await tester.pumpAndSettle();
      expect(find.text('Step'), findsOneWidget);
      expect(requests, [false, true]);
    },
  );

  testWidgets(
    'activity ignores working toggles and uses the current callback',
    (tester) async {
      final oldRequests = <bool>[];
      final currentRequests = <bool>[];
      Future<void> pump(AgentRunStatus status, ValueChanged<bool> callback) =>
          pumpAgent(
            tester,
            AgentActivity(
              status: status,
              expanded: false,
              onExpandedChanged: callback,
              items: const [AgentActivityItem(id: 'one', title: 'Work')],
            ),
          );
      await pump(.working, oldRequests.add);
      await tester.tap(find.text('Activity'));
      await tester.pump();
      expect(oldRequests, isEmpty);
      expect(find.text('Work'), findsOneWidget);
      await pump(.complete, currentRequests.add);
      await tester.pumpAndSettle();
      expect(oldRequests, isEmpty);
      expect(currentRequests, [false]);
      await tester.tap(find.text('Activity'));
      await tester.pump();
      expect(currentRequests, [false, true]);
      expect(find.text('Work'), findsNothing);
    },
  );

  testWidgets(
    'custom indicator inherits host context and receives disclosure state',
    (tester) async {
      const color = Color(0xFF123456);
      final states = <bool>[];
      await pumpAgent(
        tester,
        IconTheme(
          data: const IconThemeData(color: color),
          child: AgentPlan(
            items: const [],
            indicatorBuilder: (context, expanded) {
              expect(IconTheme.of(context).color, color);
              expect(Directionality.of(context), TextDirection.ltr);
              states.add(expanded);
              return const Text('Host indicator');
            },
          ),
        ),
      );
      expect(find.text('Host indicator'), findsOneWidget);
      expect(states.last, isTrue);
      await tester.tap(find.text('Plan'));
      await tester.pumpAndSettle();
      expect(states.last, isFalse);
    },
  );
}
