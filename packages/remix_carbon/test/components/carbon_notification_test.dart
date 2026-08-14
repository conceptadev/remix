import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonNotification exposes alert semantics and actions', (
    tester,
  ) async {
    var acted = false;
    var closed = false;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonNotification(
        kind: CarbonNotificationKind.error,
        title: 'Upload failed',
        subtitle: 'Try again later',
        actionLabel: 'Retry',
        onAction: () => acted = true,
        onClose: () => closed = true,
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Upload failed')).role,
      SemanticsRole.alert,
    );
    await tester.tap(find.bySemanticsLabel('Retry'));
    await tester.tap(find.bySemanticsLabel('Close Upload failed'));
    expect(acted, isTrue);
    expect(closed, isTrue);
    semantics.dispose();
  });

  testWidgets('informational notification exposes status semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonNotification(title: 'Upload complete', hideCloseButton: true),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Upload complete')).role,
      SemanticsRole.status,
    );
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });
}
