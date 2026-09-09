import 'package:agent_consumer_fixture/agent/composer.dart';
import 'package:agent_consumer_fixture/ui/ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

/// The edge the installed IconButton recipe gives its `small` size.
///
/// Read from the environment so `tool/check_agent_consumer.dart` can edit the
/// installed recipe, rerun this suite with the new value, and prove the edit
/// reached Agent's send and stop buttons. Nothing in Agent knows this number;
/// it comes from `lib/ui/components/icon_button.dart`.
const _iconButtonEdge = int.fromEnvironment(
  'AGENT_RECIPE_EDGE',
  defaultValue: 32,
);

const _sendKey = ValueKey('agent-composer-send');
const _stopKey = ValueKey('agent-composer-stop');

const _light = UiThemeData.light();
const _dark = UiThemeData.dark();

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

List<SemanticsNode> _nodes(WidgetTester tester) =>
    tester.semantics.simulatedAccessibilityTraversal().toList();

/// Pumps [child] in the same host the gallery uses.
///
/// The `Overlay` is not optional here: every case below builds a composer, and
/// a focused `EditableText` asserts on one.
Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  UiThemeData theme = _light,
  Size surface = const Size(800, 600),
}) async {
  await tester.binding.setSurfaceSize(surface);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    WidgetsApp(
      color: const Color(0xFF0A0A0A),
      // `Overlay.wrap` rather than `Overlay(initialEntries: ...)`: the second
      // form builds its entry once and ignores every later rebuild, which
      // would make the controller-swap case below silently pump nothing.
      builder: (_, _) => UiThemeScope(
        data: theme,
        child: Overlay.wrap(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 14),
            child: Align(alignment: Alignment.topLeft, child: child),
          ),
        ),
      ),
    ),
  );
}

/// Builds a composer from the bundle, spreading it across the five parameters.
Widget _composer({
  UiAgentComposerRecipe? recipe,
  TextEditingController? controller,
  FocusNode? focusNode,
  String? initialValue,
  bool running = false,
  ValueChanged<String>? onSubmit,
  VoidCallback? onStop,
}) {
  final resolved = recipe ?? uiAgentComposerRecipe();

  return AgentComposer(
    controller: controller,
    focusNode: focusNode,
    initialValue: initialValue,
    running: running,
    onSubmit: onSubmit,
    onStop: onStop,
    style: resolved.style,
    surfaceStyle: resolved.surfaceStyle,
    fieldStyle: resolved.fieldStyle,
    submitStyle: resolved.submitStyle,
    stopStyle: resolved.stopStyle,
  );
}

