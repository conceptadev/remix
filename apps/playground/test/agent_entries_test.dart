import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/registry/component_registry.dart';
import 'package:playground/ui/ui.dart';

void main() {
  testWidgets('New chat clears an unsent draft', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Builder(builder: components['chat']!)),
    );
    final field = find.descendant(
      of: find.byType(PlaygroundComposer),
      matching: find.byType(EditableText),
    );
    await tester.enterText(field, 'Old unsent draft');
    await tester.tap(find.text('New chat'));
    await pumpChatLayout(tester);
    expect(tester.widget<EditableText>(field).controller.text, isEmpty);
    await tester.enterText(field, 'Fresh conversation');
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpChatLayout(tester);
    expect(find.text('Fresh conversation'), findsOneWidget);
    expect(find.text('Old unsent draft'), findsNothing);
  });

  testWidgets('Copy output preserves the displayed command and log', (
    tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(home: Builder(builder: components['chat']!)),
    );
    await tester.enterText(
      find.descendant(
        of: find.byType(PlaygroundComposer),
        matching: find.byType(EditableText),
      ),
      'Run checks',
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpChatLayout(tester);
    await tester.tap(find.text('Allow once'));
    await pumpChatLayout(tester);
    await tester.tap(find.text('Finish'));
    await pumpChatLayout(tester);
    await tester.ensureVisible(find.text('Focused checks'));
    await tester.tap(find.text('Focused checks'));
    await pumpChatLayout(tester);
    final output = find.text('\$ flutter test\nSimulated output');
    await tester.ensureVisible(output);
    final copy = find.bySemanticsLabel('Copy output');
    await tester.ensureVisible(copy);
    await tester.tap(copy);
    await tester.pump();
    expect(copied, tester.widget<Text>(output).data);
  });

  testWidgets('denial does not run a tool and retry requests permission', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Builder(builder: components['chat']!)),
    );
    await tester.enterText(
      find.descendant(
        of: find.byType(PlaygroundComposer),
        matching: find.byType(EditableText),
      ),
      'Run checks',
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpChatLayout(tester);
    await tester.tap(find.text('Deny'));
    await pumpChatLayout(tester);
    expect(find.byType(PlaygroundExecution), findsNothing);
    expect(find.text('Permission denied. No command was run.'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Retry answer'));
    await pumpChatLayout(tester);
    expect(find.text('Allow once'), findsOneWidget);
    await tester.tap(find.text('Always allow'));
    await pumpChatLayout(tester);
    await tester.tap(find.text('Finish'));
    await pumpChatLayout(tester);
    await tester.tap(find.bySemanticsLabel('Retry answer'));
    await pumpChatLayout(tester);
    expect(find.text('Finish'), findsOneWidget);
    expect(find.byType(PlaygroundPermission), findsNothing);
    await tester.tap(find.text('New chat'));
    await pumpChatLayout(tester);
    await tester.enterText(
      find.descendant(
        of: find.byType(PlaygroundComposer),
        matching: find.byType(EditableText),
      ),
      'Run checks again',
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpChatLayout(tester);
    expect(find.text('Allow once'), findsOneWidget);
  });

  test('Agent surfaces and chat are discoverable', () {
    expect(
      components.keys,
      containsAll({
        'agent-activity',
        'agent-answer',
        'agent-composer',
        'agent-execution',
        'agent-message',
        'agent-permission',
        'agent-plan',
        'agent-transcript',
        'chat',
      }),
    );
  });

  testWidgets('compact chat submits, permits, stops, and exposes retry', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(home: Builder(builder: components['chat']!)),
    );
    await tester.enterText(
      find.descendant(
        of: find.byType(PlaygroundComposer),
        matching: find.byType(EditableText),
      ),
      'Run checks',
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await pumpChatLayout(tester);
    expect(find.text('Allow once'), findsOneWidget);
    await tester.tap(find.text('Allow once'));
    await pumpChatLayout(tester);
    expect(find.text('Simulate failure'), findsOneWidget);
    await tester.tap(find.text('Simulate failure'));
    await pumpChatLayout(tester);
    expect(find.bySemanticsLabel('Retry answer'), findsOneWidget);
  });
}

Future<void> pumpChatLayout(WidgetTester tester) async {
  // Lay out lazy transcript children, then apply the post-frame live-edge scroll.
  // Running tool animations intentionally never settle.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pump();
}
