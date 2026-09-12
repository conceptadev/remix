import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  test('generated specs are empty and merge named slots', () {
    const empty = AgentComposerSpec();
    expect(empty.toolbar.spec, const FlexBoxSpec());

    final merged = AgentPlanStyler(
      summaryTitle: TextStyler().fontSize(14),
    ).merge(AgentPlanStyler(itemDetail: TextStyler().fontSize(12)));
    expect(merged.$summaryTitle, isNotNull);
    expect(merged.$itemDetail, isNotNull);
  });

  testWidgets('styleSpec bypass applies resolved nested slots', (tester) async {
    const spec = AgentMessageSpec(maxWidth: 120);
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentMessage(
          role: AgentRole.user,
          styleSpec: spec,
          child: Text('message'),
        ),
      ),
    );
    expect(tester.getSize(find.text('message')).width, lessThanOrEqualTo(120));
  });

  testWidgets('message is unclamped unless wrapper overflows', (tester) async {
    expect(
      const AgentMessage(role: AgentRole.assistant, child: Text('x')).maxWidth,
      isNull,
    );
    await pumpAgent(
      tester,
      AgentMessageCollapsible(
        style: AgentMessageCollapsibleStyler(collapsedHeight: 20),
        child: const SizedBox(height: 100, child: Text('long copy')),
      ),
    );
    await tester.pump();
    expect(find.text('Show more'), findsOneWidget);
    await tester.tap(find.text('Show more'));
    await tester.pump();
    expect(find.text('Show less'), findsOneWidget);
  });

  testWidgets('lazy transcript is chronological and swaps controllers', (
    tester,
  ) async {
    final first = ScrollController();
    final second = ScrollController();
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    final key = GlobalKey<_TranscriptHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(
        height: 120,
        width: 300,
        child: _TranscriptHarness(key: key, first: first, second: second),
      ),
    );
    await tester.pump();
    expect(find.text('Item 0'), findsOneWidget);
    expect(first.hasClients, isTrue);
    key.currentState!.swap();
    await tester.pump();
    expect(second.hasClients, isTrue);
    expect(first.hasClients, isFalse);
  });

  testWidgets('nested scroll notifications do not release live edge', (
    tester,
  ) async {
    final changes = <bool>[];
    await pumpAgent(
      tester,
      SizedBox(
        height: 140,
        width: 300,
        child: AgentTranscript(
          onFollowChanged: changes.add,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 80,
              child: ListView(children: const [SizedBox(height: 240)]),
            ),
          ],
        ),
      ),
    );
    await tester.drag(find.byType(ListView).last, const Offset(0, -40));
    await tester.pump();
    expect(changes, isEmpty);
  });

  testWidgets('transcript container is not a duplicate live region', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pumpAgent(
      tester,
      SizedBox(
        height: 100,
        child: AgentTranscript(
          busy: true,
          children: [Semantics(liveRegion: true, child: const Text('leaf'))],
        ),
      ),
    );
    final node = tester.getSemantics(find.bySemanticsLabel('Conversation'));
    expect(node.getSemanticsData().flagsCollection.isLiveRegion, isFalse);
    handle.dispose();
  });

  testWidgets('a focused transcript resolves host focus styling', (
    tester,
  ) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    await pumpAgent(
      tester,
      SizedBox(
        height: 120,
        width: 300,
        child: AgentTranscript(
          followOutput: false,
          style: AgentTranscriptStyler(
            viewport: BoxStyler().onFocused(BoxStyler().paddingLeft(40)),
          ),
          children: [Focus(focusNode: focusNode, child: const Text('leaf'))],
        ),
      ),
    );
    final unfocused = tester.getTopLeft(find.text('leaf')).dx;

    focusNode.requestFocus();
    await tester.pump();

    // Mix tracks pointer states on its own, but `focused` needs a controller,
    // and Agent's slots resolve above any Naked control. Until the transcript
    // published its own focus there was no source for this state, so a host's
    // focus styling on the viewport could never activate.
    expect(tester.getTopLeft(find.text('leaf')).dx, unfocused + 40);
  });
}

class _TranscriptHarness extends StatefulWidget {
  const _TranscriptHarness({
    super.key,
    required this.first,
    required this.second,
  });
  final ScrollController first;
  final ScrollController second;
  @override
  State<_TranscriptHarness> createState() => _TranscriptHarnessState();
}

class _TranscriptHarnessState extends State<_TranscriptHarness> {
  var swapped = false;
  void swap() => setState(() => swapped = true);
  @override
  Widget build(BuildContext context) => AgentTranscript.builder(
    controller: swapped ? widget.second : widget.first,
    followOutput: false,
    itemCount: 100,
    itemBuilder: (_, index) => SizedBox(height: 24, child: Text('Item $index')),
  );
}
