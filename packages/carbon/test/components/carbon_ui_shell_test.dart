import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
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
}
