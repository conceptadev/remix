import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSpinner contract', () {
    test('defaults to loading with optional content', () {
      const spinner = RemixSpinner();

      expect(spinner.loading, isTrue);
      expect(spinner.child, isNull);
      expect(spinner.excludeSemantics, isFalse);
    });

    testWidgets('returns its child directly when not loading', (tester) async {
      const child = SizedBox(key: ValueKey('child'), width: 120, height: 40);
      await tester.pumpRemixApp(
        const RemixSpinner(loading: false, child: child),
      );

      expect(find.byKey(const ValueKey('child')), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(RemixSpinner),
          matching: find.byType(CustomPaint),
        ),
        findsNothing,
      );
      expect(tester.getSize(find.byType(RemixSpinner)), const Size(120, 40));
    });

    testWidgets('preserves hidden child layout while loading', (tester) async {
      await tester.pumpRemixApp(
        const RemixSpinner(
          semanticLabel: 'Saving',
          child: SizedBox(
            key: ValueKey('child'),
            width: 120,
            height: 40,
            child: Text('Save changes'),
          ),
        ),
      );

      expect(tester.getSize(find.byType(RemixSpinner)), const Size(120, 40));
      expect(find.text('Save changes'), findsOneWidget);
      expect(find.bySemanticsLabel('Save changes'), findsNothing);
      expect(find.bySemanticsLabel('Saving'), findsOneWidget);
    });

    testWidgets('passes parent constraints through to hidden content', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const SizedBox(
          width: 140,
          height: 48,
          child: RemixSpinner(
            child: Align(
              key: ValueKey('constraint-sensitive-child'),
              child: Text('Save'),
            ),
          ),
        ),
      );

      expect(
        tester.getSize(
          find.byKey(const ValueKey('constraint-sensitive-child')),
        ),
        const Size(140, 48),
      );
    });

    testWidgets('renders an eight-leaf spinner in inherited current color', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const IconTheme(
          data: IconThemeData(color: Colors.purple),
          child: RemixSpinner(
            styleSpec: RemixSpinnerSpec(size: 32, opacity: 0.65),
          ),
        ),
      );

      final paint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(RemixSpinner),
          matching: find.byType(CustomPaint),
        ),
      );
      final painter = paint.painter! as RemixSpinnerPainter;
      expect(paint.size, const Size.square(32));
      expect(painter.color, Colors.purple);
      expect(painter.opacity, 0.65);
      expect(RemixSpinnerPainter.leafCount, 8);
    });

    testWidgets('uses an 800ms repeating linear phase by default', (
      tester,
    ) async {
      await tester.pumpRemixApp(const RemixSpinner());
      final painter = () =>
          tester
                  .widget<CustomPaint>(
                    find.descendant(
                      of: find.byType(RemixSpinner),
                      matching: find.byType(CustomPaint),
                    ),
                  )
                  .painter!
              as RemixSpinnerPainter;

      expect(painter().animation.value, closeTo(0, 0.0001));
      await tester.pump(const Duration(milliseconds: 100));
      expect(painter().animation.value, closeTo(0.125, 0.0001));
      await tester.pump(const Duration(milliseconds: 700));
      expect(painter().animation.value, closeTo(0, 0.0001));
    });

    testWidgets('stops animation when accessible animations are disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: RemixSpinner(),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 2));

      final painter =
          tester.widget<CustomPaint>(find.byType(CustomPaint)).painter!
              as RemixSpinnerPainter;
      expect(painter.animation.value, 0);
      expect(tester.binding.hasScheduledFrame, isFalse);
    });
  });

  group('RemixSpinner semantics', () {
    testWidgets('exposes a loading-spinner role and optional label', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixSpinner(semanticLabel: 'Loading dashboard'),
      );

      final node = tester.getSemantics(
        find.bySemanticsLabel('Loading dashboard'),
      );
      expect(node.getSemanticsData().role, ui.SemanticsRole.loadingSpinner);
    });

    testWidgets('can exclude spinner semantics', (tester) async {
      await tester.pumpRemixApp(
        const RemixSpinner(
          semanticLabel: 'Hidden spinner',
          excludeSemantics: true,
        ),
      );

      expect(find.bySemanticsLabel('Hidden spinner'), findsNothing);
    });
  });
}
