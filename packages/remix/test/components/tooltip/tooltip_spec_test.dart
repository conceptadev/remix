import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixTooltipSpec', () {
    group('Constructor', () {
      test('creates with default properties', () {
        const spec = RemixTooltipSpec();

        expect(spec.container, equals(const StyleSpec(spec: BoxSpec())));
        expect(spec.label, equals(const StyleSpec(spec: TextSpec())));
        expect(spec.waitDuration, equals(const Duration(milliseconds: 300)));
        expect(spec.showDuration, equals(const Duration(milliseconds: 1500)));
      });

      test('creates with provided properties', () {
        final container = StyleSpec(spec: const BoxSpec());
        final label = StyleSpec(spec: const TextSpec());
        const waitDuration = Duration(milliseconds: 500);
        const showDuration = Duration(milliseconds: 2000);

        final spec = RemixTooltipSpec(
          container: container,
          label: label,
          waitDuration: waitDuration,
          showDuration: showDuration,
        );

        expect(spec.container, equals(container));
        expect(spec.label, equals(label));
        expect(spec.waitDuration, equals(waitDuration));
        expect(spec.showDuration, equals(showDuration));
      });
    });

    group('copyWith', () {
      test('returns copy when no parameters provided', () {
        const spec = RemixTooltipSpec();
        final copy = spec.copyWith();

        expect(copy.container, equals(spec.container));
        expect(copy.label, equals(spec.label));
        expect(copy.waitDuration, equals(spec.waitDuration));
        expect(copy.showDuration, equals(spec.showDuration));
      });

      test('returns copy with new container', () {
        const spec = RemixTooltipSpec();
        final newContainer = StyleSpec(
          spec: const BoxSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(container: newContainer);

        expect(copy.container, equals(newContainer));
        expect(copy.container, isNot(equals(spec.container)));
        expect(copy.label, equals(spec.label));
      });

      test('returns copy with new durations', () {
        const spec = RemixTooltipSpec();

        final copy = spec.copyWith(
          waitDuration: const Duration(milliseconds: 600),
          showDuration: const Duration(milliseconds: 3000),
        );

        expect(copy.waitDuration, equals(const Duration(milliseconds: 600)));
        expect(copy.showDuration, equals(const Duration(milliseconds: 3000)));
        expect(copy.waitDuration, isNot(equals(spec.waitDuration)));
        expect(copy.showDuration, isNot(equals(spec.showDuration)));
      });
    });

    group('lerp', () {
      test('returns value equal to this when other is null', () {
        const spec = RemixTooltipSpec();
        final lerped = spec.lerp(null, 0.5);

        // Container and label should be equal
        expect(lerped.container, equals(spec.container));
        expect(lerped.label, equals(spec.label));
      });

      test('interpolates between two specs at t=0', () {
        const spec1 = RemixTooltipSpec();
        const spec2 = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 600),
          showDuration: Duration(milliseconds: 3000),
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result.waitDuration, equals(spec1.waitDuration));
        expect(result.showDuration, equals(spec1.showDuration));
      });

      test('interpolates between two specs at t=1', () {
        const spec1 = RemixTooltipSpec();
        const spec2 = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 600),
          showDuration: Duration(milliseconds: 3000),
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result.waitDuration, equals(spec2.waitDuration));
        expect(result.showDuration, equals(spec2.showDuration));
      });

      test('uses threshold interpolation for durations', () {
        const spec1 = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 300),
          showDuration: Duration(milliseconds: 1500),
        );
        const spec2 = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 600),
          showDuration: Duration(milliseconds: 3000),
        );

        final resultBelowThreshold = spec1.lerp(spec2, 0.4);
        expect(resultBelowThreshold.waitDuration, equals(spec1.waitDuration));
        expect(resultBelowThreshold.showDuration, equals(spec1.showDuration));

        final resultAboveThreshold = spec1.lerp(spec2, 0.6);
        expect(resultAboveThreshold.waitDuration, equals(spec2.waitDuration));
        expect(resultAboveThreshold.showDuration, equals(spec2.showDuration));
      });
    });

    group('Equality & Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixTooltipSpec();
        const spec2 = RemixTooltipSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixTooltipSpec();
        const spec2 = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 500),
        );

        expect(spec1, isNot(equals(spec2)));
      });

      test('props includes all relevant properties', () {
        const spec = RemixTooltipSpec();

        expect(spec.props.length, equals(6));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.label));
        expect(spec.props, contains(spec.waitDuration));
        expect(spec.props, contains(spec.showDuration));
        expect(spec.props, contains(spec.dismissDuration));
        expect(spec.props, contains(spec.arrowColor));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties includes all properties', () {
        const spec = RemixTooltipSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties.any((p) => p.name == 'container'), isTrue);
        expect(properties.any((p) => p.name == 'label'), isTrue);
        expect(properties.any((p) => p.name == 'waitDuration'), isTrue);
        expect(properties.any((p) => p.name == 'showDuration'), isTrue);
        expect(properties.any((p) => p.name == 'dismissDuration'), isTrue);
      });
    });

    group('Edge Cases', () {
      test('handles very short durations', () {
        const spec = RemixTooltipSpec(
          waitDuration: Duration(milliseconds: 1),
          showDuration: Duration(milliseconds: 1),
        );

        expect(spec.waitDuration, equals(const Duration(milliseconds: 1)));
        expect(spec.showDuration, equals(const Duration(milliseconds: 1)));
      });

      test('handles very long durations', () {
        const spec = RemixTooltipSpec(
          waitDuration: Duration(seconds: 60),
          showDuration: Duration(minutes: 5),
        );

        expect(spec.waitDuration, equals(const Duration(seconds: 60)));
        expect(spec.showDuration, equals(const Duration(minutes: 5)));
      });
    });
  });
}
