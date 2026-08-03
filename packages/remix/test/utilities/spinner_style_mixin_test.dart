import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('ButtonStyler spinner nesting', () {
    test('spinner indicator color can be set through nested shorthand', () {
      const testColor = Colors.red;
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.indicatorColor(testColor));

      final expectedSpinner = Prop.maybeMix(
        SpinnerStyler(indicatorColor: testColor),
      );

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    test('spinner track color can be set through nested shorthand', () {
      const testColor = Colors.blue;
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.trackColor(testColor));

      final expectedSpinner = Prop.maybeMix(
        SpinnerStyler(trackColor: testColor),
      );

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    test('spinner size can be set through nested shorthand', () {
      const testSize = 32.0;
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.size(testSize));

      final expectedSpinner = Prop.maybeMix(SpinnerStyler(size: testSize));

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    test('spinner stroke width can be set through nested shorthand', () {
      const testWidth = 3.0;
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.strokeWidth(testWidth));

      final expectedSpinner = Prop.maybeMix(
        SpinnerStyler(strokeWidth: testWidth),
      );

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    test('spinner track stroke width can be set through nested shorthand', () {
      const testWidth = 2.5;
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.trackStrokeWidth(testWidth));

      final expectedSpinner = Prop.maybeMix(
        SpinnerStyler(trackStrokeWidth: testWidth),
      );

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    test('spinner duration can be set through nested shorthand', () {
      const testDuration = Duration(milliseconds: 800);
      final originalStyle = ButtonStyler();
      final modifiedStyle = originalStyle.spinner(.duration(testDuration));

      final expectedSpinner = Prop.maybeMix(
        SpinnerStyler(duration: testDuration),
      );

      expect(modifiedStyle, isNot(same(originalStyle)));
      expect(modifiedStyle.$spinner, equals(expectedSpinner));
    });

    testWidgets('spinner styles can be chained together', (tester) async {
      final originalStyle = ButtonStyler();
      final chainedStyle = originalStyle
          .spinner(.indicatorColor(Colors.blue))
          .spinner(.trackColor(Colors.blue.withValues(alpha: 0.2)))
          .spinner(.size(28.0))
          .spinner(.strokeWidth(2.5))
          .spinner(.duration(const Duration(milliseconds: 500)));

      expect(chainedStyle, isNot(same(originalStyle)));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final spec = chainedStyle.resolve(context).spec.spinner.spec;

              expect(spec.indicatorColor, equals(Colors.blue));
              expect(
                spec.trackColor,
                equals(Colors.blue.withValues(alpha: 0.2)),
              );
              expect(spec.size, equals(28.0));
              expect(spec.strokeWidth, equals(2.5));
              expect(spec.duration, equals(const Duration(milliseconds: 500)));

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    test('spinner nesting can be chained with label and icon nesting', () {
      final combinedStyle = ButtonStyler()
          .label(.color(Colors.white))
          .icon(.color(Colors.white))
          .spinner(.indicatorColor(Colors.white))
          .color(Colors.blue);

      expect(
        combinedStyle.$spinner,
        equals(Prop.maybeMix(SpinnerStyler(indicatorColor: Colors.white))),
      );
    });
  });
}