void main() {
  group('the installed recipes style Agent', () {
    testWidgets('send takes the IconButton recipe primary variant', (
      tester,
    ) async {
      await _pump(tester, _composer(initialValue: 'go', onSubmit: (_) {}));

      final send = find.byKey(_sendKey);
      expect(_decorationColors(tester, send), contains(_light.primary));
      expect(
        tester.getSize(send),
        Size(_iconButtonEdge.toDouble(), _iconButtonEdge.toDouble()),
      );
    });

    testWidgets('stop takes the IconButton recipe destructive variant', (
      tester,
    ) async {
      await _pump(tester, _composer(running: true, onStop: () {}));

      final stop = find.byKey(_stopKey);
      expect(_decorationColors(tester, stop), contains(_light.destructive));
      expect(
        tester.getSize(stop),
        Size(_iconButtonEdge.toDouble(), _iconButtonEdge.toDouble()),
      );
    });

    testWidgets('the card recipe paints the composer surface', (tester) async {
      await _pump(tester, _composer(onSubmit: (_) {}));

      expect(
        _decorationColors(tester, find.byType(RemixCard)),
        contains(_light.background),
      );
    });

    testWidgets('the dark theme reaches Agent through the same recipe', (
      tester,
    ) async {
      await _pump(
        tester,
        _composer(initialValue: 'go', onSubmit: (_) {}),
        theme: _dark,
      );

      final send = find.byKey(_sendKey);
      expect(_decorationColors(tester, send), contains(_dark.primary));
      expect(_decorationColors(tester, send), isNot(contains(_light.primary)));
      expect(
        _decorationColors(tester, find.byType(RemixCard)),
        contains(_dark.background),
      );
    });

    testWidgets('a narrow surface keeps the toolbar on one row', (
      tester,
    ) async {
      await _pump(
        tester,
        SizedBox(
          width: 320,
          child: _composer(initialValue: 'go', onSubmit: (_) {}),
        ),
        surface: const Size(320, 600),
      );

      expect(tester.takeException(), isNull);
      expect(find.byKey(_sendKey), findsOneWidget);
    });

    testWidgets('the text-area recipe reaches the field', (tester) async {
      await _pump(tester, _composer(onSubmit: (_) {}));

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
        _light.foreground,
      );
    });
  });

  group('composition does not flatten child state', () {
    testWidgets('field focus still resolves in the text-field controller', (
      tester,
    ) async {
      const focused = Color(0xFFFF0000);
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      final recipe = uiAgentComposerRecipe(
        fieldStyle: TextFieldStyler().onFocused(
          TextFieldStyler(cursorColor: focused),
        ),
      );
      await _pump(tester, _composer(recipe: recipe, focusNode: focusNode));

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
        _light.foreground,
      );

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
        focused,
      );
    });

    testWidgets('send hover still resolves in the icon-button controller', (
      tester,
    ) async {
      const hovered = Color(0xFF00FF00);
      final recipe = uiAgentComposerRecipe(
        submitStyle: IconButtonStyler().onHovered(
          IconButtonStyler().color(hovered),
        ),
      );
      await _pump(
        tester,
        _composer(recipe: recipe, initialValue: 'go', onSubmit: (_) {}),
      );

      final send = find.byKey(_sendKey);
      expect(_decorationColors(tester, send), contains(_light.primary));

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(send));
      await tester.pumpAndSettle();

      expect(_decorationColors(tester, send), contains(hovered));
    });
  });

  testWidgets('an instance override beats the recipe', (tester) async {
    const override = Color(0xFF7C3AED);
    final recipe = uiAgentComposerRecipe(
      submitStyle: IconButtonStyler().color(override),
    );
    await _pump(
      tester,
      _composer(recipe: recipe, initialValue: 'go', onSubmit: (_) {}),
    );

    final colors = _decorationColors(tester, find.byKey(_sendKey)).toList();
    expect(colors, contains(override));
    expect(colors, isNot(contains(_light.primary)));
  });

  group('Agent keeps the behaviour the recipe never sees', () {
    testWidgets('Enter submits, Shift+Enter and IME composition do not', (
      tester,
    ) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);
      final submitted = <String>[];
      await _pump(
        tester,
        _composer(
          controller: controller,
          focusNode: focusNode,
          onSubmit: submitted.add,
        ),
      );
      focusNode.requestFocus();

      controller.value = const TextEditingValue(
        text: 'compose',
        selection: TextSelection.collapsed(offset: 7),
        composing: TextRange(start: 0, end: 7),
      );
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(submitted, isEmpty);

      controller.value = const TextEditingValue(
        text: 'ship it',
        selection: TextSelection.collapsed(offset: 7),
      );
      await tester.pump();
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
      expect(submitted, isEmpty);

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(submitted, ['ship it']);
      expect(controller.text, isEmpty);
      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('a controller swap keeps the text and the change reports', (
      tester,
    ) async {
      final first = TextEditingController(text: 'first');
      final second = TextEditingController(text: 'second');
      addTearDown(first.dispose);
      addTearDown(second.dispose);
      final recipe = uiAgentComposerRecipe();

      await _pump(
        tester,
        AgentComposer(
          controller: first,
          style: recipe.style,
          surfaceStyle: recipe.surfaceStyle,
          fieldStyle: recipe.fieldStyle,
          submitStyle: recipe.submitStyle,
          stopStyle: recipe.stopStyle,
          onSubmit: (_) {},
        ),
      );
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        'first',
      );

      await _pump(
        tester,
        AgentComposer(
          controller: second,
          style: recipe.style,
          surfaceStyle: recipe.surfaceStyle,
          fieldStyle: recipe.fieldStyle,
          submitStyle: recipe.submitStyle,
          stopStyle: recipe.stopStyle,
          onSubmit: (_) {},
        ),
      );
      await tester.pump();

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        'second',
      );
      expect(
        tester.widget<RemixIconButton>(find.byKey(_sendKey)).enabled,
        isTrue,
      );
    });

    testWidgets('the semantic tree has one field and one action', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await _pump(tester, _composer(initialValue: 'go', onSubmit: (_) {}));

      final fields = _nodes(
        tester,
      ).where((node) => node.getSemanticsData().flagsCollection.isTextField);
      final buttons = _nodes(
        tester,
      ).where((node) => node.getSemanticsData().flagsCollection.isButton);

      expect(fields, hasLength(1));
      expect(fields.single.getSemanticsData().label, 'Message');
      expect(buttons, hasLength(1));
      expect(buttons.single.getSemanticsData().label, 'Send');
      semantics.dispose();
    });
  });
}
