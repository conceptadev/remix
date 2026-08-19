import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

const _triggerKey = ValueKey('agent-plan-trigger');

final _chevron = find.byWidgetPredicate(
  (widget) => widget is CustomPaint && widget.size == const Size(8, 8),
);

void main() {
  testWidgets('stays open while items are active and collapses when done', (
    tester,
  ) async {
    final key = GlobalKey<_PlanHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: _PlanHarness(key: key)),
    );

    expect(find.text('Inspect the flow'), findsOneWidget);
    expect(find.text('0/2'), findsOneWidget);

    key.currentState!.completeAll();
    await tester.pump();

    expect(find.text('Inspect the flow'), findsNothing);
    expect(find.text('2/2'), findsOneWidget);
  });

  testWidgets('rows stay on one 36 line with trailing detail and a strike', (
    tester,
  ) async {
    const longTitle =
        'A very long plan title that would wrap without truncation';
    const longHeading =
        'A very long plan heading that would wrap without truncation';
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentPlan(
          title: longHeading,
          items: [
            AgentPlanItem(
              id: 'live',
              title: longTitle,
              detail: '2.1s',
              status: AgentPlanItemStatus.inProgress,
            ),
            AgentPlanItem(
              id: 'done',
              title: 'Done step',
              status: AgentPlanItemStatus.completed,
            ),
            AgentPlanItem(
              id: 'skip',
              title: 'Skip step',
              status: AgentPlanItemStatus.cancelled,
            ),
          ],
        ),
      ),
    );

    expect(
      tester.getSize(find.byKey(const ValueKey('agent-plan-item-live'))).height,
      greaterThanOrEqualTo(36),
    );
    expect(
      tester.getSize(find.byKey(const ValueKey('agent-plan-item-done'))).height,
      greaterThanOrEqualTo(36),
    );

    expect(tester.getSize(find.byKey(_triggerKey)).height, 36);

    final heading = tester.widget<Text>(find.text(longHeading));
    expect(heading.maxLines, 1);
    expect(heading.overflow, TextOverflow.ellipsis);
    final headingRect = tester.getRect(find.text(longHeading));
    final countRect = tester.getRect(find.text('1/3'));
    expect(countRect.left - headingRect.right, closeTo(10, 1));

    final liveTitle = tester.widget<Text>(find.text(longTitle));
    expect(liveTitle.maxLines, 1);
    expect(liveTitle.overflow, TextOverflow.ellipsis);

    final titleRect = tester.getRect(find.text(longTitle));
    final detailRect = tester.getRect(find.text('2.1s'));
    expect(detailRect.center.dy, closeTo(titleRect.center.dy, 2));
    expect(detailRect.left, greaterThan(titleRect.left));
    final detailStyle = tester
        .renderObject<RenderParagraph>(find.text('2.1s'))
        .text
        .style!;
    expect(detailStyle.fontSize, 14);
    expect(detailStyle.color!.a, closeTo(0.55, 0.02));

    final live = tester.renderObject<RenderParagraph>(find.text(longTitle));
    final done = tester.renderObject<RenderParagraph>(find.text('Done step'));
    final skip = tester.renderObject<RenderParagraph>(find.text('Skip step'));
    expect(done.text.style!.color!.a, lessThan(live.text.style!.color!.a));
    expect(done.text.style!.decoration, TextDecoration.lineThrough);
    expect(done.text.style!.decorationThickness, 1);
    expect(skip.text.style!.decoration, TextDecoration.none);

    final row = tester.getRect(
      find.byKey(const ValueKey('agent-plan-item-live')),
    );
    final mark = tester.getRect(
      find.descendant(
        of: find.byKey(const ValueKey('agent-plan-item-live')),
        matching: find.byType(CustomPaint),
      ),
    );
    expect(mark.center.dy, closeTo(row.center.dy, 1));
    expect(tester.getTopLeft(_chevron).dx, closeTo(mark.left, 1));

    final viewport = tester.getRect(
      find.byKey(const ValueKey('agent-plan-viewport')),
    );
    expect(row.left - viewport.left, closeTo(8, 2));
    expect(viewport.right - row.right, closeTo(8, 2));

    final count = tester.renderObject<RenderParagraph>(find.text('1/3'));
    expect(count.text.style!.fontSize, 12);
    expect(count.text.style!.fontWeight, FontWeight.w500);
    expect(
      count.text.style!.fontFeatures,
      contains(const FontFeature.tabularFigures()),
    );
  });

  testWidgets('empty list shows muted copy and stays open', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(width: 400, child: AgentPlan(items: [])),
    );

    expect(find.text('No tasks yet'), findsOneWidget);
    expect(find.text('0/0'), findsOneWidget);
    expect(
      tester
          .renderObject<RenderParagraph>(find.text('No tasks yet'))
          .text
          .style!
          .fontSize,
      14,
    );

    final viewport = tester.getRect(
      find.byKey(const ValueKey('agent-plan-viewport')),
    );
    final empty = tester.getRect(find.text('No tasks yet'));
    expect(empty.left - viewport.left, closeTo(14, 2));
  });

  testWidgets('caps the list at 248 and follows the live edge', (tester) async {
    final key = GlobalKey<_GrowingPlanState>();
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: _GrowingPlan(key: key)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.getSize(find.byKey(const ValueKey('agent-plan-viewport'))).height,
      kAgentPlanViewportHeight,
    );

    final position = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(position.pixels, closeTo(position.maxScrollExtent, 2));

    key.currentState!.addItem();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.getSize(find.byKey(const ValueKey('agent-plan-viewport'))).height,
      kAgentPlanViewportHeight,
    );
    expect(position.pixels, closeTo(position.maxScrollExtent, 2));
    expect(find.text('Step 8'), findsOneWidget);
  });

  testWidgets('summary chevron brightens on hover', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentPlan(
          items: [
            AgentPlanItem(
              id: 'done',
              title: 'Done step',
              status: AgentPlanItemStatus.completed,
            ),
          ],
        ),
      ),
    );

    Opacity opacityOf() {
      return tester.widget<Opacity>(
        find.ancestor(of: _chevron, matching: find.byType(Opacity)),
      );
    }

    expect(opacityOf().opacity, 0.5);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();
    await gesture.moveTo(tester.getCenter(find.byKey(_triggerKey)));
    await tester.pump();

    expect(opacityOf().opacity, 1);
  });

  testWidgets('summary paints a 2px inset focus-visible ring', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(
        width: 400,
        child: AgentPlan(
          items: [
            AgentPlanItem(
              id: 'done',
              title: 'Done step',
              status: AgentPlanItemStatus.completed,
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
    expect(border.top.strokeAlign, BorderSide.strokeAlignInside);
    expect(decoration.borderRadius, BorderRadius.circular(6));
  });
}

class _PlanHarness extends StatefulWidget {
  const _PlanHarness({super.key});

  @override
  State<_PlanHarness> createState() => _PlanHarnessState();
}

class _PlanHarnessState extends State<_PlanHarness> {
  var items = const [
    AgentPlanItem(
      id: 'a',
      title: 'Inspect the flow',
      status: AgentPlanItemStatus.inProgress,
    ),
    AgentPlanItem(id: 'b', title: 'Write the patch'),
  ];

  void completeAll() {
    setState(() {
      items = const [
        AgentPlanItem(
          id: 'a',
          title: 'Inspect the flow',
          status: AgentPlanItemStatus.completed,
        ),
        AgentPlanItem(
          id: 'b',
          title: 'Write the patch',
          status: AgentPlanItemStatus.completed,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AgentPlan(items: items);
  }
}

class _GrowingPlan extends StatefulWidget {
  const _GrowingPlan({super.key});

  @override
  State<_GrowingPlan> createState() => _GrowingPlanState();
}

class _GrowingPlanState extends State<_GrowingPlan> {
  var _count = 8;

  void addItem() => setState(() => _count += 1);

  @override
  Widget build(BuildContext context) {
    return AgentPlan(
      items: [
        for (var i = 0; i < _count; i++)
          AgentPlanItem(
            id: '$i',
            title: 'Step $i',
            status: i == _count - 1
                ? AgentPlanItemStatus.inProgress
                : AgentPlanItemStatus.pending,
          ),
      ],
    );
  }
}
