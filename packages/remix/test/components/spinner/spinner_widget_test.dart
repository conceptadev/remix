import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSpinner', () {
    group('Basic Rendering', () {
      testWidgets('renders spinner with default props', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('renders spinner with custom style', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(
            style: RemixSpinnerStyler(
              size: 32.0,
              indicatorColor: const Color(0xFF0000FF),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('contains CustomPaint widget', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());
        await tester.pump();

        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('contains AnimatedBuilder widget', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());
        await tester.pump();

        expect(find.byType(AnimatedBuilder), findsWidgets);
      });
    });

    group('Painter selection', () {
      Finder spinnerPaint() => find.descendant(
        of: find.byType(RemixSpinner),
        matching: find.byType(CustomPaint),
      );

      testWidgets('keeps the base spinner on the arc painter', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());
        await tester.pump();

        final customPaint = tester.widget<CustomPaint>(spinnerPaint());

        expect(customPaint.painter, isA<RemixSpinnerPainter>());
      });

      testWidgets('uses rounded fading leaves for the Fortal spinner', (
        tester,
      ) async {
        final expectedRadius = await _resolveFortal(
          tester,
          (context) => fortalSpinnerStyle().resolve(context).spec.leafRadius!,
        );

        await tester.pumpRemixApp(const FortalSpinner());
        await tester.pump();

        final customPaint = tester.widget<CustomPaint>(spinnerPaint());
        final painter = customPaint.painter;

        expect(painter, isA<RemixLeafSpinnerPainter>());
        final leafPainter = painter! as RemixLeafSpinnerPainter;
        expect(leafPainter.opacity, 0.65);
        expect(leafPainter.leafRadius, expectedRadius);
      });

      testWidgets('opts into the leaf painter when a leaf field is set', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(opacity: 0.5)),
        );
        await tester.pump();

        final customPaint = tester.widget<CustomPaint>(spinnerPaint());

        expect(customPaint.painter, isA<RemixLeafSpinnerPainter>());
      });

      testWidgets('keeps legacy-only styling on the arc painter', (
        tester,
      ) async {
        const indicatorColor = Color(0xFF123456);
        await tester.pumpRemixApp(
          RemixSpinner(
            style: RemixSpinnerStyler(
              indicatorColor: indicatorColor,
              strokeWidth: 3,
            ),
          ),
        );
        await tester.pump();

        final customPaint = tester.widget<CustomPaint>(spinnerPaint());
        final painter = customPaint.painter;

        expect(painter, isA<RemixSpinnerPainter>());
        final arcPainter = painter! as RemixSpinnerPainter;
        expect(arcPainter.indicatorColor, indicatorColor);
        expect(arcPainter.strokeWidth, 3);
      });

      testWidgets('inherits leaf color from the nearest IconTheme', (
        tester,
      ) async {
        const iconColor = Color(0xFF654321);
        await tester.pumpRemixApp(
          IconTheme(
            data: const IconThemeData(color: iconColor),
            child: RemixSpinner(style: RemixSpinnerStyler(opacity: 0.5)),
          ),
        );
        await tester.pump();

        final customPaint = tester.widget<CustomPaint>(spinnerPaint());
        final painter = customPaint.painter;

        expect(painter, isA<RemixLeafSpinnerPainter>());
        expect((painter! as RemixLeafSpinnerPainter).color, iconColor);
      });
    });

    group('Styling', () {
      testWidgets('applies custom size', (tester) async {
        final customStyle = RemixSpinnerStyler().size(48.0);

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies custom indicator color', (tester) async {
        final customStyle = RemixSpinnerStyler().indicatorColor(
          const Color(0xFF0000FF),
        );

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies custom track color', (tester) async {
        final customStyle = RemixSpinnerStyler().trackColor(
          const Color(0xFFCCCCCC),
        );

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies custom stroke width', (tester) async {
        final customStyle = RemixSpinnerStyler().strokeWidth(3.0);

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies custom track stroke width', (tester) async {
        final customStyle = RemixSpinnerStyler().trackStrokeWidth(2.0);

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies custom duration', (tester) async {
        final customStyle = RemixSpinnerStyler().duration(
          const Duration(milliseconds: 500),
        );

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Animation', () {
      testWidgets('spinner animates', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());

        // Initial state
        await tester.pump();

        // Advance animation
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(RemixSpinner), findsOneWidget);
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });

      testWidgets('spinner respects custom duration', (tester) async {
        const customDuration = Duration(milliseconds: 500);

        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(duration: customDuration)),
        );
        await tester.pump();

        // Advance through the custom duration
        await tester.pump(customDuration);

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('animation repeats continuously', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1000));
        await tester.pump(const Duration(milliseconds: 1000));

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Different Sizes', () {
      testWidgets('renders small spinner', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(size: 16.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('renders medium spinner', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(size: 32.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('renders large spinner', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(size: 64.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Advanced Styling', () {
      testWidgets('applies multiple style methods', (tester) async {
        final customStyle = RemixSpinnerStyler()
            .size(48.0)
            .strokeWidth(3.0)
            .indicatorColor(const Color(0xFF0000FF))
            .trackColor(const Color(0xFFCCCCCC))
            .trackStrokeWidth(2.0)
            .duration(const Duration(milliseconds: 500));

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('applies animation config', (tester) async {
        final customStyle = RemixSpinnerStyler().animate(
          AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        final customStyle = RemixSpinnerStyler().wrap(.clipOval());

        await tester.pumpRemixApp(RemixSpinner(style: customStyle));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('spinner_key');

        await tester.pumpRemixApp(const RemixSpinner(key: key));
        await tester.pump();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('accepts styleSpec parameter', (tester) async {
        const spec = RemixSpinnerSpec(
          size: 32.0,
          indicatorColor: Color(0xFF0000FF),
        );
        await tester.pumpRemixApp(const RemixSpinner(styleSpec: spec));
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles zero size', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(size: 0.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('handles very large size', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(size: 200.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('handles zero stroke width', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(strokeWidth: 0.0)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('handles very long duration', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(
            style: RemixSpinnerStyler(duration: const Duration(seconds: 10)),
          ),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });

      testWidgets('handles very short duration', (tester) async {
        await tester.pumpRemixApp(
          RemixSpinner(
            style: RemixSpinnerStyler(
              duration: const Duration(milliseconds: 100),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Widget Lifecycle', () {
      testWidgets('disposes animation controller', (tester) async {
        await tester.pumpRemixApp(const RemixSpinner());
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);

        // Remove the widget
        await tester.pumpRemixApp(Container());

        expect(find.byType(RemixSpinner), findsNothing);
      });

      testWidgets('updates duration when spec changes', (tester) async {
        const initialDuration = Duration(milliseconds: 1000);
        const newDuration = Duration(milliseconds: 500);

        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(duration: initialDuration)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);

        // Update duration
        await tester.pumpRemixApp(
          RemixSpinner(style: RemixSpinnerStyler(duration: newDuration)),
        );
        await tester.pump();

        expect(find.byType(RemixSpinner), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('is decorative when semantic inputs are omitted', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(const RemixSpinner());
          await tester.pump();

          final nodes = tester.semantics
              .simulatedAccessibilityTraversal()
              .where(
                (node) =>
                    node.getSemanticsData().role ==
                    SemanticsRole.loadingSpinner,
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
            const RemixSpinner(semanticsValue: 'Connecting'),
          );
          await tester.pump();

          final nodes = tester.semantics
              .simulatedAccessibilityTraversal()
              .where(
                (node) =>
                    node.getSemanticsData().role ==
                    SemanticsRole.loadingSpinner,
              );
          expect(nodes, isEmpty);
        } finally {
          semantics.dispose();
        }
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
                    node.getSemanticsData().role ==
                    SemanticsRole.loadingSpinner,
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

          final spinner = tester.widget<RemixSpinner>(
            find.byType(RemixSpinner),
          );
          expect(spinner.semanticsLabel, 'Loading workspaces');
          expect(spinner.semanticsValue, 'Connecting');
        } finally {
          semantics.dispose();
        }
      });
    });
  });
}

Future<T> _resolveFortal<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve,
) async {
  late T result;
  await tester.pumpRemixApp(
    Builder(
      builder: (context) {
        result = resolve(context);
        return const SizedBox.shrink();
      },
    ),
  );
  return result;
}
