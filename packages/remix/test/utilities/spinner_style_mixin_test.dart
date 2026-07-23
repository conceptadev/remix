import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('ButtonStyler spinner nesting', () {
    test('sets each spinner field through nested shorthand', () {
      final spinner = RemixSpinnerStyler(
        color: Colors.red,
        size: 28,
        opacity: 0.5,
        leafRadius: const Radius.circular(3),
        duration: const Duration(milliseconds: 500),
      );
      final original = ButtonStyler();
      final modified = original.spinner(spinner);

      expect(modified, isNot(same(original)));
      expect(modified.$spinner, Prop.maybeMix(spinner));
    });

    testWidgets('successive nested styles merge field by field', (
      tester,
    ) async {
      final style = ButtonStyler()
          .spinner(.color(Colors.blue))
          .spinner(.opacity(0.45))
          .spinner(.size(28))
          .spinner(.leafRadius(const Radius.circular(3)))
          .spinner(.duration(const Duration(milliseconds: 500)));

      late RemixSpinnerSpec resolved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = style.resolve(context).spec.spinner.spec;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolved.color, Colors.blue);
      expect(resolved.opacity, 0.45);
      expect(resolved.size, 28);
      expect(resolved.leafRadius, const Radius.circular(3));
      expect(resolved.duration, const Duration(milliseconds: 500));
    });

    test('spinner nesting composes with label and icon nesting', () {
      final style = ButtonStyler()
          .label(.color(Colors.white))
          .icon(.color(Colors.white))
          .spinner(.color(Colors.white))
          .color(Colors.blue);

      expect(
        style.$spinner,
        Prop.maybeMix(RemixSpinnerStyler(color: Colors.white)),
      );
    });
  });
}
