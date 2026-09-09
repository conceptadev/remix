import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';
import 'package:remix_agent_example/demos.dart';
import 'package:remix_agent_example/main.dart';
import 'package:remix_agent_example/showcase.dart';

import 'helpers/pump_catalog.dart';

Future<void> pumpDemo(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => Overlay.wrap(
        child: DarkHost(child: SingleChildScrollView(child: child)),
      ),
    ),
  );
  await pumpCatalog(tester);
}

Future<void> tapText(WidgetTester tester, String text) async {
  final target = find.text(text).last;
  await tester.ensureVisible(target);
  await pumpCatalog(tester);
  await tester.tap(target);
  await pumpCatalog(tester);
}

void main() {
  testWidgets('composed run grants, finishes, resubmits, denies and stops', (
    tester,
  ) async {
    await pumpDemo(tester, const ComposedRunDemo());
    expect(find.byType(AgentExecution), findsNothing);
    await tapText(tester, 'Allow once');
    expect(
      tester.widget<AgentExecution>(find.byType(AgentExecution)).status,
      AgentExecutionStatus.running,
    );
    expect(find.text('12 passed · 0 failed'), findsNothing);
    await tapText(tester, 'Finish checks');
    expect(
      find.text('All 12 checks passed. The checkout flow is ready for review.'),
      findsOneWidget,
    );
    expect(find.text('Finish checks'), findsNothing);
    final input = find.byType(EditableText);
    await tester.ensureVisible(input);
    await tester.enterText(input, 'Check again');
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpCatalog(tester);
    expect(find.text('Check again'), findsOneWidget);
    await tapText(tester, 'Deny');
    expect(find.text('Permission denied. No checks were run.'), findsOneWidget);
    expect(find.byType(AgentExecution), findsNothing);
    await tester.ensureVisible(input);
    await tester.enterText(input, 'Try once more');
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpCatalog(tester);
    await tapText(tester, 'Allow once');
    final stop = find.byKey(const ValueKey('agent-composer-stop'));
    await tester.ensureVisible(stop);
    await tester.tap(stop);
    await pumpCatalog(tester);
    expect(
      tester.widget<AgentExecution>(find.byType(AgentExecution)).status,
      AgentExecutionStatus.cancelled,
    );
    expect(
      find.text('Run stopped. Submit another message to try again.'),
      findsOneWidget,
    );
  });

  testWidgets('execution reaches failure and retries', (tester) async {
    await pumpDemo(tester, const ExecutionDemo());
    await tapText(tester, 'Succeed');
    await tapText(tester, 'Fail');
    expect(
      tester.widget<AgentExecution>(find.byType(AgentExecution)).status,
      AgentExecutionStatus.error,
    );
    await tapText(tester, 'Focused checks');
    final retry = find.byWidgetPredicate(
      (w) => w is RemixIconButton && w.semanticLabel == 'Retry execution',
    );
    await tester.ensureVisible(retry);
    await tester.tap(retry);
    await pumpCatalog(tester);
    expect(
      tester.widget<AgentExecution>(find.byType(AgentExecution)).status,
      AgentExecutionStatus.running,
    );
  });

  testWidgets('composed run supports always allow', (tester) async {
    await pumpDemo(tester, const ComposedRunDemo());
    await tapText(tester, 'Always allow');
    expect(
      tester.widget<AgentExecution>(find.byType(AgentExecution)).status,
      AgentExecutionStatus.running,
    );
  });

  testWidgets('plan can replay after completion', (tester) async {
    await pumpDemo(tester, const PlanDemo());
    for (var i = 0; i < 3; i++) {
      await tapText(tester, 'Advance');
    }
    expect(find.text('3/3'), findsOneWidget);
    expect(find.text('Advance'), findsNothing);
    await tapText(tester, 'Replay');
    expect(find.text('0/3'), findsOneWidget);
    expect(find.text('Read the brief'), findsOneWidget);
  });

  testWidgets(
    'answer reveals sources only when complete and copies the answer',
    (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData')
            copied = (call.arguments as Map)['text'] as String;
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await pumpDemo(tester, const AnswerDemo());
      expect(find.text('Sources'), findsNothing);
      await tapText(tester, 'Complete');
      expect(find.text('Sources'), findsOneWidget);
      expect(
        tester
            .widget<RemixButton>(find.widgetWithText(RemixButton, 'Complete'))
            .enabled,
        isFalse,
      );
      final copy = find.byWidgetPredicate(
        (w) => w is RemixIconButton && w.semanticLabel == 'Copy answer',
      );
      await tester.tap(copy);
      await tester.pump();
      expect(copied, 'The checkout flow is ready for review.');
      await tester.tap(
        find.byWidgetPredicate(
          (w) => w is RemixIconButton && w.semanticLabel == 'Retry answer',
        ),
      );
      await pumpCatalog(tester);
      expect(find.text('Sources'), findsNothing);
      expect(find.text('Writing the answer…'), findsOneWidget);
    },
  );

  for (final width in [390.0, 1280.0]) {
    testWidgets('navigation preserves clicked destination at width $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const RemixAgentExampleApp());
      await pumpCatalog(tester);
      for (final label in ['Activity', 'Answer', 'Composer']) {
        final nav = find.widgetWithText(RemixToggle, label);
        await tester.ensureVisible(nav);
        await pumpCatalog(tester);
        await tester.tap(nav);
        await pumpCatalog(tester);
        expect(tester.widget<RemixToggle>(nav).selected, isTrue);
        final rect = tester.getRect(nav);
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(width));
      }
      expect(tester.takeException(), isNull);
    });
  }
}
