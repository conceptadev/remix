import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSelectSpec', () {
    test('provides typed defaults for every structural slot', () {
      const spec = RemixSelectSpec();

      expect(spec.trigger.spec, isA<RemixSelectTriggerSpec>());
      expect(spec.content.spec, isA<RemixSelectContentSpec>());
      expect(spec.item.spec, isA<RemixSelectMenuItemSpec>());
      expect(spec.label.spec, isA<RemixSelectLabelSpec>());
      expect(spec.separator.spec, isA<BoxSpec>());
    });

    test('copyWith replaces one slot and preserves the rest', () {
      const original = RemixSelectSpec();
      const replacement = StyleSpec(
        spec: RemixSelectContentSpec(
          containerEffects: RemixBoxEffectsSpec(
            behindContent: RemixBoxEffectLayerSpec(
              shadows: [RemixBoxShadow(color: Colors.blue)],
            ),
          ),
        ),
      );

      final copied = original.copyWith(content: replacement);

      expect(copied.content, replacement);
      expect(copied.trigger, original.trigger);
      expect(copied.item, original.item);
      expect(copied.label, original.label);
      expect(copied.separator, original.separator);
    });

    test('value equality includes all slots', () {
      const first = RemixSelectSpec(
        separator: StyleSpec(
          spec: BoxSpec(constraints: BoxConstraints.tightFor(height: 1)),
        ),
      );
      const same = RemixSelectSpec(
        separator: StyleSpec(
          spec: BoxSpec(constraints: BoxConstraints.tightFor(height: 1)),
        ),
      );
      const different = RemixSelectSpec();

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
    });
  });

  group('Select part specs', () {
    test('trigger carries independent paint and text roles', () {
      const trigger = RemixSelectTriggerSpec(
        containerEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.red)],
          ),
          overContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.orange)],
          ),
        ),
        chevronOpacity: 0.9,
        placeholderOpacity: 0.6,
      );

      expect(
        trigger.containerEffects?.behindContent?.shadows.first.color,
        Colors.red,
      );
      expect(
        trigger.containerEffects?.overContent?.shadows.first.color,
        Colors.orange,
      );
      expect(trigger.chevronOpacity, 0.9);
      expect(trigger.placeholderOpacity, 0.6);
      expect(trigger.placeholder.spec, isA<TextSpec>());
      expect(trigger.chevron.spec, isA<IconSpec>());
    });

    test('content, item, and label expose their owned slots', () {
      const content = RemixSelectContentSpec(
        containerEffects: RemixBoxEffectsSpec(
          behindContent: RemixBoxEffectLayerSpec(
            shadows: [RemixBoxShadow(color: Colors.blue)],
          ),
        ),
      );
      const item = RemixSelectMenuItemSpec();
      const label = RemixSelectLabelSpec(adjacentItemSpacing: 8);

      expect(
        content.containerEffects?.behindContent?.shadows.first.color,
        Colors.blue,
      );
      expect(item.indicator.spec, isA<BoxSpec>());
      expect(item.icon.spec, isA<IconSpec>());
      expect(label.text.spec, isA<TextSpec>());
      expect(label.adjacentItemSpacing, 8);
    });
  });
}
