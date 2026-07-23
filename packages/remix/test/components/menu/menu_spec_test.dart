import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixMenuSpec', () {
    test('provides empty overlay, item, label, and divider defaults', () {
      const spec = RemixMenuSpec();

      expect(spec.overlay, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.containerEffects, isNull);
      expect(spec.item, isA<StyleSpec<RemixMenuItemSpec>>());
      expect(spec.label, isA<StyleSpec<RemixMenuItemSpec>>());
      expect(spec.divider, isA<StyleSpec<RemixDividerSpec>>());
    });

    test('retains every supplied content slot', () {
      const surface = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.white)],
      );
      final item = StyleSpec(spec: const RemixMenuItemSpec(leadingInset: 12));
      final label = StyleSpec(
        spec: const RemixMenuItemSpec(adjacentItemSpacing: 8),
      );
      final spec = RemixMenuSpec(
        containerEffects: RemixBoxEffectsSpec(behindContent: surface),
        item: item,
        label: label,
      );

      expect(spec.containerEffects?.behindContent, surface);
      expect(spec.item, item);
      expect(spec.label, label);
    });
  });

  group('RemixMenuItemSpec', () {
    test('provides structured content defaults', () {
      const spec = RemixMenuItemSpec();

      expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.label, isA<StyleSpec<TextSpec>>());
      expect(spec.leadingIcon, isA<StyleSpec<IconSpec>>());
      expect(spec.trailingIcon, isA<StyleSpec<IconSpec>>());
      expect(spec.indicator, isA<StyleSpec<BoxSpec>>());
      expect(spec.indicatorIcon, isA<StyleSpec<IconSpec>>());
      expect(spec.leadingInset, isNull);
      expect(spec.checkableLeadingInset, isNull);
      expect(spec.trailingInset, isNull);
      expect(spec.adjacentItemSpacing, isNull);
    });

    test('retains exact layout metrics', () {
      const spec = RemixMenuItemSpec(
        leadingInset: 8,
        checkableLeadingInset: 20,
        trailingInset: 8,
        adjacentItemSpacing: 8,
      );

      expect(spec.leadingInset, 8);
      expect(spec.checkableLeadingInset, 20);
      expect(spec.trailingInset, 8);
      expect(spec.adjacentItemSpacing, 8);
    });
  });
}
