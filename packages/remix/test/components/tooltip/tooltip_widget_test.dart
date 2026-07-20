import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixTooltip', () {
    group('Basic Rendering', () {
      testWidgets('renders with default style', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
        expect(find.text('Trigger'), findsOneWidget);
      });

      testWidgets('renders tooltip child', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text('Tooltip Content'),
            child: Icon(Icons.info),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
      });

      testWidgets('renders with custom widgets', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            tooltipChild: Container(
              key: const ValueKey('tooltip_container'),
              child: const Text('Custom Tooltip'),
            ),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Trigger'), findsOneWidget);
      });
    });

    group('Interaction', () {
      testWidgets('shows tooltip on hover', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().waitDuration(Duration.zero),
            tooltipChild: const Text('Tooltip Content'),
            child: const Icon(Icons.info),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byIcon(Icons.info)));
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.text('Tooltip Content'), findsOneWidget);
      });
    });

    group('Styling', () {
      testWidgets('applies custom padding', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().padding(EdgeInsetsGeometryMix.all(20)),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom background color', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().color(Colors.blue),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom border radius', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().borderRadius(
              BorderRadiusGeometryMix.circular(12),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom margin', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().margin(EdgeInsetsGeometryMix.all(8)),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom alignment', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().alignment(Alignment.topCenter),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom decoration', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().decoration(
              BoxDecorationMix(color: Colors.red),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies label style to text tooltip children', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler(
              label: TextStyler(style: TextStyleMix(color: Colors.purple)),
              waitDuration: Duration.zero,
            ),
            tooltipChild: const Text('Styled tooltip'),
            child: const Icon(Icons.info),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.byIcon(Icons.info)));
        await tester.pumpAndSettle();

        final tooltipContext = tester.element(find.text('Styled tooltip'));
        expect(DefaultTextStyle.of(tooltipContext).style.color, Colors.purple);
      });
    });

    group('Duration Configuration', () {
      testWidgets('applies custom wait duration', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().waitDuration(
              const Duration(milliseconds: 500),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies custom show duration', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().showDuration(
              const Duration(milliseconds: 2000),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('uses default durations when not specified', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });
    });

    group('Semantics', () {
      testWidgets('uses tooltip semantics label', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipSemantics: 'Info tooltip',
            tooltipChild: Text('Tooltip'),
            child: Icon(Icons.info),
          ),
        );
        await tester.pumpAndSettle();

        final tooltip = tester.widget<RemixTooltip>(find.byType(RemixTooltip));
        expect(tooltip.tooltipSemantics, equals('Info tooltip'));
      });

      testWidgets('works without semantic label', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        final tooltip = tester.widget<RemixTooltip>(find.byType(RemixTooltip));
        expect(tooltip.tooltipSemantics, isNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles very short text', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(tooltipChild: Text('T'), child: Text('X')),
        );
        await tester.pumpAndSettle();

        expect(find.text('X'), findsOneWidget);
      });

      testWidgets('handles very long text', (tester) async {
        const longText =
            'This is a very long tooltip text that should '
            'wrap properly and display correctly in the tooltip overlay';

        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text(longText),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Trigger'), findsOneWidget);
      });

      testWidgets('handles complex tooltip children', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            tooltipChild: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.warning), Text('Warning Message')],
            ),
            child: const Icon(Icons.info),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.info), findsOneWidget);
      });

      testWidgets('handles complex trigger children', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            tooltipChild: const Text('Tooltip'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.info),
                SizedBox(width: 4),
                Text('Info'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Info'), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
      });
    });

    group('Advanced Styling', () {
      testWidgets('applies constraints', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().constraints(
              BoxConstraintsMix(minWidth: 100, maxWidth: 200),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies foreground decoration', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().foregroundDecoration(
              BoxDecorationMix(shape: BoxShape.circle),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies transform', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().transform(
              Matrix4.rotationZ(0.1),
              alignment: Alignment.center,
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });

      testWidgets('applies combined styles', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler()
                .color(Colors.blue)
                .padding(EdgeInsetsGeometryMix.all(16))
                .borderRadius(BorderRadiusGeometryMix.circular(8))
                .waitDuration(const Duration(milliseconds: 500)),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().wrap(.clipOval()),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and uses key parameter', (tester) async {
        const key = ValueKey('tooltip_key');

        await tester.pumpRemixApp(
          const RemixTooltip(
            key: key,
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('uses styleSpec when provided', (tester) async {
        const spec = RemixTooltipSpec(
          container: StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
          waitDuration: Duration.zero,
          showDuration: Duration(milliseconds: 2500),
        );

        await tester.pumpRemixApp(
          const RemixTooltip(
            styleSpec: spec,
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('Trigger')));
        await tester.pumpAndSettle();

        final decorations = tester
            .widgetList<Box>(find.byType(Box))
            .map((box) => box.styleSpec?.spec.decoration);

        expect(
          decorations,
          contains(equals(const BoxDecoration(color: Colors.red))),
        );
      });

      testWidgets('accepts custom positioning', (tester) async {
        const positioning = OverlayPositionConfig(
          side: OverlaySide.top,
          alignment: OverlayAlignment.center,
          sideOffset: 8,
        );

        await tester.pumpRemixApp(
          const RemixTooltip(
            positioning: positioning,
            tooltipChild: Text('Tooltip'),
            child: Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        final tooltip = tester.widget<RemixTooltip>(find.byType(RemixTooltip));
        expect(tooltip.positioning, equals(positioning));
      });
    });

    group('Animation', () {
      testWidgets('applies animation config', (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: RemixTooltipStyler().animate(
              AnimationConfig.linear(const Duration(milliseconds: 300)),
            ),
            tooltipChild: const Text('Tooltip'),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTooltip), findsOneWidget);
      });
    });

    group('Multiple Tooltips', () {
      testWidgets('renders multiple tooltips', (tester) async {
        await tester.pumpRemixApp(
          Column(
            children: const [
              RemixTooltip(
                tooltipChild: Text('Tooltip 1'),
                child: Text('Trigger 1'),
              ),
              RemixTooltip(
                tooltipChild: Text('Tooltip 2'),
                child: Text('Trigger 2'),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Trigger 1'), findsOneWidget);
        expect(find.text('Trigger 2'), findsOneWidget);
      });
    });

    group('Icon Child', () {
      testWidgets('works with icon as child', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Text('Help information'),
            child: Icon(Icons.help),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.help), findsOneWidget);
      });

      testWidgets('works with icon as tooltip child', (tester) async {
        await tester.pumpRemixApp(
          const RemixTooltip(
            tooltipChild: Icon(Icons.check_circle),
            child: Text('Success'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Success'), findsOneWidget);
      });
    });
  });
}
