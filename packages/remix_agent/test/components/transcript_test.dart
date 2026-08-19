import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  testWidgets('follows growth at the live edge and releases on user scroll', (
    tester,
  ) async {
    final following = <bool>[];
    final key = GlobalKey<_LineTranscriptState>();

    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 180,
          child: _LineTranscript(key: key, onFollowChange: following.add),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final transcript = tester.state<AgentTranscriptState>(
      find.byType(AgentTranscript),
    );
    expect(transcript.controller.hasClients, isTrue);
    expect(
      transcript.controller.offset,
      closeTo(transcript.controller.position.maxScrollExtent, 2),
    );

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 240));
    await tester.pump();
    expect(transcript.policy.following, isFalse);
    expect(following, contains(false));

    final offsetAfterLeave = transcript.controller.offset;
    key.currentState!.lineCount = 30;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(transcript.policy.following, isFalse);
    expect(transcript.controller.offset, closeTo(offsetAfterLeave, 8));
    expect(
      transcript.controller.position.maxScrollExtent -
          transcript.controller.offset,
      greaterThan(56),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -800),
    );
    await tester.pump();
    expect(transcript.policy.following, isTrue);

    key.currentState!.lineCount = 40;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(
      transcript.controller.offset,
      closeTo(transcript.controller.position.maxScrollExtent, 2),
    );
  });

  testWidgets('nested scrollables do not release follow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 180,
          child: AgentTranscript(
            child: Column(
              children: [
                for (var i = 0; i < 16; i++)
                  SizedBox(height: 24, child: Text('Outer $i')),
                SizedBox(
                  height: 80,
                  child: ListView(
                    children: [for (var i = 0; i < 12; i++) Text('Inner $i')],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final state = tester.state<AgentTranscriptState>(
      find.byType(AgentTranscript),
    );
    expect(state.policy.following, isTrue);

    await tester.drag(find.text('Inner 0'), const Offset(0, -40));
    await tester.pump();
    expect(state.policy.following, isTrue);
  });

  testWidgets('reduced motion jumps to the live edge', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 160,
          child: AgentTranscript(
            child: Column(
              children: [
                for (var i = 0; i < 20; i++)
                  SizedBox(height: 24, child: Text('Jump $i')),
              ],
            ),
          ),
        ),
        disableAnimations: true,
      ),
    );
    await tester.pump();

    final state = tester.state<AgentTranscriptState>(
      find.byType(AgentTranscript),
    );
    expect(
      state.controller.offset,
      closeTo(state.controller.position.maxScrollExtent, 2),
    );
  });

  testWidgets('clips overflow at the viewport edge', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 160,
          child: AgentTranscript(
            child: Column(
              children: [
                for (var i = 0; i < 20; i++)
                  SizedBox(height: 24, child: Text('Clip $i')),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.getSize(find.byType(AgentTranscript)), const Size(300, 160));
    expect(
      find.descendant(
        of: find.byType(AgentTranscript),
        matching: find.byType(ClipRect),
      ),
      findsWidgets,
    );
  });

  testWidgets('fills a bounded host when content is shorter', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        const SizedBox(
          width: 300,
          height: 180,
          child: AgentTranscript(
            child: SizedBox(height: 40, child: Text('short')),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.getSize(find.byType(AgentTranscript)), const Size(300, 180));
  });

  testWidgets('reserves a stable end gutter', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        const SizedBox(
          width: 300,
          height: 180,
          child: AgentTranscript(
            child: ColoredBox(
              key: ValueKey('transcript-line'),
              color: Color(0xFF000000),
              child: SizedBox(height: 24, width: double.infinity),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      tester.getSize(find.byType(AgentTranscript)).width -
          tester.getSize(find.byKey(const ValueKey('transcript-line'))).width,
      closeTo(kAgentScrollbarGutter, 0.5),
    );
  });

  testWidgets('contains overscroll so a parent log does not chain', (
    tester,
  ) async {
    final parent = ScrollController();
    addTearDown(parent.dispose);

    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 200,
          child: SingleChildScrollView(
            controller: parent,
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: AgentTranscript(
                    followOutput: false,
                    child: Column(
                      children: [
                        for (var i = 0; i < 20; i++)
                          SizedBox(height: 24, child: Text('Over $i')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 400, child: Text('below')),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      tester
          .widget<SingleChildScrollView>(
            find.descendant(
              of: find.byType(AgentTranscript),
              matching: find.byType(SingleChildScrollView),
            ),
          )
          .physics,
      isA<ClampingScrollPhysics>(),
    );

    await tester.drag(find.text('Over 0'), const Offset(0, 120));
    await tester.pump();
    expect(parent.offset, 0);
  });

  testWidgets('is keyboard-focusable and paints an inset host-ink ring', (
    tester,
  ) async {
    final previous = FocusManager.instance.highlightStrategy;
    addTearDown(() {
      FocusManager.instance.highlightStrategy = previous;
    });
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;

    await tester.binding.setSurfaceSize(const Size(400, 240));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _widgetsHost(
        SizedBox(
          width: 300,
          height: 160,
          child: AgentTranscript(
            child: Column(
              children: [
                for (var i = 0; i < 20; i++)
                  SizedBox(height: 24, child: Text('Focus $i')),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final transcript = tester.state<AgentTranscriptState>(
      find.byType(AgentTranscript),
    );
    expect(
      transcript.controller.offset,
      closeTo(transcript.controller.position.maxScrollExtent, 2),
    );

    final box = find.descendant(
      of: find.byType(AgentTranscript),
      matching: find.byType(Box),
    );
    final node = Focus.of(tester.element(box.first));
    node.requestFocus();
    await tester.pump();
    await tester.pump();
    expect(
      node.hasPrimaryFocus,
      isTrue,
      reason: 'viewport should take keyboard focus',
    );

    final ringed = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byType(AgentTranscript),
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

    await tester.sendKeyEvent(LogicalKeyboardKey.home);
    await tester.pump();
    expect(transcript.policy.following, isFalse);
    expect(transcript.controller.offset, closeTo(0, 2));
  });
}

class _LineTranscript extends StatefulWidget {
  const _LineTranscript({super.key, this.onFollowChange});

  final ValueChanged<bool>? onFollowChange;

  @override
  State<_LineTranscript> createState() => _LineTranscriptState();
}

class _LineTranscriptState extends State<_LineTranscript> {
  var _lineCount = 20;

  int get lineCount => _lineCount;

  set lineCount(int value) {
    setState(() => _lineCount = value);
  }

  @override
  Widget build(BuildContext context) {
    return AgentTranscript(
      followOutput: true,
      followThreshold: 56,
      onFollowChange: widget.onFollowChange,
      child: Column(
        children: [
          for (var i = 0; i < _lineCount; i++)
            SizedBox(height: 24, child: Text('Line $i')),
        ],
      ),
    );
  }
}

Widget _widgetsHost(Widget child, {bool disableAnimations = false}) {
  return MixScope.empty(
    child: MediaQuery(
      data: MediaQueryData(
        size: const Size(400, 240),
        disableAnimations: disableAnimations,
      ),
      child: WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (_, _) {
          return DefaultTextStyle(
            style: const TextStyle(color: Color(0xFF18181B), fontSize: 14),
            child: Align(alignment: Alignment.topLeft, child: child),
          );
        },
      ),
    ),
  );
}
