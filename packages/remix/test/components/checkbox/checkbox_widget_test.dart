import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixCheckbox', () {
    group('Basic Rendering', () {
      testWidgets('renders checkbox with minimal props', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: false, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders checkbox with all props', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: true,
            onChanged: (value) {},
            enabled: true,
            tristate: false,
            autofocus: false,
            checkedIcon: Icons.check,
            uncheckedIcon: Icons.close,
            indeterminateIcon: Icons.remove,
            enableFeedback: true,
            style: CheckboxStyler.create(),
            semanticLabel: 'Test Checkbox',
            mouseCursor: SystemMouseCursors.click,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });
    });

    group('State Handling', () {
      testWidgets('renders unchecked state', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: false, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsNothing);
      });

      testWidgets('renders checked state', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(_pathGlyph(RemixPathGlyph.thickCheck), findsOneWidget);
      });

      testWidgets('renders indeterminate state when tristate is true', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: null, tristate: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(
          _pathGlyph(RemixPathGlyph.thickDividerHorizontal),
          findsOneWidget,
        );
      });
    });

    group('WidgetStateController', () {
      widgetControllerTest<CheckboxSpec>(
        'contains disabled state when enabled is false',
        build: () => RemixCheckbox(
          selected: false,
          enabled: false,
          onChanged: (value) {},
        ),
        expectedStates: {WidgetState.disabled},
      );

      widgetControllerTest<CheckboxSpec>(
        'contains hovered state when hovered',
        build: () => RemixCheckbox(selected: false, onChanged: (value) {}),
        act: hoverAction<RemixCheckbox>,
        expectedStates: {WidgetState.hovered},
      );

      widgetControllerTest<CheckboxSpec>(
        'contains focused state when focused',
        build: () => RemixCheckbox(selected: false, onChanged: (value) {}),
        act: focusAction<RemixCheckbox>,
        expectedStates: {WidgetState.focused},
      );

      widgetControllerTest<CheckboxSpec>(
        'contains pressed state when pressed',
        build: () => RemixCheckbox(selected: false, onChanged: (value) {}),
        act: pressAction<RemixCheckbox>,
        expectedStates: {WidgetState.pressed},
      );
    });

    group('Icon Handling', () {
      testWidgets('uses default checked path', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(StyledIcon), findsNothing);
        expect(_pathGlyph(RemixPathGlyph.thickCheck), findsOneWidget);
      });

      testWidgets('uses custom checked icon', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: true,
            checkedIcon: Icons.done,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.done), findsOneWidget);
      });

      testWidgets('uses custom unchecked icon', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            uncheckedIcon: Icons.radio_button_unchecked,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      });

      testWidgets('uses custom indeterminate icon', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: null,
            tristate: true,
            indeterminateIcon: Icons.minimize,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.minimize), findsOneWidget);
      });

      testWidgets('renders no icon when uncheckedIcon is null', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            uncheckedIcon: null,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsNothing);
      });
    });

    group('Interaction', () {
      testWidgets('calls onChanged when tapped', (tester) async {
        bool? receivedValue;
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) => receivedValue = value,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixCheckbox));
        await tester.pumpAndSettle();

        expect(receivedValue, equals(true));
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool? receivedValue;
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            enabled: false,
            onChanged: (value) => receivedValue = value,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixCheckbox));
        await tester.pumpAndSettle();

        expect(receivedValue, isNull);
      });

      testWidgets('handles tristate onChanged correctly', (tester) async {
        bool? receivedValue;
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            tristate: true,
            onChanged: (value) => receivedValue = value,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixCheckbox));
        await tester.pumpAndSettle();

        expect(receivedValue, equals(true));
      });

      testWidgets('handles non-tristate onChanged correctly', (tester) async {
        bool? receivedValue;
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            tristate: false,
            onChanged: (value) => receivedValue = value,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixCheckbox));
        await tester.pumpAndSettle();

        expect(receivedValue, equals(true));
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('autofocus requests focus on mount', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() => focusNode.dispose());

        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            autofocus: true,
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        final focused = tester.binding.focusManager.primaryFocus;
        expect(focused, equals(focusNode));
      });

      testWidgets('can be focused programmatically', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() => focusNode.dispose());

        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
      });
    });

    group('Accessibility', () {
      testWidgets('semanticLabel overrides default label', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            semanticLabel: 'Custom Semantic Label',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders correctly in checked state', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(_pathGlyph(RemixPathGlyph.thickCheck), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('checkbox adapts to custom size', (tester) async {
        final smallStyle = CheckboxStyler().size(16.0, 16.0);
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            style: smallStyle,
          ),
        );
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(find.byType(Box));

        final largeStyle = CheckboxStyler().size(32.0, 32.0);
        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            style: largeStyle,
          ),
        );
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(find.byType(Box));

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('applies raw styleSpec when provided', (tester) async {
        const spec = CheckboxSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        await tester.pumpRemixApp(
          RemixCheckbox(
            selected: false,
            onChanged: (value) {},
            styleSpec: spec,
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
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null onChanged gracefully', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: false, onChanged: null),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('handles tristate with null selected', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: null, tristate: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(
          _pathGlyph(RemixPathGlyph.thickDividerHorizontal),
          findsOneWidget,
        );
      });

      testWidgets('handles tristate with true selected', (tester) async {
        await tester.pumpRemixApp(
          RemixCheckbox(selected: true, tristate: true, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCheckbox), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(_pathGlyph(RemixPathGlyph.thickCheck), findsOneWidget);
      });
    });
  });
}

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);
