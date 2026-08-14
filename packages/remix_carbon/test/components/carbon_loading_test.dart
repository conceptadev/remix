import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonLoading resolves both Carbon sizes and colors', (
    tester,
  ) async {
    late ({SpinnerSpec regular, SpinnerSpec small, Color interactive}) result;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            result = (
              regular: carbonLoadingStyle().build(context).spec,
              small: carbonLoadingStyle(small: true).build(context).spec,
              interactive: CarbonTokens.interactive.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(result.regular.size, 88);
    expect(result.regular.strokeWidth, 10);
    expect(result.regular.indicatorColor, result.interactive);
    expect(result.small.size, 16);
    expect(result.small.strokeWidth, 2);
  });

  testWidgets('active state and loading semantics are explicit', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonLoading(withOverlay: false, description: 'Loading account'),
    );

    expect(find.byType(RemixSpinner), findsOneWidget);
    final node = tester.getSemantics(find.byType(RemixSpinner));
    expect(node, isSemantics(label: 'Loading account'));
    expect(node.role, SemanticsRole.loadingSpinner);

    await tester.pumpCarbonApp(const CarbonLoading(active: false));
    expect(find.byType(RemixSpinner), findsNothing);
    semantics.dispose();
  });
}
