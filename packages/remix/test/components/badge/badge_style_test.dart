import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixBadgeStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = RemixBadgeStyler.create();
        expect(style, isNotNull);
        expect(style, isA<RemixBadgeStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final text = Prop.maybeMix(TextStyler());

        final style = RemixBadgeStyler.create(
          container: container,
          label: text,
        );

        expect(style, isNotNull);
        expect(style, isA<RemixBadgeStyler>());
      });

      test('constructor with styler parameters', () {
        final style = RemixBadgeStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(8.0)),
          label: TextStyler(style: TextStyleMix(color: Colors.red)),
        );

        expect(style, isNotNull);
        expect(style, isA<RemixBadgeStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'backgroundColor sets background color',
        initial: RemixBadgeStyler(),
        modify: (style) => style.backgroundColor(Colors.blue),
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
        'foregroundColor sets text color',
        initial: RemixBadgeStyler(),
        modify: (style) => style.foregroundColor(Colors.green),
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
        initial: RemixBadgeStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixBadgeStyler.borderRadius(
                BorderRadiusGeometryMix.circular(12.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: RemixBadgeStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixBadgeStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: RemixBadgeStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixBadgeStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: RemixBadgeStyler(),
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
              RemixBadgeStyler.decoration(
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
        initial: RemixBadgeStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixBadgeStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'label sets text styler',
        initial: RemixBadgeStyler(),
        modify: (style) =>
            style.label(TextStyler(style: TextStyleMix(fontSize: 14.0))),
        expect: (style) {
          expect(
            style,
            equals(
              RemixBadgeStyler.label(
                TextStyler(style: TextStyleMix(fontSize: 14.0)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: RemixBadgeStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 50.0, minHeight: 20.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixBadgeStyler.constraints(
                BoxConstraintsMix(minWidth: 50.0, minHeight: 20.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: RemixBadgeStyler(),
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
        initial: RemixBadgeStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: RemixBadgeStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: RemixBadgeStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.5)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixBadgeStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.5)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: RemixBadgeStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(
            style,
            equals(RemixBadgeStyler.transform(Matrix4.rotationZ(0.1))),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = RemixBadgeStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<RemixBadgeSpec>>());
                expect(spec.spec, isA<RemixBadgeSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = RemixBadgeStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = RemixBadgeStyler.create();
        final style2 = RemixBadgeStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<RemixBadgeStyler>());
      });

      test('props list contains all properties', () {
        const style = RemixBadgeStyler.create();
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
        const style1 = RemixBadgeStyler.create();
        const style2 = RemixBadgeStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = RemixBadgeStyler.create();
        final style2 = RemixBadgeStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = RemixBadgeStyler();
        final style2 = RemixBadgeStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
