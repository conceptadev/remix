import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('SegmentedControlSpec', () {
    test('creates default track and item specs', () {
      const spec = SegmentedControlSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.mainAxisSize, isNull);
      expect(spec.spacing, isNull);
      expect(spec.item, isA<StyleSpec<SegmentedControlItemSpec>>());
      expect(spec.props, hasLength(4));
    });

    test('copyWith replaces selected properties', () {
      const original = SegmentedControlSpec();
      final container = StyleSpec(spec: BoxSpec());

      final copy = original.copyWith(
        container: container,
        mainAxisSize: MainAxisSize.max,
        spacing: 6,
      );

      expect(copy, isNot(same(original)));
      expect(copy.container, container);
      expect(copy.mainAxisSize, MainAxisSize.max);
      expect(copy.spacing, 6);
      expect(copy.item, original.item);
    });

    test('supports lerp endpoints, null, and diagnostics', () {
      const first = SegmentedControlSpec();
      const second = SegmentedControlSpec();
      final builder = DiagnosticPropertiesBuilder();

      expect(first.lerp(null, 0.5), first);
      expect(first.lerp(second, 0), first);
      expect(first.lerp(second, 1), second);
      expect(() => first.debugFillProperties(builder), returnsNormally);
      expect(builder.properties.map((property) => property.name), [
        'container',
        'mainAxisSize',
        'spacing',
        'item',
      ]);
    });
  });

  group('SegmentedControlItemSpec', () {
    test('creates default anatomy and value semantics', () {
      const spec = SegmentedControlItemSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.spacing, isNull);
      expect(spec.label, isA<StyleSpec<TextSpec>>());
      expect(spec.icon, isA<StyleSpec<IconSpec>>());
      expect(spec.containerEffects, isNull);
      expect(spec.props, hasLength(5));
      expect(const SegmentedControlItemSpec(), spec);
      expect(const SegmentedControlItemSpec().hashCode, spec.hashCode);
    });

    test('copyWith preserves effects and replaces child specs', () {
      const effects = RemixBoxEffectsSpec(outlineOffset: 6);
      const original = SegmentedControlItemSpec(containerEffects: effects);
      final label = StyleSpec(spec: TextSpec());

      final copy = original.copyWith(label: label, spacing: 6);

      expect(copy.label, label);
      expect(copy.container, original.container);
      expect(copy.spacing, 6);
      expect(copy.containerEffects, effects);
    });

    test('lerp interpolates nullable item effects explicitly', () {
      const first = SegmentedControlItemSpec(
        containerEffects: RemixBoxEffectsSpec(outlineOffset: 2),
      );
      const second = SegmentedControlItemSpec(
        containerEffects: RemixBoxEffectsSpec(outlineOffset: 6),
      );

      final middle = first.lerp(second, 0.5);

      expect(middle.containerEffects?.outlineOffset, 4);
      expect(first.lerp(null, 0.5).containerEffects, isNull);
    });
  });
}
