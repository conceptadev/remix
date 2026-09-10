import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  for (final variant in FortalButtonVariant.values) {
    for (final size in FortalButtonSize.values) {
      testWidgets('${variant.name}/${size.name} inherits icon size', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          IconTheme(
            data: const IconThemeData(size: 19),
            child: FortalButton(
              variant: variant,
              size: size,
              label: 'Save',
              leadingIcon: Icons.save,
              trailingIcon: Icons.check,
              onPressed: () {},
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.getSize(find.byIcon(Icons.save)), const Size.square(19));
        expect(tester.getSize(find.byIcon(Icons.check)), const Size.square(19));
        expect(tester.takeException(), isNull);
      });

      testWidgets('${variant.name}/${size.name} accepts recipe icon override', (
        tester,
      ) async {
        var presses = 0;
        await tester.pumpRemixApp(
          IconTheme(
            data: const IconThemeData(size: 19),
            child: RemixButton(
              style: fortalButtonStyle(
                variant: variant,
                size: size,
              ).icon(IconStyler().size(14)),
              label: 'Save',
              leadingIcon: Icons.save,
              trailingIcon: Icons.check,
              onPressed: () => presses++,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.getSize(find.byIcon(Icons.save)), const Size.square(14));
        expect(tester.getSize(find.byIcon(Icons.check)), const Size.square(14));
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        expect(presses, 1);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
