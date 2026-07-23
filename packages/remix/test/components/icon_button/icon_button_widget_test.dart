import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixIconButton', () {
    testWidgets('renders arbitrary content through the surface renderer', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixIconButton(
          semanticLabel: 'Add item',
          icon: Stack(
            children: [
              Icon(Icons.add),
              Positioned(child: Text('1')),
            ],
          ),
        ),
      );

      expect(find.byType(NakedButton), findsOneWidget);
      expect(
        find.byKey(const ValueKey('remix-icon-button-surface')),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(
        tester.widget<NakedButton>(find.byType(NakedButton)).enabled,
        isFalse,
      );
    });

    testWidgets('resolved icon style is inherited by arbitrary content', (
      tester,
    ) async {
      const color = Color(0xFF654321);
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Star',
          style: RemixIconButtonStyler(
            icon: IconStyler().color(color).size(19),
          ),
          icon: const Icon(Icons.star),
        ),
      );

      final iconContext = tester.element(find.byIcon(Icons.star));
      expect(IconTheme.of(iconContext).color, color);
      expect(IconTheme.of(iconContext).size, 19);
    });

    testWidgets('explicit icon styling remains authoritative', (tester) async {
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Star',
          style: RemixIconButtonStyler(icon: IconStyler().color(Colors.green)),
          icon: const Icon(Icons.star, color: Colors.red),
        ),
      );

      expect(tester.widget<Icon>(find.byIcon(Icons.star)).color, Colors.red);
    });

    testWidgets('raw style spec supplies surface and icon theme', (
      tester,
    ) async {
      const color = Color(0xFF224466);
      await tester.pumpRemixApp(
        const RemixIconButton(
          semanticLabel: 'Spec',
          styleSpec: RemixIconButtonSpec(
            container: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            icon: StyleSpec(spec: IconSpec(color: color, size: 21)),
            containerEffects: RemixBoxEffectsSpec(
              behindContent: RemixBoxEffectLayerSpec(
                shadows: [RemixBoxShadow(color: color)],
              ),
            ),
          ),
          icon: Icon(Icons.settings),
        ),
      );

      final iconContext = tester.element(find.byIcon(Icons.settings));
      expect(find.byType(CustomPaint), findsWidgets);
      expect(IconTheme.of(iconContext).color, color);
      expect(IconTheme.of(iconContext).size, 21);
    });

    testWidgets('loading preserves layout, hides content, and shows spinner', (
      tester,
    ) async {
      Widget build(bool loading) => RemixIconButton(
        semanticLabel: 'Save',
        loading: loading,
        onPressed: () {},
        icon: const SizedBox.square(dimension: 24, child: Icon(Icons.save)),
      );

      await tester.pumpRemixApp(build(false));
      final idleSize = tester.getSize(find.byType(RemixIconButton));
      await tester.pumpRemixApp(build(true));
      await tester.pump();
      final visibility = tester.widget<Visibility>(find.byType(Visibility));

      expect(tester.getSize(find.byType(RemixIconButton)), idleSize);
      expect(find.byType(RemixSpinner), findsOneWidget);
      expect(visibility.visible, isFalse);
      expect(visibility.maintainSize, isTrue);
      expect(visibility.maintainState, isTrue);
      expect(visibility.maintainAnimation, isTrue);
      expect(visibility.maintainSemantics, isTrue);
    });

    testWidgets('loadingBuilder receives the resolved spinner spec', (
      tester,
    ) async {
      RemixSpinnerSpec? received;
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Save',
          loading: true,
          onPressed: () {},
          loadingBuilder: (context, spec) {
            received = spec;
            return const SizedBox(key: ValueKey('custom-spinner'));
          },
          icon: const Icon(Icons.save),
        ),
      );
      await tester.pump();

      expect(received, isNotNull);
      expect(find.byKey(const ValueKey('custom-spinner')), findsOneWidget);
      expect(find.byType(RemixSpinner), findsNothing);
    });

    testWidgets('loadingBuilder retains nested spinner widget modifiers', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Save',
          loading: true,
          loadingBuilder: (context, spec) =>
              const SizedBox(key: ValueKey('custom-spinner')),
          styleSpec: const RemixIconButtonSpec(
            spinner: StyleSpec(
              spec: RemixSpinnerSpec(),
              widgetModifiers: [OpacityModifier(0.25)],
            ),
          ),
          icon: const Icon(Icons.save),
        ),
      );
      await tester.pump();

      expect(
        find.ancestor(
          of: find.byKey(const ValueKey('custom-spinner')),
          matching: find.byWidgetPredicate(
            (widget) => widget is Opacity && widget.opacity == 0.25,
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('press and long-press callbacks independently enable it', (
      tester,
    ) async {
      var presses = 0;
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Add',
          onPressed: () => presses++,
          icon: const Icon(Icons.add),
        ),
      );
      await tester.tap(find.byType(RemixIconButton));
      expect(presses, 1);

      var longPresses = 0;
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'More actions',
          onLongPress: () => longPresses++,
          icon: const Icon(Icons.more_horiz),
        ),
      );
      await tester.longPress(find.byType(RemixIconButton));
      expect(longPresses, 1);
    });

    testWidgets('disabled and loading states suppress every callback', (
      tester,
    ) async {
      var callbacks = 0;
      for (final configuration in [
        (enabled: false, loading: false),
        (enabled: true, loading: true),
      ]) {
        await tester.pumpRemixApp(
          RemixIconButton(
            semanticLabel: 'Unavailable',
            enabled: configuration.enabled,
            loading: configuration.loading,
            onPressed: () => callbacks++,
            onLongPress: () => callbacks++,
            icon: const Icon(Icons.block),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(RemixIconButton));
        await tester.longPress(find.byType(RemixIconButton));
      }
      expect(callbacks, 0);
    });

    testWidgets('required semantic label forms one button node', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Delete item',
          semanticHint: 'Permanently removes the selected item',
          onPressed: () {},
          icon: const Icon(Icons.delete, semanticLabel: 'trash icon'),
        ),
      );

      final node = tester.getSemantics(find.byType(RemixIconButton));
      expect(node.label, 'Delete item');
      expect(node.hint, 'Permanently removes the selected item');
      expect(node.label, isNot(contains('trash icon')));
      expect(node.flagsCollection.isButton, isTrue);
      semantics.dispose();
    });

    test('rejects an empty semantic label', () {
      expect(
        () => RemixIconButton(semanticLabel: '', icon: const Icon(Icons.add)),
        throwsAssertionError,
      );
    });

    testWidgets('excludeSemantics is forwarded to the headless control', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixIconButton(
          semanticLabel: 'Hidden',
          excludeSemantics: true,
          icon: Icon(Icons.hide_source),
        ),
      );

      expect(
        tester.widget<NakedButton>(find.byType(NakedButton)).excludeSemantics,
        isTrue,
      );
    });

    testWidgets('autofocus, feedback, and cursor are forwarded', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpRemixApp(
        RemixIconButton(
          semanticLabel: 'Focus',
          autofocus: true,
          focusNode: focusNode,
          enableFeedback: false,
          mouseCursor: SystemMouseCursors.forbidden,
          onPressed: () {},
          icon: const Icon(Icons.center_focus_strong),
        ),
      );
      await tester.pumpAndSettle();

      final naked = tester.widget<NakedButton>(find.byType(NakedButton));
      expect(focusNode.hasFocus, isTrue);
      expect(naked.enableFeedback, isFalse);
      expect(naked.mouseCursor, SystemMouseCursors.forbidden);
    });

    widgetControllerTest<RemixIconButtonSpec>(
      'reports disabled state when no callback is supplied',
      build: () => const RemixIconButton(
        semanticLabel: 'Disabled',
        icon: Icon(Icons.block),
      ),
      expectedStates: {WidgetState.disabled},
    );

    widgetControllerTest<RemixIconButtonSpec>(
      'reports hovered state',
      build: () => RemixIconButton(
        semanticLabel: 'Hover',
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      act: hoverAction<RemixIconButton>,
      expectedStates: {WidgetState.hovered},
    );

    widgetControllerTest<RemixIconButtonSpec>(
      'reports focused state',
      build: () => RemixIconButton(
        semanticLabel: 'Focus',
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      act: focusAction<RemixIconButton>,
      expectedStates: {WidgetState.focused},
    );

    widgetControllerTest<RemixIconButtonSpec>(
      'reports pressed state',
      build: () => RemixIconButton(
        semanticLabel: 'Press',
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      act: pressAction<RemixIconButton>,
      expectedStates: {WidgetState.pressed},
    );
  });

  group('FortalIconButton', () {
    testWidgets('forwards enum recipe, overrides, semantics, and icon', (
      tester,
    ) async {
      const icon = Icon(Icons.add);
      await tester.pumpRemixApp(
        const FortalIconButton.classic(
          size: .size3,
          color: .red,
          radius: .small,
          highContrast: true,
          semanticLabel: 'Add item',
          icon: icon,
        ),
      );

      final fortal = tester.widget<FortalIconButton>(
        find.byType(FortalIconButton),
      );
      final remix = tester.widget<RemixIconButton>(
        find.byType(RemixIconButton),
      );
      expect(fortal.variant, FortalIconButtonVariant.classic);
      expect(fortal.size, FortalIconButtonSize.size3);
      expect(fortal.icon, same(icon));
      expect(remix.icon, same(icon));
      expect(remix.semanticLabel, 'Add item');
    });
  });
}
