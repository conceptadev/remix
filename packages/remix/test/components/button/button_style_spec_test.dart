import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('button applies raw styleSpec via RemixStyleSpecBuilder path', (
    tester,
  ) async {
    const labelColor = Color(0xFF112233);
    final styleSpec = RemixButtonSpec(
      label: StyleSpec(
        spec: TextSpec(style: TextStyle(color: labelColor, fontSize: 18)),
      ),
    );

    await tester.pumpRemixApp(
      RemixButton(
        onPressed: () {},
        styleSpec: styleSpec,
        child: const Text('Save'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RemixButton), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    final inherited = DefaultTextStyle.of(tester.element(find.text('Save')));
    expect(inherited.style.color, labelColor);
    expect(inherited.style.fontSize, 18);
  });
}
