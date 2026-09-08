import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

int _coloredItems(WidgetTester tester, Finder root, Color color) => tester
    .widgetList<DecoratedBox>(
      find.descendant(of: root, matching: find.byType(DecoratedBox)),
    )
    .where(
      (widget) =>
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == color,
    )
    .length;

void main() {
  testWidgets('transcript follows growth, releases, and reattaches', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    final key = GlobalKey<_GrowingTranscriptState>();
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 120,
        child: _GrowingTranscript(key: key, controller: controller),
      ),
    );
    await tester.pump();

    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );

    await tester.drag(find.byType(ListView), const Offset(0, 160));
    await tester.pump();
    expect(key.currentState!.changes, contains(false));
    final readingOffset = controller.offset;

    key.currentState!.grow();
    await tester.pump();
    await tester.pump();
    expect(controller.offset, closeTo(readingOffset, 0.5));

    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pump();
    expect(key.currentState!.changes, contains(true));
    key.currentState!.grow();
    await tester.pump();
    await tester.pump();
    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );
  });

  testWidgets('turning followOutput off leaves the reader position stable', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    final key = GlobalKey<_NonFollowingTranscriptState>();
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 120,
        child: _NonFollowingTranscript(key: key, controller: controller),
      ),
    );
    controller.jumpTo(60);
    final offset = controller.offset;

    key.currentState!.grow();
    await tester.pump();
    await tester.pump();

    expect(controller.offset, closeTo(offset, 0.5));
  });

  testWidgets('removing an external controller installs an owned controller', (
    tester,
  ) async {
    final external = ScrollController();
    addTearDown(external.dispose);
    final key = GlobalKey<_ControllerRemovalHarnessState>();
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 120,
        child: _ControllerRemovalHarness(key: key, external: external),
      ),
    );
    final first = tester.widget<ListView>(find.byType(ListView)).controller;
    expect(first, same(external));

    key.currentState!.remove();
    await tester.pump();
    final owned = tester.widget<ListView>(find.byType(ListView)).controller;

    expect(owned, isNot(same(external)));
    expect(owned!.hasClients, isTrue);
    expect(external.hasClients, isFalse);
  });

  testWidgets('static transcript applies item styling and spacing', (
    tester,
  ) async {
    const itemColor = Color(0xFFCC0000);
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 120,
        child: AgentTranscript(
          followOutput: false,
          style: AgentTranscriptStyler(
            item: BoxStyler().color(itemColor),
            spacing: 8,
          ),
          children: const [
            SizedBox(height: 20, child: Text('First')),
            SizedBox(height: 20, child: Text('Second')),
          ],
        ),
      ),
    );

    expect(_coloredItems(tester, find.byType(AgentTranscript), itemColor), 2);
    final first = tester.getRect(find.text('First'));
    final second = tester.getRect(find.text('Second'));
    expect(second.top - first.bottom, closeTo(8, 0.5));
  });

  testWidgets('lazy transcript applies the same item styling and spacing', (
    tester,
  ) async {
    const itemColor = Color(0xFFCC0000);
    await pumpAgent(
      tester,
      SizedBox(
        width: 300,
        height: 140,
        child: AgentTranscript.builder(
          followOutput: false,
          style: AgentTranscriptStyler(
            item: BoxStyler().color(itemColor),
            spacing: 7,
          ),
          itemCount: 3,
          itemBuilder: (context, index) =>
              SizedBox(height: 20, child: Text('Lazy $index')),
        ),
      ),
    );

    expect(_coloredItems(tester, find.byType(AgentTranscript), itemColor), 3);
    final first = tester.getRect(find.text('Lazy 0'));
    final second = tester.getRect(find.text('Lazy 1'));
    expect(second.top - first.bottom, closeTo(7, 0.5));
  });

  testWidgets('plan uses live-edge behavior for ledger growth', (tester) async {
    final key = GlobalKey<_GrowingPlanState>();
    await pumpAgent(
      tester,
      SizedBox(width: 300, child: _GrowingPlan(key: key)),
    );
    await tester.pump();
    final scroll = tester.widget<SingleChildScrollView>(
      find.descendant(
        of: find.byType(AgentPlan),
        matching: find.byType(SingleChildScrollView),
      ),
    );
    final controller = scroll.controller!;
    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );

    key.currentState!.grow();
    await tester.pump();
    await tester.pump();
    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 70));
    await tester.pump();
    expect(key.currentState!.changes, contains(false));
    final readingOffset = controller.offset;
    key.currentState!.grow();
    await tester.pump();
    await tester.pump();
    expect(controller.offset, closeTo(readingOffset, 0.5));
  });

  testWidgets('activity uses live-edge behavior for ledger growth', (
    tester,
  ) async {
    final key = GlobalKey<_GrowingActivityState>();
    await pumpAgent(
      tester,
      SizedBox(width: 300, child: _GrowingActivity(key: key)),
    );
    await tester.pump();
    final scroll = tester.widget<SingleChildScrollView>(
      find.descendant(
        of: find.byType(AgentActivity),
        matching: find.byType(SingleChildScrollView),
      ),
    );
    final controller = scroll.controller!;
    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );

    key.currentState!.grow();
    await tester.pump();
    await tester.pump();
    expect(
      controller.offset,
      closeTo(controller.position.maxScrollExtent, 0.5),
    );
  });
}

