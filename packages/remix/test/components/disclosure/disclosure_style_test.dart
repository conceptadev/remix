import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('DisclosureStyler', () {
    test('constructs every explicit part', () {
      final style = DisclosureStyler(
        container: BoxStyler().padding(.all(4)),
        containerEffects: RemixBoxEffectsMix(backdropBlur: 4),
        trigger: BoxStyler().padding(.all(8)),
        content: BoxStyler().padding(.all(12)),
      );

      expect(style.$container, isNotNull);
      expect(style.$containerEffects, isNotNull);
      expect(style.$trigger, isNotNull);
      expect(style.$content, isNotNull);
    });

    test('top-level box methods forward to the trigger', () {
      final style = DisclosureStyler().color(Colors.red).padding(.all(8));

      expect(style.$trigger, isNotNull);
      expect(style.$container, isNull);
    });

    test('expanded and collapsed helpers add distinct variants', () {
      final style = DisclosureStyler()
          .onExpanded(DisclosureStyler().color(Colors.green))
          .onCollapsed(DisclosureStyler().color(Colors.red));

      expect(style.$variants, hasLength(2));
      expect(style.$variants?.first.variant, isA<ContextVariant>());
      expect(style.$variants?.last.variant, isA<ContextVariant>());
      expect(
        style.$variants?.first.variant,
        isNot(equals(style.$variants?.last.variant)),
      );
    });
  });
}
