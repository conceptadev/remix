import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonPagination clamps navigation and reports page changes', (
    tester,
  ) async {
    var page = 1;
    await tester.pumpCarbonApp(
      CarbonPagination(
        page: page,
        pageSize: 10,
        totalItems: 21,
        onPageChanged: (next) => page = next,
      ),
    );

    expect(find.text('1–10 of 21 items'), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Previous page')),
      isSemantics(hasEnabledState: true, isEnabled: false),
    );
    await tester.tap(find.bySemanticsLabel('Next page'));
    expect(page, 2);
  });

  testWidgets('CarbonPagination reports page-size selection', (tester) async {
    var pageSize = 10;
    await tester.pumpCarbonApp(
      CarbonPagination(
        page: 1,
        pageSize: pageSize,
        pageSizeOptions: const [10, 20],
        totalItems: 42,
        onPageChanged: (_) {},
        onPageSizeChanged: (next) => pageSize = next,
      ),
    );

    await tester.tap(find.bySemanticsLabel('Items per page'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20'));
    expect(pageSize, 20);
  });
}
