import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RadioStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RadioStyler();

        expect(style, isNotNull);
        expect(style, isA<RadioStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final indicator = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<RadioSpec>>[];

        final style = RadioStyler.create(
          container: container,
          indicator: indicator,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$indicator, equals(indicator));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();
        final indicatorStyler = BoxStyler();

        final style = RadioStyler(
          container: containerStyler,
          indicator: indicatorStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$indicator, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'indicator',
        initial: RadioStyler(),
        modify: (style) => style.indicator(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
        ),
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
        'alignment',
        initial: RadioStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(RadioStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding',
        initial: RadioStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(RadioStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: RadioStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(RadioStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'fillColor',
        initial: RadioStyler(),
        modify: (style) => style.fillColor(Colors.blue),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size',
        initial: RadioStyler(),
        modify: (style) => style.size(24.0, 24.0),
        expect: (style) {
          expect(style, equals(RadioStyler.size(24.0, 24.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: RadioStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(RadioStyler.borderRadius(BorderRadiusMix.circular(12.0))),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: RadioStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RadioStyler.constraints(
                BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: RadioStyler(),
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
              RadioStyler.decoration(
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
        initial: RadioStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RadioStyler.foregroundDecoration(
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
        initial: RadioStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              RadioStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: RadioStyler(),
        modify: (style) => style.variants(<VariantStyle<RadioSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RadioSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: RadioStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixRadio with required parameters', () {
        final style = RadioStyler();

        final radio = style.call<String>(value: 'option1');

        expect(radio, isA<RemixRadio<String>>());
        expect(radio.value, equals('option1'));
        expect(radio.enabled, isTrue);
        expect(radio.autofocus, isFalse);
        expect(radio.toggleable, isFalse);
      });

      test('call method creates RemixRadio with all parameters', () {
        final style = RadioStyler();
        final focusNode = FocusNode();

        final radio = style.call<int>(
          value: 42,
          enabled: false,
          autofocus: true,
          toggleable: true,
          focusNode: focusNode,
          mouseCursor: SystemMouseCursors.click,
        );

        expect(radio, isA<RemixRadio<int>>());
        expect(radio.value, equals(42));
        expect(radio.enabled, isFalse);
        expect(radio.autofocus, isTrue);
        expect(radio.toggleable, isTrue);
        expect(radio.focusNode, equals(focusNode));
        expect(radio.mouseCursor, equals(SystemMouseCursors.click));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = RadioStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RadioSpec>>());
                expect(spec.spec, isA<RadioSpec>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.indicator, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = RadioStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RadioStyler();
        final style2 = RadioStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RadioStyler().size(20.0, 20.0);
        final style2 = RadioStyler().size(24.0, 24.0);

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
