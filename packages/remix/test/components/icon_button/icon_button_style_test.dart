import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixIconButtonStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        const style = RemixIconButtonStyler.create();
        expect(style, isNotNull);
        expect(style, isA<RemixIconButtonStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final icon = Prop.maybeMix(IconStyler());
        final spinner = Prop.maybeMix(RemixSpinnerStyler());

        final style = RemixIconButtonStyler.create(
          container: container,
          icon: icon,
          spinner: spinner,
        );

        expect(style, isNotNull);
        expect(style, isA<RemixIconButtonStyler>());
      });

      test('constructor with styler parameters', () {
        final style = RemixIconButtonStyler(
          container: BoxStyler(padding: EdgeInsetsGeometryMix.all(12.0)),
          icon: IconStyler(color: Colors.blue),
          spinner: RemixSpinnerStyler(),
        );

        expect(style, isNotNull);
        expect(style, isA<RemixIconButtonStyler>());
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'icon sets icon styler',
        initial: RemixIconButtonStyler(),
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
        initial: RemixIconButtonStyler(),
        modify: (style) => style.spinner(RemixSpinnerStyler()),
        expect: (style) {
          expect(style.$spinner, equals(Prop.maybeMix(RemixSpinnerStyler())));
        },
      );

      styleMethodTest(
        'color sets container background color',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(RemixIconButtonStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'padding sets container padding',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'borderRadius sets container border radius',
        initial: RemixIconButtonStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.borderRadius(
                BorderRadiusGeometryMix.circular(8.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconButtonSize sets container size constraints',
        initial: RemixIconButtonStyler(),
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
        initial: RemixIconButtonStyler(),
        modify: (style) =>
            style.border(BoxBorderMix.all(BorderSideMix(color: Colors.grey))),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.border(
                BoxBorderMix.all(BorderSideMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'margin sets container margin',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.margin(EdgeInsetsGeometryMix.all(4.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment sets container alignment',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixIconButtonStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'decoration sets container decoration',
        initial: RemixIconButtonStyler(),
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
              RemixIconButtonStyler.decoration(
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
        initial: RemixIconButtonStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 40.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.constraints(
                BoxConstraintsMix(minWidth: 40.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconColor sets icon color',
        initial: RemixIconButtonStyler(),
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
        initial: RemixIconButtonStyler(),
        modify: (style) => style.iconSize(24.0),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler(size: 24.0))));
        },
      );

      styleMethodTest(
        'width sets container width',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.width(50.0),
        expect: (style) {
          expect(style, equals(RemixIconButtonStyler.width(50.0)));
        },
      );

      styleMethodTest(
        'height sets container height',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.height(50.0),
        expect: (style) {
          expect(style, equals(RemixIconButtonStyler.height(50.0)));
        },
      );

      styleMethodTest(
        'animate sets animation config',
        initial: RemixIconButtonStyler(),
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
        initial: RemixIconButtonStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap sets widget modifier config',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig()));
        },
      );

      styleMethodTest(
        'foregroundDecoration sets foreground decoration',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixIconButtonStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.yellow.withValues(alpha: 0.3)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform sets container transform',
        initial: RemixIconButtonStyler(),
        modify: (style) => style.transform(Matrix4.rotationZ(0.1)),
        expect: (style) {
          expect(
            style,
            equals(RemixIconButtonStyler.transform(Matrix4.rotationZ(0.1))),
          );
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixIconButton with minimal parameters', () {
        const style = RemixIconButtonStyler.create();
        final button = style.call(icon: Icons.add);

        expect(button, isA<RemixIconButton>());
        expect(button.icon, equals(Icons.add));
        expect(button.onPressed, isNull);
      });

      test('call method with all parameters', () {
        const style = RemixIconButtonStyler.create();
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

        Widget loadingBuilder(BuildContext context, RemixSpinnerSpec spec) {
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
        const style = RemixIconButtonStyler.create();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);
                expect(spec, isA<StyleSpec<RemixIconButtonSpec>>());
                expect(spec.spec, isA<RemixIconButtonSpec>());
                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        const originalStyle = RemixIconButtonStyler.create();
        final mergedStyle = originalStyle.merge(null);
        expect(mergedStyle, equals(originalStyle));
      });

      test('merge with other style combines properties', () {
        const style1 = RemixIconButtonStyler.create();
        final style2 = RemixIconButtonStyler();

        final merged = style1.merge(style2);
        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged, isA<RemixIconButtonStyler>());
      });

      test('props list contains all properties', () {
        const style = RemixIconButtonStyler.create();
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
        const style1 = RemixIconButtonStyler.create();
        const style2 = RemixIconButtonStyler.create();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        const style1 = RemixIconButtonStyler.create();
        final style2 = RemixIconButtonStyler();
        expect(style1, equals(style2));
      });

      test('styles with same properties are equal', () {
        final style1 = RemixIconButtonStyler();
        final style2 = RemixIconButtonStyler();
        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });
    });
  });
}
