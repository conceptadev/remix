import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('composer tracks replacement and programmatic controller edits', (
    tester,
  ) async {
    final first = TextEditingController();
    final second = TextEditingController();
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    final key = GlobalKey<_ComposerHarnessState>();
    await pumpAgent(
      tester,
      _ComposerHarness(key: key, first: first, second: second),
      overlay: true,
    );

    first.text = 'first';
    await tester.pump();
    var send = tester.widget<RemixIconButton>(
      find.byKey(const ValueKey('agent-composer-send')),
    );
    expect(send.enabled, isTrue);

    key.currentState!.replace();
    second.text = 'second';
    await tester.pump();
    tester
        .widget<RemixIconButton>(
          find.byKey(const ValueKey('agent-composer-send')),
        )
        .onPressed!();
    await tester.pump();
    expect(key.currentState!.submitted, ['second']);
    expect(second.text, isEmpty);
    expect(first.text, 'first');
  });

  testWidgets('composer respects IME, Shift+Enter, focus, and clearOnSubmit', (
    tester,
  ) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);
    final submitted = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(
        controller: controller,
        focusNode: focusNode,
        onSubmit: submitted.add,
      ),
      overlay: true,
    );
    focusNode.requestFocus();
    controller.value = const TextEditingValue(
      text: 'compose',
      selection: TextSelection.collapsed(offset: 7),
      composing: TextRange(start: 0, end: 7),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(submitted, isEmpty);

    controller.value = const TextEditingValue(
      text: 'line',
      selection: TextSelection.collapsed(offset: 4),
    );
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    expect(submitted, isEmpty);

    await tester.sendKeyEvent(LogicalKeyboardKey.numpadEnter);
    await tester.pump();
    expect(submitted, ['line']);
    expect(controller.text, isEmpty);
    expect(focusNode.hasFocus, isTrue);
  });

  testWidgets('plan counts cancelled as settled and lifecycle reopens', (
    tester,
  ) async {
    final key = GlobalKey<_PlanHarnessState>();
    await pumpAgent(tester, _PlanHarness(key: key));
    expect(find.text('0/2'), findsOneWidget);
    key.currentState!.settle();
    await tester.pumpAndSettle();
    expect(find.text('2/2'), findsOneWidget);
    expect(find.text('One'), findsNothing);
    key.currentState!.restart();
    await tester.pumpAndSettle();
    expect(find.text('One'), findsOneWidget);
  });

  testWidgets('activity locks only while working', (tester) async {
    final key = GlobalKey<_ActivityHarnessState>();
    await pumpAgent(tester, _ActivityHarness(key: key));
    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Working item'), findsOneWidget);
    key.currentState!.complete();
    await tester.pumpAndSettle();
    expect(find.text('Working item'), findsNothing);
    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Working item'), findsOneWidget);
  });

  testWidgets('execution stays toggleable while running and reopens on run', (
    tester,
  ) async {
    final key = GlobalKey<_ExecutionHarnessState>();
    await pumpAgent(
      tester,
      _ExecutionHarness(key: key),
      disableAnimations: true,
    );
    await tester.tap(find.text('Run checks'));
    await tester.pumpAndSettle();
    expect(find.text('output'), findsNothing);
    key.currentState!.settle();
    await tester.pumpAndSettle();
    key.currentState!.runAgain();
    await tester.pumpAndSettle();
    expect(find.text('output'), findsOneWidget);
  });

  testWidgets('permission latch prevents duplicate decisions and resets', (
    tester,
  ) async {
    final key = GlobalKey<_PermissionHarnessState>();
    await pumpAgent(tester, _PermissionHarness(key: key));
    final deny = find.byKey(const ValueKey('agent-permission-deny'));
    await tester.tap(deny);
    await tester.tap(deny);
    expect(key.currentState!.decisions, 1);
    key.currentState!.newRequest();
    await tester.pump();
    await tester.tap(deny);
    expect(key.currentState!.decisions, 2);
  });

  testWidgets(
    'answer never forces actions while streaming and resets sources',
    (tester) async {
      final key = GlobalKey<_AnswerHarnessState>();
      await pumpAgent(tester, _AnswerHarness(key: key));
      expect(find.bySemanticsLabel('Copy answer'), findsNothing);
      key.currentState!.complete();
      await tester.pump();
      expect(find.bySemanticsLabel('Copy answer'), findsOneWidget);
      await tester.tap(find.text('Sources'));
      await tester.pumpAndSettle();
      expect(find.text('source body'), findsOneWidget);
      key.currentState!.restart();
      await tester.pumpAndSettle();
      expect(find.text('source body'), findsNothing);
    },
  );
}