class _GrowingTranscript extends StatefulWidget {
  const _GrowingTranscript({super.key, required this.controller});

  final ScrollController controller;

  @override
  State<_GrowingTranscript> createState() => _GrowingTranscriptState();
}

class _GrowingTranscriptState extends State<_GrowingTranscript> {
  var count = 24;
  final changes = <bool>[];

  void grow() => setState(() => count += 6);

  @override
  Widget build(BuildContext context) => AgentTranscript.builder(
    controller: widget.controller,
    onFollowChanged: changes.add,
    itemCount: count,
    itemBuilder: (context, index) =>
        SizedBox(height: 24, child: Text('Line $index')),
  );
}

class _NonFollowingTranscript extends StatefulWidget {
  const _NonFollowingTranscript({super.key, required this.controller});

  final ScrollController controller;

  @override
  State<_NonFollowingTranscript> createState() =>
      _NonFollowingTranscriptState();
}

class _NonFollowingTranscriptState extends State<_NonFollowingTranscript> {
  var count = 24;

  void grow() => setState(() => count += 6);

  @override
  Widget build(BuildContext context) => AgentTranscript.builder(
    controller: widget.controller,
    followOutput: false,
    itemCount: count,
    itemBuilder: (context, index) =>
        SizedBox(height: 24, child: Text('Static $index')),
  );
}

class _ControllerRemovalHarness extends StatefulWidget {
  const _ControllerRemovalHarness({super.key, required this.external});

  final ScrollController external;

  @override
  State<_ControllerRemovalHarness> createState() =>
      _ControllerRemovalHarnessState();
}

class _ControllerRemovalHarnessState extends State<_ControllerRemovalHarness> {
  var useExternal = true;

  void remove() => setState(() => useExternal = false);

  @override
  Widget build(BuildContext context) => AgentTranscript.builder(
    controller: useExternal ? widget.external : null,
    itemCount: 20,
    itemBuilder: (context, index) =>
        SizedBox(height: 24, child: Text('Controller $index')),
  );
}

class _GrowingPlan extends StatefulWidget {
  const _GrowingPlan({super.key});

  @override
  State<_GrowingPlan> createState() => _GrowingPlanState();
}

class _GrowingPlanState extends State<_GrowingPlan> {
  var count = 6;
  final changes = <bool>[];

  void grow() => setState(() => count += 3);

  @override
  Widget build(BuildContext context) => AgentPlan(
    style: AgentPlanStyler(
      viewport: BoxStyler().maxHeight(90),
      item: FlexBoxStyler().height(30),
    ),
    onFollowChanged: changes.add,
    items: [
      for (var index = 0; index < count; index++)
        AgentPlanItem(
          id: '$index',
          title: 'Plan $index',
          status: index == count - 1
              ? AgentPlanItemStatus.inProgress
              : AgentPlanItemStatus.completed,
        ),
    ],
  );
}

class _GrowingActivity extends StatefulWidget {
  const _GrowingActivity({super.key});

  @override
  State<_GrowingActivity> createState() => _GrowingActivityState();
}

class _GrowingActivityState extends State<_GrowingActivity> {
  var count = 6;

  void grow() => setState(() => count += 3);

  @override
  Widget build(BuildContext context) => AgentActivity(
    style: AgentActivityStyler(
      viewport: BoxStyler().maxHeight(96),
      item: FlexBoxStyler().height(48),
    ),
    items: [
      for (var index = 0; index < count; index++)
        AgentActivityItem(
          id: '$index',
          title: 'Activity $index',
          detail: 'Detail $index',
          status: index == count - 1
              ? AgentActivityItemStatus.active
              : AgentActivityItemStatus.complete,
        ),
    ],
  );
}
