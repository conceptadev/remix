import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

const _actionsKey = ValueKey('agent-answer-actions');
const _copyKey = ValueKey('agent-answer-copy');
const _retryKey = ValueKey('agent-answer-retry');
const _feedbackKey = ValueKey('agent-answer-feedback');
const _sourcesKey = ValueKey('agent-answer-sources');
const _sourcesWellKey = ValueKey('agent-answer-sources-well');

void main() {
  testWidgets('hides completion actions while streaming', (tester) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.streaming,
        copyAction: RemixTextAction(label: 'Copy', onPressed: () {}),
        retryAction: RemixTextAction(label: 'Retry', onPressed: () {}),
        feedback: const Text('Up'),
        sources: const Text('Sources'),
        sourcesContent: const Text('Brief'),
        child: const Text('partial'),
      ),
    );

    expect(find.text('partial'), findsOneWidget);
    expect(find.text('Copy'), findsNothing);
    expect(find.text('Retry'), findsNothing);
    expect(find.text('Up'), findsNothing);
    expect(find.text('Sources'), findsNothing);
    expect(find.text('Brief'), findsNothing);
  });

  testWidgets('shows completion actions when complete or errored', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.complete,
        copyAction: RemixTextAction(label: 'Copy', onPressed: () {}),
        retryAction: RemixTextAction(label: 'Retry', onPressed: () {}),
        sources: const Text('Sources'),
        child: const Text('done'),
      ),
    );

    expect(find.text('Copy'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Sources'), findsOneWidget);
  });

  testWidgets('host can hide actions after complete', (tester) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.complete,
        showActions: false,
        copyAction: RemixTextAction(label: 'Copy', onPressed: () {}),
        retryAction: RemixTextAction(label: 'Retry', onPressed: () {}),
        sources: const Text('Sources'),
        child: const Text('done'),
      ),
    );

    expect(find.text('done'), findsOneWidget);
    expect(find.text('Copy'), findsNothing);
    expect(find.text('Retry'), findsNothing);
    expect(find.text('Sources'), findsNothing);
  });

  testWidgets('body is a 14/24 run at 90% host ink', (tester) async {
    await pumpAgent(tester, const AgentAnswer(child: Text('done')));

    final body = tester.renderObject<RenderParagraph>(find.text('done'));
    expect(body.text.style?.fontSize, 14);
    expect(body.text.style?.height, 24 / 14);
    expect(
      body.text.style?.color,
      const Color(0xFF18181B).withValues(alpha: 0.90),
    );
  });

  testWidgets('completion chrome is one 12px-offset row', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentAnswer(
          status: AgentAnswerStatus.complete,
          copyAction: SizedBox(width: 14, height: 14, child: Text('Copy')),
          retryAction: SizedBox(width: 14, height: 14, child: Text('Retry')),
          feedback: Text('Up'),
          sources: Text('Sources'),
          sourcesContent: Text('Brief'),
          child: Text('done'),
        ),
      ),
    );

    final body = tester.getRect(find.text('done'));
    final actions = tester.getRect(find.byKey(_actionsKey));
    final copy = tester.getSize(find.byKey(_copyKey));
    final retry = tester.getRect(find.byKey(_retryKey));
    final copyRect = tester.getRect(find.byKey(_copyKey));
    final feedback = tester.getRect(find.byKey(_feedbackKey));
    final sources = tester.getRect(find.byKey(_sourcesKey));
    final sourcesText = tester.getRect(find.text('Sources'));
    final well = tester.getRect(find.byKey(_sourcesWellKey));
    final brief = tester.getRect(find.text('Brief'));

    expect(actions.top - body.bottom, closeTo(12, 1));
    expect(copy, const Size(kAgentActionSize, kAgentActionSize));
    expect(retry.size, const Size(kAgentActionSize, kAgentActionSize));
    expect(retry.left - copyRect.right, closeTo(2, 1));
    expect(feedback.left - retry.right, closeTo(2, 1));
    expect(feedback.height, greaterThanOrEqualTo(kAgentActionSize));
    expect(sources.left - feedback.right, closeTo(2, 1));
    expect(sources.height, greaterThanOrEqualTo(kAgentActionSize));
    expect(sourcesText.left - sources.left, closeTo(6, 1));
    expect(sources.width, lessThan(actions.width * 0.5));

    final sourcesRun = tester.renderObject<RenderParagraph>(
      find.text('Sources'),
    );
    expect(sourcesRun.text.style?.fontSize, 12);
    expect(
      sourcesRun.text.style?.color,
      const Color(0xFF18181B).withValues(alpha: 0.62),
    );

    expect(well.top - actions.bottom, closeTo(8, 1));
    expect(brief.left - well.left, closeTo(8, 1.5));
    expect(brief.top - well.top, closeTo(8, 1.5));
  });

  testWidgets('feedback paints only when complete', (tester) async {
    await pumpAgent(
      tester,
      const AgentAnswer(
        status: AgentAnswerStatus.error,
        copyAction: Text('Copy'),
        feedback: Text('Up'),
        sources: Text('Sources'),
        child: Text('fail'),
      ),
    );

    expect(find.text('Copy'), findsOneWidget);
    expect(find.text('Sources'), findsOneWidget);
    expect(find.text('Up'), findsNothing);
    expect(find.byKey(_feedbackKey), findsNothing);

    await pumpAgent(
      tester,
      const AgentAnswer(
        status: AgentAnswerStatus.complete,
        feedback: Text('Up'),
        child: Text('done'),
      ),
    );

    expect(find.text('Up'), findsOneWidget);
  });

  testWidgets('action and sources chrome lift muted copy to ink on hover', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentAnswer(
          status: AgentAnswerStatus.complete,
          copyAction: Text('Copy'),
          sources: Text('Sources'),
          child: Text('done'),
        ),
      ),
    );

    Color colorOf(String label) {
      return tester
          .renderObject<RenderParagraph>(find.text(label))
          .text
          .style!
          .color!;
    }

    expect(colorOf('Copy'), const Color(0xFF18181B).withValues(alpha: 0.62));
    expect(colorOf('Sources'), const Color(0xFF18181B).withValues(alpha: 0.62));

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byKey(_copyKey)));
    await tester.pump();
    expect(colorOf('Copy'), const Color(0xFF18181B));

    await gesture.moveTo(tester.getCenter(find.byKey(_sourcesKey)));
    await tester.pump();
    expect(colorOf('Sources'), const Color(0xFF18181B));
  });

  testWidgets(
    'action and sources chrome paint a 2px inset focus-visible ring',
    (tester) async {
      await pumpAgent(
        tester,
        const SizedBox(
          width: 400,
          child: AgentAnswer(
            status: AgentAnswerStatus.complete,
            copyAction: Text('Copy'),
            sources: Text('Sources'),
            child: Text('done'),
          ),
        ),
      );

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
      addTearDown(() {
        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.automatic;
      });

      Future<void> expectRing(ValueKey<String> key) async {
        final node = Focus.of(tester.element(find.byKey(key)));
        node.requestFocus();
        await tester.pump();
        await tester.pump();

        final ringed = tester
            .widgetList<Container>(
              find.descendant(
                of: find.byKey(key),
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
      }

      await expectRing(_copyKey);
      await expectRing(_sourcesKey);
    },
  );
}

class RemixTextAction extends StatelessWidget {
  const RemixTextAction({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onPressed, child: Text(label));
  }
}
