import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('button applies raw styleSpec via RemixStyleSpecBuilder path', (
    tester,
  ) async {
    const labelColor = Color(0xFF112233);
    final styleSpec = ButtonSpec(
      label: StyleSpec(
        spec: TextSpec(style: TextStyle(color: labelColor, fontSize: 18)),
      ),
    );

    await tester.pumpRemixApp(
      RemixButton(label: 'Save', onPressed: () {}, styleSpec: styleSpec),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RemixButton), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    final text = tester.widget<Text>(find.text('Save'));
    expect(text.style?.color, labelColor);
    expect(text.style?.fontSize, 18);
  });
}
