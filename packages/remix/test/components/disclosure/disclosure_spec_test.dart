import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('DisclosureSpec', () {
    test('provides empty defaults for every styled part', () {
      const spec = DisclosureSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.trigger, isA<StyleSpec<BoxSpec>>());
      expect(spec.content, isA<StyleSpec<BoxSpec>>());
      expect(spec.containerEffects, isNull);
    });

    test('copyWith updates one part and preserves the others', () {
      const original = DisclosureSpec();
      const trigger = StyleSpec(
        spec: BoxSpec(constraints: BoxConstraints(minHeight: 40)),
      );

      final updated = original.copyWith(trigger: trigger);

      expect(updated.trigger, trigger);
      expect(updated.container, original.container);
      expect(updated.content, original.content);
    });

    test('lerp interpolates all parts', () {
      const start = DisclosureSpec();
      const end = DisclosureSpec(
        trigger: StyleSpec(
          spec: BoxSpec(constraints: BoxConstraints(minHeight: 48)),
        ),
      );

      final result = start.lerp(end, 0.5);

      expect(result, isA<DisclosureSpec>());
      expect(result.trigger.spec.constraints?.minHeight, 24);
    });

    test('supports diagnostics', () {
      const spec = DisclosureSpec();

      expect(
        () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
        returnsNormally,
      );
    });
  });
}
