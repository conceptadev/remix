import 'dart:ui' show Tristate;

import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

List<SemanticsNode> _nodes(WidgetTester tester) =>
    tester.semantics.simulatedAccessibilityTraversal().toList();

Iterable<SemanticsNode> _labeled(WidgetTester tester, String label) =>
    _nodes(tester).where((node) => node.getSemanticsData().label == label);

Iterable<SemanticsNode> _buttons(WidgetTester tester, String label) => _labeled(
  tester,
  label,
).where((node) => node.getSemanticsData().flagsCollection.isButton);

void main() {
  testWidgets('composer exposes one named field and one Send action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final controller = TextEditingController(text: 'Ship it');
    addTearDown(controller.dispose);
    await pumpAgent(
      tester,
      AgentComposer(controller: controller, onSubmit: (_) {}),
      overlay: true,
    );

    final fields = _nodes(
      tester,
    ).where((node) => node.getSemanticsData().flagsCollection.isTextField);
    expect(fields, hasLength(1));
    expect(fields.single.getSemanticsData().label, 'Message');
    expect(_buttons(tester, 'Send'), hasLength(1));
    expect(_buttons(tester, 'Stop'), isEmpty);
    semantics.dispose();
  });

  testWidgets('running composer replaces Send with exactly one Stop action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentComposer(running: true, onStop: () {}),
      overlay: true,
    );

    expect(_buttons(tester, 'Send'), isEmpty);
    expect(_buttons(tester, 'Stop'), hasLength(1));
    semantics.dispose();
  });

  testWidgets('plan keeps container, trigger, and status names separate', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      const AgentPlan(
        items: [
          AgentPlanItem(
            id: 'one',
            title: 'Inspect',
            detail: 'checkout',
            status: AgentPlanItemStatus.inProgress,
          ),
        ],
      ),
    );

    expect(_labeled(tester, 'Task plan'), hasLength(1));
    expect(_buttons(tester, 'Plan'), hasLength(1));
    expect(_labeled(tester, 'Task plan Plan'), isEmpty);
    expect(_labeled(tester, 'Inspect, checkout, In progress'), hasLength(1));
    semantics.dispose();
  });

  testWidgets('working activity has one disabled trigger and named status', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      const AgentActivity(
        items: [
          AgentActivityItem(
            id: 'one',
            title: 'Reading',
            detail: 'brief',
            status: AgentActivityItemStatus.active,
          ),
        ],
      ),
    );

    final trigger = _buttons(tester, 'Activity').single.getSemanticsData();
    expect(trigger.flagsCollection.isEnabled, Tristate.isFalse);
    expect(_labeled(tester, 'Activity Activity'), isEmpty);
    expect(_labeled(tester, 'Reading, brief, Active'), hasLength(1));
    semantics.dispose();
  });

  testWidgets('execution announces tool and status without renaming trigger', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentExecution(
        tool: 'terminal.run',
        title: 'Focused checks',
        status: AgentExecutionStatus.success,
        collapseOnComplete: false,
        onCopy: () {},
        onRetry: () {},
        child: const Text('12 passed'),
      ),
    );

    final container = _labeled(tester, 'Tool execution').single;
    expect(container.getSemanticsData().value, 'terminal.run, Completed');
    expect(_buttons(tester, 'Focused checks'), hasLength(1));
    expect(_labeled(tester, 'Tool execution Focused checks'), isEmpty);
    expect(_buttons(tester, 'Copy output'), hasLength(1));
    expect(_buttons(tester, 'Retry execution'), hasLength(1));
    semantics.dispose();
  });

  testWidgets('permission exposes independent details and decision actions', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentPermission(
        tool: 'terminal.run',
        parameters: const [
          RemixDataListItem(label: 'Command', value: 'flutter test'),
        ],
        onAllowOnce: () {},
        onAlwaysAllow: () {},
        onDeny: () {},
      ),
    );

    expect(_labeled(tester, 'Tool permission'), hasLength(1));
    expect(_buttons(tester, 'View details'), hasLength(1));
    expect(_buttons(tester, 'Allow once'), hasLength(1));
    expect(_buttons(tester, 'Always allow'), hasLength(1));
    expect(_buttons(tester, 'Deny'), hasLength(1));
    expect(
      _labeled(tester, 'Tool permission Allow this tool to run?'),
      isEmpty,
    );
    semantics.dispose();
  });

  testWidgets('answer keeps Sources separate from body and container', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.complete,
        onCopy: () {},
        sourcesContent: const Text('Checkout brief'),
        child: const Text('The checkout flow is ready.'),
      ),
    );

    expect(_labeled(tester, 'Answer'), hasLength(1));
    expect(_buttons(tester, 'Sources'), hasLength(1));
    expect(
      _labeled(tester, 'Answer The checkout flow is ready. Sources'),
      isEmpty,
    );
    expect(_buttons(tester, 'Copy answer'), hasLength(1));
    semantics.dispose();
  });

  testWidgets('busy transcript exposes a value but is not a live region', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpAgent(
      tester,
      SizedBox(
        height: 100,
        child: AgentTranscript(
          busy: true,
          busyLabel: 'Generating',
          children: [
            Semantics(liveRegion: true, child: const Text('streaming leaf')),
          ],
        ),
      ),
    );

    final container = _labeled(tester, 'Conversation').single;
    final data = container.getSemanticsData();
    expect(data.value, 'Generating');
    expect(data.flagsCollection.isLiveRegion, isFalse);
    expect(
      _nodes(
        tester,
      ).where((node) => node.getSemanticsData().flagsCollection.isLiveRegion),
      hasLength(1),
    );
    semantics.dispose();
  });
}
