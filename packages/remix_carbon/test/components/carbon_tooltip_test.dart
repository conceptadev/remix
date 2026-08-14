import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonTooltip opens after Carbon hover delay', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonTooltip(
        tooltipSemantics: 'Create a copy',
        tooltipChild: Text('Create a copy'),
        child: Text('Copy'),
      ),
    );

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: const Offset(0, 0));
    await mouse.moveTo(tester.getCenter(find.text('Copy')));
    await tester.pump(const Duration(milliseconds: 99));
    expect(find.text('Create a copy'), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('Create a copy'), findsOneWidget);
  });

  testWidgets('Carbon tooltip recipe matches high-contrast geometry', (
    tester,
  ) async {
    late TooltipSpec spec;
    late Color inverse;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonTooltipStyle().build(context).spec;
            inverse = CarbonTokens.backgroundInverse.resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.container.spec.constraints?.maxWidth, 288);
    expect(spec.container.spec.padding, const EdgeInsets.all(16));
    expect((spec.container.spec.decoration as BoxDecoration?)?.color, inverse);
    expect(spec.waitDuration, const Duration(milliseconds: 100));
    expect(spec.dismissDuration, const Duration(milliseconds: 300));
  });
}
