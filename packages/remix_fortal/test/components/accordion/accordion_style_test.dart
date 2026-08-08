import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  group('Fortal styles', () {
    test('default style is surface size2', () {
      final defaultStyle = fortalAccordionStyle();
      final explicitStyle = fortalAccordionStyle(
        variant: FortalAccordionVariant.surface,
        size: FortalAccordionSize.size2,
      );

      expect(defaultStyle, equals(explicitStyle));
    });

    test('variant and size enums create distinct styles', () {
      final surface = fortalAccordionStyle(variant: .surface);
      final soft = fortalAccordionStyle(variant: .soft);
      final small = fortalAccordionStyle(size: .size1);
      final large = fortalAccordionStyle(size: .size3);

      expect(surface, isNot(equals(soft)));
      expect(small, isNot(equals(large)));
    });

    test('all variant and size combinations produce complete styles', () {
      for (final variant in FortalAccordionVariant.values) {
        for (final size in FortalAccordionSize.values) {
          final style = fortalAccordionStyle(variant: variant, size: size);

          expect(style.$trigger, isNotNull);
          expect(style.$title, isNotNull);
          expect(style.$trailingIcon, isNotNull);
          expect(style.$content, isNotNull);
        }
      }
    });
  });
}
