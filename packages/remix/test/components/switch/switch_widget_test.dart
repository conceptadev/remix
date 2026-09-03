import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSwitch', () {
    group('Basic Rendering', () {
      testWidgets('renders switch with minimal props', (tester) async {
        await tester.pumpRemixApp(
          const RemixSwitch(semanticLabel: 'Toggle', selected: false),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('renders switch in selected state', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: true,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('renders switch in unselected state', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('renders with custom style', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: SwitchStyler().thumbColor(Colors.blue),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Interaction', () {
      testWidgets('calls onChanged when tapped', (tester) async {
        bool wasChanged = false;
        bool newValue = false;

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {
              wasChanged = true;
              newValue = value;
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(wasChanged, isTrue);
        expect(newValue, isTrue);
      });

      testWidgets('toggles between states', (tester) async {
        bool switchValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSwitch(
                semanticLabel: 'Toggle',
                selected: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(switchValue, isFalse);

        // Toggle to true
        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(switchValue, isTrue);

        // Toggle back to false
        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(switchValue, isFalse);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool wasChanged = false;

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {
              wasChanged = true;
            },
            enabled: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(wasChanged, isFalse);
      });

      testWidgets('omitted onChanged disables interaction', (tester) async {
        await tester.pumpRemixApp(
          const RemixSwitch(semanticLabel: 'Toggle', selected: false),
        );
        await tester.pumpAndSettle();

        final nakedToggle = tester.widget<NakedToggle>(
          find.byType(NakedToggle),
        );
        expect(nakedToggle.onChanged, isNull);

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('calls onChanged when enabled and not when disabled', (
        tester,
      ) async {
        bool enabledChanged = false;
        bool disabledChanged = false;

        // Enabled switch - should call onChanged
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {
              enabledChanged = true;
            },
            enabled: true,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(enabledChanged, isTrue);

        // Now check disabled - should NOT call onChanged
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {
              disabledChanged = true;
            },
            enabled: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(disabledChanged, isFalse);
      });
    });

    group('Focus', () {
      testWidgets('accepts focusNode parameter', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
        focusNode.dispose();
      });

      testWidgets('handles autofocus parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            autofocus: true,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('can request focus programmatically', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
        focusNode.dispose();
      });
    });

    group('Styling', () {
      testWidgets('applies custom thumb color', (tester) async {
        final customStyle = SwitchStyler().thumbColor(Colors.blue);

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies custom thumb styling', (tester) async {
        final customStyle = SwitchStyler().thumb(
          BoxStyler(
            decoration: BoxDecorationMix(
              color: Colors.red,
              borderRadius: BorderRadiusMix.circular(8.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies alignment styling', (tester) async {
        final customStyle = SwitchStyler().alignment(Alignment.centerRight);

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies padding styling', (tester) async {
        final customStyle = SwitchStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies margin styling', (tester) async {
        final customStyle = SwitchStyler().margin(
          EdgeInsetsGeometryMix.all(8.0),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies constraints styling', (tester) async {
        final customStyle = SwitchStyler().constraints(
          BoxConstraintsMix(minWidth: 40.0, minHeight: 20.0),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies decoration styling', (tester) async {
        final customStyle = SwitchStyler().decoration(
          BoxDecorationMix(
            color: Colors.blue,
            borderRadius: BorderRadiusMix.circular(12.0),
          ),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            selected: false,
            semanticLabel: 'Toggle',
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Semantics and Accessibility', () {
      testWidgets('accepts semanticLabel parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            selected: false,
            onChanged: (value) {},
            semanticLabel: 'Toggle setting',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('has proper semantics for screen readers', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            selected: true,
            onChanged: (value) {},
            semanticLabel: 'Enable notifications',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Mouse Cursor', () {
      testWidgets('accepts mouseCursor parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            mouseCursor: SystemMouseCursors.click,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('can use custom mouse cursor', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            mouseCursor: SystemMouseCursors.forbidden,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Haptic Feedback', () {
      testWidgets('accepts enableFeedback parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            enableFeedback: true,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('handles disabled feedback', (tester) async {
        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            enableFeedback: false,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Advanced Styling', () {
      testWidgets('applies multiple style methods', (tester) async {
        final customStyle = SwitchStyler()
            .thumbColor(Colors.blue)
            .alignment(Alignment.centerLeft)
            .padding(EdgeInsetsGeometryMix.all(8.0))
            .decoration(
              BoxDecorationMix(
                color: Colors.grey,
                borderRadius: BorderRadiusMix.circular(16.0),
              ),
            );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies animation config', (tester) async {
        final customStyle = SwitchStyler().animate(
          AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies foreground decoration', (tester) async {
        final customStyle = SwitchStyler().foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.blue)),
          ),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('applies transform', (tester) async {
        final customStyle = SwitchStyler().transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.center,
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        final customStyle = SwitchStyler().wrap(.clipOval());

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('switch_key');

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            key: key,
            selected: false,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('accepts styleSpec parameter', (tester) async {
        const spec = SwitchSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
          thumb: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.blue)),
          ),
        );

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            styleSpec: spec,
            selected: false,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        final decorations = tester
            .widgetList<Box>(find.byType(Box))
            .map((box) => box.styleSpec?.spec.decoration);

        expect(
          decorations,
          contains(equals(const BoxDecoration(color: Colors.red))),
        );
        expect(
          decorations,
          contains(equals(const BoxDecoration(color: Colors.blue))),
        );
      });
    });

    group('Edge Cases', () {
      testWidgets('handles rapid toggling', (tester) async {
        bool switchValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSwitch(
                semanticLabel: 'Toggle',
                selected: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        // Rapid toggling
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(RemixSwitch));
          await tester.pump();
        }
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);
      });

      testWidgets('handles disabled state with enabled=false', (tester) async {
        bool wasChanged = false;

        await tester.pumpRemixApp(
          RemixSwitch(
            semanticLabel: 'Toggle',
            selected: false,
            onChanged: (value) {
              wasChanged = true;
            },
            enabled: false,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSwitch), findsOneWidget);

        // Should not call onChanged when disabled
        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();

        expect(wasChanged, isFalse);
      });
    });

    group('State Changes', () {
      testWidgets('updates when selected value changes', (tester) async {
        bool switchValue = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  RemixSwitch(
                    semanticLabel: 'Toggle',
                    selected: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        switchValue = !switchValue;
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

        expect(switchValue, isFalse);

        // Tap button to toggle programmatically
        await tester.tap(find.text('Toggle Programmatically'));
        await tester.pumpAndSettle();

        expect(switchValue, isTrue);
      });
    });

    group('Accessible naming', () {
      test('rejects an empty accessible name', () {
        expect(
          () => RemixSwitch(selected: false, semanticLabel: ''),
          throwsAssertionError,
        );
      });

      testWidgets('announces switch role and label', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixSwitch(
              selected: false,
              semanticLabel: 'Airplane mode',
              onChanged: (_) {},
            ),
          );
          await tester.pumpAndSettle();

          expect(find.semantics.byLabel('Airplane mode'), findsOne);
          expect(
            find.semantics.byLabel('Airplane mode').evaluate().single,
            isSemantics(
              label: 'Airplane mode',
              isEnabled: true,
              hasToggledState: true,
              isToggled: false,
            ),
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('tap and keyboard activate the switch', (tester) async {
        var selected = false;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSwitch(
                selected: selected,
                semanticLabel: 'Airplane mode',
                focusNode: focusNode,
                onChanged: (value) => setState(() => selected = value),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();
        expect(selected, isTrue);

        focusNode.requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        expect(selected, isFalse);
      });

      testWidgets('disabled switch does not toggle', (tester) async {
        var selected = false;
        await tester.pumpRemixApp(
          RemixSwitch(
            selected: selected,
            semanticLabel: 'Airplane mode',
            enabled: false,
            onChanged: (value) => selected = value,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byType(RemixSwitch));
        await tester.pumpAndSettle();
        expect(selected, isFalse);
      });
    });
  });
}
