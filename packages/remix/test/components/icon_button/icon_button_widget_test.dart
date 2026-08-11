import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixIconButton', () {
    group('Basic Rendering', () {
      testWidgets('renders icon button with minimal props', (tester) async {
        await tester.pumpRemixApp(RemixIconButton(icon: Icons.add));
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(
          tester.widget<NakedButton>(find.byType(NakedButton)).enabled,
          isFalse,
        );
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('renders icon button with all props', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.delete,
            onPressed: () {},
            onLongPress: () {},
            autofocus: false,
            loading: false,
            enabled: true,
            enableFeedback: true,
            style: IconButtonStyler.create(),
            semanticLabel: 'Delete Button',
            semanticHint: 'Deletes the item',
            excludeSemantics: false,
            mouseCursor: SystemMouseCursors.click,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.delete), findsOneWidget);
      });
    });

    group('Loading State', () {
      testWidgets('shows spinner when loading is true', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.save, onPressed: () {}, loading: true),
        );
        await tester.pump(); // Use pump() for loading states

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(RemixSpinner), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('hides spinner when loading is false', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.save, onPressed: () {}, loading: false),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(RemixSpinner), findsNothing);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('is disabled when loading is true', (tester) async {
        int callbackCount = 0;
        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.save,
            onPressed: () => callbackCount++,
            loading: true,
          ),
        );
        await tester.pump(); // Use pump() for loading states

        await tester.tap(find.byType(RemixIconButton));
        await tester.pump();

        expect(callbackCount, equals(0));
      });
    });

    group('Custom Builders', () {
      testWidgets('iconBuilder renders custom icon widget', (tester) async {
        Widget customIconBuilder(
          BuildContext context,
          IconSpec spec,
          IconData? icon,
        ) {
          return Container(
            key: const ValueKey('custom_icon'),
            child: Icon(icon, color: Colors.red),
          );
        }

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.star,
            onPressed: () {},
            iconBuilder: customIconBuilder,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('custom_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('loadingBuilder renders custom loading widget', (
        tester,
      ) async {
        Widget customLoadingBuilder(BuildContext context, SpinnerSpec spec) {
          return Container(
            key: const ValueKey('custom_loading'),
            child: const CircularProgressIndicator(),
          );
        }

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.save,
            onPressed: () {},
            loading: true,
            loadingBuilder: customLoadingBuilder,
          ),
        );
        await tester.pump(); // Use pump() for loading states

        expect(find.byKey(const ValueKey('custom_loading')), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Interaction', () {
      testWidgets('calls onPressed when tapped', (tester) async {
        int callbackCount = 0;
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () => callbackCount++),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixIconButton));
        await tester.pumpAndSettle();

        expect(callbackCount, equals(1));
      });

      testWidgets('calls onLongPress when long pressed', (tester) async {
        int callbackCount = 0;
        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
            onLongPress: () => callbackCount++,
          ),
        );
        await tester.pumpAndSettle();

        await tester.longPress(find.byType(RemixIconButton));
        await tester.pumpAndSettle();

        expect(callbackCount, equals(1));
      });

      testWidgets('does not call callbacks when disabled', (tester) async {
        int pressedCount = 0;
        int longPressCount = 0;
        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: null,
            onLongPress: () => longPressCount++,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixIconButton));
        await tester.longPress(find.byType(RemixIconButton));
        await tester.pumpAndSettle();

        expect(pressedCount, equals(0));
        expect(longPressCount, equals(0));
      });

      testWidgets('does not call callbacks when enabled is false', (
        tester,
      ) async {
        int pressedCount = 0;
        int longPressCount = 0;
        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            enabled: false,
            onPressed: () => pressedCount++,
            onLongPress: () => longPressCount++,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixIconButton));
        await tester.longPress(find.byType(RemixIconButton));
        await tester.pumpAndSettle();

        expect(pressedCount, equals(0));
        expect(longPressCount, equals(0));
      });
    });

    group('Focus and Keyboard', () {
      testWidgets('autofocus requests focus on mount', (tester) async {
        final focusNode = FocusNode();
        addTearDown(() => focusNode.dispose());

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
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
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
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
      testWidgets('exposes one semantic owner for the button contract', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.delete,
            onPressed: () {},
            onLongPress: () {},
            semanticLabel: 'Delete item',
            semanticHint: 'Deletes the selected item',
          ),
        );
        await tester.pumpAndSettle();

        final button = find.semantics.byLabel('Delete item');
        expect(button, findsOne);
        expect(
          button.evaluate().single,
          isSemantics(
            label: 'Delete item',
            hint: 'Deletes the selected item',
            isButton: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            hasLongPressAction: true,
          ),
        );
        semantics.dispose();
      });

      testWidgets('loading updates that owner without duplicating it', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.save,
            onPressed: () {},
            loading: true,
            semanticLabel: 'Save item',
            semanticHint: 'Saves the selected item',
          ),
        );
        await tester.pump();

        final button = find.semantics.byLabel('Save item');
        expect(button, findsOne);
        expect(
          button.evaluate().single,
          isSemantics(
            label: 'Save item',
            hint: 'Saves the selected item',
            isButton: true,
            hasEnabledState: true,
            isEnabled: false,
            isLiveRegion: true,
            hasTapAction: false,
          ),
        );
        semantics.dispose();
      });

      testWidgets('default and disabled labels remain single button nodes', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(const RemixIconButton(icon: Icons.block));
        await tester.pumpAndSettle();

        final button = find.semantics.byLabel('Icon Button');
        expect(button, findsOne);
        expect(
          button.evaluate().single,
          isSemantics(
            label: 'Icon Button',
            isButton: true,
            hasEnabledState: true,
            isEnabled: false,
            hasTapAction: false,
          ),
        );
        semantics.dispose();
      });

      testWidgets('excludeSemantics hides the complete button contract', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
            semanticLabel: 'Add item',
            semanticHint: 'Adds an item',
            excludeSemantics: true,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.semantics.byLabel('Add item'), findsNothing);
        expect(
          tester.semantics.simulatedAccessibilityTraversal().where(
            (node) => node.hint == 'Adds an item',
          ),
          isEmpty,
        );
        semantics.dispose();
      });

      testWidgets('renders correctly in enabled state', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('renders correctly in disabled state', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: null),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('renders correctly when enabled is false', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, enabled: false, onPressed: () {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });
    });

    group('Style Integration', () {
      testWidgets('applies custom style to container', (tester) async {
        final customStyle = IconButtonStyler(
          container: BoxStyler(
            padding: EdgeInsetsGeometryMix.all(16.0),
            decoration: BoxDecorationMix(
              color: Colors.lightBlue,
              borderRadius: BorderRadiusGeometryMix.circular(8.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('applies custom icon style', (tester) async {
        final customStyle = IconButtonStyler(
          icon: IconStyler(color: Colors.red, size: 24.0),
        );

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.add,
            onPressed: () {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('applies custom spinner style', (tester) async {
        final customStyle = IconButtonStyler(spinner: SpinnerStyler());

        await tester.pumpRemixApp(
          RemixIconButton(
            icon: Icons.save,
            onPressed: () {},
            loading: true,
            style: customStyle,
          ),
        );
        await tester.pump(); // Use pump() for loading states

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('uses default style when none provided', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('applies raw styleSpec when provided', (tester) async {
        const spec = IconButtonSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () {}, styleSpec: spec),
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

    group('Layout and Sizing', () {
      testWidgets('icon button adapts to custom size', (tester) async {
        final smallStyle = IconButtonStyler().size(32.0, 32.0);
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () {}, style: smallStyle),
        );
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(find.byType(RemixIconButton));

        final largeStyle = IconButtonStyler().size(64.0, 64.0);
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: () {}, style: largeStyle),
        );
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(find.byType(RemixIconButton));

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null onPressed gracefully', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.add, onPressed: null),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('handles loading state with null onPressed', (tester) async {
        await tester.pumpRemixApp(
          RemixIconButton(icon: Icons.save, onPressed: null, loading: true),
        );
        await tester.pump(); // Use pump() for loading states

        expect(find.byType(RemixIconButton), findsOneWidget);
        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('handles different icon types', (tester) async {
        final icons = [
          Icons.add,
          Icons.remove,
          Icons.close,
          Icons.check,
          Icons.star,
        ];

        for (final icon in icons) {
          await tester.pumpRemixApp(
            RemixIconButton(icon: icon, onPressed: () {}),
          );
          await tester.pumpAndSettle();

          expect(find.byType(RemixIconButton), findsOneWidget);
          expect(find.byIcon(icon), findsOneWidget);
        }
      });
    });
  });
}
