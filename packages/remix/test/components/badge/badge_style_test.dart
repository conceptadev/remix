import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('BadgeStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = BadgeStyler.create();
        expect(style, isNotNull);
        expect(style, isA<BadgeStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final text = Prop.maybeMix(TextStyler());

        final style = BadgeStyler.create(container: container, label: text);

        expect(style, isNotNull);
        expect(style, isA<BadgeStyler>());
      });

      test('constructor with styler parameters', () {
        final style = BadgeStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(8.0)),
          label: TextStyler(style: TextStyleMix(color: Colors.red)),
        );

        expect(style, isNotNull);
        expect(style, isA<BadgeStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'color sets background color',
        initial: BadgeStyler(),
        modify: (style) => style.color(Colors.blue),
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
        'labelColor sets text color',
        initial: BadgeStyler(),
        modify: (style) => style.labelColor(Colors.green),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'borderRadius sets border radius',
        initial: BadgeStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              BadgeStyler.borderRadius(BorderRadiusGeometryMix.circular(12.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: BadgeStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(BadgeStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: BadgeStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(BadgeStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: BadgeStyler(),
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
              BadgeStyler.decoration(
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
        initial: BadgeStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(style, equals(BadgeStyler.alignment(Alignment.centerLeft)));
        },
      );

      styleMethodTest(
        'label sets text styler',
        initial: BadgeStyler(),
        modify: (style) =>
            style.label(TextStyler(style: TextStyleMix(fontSize: 14.0))),
        expect: (style) {
          expect(
            style,
            equals(
              BadgeStyler.label(
                TextStyler(style: TextStyleMix(fontSize: 14.0)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: BadgeStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 50.0, minHeight: 20.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              BadgeStyler.constraints(
                BoxConstraintsMix(minWidth: 50.0, minHeight: 20.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: BadgeStyler(),
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
        'variants sets variant styles',
        initial: BadgeStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: BadgeStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: BadgeStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.5)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              BadgeStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.5)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: BadgeStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(style, equals(BadgeStyler.transform(Matrix4.rotationZ(0.1))));
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = BadgeStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<BadgeSpec>>());
                expect(spec.spec, isA<BadgeSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = BadgeStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = BadgeStyler.create();
        final style2 = BadgeStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<BadgeStyler>());
      });

      test('props list contains all properties', () {
        const style = BadgeStyler.create();
        expect(style.props, hasLength(6));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$label));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = BadgeStyler.create();
        const style2 = BadgeStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = BadgeStyler.create();
        final style2 = BadgeStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = BadgeStyler();
        final style2 = BadgeStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
