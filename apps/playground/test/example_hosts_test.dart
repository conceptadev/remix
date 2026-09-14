import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/main.dart' as playground;

void main() {
  for (final component in ['textarea', 'menu', 'skeleton']) {
    testWidgets('$component comparison works under WidgetsApp', (tester) async {
      tester.view.physicalSize = const Size(2400, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.binding.resetEpoch();
      playground.main();
      await tester.pump();
      await tester.tap(find.text(component));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.byType(WidgetsApp), findsWidgets);
      expect(find.byType(MaterialApp), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Dark theme'));
      await tester.pump();
      expect(find.text('Light theme'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
