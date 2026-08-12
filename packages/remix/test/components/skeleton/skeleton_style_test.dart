import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('SkeletonStyler', () {
    group('Constructors', () {
      test('the fluent constructor stores every prop', () {
        final style = SkeletonStyler(
          container: BoxStyler().width(120),
          pulseColor: _pulseColor,
          duration: _leg,
        );

        expect(style.$container, isNotNull);
        expect(style.$pulseColor, Prop.maybe(_pulseColor));
        expect(style.$duration, Prop.maybe(_leg));
      });

      test('the create constructor takes raw props', () {
        final container = Prop.maybeMix(BoxStyler().width(120));
        final pulseColor = Prop.maybe(_pulseColor);
        final duration = Prop.maybe(_leg);
        final variants = <VariantStyle<SkeletonSpec>>[];

        final style = SkeletonStyler.create(
          container: container,
          pulseColor: pulseColor,
          duration: duration,
          variants: variants,
        );

        expect(style.$container, container);
        expect(style.$pulseColor, pulseColor);
        expect(style.$duration, duration);
        expect(style.$variants, variants);
      });
    });

    group('Style methods', () {
      styleMethodTest(
        'pulseColor',
        initial: SkeletonStyler(),
        modify: (style) => style.pulseColor(_pulseColor),
        expect: (style) {
          expect(style.$pulseColor, Prop.maybe(_pulseColor));
        },
      );

      styleMethodTest(
        'duration',
        initial: SkeletonStyler(),
        modify: (style) => style.duration(_leg),
        expect: (style) {
          expect(style.$duration, Prop.maybe(_leg));
        },
      );

      styleMethodTest(
        'container',
        initial: SkeletonStyler(),
        modify: (style) => style.container(BoxStyler().width(120)),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );

      styleMethodTest(
        'variants',
        initial: SkeletonStyler(),
        modify: (style) => style.variants(<VariantStyle<SkeletonSpec>>[]),
        expect: (style) {
          expect(style.$variants, <VariantStyle<SkeletonSpec>>[]);
        },
      );

      styleMethodTest(
        'animate',
        initial: SkeletonStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(const Duration(seconds: 1))),
        expect: (style) {
          expect(
            style.$animation,
            AnimationConfig.linear(const Duration(seconds: 1)),
          );
        },
      );

      styleMethodTest(
        'wrap',
        initial: SkeletonStyler(),
        modify: (style) => style.wrap(.opacity(0.5)),
        expect: (style) {
          expect(style.$modifier, WidgetModifierConfig.opacity(0.5));
        },
      );
    });

    group('Nested container surface', () {
      testWidgets('Box styling resolves through the container styler', (
        tester,
      ) async {
        late SkeletonSpec spec;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                spec = SkeletonStyler()
                    .container(
                      BoxStyler()
                          .size(120, 24)
                          .color(_baseColor)
                          .borderRadius(.circular(4))
                          .padding(.all(2)),
                    )
                    .resolve(context)
                    .spec;

                return const SizedBox.shrink();
              },
            ),
          ),
        );

        final box = spec.container.spec;
        final decoration = box.decoration! as BoxDecoration;

        expect(
          box.constraints,
          const BoxConstraints.tightFor(width: 120, height: 24),
        );
        expect(box.padding, const EdgeInsets.all(2));
        expect(decoration.color, _baseColor);
        expect(decoration.borderRadius, BorderRadius.circular(4));
      });

      testWidgets('nested container styles merge instead of replacing', (
        tester,
      ) async {
        late SkeletonSpec spec;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                spec = SkeletonStyler()
                    .container(BoxStyler().color(_baseColor))
                    .container(BoxStyler().borderRadius(.circular(4)))
                    .resolve(context)
                    .spec;

                return const SizedBox.shrink();
              },
            ),
          ),
        );

        final decoration = spec.container.spec.decoration! as BoxDecoration;

        expect(decoration.color, _baseColor);
        expect(decoration.borderRadius, BorderRadius.circular(4));
      });

      test('does not expose misleading direct Box methods', () {
        final dynamic style = SkeletonStyler();

        expect(
          () => style.alignment(Alignment.center),
          throwsA(isA<NoSuchMethodError>()),
        );
        expect(
          () => style.clipBehavior(Clip.hardEdge),
          throwsA(isA<NoSuchMethodError>()),
        );
        expect(
          () => style.textStyle(TextStyler()),
          throwsA(isA<NoSuchMethodError>()),
        );
      });
    });

    group('Core methods', () {
      testWidgets('resolve returns a SkeletonSpec', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final resolved = SkeletonStyler().resolve(context);

                expect(resolved, isA<StyleSpec<SkeletonSpec>>());
                expect(resolved.spec, isA<SkeletonSpec>());

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      test('merging with null returns an equal style', () {
        final style = SkeletonStyler().pulseColor(_pulseColor);

        expect(style.merge(null), style);
      });

      test('merge combines disjoint props', () {
        final merged = SkeletonStyler()
            .pulseColor(_pulseColor)
            .merge(SkeletonStyler().duration(_leg));

        expect(merged.$pulseColor, Prop.maybe(_pulseColor));
        expect(merged.$duration, Prop.maybe(_leg));
      });

      testWidgets('later values win on merge', (tester) async {
        const other = Color(0xFF000000);
        late SkeletonSpec spec;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                spec = SkeletonStyler()
                    .pulseColor(_pulseColor)
                    .merge(SkeletonStyler().pulseColor(other))
                    .resolve(context)
                    .spec;

                return const SizedBox.shrink();
              },
            ),
          ),
        );

        expect(spec.pulseColor, other);
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        expect(SkeletonStyler(), SkeletonStyler());
        expect(SkeletonStyler().hashCode, SkeletonStyler().hashCode);
      });

      test('different styles are not equal', () {
        expect(
          SkeletonStyler().duration(_leg),
          isNot(SkeletonStyler().duration(const Duration(milliseconds: 400))),
        );
      });

      test('props exposes every stored value', () {
        final style = SkeletonStyler();

        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$pulseColor));
        expect(style.props, contains(style.$duration));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Call method', () {
      test('forwards key, child, loading, and style to RemixSkeleton', () {
        final key = UniqueKey();
        const child = Text('Ready');
        final style = SkeletonStyler().pulseColor(_pulseColor);
        final skeleton = style(key: key, child: child, loading: false);

        expect(skeleton, isA<RemixSkeleton>());
        expect(skeleton.key, same(key));
        expect(skeleton.style, style);
        expect(skeleton.loading, isFalse);
        expect(skeleton.child, same(child));
      });
    });

    group('Raw styleSpec', () {
      testWidgets('bypasses the styler entirely', (tester) async {
        await tester.pumpRemixApp(
          RemixSkeleton(
            style: SkeletonStyler().container(BoxStyler().size(300, 300)),
            styleSpec: const StyleSpec(
              spec: SkeletonSpec(
                container: StyleSpec(
                  spec: BoxSpec(
                    constraints: BoxConstraints.tightFor(width: 64, height: 16),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(tester.getSize(find.byType(RemixSkeleton)), const Size(64, 16));
      });
    });
  });
}

const _leg = Duration(milliseconds: 1000);
const _baseColor = Color(0xFFEEEEEE);
const _pulseColor = Color(0xFFCCCCCC);
