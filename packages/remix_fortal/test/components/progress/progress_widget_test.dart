import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/semantics.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('Fortal forwards one named normalized progress node', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpRemixApp(
        const FortalProgress(
          value: 0.42,
          semanticsLabel: 'Uploading workspace',
        ),
      );
      await tester.pump();

      final nodes = tester.semantics
          .simulatedAccessibilityTraversal()
          .where(
            (node) => node.getSemanticsData().role == SemanticsRole.progressBar,
          )
          .toList();
      expect(nodes, hasLength(1));
      expect(
        nodes.single,
        isSemantics(
          label: 'Uploading workspace',
          value: '42',
          minValue: '0',
          maxValue: '100',
          hasTapAction: false,
          hasLongPressAction: false,
          hasIncreaseAction: false,
          hasDecreaseAction: false,
        ),
      );

      final progress = tester.widget<RemixProgress>(find.byType(RemixProgress));
      expect(progress.semanticsLabel, 'Uploading workspace');
      expect(progress.semanticsValue, isNull);
    } finally {
      semantics.dispose();
    }
  });
  testWidgets('updates the existing progress node', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      var value = 0.25;
      late StateSetter update;

      await tester.pumpRemixApp(
        StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return FortalProgress(
              value: value,
              semanticsLabel: 'Uploading workspace',
            );
          },
        ),
      );
      await tester.pump();

      List<SemanticsNode> progressNodes() => tester.semantics
          .simulatedAccessibilityTraversal()
          .where(
            (node) => node.getSemanticsData().role == SemanticsRole.progressBar,
          )
          .toList();

      final initialNode = progressNodes().single;
      expect(initialNode.getSemanticsData().value, '25');

      update(() => value = 0.75);
      await tester.pump();

      final updatedNodes = progressNodes();
      expect(updatedNodes, hasLength(1));
      expect(updatedNodes.single.id, initialNode.id);
      expect(updatedNodes.single.getSemanticsData().value, '75');
    } finally {
      semantics.dispose();
    }
  });
}
