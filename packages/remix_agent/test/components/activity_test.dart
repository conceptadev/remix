import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

const _triggerKey = ValueKey('agent-activity-trigger');

final _chevron = find.byWidgetPredicate(
  (widget) => widget is CustomPaint && widget.size == const Size(8, 8),
);

void main() {
  testWidgets('follows while working and collapses when complete', (
    tester,
  ) async {
    final key = GlobalKey<_ActivityHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: _ActivityHarness(key: key)),
    );

    expect(find.text('Reading the brief'), findsOneWidget);
    expect(find.text('detail child'), findsOneWidget);

    key.currentState!.status = AgentRunStatus.complete;
    await tester.pumpAndSettle();

    expect(find.text('Reading the brief'), findsNothing);
    expect(find.text('Activity'), findsOneWidget);
  });

  testWidgets('rows are at least 36 tall and completed type is quieter', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          items: [
            AgentActivityItem(
              id: 'live',
              title: 'Live activity',
              status: AgentActivityItemStatus.active,
            ),
            AgentActivityItem(
              id: 'done',
              title: 'Done activity',
              status: AgentActivityItemStatus.complete,
            ),
          ],
        ),
      ),
    );

    expect(
      tester
          .getSize(find.byKey(const ValueKey('agent-activity-item-live')))
          .height,
      greaterThanOrEqualTo(36),
    );

    final live = tester.renderObject<RenderParagraph>(
      find.text('Live activity'),
    );
    final done = tester.renderObject<RenderParagraph>(
      find.text('Done activity'),
    );
    expect(done.text.style!.color!.a, lessThan(live.text.style!.color!.a));
  });

  testWidgets('working chrome is a 28px muted title with no chevron', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          title: 'Mapping the path',
          items: [
            AgentActivityItem(
              id: '1',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.active,
            ),
          ],
        ),
      ),
    );

    expect(tester.getSize(find.byKey(_triggerKey)).height, 28);
    expect(_chevron, findsNothing);

    final label = tester.renderObject<RenderParagraph>(
      find.text('Mapping the path'),
    );
    expect(label.text.style!.fontSize, 14);
    expect(label.text.style!.fontWeight, FontWeight.w400);
    expect(label.text.style!.color!.a, lessThan(1));
  });

  testWidgets('completed trigger is 28px 14/medium with a trailing chevron', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          status: AgentRunStatus.complete,
          items: [
            AgentActivityItem(
              id: '1',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.complete,
            ),
          ],
        ),
      ),
    );

    expect(tester.getSize(find.byKey(_triggerKey)).height, 28);
    expect(tester.getSize(find.byKey(_triggerKey)).width, lessThan(400));
    expect(_chevron, findsOneWidget);

    final title = tester.renderObject<RenderParagraph>(find.text('Activity'));
    expect(title.text.style!.fontSize, 14);
    expect(title.text.style!.fontWeight, FontWeight.w500);
    expect(title.text.style!.color!.a, lessThan(1));

    final titleRight = tester.getTopRight(find.text('Activity')).dx;
    final chevronLeft = tester.getTopLeft(_chevron).dx;
    expect(chevronLeft - titleRight, closeTo(6, 1));
  });

  testWidgets('completed trigger hovers muted to ink', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          status: AgentRunStatus.complete,
          items: [
            AgentActivityItem(
              id: '1',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.complete,
            ),
          ],
        ),
      ),
    );

    final idle = tester
        .renderObject<RenderParagraph>(find.text('Activity'))
        .text
        .style!
        .color!;
    expect(idle, isNot(const Color(0xFF18181B)));

    Opacity chevronOpacity() {
      return tester.widget<Opacity>(
        find.ancestor(of: _chevron, matching: find.byType(Opacity)),
      );
    }

    expect(chevronOpacity().opacity, closeTo(idle.a * 0.70, 0.02));

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(find.byKey(_triggerKey)));
    await tester.pumpAndSettle();

    final hovered = tester
        .renderObject<RenderParagraph>(find.text('Activity'))
        .text
        .style!
        .color!;
    expect(hovered, const Color(0xFF18181B));
    expect(chevronOpacity().opacity, 1);
  });

  testWidgets('completed trigger paints a 2px focus-visible ring', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          status: AgentRunStatus.complete,
          items: [
            AgentActivityItem(
              id: '1',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.complete,
            ),
          ],
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
    expect(decoration.borderRadius, BorderRadius.circular(6));
  });

  testWidgets('ledger has 8px y-inset, 2px item gap, and 4px end pad', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentActivity(
          items: [
            AgentActivityItem(
              id: 'a',
              title: 'First',
              status: AgentActivityItemStatus.active,
            ),
            AgentActivityItem(
              id: 'b',
              title: 'Second',
              status: AgentActivityItemStatus.pending,
            ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    final viewport = tester.getRect(
      find.byKey(const ValueKey('agent-activity-viewport')),
    );
    final first = tester.getRect(
      find.byKey(const ValueKey('agent-activity-item-a')),
    );
    final second = tester.getRect(
      find.byKey(const ValueKey('agent-activity-item-b')),
    );
    expect(viewport.height, kAgentActivityViewportHeight);
    expect(first.top - viewport.top, closeTo(8, 1));
    expect(second.top - first.bottom, closeTo(2, 1));
    expect(viewport.right - first.right, closeTo(4, 1));
  });

  testWidgets('capped ledger fades overflow', (tester) async {
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentActivity(
          maxHeight: 80,
          items: [
            for (var i = 0; i < 8; i++)
              AgentActivityItem(
                id: '$i',
                title: 'Step $i',
                status: AgentActivityItemStatus.complete,
              ),
          ],
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byType(ShaderMask), findsOneWidget);
  });

  testWidgets('opening a completed ledger pins the viewport to the top', (
    tester,
  ) async {
    final key = GlobalKey<_ActivityHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: _ActivityHarness(key: key, itemCount: 12, maxHeight: 80),
      ),
    );
    await tester.pump();
    await tester.pump();

    final working = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(working.pixels, closeTo(working.maxScrollExtent, 2));

    key.currentState!.status = AgentRunStatus.complete;
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('agent-activity-viewport')), findsNothing);

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();

    final opened = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(opened.pixels, closeTo(0, 2));
  });
}

class _ActivityHarness extends StatefulWidget {
  const _ActivityHarness({super.key, this.itemCount = 1, this.maxHeight = 208});

  final int itemCount;
  final double maxHeight;

  @override
  State<_ActivityHarness> createState() => _ActivityHarnessState();
}

class _ActivityHarnessState extends State<_ActivityHarness> {
  var _status = AgentRunStatus.working;

  set status(AgentRunStatus value) {
    setState(() => _status = value);
  }

  @override
  Widget build(BuildContext context) {
    return AgentActivity(
      status: _status,
      maxHeight: widget.maxHeight,
      items: [
        for (var i = 0; i < widget.itemCount; i++)
          AgentActivityItem(
            id: '$i',
            title: i == 0 ? 'Reading the brief' : 'Step $i',
            status:
                i == widget.itemCount - 1 && _status == AgentRunStatus.working
                ? AgentActivityItemStatus.active
                : AgentActivityItemStatus.complete,
            child: i == 0 ? const Text('detail child') : null,
          ),
      ],
    );
  }
}
