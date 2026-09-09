import 'package:flutter_test/flutter_test.dart';

/// Finish finite catalog transitions without waiting for live loaders to stop.
Future<void> pumpCatalog(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump();
}
