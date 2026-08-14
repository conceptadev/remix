import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonModal preserves content and dialog semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonModal(
        title: 'Delete project',
        description: 'This cannot be undone.',
        child: Text('Project Phoenix'),
      ),
    );

    expect(find.text('Project Phoenix'), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(CarbonModal)).role,
      SemanticsRole.dialog,
    );
    semantics.dispose();
  });

  testWidgets('showCarbonModal returns a route result', (tester) async {
    await tester.pumpCarbonApp(
      Builder(
        builder: (context) => CarbonButton(
          label: 'Open modal',
          onPressed: () async {
            await showCarbonModal<String>(
              context: context,
              builder: (context) => CarbonModal(
                title: 'Confirm',
                actions: [
                  CarbonButton(
                    label: 'Done',
                    onPressed: () => Navigator.pop(context, 'done'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open modal'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm'), findsOneWidget);
    expect(
      tester.getCenter(find.byType(RemixDialog)).dx,
      moreOrLessEquals(
        tester.view.physicalSize.width / tester.view.devicePixelRatio / 2,
      ),
    );
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm'), findsNothing);
  });

  testWidgets('CarbonModal exposes the official close action', (tester) async {
    var closed = false;
    final semantics = tester.ensureSemantics();

    await tester.pumpCarbonApp(
      CarbonModal(
        title: 'Preferences',
        onClose: () => closed = true,
        closeSemanticLabel: 'Dismiss preferences',
        actions: [
          CarbonButton(label: 'Cancel', onPressed: () {}),
          CarbonButton(label: 'Save', onPressed: () {}),
        ],
      ),
    );

    expect(find.byIcon(CarbonIcons.close), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Dismiss preferences')),
      isSemantics(
        label: 'Dismiss preferences',
        hasTapAction: true,
        isEnabled: true,
        isButton: true,
      ),
    );
    final actionSizes = tester
        .widgetList<CarbonButton>(find.byType(CarbonButton))
        .map((button) => tester.getSize(find.byWidget(button)))
        .toList(growable: false);
    expect(actionSizes, hasLength(2));
    expect(actionSizes.first.width, actionSizes.last.width);
    expect(actionSizes.first.width, greaterThan(150));

    await tester.tap(find.bySemanticsLabel('Dismiss preferences'));
    expect(closed, isTrue);
    semantics.dispose();
  });
}
