import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonUiShell composes header, side navigation, and content', (
    tester,
  ) async {
    var destination = '';
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonUiShell(
        header: const CarbonHeader(productName: 'Carbon Studio'),
        sideNav: CarbonSideNav(
          items: [
            CarbonSideNavItem(
              label: 'Dashboard',
              selected: true,
              onPressed: () => destination = 'dashboard',
            ),
          ],
        ),
        child: const Text('Workspace'),
      ),
    );

    expect(find.text('Workspace'), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Primary navigation')).role,
      SemanticsRole.navigation,
    );
    await tester.tap(find.bySemanticsLabel('Dashboard'));
    expect(destination, 'dashboard');
    semantics.dispose();
  });

  testWidgets('CarbonSideNav keeps custom destination slots', (tester) async {
    await tester.pumpCarbonApp(
      CarbonSideNav(
        items: const [
          CarbonSideNavItem(
            key: ValueKey('reports'),
            label: 'Reports',
            leading: Icon(CarbonIcons.dashboard),
            trailing: Text('New'),
          ),
        ],
      ),
    );

    expect(find.byKey(const ValueKey('reports')), findsOneWidget);
    expect(find.byIcon(CarbonIcons.dashboard), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
  });

  testWidgets('CarbonSideNav uses a logical three-pixel selection marker', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      Directionality(
        textDirection: TextDirection.rtl,
        child: CarbonSideNav(
          items: const [
            CarbonSideNavItem(
              key: ValueKey('selected-destination'),
              label: 'Selected',
              selected: true,
            ),
          ],
        ),
      ),
    );

    final borders = tester
        .widgetList<DecoratedBox>(
          find.descendant(
            of: find.byKey(const ValueKey('selected-destination')),
            matching: find.byType(DecoratedBox),
          ),
        )
        .map((box) => (box.decoration as BoxDecoration).border)
        .whereType<BorderDirectional>()
        .toList();

    expect(borders, hasLength(1));
    expect(borders.single.start.width, 3);
    expect(borders.single.end, BorderSide.none);
  });
}
