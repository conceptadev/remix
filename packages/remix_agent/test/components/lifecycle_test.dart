import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('controlled plan emits collapse and reopen requests', (
    tester,
  ) async {
    final key = GlobalKey<_ControlledPlanHarnessState>();
    await pumpAgent(tester, _ControlledPlanHarness(key: key));

    key.currentState!.settle();
    await tester.pump();
    key.currentState!.restart();
    await tester.pump();

    expect(key.currentState!.requests, [false, true]);
    expect(find.text('Controlled step'), findsOneWidget);
  });

  testWidgets('plan can opt out of lifecycle collapse', (tester) async {
    final key = GlobalKey<_PlanNoCollapseHarnessState>();
    await pumpAgent(tester, _PlanNoCollapseHarness(key: key));

    key.currentState!.settle();
    await tester.pumpAndSettle();

    expect(key.currentState!.requests, isEmpty);
    expect(find.text('Persistent step'), findsOneWidget);
  });

  testWidgets('controlled activity requests open and close at boundaries', (
    tester,
  ) async {
    final key = GlobalKey<_ControlledActivityHarnessState>();
    await pumpAgent(tester, _ControlledActivityHarness(key: key));

    expect(find.text('Activity step'), findsNothing);
    key.currentState!.start();
    await tester.pump();
    expect(find.text('Activity step'), findsOneWidget);
    key.currentState!.settle();
    await tester.pumpAndSettle();

    expect(key.currentState!.requests, [true, false]);
    expect(find.text('Activity step'), findsNothing);
  });

  testWidgets('activity remains toggleable after settling', (tester) async {
    final key = GlobalKey<_UncontrolledActivityHarnessState>();
    await pumpAgent(tester, _UncontrolledActivityHarness(key: key));

    key.currentState!.settle();
    await tester.pumpAndSettle();
    expect(find.text('Toggleable step'), findsNothing);
    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Toggleable step'), findsOneWidget);
  });

  testWidgets('controlled execution emits reopen and settle requests', (
    tester,
  ) async {
    final key = GlobalKey<_ControlledExecutionHarnessState>();
    await pumpAgent(tester, _ControlledExecutionHarness(key: key));

    key.currentState!.start();
    await tester.pump();
    key.currentState!.settle();
    await tester.pump();

    expect(key.currentState!.requests, [true, false]);
    expect(find.text('controlled output'), findsNothing);
  });

  testWidgets('permission status policy requests open then terminal close', (
    tester,
  ) async {
    final key = GlobalKey<_ControlledPermissionHarnessState>();
    await pumpAgent(tester, _ControlledPermissionHarness(key: key));

    key.currentState!.decide();
    await tester.pump();
    key.currentState!.complete();
    await tester.pump();

    expect(key.currentState!.requests, [true, false]);
    expect(find.text('flutter test'), findsNothing);
  });

  testWidgets('permission details remain independently toggleable in flight', (
    tester,
  ) async {
    final key = GlobalKey<_UncontrolledPermissionHarnessState>();
    await pumpAgent(
      tester,
      _UncontrolledPermissionHarness(key: key),
      disableAnimations: true,
    );

    key.currentState!.decide();
    await tester.pumpAndSettle();
    expect(find.text('flutter test'), findsOneWidget);

    await tester.tap(find.text('View details'));
    await tester.pumpAndSettle();
    expect(find.text('flutter test'), findsNothing);

    key.currentState!.complete();
    await tester.pumpAndSettle();
    expect(find.text('flutter test'), findsNothing);
  });

  testWidgets('controlled answer emits a source reset for each new stream', (
    tester,
  ) async {
    final key = GlobalKey<_ControlledAnswerHarnessState>();
    await pumpAgent(tester, _ControlledAnswerHarness(key: key));
    expect(find.text('source'), findsOneWidget);

    key.currentState!.restart();
    await tester.pump();

    expect(key.currentState!.requests, [false]);
    expect(find.text('source'), findsOneWidget);
  });

  testWidgets('status and output strings are constructor-configurable', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      Column(
        children: [
          AgentExecution(
            tool: 'tool',
            title: 'Run',
            outputLabel: 'Command log',
            statusLabelBuilder: (_) => 'Executing now',
            child: const Text('output'),
          ),
          AgentPermission(
            tool: 'tool',
            status: AgentPermissionStatus.error,
            statusLabelBuilder: (_) => 'Permission failed',
          ),
          AgentPlan(
            statusLabelBuilder: (_) => 'Queued task',
            items: const [AgentPlanItem(id: 'one', title: 'Plan item')],
          ),
          AgentActivity(
            statusLabelBuilder: (_) => 'Current action',
            items: const [AgentActivityItem(id: 'one', title: 'Activity item')],
          ),
        ],
      ),
    );

    expect(find.text('Executing now'), findsOneWidget);
    expect(find.text('Permission failed'), findsOneWidget);
    final semantics = tester.ensureSemantics();
    await tester.pump();
    expect(find.bySemanticsLabel('Plan item, Queued task'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Activity item, Current action'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Command log'), findsOneWidget);
    semantics.dispose();
  });
}

class _ControlledPlanHarness extends StatefulWidget {
  const _ControlledPlanHarness({super.key});

  @override
  State<_ControlledPlanHarness> createState() => _ControlledPlanHarnessState();
}

class _ControlledPlanHarnessState extends State<_ControlledPlanHarness> {
  var working = true;
  final requests = <bool>[];

  void settle() => setState(() => working = false);
  void restart() => setState(() => working = true);

