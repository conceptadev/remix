import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

const _triggerKey = ValueKey('agent-execution-trigger');
const _iconKey = ValueKey('agent-execution-icon');
const _chevronKey = ValueKey('agent-execution-chevron');
const _statusMarkKey = ValueKey('agent-execution-status-mark');
const _wellKey = ValueKey('agent-execution-well');
const _footerKey = ValueKey('agent-execution-footer');
const _copyKey = ValueKey('agent-execution-copy');
const _retryKey = ValueKey('agent-execution-retry');

void main() {
  testWidgets('stays open while running and collapses when complete', (
    tester,
  ) async {
    final key = GlobalKey<_ExecutionHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: _ExecutionHarness(key: key)),
    );

    expect(find.text('ok 12'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
    expect(find.text('terminal.run'), findsOneWidget);
    expect(find.text('Running'), findsOneWidget);
    expect(find.text('Success'), findsNothing);

    key.currentState!.status = AgentExecutionStatus.success;
    await tester.pump();

    expect(find.text('ok 12'), findsNothing);
    expect(find.text('Tests'), findsOneWidget);
    expect(find.text('terminal.run'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.text('Success'), findsNothing);
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('settled execution can reopen', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentExecution(
          tool: 'http.request',
          title: 'Fetch',
          status: AgentExecutionStatus.success,
          child: Text('200 OK'),
        ),
      ),
    );

    expect(find.text('200 OK'), findsNothing);
    expect(find.text('Show'), findsNothing);
    expect(find.text('Hide'), findsNothing);
    expect(find.text('http.request'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);

    await tester.tap(find.text('Fetch'));
    await tester.pump();

    expect(find.text('200 OK'), findsOneWidget);
    expect(find.text('Show'), findsNothing);
    expect(find.text('Hide'), findsNothing);
  });

  testWidgets('keeps status when meta is set and uses Failed', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentExecution(
          tool: 'http.request',
          title: 'Fetch',
          meta: '2.1s',
          status: AgentExecutionStatus.error,
          child: Text('boom'),
        ),
      ),
    );

    expect(find.text('2.1s'), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
    expect(find.text('Error'), findsNothing);
    expect(find.text('Completed'), findsNothing);
  });

  testWidgets('floors the trigger, indents the well, and hosts the footer', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentExecution(
          tool: 'terminal.run',
          title:
              'A very long execution title that would wrap without truncation',
          meta: '2.1s',
          status: AgentExecutionStatus.success,
          open: true,
          collapseOnComplete: false,
          copyAction: Text('Copy'),
          retryAction: Text('Retry'),
          child: Text('ok 12'),
        ),
      ),
    );

    final trigger = tester.getSize(find.byKey(_triggerKey));
    expect(trigger.height, 36);

    final title = tester.widget<Text>(
      find.text(
        'A very long execution title that would wrap without truncation',
      ),
    );
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(title.style?.fontSize, 14);
    expect(title.style?.fontWeight, FontWeight.w500);
    expect(title.style?.color, const Color(0xFF18181B).withValues(alpha: 0.90));

    final tool = tester.widget<Text>(find.text('terminal.run'));
    expect(tool.maxLines, 1);
    expect(tool.overflow, TextOverflow.ellipsis);
    expect(tool.style?.fontSize, 11);
    expect(tool.style?.fontFamily, 'monospace');

    final status = tester.renderObject<RenderParagraph>(
      find.text('Completed').first,
    );
    expect(status.text.style?.fontSize, 11);
    expect(status.text.style?.fontWeight, FontWeight.w500);

    expect(tester.getSize(find.byKey(_iconKey)), const Size(16, 16));
    expect(tester.getSize(find.byKey(_statusMarkKey)), const Size(12, 12));
    expect(tester.getSize(find.byKey(_chevronKey)), const Size(14, 14));

    final exec = tester.getRect(find.byType(AgentExecution));
    final triggerRect = tester.getRect(find.byKey(_triggerKey));
    final well = tester.getRect(find.byKey(_wellKey));
    final titleLeft = tester.getTopLeft(find.text(title.data!)).dx;
    final markRect = tester.getRect(find.byKey(_statusMarkKey));
    final statusRect = tester.getRect(find.text('Completed').first);
    final chevronRect = tester.getRect(find.byKey(_chevronKey));
    expect(well.left - exec.left, closeTo(24, 1));
    expect(titleLeft, closeTo(well.left, 1));
    expect(well.top - triggerRect.bottom, closeTo(6, 1));
    expect(statusRect.left - markRect.right, closeTo(4, 1));
    expect(chevronRect.left, greaterThan(statusRect.right));
    expect(markRect.left, greaterThan(titleLeft));

    final log = tester.renderObject<RenderParagraph>(find.text('ok 12'));
    expect(log.text.style?.fontSize, 14);
    expect(
      log.text.style?.color,
      const Color(0xFF18181B).withValues(alpha: 0.80),
    );
    expect(log.text.style?.fontFamily, 'monospace');

    final logRect = tester.getRect(find.text('ok 12'));
    expect(logRect.left - well.left, closeTo(12, 1.5));
    expect(logRect.top - well.top, closeTo(12, 1.5));

    final footer = tester.getRect(find.byKey(_footerKey));
    final copy = tester.getRect(find.byKey(_copyKey));
    final retry = tester.getRect(find.byKey(_retryKey));
    expect(copy.size, const Size(kAgentActionSize, kAgentActionSize));
    expect(retry.size, const Size(kAgentActionSize, kAgentActionSize));
    expect(footer.top, greaterThan(well.top));
    expect(footer.bottom, closeTo(well.bottom, 0.5));
    expect(copy.left - well.left, closeTo(8, 1.5));
    expect(retry.left - copy.right, closeTo(2, 1));
    expect(well.bottom - copy.bottom, closeTo(6, 1.5));

    expect(find.text('Completed'), findsNWidgets(2));
  });

  testWidgets('trigger paints a 2px inset focus-visible ring', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentExecution(
          tool: 'terminal.run',
          title: 'Tests',
          status: AgentExecutionStatus.success,
          child: Text('ok 12'),
        ),
      ),
    );

    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
    addTearDown(() {
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.automatic;
    });

    final node = Focus.of(tester.element(find.byKey(_triggerKey)));
    node.requestFocus();
    await tester.pump();
    await tester.pump();

    final ringed = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byKey(_triggerKey),
            matching: find.byType(Container),
          ),
        )
        .where((container) => container.foregroundDecoration != null);
    expect(ringed, isNotEmpty);
    final decoration = ringed.first.foregroundDecoration! as BoxDecoration;
    final border = decoration.border! as Border;
    expect(border.top.width, kAgentFocusRingWidth);
    expect(border.top.color, const Color(0xFF18181B));
    expect(border.top.strokeAlign, BorderSide.strokeAlignInside);
    expect(decoration.borderRadius, BorderRadius.circular(6));
  });
}

class _ExecutionHarness extends StatefulWidget {
  const _ExecutionHarness({super.key});

  @override
  State<_ExecutionHarness> createState() => _ExecutionHarnessState();
}

class _ExecutionHarnessState extends State<_ExecutionHarness> {
  var _status = AgentExecutionStatus.running;

  set status(AgentExecutionStatus value) {
    setState(() => _status = value);
  }

  @override
  Widget build(BuildContext context) {
    return AgentExecution(
      tool: 'terminal.run',
      title: 'Tests',
      status: _status,
      child: const Text('ok 12'),
      retryAction: const Text('Retry'),
    );
  }
}
