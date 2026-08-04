import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('SkeletonSpec', () {
    group('Constructor', () {
      test('defaults to an empty container and no pulse overrides', () {
        const spec = SkeletonSpec();

        expect(spec.container, const StyleSpec(spec: BoxSpec()));
        expect(spec.pulseColor, isNull);
        expect(spec.duration, isNull);
      });

      test('keeps the supplied values', () {
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(spec.container, _container);
        expect(spec.pulseColor, _pulseColor);
        expect(spec.duration, _leg);
      });
    });

    group('copyWith', () {
      test('replaces only the named fields', () {
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        final updated = spec.copyWith(duration: const Duration(seconds: 2));

        expect(updated, isNot(same(spec)));
        expect(updated.duration, const Duration(seconds: 2));
        expect(updated.container, _container);
        expect(updated.pulseColor, _pulseColor);
        expect(spec.duration, _leg);
      });

      test('null arguments keep the current values', () {
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        final updated = spec.copyWith();

        expect(updated.container, _container);
        expect(updated.pulseColor, _pulseColor);
        expect(updated.duration, _leg);
      });
    });

    group('lerp', () {
      test('keeps this at t=0 when other is null', () {
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(spec.lerp(null, 0.0), spec);
      });

      test('interpolates the container and pulse color', () {
        const other = SkeletonSpec(
          container: StyleSpec(
            spec: BoxSpec(
              constraints: BoxConstraints.tightFor(width: 40, height: 8),
            ),
          ),
          pulseColor: Color(0xFF000000),
        );
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
        );

        final result = spec.lerp(other, 0.5);

        expect(
          result.container.spec.constraints,
          BoxConstraints.lerp(
            _container.spec.constraints,
            other.container.spec.constraints,
            0.5,
          ),
        );
        expect(
          result.pulseColor,
          Color.lerp(_pulseColor, other.pulseColor, 0.5),
        );
      });

      test('resolves the endpoints exactly', () {
        const other = SkeletonSpec(
          pulseColor: Color(0xFF000000),
          duration: Duration(milliseconds: 400),
        );
        const spec = SkeletonSpec(pulseColor: _pulseColor, duration: _leg);

        expect(spec.lerp(other, 0.0).pulseColor, _pulseColor);
        expect(spec.lerp(other, 0.0).duration, _leg);
        expect(spec.lerp(other, 1.0).pulseColor, other.pulseColor);
        expect(spec.lerp(other, 1.0).duration, other.duration);
      });
    });

    group('Equality and props', () {
      test('specs with the same values are equal', () {
        const a = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );
        const b = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(a, b);
        expect(a.hashCode, b.hashCode);
      });

      test('every field participates in equality', () {
        const base = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(base, isNot(const SkeletonSpec(pulseColor: _pulseColor)));
        expect(
          base,
          isNot(
            const SkeletonSpec(
              container: _container,
              pulseColor: Color(0xFF000000),
              duration: _leg,
            ),
          ),
        );
        expect(
          base,
          isNot(
            const SkeletonSpec(
              container: _container,
              pulseColor: _pulseColor,
              duration: Duration(milliseconds: 400),
            ),
          ),
        );
      });

      test('props exposes container, pulseColor, and duration', () {
        const spec = SkeletonSpec(
          container: _container,
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(spec.props, hasLength(3));
        expect(
          spec.props,
          containsAll(<Object?>[_container, _pulseColor, _leg]),
        );
      });
    });

    group('Diagnostics', () {
      test('fills properties without throwing', () {
        const spec = SkeletonSpec();

        expect(
          () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
          returnsNormally,
        );
        expect(spec.toString(), isNotEmpty);
      });
    });

    group('Expressiveness', () {
      // The plan's acceptance bar: every documented placeholder shape must be
      // reachable through the container alone, with no extra widget flags.
      testWidgets('the container expresses every placeholder shape', (
        tester,
      ) async {
        late Map<String, SkeletonSpec> specs;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                specs = {
                  'rectangle': SkeletonStyler()
                      .size(120, 24)
                      .borderRounded(4)
                      .resolve(context)
                      .spec,
                  'circle': SkeletonStyler()
                      .size(40, 40)
                      .shapeCircle()
                      .resolve(context)
                      .spec,
                  'textLine': SkeletonStyler()
                      .height(12)
                      .maxWidth(200)
                      .resolve(context)
                      .spec,
                  'childSized': SkeletonStyler()
                      .color(const Color(0xFFEEEEEE))
                      .resolve(context)
                      .spec,
                };

                return const SizedBox.shrink();
              },
            ),
          ),
        );

        final rectangle = specs['rectangle']!.container.spec;
        expect(
          rectangle.constraints,
          const BoxConstraints.tightFor(width: 120, height: 24),
        );
        expect(
          (rectangle.decoration! as BoxDecoration).borderRadius,
          BorderRadius.circular(4),
        );

        expect(
          specs['circle']!.container.spec.decoration,
          isA<ShapeDecoration>(),
        );

        expect(
          specs['textLine']!.container.spec.constraints,
          const BoxConstraints(minHeight: 12, maxHeight: 12, maxWidth: 200),
        );

        // A child-sized placeholder needs no geometry at all.
        expect(specs['childSized']!.container.spec.constraints, isNull);
        expect(
          (specs['childSized']!.container.spec.decoration! as BoxDecoration)
              .color,
          const Color(0xFFEEEEEE),
        );
      });
    });
  });
}

const _leg = Duration(milliseconds: 1000);
const _pulseColor = Color(0xFFCCCCCC);
const _container = StyleSpec(
  spec: BoxSpec(constraints: BoxConstraints.tightFor(width: 120, height: 24)),
);
