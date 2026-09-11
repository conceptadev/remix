import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  for (final variant in FortalButtonVariant.values) {
    for (final size in FortalButtonSize.values) {
      testWidgets('${variant.name}/${size.name} uses preset icon size', (
        tester,
      ) async {
        final expectedSize = switch (size) {
          FortalButtonSize.size1 => 12.0,
          FortalButtonSize.size2 => 16.0,
          FortalButtonSize.size3 => 20.0,
          FortalButtonSize.size4 => 24.0,
        };
        await tester.pumpRemixApp(
          IconTheme(
            data: const IconThemeData(size: 48),
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

        expect(
          tester.getSize(find.byIcon(Icons.save)),
          Size.square(expectedSize),
        );
        expect(
          tester.getSize(find.byIcon(Icons.check)),
          Size.square(expectedSize),
        );
        expect(tester.takeException(), isNull);
      });

      for (final direction in TextDirection.values) {
        for (final slots in ['leading', 'trailing', 'both']) {
          testWidgets(
            '${variant.name}/${size.name}/$slots/${direction.name} contains icons at large text',
            (tester) async {
              var presses = 0;
              await tester.pumpRemixApp(
                MediaQuery(
                  data: const MediaQueryData(textScaler: TextScaler.linear(2)),
                  child: SizedBox(
                    width: 320,
                    child: Center(
                      child: FortalButton(
                        variant: variant,
                        size: size,
                        label: 'Save',
                        leadingIcon: slots == 'trailing' ? null : Icons.save,
                        trailingIcon: slots == 'leading' ? null : Icons.check,
                        onPressed: () => presses++,
                      ),
                    ),
                  ),
                ),
                textDirection: direction,
              );
              await tester.pumpAndSettle();
              final bounds = tester.getRect(find.byType(RemixButton));
              for (final icon in [Icons.save, Icons.check]) {
                final finder = find.byIcon(icon);
                final expected = icon == Icons.save
                    ? slots != 'trailing'
                    : slots != 'leading';
                expect(finder, expected ? findsOneWidget : findsNothing);
                if (!expected) continue;
                final rect = tester.getRect(finder);
                expect(rect.left, greaterThanOrEqualTo(bounds.left));
                expect(rect.right, lessThanOrEqualTo(bounds.right));
                expect(rect.top, greaterThanOrEqualTo(bounds.top));
                expect(rect.bottom, lessThanOrEqualTo(bounds.bottom));
              }
              await tester.tap(find.text('Save'));
              expect(presses, 1);
              expect(tester.takeException(), isNull);
            },
          );
        }
      }

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

      testWidgets('${variant.name}/${size.name} accepts widget icon override', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          FortalButton(
            variant: variant,
            size: size,
            style: ButtonStyler().icon(IconStyler().size(14)),
            label: 'Save',
            leadingIcon: Icons.save,
            trailingIcon: Icons.check,
            onPressed: () {},
          ),
        );
        expect(tester.getSize(find.byIcon(Icons.save)), const Size.square(14));
        expect(tester.getSize(find.byIcon(Icons.check)), const Size.square(14));
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('base RemixButton still inherits icon size', (tester) async {
    await tester.pumpRemixApp(
      IconTheme(
        data: const IconThemeData(size: 19),
        child: RemixButton(
          label: 'Save',
          leadingIcon: Icons.save,
          trailingIcon: Icons.check,
          onPressed: () {},
        ),
      ),
    );
    expect(tester.getSize(find.byIcon(Icons.save)), const Size.square(19));
    expect(tester.getSize(find.byIcon(Icons.check)), const Size.square(19));
  });
}
