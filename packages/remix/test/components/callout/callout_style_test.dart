import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('CalloutStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = CalloutStyler.create();
        expect(style, isNotNull);
        expect(style, isA<CalloutStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final text = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());

        final style = CalloutStyler.create(
          container: container,
          text: text,
          icon: icon,
        );

        expect(style, isNotNull);
        expect(style, isA<CalloutStyler>());
      });

      test('constructor with styler parameters', () {
        final style = CalloutStyler(
          container: FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(16.0)),
          text: TextStyler(style: TextStyleMix(color: Colors.blue)),
          icon: IconStyler(color: Colors.green),
        );

        expect(style, isNotNull);
        expect(style, isA<CalloutStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'padding sets container padding',
        initial: CalloutStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(20.0)),
        expect: (style) {
          expect(
            style,
            equals(CalloutStyler.padding(EdgeInsetsGeometryMix.all(20.0))),
          );
        },
      );

      styleMethodTest(
        'icon sets icon styler',
        initial: CalloutStyler(),
        modify: (style) => style.icon(IconStyler(color: Colors.red)),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.red))),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: CalloutStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(CalloutStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'backgroundColor sets container background color',
        initial: CalloutStyler(),
        modify: (style) => style.backgroundColor(Colors.yellow),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                FlexBoxStyler(
                  decoration: BoxDecorationMix(color: Colors.yellow),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundColor sets both icon and text color',
        initial: CalloutStyler(),
        modify: (style) => style.foregroundColor(Colors.red),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.red))),
          );
          expect(
            style.$text,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(color: Colors.red))),
            ),
          );
        },
      );

      styleMethodTest(
        'shape sets container shape decoration',
        initial: CalloutStyler(),
        modify: (style) => style.shape(
          RoundedRectangleBorderMix(
            borderRadius: BorderRadiusGeometryMix.circular(16.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CalloutStyler.shape(
                RoundedRectangleBorderMix(
                  borderRadius: BorderRadiusGeometryMix.circular(16.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'borderRadius sets container border radius',
        initial: CalloutStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              CalloutStyler.borderRadius(
                BorderRadiusGeometryMix.circular(12.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: CalloutStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.purple,
            borderRadius: BorderRadiusGeometryMix.circular(8.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CalloutStyler.decoration(
                BoxDecorationMix(
                  color: Colors.purple,
                  borderRadius: BorderRadiusGeometryMix.circular(8.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment sets container alignment',
        initial: CalloutStyler(),
        modify: (style) => style.alignment(Alignment.centerRight),
        expect: (style) {
          expect(style, equals(CalloutStyler.alignment(Alignment.centerRight)));
        },
      );

      styleMethodTest(
        'spacing sets flex spacing',
        initial: CalloutStyler(),
        modify: (style) => style.spacing(16.0),
        expect: (style) {
          expect(style, equals(CalloutStyler.spacing(16.0)));
        },
      );

      styleMethodTest(
        'iconColor sets icon color',
        initial: CalloutStyler(),
        modify: (style) => style.iconColor(Colors.orange),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.orange))),
          );
        },
      );

      styleMethodTest(
        'textColor sets text color',
        initial: CalloutStyler(),
        modify: (style) => style.textColor(Colors.indigo),
        expect: (style) {
          expect(
            style.$text,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.indigo)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants sets variant styles',
        initial: CalloutStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: CalloutStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: CalloutStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(Duration(milliseconds: 300))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(Duration(milliseconds: 300))),
          );
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: CalloutStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 200.0, minHeight: 50.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CalloutStyler.constraints(
                BoxConstraintsMix(minWidth: 200.0, minHeight: 50.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: CalloutStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.cyan.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              CalloutStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.cyan.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: CalloutStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.2)),
        expect: (style) {
          expect(
            style,
            equals(CalloutStyler.transform(Matrix4.rotationZ(0.2))),
          );
        },
      );

      styleMethodTest(
        'flex sets flex styler',
        initial: CalloutStyler(),
        modify: (style) => style.flex(
          FlexStyler(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                FlexBoxStyler().flex(
                  FlexStyler(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = CalloutStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<CalloutSpec>>());
                expect(spec.spec, isA<CalloutSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = CalloutStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = CalloutStyler.create();
        final style2 = CalloutStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<CalloutStyler>());
      });

      test('props list contains all properties', () {
        const style = CalloutStyler.create();
        expect(style.props, hasLength(7));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$text));
        expect(style.props, contains(style.$icon));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = CalloutStyler.create();
        const style2 = CalloutStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = CalloutStyler.create();
        final style2 = CalloutStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = CalloutStyler();
        final style2 = CalloutStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
