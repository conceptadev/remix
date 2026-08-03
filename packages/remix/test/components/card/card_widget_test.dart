import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixCard', () {
    group('Basic Rendering', () {
      testWidgets('renders card with minimal props', (tester) async {
        await tester.pumpRemixApp(const RemixCard());
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });

      testWidgets('renders card with child', (tester) async {
        const testChild = Icon(Icons.star, key: ValueKey('test_icon'));
        await tester.pumpRemixApp(const RemixCard(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byKey(const ValueKey('test_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders card with all props', (tester) async {
        const testChild = Text('Card Content');
        await tester.pumpRemixApp(
          const RemixCard(child: testChild, style: CardStyler.create()),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Card Content'), findsOneWidget);
      });
    });

    group('Child Handling', () {
      testWidgets('card with text child renders correctly', (tester) async {
        await tester.pumpRemixApp(
          const RemixCard(child: Text('Card Text Content')),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Card Text Content'), findsOneWidget);
      });

      testWidgets('card with complex child renders correctly', (tester) async {
        final complexChild = Column(
          children: [
            const Text('Card Title'),
            const Text('Card Description'),
            const Icon(Icons.info),
          ],
        );

        await tester.pumpRemixApp(RemixCard(child: complexChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Card Title'), findsOneWidget);
        expect(find.text('Card Description'), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
      });

      testWidgets('card with null child renders correctly', (tester) async {
        await tester.pumpRemixApp(const RemixCard(child: null));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });
    });

    group('Style Integration', () {
      testWidgets('applies custom style to container', (tester) async {
        final customStyle = CardStyler(
          container: BoxStyler(
            padding: EdgeInsetsGeometryMix.all(20.0),
            decoration: BoxDecorationMix(
              color: Colors.lightBlue,
              borderRadius: BorderRadiusGeometryMix.circular(12.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixCard(child: const Text('Styled Card'), style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Styled Card'), findsOneWidget);
      });

      testWidgets('uses default style when none provided', (tester) async {
        await tester.pumpRemixApp(
          const RemixCard(child: Text('Default Style Card')),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.text('Default Style Card'), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('card adapts to child size', (tester) async {
        const smallChild = Icon(Icons.star, size: 16.0);
        await tester.pumpRemixApp(const RemixCard(child: smallChild));
        await tester.pumpAndSettle();

        final smallSize = tester.getSize(find.byType(RemixCard));

        const largeChild = Icon(Icons.star, size: 32.0);
        await tester.pumpRemixApp(const RemixCard(child: largeChild));
        await tester.pumpAndSettle();

        final largeSize = tester.getSize(find.byType(RemixCard));

        expect(largeSize.width, greaterThan(smallSize.width));
        expect(largeSize.height, greaterThan(smallSize.height));
      });

      testWidgets('card with text adapts to text length', (tester) async {
        await tester.pumpRemixApp(const RemixCard(child: Text('Short')));
        await tester.pumpAndSettle();

        final shortSize = tester.getSize(find.byType(RemixCard));

        await tester.pumpRemixApp(
          const RemixCard(child: Text('Much Longer Card Text Content')),
        );
        await tester.pumpAndSettle();

        final longSize = tester.getSize(find.byType(RemixCard));

        expect(longSize.width, greaterThan(shortSize.width));
      });
    });

    group('Accessibility', () {
      testWidgets('card with text child preserves child semantics', (
        tester,
      ) async {
        const testChild = Text('Accessible Card Content');
        await tester.pumpRemixApp(const RemixCard(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.text('Accessible Card Content'), findsOneWidget);
      });

      testWidgets('card with icon child preserves child semantics', (
        tester,
      ) async {
        const testChild = Icon(Icons.star, semanticLabel: 'Star Icon');
        await tester.pumpRemixApp(const RemixCard(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
        // Child semantics should be preserved
        final iconSemantics = tester.getSemantics(find.byIcon(Icons.star));
        expect(iconSemantics.label, contains('Star Icon'));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles very long text content', (tester) async {
        const longText =
            'This is a very long card content that should be handled gracefully by the card component without breaking the layout or causing overflow issues in the user interface';

        await tester.pumpRemixApp(const RemixCard(child: Text(longText)));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('handles special characters in content', (tester) async {
        const specialText = 'Card with émojis 🎉 and spëcial chars!';

        await tester.pumpRemixApp(const RemixCard(child: Text(specialText)));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.text(specialText), findsOneWidget);
      });

      testWidgets('handles empty content gracefully', (tester) async {
        await tester.pumpRemixApp(const RemixCard(child: Text('')));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCard), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
      });
    });
  });
}
