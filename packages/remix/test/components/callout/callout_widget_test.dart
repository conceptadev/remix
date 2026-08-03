import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixCallout', () {
    group('Basic Rendering', () {
      testWidgets('renders callout with text only', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Test Callout'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Test Callout'), findsOneWidget);
      });

      testWidgets('renders callout with icon only', (tester) async {
        await tester.pumpRemixApp(
          RemixCallout(text: 'Icon Callout', icon: Icons.info),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
        expect(find.text('Icon Callout'), findsOneWidget);
      });

      testWidgets('renders callout with child only', (tester) async {
        final testChild = Icon(Icons.star, key: ValueKey('test_icon'));
        await tester.pumpRemixApp(RemixCallout(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byKey(ValueKey('test_icon')), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('constrains flexible custom content to the callout width', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 320,
            child: RemixCallout(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'A detailed capture failure that should wrap in place.',
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('Retry')),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Retry'), findsOneWidget);
      });

      testWidgets('wraps long text beside its icon at a bounded width', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          SizedBox(
            width: 320,
            child: RemixCallout(
              icon: Icons.info,
              text:
                  'A detailed capture failure that should wrap without '
                  'overflowing the callout.',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });

      testWidgets('renders callout with all props', (tester) async {
        await tester.pumpRemixApp(
          RemixCallout(
            text: 'Complete Callout',
            icon: Icons.warning,
            style: CalloutStyler.create(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.byIcon(Icons.warning), findsOneWidget);
        expect(find.text('Complete Callout'), findsOneWidget);
      });
    });

    group('Content Combinations', () {
      testWidgets('text and icon are rendered together', (tester) async {
        await tester.pumpRemixApp(
          RemixCallout(text: 'Info Message', icon: Icons.info_outline),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.byIcon(Icons.info_outline), findsOneWidget);
        expect(find.text('Info Message'), findsOneWidget);
      });

      testWidgets('child takes priority over text and icon', (tester) async {
        final testChild = Container(
          key: ValueKey('priority_child'),
          child: Text('Custom Child'),
        );
        await tester.pumpRemixApp(
          RemixCallout(
            text: 'Should not show',
            icon: Icons.error,
            child: testChild,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byKey(ValueKey('priority_child')), findsOneWidget);
        expect(find.text('Custom Child'), findsOneWidget);
        expect(find.text('Should not show'), findsNothing);
        expect(find.byIcon(Icons.error), findsNothing);
      });

      testWidgets('empty text with icon still renders icon', (tester) async {
        await tester.pumpRemixApp(
          RemixCallout(text: '', icon: Icons.check_circle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
        expect(find.byType(StyledText), findsNothing);
      });

      testWidgets('null text with icon still renders icon', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: '', icon: Icons.star));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byType(StyledText), findsNothing);
      });
    });

    group('Icon Variations', () {
      testWidgets('renders different icon types', (tester) async {
        final icons = [
          Icons.info,
          Icons.warning,
          Icons.error,
          Icons.check_circle,
          Icons.help,
        ];

        for (final icon in icons) {
          await tester.pumpRemixApp(
            RemixCallout(text: 'Icon Test', icon: icon),
          );
          await tester.pumpAndSettle();

          expect(find.byType(RemixCallout), findsOneWidget);
          expect(find.byType(StyledIcon), findsOneWidget);
          expect(find.byIcon(icon), findsOneWidget);
          expect(find.text('Icon Test'), findsOneWidget);
        }
      });

      testWidgets('icon styling is applied correctly', (tester) async {
        final customStyle = CalloutStyler(
          icon: IconStyler(color: Colors.red, size: 24.0),
        );

        await tester.pumpRemixApp(
          RemixCallout(
            text: 'Styled Icon',
            icon: Icons.favorite,
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.text('Styled Icon'), findsOneWidget);
      });
    });

    group('Text Variations', () {
      testWidgets('renders short text', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Hi'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Hi'), findsOneWidget);
      });

      testWidgets('renders long text', (tester) async {
        const longText = 'This is a longer callout message';

        await tester.pumpRemixApp(RemixCallout(text: longText));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('renders text with special characters', (tester) async {
        const specialText = 'Callout with émojis 🎉 and spëcial chars!';

        await tester.pumpRemixApp(RemixCallout(text: specialText));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text(specialText), findsOneWidget);
      });

      testWidgets('text styling is applied correctly', (tester) async {
        final customStyle = CalloutStyler(
          text: TextStyler(
            style: TextStyleMix(
              color: Colors.blue,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixCallout(text: 'Styled Text', style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Styled Text'), findsOneWidget);
      });
    });

    group('Style Integration', () {
      testWidgets('applies custom container style', (tester) async {
        final customStyle = CalloutStyler(
          container: FlexBoxStyler(
            padding: EdgeInsetsGeometryMix.all(20.0),
            decoration: BoxDecorationMix(
              color: Colors.lightBlue,
              borderRadius: BorderRadiusGeometryMix.circular(12.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixCallout(text: 'Styled Container', style: customStyle),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.text('Styled Container'), findsOneWidget);
      });

      testWidgets('applies flex spacing between icon and text', (tester) async {
        final customStyle = CalloutStyler(
          container: FlexBoxStyler(spacing: 16.0),
        );

        await tester.pumpRemixApp(
          RemixCallout(
            text: 'Spaced Content',
            icon: Icons.info,
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
        expect(find.text('Spaced Content'), findsOneWidget);
      });

      testWidgets('uses default style when none provided', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Default Style'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Default Style'), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('callout renders with different text lengths', (
        tester,
      ) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Short'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.text('Short'), findsOneWidget);

        await tester.pumpRemixApp(
          RemixCallout(text: 'Much Longer Callout Text'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.text('Much Longer Callout Text'), findsOneWidget);
      });

      testWidgets('callout renders with and without icon', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Text Only'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.text('Text Only'), findsOneWidget);
        expect(find.byType(StyledIcon), findsNothing);

        await tester.pumpRemixApp(
          RemixCallout(text: 'Text Only', icon: Icons.info),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.text('Text Only'), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
      });

      testWidgets('callout renders with different child sizes', (tester) async {
        final smallChild = Icon(Icons.star, size: 16.0);
        await tester.pumpRemixApp(RemixCallout(child: smallChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);

        final largeChild = Icon(Icons.star, size: 32.0);
        await tester.pumpRemixApp(RemixCallout(child: largeChild));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('callout with text renders correctly', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'Accessible Callout'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.text('Accessible Callout'), findsOneWidget);
      });

      testWidgets('callout with icon and text renders correctly', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixCallout(text: 'Info Message', icon: Icons.info),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
        expect(find.text('Info Message'), findsOneWidget);
      });

      testWidgets('callout with child renders correctly', (tester) async {
        final testChild = Icon(Icons.star, semanticLabel: 'Star Icon');
        await tester.pumpRemixApp(RemixCallout(child: testChild));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.star), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty text gracefully', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: ''));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledText), findsNothing);
      });

      testWidgets('handles null icon gracefully', (tester) async {
        await tester.pumpRemixApp(RemixCallout(text: 'No Icon', icon: null));
        await tester.pumpAndSettle();

        expect(find.byType(RemixCallout), findsOneWidget);
        expect(find.byType(RowBox), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('No Icon'), findsOneWidget);
        expect(find.byType(StyledIcon), findsNothing);
      });

      test('assertion error when both text and child are null', () {
        expect(
          () => RemixCallout(text: null, child: null),
          throwsAssertionError,
        );
      });

      test('assertion error when text is null and child is null', () {
        expect(() => RemixCallout(), throwsAssertionError);
      });
    });
  });
}
