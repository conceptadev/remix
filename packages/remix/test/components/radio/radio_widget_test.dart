import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixRadio', () {
    group('Basic Rendering', () {
      testWidgets('renders radio with minimal props within group', (
        tester,
      ) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: selectedValue,
            onChanged: (value) => selectedValue = value,
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('renders radio as unselected when not matching groupValue', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option2',
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('renders radio as selected when matching groupValue', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('throws error when used without RemixRadioGroup', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixRadio<String>(value: 'option1'));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isA<FlutterError>());
      });
    });

    group('WidgetStateController', () {
      Widget buildRadio({bool enabled = true}) => RemixRadioGroup<String>(
        groupValue: 'other',
        onChanged: (_) {},
        child: RemixRadio<String>(
          value: 'option',
          enabled: enabled,
          style: RemixRadioStyler().size(20, 20),
        ),
      );

      widgetControllerTest<RemixRadioSpec>(
        'reports radio hovered state',
        build: buildRadio,
        act: (tester) async {
          final previousStrategy = FocusManager.instance.highlightStrategy;
          FocusManager.instance.highlightStrategy =
              FocusHighlightStrategy.alwaysTraditional;
          addTearDown(
            () => FocusManager.instance.highlightStrategy = previousStrategy,
          );
          await tester.pump();
          await hoverAction<RemixRadio<String>>(tester);
        },
        expectedStates: {WidgetState.hovered},
      );

      widgetControllerTest<RemixRadioSpec>(
        'reports radio pressed state',
        build: buildRadio,
        act: pressAction<RemixRadio<String>>,
        expectedStates: {WidgetState.pressed},
      );

      widgetControllerTest<RemixRadioSpec>(
        'reports radio focused state',
        build: buildRadio,
        act: focusAction<RemixRadio<String>>,
        expectedStates: {WidgetState.focused},
      );

      widgetControllerTest<RemixRadioSpec>(
        'reports radio disabled state',
        build: () => buildRadio(enabled: false),
        expectedStates: {WidgetState.disabled},
      );
    });

    group('RemixRadioGroup', () {
      testWidgets('provides group context for radio buttons', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: selectedValue,
            onChanged: (value) => selectedValue = value,
            child: Column(
              children: [
                RemixRadio<String>(value: 'option1'),
                RemixRadio<String>(value: 'option2'),
                RemixRadio<String>(value: 'option3'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsNWidgets(3));
      });

      testWidgets('handles groupValue changes', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                child: Column(
                  children: [
                    RemixRadio<String>(value: 'option1'),
                    RemixRadio<String>(value: 'option2'),
                  ],
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsNWidgets(2));
      });

      testWidgets('handles null groupValue', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('is disabled when onChanged is omitted', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: selectedValue,
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

        final nakedRadio = tester.widget<NakedRadio<String>>(
          find.byType(NakedRadio<String>),
        );
        expect(nakedRadio.enabled, isFalse);
        expect(selectedValue, isNull);
      });
    });

    group('Interaction', () {
      testWidgets('calls onChanged when tapped', (tester) async {
        String? selectedValue;
        String? capturedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    capturedValue = value;
                  });
                },
                child: RemixRadio<String>(value: 'option1'),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

        expect(capturedValue, equals('option1'));
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        String? selectedValue;
        bool onChangedCalled = false;

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: selectedValue,
            onChanged: (value) => onChangedCalled = true,
            child: RemixRadio<String>(value: 'option1', enabled: false),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

        expect(onChangedCalled, isFalse);
      });

      testWidgets('handles toggleable radio', (tester) async {
        String? selectedValue = 'option1';

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                child: RemixRadio<String>(value: 'option1', toggleable: true),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('accepts autofocus parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', autofocus: true),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('accepts focusNode parameter', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', focusNode: focusNode),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
        focusNode.dispose();
      });

      testWidgets('can request focus programmatically', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', focusNode: focusNode),
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
      testWidgets('applies custom style', (tester) async {
        final customStyle = RemixRadioStyler().size(32.0, 32.0);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies indicator styling', (tester) async {
        final customStyle = RemixRadioStyler().indicator(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies alignment styling', (tester) async {
        final customStyle = RemixRadioStyler().alignment(Alignment.center);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies color styling', (tester) async {
        final customStyle = RemixRadioStyler().fillColor(Colors.red);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies border radius styling', (tester) async {
        final customStyle = RemixRadioStyler().borderRadius(
          BorderRadiusMix.circular(8.0),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies raw styleSpec when provided', (tester) async {
        const spec = RemixRadioSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.green)),
          ),
          indicator: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.blue)),
          ),
          effects: RemixSurfaceEffectsSpec(
            background: RemixSurfaceLayerSpec(
              shadows: [RemixPaintShadow(color: Colors.red)],
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: const RemixRadio<String>(value: 'option1', styleSpec: spec),
          ),
        );
        await tester.pumpAndSettle();

        final boxDecorations = tester
            .widgetList<Box>(find.byType(Box))
            .map((box) => box.styleSpec?.spec.decoration);
        final renderedDecorations = tester
            .widgetList<DecoratedBox>(find.byType(DecoratedBox))
            .map((box) => box.decoration);
        expect(find.byType(CustomPaint), findsWidgets);
        expect(
          renderedDecorations,
          contains(equals(const BoxDecoration(color: Colors.green))),
        );
        expect(
          boxDecorations,
          contains(equals(const BoxDecoration(color: Colors.blue))),
        );
      });
    });

    group('Type Safety', () {
      testWidgets('works with String type', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('works with int type', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<int>(
            groupValue: 1,
            onChanged: (value) {},
            child: RemixRadio<int>(value: 1),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<int>), findsOneWidget);
      });

      testWidgets('works with enum type', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<TestEnum>(
            groupValue: TestEnum.option1,
            onChanged: (value) {},
            child: RemixRadio<TestEnum>(value: TestEnum.option1),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<TestEnum>), findsOneWidget);
      });

      testWidgets('works with custom object type', (tester) async {
        final option1 = CustomOption('Option 1');

        await tester.pumpRemixApp(
          RemixRadioGroup<CustomOption>(
            groupValue: option1,
            onChanged: (value) {},
            child: RemixRadio<CustomOption>(value: option1),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<CustomOption>), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles rapid taps', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                child: RemixRadio<String>(value: 'option1'),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.tap(find.byType(RemixRadio<String>));
        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('handles null mouseCursor', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', mouseCursor: null),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('handles custom mouseCursor', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              value: 'option1',
              mouseCursor: SystemMouseCursors.click,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('handles toggleable parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', toggleable: true),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('radio_key');

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(key: key, value: 'option1'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('Multiple Radios in Group', () {
      testWidgets('switches selection between radios', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(value: 'option1'),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(value: 'option2'),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(value: 'option3'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        // Tap first radio
        await tester.tap(find.byType(RemixRadio<String>).first);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('option1'));

        // Tap second radio
        await tester.tap(find.byType(RemixRadio<String>).at(1));
        await tester.pumpAndSettle();

        expect(selectedValue, equals('option2'));
      });

      testWidgets('only one radio is selected at a time', (tester) async {
        String? selectedValue = 'option1';

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(value: 'option1'),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(value: 'option2'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>).last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('option2'));
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        final customStyle = RemixRadioStyler().wrap(.clipOval());

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(value: 'option1', style: customStyle),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });
    });
  });
}

// Test helpers
enum TestEnum { option1, option2, option3 }

class CustomOption {
  CustomOption(this.label);
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomOption &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode => label.hashCode;
}
