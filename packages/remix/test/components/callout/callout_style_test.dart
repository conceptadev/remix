import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixCalloutStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = RemixCalloutStyler.create();
        expect(style, isNotNull);
        expect(style, isA<RemixCalloutStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final text = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());

        final style = RemixCalloutStyler.create(
          container: container,
          text: text,
          icon: icon,
        );

        expect(style, isNotNull);
        expect(style, isA<RemixCalloutStyler>());
      });

      test('constructor with styler parameters', () {
        final style = RemixCalloutStyler(
          container: FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(16.0)),
          text: TextStyler(style: TextStyleMix(color: Colors.blue)),
          icon: IconStyler(color: Colors.green),
        );

        expect(style, isNotNull);
        expect(style, isA<RemixCalloutStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'padding sets container padding',
        initial: RemixCalloutStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(20.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixCalloutStyler.padding(EdgeInsetsGeometryMix.all(20.0))),
          );
        },
      );

      styleMethodTest(
        'icon sets icon styler',
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixCalloutStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'backgroundColor sets container background color',
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
        modify: (style) => style.shape(
          RoundedRectangleBorderMix(
            borderRadius: BorderRadiusGeometryMix.circular(16.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixCalloutStyler.shape(
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
        initial: RemixCalloutStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixCalloutStyler.borderRadius(
                BorderRadiusGeometryMix.circular(12.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: RemixCalloutStyler(),
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
              RemixCalloutStyler.decoration(
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
        initial: RemixCalloutStyler(),
        modify: (style) => style.alignment(Alignment.centerRight),
        expect: (style) {
          expect(
            style,
            equals(RemixCalloutStyler.alignment(Alignment.centerRight)),
          );
        },
      );

      styleMethodTest(
        'spacing sets flex spacing',
        initial: RemixCalloutStyler(),
        modify: (style) => style.spacing(16.0),
        expect: (style) {
          expect(style, equals(RemixCalloutStyler.spacing(16.0)));
        },
      );

      styleMethodTest(
        'iconColor sets icon color',
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: RemixCalloutStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: RemixCalloutStyler(),
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
        initial: RemixCalloutStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 200.0, minHeight: 50.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixCalloutStyler.constraints(
                BoxConstraintsMix(minWidth: 200.0, minHeight: 50.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: RemixCalloutStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.cyan.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixCalloutStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.cyan.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: RemixCalloutStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.2)),
        expect: (style) {
          expect(
            style,
            equals(RemixCalloutStyler.transform(Matrix4.rotationZ(0.2))),
          );
        },
      );

      styleMethodTest(
        'flex sets flex styler',
        initial: RemixCalloutStyler(),
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
        const style = RemixCalloutStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<RemixCalloutSpec>>());
                expect(spec.spec, isA<RemixCalloutSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = RemixCalloutStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = RemixCalloutStyler.create();
        final style2 = RemixCalloutStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<RemixCalloutStyler>());
      });

      test('props list contains all properties', () {
        const style = RemixCalloutStyler.create();
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
        const style1 = RemixCalloutStyler.create();
        const style2 = RemixCalloutStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = RemixCalloutStyler.create();
        final style2 = RemixCalloutStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = RemixCalloutStyler();
        final style2 = RemixCalloutStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
