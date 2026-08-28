import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('NavigationListSpec', () {
    test('creates every public anatomy slot', () {
      const spec = NavigationListSpec();

      expect(spec.container, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.section, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.sectionLabel, isA<StyleSpec<TextSpec>>());
      expect(spec.destinations, isA<StyleSpec<FlexBoxSpec>>());
      expect(spec.destination, isA<StyleSpec<ToggleSpec>>());
      expect(spec.props, hasLength(5));
    });

    test(
      'copyWith, lerp, equality, and diagnostics preserve value semantics',
      () {
        const original = NavigationListSpec();
        final sectionLabel = StyleSpec(
          spec: TextSpec(style: const TextStyle(fontSize: 12)),
        );
        final copy = original.copyWith(sectionLabel: sectionLabel);

        expect(copy.sectionLabel, sectionLabel);
        expect(copy.container, original.container);
        expect(original.lerp(null, 0.5), original);
        expect(original.lerp(copy, 1).sectionLabel.spec.style?.fontSize, 12);
        expect(const NavigationListSpec(), original);
        expect(const NavigationListSpec().hashCode, original.hashCode);

        final builder = DiagnosticPropertiesBuilder();
        original.debugFillProperties(builder);
        expect(builder.properties.map((property) => property.name), [
          'container',
          'section',
          'sectionLabel',
          'destinations',
          'destination',
        ]);
      },
    );
  });
}
