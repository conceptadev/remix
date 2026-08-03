import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('TabBarSpec', () {
    group('Constructor', () {
      test('creates with default container', () {
        const spec = TabBarSpec();

        expect(spec.container, equals(const StyleSpec(spec: FlexBoxSpec())));
      });

      test('creates with provided container', () {
        final container = StyleSpec(spec: const FlexBoxSpec());
        final spec = TabBarSpec(container: container);

        expect(spec.container, equals(container));
      });
    });

    group('copyWith', () {
      test('returns copy when no parameters provided', () {
        const spec = TabBarSpec();
        final copy = spec.copyWith();

        expect(copy.container, equals(spec.container));
      });

      test('returns copy with new container', () {
        const spec = TabBarSpec();
        final newContainer = StyleSpec(
          spec: const FlexBoxSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(container: newContainer);

        expect(copy.container, equals(newContainer));
        expect(copy.container, isNot(equals(spec.container)));
      });
    });

    group('lerp', () {
      test('returns value equal to this when other is null', () {
        const spec = TabBarSpec();
        final lerped = spec.lerp(null, 0.5);

        expect(lerped, equals(spec));
      });

      test('interpolates between two specs at t=0', () {
        const spec1 = TabBarSpec();
        const spec2 = TabBarSpec();

        final result = spec1.lerp(spec2, 0.0);

        expect(result.container, isNotNull);
      });

      test('interpolates between two specs at t=1', () {
        const spec1 = TabBarSpec();
        const spec2 = TabBarSpec();

        final result = spec1.lerp(spec2, 1.0);

        expect(result.container, isNotNull);
      });

      test('interpolates between two specs at t=0.5', () {
        const spec1 = TabBarSpec();
        const spec2 = TabBarSpec();

        final result = spec1.lerp(spec2, 0.5);

        expect(result.container, isNotNull);
      });
    });

    group('Equality & Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = TabBarSpec();
        const spec2 = TabBarSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = TabBarSpec();
        final spec2 = TabBarSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props includes all relevant properties', () {
        const spec = TabBarSpec();

        expect(spec.props.length, equals(1));
        expect(spec.props, contains(spec.container));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties includes container', () {
        const spec = TabBarSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties.any((p) => p.name == 'container'), isTrue);
      });
    });
  });

  group('TabViewSpec', () {
    group('Constructor', () {
      test('creates with default container', () {
        const spec = TabViewSpec();

        expect(spec.container, equals(const StyleSpec(spec: BoxSpec())));
      });

      test('creates with provided container', () {
        final container = StyleSpec(spec: const BoxSpec());
        final spec = TabViewSpec(container: container);

        expect(spec.container, equals(container));
      });
    });

    group('copyWith', () {
      test('returns copy when no parameters provided', () {
        const spec = TabViewSpec();
        final copy = spec.copyWith();

        expect(copy.container, equals(spec.container));
      });

      test('returns copy with new container', () {
        const spec = TabViewSpec();
        final newContainer = StyleSpec(
          spec: const BoxSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(container: newContainer);

        expect(copy.container, equals(newContainer));
        expect(copy.container, isNot(equals(spec.container)));
      });
    });

    group('lerp', () {
      test('returns value equal to this when other is null', () {
        const spec = TabViewSpec();
        final lerped = spec.lerp(null, 0.5);

        expect(lerped, equals(spec));
      });

      test('interpolates between two specs at t=0', () {
        const spec1 = TabViewSpec();
        const spec2 = TabViewSpec();

        final result = spec1.lerp(spec2, 0.0);

        expect(result.container, isNotNull);
      });

      test('interpolates between two specs at t=1', () {
        const spec1 = TabViewSpec();
        const spec2 = TabViewSpec();

        final result = spec1.lerp(spec2, 1.0);

        expect(result.container, isNotNull);
      });

      test('interpolates between two specs at t=0.5', () {
        const spec1 = TabViewSpec();
        const spec2 = TabViewSpec();

        final result = spec1.lerp(spec2, 0.5);

        expect(result.container, isNotNull);
      });
    });

    group('Equality & Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = TabViewSpec();
        const spec2 = TabViewSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = TabViewSpec();
        final spec2 = TabViewSpec(
          container: StyleSpec(
            spec: const BoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props includes all relevant properties', () {
        const spec = TabViewSpec();

        expect(spec.props.length, equals(1));
        expect(spec.props, contains(spec.container));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties includes container', () {
        const spec = TabViewSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties.any((p) => p.name == 'container'), isTrue);
      });
    });
  });

  group('TabSpec', () {
    group('Constructor', () {
      test('creates with default properties', () {
        const spec = TabSpec();

        expect(spec.container, equals(const StyleSpec(spec: FlexBoxSpec())));
        expect(spec.label, equals(const StyleSpec(spec: TextSpec())));
        expect(spec.icon, equals(const StyleSpec(spec: IconSpec())));
      });

      test('creates with provided properties', () {
        final container = StyleSpec(spec: const FlexBoxSpec());
        final label = StyleSpec(spec: const TextSpec());
        final icon = StyleSpec(spec: const IconSpec());

        final spec = TabSpec(container: container, label: label, icon: icon);

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.icon, equals(icon));
      });
    });

    group('copyWith', () {
      test('returns copy when no parameters provided', () {
        const spec = TabSpec();
        final copy = spec.copyWith();

        expect(copy.container, equals(spec.container));
        expect(copy.label, equals(spec.label));
        expect(copy.icon, equals(spec.icon));
      });

      test('returns copy with new container', () {
        const spec = TabSpec();
        final newContainer = StyleSpec(
          spec: const FlexBoxSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(container: newContainer);

        expect(copy.container, equals(newContainer));
        expect(copy.container, isNot(equals(spec.container)));
        expect(copy.label, equals(spec.label));
        expect(copy.icon, equals(spec.icon));
      });

      test('returns copy with new label', () {
        const spec = TabSpec();
        final newLabel = StyleSpec(
          spec: const TextSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(label: newLabel);

        expect(copy.label, equals(newLabel));
        expect(copy.label, isNot(equals(spec.label)));
        expect(copy.container, equals(spec.container));
        expect(copy.icon, equals(spec.icon));
      });

      test('returns copy with new icon', () {
        const spec = TabSpec();
        final newIcon = StyleSpec(
          spec: const IconSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(icon: newIcon);

        expect(copy.icon, equals(newIcon));
        expect(copy.icon, isNot(equals(spec.icon)));
        expect(copy.container, equals(spec.container));
        expect(copy.label, equals(spec.label));
      });
    });

    group('lerp', () {
      test('returns value equal to this when other is null', () {
        const spec = TabSpec();
        final lerped = spec.lerp(null, 0.5);

        expect(lerped, equals(spec));
      });

      test('interpolates between two specs at t=0', () {
        const spec1 = TabSpec();
        const spec2 = TabSpec();

        final result = spec1.lerp(spec2, 0.0);

        expect(result.container, isNotNull);
        expect(result.label, isNotNull);
        expect(result.icon, isNotNull);
      });

      test('interpolates between two specs at t=1', () {
        const spec1 = TabSpec();
        const spec2 = TabSpec();

        final result = spec1.lerp(spec2, 1.0);

        expect(result.container, isNotNull);
        expect(result.label, isNotNull);
        expect(result.icon, isNotNull);
      });

      test('interpolates between two specs at t=0.5', () {
        const spec1 = TabSpec();
        const spec2 = TabSpec();

        final result = spec1.lerp(spec2, 0.5);

        expect(result.container, isNotNull);
        expect(result.label, isNotNull);
        expect(result.icon, isNotNull);
      });
    });

    group('Equality & Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = TabSpec();
        const spec2 = TabSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = TabSpec();
        final spec2 = TabSpec(
          container: StyleSpec(
            spec: const FlexBoxSpec(),
            animation: AnimationConfig.linear(
              const Duration(milliseconds: 100),
            ),
          ),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props includes all relevant properties', () {
        const spec = TabSpec();

        expect(spec.props.length, equals(3));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.icon));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties includes all properties', () {
        const spec = TabSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties.any((p) => p.name == 'container'), isTrue);
        expect(properties.any((p) => p.name == 'label'), isTrue);
        expect(properties.any((p) => p.name == 'icon'), isTrue);
      });
    });
  });
}
