import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixToggle', () {
    group('Basic Rendering', () {
      testWidgets('renders toggle with label only', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(selected: false, onChanged: (value) {}, label: 'Bold'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Bold'), findsOneWidget);
        expect(find.byType(NakedToggle), findsOneWidget);
      });

      testWidgets('renders toggle with icon only', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            icon: Icons.format_bold,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.format_bold), findsOneWidget);
        expect(find.byType(NakedToggle), findsOneWidget);
      });

      testWidgets('renders toggle with both icon and label', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            icon: Icons.format_bold,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Bold'), findsOneWidget);
        expect(find.byIcon(Icons.format_bold), findsOneWidget);
      });
    });

    group('WidgetStateController', () {
      widgetControllerTest<RemixToggleSpec>(
        'contains disabled state when enabled is false',
        build: () => RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Bold',
          enabled: false,
        ),
        expectedStates: {WidgetState.disabled},
      );

      widgetControllerTest<RemixToggleSpec>(
        'contains hovered state when hovered',
        build: () => RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Hover Me',
        ),
        act: hoverAction<RemixToggle>,
        expectedStates: {WidgetState.hovered},
      );

      widgetControllerTest<RemixToggleSpec>(
        'contains focused state when focused',
        build: () => RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Focus Me',
        ),
        act: focusAction<RemixToggle>,
        expectedStates: {WidgetState.focused},
      );

      widgetControllerTest<RemixToggleSpec>(
        'contains pressed state when pressed',
        build: () => RemixToggle(
          selected: false,
          onChanged: (value) {},
          label: 'Press Me',
        ),
        act: pressAction<RemixToggle>,
        expectedStates: {WidgetState.pressed},
      );
    });

    group('Interaction', () {
      testWidgets('calls onChanged when tapped', (tester) async {
        bool wasChanged = false;
        bool newValue = false;

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {
              wasChanged = true;
              newValue = value;
            },
            label: 'Bold',
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixToggle));
        await tester.pumpAndSettle();

        expect(wasChanged, isTrue);
        expect(newValue, isTrue);
      });

      testWidgets('toggles between states', (tester) async {
        bool toggleValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixToggle(
                selected: toggleValue,
                onChanged: (value) {
                  setState(() {
                    toggleValue = value;
                  });
                },
                label: 'Bold',
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(toggleValue, isFalse);

        await tester.tap(find.byType(RemixToggle));
        await tester.pumpAndSettle();

        expect(toggleValue, isTrue);

        await tester.tap(find.byType(RemixToggle));
        await tester.pumpAndSettle();

        expect(toggleValue, isFalse);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool wasChanged = false;

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {
              wasChanged = true;
            },
            label: 'Bold',
            enabled: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixToggle));
        await tester.pumpAndSettle();

        expect(wasChanged, isFalse);
      });

      testWidgets('omitted onChanged disables interaction', (tester) async {
        await tester.pumpRemixApp(
          const RemixToggle(selected: false, label: 'Bold'),
        );
        await tester.pumpAndSettle();

        final nakedToggle = tester.widget<NakedToggle>(
          find.byType(NakedToggle),
        );
        expect(nakedToggle.onChanged, isNull);

        await tester.tap(find.byType(RemixToggle));
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });

      testWidgets('enableFeedback controls haptic feedback', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'No Feedback',
            enableFeedback: false,
          ),
        );
        await tester.pumpAndSettle();

        final nakedToggle = tester.widget<NakedToggle>(
          find.byType(NakedToggle),
        );
        expect(nakedToggle.enableFeedback, isFalse);
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('autofocus requests focus on mount', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() {
          focusNode.dispose();
        });

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Auto Focus',
            autofocus: true,
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        final focused = tester.binding.focusManager.primaryFocus;
        expect(focused, equals(focusNode));
      });

      testWidgets('can request focus programmatically', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() {
          focusNode.dispose();
        });

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
      });
    });

    group('Semantics and Accessibility', () {
      testWidgets('accepts semanticLabel parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            semanticLabel: 'Toggle bold formatting',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(Semantics), findsAtLeastNWidgets(1));

        final toggle = tester.widget<RemixToggle>(find.byType(RemixToggle));
        expect(toggle.semanticLabel, equals('Toggle bold formatting'));
      });
    });

    group('Layout and Sizing', () {
      testWidgets('mouseCursor defaults to SystemMouseCursors.click', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixToggle(selected: false, onChanged: (value) {}, label: 'Bold'),
        );
        await tester.pumpAndSettle();

        final toggle = tester.widget<RemixToggle>(find.byType(RemixToggle));
        expect(toggle.mouseCursor, equals(SystemMouseCursors.click));
      });

      testWidgets('custom mouseCursor is applied', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            mouseCursor: SystemMouseCursors.forbidden,
          ),
        );
        await tester.pumpAndSettle();

        final toggle = tester.widget<RemixToggle>(find.byType(RemixToggle));
        expect(toggle.mouseCursor, equals(SystemMouseCursors.forbidden));
      });
    });

    group('Styling', () {
      testWidgets('applies padding styling', (tester) async {
        final customStyle = RemixToggleStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });

      testWidgets('applies multiple style methods', (tester) async {
        final customStyle = RemixToggleStyler()
            .backgroundColor(Colors.blue)
            .labelColor(Colors.white)
            .iconColor(Colors.white)
            .padding(EdgeInsetsGeometryMix.all(8.0))
            .decoration(
              BoxDecorationMix(borderRadius: BorderRadiusMix.circular(8.0)),
            );

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            icon: Icons.format_bold,
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });

      testWidgets('applies animation config', (tester) async {
        final customStyle = RemixToggleStyler().animate(
          AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });
    });

    group('Fortal Styles', () {
      testWidgets('renders with ghost variant', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            style: fortalToggleStyle(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });

      testWidgets('renders with outline variant', (tester) async {
        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            style: fortalToggleStyle(variant: .outline),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });

      testWidgets('renders with all sizes', (tester) async {
        for (final size in FortalToggleSize.values) {
          await tester.pumpRemixApp(
            RemixToggle(
              selected: false,
              onChanged: (value) {},
              label: 'Bold',
              style: fortalToggleStyle(size: size),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(RemixToggle), findsOneWidget);
        }
      });

      testWidgets('recipe works for all variant/size combos', (tester) async {
        for (final variant in FortalToggleVariant.values) {
          for (final size in FortalToggleSize.values) {
            await tester.pumpRemixApp(
              RemixToggle(
                selected: false,
                onChanged: (value) {},
                label: 'Bold',
                style: fortalToggleStyle(variant: variant, size: size),
              ),
            );
            await tester.pumpAndSettle();

            expect(find.byType(RemixToggle), findsOneWidget);
          }
        }
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('toggle_key');

        await tester.pumpRemixApp(
          RemixToggle(
            key: key,
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('applies raw styleSpec when provided', (tester) async {
        const spec = RemixToggleSpec(
          container: StyleSpec(
            spec: FlexBoxSpec(
              box: StyleSpec(
                spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
              ),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixToggle(
            selected: false,
            onChanged: (value) {},
            label: 'Bold',
            styleSpec: spec,
          ),
        );
        await tester.pumpAndSettle();

        final decorations = tester
            .widgetList<RowBox>(find.byType(RowBox))
            .map((box) => box.styleSpec?.spec.box?.spec.decoration);

        expect(
          decorations,
          contains(equals(const BoxDecoration(color: Colors.red))),
        );
      });

      testWidgets('handles rapid toggling', (tester) async {
        bool toggleValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixToggle(
                selected: toggleValue,
                onChanged: (value) {
                  setState(() {
                    toggleValue = value;
                  });
                },
                label: 'Bold',
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(RemixToggle));
          await tester.pump();
        }
        await tester.pumpAndSettle();

        expect(find.byType(RemixToggle), findsOneWidget);
      });
    });

    group('State Changes', () {
      testWidgets('updates when selected value changes programmatically', (
        tester,
      ) async {
        bool toggleValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  RemixToggle(
                    selected: toggleValue,
                    onChanged: (value) {
                      setState(() {
                        toggleValue = value;
                      });
                    },
                    label: 'Bold',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        toggleValue = !toggleValue;
                      });
                    },
                    child: const Text('Toggle Programmatically'),
                  ),
                ],
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(toggleValue, isFalse);

        await tester.tap(find.text('Toggle Programmatically'));
        await tester.pumpAndSettle();

        expect(toggleValue, isTrue);
      });
    });
  });
}
