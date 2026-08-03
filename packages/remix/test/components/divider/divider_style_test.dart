import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('DividerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = DividerStyler();

        expect(style, isNotNull);
        expect(style, isA<DividerStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<DividerSpec>>[];

        final style = DividerStyler.create(
          container: container,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();

        final style = DividerStyler(container: containerStyler);

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'color',
        initial: DividerStyler(),
        modify: (style) => style.color(Colors.red),
        expect: (style) {
          expect(style, equals(DividerStyler.color(Colors.red)));
        },
      );

      styleMethodTest(
        'thickness',
        initial: DividerStyler(),
        modify: (style) => style.thickness(2.0),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(
                  constraints: BoxConstraintsMix(
                    minHeight: 2.0,
                    maxHeight: 2.0,
                  ),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: DividerStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(DividerStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: DividerStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(DividerStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: DividerStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(DividerStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'decoration',
        initial: DividerStyler(),
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
              DividerStyler.decoration(
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
        initial: DividerStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 1.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              DividerStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 1.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: DividerStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.black)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              DividerStyler.foregroundDecoration(
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
        initial: DividerStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topCenter),
        expect: (style) {
          expect(
            style,
            equals(
              DividerStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topCenter,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'wrap',
        initial: DividerStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'variants',
        initial: DividerStyler(),
        modify: (style) => style.variants(<VariantStyle<DividerSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<DividerSpec>>[]));
        },
      );

      styleMethodTest(
        'animate',
        initial: DividerStyler(),
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
        final style = DividerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<DividerSpec>>());
                expect(spec.spec, isA<DividerSpec>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = DividerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines two styles', () {
        final style1 = DividerStyler().color(Colors.red);
        final style2 = DividerStyler().thickness(2.0);

        final merged = style1.merge(style2);

        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged.$container, isNotNull);
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = DividerStyler();
        final style2 = DividerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = DividerStyler().color(Colors.red);
        final style2 = DividerStyler().color(Colors.blue);

        expect(style1, isNot(equals(style2)));
      });
    });

    group('Props', () {
      test('props list contains all properties', () {
        final style = DividerStyler();

        expect(style.props, hasLength(4));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Chaining', () {
      test('multiple style methods can be chained', () {
        final style = DividerStyler()
            .color(Colors.grey)
            .thickness(1.0)
            .margin(EdgeInsetsGeometryMix.symmetric(vertical: 8.0));

        expect(style, isA<DividerStyler>());
        expect(style.$container, isNotNull);
      });
    });
  });
}
