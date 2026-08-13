import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  group('CarbonButton', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpCarbonApp(CarbonButton(label: 'Save', onPressed: () {}));
      await tester.pumpAndSettle();
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('fires onPressed when tapped', (tester) async {
      var pressed = 0;
      await tester.pumpCarbonApp(
        CarbonButton(label: 'Submit', onPressed: () => pressed++),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit'));
      expect(pressed, 1);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpCarbonApp(const CarbonButton(label: 'Disabled'));
      await tester.pumpAndSettle();
      expect(find.text('Disabled'), findsOneWidget);
      // Tapping a disabled button must not throw and has no callback to fire.
      await tester.tap(find.text('Disabled'), warnIfMissed: false);
      await tester.pumpAndSettle();
    });

    testWidgets('forwards the Remix 1.0 behavior surface', (tester) async {
      var longPresses = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpCarbonApp(
        CarbonButton(
          label: 'More',
          onPressed: () {},
          onLongPress: () => longPresses++,
          focusNode: focusNode,
          semanticHint: 'Shows more options',
          excludeSemantics: true,
          mouseCursor: SystemMouseCursors.forbidden,
        ),
      );
      await tester.pumpAndSettle();

      final remixButton = tester.widget<RemixButton>(find.byType(RemixButton));
      expect(remixButton.focusNode, same(focusNode));
      expect(remixButton.semanticHint, 'Shows more options');
      expect(remixButton.excludeSemantics, isTrue);
      expect(remixButton.mouseCursor, SystemMouseCursors.forbidden);

      await tester.longPress(find.byType(CarbonButton));
      expect(longPresses, 1);
    });

    testWidgets('renders a trailing icon', (tester) async {
      await tester.pumpCarbonApp(
        CarbonButton(label: 'Add', trailingIcon: Icons.add, onPressed: () {}),
      );
      await tester.pumpAndSettle();
      expect(find.text('Add'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('uses Carbon spacing between labels and trailing icons', (
      tester,
    ) async {
      const expectedGaps = <CarbonButtonKind, double>{
        CarbonButtonKind.primary: 32.0,
        CarbonButtonKind.secondary: 32.0,
        CarbonButtonKind.tertiary: 32.0,
        CarbonButtonKind.ghost: 8.0,
        CarbonButtonKind.danger: 32.0,
        CarbonButtonKind.dangerTertiary: 32.0,
        CarbonButtonKind.dangerGhost: 8.0,
      };

      for (final MapEntry(key: kind, value: expectedGap)
          in expectedGaps.entries) {
        await tester.pumpCarbonApp(
          CarbonButton(
            label: kind.name,
            kind: kind,
            trailingIcon: Icons.add,
            onPressed: () {},
          ),
        );
        await tester.pumpAndSettle();

        final labelRect = tester.getRect(find.text(kind.name));
        final iconRect = tester.getRect(find.byIcon(Icons.add));

        expect(
          iconRect.left - labelRect.right,
          moreOrLessEquals(expectedGap),
          reason: 'kind=$kind',
        );
      }
    });

    testWidgets('focused buttons render focus and inset border layers', (
      tester,
    ) async {
      const cases = [
        (
          theme: CarbonTheme.white,
          focus: Color(0xFF0F62FE),
          inset: Color(0xFFFFFFFF),
        ),
        (
          theme: CarbonTheme.g100,
          focus: Color(0xFFFFFFFF),
          inset: Color(0xFF161616),
        ),
      ];

      for (final testCase in cases) {
        await tester.pumpCarbonApp(
          WidgetStateStyleOverride(
            states: const {WidgetState.focused},
            child: CarbonButton(label: 'Focused', onPressed: () {}),
          ),
          theme: testCase.theme,
        );
        await tester.pumpAndSettle();

        final decoration = _foregroundDecoration(tester);
        expect(
          decoration,
          isA<ShapeDecoration>(),
          reason: 'theme=${testCase.theme}',
        );

        final shape = (decoration as ShapeDecoration).shape;
        expect(
          shape.dimensions,
          const EdgeInsets.all(3.0),
          reason: 'theme=${testCase.theme}',
        );
        expect(
          shape,
          RoundedRectangleBorder(
                side: BorderSide(color: testCase.inset, width: 1.0),
              ) +
              RoundedRectangleBorder(
                side: BorderSide(color: testCase.focus, width: 2.0),
              ),
          reason: 'theme=${testCase.theme}',
        );
      }
    });

    testWidgets('focused tertiary kinds fill and use inverse text', (
      tester,
    ) async {
      const cases = [
        (
          kind: CarbonButtonKind.tertiary,
          fill: Color(0xFF0F62FE),
          text: Color(0xFFFFFFFF),
        ),
        (
          kind: CarbonButtonKind.dangerTertiary,
          fill: Color(0xFFDA1E28),
          text: Color(0xFFFFFFFF),
        ),
      ];

      for (final testCase in cases) {
        await tester.pumpCarbonApp(
          WidgetStateStyleOverride(
            states: const {WidgetState.focused},
            child: CarbonButton(
              label: testCase.kind.name,
              kind: testCase.kind,
              onPressed: () {},
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          _backgroundColor(tester),
          testCase.fill,
          reason: 'kind=${testCase.kind}',
        );
        expect(
          tester.widget<Text>(find.text(testCase.kind.name)).style?.color,
          testCase.text,
          reason: 'kind=${testCase.kind}',
        );
      }
    });

    testWidgets('focus visuals follow Flutter highlight modality', (
      tester,
    ) async {
      final previousStrategy = FocusManager.instance.highlightStrategy;
      addTearDown(() {
        FocusManager.instance.highlightStrategy = previousStrategy;
      });
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpCarbonApp(
        CarbonButton(label: 'Focused', focusNode: focusNode, onPressed: () {}),
      );
      await tester.pumpAndSettle();
      focusNode.requestFocus();
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
      expect(_foregroundDecorations(tester), isEmpty);

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
      await tester.pump();
      expect(_foregroundDecorations(tester), hasLength(1));

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      await tester.pump();
      expect(_foregroundDecorations(tester), isEmpty);
    });

    testWidgets('dark tertiary hover and press use inverse text', (
      tester,
    ) async {
      for (final state in [WidgetState.hovered, WidgetState.pressed]) {
        await tester.pumpCarbonApp(
          WidgetStateStyleOverride(
            states: {state},
            child: CarbonButton(
              label: state.name,
              kind: CarbonButtonKind.tertiary,
              onPressed: () {},
            ),
          ),
          theme: CarbonTheme.g100,
        );
        await tester.pumpAndSettle();

        expect(
          tester.widget<Text>(find.text(state.name)).style?.color,
          const Color(0xFF161616),
          reason: 'state=$state',
        );
      }
    });

    testWidgets('every kind builds across all four themes', (tester) async {
      for (final theme in CarbonTheme.values) {
        for (final kind in CarbonButtonKind.values) {
          await tester.pumpCarbonApp(
            CarbonButton(label: 'Go', kind: kind, onPressed: () {}),
            theme: theme,
          );
          await tester.pumpAndSettle();
          expect(
            find.text('Go'),
            findsOneWidget,
            reason: 'kind=$kind theme=$theme',
          );
        }
      }
    });

    testWidgets('respects an explicit size', (tester) async {
      await tester.pumpCarbonApp(
        CarbonButton(label: 'Large', size: CarbonSize.xl, onPressed: () {}),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(CarbonButton)).height, 64.0);
    });

    testWidgets("defaults to Carbon's lg (48px) without a CarbonLayoutScope", (
      tester,
    ) async {
      await tester.pumpCarbonApp(
        CarbonButton(label: 'Default', onPressed: () {}),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(CarbonButton)).height, 48.0);
    });

    testWidgets('inherits the contextual CarbonLayoutScope size', (
      tester,
    ) async {
      await tester.pumpCarbonApp(
        CarbonLayoutScope(
          size: CarbonSize.sm,
          child: CarbonButton(label: 'Contextual', onPressed: () {}),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(CarbonButton)).height, 32.0);
    });

    testWidgets('loading keeps the kind fill instead of the disabled gray', (
      tester,
    ) async {
      Color? containerColor() {
        final box = tester
            .widgetList<DecoratedBox>(
              find.descendant(
                of: find.byType(CarbonButton),
                matching: find.byType(DecoratedBox),
              ),
            )
            .map((w) => w.decoration)
            .whereType<BoxDecoration>()
            .firstWhere((d) => d.color != null, orElse: BoxDecoration.new)
            .color;
        return box;
      }

      await tester.pumpCarbonApp(
        CarbonButton(label: 'Save', loading: true, onPressed: () {}),
      );
      // The loading spinner animates forever; pump a fixed frame instead of
      // settling.
      await tester.pump(const Duration(milliseconds: 100));
      // buttonPrimary blue, not buttonDisabled gray.
      expect(containerColor(), const Color(0xFF0F62FE));

      await tester.pumpCarbonApp(
        const CarbonButton(label: 'Save', enabled: false, onPressed: null),
      );
      await tester.pumpAndSettle();
      expect(containerColor(), const Color(0xFFC6C6C6));
    });
  });
}

Decoration _foregroundDecoration(WidgetTester tester) {
  return _foregroundDecorations(tester).single;
}

List<Decoration> _foregroundDecorations(WidgetTester tester) {
  return tester
      .widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(CarbonButton),
          matching: find.byType(DecoratedBox),
        ),
      )
      .where((box) => box.position == DecorationPosition.foreground)
      .map((box) => box.decoration)
      .toList();
}

Color? _backgroundColor(WidgetTester tester) {
  return tester
      .widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(CarbonButton),
          matching: find.byType(DecoratedBox),
        ),
      )
      .where((box) => box.position == DecorationPosition.background)
      .map((box) => box.decoration)
      .whereType<BoxDecoration>()
      .firstWhere((decoration) => decoration.color != null)
      .color;
}
