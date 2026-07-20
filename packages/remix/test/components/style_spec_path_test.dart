import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('raw styleSpec widget path', () {
    testWidgets('badge', (tester) async {
      await tester.pumpRemixApp(
        const RemixBadge(child: Text('New'), styleSpec: RemixBadgeSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixBadge), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('card', (tester) async {
      await tester.pumpRemixApp(
        const RemixCard(styleSpec: RemixCardSpec(), child: Text('body')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixCard), findsOneWidget);
    });

    testWidgets('divider', (tester) async {
      await tester.pumpRemixApp(
        const RemixDivider(styleSpec: RemixDividerSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixDivider), findsOneWidget);
    });

    testWidgets('spinner', (tester) async {
      await tester.pumpRemixApp(
        const RemixSpinner(styleSpec: RemixSpinnerSpec(size: 20)),
      );
      await tester.pump();
      expect(find.byType(RemixSpinner), findsOneWidget);
    });

    testWidgets('progress', (tester) async {
      await tester.pumpRemixApp(
        const RemixProgress(value: 40, styleSpec: RemixProgressSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('callout', (tester) async {
      await tester.pumpRemixApp(
        const RemixCallout(child: Text('hi'), styleSpec: RemixCalloutSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixCallout), findsOneWidget);
    });

    testWidgets('avatar', (tester) async {
      await tester.pumpRemixApp(
        const RemixAvatar(label: 'LF', styleSpec: RemixAvatarSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixAvatar), findsOneWidget);
    });

    testWidgets('dialog', (tester) async {
      await tester.pumpRemixApp(
        const RemixDialog(title: 'T', styleSpec: RemixDialogSpec()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixDialog), findsOneWidget);
    });

    testWidgets('tooltip', (tester) async {
      await tester.pumpRemixApp(
        const RemixTooltip(
          tooltipChild: Text('tip'),
          styleSpec: RemixTooltipSpec(),
          child: Text('child'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RemixTooltip), findsOneWidget);
    });
  });
}
