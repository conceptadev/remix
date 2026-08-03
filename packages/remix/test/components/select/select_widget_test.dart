import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSelect', () {
    group('Basic Rendering', () {
      testWidgets('renders select with minimal props', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
        expect(find.text('Select'), findsOneWidget);
      });

      testWidgets('renders select with selected value', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
            selectedValue: 'a',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);
        expect(find.text('Select'), findsNothing);
      });

      testWidgets('renders trigger with icon', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(
              placeholder: 'Select',
              icon: Icons.star,
            ),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('shows dropdown chevron', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(const ValueKey('fortal-select-chevron')),
          findsOneWidget,
        );
      });
    });

    group('Interaction', () {
      testWidgets('opens dropdown when tapped', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);
        expect(find.text('Option B'), findsOneWidget);
      });

      testWidgets('rotates the chevron when opened', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        final chevron = find.byKey(const ValueKey('fortal-select-chevron'));
        final transformFinder = find.ancestor(
          of: chevron,
          matching: find.byType(Transform),
        );
        final closedTransform = tester
            .widget<Transform>(transformFinder.first)
            .transform;

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(
          tester.widget<Transform>(transformFinder.first).transform,
          isNot(equals(closedTransform)),
        );
      });

      testWidgets('calls onChanged when item is selected', (tester) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSelect<String>(
                trigger: const RemixSelectTrigger(placeholder: 'Select'),
                items: const [
                  RemixSelectItem(value: 'a', label: 'Option A'),
                  RemixSelectItem(value: 'b', label: 'Option B'),
                ],
                selectedValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option A').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('a'));
      });

      testWidgets('does not open when disabled', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            enabled: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsNothing);
      });

      testWidgets('closes dropdown after selection with closeOnSelect', (
        tester,
      ) async {
        String? selectedValue;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSelect<String>(
                trigger: const RemixSelectTrigger(placeholder: 'Select'),
                items: const [
                  RemixSelectItem(value: 'a', label: 'Option A'),
                  RemixSelectItem(value: 'b', label: 'Option B'),
                ],
                selectedValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
                closeOnSelect: true,
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option A').last);
        await tester.pumpAndSettle();

        expect(find.text('Option B'), findsNothing);
      });

      testWidgets('keeps dropdown open when closeOnSelect is false', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
            closeOnSelect: false,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option A').last);
        await tester.pumpAndSettle();

        expect(find.text('Option B'), findsOneWidget);
      });

      testWidgets('calls onOpen when dropdown opens', (tester) async {
        bool onOpenCalled = false;

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            onOpen: () => onOpenCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(onOpenCalled, isTrue);
      });

      testWidgets('calls onClose when dropdown closes', (tester) async {
        bool onCloseCalled = false;

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            onClose: () => onCloseCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option A').last);
        await tester.pumpAndSettle();

        expect(onCloseCalled, isTrue);
      });
    });

    group('Focus', () {
      testWidgets('accepts focusNode parameter', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
        focusNode.dispose();
      });

      testWidgets('can request focus programmatically', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
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
      testWidgets('item styling uses the typed select-option controller', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        final optionContext = tester.element(find.text('Option A'));
        final optionController = NakedSelectOptionState.controllerOf<String>(
          optionContext,
        );
        final stateProvider = tester.widget<WidgetStateProvider>(
          find
              .ancestor(
                of: find.text('Option A'),
                matching: find.byType(WidgetStateProvider),
              )
              .first,
        );

        expect(
          stateProvider.disabled,
          optionController.value.contains(WidgetState.disabled),
        );
        expect(
          stateProvider.selected,
          optionController.value.contains(WidgetState.selected),
        );
      });

      testWidgets('applies custom style', (tester) async {
        final customStyle = SelectStyler().menuContainer(
          FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(16.0)),
        );

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });

      testWidgets('applies trigger styling', (tester) async {
        final customStyle = SelectStyler().trigger(
          SelectTriggerStyler().label(
            TextStyler(style: TextStyleMix(color: Colors.blue)),
          ),
        );

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });

      testWidgets('applies item styling', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: [
              RemixSelectItem(
                value: 'a',
                label: 'Option A',
                style: SelectMenuItemStyler().text(
                  TextStyler(style: TextStyleMix(color: Colors.red)),
                ),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });

      testWidgets('applies select-level default item styling', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            style: SelectStyler().item(
              SelectMenuItemStyler().text(
                TextStyler(style: TextStyleMix(color: Colors.red)),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(
          tester.widget<Text>(find.text('Option A')).style?.color,
          Colors.red,
        );
      });

      testWidgets('raw item styleSpec bypasses per-item fluent styles', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: [
              RemixSelectItem(
                value: 'a',
                label: 'Option A',
                style: SelectMenuItemStyler().text(
                  TextStyler().color(Colors.green),
                ),
              ),
            ],
            styleSpec: const SelectSpec(
              item: StyleSpec(
                spec: SelectMenuItemSpec(
                  text: StyleSpec(
                    spec: TextSpec(style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(
          tester.widget<Text>(find.text('Option A')).style?.color,
          Colors.blue,
        );
      });
    });

    group('Type Safety', () {
      testWidgets('works with String type', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });

      testWidgets('works with int type', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<int>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 1, label: 'Option 1')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<int>), findsOneWidget);
      });

      testWidgets('works with enum type', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<TestEnum>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: TestEnum.option1, label: 'Option 1'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<TestEnum>), findsOneWidget);
      });

      testWidgets('works with custom object type', (tester) async {
        final option1 = CustomOption('Option 1');

        await tester.pumpRemixApp(
          RemixSelect<CustomOption>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: [RemixSelectItem(value: option1, label: 'Option 1')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<CustomOption>), findsOneWidget);
      });
    });

    group('RemixSelectItem', () {
      testWidgets('renders disabled item', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A', enabled: false),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);
        expect(find.text('Option B'), findsOneWidget);
      });

      testWidgets('shows check icon for selected item', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
            ],
            selectedValue: 'a',
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(
          find.byKey(const ValueKey('fortal-select-indicator')),
          findsOneWidget,
        );
      });

      testWidgets('applies semanticLabel to item', (tester) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(
                value: 'a',
                label: 'Option A',
                semanticLabel: 'Custom Label',
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        final item = find.bySemanticsLabel('Custom Label');
        final itemCount = item.evaluate().length;
        final itemSemantics = itemCount == 1 ? tester.getSemantics(item) : null;
        semantics.dispose();
        expect(itemCount, 1);
        expect(itemSemantics, isSemantics(label: 'Custom Label'));
      });

      testWidgets('uses one visible-label accessible name', (tester) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        final item = find.bySemanticsLabel('Option A');
        final itemCount = item.evaluate().length;
        final itemSemantics = itemCount == 1 ? tester.getSemantics(item) : null;
        semantics.dispose();
        expect(itemCount, 1);
        expect(itemSemantics, isSemantics(label: 'Option A'));
      });
    });

    group('Positioning', () {
      testWidgets('accepts positioning OverlayPositionConfig', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            positioning: const OverlayPositionConfig(
              side: OverlaySide.bottom,
              alignment: OverlayAlignment.start,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });
    });

    group('Layout Constraints', () {
      testWidgets('handles unbounded width constraints in Row', (tester) async {
        // This test verifies that RemixSelect works inside a Row
        // without explicit width constraints (unbounded width scenario)
        await tester.pumpRemixApp(
          Row(
            children: [
              RemixSelect<String>(
                trigger: const RemixSelectTrigger(placeholder: 'Select'),
                items: const [
                  RemixSelectItem(value: 'a', label: 'Option A'),
                  RemixSelectItem(value: 'b', label: 'Option B'),
                ],
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
        expect(find.text('Select'), findsOneWidget);
      });

      testWidgets('opens dropdown when in Row with unbounded width', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          Row(
            children: [
              RemixSelect<String>(
                trigger: const RemixSelectTrigger(placeholder: 'Select'),
                items: const [
                  RemixSelectItem(value: 'a', label: 'Option A'),
                  RemixSelectItem(value: 'b', label: 'Option B'),
                ],
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);
        expect(find.text('Option B'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty items list', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });

      testWidgets('handles null selectedValue', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            selectedValue: null,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Select'), findsOneWidget);
      });

      testWidgets('asserts when selected value not in items', (tester) async {
        // In debug mode, an assertion should be thrown when selectedValue
        // doesn't match any item in the items list.
        // The assertion happens during widget build, so we catch it via takeException.
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            selectedValue: 'z',
          ),
        );

        // Assertion error is caught by the test framework
        final exception = tester.takeException();
        expect(exception, isAssertionError);
      });

      testWidgets('handles rapid open/close', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pump();
        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });
    });

    group('Semantics', () {
      testWidgets('applies semanticLabel to select', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
            semanticLabel: 'Custom Select Label',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSelect<String>), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('select_key');

        await tester.pumpRemixApp(
          RemixSelect<String>(
            key: key,
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [RemixSelectItem(value: 'a', label: 'Option A')],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('Multiple Items', () {
      testWidgets('renders all items in dropdown', (tester) async {
        await tester.pumpRemixApp(
          RemixSelect<String>(
            trigger: const RemixSelectTrigger(placeholder: 'Select'),
            items: const [
              RemixSelectItem(value: 'a', label: 'Option A'),
              RemixSelectItem(value: 'b', label: 'Option B'),
              RemixSelectItem(value: 'c', label: 'Option C'),
            ],
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);
        expect(find.text('Option B'), findsOneWidget);
        expect(find.text('Option C'), findsOneWidget);
      });

      testWidgets('updates display when selection changes', (tester) async {
        String? selectedValue = 'a';

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSelect<String>(
                trigger: const RemixSelectTrigger(placeholder: 'Select'),
                items: const [
                  RemixSelectItem(value: 'a', label: 'Option A'),
                  RemixSelectItem(value: 'b', label: 'Option B'),
                ],
                selectedValue: selectedValue,
                onChanged: (value) => setState(() => selectedValue = value),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Option A'), findsOneWidget);

        await tester.tap(find.byType(RemixSelect<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option B').last);
        await tester.pumpAndSettle();

        expect(find.text('Option B'), findsOneWidget);
        expect(find.text('Option A'), findsNothing);
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
