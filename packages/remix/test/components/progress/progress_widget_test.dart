import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixProgress Basic Rendering', () {
    testWidgets('renders progress with minimal props', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.5));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress with value 0', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.0));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress with value 1', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 1.0));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress with custom style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.75,
          style: RemixProgressStyler()
              .height(20.0)
              .trackColor(Colors.grey)
              .indicatorColor(Colors.blue),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Value Validation', () {
    test('accepts value at lower boundary (0)', () {
      expect(() => const RemixProgress(value: 0.0), returnsNormally);
    });

    test('accepts value at upper boundary (1)', () {
      expect(() => const RemixProgress(value: 1.0), returnsNormally);
    });

    test('accepts value in middle range', () {
      expect(() => const RemixProgress(value: 0.5), returnsNormally);
    });

    test('throws assertion error when value is less than 0', () {
      expect(() => RemixProgress(value: -0.1), throwsA(isA<AssertionError>()));
    });

    test('throws assertion error when value is greater than 1', () {
      expect(() => RemixProgress(value: 1.1), throwsA(isA<AssertionError>()));
    });
  });

  group('RemixProgress Styling Tests', () {
    testWidgets('applies height style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(value: 0.5, style: RemixProgressStyler().height(30.0)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies width style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(value: 0.5, style: RemixProgressStyler().width(200.0)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies track color style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().trackColor(Colors.grey),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies indicator color style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().indicatorColor(Colors.blue),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies padding style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().padding(EdgeInsetsGeometryMix.all(16.0)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies margin style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().margin(EdgeInsetsGeometryMix.all(8.0)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies combined styles', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler()
              .height(20.0)
              .width(300.0)
              .trackColor(Colors.grey.shade300)
              .indicatorColor(Colors.blue)
              .padding(EdgeInsetsGeometryMix.all(8.0)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Different Values', () {
    testWidgets('renders progress at 0% (empty)', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.0));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress at 25%', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.25));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress at 50%', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.5));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress at 75%', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.75));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders progress at 100% (full)', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 1.0));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Layout Tests', () {
    testWidgets('contains LayoutBuilder widget', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.5));
      await tester.pumpAndSettle();

      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('contains SizedBox widget', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.5));
      await tester.pumpAndSettle();

      expect(find.byType(SizedBox), findsWidgets);
    });
  });

  group('RemixProgress Edge Cases', () {
    testWidgets('handles very small progress value', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.01));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('handles very large progress value', (tester) async {
      await tester.pumpRemixApp(const RemixProgress(value: 0.99));
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('handles progress with styleSpec directly', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(value: 0.5, styleSpec: RemixProgressSpec()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Advanced Styling', () {
    testWidgets('applies track styler', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().track(
            BoxStyler(
              decoration: BoxDecorationMix(
                color: Colors.grey,
                borderRadius: BorderRadiusMix.circular(8.0),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies indicator styler', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().indicator(
            BoxStyler(
              decoration: BoxDecorationMix(
                color: Colors.blue,
                borderRadius: BorderRadiusMix.circular(8.0),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies trackContainer styler', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().trackContainer(
            BoxStyler(
              decoration: BoxDecorationMix(
                border: BoxBorderMix.all(BorderSideMix(color: Colors.black)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies alignment style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().alignment(Alignment.center),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies constraints style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().constraints(
            BoxConstraintsMix(minWidth: 200.0, maxWidth: 400.0),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies decoration style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().decoration(
            BoxDecorationMix(
              color: Colors.white,
              borderRadius: BorderRadiusMix.circular(12.0),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies foregroundDecoration style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().foregroundDecoration(
            BoxDecorationMix(
              border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('applies transform style', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().transform(Matrix4.identity()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Widget Modifiers', () {
    testWidgets('applies wrap modifier', (tester) async {
      await tester.pumpRemixApp(
        RemixProgress(
          value: 0.5,
          style: RemixProgressStyler().wrap(.clipOval()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixProgress), findsOneWidget);
    });
  });

  group('RemixProgress Key Tests', () {
    testWidgets('accepts key parameter', (tester) async {
      const key = ValueKey('progress_key');

      await tester.pumpRemixApp(const RemixProgress(key: key, value: 0.5));
      await tester.pumpAndSettle();

      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('RemixProgress Accessibility', () {
    testWidgets('is decorative when semantic inputs are omitted', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(const RemixProgress(value: 0.5));
        await tester.pump();

        final nodes = tester.semantics.simulatedAccessibilityTraversal().where(
          (node) => node.getSemanticsData().role == SemanticsRole.progressBar,
        );
        expect(nodes, isEmpty);
      } finally {
        semantics.dispose();
      }
    });

    testWidgets('semantic value alone remains decorative', (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          const RemixProgress(value: 0.5, semanticsValue: '50'),
        );
        await tester.pump();

        final nodes = tester.semantics.simulatedAccessibilityTraversal().where(
          (node) => node.getSemanticsData().role == SemanticsRole.progressBar,
        );
        expect(nodes, isEmpty);
      } finally {
        semantics.dispose();
      }
    });

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
              (node) =>
                  node.getSemanticsData().role == SemanticsRole.progressBar,
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

        final progress = tester.widget<RemixProgress>(
          find.byType(RemixProgress),
        );
        expect(progress.semanticsLabel, 'Uploading workspace');
        expect(progress.semanticsValue, isNull);
      } finally {
        semantics.dispose();
      }
    });

    testWidgets('uses a caller-provided progress value', (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          const RemixProgress(
            value: 0.42,
            semanticsLabel: 'Uploading workspace',
            semanticsValue: '42%',
          ),
        );
        await tester.pump();

        expect(
          tester.getSemantics(find.byType(RemixProgress)),
          isSemantics(
            label: 'Uploading workspace',
            value: '42%',
            minValue: '0',
            maxValue: '100',
          ),
        );
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
              (node) =>
                  node.getSemanticsData().role == SemanticsRole.progressBar,
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
  });
}
