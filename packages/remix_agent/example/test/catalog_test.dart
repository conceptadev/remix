import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';
import 'package:remix_agent_example/demos.dart';
import 'package:remix_agent_example/main.dart';
import 'package:remix_agent_example/showcase.dart';

void main() {
  testWidgets('catalog lists every surface and the composed run', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const RemixAgentExampleApp());
    await tester.pump();

    for (final entry in catalogEntries) {
      expect(find.text(entry.title), findsWidgets, reason: entry.id);
    }

    expect(find.byType(AgentComposer), findsWidgets);
    expect(find.byType(AgentMessage), findsWidgets);
    expect(find.byType(AgentTranscript), findsWidgets);
    expect(find.byType(AgentPermission), findsWidgets);
    expect(find.byType(AgentExecution), findsWidgets);
    expect(find.byType(AgentPlan), findsWidgets);
    expect(find.byType(AgentActivity), findsWidgets);
    expect(find.byType(AgentAnswer), findsWidgets);
  });

  testWidgets('permission deny in the catalog updates the shipped card', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const RemixAgentExampleApp());
    await tester.pump();

    await tester.tap(find.text('Permission').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 240));

    expect(find.text('Deny'), findsWidgets);
    await tester.ensureVisible(find.text('Deny').last);
    await tester.tap(find.text('Deny').last);
    await tester.pump();

    expect(find.text('Denied'), findsWidgets);
  });

  testWidgets('hero transcript does not auto-follow', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const RemixAgentExampleApp());
    await tester.pump();

    final hero = tester
        .widgetList<AgentTranscript>(
          find.descendant(
            of: find.byType(ComposedRunDemo),
            matching: find.byType(AgentTranscript),
          ),
        )
        .first;
    expect(hero.followOutput, isFalse);
  });

  testWidgets('catalog surfaces honor the polish contracts', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const RemixAgentExampleApp());
    await tester.pump();

    expect(find.text('Show'), findsNothing);
    expect(find.text('Hide'), findsNothing);
    expect(find.text('View details'), findsWidgets);
    expect(find.text('Commandflutter test'), findsNothing);
    expect(
      find.descendant(
        of: find.byType(AgentComposer),
        matching: find.byType(RemixCard),
      ),
      findsWidgets,
    );

    final succeed = find.descendant(
      of: find.byType(ExecutionDemo),
      matching: find.text('Succeed'),
    );
    await tester.ensureVisible(succeed);
    await tester.pump();
    await tester.tap(succeed);
    await tester.pump();
    expect(find.text('12 passed · 0 failed'), findsNothing);

    final title = find.descendant(
      of: find.byType(ExecutionDemo),
      matching: find.text('Focused checks'),
    );
    await tester.ensureVisible(title);
    await tester.pump();
    await tester.tap(title);
    await tester.pump();
    expect(find.text('12 passed · 0 failed'), findsOneWidget);
  });
}
