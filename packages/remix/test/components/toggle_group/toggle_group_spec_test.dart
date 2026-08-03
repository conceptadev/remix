import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('ToggleGroupSpec', () {
    test('creates default child specs', () {
      const spec = ToggleGroupSpec();

      expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.item, isA<StyleSpec<ToggleGroupItemSpec>>());
      expect(spec.props, hasLength(2));
    });

    test('copyWith replaces selected properties', () {
      const original = ToggleGroupSpec();
      final container = StyleSpec(spec: FlexBoxSpec());

      final copy = original.copyWith(container: container);

      expect(copy, isNot(same(original)));
      expect(copy.container, container);
      expect(copy.item, original.item);
    });

    test('lerp supports endpoints and null', () {
      const first = ToggleGroupSpec();
      const second = ToggleGroupSpec();

      expect(first.lerp(null, 0.5), first);
      expect(first.lerp(second, 0), first);
      expect(first.lerp(second, 1), second);
    });

    test('supports diagnostics', () {
      const spec = ToggleGroupSpec();
      final builder = DiagnosticPropertiesBuilder();

      expect(() => spec.debugFillProperties(builder), returnsNormally);
      expect(builder.properties.map((property) => property.name), [
        'container',
        'item',
      ]);
    });
  });

  group('ToggleGroupItemSpec', () {
    test('creates default child specs', () {
      const spec = ToggleGroupItemSpec();

      expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.label, isA<StyleSpec<TextSpec>>());
      expect(spec.icon, isA<StyleSpec<IconSpec>>());
      expect(spec.props, hasLength(3));
    });

    test('copyWith and lerp preserve value semantics', () {
      const original = ToggleGroupItemSpec();
      final label = StyleSpec(spec: TextSpec());
      final copy = original.copyWith(label: label);

      expect(copy.label, label);
      expect(copy.container, original.container);
      expect(original.lerp(null, 0.5), original);
      expect(const ToggleGroupItemSpec(), original);
      expect(const ToggleGroupItemSpec().hashCode, original.hashCode);
    });
  });
}
