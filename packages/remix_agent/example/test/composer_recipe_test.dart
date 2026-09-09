import 'package:flutter/gestures.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';
import 'package:remix_agent_example/agent_recipes.dart';
import 'package:remix_agent_example/ui/ui.dart';

const _sendKey = ValueKey('agent-composer-send');
const _stopKey = ValueKey('agent-composer-stop');

const _light = UiThemeData.light();
const _dark = UiThemeData.dark();

/// A standalone installed control for comparing the send button's dimensions.
/// The glyph is incidental to the geometry assertion.
const _referenceIconButton = UiIconButton(
  icon: IconData(0x2192),
  semanticLabel: 'Reference',
  size: UiIconButtonSize.small,
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

List<SemanticsNode> _nodes(WidgetTester tester) =>
    tester.semantics.simulatedAccessibilityTraversal().toList();

/// Pumps [child] under the host the catalog uses.
///
/// The `Overlay` is not optional: every case here builds a composer, and a
/// focused `EditableText` asserts on one.
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
    testWidgets('send matches installed IconButton size and color', (
      tester,
    ) async {
      await _pump(
        tester,
        SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _composer(initialValue: 'go', onSubmit: (_) {}),
              _referenceIconButton,
            ],
          ),
        ),
      );

      final send = find.byKey(_sendKey);
      final reference = find.byType(UiIconButton);

      expect(_decorationColors(tester, send), contains(_light.primary));
      // Compare dimensions without hard-coding the installed recipe's size.
      expect(tester.getSize(send), tester.getSize(reference));
    });

    testWidgets('stop takes the IconButton recipe destructive variant', (
      tester,
    ) async {
      await _pump(tester, _composer(running: true, onStop: () {}));

      final stop = find.byKey(_stopKey);
      expect(_decorationColors(tester, stop), contains(_light.destructive));
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

    testWidgets('the text-area recipe reaches the field', (tester) async {
      await _pump(tester, _composer(onSubmit: (_) {}));

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
        _light.foreground,
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

  testWidgets('surface, field, toolbar, and stop overrides beat the recipe', (
    tester,
  ) async {
    const surface = Color(0xFF123456);
    const cursor = Color(0xFF234567);
    const toolbar = Color(0xFF345678);
    const stop = Color(0xFF456789);
    final recipe = uiAgentComposerRecipe(
      style: AgentComposerStyler(
        toolbar: FlexBoxStyler().color(toolbar).padding(.all(20)),
      ),
      surfaceStyle: CardStyler().color(surface),
      fieldStyle: TextFieldStyler(cursorColor: cursor),
      stopStyle: IconButtonStyler().color(stop),
    );
    await _pump(
      tester,
      _composer(recipe: recipe, running: true, onStop: () {}),
    );

    expect(
      _decorationColors(tester, find.byType(RemixCard)),
      contains(surface),
    );
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).cursorColor,
      cursor,
    );
    expect(_decorationColors(tester, find.byType(RowBox)), contains(toolbar));
    final toolbarTop = tester.getTopLeft(find.byType(RowBox)).dy;
    final stopTop = tester.getTopLeft(find.byKey(_stopKey)).dy;
    expect(stopTop - toolbarTop, 20);
    final stopColors = _decorationColors(tester, find.byKey(_stopKey)).toList();
    expect(stopColors, contains(stop));
    expect(stopColors, isNot(contains(_light.destructive)));
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

      await _pump(tester, _composer(controller: first, onSubmit: (_) {}));
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        'first',
      );

      await _pump(tester, _composer(controller: second, onSubmit: (_) {}));
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
