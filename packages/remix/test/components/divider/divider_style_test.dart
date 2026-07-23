import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixDividerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixDividerStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixDividerStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final thickness = Prop.maybe(2.0);
        final variants = <VariantStyle<RemixDividerSpec>>[];

        final style = RemixDividerStyler.create(
          container: container,
          thickness: thickness,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$thickness, equals(thickness));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();

        final style = RemixDividerStyler(container: containerStyler);

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'color',
        initial: RemixDividerStyler(),
        modify: (style) => style.color(Colors.red),
        expect: (style) {
          expect(style, equals(RemixDividerStyler.color(Colors.red)));
        },
      );

      styleMethodTest(
        'thickness',
        initial: RemixDividerStyler(),
        modify: (style) => style.thickness(2.0),
        expect: (style) {
          expect(style.$thickness, equals(Prop.maybe(2.0)));
          expect(style.$container, isNull);
        },
      );

      styleMethodTest(
        'padding',
        initial: RemixDividerStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixDividerStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: RemixDividerStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixDividerStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: RemixDividerStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(RemixDividerStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'decoration',
        initial: RemixDividerStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.blue,
            borderRadius: BorderRadiusMix.circular(4.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDividerStyler.decoration(
                BoxDecorationMix(
                  color: Colors.blue,
                  borderRadius: BorderRadiusMix.circular(4.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: RemixDividerStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 1.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDividerStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 1.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: RemixDividerStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.black)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDividerStyler.foregroundDecoration(
                BoxDecorationMix(
                  border: BoxBorderMix.all(BorderSideMix(color: Colors.black)),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform',
        initial: RemixDividerStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topCenter),
        expect: (style) {
          expect(
            style,
            equals(
              RemixDividerStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topCenter,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'wrap',
        initial: RemixDividerStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'variants',
        initial: RemixDividerStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixDividerSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixDividerSpec>>[]));
        },
      );

      styleMethodTest(
        'animate',
        initial: RemixDividerStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(milliseconds: 300))),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = RemixDividerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixDividerSpec>>());
                expect(spec.spec, isA<RemixDividerSpec>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = RemixDividerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines two styles', () {
        final style1 = RemixDividerStyler().color(Colors.red);
        final style2 = RemixDividerStyler().thickness(2.0);

        final merged = style1.merge(style2);

        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged.$container, isNotNull);
        expect(merged.$thickness, equals(style2.$thickness));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RemixDividerStyler();
        final style2 = RemixDividerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixDividerStyler().color(Colors.red);
        final style2 = RemixDividerStyler().color(Colors.blue);

        expect(style1, isNot(equals(style2)));
      });
    });

    group('Props', () {
      test('props list contains all properties', () {
        final style = RemixDividerStyler();

        expect(style.props, hasLength(5));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$thickness));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Chaining', () {
      test('multiple style methods can be chained', () {
        final style = RemixDividerStyler()
            .color(Colors.grey)
            .thickness(1.0)
            .margin(EdgeInsetsGeometryMix.symmetric(vertical: 8.0));

        expect(style, isA<RemixDividerStyler>());
        expect(style.$container, isNotNull);
        expect(style.$thickness, isNotNull);
      });
    });
  });
}