class _ComposerHarness extends StatefulWidget {
  const _ComposerHarness({
    super.key,
    required this.first,
    required this.second,
  });
  final TextEditingController first;
  final TextEditingController second;
  @override
  State<_ComposerHarness> createState() => _ComposerHarnessState();
}

class _ComposerHarnessState extends State<_ComposerHarness> {
  var useSecond = false;
  final submitted = <String>[];
  void replace() => setState(() => useSecond = true);
  @override
  Widget build(BuildContext context) => AgentComposer(
    controller: useSecond ? widget.second : widget.first,
    onSubmit: submitted.add,
  );
}

class _PlanHarness extends StatefulWidget {
  const _PlanHarness({super.key});
  @override
  State<_PlanHarness> createState() => _PlanHarnessState();
}

class _PlanHarnessState extends State<_PlanHarness> {
  var settled = false;
  void settle() => setState(() => settled = true);
  void restart() => setState(() => settled = false);
  @override
  Widget build(BuildContext context) => AgentPlan(
    items: [
      AgentPlanItem(
        id: '1',
        title: 'One',
        status: settled
            ? AgentPlanItemStatus.completed
            : AgentPlanItemStatus.inProgress,
      ),
      AgentPlanItem(
        id: '2',
        title: 'Two',
        status: settled
            ? AgentPlanItemStatus.cancelled
            : AgentPlanItemStatus.pending,
      ),
    ],
  );
}

class _ActivityHarness extends StatefulWidget {
  const _ActivityHarness({super.key});
  @override
  State<_ActivityHarness> createState() => _ActivityHarnessState();
}

class _ActivityHarnessState extends State<_ActivityHarness> {
  var status = AgentRunStatus.working;
  void complete() => setState(() => status = AgentRunStatus.complete);
  @override
  Widget build(BuildContext context) => AgentActivity(
    status: status,
    items: const [AgentActivityItem(id: '1', title: 'Working item')],
  );
}

class _ExecutionHarness extends StatefulWidget {
  const _ExecutionHarness({super.key});
  @override
  State<_ExecutionHarness> createState() => _ExecutionHarnessState();
}

class _ExecutionHarnessState extends State<_ExecutionHarness> {
  var status = AgentExecutionStatus.running;
  void settle() => setState(() => status = AgentExecutionStatus.success);
  void runAgain() => setState(() => status = AgentExecutionStatus.running);
  @override
  Widget build(BuildContext context) => AgentExecution(
    tool: 'terminal.run',
    title: 'Run checks',
    status: status,
    child: const Text('output'),
  );
}

class _PermissionHarness extends StatefulWidget {
  const _PermissionHarness({super.key});
  @override
  State<_PermissionHarness> createState() => _PermissionHarnessState();
}

class _PermissionHarnessState extends State<_PermissionHarness> {
  var request = 0;
  var decisions = 0;
  void newRequest() => setState(() => request++);
  @override
  Widget build(BuildContext context) => AgentPermission(
    tool: 'terminal.run',
    requestId: request,
    onDeny: () => decisions++,
  );
}

class _AnswerHarness extends StatefulWidget {
  const _AnswerHarness({super.key});
  @override
  State<_AnswerHarness> createState() => _AnswerHarnessState();
}

class _AnswerHarnessState extends State<_AnswerHarness> {
  var status = AgentAnswerStatus.streaming;
  var stream = 0;
  void complete() => setState(() => status = AgentAnswerStatus.complete);
  void restart() => setState(() {
    stream++;
    status = AgentAnswerStatus.streaming;
  });
  @override
  Widget build(BuildContext context) => AgentAnswer(
    streamId: stream,
    status: status,
    showActions: true,
    onCopy: () {},
    sourcesContent: const Text('source body'),
    child: const Text('answer'),
  );
}
