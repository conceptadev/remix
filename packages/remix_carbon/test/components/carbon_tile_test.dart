import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonClickableTile supports keyboard activation', (
    tester,
  ) async {
    var pressed = false;
    await tester.pumpCarbonApp(
      CarbonClickableTile(
        semanticLabel: 'Open analytics',
        onPressed: () => pressed = true,
        child: const Text('Analytics'),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Open analytics'));
    expect(pressed, isTrue);
    pressed = false;
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(pressed, isTrue);
  });

  testWidgets('CarbonSelectableTile reports selected state', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonSelectableTile(
        selected: true,
        semanticLabel: 'Starter plan',
        child: Text('Starter'),
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Starter plan')),
      isSemantics(isSelected: true, hasSelectedState: true),
    );
  });

  testWidgets('CarbonExpandableTile owns uncontrolled disclosure state', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const CarbonExpandableTile(
        title: 'Details',
        child: Text('Hidden details'),
      ),
    );

    expect(find.byType(RemixDisclosure), findsOneWidget);
    expect(find.text('Hidden details'), findsNothing);
    await tester.tap(find.bySemanticsLabel('Details'));
    await tester.pump();
    expect(find.text('Hidden details'), findsOneWidget);
  });

  testWidgets('CarbonExpandableTile forwards controlled disclosure requests', (
    tester,
  ) async {
    final requests = <bool>[];
    await tester.pumpCarbonApp(
      CarbonExpandableTile(
        title: 'Controlled details',
        expanded: false,
        onExpandedChanged: requests.add,
        child: const Text('Owner-controlled details'),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Controlled details'));
    await tester.pump();

    expect(requests, [true]);
    expect(find.text('Owner-controlled details'), findsNothing);
    expect(find.byIcon(CarbonIcons.chevronDown), findsOneWidget);
    expect(find.byIcon(CarbonIcons.chevronUp), findsNothing);
  });

  testWidgets('CarbonExpandableTile uses reduced-motion-aware Carbon timing', (
    tester,
  ) async {
    const tile = CarbonExpandableTile(
      title: 'Motion',
      child: Text('Animated details'),
    );
    await tester.pumpCarbonApp(tile);

    var disclosure = tester.widget<RemixDisclosure>(
      find.byType(RemixDisclosure),
    );
    expect(
      disclosure.animationStyle.duration,
      const Duration(milliseconds: 110),
    );
    expect(
      disclosure.animationStyle.reverseDuration,
      const Duration(milliseconds: 150),
    );
    expect(
      disclosure.animationStyle.curve,
      CarbonMotion.curve(.standard, .productive),
    );
    expect(
      disclosure.animationStyle.reverseCurve,
      CarbonMotion.curve(.standard, .productive),
    );

    await tester.pumpCarbonApp(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: tile,
      ),
    );

    disclosure = tester.widget<RemixDisclosure>(find.byType(RemixDisclosure));
    expect(disclosure.animationStyle.duration, Duration.zero);
    expect(disclosure.animationStyle.reverseDuration, Duration.zero);
    expect(disclosure.animationStyle.curve, Curves.linear);
    expect(disclosure.animationStyle.reverseCurve, Curves.linear);
  });
}
