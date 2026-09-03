import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixButton Widget Tests', () {
    group('Basic Rendering', () {
      testWidgets('renders button with label only', (tester) async {
        await tester.pumpRemixApp(RemixButton(label: 'Click Me'));

        await tester.pumpAndSettle();

        // Verify text is rendered
        expect(find.text('Click Me'), findsOneWidget);

        // Verify NakedButton is used internally
        expect(find.byType(NakedButton), findsOneWidget);
      });

      testWidgets('renders button with label and icon', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(label: 'Save', leadingIcon: Icons.save, onPressed: () {}),
        );

        await tester.pumpAndSettle();

        // Verify both text and icon are rendered
        expect(find.text('Save'), findsOneWidget);
        expect(find.byIcon(Icons.save), findsOneWidget);
      });

      testWidgets('iconAlignment repositions a single icon', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Continue',
            leadingIcon: Icons.arrow_forward,
            style: ButtonStyler().iconAlignment(.end),
            onPressed: () {},
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.getTopLeft(find.byIcon(Icons.arrow_forward)).dx,
          greaterThan(tester.getTopLeft(find.text('Continue')).dx),
        );
      });

      testWidgets('both explicit icon positions remain stable', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Continue',
            leadingIcon: Icons.arrow_back,
            trailingIcon: Icons.arrow_forward,
            style: ButtonStyler().iconAlignment(.end),
            onPressed: () {},
          ),
        );
        await tester.pumpAndSettle();

        final labelX = tester.getTopLeft(find.text('Continue')).dx;
        expect(
          tester.getTopLeft(find.byIcon(Icons.arrow_back)).dx,
          lessThan(labelX),
        );
        expect(
          tester.getTopLeft(find.byIcon(Icons.arrow_forward)).dx,
          greaterThan(labelX),
        );
      });
    });

    group('WidgetStateController', () {
      widgetControllerTest<ButtonSpec>(
        'contains disabled state when enabled is false',
        build: () =>
            RemixButton(label: 'Click Me', onPressed: () {}, enabled: false),
        expectedStates: {WidgetState.disabled},
      );

      widgetControllerTest<ButtonSpec>(
        'contains disabled state when onPressed is omitted',
        build: () => RemixButton(label: 'Click Me'),
        expectedStates: {WidgetState.disabled},
      );

      widgetControllerTest<ButtonSpec>(
        'contains hovered state when hovered',
        build: () => RemixButton(label: 'Hover Me', onPressed: () {}),
        act: hoverAction<RemixButton>,
        expectedStates: {WidgetState.hovered},
      );

      widgetControllerTest<ButtonSpec>(
        'contains focused state when focused',
        build: () => RemixButton(label: 'Focus Me', onPressed: () {}),
        act: focusAction<RemixButton>,
        expectedStates: {WidgetState.focused},
      );

      widgetControllerTest<ButtonSpec>(
        'contains pressed state when pressed',
        build: () => RemixButton(label: 'Press Me', onPressed: () {}),
        act: pressAction<RemixButton>,
        expectedStates: {WidgetState.pressed},
      );
    });

    group('Custom Builders', () {
      testWidgets('textBuilder renders custom text widget', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Original Label',
            textBuilder: (context, spec, text) {
              return Container(
                key: const ValueKey('custom_text'),
                child: Text('Custom: $text'),
              );
            },
            onPressed: () {},
          ),
        );

        await tester.pumpAndSettle();

        // Verify custom text widget is rendered
        expect(find.byKey(const ValueKey('custom_text')), findsOneWidget);
        expect(find.text('Custom: Original Label'), findsOneWidget);

        // Verify original label is not rendered as StyledText
        expect(find.text('Original Label'), findsNothing);
      });

      testWidgets('iconBuilder renders custom icon widget', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            leadingIcon: Icons.star,
            leadingIconBuilder: (context, spec, icon) {
              return Container(
                key: const ValueKey('custom_icon'),
                child: Icon(icon, color: Colors.red),
              );
            },
            onPressed: () {},
          ),
        );

        await tester.pumpAndSettle();

        // Verify custom icon widget is rendered
        expect(find.byKey(const ValueKey('custom_icon')), findsOneWidget);

        // Verify icon has custom color
        final icon = tester.widget<Icon>(find.byIcon(Icons.star));
        expect(icon.color, equals(Colors.red));
      });

      testWidgets('loadingBuilder renders custom loading widget', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            loading: true,
            loadingBuilder: (context, spec) {
              return Container(
                key: const ValueKey('custom_loading'),
                child: const CircularProgressIndicator(),
              );
            },
            onPressed: () {},
          ),
        );

        await tester
            .pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

        // Verify custom loading widget is rendered
        expect(find.byKey(const ValueKey('custom_loading')), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Verify default spinner is not rendered
        expect(find.byType(RemixSpinner), findsNothing);
      });

      testWidgets('builders receive correct parameters', (tester) async {
        TextSpec? receivedTextSpec;
        IconSpec? receivedIconSpec;
        SpinnerSpec? receivedSpinnerSpec;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test Label',
            leadingIcon: Icons.home,
            loading: true,
            textBuilder: (context, spec, text) {
              receivedTextSpec = spec;
              return Text(text);
            },
            leadingIconBuilder: (context, spec, icon) {
              receivedIconSpec = spec;
              return Icon(icon);
            },
            loadingBuilder: (context, spec) {
              receivedSpinnerSpec = spec;
              return const SizedBox.shrink();
            },
            onPressed: () {},
          ),
        );

        await tester.pumpAndSettle();

        // Verify builders received correct spec parameters
        expect(receivedTextSpec, isNotNull);
        expect(receivedIconSpec, isNotNull);
        expect(receivedSpinnerSpec, isNotNull);
      });
    });

    group('Interaction Tests', () {
      testWidgets('loading state shows spinner and hides content', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Loading',
            leadingIcon: Icons.download,
            loading: true,
            onPressed: () {},
          ),
        );

        await tester
            .pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

        // Verify spinner is present
        expect(find.byType(RemixSpinner), findsOneWidget);

        // Verify content is hidden but maintains size
        final VisibilityWidgets = tester.widgetList<Visibility>(
          find.byType(Visibility),
        );

        for (final visibility in VisibilityWidgets) {
          expect(visibility.visible, isFalse);
          expect(visibility.maintainSize, isTrue);
          expect(visibility.maintainState, isTrue);
          expect(visibility.maintainAnimation, isTrue);
        }
      });

      testWidgets('loading state makes button non-interactive', (tester) async {
        bool wasPressed = false;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Loading',
            loading: true,
            onPressed: () => wasPressed = true,
          ),
        );

        await tester
            .pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

        // Try to tap the button
        await tester.tap(find.byType(RemixButton));
        await tester.pump();

        expect(wasPressed, isFalse);
      });

      testWidgets('_isEnabled logic combines enabled, loading, and onPressed', (
        tester,
      ) async {
        // Test case 1: enabled=true, loading=false, onPressed=callback -> should be enabled
        int pressedCount = 0;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            enabled: true,
            loading: false,
            onPressed: () => pressedCount++,
          ),
        );

        await tester.pump();
        await tester.tap(find.byType(RemixButton));
        expect(pressedCount, equals(1));

        // Test case 2: enabled=false -> should be disabled
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            enabled: false,
            loading: false,
            onPressed: () {},
          ),
        );

        await tester.pump();
        await tester.tap(find.byType(RemixButton));
        expect(pressedCount, equals(1));

        // Test case 3: loading=true -> should be disabled
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            enabled: true,
            loading: true,
            onPressed: () {},
          ),
        );

        await tester.pump();
        await tester.tap(find.byType(RemixButton));
        expect(pressedCount, equals(1));

        // Test case 4: onPressed omitted -> should be disabled
        await tester.pumpRemixApp(
          const RemixButton(label: 'Test', enabled: true, loading: false),
        );

        await tester.pump();
        await tester.tap(find.byType(RemixButton));
        expect(pressedCount, equals(1));
      });

      testWidgets('onPressed fires when button is tapped', (tester) async {
        int pressCount = 0;

        await tester.pumpRemixApp(
          RemixButton(label: 'Tap Me', onPressed: () => pressCount++),
        );

        await tester.pumpAndSettle();

        // Tap the button
        await tester.tap(find.byType(RemixButton));
        await tester.pumpAndSettle();

        expect(pressCount, equals(1));
      });

      testWidgets('onLongPress fires on long press', (tester) async {
        int longPressCount = 0;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Long Press Me',
            onPressed: () {},
            onLongPress: () => longPressCount++,
          ),
        );

        await tester.pumpAndSettle();

        // Long press the button
        await tester.longPress(find.byType(RemixButton));
        await tester.pumpAndSettle();

        expect(longPressCount, equals(1));
      });

      testWidgets('callbacks do not fire when disabled', (tester) async {
        int pressCount = 0;
        int longPressCount = 0;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Disabled',
            enabled: false,
            onPressed: () => pressCount++,
            onLongPress: () => longPressCount++,
          ),
        );

        await tester.pumpAndSettle();

        // Try all interactions
        await tester.tap(find.byType(RemixButton));
        await tester.longPress(find.byType(RemixButton));
        await tester.pumpAndSettle();

        expect(pressCount, equals(0));
        expect(longPressCount, equals(0));
      });

      testWidgets('callbacks do not fire when loading', (tester) async {
        int pressCount = 0;
        int longPressCount = 0;

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Loading',
            loading: true,
            onPressed: () => pressCount++,
            onLongPress: () => longPressCount++,
          ),
        );

        await tester
            .pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

        // Try interactions
        await tester.tap(find.byType(RemixButton));
        await tester.longPress(find.byType(RemixButton));
        await tester.pump();

        expect(pressCount, equals(0));
        expect(longPressCount, equals(0));
      });

      testWidgets('enableFeedback controls haptic feedback', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'No Feedback',
            enableFeedback: false,
            onPressed: () {},
          ),
        );

        await tester.pumpAndSettle();

        final nakedButton = tester.widget<NakedButton>(
          find.byType(NakedButton),
        );
        expect(nakedButton.enableFeedback, isFalse);
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('autofocus requests focus on mount and button is focused', (
        tester,
      ) async {
        final focusNode = FocusNode();
        addTearDown(() {
          focusNode.dispose();
        });

        await tester.pumpRemixApp(
          RemixButton(
            label: 'Auto Focus',
            autofocus: true,
            onPressed: () {},
            focusNode: focusNode,
          ),
        );

        await tester.pumpAndSettle();

        final focused = tester.binding.focusManager.primaryFocus;
        expect(focused, equals(focusNode));
      });
    });

    group('Semantics and Accessibility', () {
      List<SemanticsNode> collectButtons(WidgetTester tester) {
        final root = tester.getSemantics(find.byType(Scaffold));
        final nodes = <SemanticsNode>[];
        bool visitor(SemanticsNode node) {
          if (!node.isMergedIntoParent &&
              node.getSemanticsData().flagsCollection.isButton) {
            nodes.add(node);
          }
          node.visitChildren(visitor);
          return true;
        }

        visitor(root);
        return nodes;
      }

      testWidgets('exposes exactly one button node and one accessible name', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(label: 'Save', onPressed: () {}),
          );
          await tester.pumpAndSettle();

          final buttons = collectButtons(tester);
          expect(buttons, hasLength(1));
          expect(buttons.single.label, 'Save');
          expect(find.semantics.byLabel('Save'), findsOne);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('semanticLabel overrides the visible label', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(
              label: 'Button Text',
              semanticLabel: 'Custom Semantic Label',
              onPressed: () {},
            ),
          );
          await tester.pumpAndSettle();

          final buttons = collectButtons(tester);
          expect(buttons, hasLength(1));
          expect(buttons.single.label, 'Custom Semantic Label');
          expect(buttons.single.label, isNot(contains('Button Text')));
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('semanticHint lives on the same button node', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(
              label: 'Save',
              semanticHint: 'Saves the current document',
              onPressed: () {},
            ),
          );
          await tester.pumpAndSettle();

          final buttons = collectButtons(tester);
          expect(buttons, hasLength(1));
          expect(
            buttons.single.getSemanticsData().hint,
            'Saves the current document',
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('tap-only button exposes tap and not long-press', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(label: 'Save', onPressed: () {}),
          );
          await tester.pumpAndSettle();

          expect(
            find.semantics.byLabel('Save').evaluate().single,
            isSemantics(
              label: 'Save',
              isButton: true,
              hasEnabledState: true,
              isEnabled: true,
              hasTapAction: true,
              hasLongPressAction: false,
            ),
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('long-press-only button exposes long-press and not tap', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(label: 'Hold', onLongPress: () {}),
          );
          await tester.pumpAndSettle();

          expect(
            find.semantics.byLabel('Hold').evaluate().single,
            isSemantics(
              label: 'Hold',
              isButton: true,
              hasEnabledState: true,
              isEnabled: true,
              hasTapAction: false,
              hasLongPressAction: true,
            ),
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('button with both actions exposes tap and long-press', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(label: 'Menu', onPressed: () {}, onLongPress: () {}),
          );
          await tester.pumpAndSettle();

          expect(
            find.semantics.byLabel('Menu').evaluate().single,
            isSemantics(
              label: 'Menu',
              isButton: true,
              hasEnabledState: true,
              isEnabled: true,
              hasTapAction: true,
              hasLongPressAction: true,
            ),
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('disabled button stays one non-interactive node', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          var pressed = 0;
          var longPressed = 0;
          await tester.pumpRemixApp(
            RemixButton(
              label: 'Save',
              enabled: false,
              onPressed: () => pressed++,
              onLongPress: () => longPressed++,
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.semantics.byLabel('Save').evaluate().single,
            isSemantics(
              label: 'Save',
              isButton: true,
              hasEnabledState: true,
              isEnabled: false,
              hasTapAction: false,
              hasLongPressAction: false,
            ),
          );
          await tester.tap(find.byType(RemixButton));
          await tester.longPress(find.byType(RemixButton));
          await tester.pump();
          expect(pressed, 0);
          expect(longPressed, 0);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('loading stays one non-interactive button node', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          var pressed = 0;
          var longPressed = 0;
          await tester.pumpRemixApp(
            RemixButton(
              label: 'Save',
              loading: true,
              onPressed: () => pressed++,
              onLongPress: () => longPressed++,
            ),
          );
          await tester.pump();

          expect(find.byType(RemixSpinner), findsOneWidget);
          final buttons = collectButtons(tester);
          expect(buttons, hasLength(1));
          expect(
            buttons.single,
            isSemantics(
              label: 'Save',
              isButton: true,
              hasEnabledState: true,
              isEnabled: false,
              hasTapAction: false,
              hasLongPressAction: false,
            ),
          );
          await tester.tap(find.byType(RemixButton));
          await tester.longPress(find.byType(RemixButton));
          await tester.pump();
          expect(pressed, 0);
          expect(longPressed, 0);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('excludeSemantics hides the complete control', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(
              label: 'Test',
              excludeSemantics: true,
              onPressed: () {},
            ),
          );
          await tester.pumpAndSettle();

          expect(find.semantics.byLabel('Test'), findsNothing);
          expect(collectButtons(tester), isEmpty);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('visible label is not republished as a second name', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixButton(label: 'Save', onPressed: () {}),
          );
          await tester.pumpAndSettle();

          expect(find.semantics.byLabel('Save'), findsOne);
        } finally {
          semantics.dispose();
        }
      });
    });

    group('Layout and Sizing', () {
      testWidgets('Row with MainAxisSize.min is applied by default', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixButton(label: 'Test', onPressed: () {}));

        await tester.pumpAndSettle();

        // Find the Flex widget (the internal flex used by the button)
        final flexFinder = find.byType(Flex);
        expect(flexFinder, findsOneWidget);

        // Get the Flex widget and verify its mainAxisSize
        final flexWidget = tester.widget<Flex>(flexFinder);
        expect(flexWidget.mainAxisSize, equals(MainAxisSize.min));
      });

      testWidgets('mouseCursor defaults to SystemMouseCursors.click', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixButton(label: 'Test', onPressed: () {}));

        await tester.pumpAndSettle();

        final button = tester.widget<RemixButton>(find.byType(RemixButton));
        expect(button.mouseCursor, equals(SystemMouseCursors.click));
      });

      testWidgets('custom mouseCursor is applied', (tester) async {
        await tester.pumpRemixApp(
          RemixButton(
            label: 'Test',
            mouseCursor: SystemMouseCursors.forbidden,
            onPressed: () {},
          ),
        );

        await tester.pumpAndSettle();

        final button = tester.widget<RemixButton>(find.byType(RemixButton));
        expect(button.mouseCursor, equals(SystemMouseCursors.forbidden));
      });
    });
  });
}
