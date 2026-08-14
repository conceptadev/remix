import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonBreadcrumb exposes navigation and activates links', (
    tester,
  ) async {
    var activated = false;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonBreadcrumb(
        items: [
          CarbonBreadcrumbItem(
            label: 'Home',
            onPressed: () => activated = true,
          ),
          const CarbonBreadcrumbItem(label: 'Settings', current: true),
        ],
      ),
    );

    await tester.tap(find.text('Home'));
    expect(activated, isTrue);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Breadcrumb')).role,
      SemanticsRole.navigation,
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Settings')),
      isSemantics(isSelected: true, hasSelectedState: true),
    );
    semantics.dispose();
  });

  testWidgets('CarbonBreadcrumb collapses a long middle section', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const CarbonBreadcrumb(
        maxVisibleItems: 3,
        items: [
          CarbonBreadcrumbItem(label: 'One'),
          CarbonBreadcrumbItem(label: 'Two'),
          CarbonBreadcrumbItem(label: 'Three'),
          CarbonBreadcrumbItem(label: 'Four'),
        ],
      ),
    );

    expect(find.byIcon(CarbonIcons.overflowMenuHorizontal), findsOneWidget);
    expect(find.text('Two'), findsNothing);
  });
}
