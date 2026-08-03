import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixBadge', () {
    group('Basic Rendering', () {
      testWidgets('renders badge with minimal props', (tester) async {
        await tester.pumpRemixApp(const RemixBadge());
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders badge with label', (tester) async {
        await tester.pumpRemixApp(const RemixBadge(label: 'Test Badge'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Test Badge'), findsOneWidget);
      });

      testWidgets('renders badge with child', (tester) async {
        const testChild = Icon(Icons.star, key: ValueKey('test_icon'));
        await tester.pumpRemixApp(const RemixBadge(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byKey(const ValueKey('test_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders badge with all props', (tester) async {
        await tester.pumpRemixApp(
          const RemixBadge(
            label: 'Complete Badge',
            style: BadgeStyler.create(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Complete Badge'), findsOneWidget);
      });
    });

    group('Custom Builders', () {
      testWidgets('labelBuilder renders custom widget', (tester) async {
        Widget customLabelBuilder(
          BuildContext context,
          TextSpec spec,
          String label,
        ) {
          return Container(
            key: const ValueKey('custom_label'),
            child: Text('Custom: $label'),
          );
        }

        await tester.pumpRemixApp(
          RemixBadge(label: 'Test', labelBuilder: customLabelBuilder),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('custom_label')), findsOneWidget);
        expect(find.text('Custom: Test'), findsOneWidget);
      });

      testWidgets('labelBuilder receives correct parameters', (tester) async {
        TextSpec? receivedSpec;
        String? receivedLabel;

        Widget customLabelBuilder(
          BuildContext context,
          TextSpec spec,
          String label,
        ) {
          receivedSpec = spec;
          receivedLabel = label;
          return Text('Builder: $label');
        }

        await tester.pumpRemixApp(
          RemixBadge(label: 'Builder Test', labelBuilder: customLabelBuilder),
        );
        await tester.pumpAndSettle();

        expect(receivedSpec, isNotNull);
        expect(receivedSpec, isA<TextSpec>());
        expect(receivedLabel, equals('Builder Test'));
        expect(find.text('Builder: Builder Test'), findsOneWidget);
      });

      testWidgets('labelBuilder with empty label', (tester) async {
        Widget customLabelBuilder(
          BuildContext context,
          TextSpec spec,
          String label,
        ) {
          return Text('Empty: "$label"');
        }

        await tester.pumpRemixApp(RemixBadge(labelBuilder: customLabelBuilder));
        await tester.pumpAndSettle();

        expect(find.text('Empty: ""'), findsOneWidget);
      });
    });

    group('Content Priority', () {
      testWidgets('child takes priority over label when both provided', (
        tester,
      ) async {
        const testChild = Icon(Icons.check, key: ValueKey('priority_icon'));
        await tester.pumpRemixApp(
          const RemixBadge(label: 'Should not show', child: testChild),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('priority_icon')), findsOneWidget);
        expect(find.text('Should not show'), findsNothing);
        expect(find.byType(StyledText), findsNothing);
      });

      testWidgets('labelBuilder takes priority over label when both provided', (
        tester,
      ) async {
        Widget customLabelBuilder(
          BuildContext context,
          TextSpec spec,
          String label,
        ) {
          return Text('Builder: $label');
        }

        await tester.pumpRemixApp(
          RemixBadge(label: 'Original Label', labelBuilder: customLabelBuilder),
        );
        await tester.pumpAndSettle();

        expect(find.text('Builder: Original Label'), findsOneWidget);
        expect(find.text('Original Label'), findsNothing);
      });

      testWidgets('empty label renders empty text', (tester) async {
        await tester.pumpRemixApp(const RemixBadge(label: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('null label renders empty text', (tester) async {
        await tester.pumpRemixApp(const RemixBadge());
        await tester.pumpAndSettle();

        expect(find.byType(RemixBadge), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('badge adapts to content size', (tester) async {
        await tester.pumpRemixApp(const RemixBadge(label: 'Short'));
        await tester.pumpAndSettle();

        final shortSize = tester.getSize(find.byType(RemixBadge));

        await tester.pumpRemixApp(
          const RemixBadge(label: 'Much Longer Badge Text'),
        );
        await tester.pumpAndSettle();

        final longSize = tester.getSize(find.byType(RemixBadge));

        expect(longSize.width, greaterThan(shortSize.width));
      });

      testWidgets('badge with child adapts to child size', (tester) async {
        const smallChild = Icon(Icons.star, size: 16.0);
        await tester.pumpRemixApp(const RemixBadge(child: smallChild));
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(find.byType(RemixBadge));

        const largeChild = Icon(Icons.star, size: 32.0);
        await tester.pumpRemixApp(const RemixBadge(child: largeChild));
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(find.byType(RemixBadge));

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });
    });

    group('Accessibility', () {
      testWidgets('badge with label has semantic label', (tester) async {
        await tester.pumpRemixApp(const RemixBadge(label: 'Accessible Badge'));
        await tester.pumpAndSettle();

        final semantics = tester.getSemantics(find.byType(RemixBadge));
        expect(semantics.label, contains('Accessible Badge'));
      });

      testWidgets('badge with child preserves child semantics', (tester) async {
        const testChild = Icon(Icons.star, semanticLabel: 'Star Icon');
        await tester.pumpRemixApp(const RemixBadge(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
        // Child semantics should be preserved
        final iconSemantics = tester.getSemantics(find.byIcon(Icons.star));
        expect(iconSemantics.label, contains('Star Icon'));
      });
    });
  });
}
