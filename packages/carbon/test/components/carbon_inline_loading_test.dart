import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets(
    'CarbonInlineLoading renders each status without losing its label',
    (tester) async {
      for (final status in CarbonInlineLoadingStatus.values) {
        await tester.pumpCarbonApp(
          CarbonInlineLoading(label: 'Saving', status: status),
        );

        expect(find.text('Saving'), findsOneWidget);
        expect(
          find.byType(RemixSpinner),
          status == CarbonInlineLoadingStatus.active
              ? findsOneWidget
              : findsNothing,
        );
      }
    },
  );

  testWidgets('announces terminal status and invokes completion once', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var completions = 0;
    await tester.pumpCarbonApp(
      CarbonInlineLoading(
        label: 'Saved',
        status: CarbonInlineLoadingStatus.finished,
        onSuccess: () => completions++,
      ),
    );
    await tester.pump();

    expect(completions, 1);
    expect(find.bySemanticsLabel('Saved'), findsWidgets);

    await tester.pump();
    expect(completions, 1);
    semantics.dispose();
  });
}
