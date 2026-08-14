import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonToggletip toggles interactive explanatory content', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const CarbonToggletip(
        semanticLabel: 'Show billing details',
        content: Text('Invoices are generated monthly.'),
        actions: Text('Manage billing'),
        child: Text('Billing info'),
      ),
    );

    expect(find.text('Invoices are generated monthly.'), findsNothing);
    await tester.tap(find.text('Billing info'));
    await tester.pump();
    expect(find.text('Invoices are generated monthly.'), findsOneWidget);
    expect(find.text('Manage billing'), findsOneWidget);
  });

  testWidgets('Carbon toggletip content is constrained and padded', (
    tester,
  ) async {
    late BoxSpec spec;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonToggletipContentStyle().build(context).spec;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.constraints?.maxWidth, 288);
    expect(spec.padding, const EdgeInsets.all(16));
  });

  testWidgets('high-contrast content does not recolor the trigger', (
    tester,
  ) async {
    Color? inheritedTriggerColor;
    await tester.pumpCarbonApp(
      CarbonToggletip(
        content: const Text('Details'),
        child: Builder(
          builder: (context) {
            inheritedTriggerColor = DefaultTextStyle.of(context).style.color;
            return const Text('Visible trigger');
          },
        ),
      ),
    );

    final context = tester.element(find.text('Visible trigger'));
    expect(inheritedTriggerColor, CarbonTokens.textPrimary.resolve(context));
  });
}
