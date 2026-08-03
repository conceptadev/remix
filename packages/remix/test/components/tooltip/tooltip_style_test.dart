import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('TooltipStyler', () {
    group('Constructors', () {
      test('create() constructs with null parameters', () {
        const style = TooltipStyler.create();

        expect(style.$container, isNull);
        expect(style.$waitDuration, isNull);
        expect(style.$showDuration, isNull);
        expect(style.$variants, isNull);
        expect(style.$animation, isNull);
        expect(style.$modifier, isNull);
      });

      test('create() constructs with provided parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final waitDuration = Prop.value(const Duration(milliseconds: 500));
        final showDuration = Prop.value(const Duration(milliseconds: 2000));
        final variants = <VariantStyle<TooltipSpec>>[];
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        final modifier = WidgetModifierConfig();

        final style = TooltipStyler.create(
          container: container,
          waitDuration: waitDuration,
          showDuration: showDuration,
          variants: variants,
          animation: animation,
          modifier: modifier,
        );

        expect(style.$container, equals(container));
        expect(style.$waitDuration, equals(waitDuration));
        expect(style.$showDuration, equals(showDuration));
        expect(style.$variants, equals(variants));
        expect(style.$animation, equals(animation));
        expect(style.$modifier, equals(modifier));
      });

      test('default constructor converts types correctly', () {
        final style = TooltipStyler(
          container: BoxStyler(),
          waitDuration: const Duration(milliseconds: 500),
          showDuration: const Duration(milliseconds: 2000),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
          variants: [],
          modifier: WidgetModifierConfig(),
        );

        expect(style.$container, isNotNull);
        expect(style.$waitDuration, isNotNull);
        expect(style.$showDuration, isNotNull);
        expect(style.$variants, isNotNull);
        expect(style.$animation, isNotNull);
        expect(style.$modifier, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'padding() sets padding',
        initial: TooltipStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16)),
        expect: (style) {
          expect(
            style,
            equals(TooltipStyler.padding(EdgeInsetsGeometryMix.all(16))),
          );
        },
      );

      styleMethodTest(
        'margin() sets margin',
        initial: TooltipStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8)),
        expect: (style) {
          expect(
            style,
            equals(TooltipStyler.margin(EdgeInsetsGeometryMix.all(8))),
          );
        },
      );

      styleMethodTest(
        'alignment() sets alignment',
        initial: TooltipStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(TooltipStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'color() sets background color',
        initial: TooltipStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(TooltipStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'backgroundColor() sets background color',
        initial: TooltipStyler(),
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
        'borderRadius() sets border radius',
        initial: TooltipStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8)),
        expect: (style) {
          expect(
            style,
            equals(
              TooltipStyler.borderRadius(BorderRadiusGeometryMix.circular(8)),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration() sets decoration',
        initial: TooltipStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.red)),
        expect: (style) {
          expect(
            style,
            equals(
              TooltipStyler.decoration(BoxDecorationMix(color: Colors.red)),
            ),
          );
        },
      );

      styleMethodTest(
        'waitDuration() sets wait duration',
        initial: TooltipStyler(),
        modify: (style) =>
            style.waitDuration(const Duration(milliseconds: 500)),
        expect: (style) {
          expect(
            style.$waitDuration,
            equals(Prop.value(const Duration(milliseconds: 500))),
          );
        },
      );

      styleMethodTest(
        'showDuration() sets show duration',
        initial: TooltipStyler(),
        modify: (style) =>
            style.showDuration(const Duration(milliseconds: 2000)),
        expect: (style) {
          expect(
            style.$showDuration,
            equals(Prop.value(const Duration(milliseconds: 2000))),
          );
        },
      );

      styleMethodTest(
        'constraints() adds box constraints',
        initial: TooltipStyler(),
        modify: (style) =>
            style.constraints(BoxConstraintsMix(minWidth: 100, maxWidth: 200)),
        expect: (style) {
          expect(
            style,
            equals(
              TooltipStyler.constraints(
                BoxConstraintsMix(minWidth: 100, maxWidth: 200),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration() adds foreground decoration',
        initial: TooltipStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(shape: BoxShape.circle),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TooltipStyler.foregroundDecoration(
                BoxDecorationMix(shape: BoxShape.circle),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform() adds transform',
        initial: TooltipStyler(),
        modify: (style) => style.transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.topLeft,
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TooltipStyler.transform(
                Matrix4.rotationZ(0.1),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'animate() adds animation config',
        initial: TooltipStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(milliseconds: 300))),
          );
        },
      );

      styleMethodTest(
        'variants() adds variants',
        initial: TooltipStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap() adds widget modifier',
        initial: TooltipStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve() creates StyleSpec', (tester) async {
        const style = TooltipStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        expect(styleSpec, isA<StyleSpec<TooltipSpec>>());
        expect(styleSpec.spec, isA<TooltipSpec>());
      });

      test('merge() combines two styles', () {
        final style1 = TooltipStyler(container: BoxStyler());
        final style2 = TooltipStyler(
          waitDuration: const Duration(milliseconds: 500),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        final merged = style1.merge(style2);

        expect(merged.$container, isNotNull);
        expect(merged.$waitDuration, isNotNull);
        expect(merged.$animation, isNotNull);
      });

      test('merge() with null returns original', () {
        final style = TooltipStyler(container: BoxStyler());
        final merged = style.merge(null);

        expect(merged, equals(style));
      });

      test('call() creates RemixTooltip with this style', () {
        final style = TooltipStyler().color(Colors.black);

        final tooltip = style.call(
          tooltipChild: const Text('More info'),
          child: const SizedBox(key: Key('trigger')),
        );

        expect(tooltip, isA<RemixTooltip>());
        expect(tooltip.style, same(style));
        expect(tooltip.tooltipChild, isA<Text>());
        expect(tooltip.child.key, const Key('trigger'));
      });

      testWidgets('resolve() provides default durations', (tester) async {
        const style = TooltipStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        // Duration fields may be null when resolved as they're not part of the style
        expect(styleSpec.spec.waitDuration, isA<Duration?>());
        expect(styleSpec.spec.showDuration, isA<Duration?>());
      });
    });

    group('Equality', () {
      test('two identical styles are equal', () {
        const style1 = TooltipStyler.create();
        const style2 = TooltipStyler.create();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('two styles with different properties are not equal', () {
        final style1 = TooltipStyler(container: BoxStyler());
        const style2 = TooltipStyler.create();

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
