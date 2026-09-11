import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import '../helpers/pump.dart';

Finder _findLucideIcon(int codePoint) => find.byWidgetPredicate(
  (widget) =>
      widget is Icon &&
      widget.icon?.codePoint == codePoint &&
      widget.icon?.fontFamily == 'Lucide',
);

Iterable<Color> _decorationColors(WidgetTester tester, Finder root) sync* {
  for (final widget in tester.widgetList<DecoratedBox>(
    find.descendant(of: root, matching: find.byType(DecoratedBox)),
  )) {
    final decoration = widget.decoration;
    if (decoration is BoxDecoration && decoration.color != null) {
      yield decoration.color!;
    }
  }
  for (final widget in tester.widgetList<ColoredBox>(
    find.descendant(of: root, matching: find.byType(ColoredBox)),
  )) {
    yield widget.color;
  }
}

void main() {
  testWidgets('composer renders a non-empty default send glyph', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentComposer(initialValue: 'go', onSubmit: (_) {}),
      overlay: true,
    );

    expect(
      find.descendant(
        of: find.byKey(const ValueKey('agent-composer-send')),
        matching: _findLucideIcon(57418),
      ),
      findsOneWidget,
    );
  });

  testWidgets('answer renders default copy and retry glyphs', (tester) async {
    await pumpAgent(
      tester,
      AgentAnswer(
        status: AgentAnswerStatus.complete,
        onCopy: () {},
        onRetry: () {},
        child: const Text('answer'),
      ),
    );

    final answer = find.byType(AgentAnswer);
    expect(
      find.descendant(of: answer, matching: _findLucideIcon(57502)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: answer, matching: _findLucideIcon(57672)),
      findsOneWidget,
    );
  });

  testWidgets('execution renders tool, status, indicator, and action glyphs', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      AgentExecution(
        tool: 'terminal.run',
        title: 'Run',
        status: AgentExecutionStatus.success,
        collapseOnComplete: false,
        onCopy: () {},
        onRetry: () {},
        child: const Text('output'),
      ),
    );

    final execution = find.byType(AgentExecution);
    for (final codePoint in [
      57866, // SquareTerminal
      57894, // CircleCheck
      57456, // ChevronUp
      57502, // Copy
      57672, // RotateCcw
    ]) {
      expect(
        find.descendant(of: execution, matching: _findLucideIcon(codePoint)),
        findsOneWidget,
      );
    }
  });

  testWidgets('plan renders one indicator and one glyph per status', (
    tester,
  ) async {
    await pumpAgent(
      tester,
      const AgentPlan(
        items: [
          AgentPlanItem(id: 'p', title: 'Pending'),
          AgentPlanItem(
            id: 'a',
            title: 'Active',
            status: AgentPlanItemStatus.inProgress,
          ),
          AgentPlanItem(
            id: 'c',
            title: 'Complete',
            status: AgentPlanItemStatus.completed,
          ),
          AgentPlanItem(
            id: 'x',
            title: 'Cancelled',
            status: AgentPlanItemStatus.cancelled,
          ),
        ],
      ),
    );

    expect(
      find.descendant(of: find.byType(AgentPlan), matching: find.byType(Icon)),
      findsAtLeastNWidgets(5),
    );
  });

  testWidgets('icon builders replace functional defaults', (tester) async {
    await pumpAgent(
      tester,
      AgentComposer(
        initialValue: 'go',
        onSubmit: (_) {},
        submitIconBuilder: (context, spec, icon) => const SizedBox(
          key: ValueKey('custom-send-glyph'),
          width: 12,
          height: 12,
        ),
      ),
      overlay: true,
    );

    final send = find.byKey(const ValueKey('agent-composer-send'));
    expect(
      find.descendant(
        of: send,
        matching: find.byKey(const ValueKey('custom-send-glyph')),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: send, matching: find.byType(Icon)),
      findsNothing,
    );
  });

  testWidgets('composer button hover resolves in the child controller', (
    tester,
  ) async {
    const rest = Color(0xFF0000FF);
    const hovered = Color(0xFFFF0000);
    await pumpAgent(
      tester,
      AgentComposer(
        initialValue: 'go',
        onSubmit: (_) {},
        submitStyle: IconButtonStyler()
            .size(48, 48)
            .color(rest)
            .onHovered(IconButtonStyler().color(hovered)),
      ),
      overlay: true,
    );

    final send = find.byKey(const ValueKey('agent-composer-send'));
    expect(_decorationColors(tester, send), contains(rest));

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: Offset.zero);
    await mouse.moveTo(tester.getCenter(send));
    await tester.pumpAndSettle();

    expect(_decorationColors(tester, send), contains(hovered));
  });

  testWidgets('composer field focus resolves in the text-field controller', (
    tester,
  ) async {
    const rest = Color(0xFF0000FF);
    const focused = Color(0xFFFF0000);
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    await pumpAgent(
      tester,
      AgentComposer(
        focusNode: focusNode,
        fieldStyle: TextFieldStyler(
          cursorColor: rest,
        ).onFocused(TextFieldStyler(cursorColor: focused)),
      ),
      overlay: true,
    );

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
      rest,
    );
    focusNode.requestFocus();
    await tester.pumpAndSettle();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
      focused,
    );
  });

  testWidgets('plan disclosure selected style resolves after expansion', (
    tester,
  ) async {
    const collapsed = Color(0xFF0000FF);
    const expanded = Color(0xFFFF0000);
    await pumpAgent(
      tester,
      AgentPlan(
        defaultExpanded: false,
        disclosureStyle: DisclosureStyler()
            .trigger(BoxStyler().color(collapsed))
            .onSelected(
              DisclosureStyler().trigger(BoxStyler().color(expanded)),
            ),
        items: const [
          AgentPlanItem(
            id: 'one',
            title: 'Step',
            status: AgentPlanItemStatus.inProgress,
          ),
        ],
      ),
    );

    final disclosure = find.byType(RemixDisclosure);
    expect(_decorationColors(tester, disclosure), contains(collapsed));
    await tester.tap(find.text('Plan'));
    await tester.pumpAndSettle();
    expect(_decorationColors(tester, disclosure), contains(expanded));
  });

  testWidgets('permission keeps distinct unresolved action styles', (
    tester,
  ) async {
    final allow = ButtonStyler().color(const Color(0xFF00AA00));
    final always = ButtonStyler().color(const Color(0xFF0000AA));
    final deny = ButtonStyler().color(const Color(0xFFAA0000));
    await pumpAgent(
      tester,
      AgentPermission(
        tool: 'tool',
        onAllowOnce: () {},
        onAlwaysAllow: () {},
        onDeny: () {},
        allowOnceStyle: allow,
        alwaysAllowStyle: always,
        denyStyle: deny,
      ),
    );

    expect(
      tester
          .widget<RemixButton>(
            find.byKey(const ValueKey('agent-permission-allow-once')),
          )
          .style,
      same(allow),
    );
    expect(
      tester
          .widget<RemixButton>(
            find.byKey(const ValueKey('agent-permission-always-allow')),
          )
          .style,
      same(always),
    );
    expect(
      tester
          .widget<RemixButton>(
            find.byKey(const ValueKey('agent-permission-deny')),
          )
          .style,
      same(deny),
    );
  });
}
