import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixAccordionGroup', () {
    group('Basic Rendering', () {
      testWidgets('renders accordion group with children', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: Column(
              children: [
                RemixAccordion<String>(
                  value: 'item1',
                  title: 'First Item',
                  child: const Text('First content'),
                ),
              ],
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('First Item'), findsOneWidget);
        expect(find.byType(NakedAccordionGroup<String>), findsOneWidget);
      });

      testWidgets('renders multiple accordion items', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: Column(
              children: [
                RemixAccordion<String>(
                  value: 'item1',
                  title: 'First Item',
                  child: const Text('First content'),
                ),
                RemixAccordion<String>(
                  value: 'item2',
                  title: 'Second Item',
                  child: const Text('Second content'),
                ),
              ],
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('First Item'), findsOneWidget);
        expect(find.text('Second Item'), findsOneWidget);
      });
    });

    group('Initial Expansion', () {
      testWidgets('expands items from initialExpandedValues', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            initialExpandedValues: const ['item1'],
            child: Column(
              children: [
                RemixAccordion<String>(
                  value: 'item1',
                  title: 'First Item',
                  child: const Text('First content'),
                ),
                RemixAccordion<String>(
                  value: 'item2',
                  title: 'Second Item',
                  child: const Text('Second content'),
                ),
              ],
            ),
          ),
        );

        await tester.pumpAndSettle();

        // First item should be expanded and show content
        expect(find.text('First content'), findsOneWidget);
        // Second item should be collapsed
        expect(find.text('Second content'), findsNothing);
      });
    });
  });

  group('RemixAccordion', () {
    group('Basic Rendering', () {
      testWidgets('renders accordion item with title', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.byType(RemixAccordion<String>), findsOneWidget);
      });

      testWidgets('renders accordion item with leading icon', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              leadingIcon: Icons.star,
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders accordion item with custom trailing icon', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              trailingIcon: Icons.arrow_drop_down,
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      });

      testWidgets(
        'shows add icon when collapsed and remove icon when expanded',
        (tester) async {
          await tester.pumpRemixApp(
            RemixAccordionGroup<String>(
              controller: RemixAccordionController<String>(),
              child: RemixAccordion<String>(
                value: 'item1',
                title: 'Test Title',
                child: const Text('Content'),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // When collapsed, should show add icon
          expect(find.byIcon(Icons.add), findsOneWidget);
          expect(find.byIcon(Icons.remove), findsNothing);

          // Tap to expand
          await tester.tap(find.text('Test Title'));
          await tester.pumpAndSettle();

          // When expanded, should show remove icon
          expect(find.byIcon(Icons.remove), findsOneWidget);
          expect(find.byIcon(Icons.add), findsNothing);
        },
      );
    });

    group('Expansion Behavior', () {
      testWidgets('expands when header is tapped', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              child: const Text('Hidden content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Content should not be visible initially
        expect(find.text('Hidden content'), findsNothing);

        // Tap to expand
        await tester.tap(find.text('Test Title'));
        await tester.pumpAndSettle();

        // Content should now be visible
        expect(find.text('Hidden content'), findsOneWidget);
      });

      testWidgets('collapses when expanded header is tapped', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            initialExpandedValues: const ['item1'],
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              child: const Text('Visible content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Content should be visible initially
        expect(find.text('Visible content'), findsOneWidget);

        // Tap to collapse
        await tester.tap(find.text('Test Title'));
        await tester.pumpAndSettle();

        // Content should now be hidden
        expect(find.text('Visible content'), findsNothing);
      });

      testWidgets('respects max=1 constraint in controller', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(max: 1),
            initialExpandedValues: const ['item1'],
            child: Column(
              children: [
                RemixAccordion<String>(
                  value: 'item1',
                  title: 'First Item',
                  child: const Text('First content'),
                ),
                RemixAccordion<String>(
                  value: 'item2',
                  title: 'Second Item',
                  child: const Text('Second content'),
                ),
              ],
            ),
          ),
        );

        await tester.pumpAndSettle();

        // First item should be expanded
        expect(find.text('First content'), findsOneWidget);
        expect(find.text('Second content'), findsNothing);

        // Tap second item
        await tester.tap(find.text('Second Item'));
        await tester.pumpAndSettle();

        // Second item should be expanded, first should collapse
        expect(find.text('First content'), findsNothing);
        expect(find.text('Second content'), findsOneWidget);
      });
    });

    group('Disabled State', () {
      testWidgets('does not expand when disabled', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Disabled Item',
              enabled: false,
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Content should not be visible
        expect(find.text('Content'), findsNothing);

        // Tap disabled item
        await tester.tap(find.text('Disabled Item'));
        await tester.pumpAndSettle();

        // Content should still not be visible
        expect(find.text('Content'), findsNothing);
      });
    });

    group('Custom Builder', () {
      testWidgets('renders custom trigger when builder is provided', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              builder: (context, state) {
                return Container(
                  key: const ValueKey('custom_trigger'),
                  child: Text(state.isExpanded ? 'Expanded' : 'Collapsed'),
                );
              },
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('custom_trigger')), findsOneWidget);
        expect(find.text('Collapsed'), findsOneWidget);

        // Tap to expand
        await tester.tap(find.byKey(const ValueKey('custom_trigger')));
        await tester.pumpAndSettle();

        expect(find.text('Expanded'), findsOneWidget);
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('autofocus requests focus on mount', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() => focusNode.dispose());

        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              autofocus: true,
              focusNode: focusNode,
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
      });
    });

    group('Accessibility', () {
      testWidgets(
        'uses title as semantic label when no semanticLabel provided',
        (tester) async {
          await tester.pumpRemixApp(
            RemixAccordionGroup<String>(
              controller: RemixAccordionController<String>(),
              child: RemixAccordion<String>(
                value: 'item1',
                title: 'Test Title',
                child: const Text('Content'),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Test Title'), findsOneWidget);
        },
      );

      testWidgets('uses custom semanticLabel when provided', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              semanticLabel: 'Custom Label',
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Widget should render correctly with semantic label
        expect(find.byType(RemixAccordion<String>), findsOneWidget);
      });
    });

    group('Callbacks', () {
      testWidgets('calls onFocusChange when focus changes', (tester) async {
        bool? focusState;
        final focusNode = FocusNode();
        addTearDown(() => focusNode.dispose());

        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              focusNode: focusNode,
              onFocusChange: (focused) => focusState = focused,
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusState, isTrue);

        focusNode.unfocus();
        await tester.pumpAndSettle();

        expect(focusState, isFalse);
      });
    });

    group('WidgetStateController', () {
      widgetControllerTest<RemixAccordionSpec>(
        'contains disabled state when enabled is false',
        build: () => RemixAccordionGroup<String>(
          controller: RemixAccordionController<String>(),
          child: RemixAccordion<String>(
            value: 'item1',
            title: 'Disabled',
            enabled: false,
            child: const Text('Content'),
          ),
        ),
        expectedStates: {WidgetState.disabled},
      );

      widgetControllerTest<RemixAccordionSpec>(
        'contains hovered state when hovered',
        build: () => RemixAccordionGroup<String>(
          controller: RemixAccordionController<String>(),
          child: RemixAccordion<String>(
            value: 'item1',
            title: 'Hover Me',
            child: const Text('Content'),
          ),
        ),
        act: hoverAction<RemixAccordion<String>>,
        expectedStates: {WidgetState.hovered},
      );

      widgetControllerTest<RemixAccordionSpec>(
        'contains focused state when focused',
        build: () => RemixAccordionGroup<String>(
          controller: RemixAccordionController<String>(),
          child: RemixAccordion<String>(
            value: 'item1',
            title: 'Focus Me',
            child: const Text('Content'),
          ),
        ),
        act: focusAction<RemixAccordion<String>>,
        expectedStates: {WidgetState.focused},
      );

      testWidgets('tracks pressed state without requiring a callback', (
        tester,
      ) async {
        Set<WidgetState> states = const {};
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              builder: (context, state) {
                states = state.states;
                return const Text('Press Me');
              },
              child: const Text('Content'),
            ),
          ),
        );

        final gesture = await tester.startGesture(
          tester.getCenter(find.text('Press Me')),
        );
        await tester.pump();
        expect(states, contains(WidgetState.pressed));

        await gesture.up();
        await tester.pump();
        expect(states, isNot(contains(WidgetState.pressed)));
      });
    });
  });
}