  @override
  Widget build(BuildContext context) => AgentPlan(
    expanded: true,
    onExpandedChanged: requests.add,
    items: [
      AgentPlanItem(
        id: 'step',
        title: 'Controlled step',
        status: working
            ? AgentPlanItemStatus.inProgress
            : AgentPlanItemStatus.completed,
      ),
    ],
  );
}

class _PlanNoCollapseHarness extends StatefulWidget {
  const _PlanNoCollapseHarness({super.key});

  @override
  State<_PlanNoCollapseHarness> createState() => _PlanNoCollapseHarnessState();
}

class _PlanNoCollapseHarnessState extends State<_PlanNoCollapseHarness> {
  var working = true;
  final requests = <bool>[];

  void settle() => setState(() => working = false);

  @override
  Widget build(BuildContext context) => AgentPlan(
    collapseOnComplete: false,
    onExpandedChanged: requests.add,
    items: [
      AgentPlanItem(
        id: 'step',
        title: 'Persistent step',
        status: working
            ? AgentPlanItemStatus.inProgress
            : AgentPlanItemStatus.completed,
      ),
    ],
  );
}

class _ControlledActivityHarness extends StatefulWidget {
  const _ControlledActivityHarness({super.key});

  @override
  State<_ControlledActivityHarness> createState() =>
      _ControlledActivityHarnessState();
}

class _ControlledActivityHarnessState
    extends State<_ControlledActivityHarness> {
  var status = AgentRunStatus.complete;
  final requests = <bool>[];

  void start() => setState(() => status = AgentRunStatus.working);
  void settle() => setState(() => status = AgentRunStatus.complete);

  @override
  Widget build(BuildContext context) => AgentActivity(
    status: status,
    expanded: false,
    onExpandedChanged: requests.add,
    items: const [AgentActivityItem(id: 'step', title: 'Activity step')],
  );
}

class _UncontrolledActivityHarness extends StatefulWidget {
  const _UncontrolledActivityHarness({super.key});

  @override
  State<_UncontrolledActivityHarness> createState() =>
      _UncontrolledActivityHarnessState();
}

class _UncontrolledActivityHarnessState
    extends State<_UncontrolledActivityHarness> {
  var status = AgentRunStatus.working;

  void settle() => setState(() => status = AgentRunStatus.complete);

  @override
  Widget build(BuildContext context) => AgentActivity(
    status: status,
    items: const [AgentActivityItem(id: 'step', title: 'Toggleable step')],
  );
}

class _ControlledExecutionHarness extends StatefulWidget {
  const _ControlledExecutionHarness({super.key});

  @override
  State<_ControlledExecutionHarness> createState() =>
      _ControlledExecutionHarnessState();
}

class _ControlledExecutionHarnessState
    extends State<_ControlledExecutionHarness> {
  var status = AgentExecutionStatus.success;
  final requests = <bool>[];

  void start() => setState(() => status = AgentExecutionStatus.running);
  void settle() => setState(() => status = AgentExecutionStatus.success);

  @override
  Widget build(BuildContext context) => AgentExecution(
    tool: 'terminal.run',
    title: 'Controlled run',
    status: status,
    expanded: false,
    onExpandedChanged: requests.add,
    child: const Text('controlled output'),
  );
}

class _ControlledPermissionHarness extends StatefulWidget {
  const _ControlledPermissionHarness({super.key});

  @override
  State<_ControlledPermissionHarness> createState() =>
      _ControlledPermissionHarnessState();
}

class _ControlledPermissionHarnessState
    extends State<_ControlledPermissionHarness> {
  var status = AgentPermissionStatus.pending;
  final requests = <bool>[];

  void decide() => setState(() => status = AgentPermissionStatus.deciding);
  void complete() => setState(() => status = AgentPermissionStatus.complete);

  @override
  Widget build(BuildContext context) => AgentPermission(
    tool: 'terminal.run',
    status: status,
    detailsExpanded: false,
    onDetailsExpandedChanged: requests.add,
    parameters: const [
      RemixDataListItem(label: 'Command', value: 'flutter test'),
    ],
  );
}

class _UncontrolledPermissionHarness extends StatefulWidget {
  const _UncontrolledPermissionHarness({super.key});

  @override
  State<_UncontrolledPermissionHarness> createState() =>
      _UncontrolledPermissionHarnessState();
}

class _UncontrolledPermissionHarnessState
    extends State<_UncontrolledPermissionHarness> {
  var status = AgentPermissionStatus.pending;

  void decide() => setState(() => status = AgentPermissionStatus.deciding);
  void complete() => setState(() => status = AgentPermissionStatus.complete);

  @override
  Widget build(BuildContext context) => AgentPermission(
    tool: 'terminal.run',
    status: status,
    parameters: const [
      RemixDataListItem(label: 'Command', value: 'flutter test'),
    ],
  );
}

class _ControlledAnswerHarness extends StatefulWidget {
  const _ControlledAnswerHarness({super.key});

  @override
  State<_ControlledAnswerHarness> createState() =>
      _ControlledAnswerHarnessState();
}

class _ControlledAnswerHarnessState extends State<_ControlledAnswerHarness> {
  var stream = 0;
  var status = AgentAnswerStatus.complete;
  final requests = <bool>[];

  void restart() => setState(() {
    stream++;
    status = AgentAnswerStatus.streaming;
  });

  @override
  Widget build(BuildContext context) => AgentAnswer(
    streamId: stream,
    status: status,
    sourcesExpanded: true,
    onSourcesExpandedChanged: requests.add,
    sourcesContent: const Text('source'),
    child: const Text('answer'),
  );
}
