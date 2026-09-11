import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('submits trimmed text without clearing when opted out', (
    tester,
  ) async {
    final controller = TextEditingController(text: '  keep me  ');
    addTearDown(controller.dispose);
    final submitted = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(
        controller: controller,
        clearOnSubmit: false,
        onSubmit: submitted.add,
      ),
      overlay: true,
    );

    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();

    expect(submitted, ['keep me']);
    expect(controller.text, '  keep me  ');
  });

  testWidgets('programmatic edits report changes and enable submit', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    final changes = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(
        controller: controller,
        onChanged: changes.add,
        onSubmit: (_) {},
      ),
      overlay: true,
    );

    controller.text = 'programmatic';
    await tester.pump();

    expect(changes, ['programmatic']);
    expect(
      tester
          .widget<RemixIconButton>(
            find.byKey(const ValueKey('agent-composer-send')),
          )
          .enabled,
      isTrue,
    );
  });

  testWidgets('canSubmit false disables a non-empty composer', (tester) async {
    final submitted = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(
        initialValue: 'blocked',
        canSubmit: false,
        onSubmit: submitted.add,
      ),
      overlay: true,
    );

    final button = tester.widget<RemixIconButton>(
      find.byKey(const ValueKey('agent-composer-send')),
    );
    expect(button.enabled, isFalse);
    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    expect(submitted, isEmpty);
  });

  testWidgets('owned controller clears after submit', (tester) async {
    final submitted = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(initialValue: 'owned', onSubmit: submitted.add),
      overlay: true,
    );

    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();

    expect(submitted, ['owned']);
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller.text,
      isEmpty,
    );
  });

  testWidgets('running mode invokes stop and never submit', (tester) async {
    var stops = 0;
    final submitted = <String>[];
    await pumpAgent(
      tester,
      AgentComposer(
        running: true,
        initialValue: 'do not send',
        onSubmit: submitted.add,
        onStop: () => stops++,
      ),
      overlay: true,
    );

    await tester.tap(find.byKey(const ValueKey('agent-composer-stop')));
    expect(stops, 1);
    expect(submitted, isEmpty);
  });

  // Both swaps used to dispose the superseded owned object inside
  // didUpdateWidget, while the child RemixTextArea still held it. Detaching
  // then touched a disposed object, which asserts in debug.
  testWidgets('adopting a host controller keeps the composer usable', (
    tester,
  ) async {
    final adopted = TextEditingController(text: 'from host');
    addTearDown(adopted.dispose);

    await pumpAgent(
      tester,
      const AgentComposer(initialValue: 'owned'),
      overlay: true,
    );
    await pumpAgent(tester, AgentComposer(controller: adopted), overlay: true);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('from host'), findsOneWidget);
  });

  testWidgets('adopting a host focus node keeps the composer usable', (
    tester,
  ) async {
    final adopted = FocusNode();
    addTearDown(adopted.dispose);

    await pumpAgent(
      tester,
      const AgentComposer(initialValue: 'text'),
      overlay: true,
    );
    // The owned node is created lazily by the getter, so it only exists to be
    // disposed once the field has been built.
    await tester.pump();

    await pumpAgent(
      tester,
      AgentComposer(initialValue: 'text', focusNode: adopted),
      overlay: true,
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    adopted.requestFocus();
    await tester.pump();
    expect(adopted.hasFocus, isTrue);
  });
}
