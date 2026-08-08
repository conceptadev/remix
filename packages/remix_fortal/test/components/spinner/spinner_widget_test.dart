import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('uses rounded fading leaves for the Fortal spinner', (
    tester,
  ) async {
    final expectedRadius = await resolveInFortalScope(
      tester,
      (context) => fortalSpinnerStyle().resolve(context).spec.leafRadius!,
    );

    await tester.pumpRemixApp(const FortalSpinner());
    await tester.pump();

    final customPaint = tester.widget<CustomPaint>(_spinnerPaint());
    final painter = customPaint.painter;

    expect(painter, isA<RemixLeafSpinnerPainter>());
    final leafPainter = painter! as RemixLeafSpinnerPainter;
    expect(leafPainter.opacity, 0.65);
    expect(leafPainter.leafRadius, expectedRadius);
  });
  testWidgets('Fortal forwards one labelled loading status node', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpRemixApp(
        const FortalSpinner(
          semanticsLabel: 'Loading workspaces',
          semanticsValue: 'Connecting',
        ),
      );
      await tester.pump();

      final nodes = tester.semantics
          .simulatedAccessibilityTraversal()
          .where(
            (node) =>
                node.getSemanticsData().role == SemanticsRole.loadingSpinner,
          )
          .toList();
      expect(nodes, hasLength(1));
      expect(
        nodes.single,
        isSemantics(
          label: 'Loading workspaces',
          value: 'Connecting',
          hasTapAction: false,
          hasLongPressAction: false,
          hasIncreaseAction: false,
          hasDecreaseAction: false,
        ),
      );

      final spinner = tester.widget<RemixSpinner>(find.byType(RemixSpinner));
      expect(spinner.semanticsLabel, 'Loading workspaces');
      expect(spinner.semanticsValue, 'Connecting');
    } finally {
      semantics.dispose();
    }
  });
}

Finder _spinnerPaint() => find.descendant(
  of: find.byType(RemixSpinner),
  matching: find.byType(CustomPaint),
);
