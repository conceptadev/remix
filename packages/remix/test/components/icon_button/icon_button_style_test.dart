import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('IconButtonStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = IconButtonStyler.create();
        expect(style, isNotNull);
        expect(style, isA<IconButtonStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final icon = Prop.maybeMix(IconStyler());
        final spinner = Prop.maybeMix(SpinnerStyler());

        final style = IconButtonStyler.create(
          container: container,
          icon: icon,
          spinner: spinner,
        );

        expect(style, isNotNull);
        expect(style, isA<IconButtonStyler>());
      });

      test('constructor with styler parameters', () {
        final style = IconButtonStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(12.0)),
          icon: IconStyler(color: Colors.blue),
          spinner: SpinnerStyler(),
        );

        expect(style, isNotNull);
        expect(style, isA<IconButtonStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'icon sets icon styler',
        initial: IconButtonStyler(),
        modify: (style) => style.icon(IconStyler(color: Colors.red)),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.red))),
          );
        },
      );

      styleMethodTest(
        'spinner sets spinner style',
        initial: IconButtonStyler(),
        modify: (style) => style.spinner(SpinnerStyler()),
        expect: (style) {
          expect(style.$spinner, equals(Prop.maybeMix(SpinnerStyler())));
        },
      );

      styleMethodTest(
        'color sets container background color',
        initial: IconButtonStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(IconButtonStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: IconButtonStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(IconButtonStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'borderRadius sets container border radius',
        initial: IconButtonStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8.0)),
        expect: (style) {
          expect(
            style,
            equals(
              IconButtonStyler.borderRadius(
                BorderRadiusGeometryMix.circular(8.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconButtonSize sets container size constraints',
        initial: IconButtonStyler(),
        modify: (style) => style.iconButtonSize(48.0),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(
                  constraints: BoxConstraintsMix(
                    minWidth: 48.0,
                    maxWidth: 48.0,
                    minHeight: 48.0,
                    maxHeight: 48.0,
                  ),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'border sets container border',
        initial: IconButtonStyler(),
        modify: (style) =>
            style.border(BoxBorderMix.all(BorderSideMix(color: Colors.grey))),
        expect: (style) {
          expect(
            style,
            equals(
              IconButtonStyler.border(
                BoxBorderMix.all(BorderSideMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: IconButtonStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(IconButtonStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'alignment sets container alignment',
        initial: IconButtonStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(IconButtonStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: IconButtonStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.lightBlue,
            borderRadius: BorderRadiusGeometryMix.circular(6.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              IconButtonStyler.decoration(
                BoxDecorationMix(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadiusGeometryMix.circular(6.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints sets container constraints',
        initial: IconButtonStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 40.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              IconButtonStyler.constraints(
                BoxConstraintsMix(minWidth: 40.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconColor sets icon color',
        initial: IconButtonStyler(),
        modify: (style) => style.iconColor(Colors.green),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.green))),
          );
        },
      );

      styleMethodTest(
        'iconSize sets icon size',
        initial: IconButtonStyler(),
        modify: (style) => style.iconSize(24.0),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler(size: 24.0))));
        },
      );

      styleMethodTest(
        'width sets container width',
        initial: IconButtonStyler(),
        modify: (style) => style.width(50.0),
        expect: (style) {
          expect(style, equals(IconButtonStyler.width(50.0)));
        },
      );

      styleMethodTest(
        'height sets container height',
        initial: IconButtonStyler(),
        modify: (style) => style.height(50.0),
        expect: (style) {
          expect(style, equals(IconButtonStyler.height(50.0)));
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: IconButtonStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(Duration(milliseconds: 200))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(Duration(milliseconds: 200))),
          );
        },
      );

      styleMethodTest(
        'variants sets variant styles',
        initial: IconButtonStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: IconButtonStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: IconButtonStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              IconButtonStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: IconButtonStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(
            style,
            equals(IconButtonStyler.transform(Matrix4.rotationZ(0.1))),
          );
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixIconButton with minimal parameters', () {
        const style = IconButtonStyler.create();
        final button = style.call(icon: Icons.add);

        expect(button, isA<RemixIconButton>());
        expect(button.icon, equals(Icons.add));
        expect(button.onPressed, isNull);
      });

      test('call method with all parameters', () {
        const style = IconButtonStyler.create();
        const key = ValueKey('icon-button');
        final focusNode = FocusNode();
        void onPressed() {}
        void onLongPress() {}
        Widget iconBuilder(
          BuildContext context,
          IconSpec spec,
          IconData? icon,
        ) {
          return const SizedBox();
        }

        Widget loadingBuilder(BuildContext context, SpinnerSpec spec) {
          return const SizedBox();
        }

        final button = style.call(
          key: key,
          icon: Icons.delete,
          iconBuilder: iconBuilder,
          loadingBuilder: loadingBuilder,
          loading: true,
          enabled: false,
          enableFeedback: false,
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: true,
          semanticLabel: 'Delete',
          semanticHint: 'Deletes the item',
          excludeSemantics: true,
          mouseCursor: SystemMouseCursors.forbidden,
        );

        expect(button, isA<RemixIconButton>());
        expect(button.key, key);
        expect(button.icon, equals(Icons.delete));
        expect(button.iconBuilder, same(iconBuilder));
        expect(button.loadingBuilder, same(loadingBuilder));
        expect(button.onPressed, same(onPressed));
        expect(button.onLongPress, same(onLongPress));
        expect(button.loading, isTrue);
        expect(button.enabled, isFalse);
        expect(button.enableFeedback, isFalse);
        expect(button.focusNode, same(focusNode));
        expect(button.autofocus, isTrue);
        expect(button.semanticLabel, 'Delete');
        expect(button.semanticHint, 'Deletes the item');
        expect(button.excludeSemantics, isTrue);
        expect(button.mouseCursor, SystemMouseCursors.forbidden);

        focusNode.dispose();
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (tester) async {
        const style = IconButtonStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<IconButtonSpec>>());
                expect(spec.spec, isA<IconButtonSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = IconButtonStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = IconButtonStyler.create();
        final style2 = IconButtonStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<IconButtonStyler>());
      });

      test('props list contains all properties', () {
        const style = IconButtonStyler.create();
        expect(style.props, hasLength(7));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$icon));
        expect(style.props, contains(style.$spinner));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        const style1 = IconButtonStyler.create();
        const style2 = IconButtonStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = IconButtonStyler.create();
        final style2 = IconButtonStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = IconButtonStyler();
        final style2 = IconButtonStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
