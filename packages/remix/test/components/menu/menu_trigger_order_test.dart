import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('arbitrary trigger preserves caller-owned child order', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      const RemixMenu<String>(
        trigger: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Actions'), Icon(Icons.menu)],
        ),
        items: [RemixMenuAction(value: 'a', child: Text('A'))],
      ),
    );

    expect(
      tester.getTopLeft(find.text('Actions')).dx,
      lessThan(tester.getTopLeft(find.byIcon(Icons.menu)).dx),
    );
  });
}
