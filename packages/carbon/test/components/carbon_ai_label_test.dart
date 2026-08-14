import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonAiLabel opens its AI explanation', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonAiLabel(content: Text('Generated with Granite.')),
    );

    expect(find.text('AI'), findsOneWidget);
    expect(find.text('Generated with Granite.'), findsNothing);
    await tester.tap(find.text('AI'));
    await tester.pump();
    expect(find.text('Generated with Granite.'), findsOneWidget);
  });

  testWidgets('Carbon AI label defaults to the upstream xs geometry', (
    tester,
  ) async {
    late BoxSpec spec;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonAiLabelStyle().build(context).spec;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.constraints?.minWidth, 24);
    expect(spec.constraints?.minHeight, 24);
    expect((spec.decoration as BoxDecoration?)?.border, isA<Border>());
  });
}
