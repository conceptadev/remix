import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

/// The single coloured [Box] in the tree is the outer panel: every test that
/// uses this styles `container(...)` and nothing else that paints a fill.
Color? _panelColor(WidgetTester tester) {
  return tester
      .widgetList<Box>(find.byType(Box))
      .map((box) => (box.styleSpec?.spec.decoration as BoxDecoration?)?.color)
      .where((color) => color != null)
      .single;
}

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

      testWidgets('renders container effects on the outer panel', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              style: AccordionStyler(
                containerEffects: RemixBoxEffectsMix(backdropBlur: 4),
              ),
              child: const Text('Content'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(BackdropFilter), findsOneWidget);
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

          expect(_pathGlyph(RemixPathGlyph.plus), findsOneWidget);
          expect(_pathGlyph(RemixPathGlyph.minus), findsNothing);

          // Tap to expand
          await tester.tap(find.text('Test Title'));
          await tester.pumpAndSettle();

          expect(_pathGlyph(RemixPathGlyph.minus), findsOneWidget);
          expect(_pathGlyph(RemixPathGlyph.plus), findsNothing);
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

    group('Expansion-Conditional Styling', () {
      testWidgets(
        'onExpanded and onCollapsed style the panel across live taps',
        (tester) async {
          final style = AccordionStyler()
              .container(.color(Colors.blue))
              .onExpanded<String>(.container(.color(Colors.green)))
              .onCollapsed<String>(.container(.color(Colors.red)));

          await tester.pumpRemixApp(
            RemixAccordionGroup<String>(
              controller: RemixAccordionController<String>(),
              child: RemixAccordion<String>(
                value: 'item1',
                title: 'Test Title',
                style: style,
                child: const Text('Content'),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(_panelColor(tester), Colors.red);

          await tester.tap(find.text('Test Title'));
          await tester.pumpAndSettle();

          expect(_panelColor(tester), Colors.green);

          await tester.tap(find.text('Test Title'));
          await tester.pumpAndSettle();

          expect(_panelColor(tester), Colors.red);
        },
      );

      testWidgets(
        'onCanExpand and onCanCollapse style the panel across live taps',
        (tester) async {
          final style = AccordionStyler()
              .container(.color(Colors.blue))
              .onCanExpand<String>(.container(.color(Colors.green)))
              .onCanCollapse(.container(.color(Colors.red)));

          await tester.pumpRemixApp(
            RemixAccordionGroup<String>(
              controller: RemixAccordionController<String>(min: 0, max: 1),
              child: RemixAccordion<String>(
                value: 'item1',
                title: 'Test Title',
                style: style,
                child: const Text('Content'),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(_panelColor(tester), Colors.green);

          await tester.tap(find.text('Test Title'));
          await tester.pumpAndSettle();

          expect(_panelColor(tester), Colors.red);
        },
      );
    });

    // The panel container is mounted above NakedAccordion, which publishes its
    // interaction states only to its own descendants. These pin that the
    // container still observes the trigger's states, and only the trigger's.
    group('Interaction-Conditional Panel Styling', () {
      testWidgets('onDisabled styles the panel from the first frame', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              enabled: false,
              style: AccordionStyler()
                  .container(.color(Colors.blue))
                  .onDisabled(.container(.color(Colors.red))),
              child: const Text('Content'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.red);
      });

      testWidgets('onDisabled styles the panel when enabled flips at runtime', (
        tester,
      ) async {
        final controller = RemixAccordionController<String>();
        addTearDown(controller.dispose);
        var enabled = true;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RemixAccordionGroup<String>(
                  controller: controller,
                  child: RemixAccordion<String>(
                    value: 'item1',
                    title: 'Test Title',
                    enabled: enabled,
                    style: AccordionStyler()
                        .container(.color(Colors.blue))
                        .onDisabled(.container(.color(Colors.red))),
                    child: const Text('Content'),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => enabled = false),
                  child: const Text('Disable'),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);

        await tester.tap(find.text('Disable'));
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.red);
      });

      testWidgets('onDisabled reaches containerEffects as well as container', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              enabled: false,
              style: AccordionStyler().onDisabled(
                .containerEffects(RemixBoxEffectsMix(backdropBlur: 4)),
              ),
              child: const Text('Content'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(BackdropFilter), findsOneWidget);
      });

      testWidgets('onHovered styles the panel from the trigger, and clears '
          'when the pointer moves into the expanded content', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            initialExpandedValues: const ['item1'],
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              style: AccordionStyler()
                  .container(.color(Colors.blue))
                  .onHovered(.container(.color(Colors.green))),
              child: const Text('Panel body'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(kind: .mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

        await gesture.moveTo(tester.getCenter(find.text('Test Title')));
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.green);

        await gesture.moveTo(tester.getCenter(find.text('Panel body')));
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);
      });

      testWidgets('onPressed styles the panel while the trigger is held, and '
          'not while the expanded content is', (tester) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            initialExpandedValues: const ['item1'],
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              style: AccordionStyler()
                  .container(.color(Colors.blue))
                  .onPressed(.container(.color(Colors.green))),
              child: const Text('Panel body'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final trigger = await tester.startGesture(
          tester.getCenter(find.text('Test Title')),
        );
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.green);

        await trigger.up();
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);
      });

      testWidgets('onPressed ignores presses on the expanded content', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            initialExpandedValues: const ['item1'],
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              style: AccordionStyler()
                  .container(.color(Colors.blue))
                  .onPressed(.container(.color(Colors.green))),
              child: const Text('Panel body'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final content = await tester.startGesture(
          tester.getCenter(find.text('Panel body')),
        );
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);

        await content.up();
        await tester.pumpAndSettle();
      });

      testWidgets('onFocused and onFocusVisible style the panel, the latter '
          'only while the highlight mode is traditional', (tester) async {
        final previousStrategy = FocusManager.instance.highlightStrategy;
        addTearDown(() {
          FocusManager.instance.highlightStrategy = previousStrategy;
        });
        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.alwaysTouch;

        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              focusNode: focusNode,
              style: AccordionStyler()
                  .container(.color(Colors.blue))
                  .onFocused(.container(.color(Colors.green)))
                  .onFocusVisible(.container(.color(Colors.orange))),
              child: const Text('Content'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.green);

        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.alwaysTraditional;
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.orange);

        focusNode.unfocus();
        await tester.pumpAndSettle();

        expect(_panelColor(tester), Colors.blue);
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

      testWidgets('forwards focus, hover, and press exactly once per '
          'transition', (tester) async {
        final focusEvents = <bool>[];
        final hoverEvents = <bool>[];
        final pressEvents = <bool>[];
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixAccordionGroup<String>(
            controller: RemixAccordionController<String>(),
            child: RemixAccordion<String>(
              value: 'item1',
              title: 'Test Title',
              focusNode: focusNode,
              onFocusChange: focusEvents.add,
              onHoverChange: hoverEvents.add,
              onPressChange: pressEvents.add,
              child: const Text('Content'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final triggerCenter = tester.getCenter(find.text('Test Title'));

        final pointer = await tester.createGesture(kind: .mouse);
        await pointer.addPointer(location: Offset.zero);
        addTearDown(pointer.removePointer);
        await pointer.moveTo(triggerCenter);
        await tester.pumpAndSettle();
        await pointer.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        focusNode.unfocus();
        await tester.pumpAndSettle();

        final press = await tester.startGesture(triggerCenter);
        await tester.pumpAndSettle();
        await press.up();
        await tester.pumpAndSettle();

        expect(hoverEvents, [true, false]);
        expect(focusEvents, [true, false]);
        expect(pressEvents, [true, false]);
      });
    });

    group('WidgetStateController', () {
      widgetControllerTest<AccordionSpec>(
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

      widgetControllerTest<AccordionSpec>(
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

      widgetControllerTest<AccordionSpec>(
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

      // Note: pressAction won't work here - the tappable header is in nested
      // widgets, not on RemixAccordion itself. Press behavior is covered in
      // the expansion behavior tests above.
    });

    group('Default transition', () {
      testWidgets('anchors the panel to the bottom start while expanding', (
        tester,
      ) async {
        // Pins the alignment the builder actually renders, so the
        // `axisAlignment` spelling it uses to stay on Flutter 3.41 cannot drift
        // away from `AlignmentDirectional.bottomStart`.
        final animation = AlwaysStoppedAnimation<double>(0.5);

        await tester.pumpRemixApp(
          RemixAccordion.defaultAccordionTransitionBuilder(
            const Text('Panel'),
            animation,
          ),
        );

        final align = tester.widget<Align>(
          find.descendant(
            of: find.byType(SizeTransition),
            matching: find.byType(Align),
          ),
        );

        expect(align.alignment, AlignmentDirectional.bottomStart);
        expect(align.heightFactor, 0.5);
      });
    });
  });
}

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);
