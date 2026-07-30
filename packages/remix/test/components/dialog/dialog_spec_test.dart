import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixDialogSpec', () {
    test('creates default child specs', () {
      const spec = RemixDialogSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.title, isA<StyleSpec<TextSpec>>());
      expect(spec.description, isA<StyleSpec<TextSpec>>());
      expect(spec.actions, isA<StyleSpec<FlexBoxSpec>>());
    });

    test('uses provided child specs', () {
      final container = StyleSpec(spec: BoxSpec());
      final title = StyleSpec(spec: TextSpec());
      final description = StyleSpec(spec: TextSpec());
      final actions = StyleSpec(spec: FlexBoxSpec());

      final spec = RemixDialogSpec(
        container: container,
        title: title,
        description: description,
        actions: actions,
      );

      expect(spec.container, same(container));
      expect(spec.title, same(title));
      expect(spec.description, same(description));
      expect(spec.actions, same(actions));
    });

    test('copyWith updates selected values and preserves the rest', () {
      const original = RemixDialogSpec();
      final title = StyleSpec(spec: TextSpec());

      final updated = original.copyWith(title: title);

      expect(updated, isNot(same(original)));
      expect(updated.container, same(original.container));
      expect(updated.title, same(title));
      expect(updated.description, same(original.description));
      expect(updated.actions, same(original.actions));
    });

    test('lerp returns a value object with all dialog fields', () {
      const first = RemixDialogSpec();
      const second = RemixDialogSpec();

      final result = first.lerp(second, 0.5);

      expect(result, isA<RemixDialogSpec>());
      expect(result.props, hasLength(5));
      expect(
        result.props,
        containsAll(<Object?>[
          result.container,
          result.title,
          result.description,
          result.actions,
        ]),
      );
    });

    test('supports value equality and diagnostics', () {
      const first = RemixDialogSpec();
      const second = RemixDialogSpec();
      final properties = DiagnosticPropertiesBuilder();

      first.debugFillProperties(properties);

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
      expect(
        properties.properties.map((property) => property.name),
        containsAll(['container', 'title', 'description', 'actions']),
      );
    });
  });
}
