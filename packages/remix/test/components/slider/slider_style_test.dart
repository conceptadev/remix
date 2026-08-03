import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('SliderStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SliderStyler();

        expect(style, isNotNull);
        expect(style, isA<SliderStyler>());
      });

      test('create constructor with all parameters', () {
        final thumb = Prop.maybeMix(BoxStyler());
        final trackColor = Prop.value(Colors.blue);
        final trackWidth = Prop.value(8.0);
        final rangeColor = Prop.value(Colors.red);
        final rangeWidth = Prop.value(4.0);
        final variants = <VariantStyle<SliderSpec>>[];

        final style = SliderStyler.create(
          thumb: thumb,
          trackColor: trackColor,
          trackWidth: trackWidth,
          rangeColor: rangeColor,
          rangeWidth: rangeWidth,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$thumb, equals(thumb));
        expect(style.$trackColor, equals(trackColor));
        expect(style.$trackWidth, equals(trackWidth));
        expect(style.$rangeColor, equals(rangeColor));
        expect(style.$rangeWidth, equals(rangeWidth));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final thumbStyler = BoxStyler();

        final style = SliderStyler(
          thumb: thumbStyler,
          trackColor: Colors.blue,
          trackWidth: 10.0,
          rangeColor: Colors.red,
          rangeWidth: 5.0,
        );

        expect(style, isNotNull);
        expect(style.$thumb, isNotNull);
        expect(style.$trackColor, isNotNull);
        expect(style.$trackWidth, isNotNull);
        expect(style.$rangeColor, isNotNull);
        expect(style.$rangeWidth, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'thumbColor',
        initial: SliderStyler(),
        modify: (style) => style.thumbColor(Colors.blue),
        expect: (style) {
          expect(
            style.$thumb,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'trackColor',
        initial: SliderStyler(),
        modify: (style) => style.trackColor(const Color(0xFF0000FF)),
        expect: (style) {
          expect(
            style,
            equals(SliderStyler.trackColor(const Color(0xFF0000FF))),
          );
        },
      );

      styleMethodTest(
        'rangeColor',
        initial: SliderStyler(),
        modify: (style) => style.rangeColor(const Color(0xFFFF0000)),
        expect: (style) {
          expect(
            style,
            equals(SliderStyler.rangeColor(const Color(0xFFFF0000))),
          );
        },
      );

      styleMethodTest(
        'thumb',
        initial: SliderStyler(),
        modify: (style) => style.thumb(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SliderStyler.thumb(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'thumbSize',
        initial: SliderStyler(),
        modify: (style) => style.thumbSize(const Size(20.0, 20.0)),
        expect: (style) {
          expect(
            style.$thumb,
            equals(
              Prop.maybeMix(
                BoxStyler(
                  constraints: BoxConstraintsMix.size(const Size(20.0, 20.0)),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: SliderStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(SliderStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'thickness',
        initial: SliderStyler(),
        modify: (style) => style.thickness(12.0),
        expect: (style) {
          expect(style.$trackWidth, equals(Prop.value(12.0)));
          expect(style.$rangeWidth, equals(Prop.value(12.0)));
        },
      );

      styleMethodTest(
        'trackThickness',
        initial: SliderStyler(),
        modify: (style) => style.trackThickness(10.0),
        expect: (style) {
          expect(style.$trackWidth, equals(Prop.value(10.0)));
        },
      );

      styleMethodTest(
        'rangeThickness',
        initial: SliderStyler(),
        modify: (style) => style.rangeThickness(8.0),
        expect: (style) {
          expect(style.$rangeWidth, equals(Prop.value(8.0)));
        },
      );

      styleMethodTest(
        'padding',
        initial: SliderStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(SliderStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: SliderStyler(),
        modify: (style) => style.color(Colors.purple),
        expect: (style) {
          expect(style, equals(SliderStyler.color(Colors.purple)));
        },
      );

      styleMethodTest(
        'size',
        initial: SliderStyler(),
        modify: (style) => style.size(24.0, 24.0),
        expect: (style) {
          expect(style, equals(SliderStyler.size(24.0, 24.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: SliderStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(SliderStyler.borderRadius(BorderRadiusMix.circular(12.0))),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: SliderStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SliderStyler.constraints(
                BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: SliderStyler(),
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
              SliderStyler.decoration(
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
        'margin',
        initial: SliderStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(SliderStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: SliderStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SliderStyler.foregroundDecoration(
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
        initial: SliderStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              SliderStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: SliderStyler(),
        modify: (style) => style.variants(<VariantStyle<SliderSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<SliderSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: SliderStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: SliderStyler(),
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

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SliderStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SliderSpec>>());
                expect(spec.spec, isA<SliderSpec>());
                expect(spec.spec.thumb, isA<StyleSpec<BoxSpec>?>());
                expect(spec.spec.trackColor, isA<Color?>());
                expect(spec.spec.trackWidth, isA<double?>());
                expect(spec.spec.rangeColor, isA<Color?>());
                expect(spec.spec.rangeWidth, isA<double?>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = SliderStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Call Method', () {
      testWidgets('call method creates RemixSlider with all parameters', (
        tester,
      ) async {
        final style = SliderStyler().thumbColor(Colors.blue);
        final focusNode = FocusNode();

        final slider = style.call(
          value: 0.5,
          onChanged: (value) {},
          min: 0.0,
          max: 100.0,
          onChangeStart: (value) {},
          onChangeEnd: (value) {},
          enabled: false,
          enableFeedback: false,
          focusNode: focusNode,
          autofocus: true,
          snapDivisions: 10,
        );

        expect(slider, isA<RemixSlider>());
        expect(slider.value, equals(0.5));
        expect(slider.min, equals(0.0));
        expect(slider.max, equals(100.0));
        expect(slider.enabled, equals(false));
        expect(slider.enableFeedback, equals(false));
        expect(slider.focusNode, same(focusNode));
        expect(slider.autofocus, equals(true));
        expect(slider.snapDivisions, equals(10));
        expect(slider.style, same(style));

        focusNode.dispose();
      });

      testWidgets('call method creates RemixSlider with minimal parameters', (
        tester,
      ) async {
        final style = SliderStyler();

        final slider = style.call(value: 0.3, onChanged: (v) {});

        expect(slider, isA<RemixSlider>());
        expect(slider.value, equals(0.3));
        expect(slider.min, equals(0.0));
        expect(slider.max, equals(1.0));
        expect(slider.enabled, equals(true));
        expect(slider.style, same(style));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SliderStyler();
        final style2 = SliderStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SliderStyler().trackColor(Colors.blue);
        final style2 = SliderStyler().trackColor(Colors.red);

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
