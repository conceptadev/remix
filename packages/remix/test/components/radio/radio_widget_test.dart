import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

List<SemanticsNode> _collectSemanticsNodes(
  SemanticsNode root,
  bool Function(SemanticsNode) predicate,
) {
  final nodes = <SemanticsNode>[];

  bool visitor(SemanticsNode node) {
    if (!node.isMergedIntoParent && predicate(node)) nodes.add(node);
    node.visitChildren(visitor);
    return true;
  }

  visitor(root);
  return nodes;
}

Finder _boxesIn(Finder radio) =>
    find.descendant(of: radio, matching: find.byType(Box));

void _expectIndicatorOnlyOn(
  WidgetTester tester, {
  required Finder selected,
  required List<Finder> unselected,
}) {
  expect(selected, findsOneWidget);
  expect(_boxesIn(selected), findsNWidgets(2));
  for (final radio in unselected) {
    expect(radio, findsOneWidget);
    expect(_boxesIn(radio), findsOneWidget);
  }
}

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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('throws error when used without RemixRadioGroup', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixRadio<String>(semanticLabel: 'Option', value: 'option1'),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isA<FlutterError>());
      });
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
                RemixRadio<String>(semanticLabel: 'Option', value: 'option1'),
                RemixRadio<String>(semanticLabel: 'Option', value: 'option2'),
                RemixRadio<String>(semanticLabel: 'Option', value: 'option3'),
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
                    RemixRadio<String>(
                      semanticLabel: 'Option',
                      value: 'option1',
                    ),
                    RemixRadio<String>(
                      semanticLabel: 'Option',
                      value: 'option2',
                    ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixRadio<String>));
        await tester.pumpAndSettle();

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
                child: RemixRadio<String>(
                  semanticLabel: 'Option',
                  value: 'option1',
                ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              enabled: false,
            ),
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
                child: RemixRadio<String>(
                  semanticLabel: 'Option',
                  value: 'option1',
                  toggleable: true,
                ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              autofocus: true,
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              focusNode: focusNode,
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              focusNode: focusNode,
            ),
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
        final customStyle = RadioStyler().size(32.0, 32.0);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies indicator styling', (tester) async {
        final customStyle = RadioStyler().indicator(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies alignment styling', (tester) async {
        final customStyle = RadioStyler().alignment(Alignment.center);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies color styling', (tester) async {
        final customStyle = RadioStyler().fillColor(Colors.red);

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies border radius styling', (tester) async {
        final customStyle = RadioStyler().borderRadius(
          BorderRadiusMix.circular(8.0),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });

      testWidgets('applies raw styleSpec when provided', (tester) async {
        const spec = RadioSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
          indicator: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.blue)),
          ),
        );

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: const RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              styleSpec: spec,
            ),
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

    group('Type Safety', () {
      testWidgets('works with String type', (tester) async {
        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: 'option1',
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
            ),
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
            child: RemixRadio<int>(semanticLabel: 'Option', value: 1),
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
            child: RemixRadio<TestEnum>(
              semanticLabel: 'Option',
              value: TestEnum.option1,
            ),
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
            child: RemixRadio<CustomOption>(
              semanticLabel: 'Option',
              value: option1,
            ),
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
                child: RemixRadio<String>(
                  semanticLabel: 'Option',
                  value: 'option1',
                ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              mouseCursor: null,
            ),
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
              semanticLabel: 'Option',
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              toggleable: true,
            ),
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
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              key: key,
              value: 'option1',
            ),
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
                        child: RemixRadio<String>(
                          semanticLabel: 'Option',
                          value: 'option1',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(
                          semanticLabel: 'Option',
                          value: 'option2',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(
                          semanticLabel: 'Option',
                          value: 'option3',
                        ),
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
                        child: RemixRadio<String>(
                          semanticLabel: 'Option',
                          value: 'option1',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: RemixRadio<String>(
                          semanticLabel: 'Option',
                          value: 'option2',
                        ),
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
        final customStyle = RadioStyler().wrap(.clipOval());

        await tester.pumpRemixApp(
          RemixRadioGroup<String>(
            groupValue: null,
            onChanged: (value) {},
            child: RemixRadio<String>(
              semanticLabel: 'Option',
              value: 'option1',
              style: customStyle,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixRadio<String>), findsOneWidget);
      });
    });

    group('Accessible naming and Naked selection', () {
      test('rejects an empty accessible name', () {
        expect(
          () => RemixRadio<String>(value: 'a', semanticLabel: ''),
          throwsAssertionError,
        );
      });

      testWidgets('selected indicator follows Naked state', (tester) async {
        String? selected = 'option2';
        final first = find.byKey(const ValueKey('radio-first'));
        final second = find.byKey(const ValueKey('radio-second'));

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selected,
                onChanged: (value) => setState(() => selected = value),
                child: Column(
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: RemixRadio<String>(
                        key: const ValueKey('radio-first'),
                        value: 'option1',
                        semanticLabel: 'First',
                        style: RadioStyler().size(24, 24),
                      ),
                    ),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: RemixRadio<String>(
                        key: const ValueKey('radio-second'),
                        value: 'option2',
                        semanticLabel: 'Second',
                        style: RadioStyler().size(24, 24),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        _expectIndicatorOnlyOn(tester, selected: second, unselected: [first]);

        await tester.tap(first);
        await tester.pumpAndSettle();

        expect(selected, 'option1');
        _expectIndicatorOnlyOn(tester, selected: first, unselected: [second]);
      });

      testWidgets('group semantic label and role', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixRadioGroup<String>(
              groupValue: 'option1',
              onChanged: (_) {},
              semanticLabel: 'Plan',
              child: const RemixRadio<String>(
                value: 'option1',
                semanticLabel: 'Starter',
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.bySemanticsLabel('Plan'), findsOneWidget);
          expect(find.bySemanticsLabel('Starter'), findsOneWidget);

          final root = tester
              .binding
              .renderViews
              .single
              .owner!
              .semanticsOwner!
              .rootSemanticsNode!;
          // Flutter's RadioGroup publishes the single radioGroup role node
          // and accepts no label, so NakedRadioGroup puts the label on a
          // plain container around it. Two nodes; never a second role node.
          final roleNodes = _collectSemanticsNodes(
            root,
            (node) => node.getSemanticsData().role == SemanticsRole.radioGroup,
          );
          expect(roleNodes, hasLength(1));
          final labeled = _collectSemanticsNodes(
            root,
            (node) => node.getSemanticsData().label == 'Plan',
          );
          expect(labeled, hasLength(1));
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('group keyboard navigation moves selection', (tester) async {
        String? selected = 'a';
        final nodes = List<FocusNode>.generate(
          3,
          (index) => FocusNode(debugLabel: 'radio-$index'),
        );
        addTearDown(() {
          for (final node in nodes) {
            node.dispose();
          }
        });

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selected,
                onChanged: (value) => setState(() => selected = value),
                child: Column(
                  children: [
                    RemixRadio<String>(
                      key: const ValueKey('radio-a'),
                      value: 'a',
                      semanticLabel: 'Alpha',
                      focusNode: nodes[0],
                    ),
                    RemixRadio<String>(
                      key: const ValueKey('radio-b'),
                      value: 'b',
                      semanticLabel: 'Bravo',
                      focusNode: nodes[1],
                    ),
                    RemixRadio<String>(
                      key: const ValueKey('radio-c'),
                      value: 'c',
                      semanticLabel: 'Charlie',
                      focusNode: nodes[2],
                    ),
                  ],
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        nodes[0].requestFocus();
        await tester.pump();
        expect(nodes[0].hasFocus, isTrue);
        expect(selected, 'a');

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.pumpAndSettle();
        expect(selected, 'b');
        expect(nodes[1].hasFocus, isTrue);
        _expectIndicatorOnlyOn(
          tester,
          selected: find.byKey(const ValueKey('radio-b')),
          unselected: [
            find.byKey(const ValueKey('radio-a')),
            find.byKey(const ValueKey('radio-c')),
          ],
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();
        expect(selected, 'c');
        expect(nodes[2].hasFocus, isTrue);

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
        await tester.pumpAndSettle();
        expect(selected, 'b');
        expect(nodes[1].hasFocus, isTrue);

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
        await tester.pumpAndSettle();
        expect(selected, 'a');
        expect(nodes[0].hasFocus, isTrue);

        // Flutter RadioGroup binds arrows and Space, not Home/End.
        await tester.sendKeyEvent(LogicalKeyboardKey.home);
        await tester.pumpAndSettle();
        expect(selected, 'a');
        expect(nodes[0].hasFocus, isTrue);

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pumpAndSettle();
        expect(selected, 'a');
        expect(nodes[0].hasFocus, isTrue);

        nodes[2].requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();
        expect(selected, 'c');
        expect(nodes[2].hasFocus, isTrue);
        _expectIndicatorOnlyOn(
          tester,
          selected: find.byKey(const ValueKey('radio-c')),
          unselected: [
            find.byKey(const ValueKey('radio-a')),
            find.byKey(const ValueKey('radio-b')),
          ],
        );
      });

      testWidgets('disabled group does not change selection', (tester) async {
        String? selected = 'option1';
        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixRadioGroup<String>(
                groupValue: selected,
                onChanged: null,
                child: Column(
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: RemixRadio<String>(
                        value: 'option1',
                        semanticLabel: 'First',
                      ),
                    ),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: RemixRadio<String>(
                        value: 'option2',
                        semanticLabel: 'Second',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byType(RemixRadio<String>).last,
          warnIfMissed: false,
        );
        await tester.pumpAndSettle();
        expect(selected, 'option1');
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
