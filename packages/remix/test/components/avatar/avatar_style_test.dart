import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('AvatarStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = AvatarStyler.create();
        expect(style, isNotNull);
        expect(style, isA<AvatarStyler>());
      });

      test('constructor with styler parameters', () {
        final style = AvatarStyler(
          container: BoxStyler(
            decoration: BoxDecorationMix(color: Colors.blue),
          ),
          label: TextStyler(style: TextStyleMix(color: Colors.white)),
          icon: IconStyler(color: Colors.red),
        );

        expect(style, isNotNull);
        expect(style, isA<AvatarStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'size sets equal width and height',
        initial: AvatarStyler(),
        modify: (style) => style.size(50.0, 50.0),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(
                  constraints: BoxConstraintsMix(
                    minWidth: 50.0,
                    maxWidth: 50.0,
                    minHeight: 50.0,
                    maxHeight: 50.0,
                  ),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size sets width and height',
        initial: AvatarStyler(),
        modify: (style) => style.size(100.0, 80.0),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(
                  constraints: BoxConstraintsMix(
                    minWidth: 100.0,
                    maxWidth: 100.0,
                    minHeight: 80.0,
                    maxHeight: 80.0,
                  ),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'color method sets background color',
        initial: AvatarStyler(),
        modify: (style) => style.color(Colors.green),
        expect: (style) {
          expect(style, equals(AvatarStyler.color(Colors.green)));
        },
      );

      styleMethodTest(
        'borderRadius method sets border radius',
        initial: AvatarStyler(),
        modify: (style) => style.borderRadius(
          BorderRadiusGeometryMix.all(Radius.circular(10)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              AvatarStyler.borderRadius(
                BorderRadiusGeometryMix.all(Radius.circular(10)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'color sets background color',
        initial: AvatarStyler(),
        modify: (style) => style.color(Colors.green),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'labelColor and iconColor set content color',
        initial: AvatarStyler(),
        modify: (style) =>
            style.labelColor(Colors.purple).iconColor(Colors.purple),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.purple)),
              ),
            ),
          );
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.purple))),
          );
        },
      );

      styleMethodTest(
        'labelColor method sets label color',
        initial: AvatarStyler(),
        modify: (style) => style.labelColor(Colors.purple),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.purple)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconColor method sets icon color',
        initial: AvatarStyler(),
        modify: (style) => style.iconColor(Colors.orange),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.orange))),
          );
        },
      );

      styleMethodTest(
        'padding method sets padding',
        initial: AvatarStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(AvatarStyler.padding(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'margin method sets margin',
        initial: AvatarStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(AvatarStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'alignment method sets container alignment',
        initial: AvatarStyler(),
        modify: (style) => style.alignment(Alignment.topLeft),
        expect: (style) {
          expect(style, equals(AvatarStyler.alignment(Alignment.topLeft)));
        },
      );

      styleMethodTest(
        'decoration method sets decoration',
        initial: AvatarStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.yellow)),
        expect: (style) {
          expect(
            style,
            equals(
              AvatarStyler.decoration(BoxDecorationMix(color: Colors.yellow)),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints method sets constraints',
        initial: AvatarStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(
            minWidth: 50,
            maxWidth: 100,
            minHeight: 50,
            maxHeight: 100,
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              AvatarStyler.constraints(
                BoxConstraintsMix(
                  minWidth: 50,
                  maxWidth: 100,
                  minHeight: 50,
                  maxHeight: 100,
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'animate method sets animation',
        initial: AvatarStyler(),
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
        'label method sets text styler',
        initial: AvatarStyler(),
        modify: (style) =>
            style.label(TextStyler(style: TextStyleMix(fontSize: 16))),
        expect: (style) {
          expect(
            style,
            equals(
              AvatarStyler.label(TextStyler(style: TextStyleMix(fontSize: 16))),
            ),
          );
        },
      );

      styleMethodTest(
        'icon method sets icon styler',
        initial: AvatarStyler(),
        modify: (style) => style.icon(IconStyler(size: 24)),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler(size: 24))));
        },
      );

      styleMethodTest(
        'size method sets width and height',
        initial: AvatarStyler(),
        modify: (style) => style.size(60.0, 40.0),
        expect: (style) {
          expect(style, equals(AvatarStyler.size(60.0, 40.0)));
        },
      );

      styleMethodTest(
        'variants method sets variants',
        initial: AvatarStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap method sets modifier',
        initial: AvatarStyler(),
        modify: (style) => style.wrap(.align()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.align()));
        },
      );

      styleMethodTest(
        'foregroundDecoration method sets foreground decoration',
        initial: AvatarStyler(),
        modify: (style) =>
            style.foregroundDecoration(BoxDecorationMix(color: Colors.cyan)),
        expect: (style) {
          expect(
            style,
            equals(
              AvatarStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.cyan),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform method sets transform',
        initial: AvatarStyler(),
        modify: (style) => style.transform(Matrix4.identity()),
        expect: (style) {
          expect(style, equals(AvatarStyler.transform(Matrix4.identity())));
        },
      );
    });

    group('Style Integration', () {
      test('style can be used to create RemixAvatar widget', () {
        final style = AvatarStyler().size(50.0, 50.0);
        final avatar = RemixAvatar(style: style, label: 'Test User');

        expect(avatar, isA<RemixAvatar>());
        expect(avatar.label, equals('Test User'));
        expect(avatar.style, equals(style));
      });

      test('style methods can be chained', () {
        final style = AvatarStyler()
            .size(100.0, 100.0)
            .labelColor(Colors.white)
            .iconColor(Colors.white)
            .iconColor(Colors.yellow);

        expect(style, isA<AvatarStyler>());
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        final style = AvatarStyler();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<AvatarSpec>>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = AvatarStyler();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style returns new instance', () {
        final style1 = AvatarStyler();
        final style2 = AvatarStyler().size(50.0, 50.0);
        final mergedStyle = style1.merge(style2);

        expect(mergedStyle, isNot(same(style1)));
        expect(mergedStyle, isNot(same(style2)));
        expect(mergedStyle, isA<AvatarStyler>());
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = AvatarStyler.create();
        const style2 = AvatarStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = AvatarStyler().size(50.0, 50.0);
        final style2 = AvatarStyler().size(100.0, 100.0);
        expect(style1, isNot(equals(style2)));
      });

      test('styles with same properties are equal', () {
        final style1 = AvatarStyler().size(50.0, 50.0);
        final style2 = AvatarStyler().size(50.0, 50.0);
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
