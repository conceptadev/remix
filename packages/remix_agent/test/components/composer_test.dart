import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('Enter submits and Shift+Enter does not', (tester) async {
    final submitted = <String>[];
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: AgentComposer(onSubmit: submitted.add)),
      overlay: true,
    );

    await tester.enterText(find.byType(AgentComposer), 'hello world');
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(submitted, ['hello world']);

    await tester.enterText(find.byType(AgentComposer), 'keep');
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shift);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shift);
    await tester.pump();

    expect(submitted, ['hello world']);
    expect(find.text('keep'), findsOneWidget);
  });

  testWidgets('Enter is ignored while IME is composing', (tester) async {
    final submitted = <String>[];
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentComposer(controller: controller, onSubmit: submitted.add),
      ),
      overlay: true,
    );

    await tester.tap(find.byType(EditableText));
    await tester.pump();
    controller.value = const TextEditingValue(
      text: 'ni',
      selection: TextSelection.collapsed(offset: 2),
      composing: TextRange(start: 0, end: 2),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(submitted, isEmpty);
    expect(controller.text, 'ni');
  });

  testWidgets('send becomes stop while a run is live', (tester) async {
    var stopped = false;
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentComposer(
          running: true,
          onSubmit: (_) {},
          onStop: () => stopped = true,
        ),
      ),
    );

    expect(find.byKey(const ValueKey('agent-composer-send')), findsNothing);
    expect(find.byKey(const ValueKey('agent-composer-stop')), findsOneWidget);
    expect(find.byType(RemixIconButton), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const ValueKey('agent-composer-stop'))),
      const Size(32, 32),
    );

    await tester.tap(find.byKey(const ValueKey('agent-composer-stop')));
    await tester.pump();
    expect(stopped, isTrue);
  });

  testWidgets('submit clears the field and reports the empty value', (
    tester,
  ) async {
    final changed = <String>[];
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentComposer(onSubmit: (_) {}, onChanged: changed.add),
      ),
      overlay: true,
    );

    await tester.enterText(find.byType(AgentComposer), 'note');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();

    expect(changed, contains(''));
    expect(find.text('note'), findsNothing);
  });

  testWidgets('send is disabled when the field is empty', (tester) async {
    final submitted = <String>[];
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: AgentComposer(onSubmit: submitted.add)),
    );

    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();
    expect(submitted, isEmpty);
  });

  testWidgets('field and send share one card', (tester) async {
    await pumpAgent(
      tester,
      SizedBox(width: 400, child: AgentComposer(onSubmit: (_) {})),
    );

    expect(
      find.descendant(
        of: find.byType(AgentComposer),
        matching: find.byType(RemixCard),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(RemixCard),
        matching: find.byType(RemixTextArea),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(RemixCard),
        matching: find.byKey(const ValueKey('agent-composer-send')),
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'surface uses 8px pad, 16px radius, and a stronger focus border',
    (tester) async {
      await pumpAgent(
        tester,
        SizedBox(width: 400, child: AgentComposer(onSubmit: (_) {})),
        overlay: true,
      );

      final card = find.descendant(
        of: find.byType(AgentComposer),
        matching: find.byType(RemixCard),
      );
      final cardRect = tester.getRect(card);
      final fieldRect = tester.getRect(find.byType(RemixTextArea));
      expect(fieldRect.left - cardRect.left, closeTo(8, 1.5));
      expect(fieldRect.top - cardRect.top, closeTo(8, 1.5));

      final editRect = tester.getRect(find.byType(EditableText));
      expect(editRect.left - fieldRect.left, closeTo(8, 1.5));
      expect(editRect.top - fieldRect.top, closeTo(6, 1.5));

      final rest = _cardDecoration(tester, card);
      expect(rest, isNotNull);
      expect((rest!.borderRadius! as BorderRadius).topLeft.x, 16);
      expect(rest.color == null || rest.color!.a == 0, isTrue);

      final restAlpha = (rest.border as Border?)?.top.color.a ?? 0;
      await tester.tap(find.byType(EditableText));
      await tester.pumpAndSettle();
      final focused = _cardDecoration(tester, card);
      final focusAlpha = (focused!.border as Border?)?.top.color.a ?? 0;
      expect(focusAlpha, greaterThan(restAlpha));

      final fieldStyle = tester
          .widget<EditableText>(find.byType(EditableText))
          .style;
      expect(fieldStyle.fontSize, 14);
      expect((fieldStyle.height ?? 0) * 14, closeTo(24, 0.1));

      expect(
        tester.getSize(find.byKey(const ValueKey('agent-composer-send'))),
        const Size(32, 32),
      );
      expect(
        tester
            .getSize(find.byKey(const ValueKey('agent-composer-toolbar')))
            .height,
        greaterThanOrEqualTo(32),
      );
      final sendChrome = _buttonDecoration(
        tester,
        find.byKey(const ValueKey('agent-composer-send')),
      );
      expect((sendChrome!.borderRadius! as BorderRadius).topLeft.x, 16);
      expect(sendChrome.color?.a, greaterThan(0.9));

      final hint = tester.widget<Text>(find.text('Message'));
      expect(hint.style?.fontSize, 14);
      expect((hint.style?.height ?? 0) * 14, closeTo(24, 0.1));
      expect(hint.style?.color?.a ?? 0, closeTo(0.55, 0.02));

      expect(
        tester
            .widgetList<Opacity>(
              find.descendant(
                of: find.byKey(const ValueKey('agent-composer-send')),
                matching: find.byType(Opacity),
              ),
            )
            .any((opacity) => opacity.opacity == 0.5),
        isTrue,
      );
    },
  );

  testWidgets('canSubmit false keeps send disabled', (tester) async {
    final submitted = <String>[];
    await pumpAgent(
      tester,
      SizedBox(
        width: 400,
        child: AgentComposer(canSubmit: false, onSubmit: submitted.add),
      ),
      overlay: true,
    );

    await tester.enterText(find.byType(AgentComposer), 'blocked');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('agent-composer-send')));
    await tester.pump();
    expect(submitted, isEmpty);
  });

  testWidgets('disabled fades the whole instrument', (tester) async {
    await pumpAgent(
      tester,
      const SizedBox(width: 400, child: AgentComposer(enabled: false)),
    );

    expect(
      tester
          .widgetList<Opacity>(
            find.descendant(
              of: find.byType(AgentComposer),
              matching: find.byType(Opacity),
            ),
          )
          .any((opacity) => opacity.opacity == 0.6),
      isTrue,
    );
  });
}

BoxDecoration? _cardDecoration(WidgetTester tester, Finder card) {
  return _largestRadiusDecoration(tester, card);
}

BoxDecoration? _buttonDecoration(WidgetTester tester, Finder button) {
  return _largestRadiusDecoration(tester, button);
}

BoxDecoration? _largestRadiusDecoration(WidgetTester tester, Finder root) {
  BoxDecoration? found;
  var foundRadius = -1.0;
  void visit(Element element) {
    final widget = element.widget;
    if (widget is DecoratedBox && widget.decoration is BoxDecoration) {
      final decoration = widget.decoration as BoxDecoration;
      final radius = decoration.borderRadius;
      if (radius is BorderRadius && radius.topLeft.x > foundRadius) {
        foundRadius = radius.topLeft.x;
        found = decoration;
      }
    }
    element.visitChildren(visit);
  }

  tester.element(root).visitChildren(visit);
  return found;
}
