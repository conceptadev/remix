import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('ProgressStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = ProgressStyler();

        expect(style, isNotNull);
        expect(style, isA<ProgressStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final track = Prop.maybeMix(BoxStyler());
        final indicator = Prop.maybeMix(BoxStyler());
        final trackContainer = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<ProgressSpec>>[];

        final style = ProgressStyler.create(
          container: container,
          track: track,
          indicator: indicator,
          trackContainer: trackContainer,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$track, equals(track));
        expect(style.$indicator, equals(indicator));
        expect(style.$trackContainer, equals(trackContainer));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();
        final trackStyler = BoxStyler();
        final indicatorStyler = BoxStyler();
        final trackContainerStyler = BoxStyler();

        final style = ProgressStyler(
          container: containerStyler,
          track: trackStyler,
          indicator: indicatorStyler,
          trackContainer: trackContainerStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$track, isNotNull);
        expect(style.$indicator, isNotNull);
        expect(style.$trackContainer, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'height',
        initial: ProgressStyler(),
        modify: (style) => style.height(20.0),
        expect: (style) {
          expect(style, equals(ProgressStyler.height(20.0)));
        },
      );

      styleMethodTest(
        'width',
        initial: ProgressStyler(),
        modify: (style) => style.width(200.0),
        expect: (style) {
          expect(style, equals(ProgressStyler.width(200.0)));
        },
      );

      styleMethodTest(
        'trackColor',
        initial: ProgressStyler(),
        modify: (style) => style.trackColor(Colors.grey),
        expect: (style) {
          expect(
            style.$track,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'indicatorColor',
        initial: ProgressStyler(),
        modify: (style) => style.indicatorColor(Colors.blue),
        expect: (style) {
          expect(
            style.$indicator,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'track',
        initial: ProgressStyler(),
        modify: (style) => style.track(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.red)),
        ),
        expect: (style) {
          expect(
            style.$track,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.red)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'indicator',
        initial: ProgressStyler(),
        modify: (style) => style.indicator(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
        ),
        expect: (style) {
          expect(
            style.$indicator,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'trackContainer',
        initial: ProgressStyler(),
        modify: (style) => style.trackContainer(
          BoxStyler(padding: EdgeInsetsGeometryMix.all(4.0)),
        ),
        expect: (style) {
          expect(
            style.$trackContainer,
            equals(
              Prop.maybeMix(BoxStyler(padding: EdgeInsetsGeometryMix.all(4.0))),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: ProgressStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(ProgressStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding',
        initial: ProgressStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(ProgressStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: ProgressStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(ProgressStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: ProgressStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ProgressStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: ProgressStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.blue,
            borderRadius: BorderRadiusMix.circular(8.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ProgressStyler.decoration(
                BoxDecorationMix(
                  color: Colors.blue,
                  borderRadius: BorderRadiusMix.circular(8.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: ProgressStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ProgressStyler.foregroundDecoration(
                BoxDecorationMix(
                  border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform',
        initial: ProgressStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              ProgressStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: ProgressStyler(),
        modify: (style) => style.variants(<VariantStyle<ProgressSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<ProgressSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: ProgressStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = ProgressStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<ProgressSpec>>());
                expect(spec.spec, isA<ProgressSpec>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.track, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.indicator, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.trackContainer, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = ProgressStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = ProgressStyler();
        final style2 = ProgressStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = ProgressStyler().height(10.0);
        final style2 = ProgressStyler().height(20.0);

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
