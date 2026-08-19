import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';
import 'package:remix_agent_example/main.dart';

void main() {
  testWidgets('example app boots under WidgetsApp', (tester) async {
    await tester.pumpWidget(const RemixAgentExampleApp());
    await tester.pump();
    expect(find.byType(WidgetsApp), findsOneWidget);
    expect(find.byType(AgentComposer), findsWidgets);
    expect(find.byType(AgentPermission), findsWidgets);
    expect(find.byType(Navigator), findsNothing);
    expect(find.text('Composer'), findsWidgets);
    expect(find.text('Permission'), findsWidgets);
    expect(find.text('Execution'), findsWidgets);
    expect(find.text('Plan'), findsWidgets);
    expect(find.text('Activity'), findsWidgets);
    expect(find.text('Answer'), findsWidgets);
    expect(find.text('Transcript'), findsWidgets);
    expect(find.text('Message'), findsWidgets);
  });

  testWidgets('consumer import fires composer submit and permission deny', (
    tester,
  ) async {
    final submitted = <String>[];
    var denied = false;

    await tester.pumpWidget(
      MixScope.empty(
        child: WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (_, _) {
            return DefaultTextStyle(
              style: const TextStyle(color: Color(0xFF18181B), fontSize: 14),
              child: Overlay.wrap(
                child: Column(
                  children: [
                    AgentComposer(onSubmit: submitted.add),
                    AgentPermission(
                      tool: 'demo.tool',
                      onDeny: () => denied = true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.enterText(find.byType(AgentComposer), 'ship it');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();
    expect(submitted, ['ship it']);

    await tester.tap(find.text('Deny'));
    await tester.pump();
    expect(denied, isTrue);
  });
}
