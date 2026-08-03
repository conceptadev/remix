import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('SpinnerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SpinnerStyler();

        expect(style, isNotNull);
        expect(style, isA<SpinnerStyler>());
      });

      test('create constructor with all parameters', () {
        final size = Prop.maybe(24.0);
        final strokeWidth = Prop.maybe(2.0);
        final indicatorColor = Prop.maybe(const Color(0xFF0000FF));
        final trackColor = Prop.maybe(const Color(0xFFCCCCCC));
        final trackStrokeWidth = Prop.maybe(1.0);
        final duration = Prop.maybe(const Duration(milliseconds: 1000));
        final variants = <VariantStyle<SpinnerSpec>>[];

        final style = SpinnerStyler.create(
          size: size,
          strokeWidth: strokeWidth,
          indicatorColor: indicatorColor,
          trackColor: trackColor,
          trackStrokeWidth: trackStrokeWidth,
          duration: duration,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$size, equals(size));
        expect(style.$strokeWidth, equals(strokeWidth));
        expect(style.$indicatorColor, equals(indicatorColor));
        expect(style.$trackColor, equals(trackColor));
        expect(style.$trackStrokeWidth, equals(trackStrokeWidth));
        expect(style.$duration, equals(duration));
        expect(style.$variants, equals(variants));
      });

      test('constructor with direct parameters', () {
        final style = SpinnerStyler(
          size: 24.0,
          strokeWidth: 2.0,
          indicatorColor: const Color(0xFF0000FF),
          trackColor: const Color(0xFFCCCCCC),
          trackStrokeWidth: 1.0,
          duration: const Duration(milliseconds: 1000),
        );

        expect(style, isNotNull);
        expect(style.$size, isNotNull);
        expect(style.$strokeWidth, isNotNull);
        expect(style.$indicatorColor, isNotNull);
        expect(style.$trackColor, isNotNull);
        expect(style.$trackStrokeWidth, isNotNull);
        expect(style.$duration, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'size',
        initial: SpinnerStyler(),
        modify: (style) => style.size(32.0),
        expect: (style) {
          expect(style.$size, equals(Prop.maybe(32.0)));
        },
      );

      styleMethodTest(
        'strokeWidth',
        initial: SpinnerStyler(),
        modify: (style) => style.strokeWidth(3.0),
        expect: (style) {
          expect(style.$strokeWidth, equals(Prop.maybe(3.0)));
        },
      );

      styleMethodTest(
        'indicatorColor',
        initial: SpinnerStyler(),
        modify: (style) => style.indicatorColor(const Color(0xFF0000FF)),
        expect: (style) {
          expect(
            style.$indicatorColor,
            equals(Prop.maybe(const Color(0xFF0000FF))),
          );
        },
      );

      styleMethodTest(
        'trackColor',
        initial: SpinnerStyler(),
        modify: (style) => style.trackColor(const Color(0xFFCCCCCC)),
        expect: (style) {
          expect(
            style.$trackColor,
            equals(Prop.maybe(const Color(0xFFCCCCCC))),
          );
        },
      );

      styleMethodTest(
        'trackStrokeWidth',
        initial: SpinnerStyler(),
        modify: (style) => style.trackStrokeWidth(2.0),
        expect: (style) {
          expect(style.$trackStrokeWidth, equals(Prop.maybe(2.0)));
        },
      );

      styleMethodTest(
        'duration',
        initial: SpinnerStyler(),
        modify: (style) => style.duration(const Duration(milliseconds: 500)),
        expect: (style) {
          expect(
            style.$duration,
            equals(Prop.maybe(const Duration(milliseconds: 500))),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: SpinnerStyler(),
        modify: (style) => style.variants(<VariantStyle<SpinnerSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<SpinnerSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: SpinnerStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: SpinnerStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(const Duration(seconds: 1))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(seconds: 1))),
          );
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixSpinner', () {
        final style = SpinnerStyler();
        final spinner = style.call();

        expect(spinner, isA<RemixSpinner>());
        expect(spinner.style, equals(style));
      });

      test('call method with customized style creates RemixSpinner', () {
        final style = SpinnerStyler(
          size: 32.0,
          indicatorColor: const Color(0xFF0000FF),
        );
        final spinner = style.call();

        expect(spinner, isA<RemixSpinner>());
        expect(spinner.style, equals(style));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SpinnerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SpinnerSpec>>());
                expect(spec.spec, isA<SpinnerSpec>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = SpinnerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines properties correctly', () {
        final style1 = SpinnerStyler(size: 24.0);
        final style2 = SpinnerStyler(strokeWidth: 2.0);

        final merged = style1.merge(style2);

        expect(merged.$size, equals(Prop.maybe(24.0)));
        expect(merged.$strokeWidth, equals(Prop.maybe(2.0)));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SpinnerStyler();
        final style2 = SpinnerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SpinnerStyler().size(24.0);
        final style2 = SpinnerStyler().size(32.0);

        expect(style1, isNot(equals(style2)));
      });

      test('props list contains all properties', () {
        final style = SpinnerStyler();

        expect(style.props, hasLength(12));
        expect(style.props, contains(style.$size));
        expect(style.props, contains(style.$strokeWidth));
        expect(style.props, contains(style.$indicatorColor));
        expect(style.props, contains(style.$trackColor));
        expect(style.props, contains(style.$trackStrokeWidth));
        expect(style.props, contains(style.$duration));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });
  });
}
