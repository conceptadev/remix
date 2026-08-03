import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('raw styleSpec widget path', () {
    testWidgets('badge', (tester) async {
      await tester.pumpRemixApp(
        const RemixBadge(label: 'New', styleSpec: BadgeSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixBadge), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('card', (tester) async {
      await tester.pumpRemixApp(
        const RemixCard(styleSpec: CardSpec(), child: Text('body')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixCard), findsOneWidget);
    });

    testWidgets('divider', (tester) async {
      await tester.pumpRemixApp(const RemixDivider(styleSpec: DividerSpec()));
      await tester.pumpAndSettle();
      expect(find.byType(RemixDivider), findsOneWidget);
    });

    testWidgets('spinner', (tester) async {
      await tester.pumpRemixApp(
        const RemixSpinner(styleSpec: SpinnerSpec(size: 20)),
      );
      await tester.pump();
      expect(find.byType(RemixSpinner), findsOneWidget);
    });

    testWidgets('progress', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(value: 0.4, styleSpec: ProgressSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('callout', (tester) async {
      await tester.pumpRemixApp(
        const RemixCallout(text: 'hi', styleSpec: CalloutSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixCallout), findsOneWidget);
    });

    testWidgets('avatar', (tester) async {
      await tester.pumpRemixApp(
        const RemixAvatar(label: 'LF', styleSpec: AvatarSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixAvatar), findsOneWidget);
    });

    testWidgets('dialog', (tester) async {
      await tester.pumpRemixApp(
        const RemixDialog(title: 'T', styleSpec: DialogSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixDialog), findsOneWidget);
    });

    testWidgets('tooltip', (tester) async {
      await tester.pumpRemixApp(
        const RemixTooltip(
          tooltipChild: Text('tip'),
          styleSpec: TooltipSpec(),
          child: Text('child'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixTooltip), findsOneWidget);
    });
  });
}
