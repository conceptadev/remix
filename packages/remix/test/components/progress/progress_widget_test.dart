import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  Finder indicatorOf() => find.descendant(
    of: find.byType(RemixProgress),
    matching: find.byType(FractionallySizedBox),
  );

  group('RemixProgress contract', () {
    test('defaults to indeterminate progress on a 0-1 scale', () {
      const progress = RemixProgress();

      expect(progress.value, isNull);
      expect(progress.max, 1);
      expect(progress.duration, const Duration(seconds: 5));
      expect(progress.excludeSemantics, isFalse);
    });

    test('validates max, value, and duration', () {
      expect(() => const RemixProgress(value: 0), returnsNormally);
      expect(() => const RemixProgress(value: 1), returnsNormally);
      expect(() => RemixProgress(value: -0.1), throwsA(isA<AssertionError>()));
      expect(() => RemixProgress(value: 1.1), throwsA(isA<AssertionError>()));
      expect(() => RemixProgress(max: 0), throwsA(isA<AssertionError>()));
      expect(
        () => RemixProgress(max: double.infinity),
        throwsA(isA<AssertionError>()),
      );
    });

    testWidgets('rejects a non-positive duration when mounted', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(duration: Duration.zero));

      expect(tester.takeException(), isA<ArgumentError>());
    });
  });

  group('RemixProgress geometry', () {
    testWidgets('uses value divided by max for determinate width', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const SizedBox(width: 200, child: RemixProgress(value: 25, max: 200)),
      );

      final indicator = tester.widget<FractionallySizedBox>(indicatorOf());
      expect(indicator.widthFactor, 0.125);
      expect(indicator.heightFactor, 1);
    });

    testWidgets('runs the indeterminate growth sequence once', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(duration: Duration(seconds: 1)),
      );

      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        closeTo(0.01, 0.0001),
      );

      await tester.pump(const Duration(milliseconds: 200));
      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        closeTo(0.1, 0.0001),
      );

      await tester.pump(const Duration(milliseconds: 800));
      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        closeTo(1, 0.0001),
      );
      await tester.pump(const Duration(seconds: 1));
      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        closeTo(1, 0.0001),
      );
    });

    testWidgets('restarts indeterminate growth after a mode change', (
      tester,
    ) async {
      const key = ValueKey('progress');
      await tester.pumpRemixApp(
        const RemixProgress(key: key, value: 50, max: 100),
      );
      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        0.5,
      );

      await tester.pumpRemixApp(const RemixProgress(key: key));
      expect(
        tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor,
        closeTo(0.01, 0.0001),
      );
    });

    testWidgets('uses a stable completed frame when animations are disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: RemixProgress(duration: Duration(seconds: 1)),
          ),
        ),
      );

      expect(tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor, 1);
      await tester.pump(const Duration(seconds: 2));
      expect(tester.widget<FractionallySizedBox>(indicatorOf()).widthFactor, 1);
      expect(tester.binding.hasScheduledFrame, isFalse);
    });
  });

  group('RemixProgress semantics', () {
    testWidgets('exposes determinate progress semantics', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(
          value: 25.5,
          max: 200,
          semanticLabel: 'Upload progress',
        ),
      );

      final node = tester.getSemantics(
        find.bySemanticsLabel('Upload progress'),
      );
      expect(node.getSemanticsData().role, ui.SemanticsRole.progressBar);
      expect(
        node,
        matchesSemantics(
          label: 'Upload progress',
          value: '25.5',
          minValue: '0',
          maxValue: '200',
        ),
      );
    });

    testWidgets('exposes an indeterminate loading role without fake values', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixProgress(semanticLabel: 'Loading records'),
      );

      final node = tester.getSemantics(
        find.bySemanticsLabel('Loading records'),
      );
      final data = node.getSemanticsData();
      expect(data.role, ui.SemanticsRole.loadingSpinner);
      expect(data.value, isEmpty);
      expect(data.maxValue, isNull);
    });

    testWidgets('can explicitly exclude progress semantics', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(
          value: 50,
          max: 100,
          semanticLabel: 'Hidden progress',
          excludeSemantics: true,
        ),
      );

      expect(find.bySemanticsLabel('Hidden progress'), findsNothing);
    });
  });

  testWidgets('wires resolved surface and overlay slots to the renderer', (
    tester,
  ) async {
    const surface = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(color: Colors.red)],
    );
    const overlay = RemixBoxEffectLayerSpec(
      shadows: [RemixBoxShadow(kind: RemixBoxShadowKind.inset, blurRadius: 1)],
    );
    await tester.pumpRemixApp(
      const RemixProgress(
        value: 50,
        max: 100,
        styleSpec: RemixProgressSpec(
          container: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
          trackEffects: RemixBoxEffectsSpec(
            behindContent: surface,
            overContent: overlay,
            backdropBlur: 3,
          ),
        ),
      ),
    );

    expect(find.byType(CustomPaint), findsWidgets);
    expect(find.byType(BackdropFilter), findsOneWidget);
  });
}
