import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('TabBarStyler', () {
    group('Constructors', () {
      test('create() constructs with null parameters', () {
        const style = TabBarStyler.create();

        expect(style.$container, isNull);
        expect(style.$variants, isNull);
        expect(style.$animation, isNull);
        expect(style.$modifier, isNull);
      });

      test('create() constructs with provided parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final variants = <VariantStyle<TabBarSpec>>[];
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        final modifier = WidgetModifierConfig();

        final style = TabBarStyler.create(
          container: container,
          variants: variants,
          animation: animation,
          modifier: modifier,
        );

        expect(style.$container, equals(container));
        expect(style.$variants, equals(variants));
        expect(style.$animation, equals(animation));
        expect(style.$modifier, equals(modifier));
      });

      test('default constructor converts types correctly', () {
        final style = TabBarStyler(
          container: FlexBoxStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
          variants: [],
          modifier: WidgetModifierConfig(),
        );

        expect(style.$container, isNotNull);
        expect(style.$variants, isNotNull);
        expect(style.$animation, isNotNull);
        expect(style.$modifier, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'container() adds container styling',
        initial: TabBarStyler(),
        modify: (style) => style.container(FlexBoxStyler()),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );

      styleMethodTest(
        'alignment() adds alignment',
        initial: TabBarStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(TabBarStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding() adds padding',
        initial: TabBarStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16)),
        expect: (style) {
          expect(
            style,
            equals(TabBarStyler.padding(EdgeInsetsGeometryMix.all(16))),
          );
        },
      );

      styleMethodTest(
        'color() adds background color',
        initial: TabBarStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(TabBarStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'size() sets width and height',
        initial: TabBarStyler(),
        modify: (style) => style.size(100, 50),
        expect: (style) {
          expect(style, equals(TabBarStyler.size(100, 50)));
        },
      );

      styleMethodTest(
        'borderRadius() adds border radius',
        initial: TabBarStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8)),
        expect: (style) {
          expect(
            style,
            equals(
              TabBarStyler.borderRadius(BorderRadiusGeometryMix.circular(8)),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints() adds box constraints',
        initial: TabBarStyler(),
        modify: (style) =>
            style.constraints(BoxConstraintsMix(minWidth: 100, maxWidth: 200)),
        expect: (style) {
          expect(
            style,
            equals(
              TabBarStyler.constraints(
                BoxConstraintsMix(minWidth: 100, maxWidth: 200),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration() adds decoration',
        initial: TabBarStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.red)),
        expect: (style) {
          expect(
            style,
            equals(
              TabBarStyler.decoration(BoxDecorationMix(color: Colors.red)),
            ),
          );
        },
      );

      styleMethodTest(
        'margin() adds margin',
        initial: TabBarStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8)),
        expect: (style) {
          expect(
            style,
            equals(TabBarStyler.margin(EdgeInsetsGeometryMix.all(8))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration() adds foreground decoration',
        initial: TabBarStyler(),
        modify: (style) =>
            style.foregroundDecoration(BoxDecorationMix(color: Colors.green)),
        expect: (style) {
          expect(
            style,
            equals(
              TabBarStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.green),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform() adds transform',
        initial: TabBarStyler(),
        modify: (style) => style.transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.topLeft,
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TabBarStyler.transform(
                Matrix4.rotationZ(0.1),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants() adds variants',
        initial: TabBarStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, isNotNull);
        },
      );

      styleMethodTest(
        'animate() adds animation config',
        initial: TabBarStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(style.$animation, isNotNull);
        },
      );

      styleMethodTest(
        'wrap() adds widget modifier',
        initial: TabBarStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, isNotNull);
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve() creates StyleSpec', (tester) async {
        const style = TabBarStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        expect(styleSpec, isA<StyleSpec<TabBarSpec>>());
        expect(styleSpec.spec, isA<TabBarSpec>());
      });

      test('merge() combines two styles', () {
        final style1 = TabBarStyler(container: FlexBoxStyler());
        final style2 = TabBarStyler(
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        final merged = style1.merge(style2);

        expect(merged.$container, isNotNull);
        expect(merged.$animation, isNotNull);
      });

      test('merge() with null returns original', () {
        final style = TabBarStyler(container: FlexBoxStyler());
        final merged = style.merge(null);

        expect(merged, equals(style));
      });

      test('call() creates RemixTabBar with this style', () {
        final style = TabBarStyler().padding(EdgeInsetsGeometryMix.all(8));

        final tabBar = style.call(child: const Text('Tabs'));

        expect(tabBar, isA<RemixTabBar>());
        expect(tabBar.style, same(style));
        expect(tabBar.child, isA<Text>());
      });
    });

    group('Equality', () {
      test('two identical styles are equal', () {
        const style1 = TabBarStyler.create();
        const style2 = TabBarStyler.create();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('two styles with different properties are not equal', () {
        final style1 = TabBarStyler(container: FlexBoxStyler());
        const style2 = TabBarStyler.create();

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('TabViewStyler', () {
    group('Constructors', () {
      test('create() constructs with null parameters', () {
        const style = TabViewStyler.create();

        expect(style.$container, isNull);
        expect(style.$variants, isNull);
        expect(style.$animation, isNull);
        expect(style.$modifier, isNull);
      });

      test('create() constructs with provided parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<TabViewSpec>>[];
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        final modifier = WidgetModifierConfig();

        final style = TabViewStyler.create(
          container: container,
          variants: variants,
          animation: animation,
          modifier: modifier,
        );

        expect(style.$container, equals(container));
        expect(style.$variants, equals(variants));
        expect(style.$animation, equals(animation));
        expect(style.$modifier, equals(modifier));
      });

      test('default constructor converts types correctly', () {
        final style = TabViewStyler(
          container: BoxStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
          variants: [],
          modifier: WidgetModifierConfig(),
        );

        expect(style.$container, isNotNull);
        expect(style.$variants, isNotNull);
        expect(style.$animation, isNotNull);
        expect(style.$modifier, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'alignment() adds alignment',
        initial: TabViewStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(TabViewStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding() adds padding',
        initial: TabViewStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16)),
        expect: (style) {
          expect(
            style,
            equals(TabViewStyler.padding(EdgeInsetsGeometryMix.all(16))),
          );
        },
      );

      styleMethodTest(
        'color() adds background color',
        initial: TabViewStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(TabViewStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'borderRadius() adds border radius',
        initial: TabViewStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8)),
        expect: (style) {
          expect(
            style,
            equals(
              TabViewStyler.borderRadius(BorderRadiusGeometryMix.circular(8)),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints() adds box constraints',
        initial: TabViewStyler(),
        modify: (style) =>
            style.constraints(BoxConstraintsMix(minWidth: 100, maxWidth: 200)),
        expect: (style) {
          expect(
            style,
            equals(
              TabViewStyler.constraints(
                BoxConstraintsMix(minWidth: 100, maxWidth: 200),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration() adds decoration',
        initial: TabViewStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.red)),
        expect: (style) {
          expect(
            style,
            equals(
              TabViewStyler.decoration(BoxDecorationMix(color: Colors.red)),
            ),
          );
        },
      );

      styleMethodTest(
        'margin() adds margin',
        initial: TabViewStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8)),
        expect: (style) {
          expect(
            style,
            equals(TabViewStyler.margin(EdgeInsetsGeometryMix.all(8))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration() adds foreground decoration',
        initial: TabViewStyler(),
        modify: (style) =>
            style.foregroundDecoration(BoxDecorationMix(color: Colors.green)),
        expect: (style) {
          expect(
            style,
            equals(
              TabViewStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.green),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform() adds transform',
        initial: TabViewStyler(),
        modify: (style) => style.transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.topLeft,
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TabViewStyler.transform(
                Matrix4.rotationZ(0.1),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants() adds variants',
        initial: TabViewStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, isNotNull);
        },
      );

      styleMethodTest(
        'animate() adds animation config',
        initial: TabViewStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(style.$animation, isNotNull);
        },
      );

      styleMethodTest(
        'wrap() adds widget modifier',
        initial: TabViewStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, isNotNull);
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve() creates StyleSpec', (tester) async {
        const style = TabViewStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        expect(styleSpec, isA<StyleSpec<TabViewSpec>>());
        expect(styleSpec.spec, isA<TabViewSpec>());
      });

      test('merge() combines two styles', () {
        final style1 = TabViewStyler(container: BoxStyler());
        final style2 = TabViewStyler(
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        final merged = style1.merge(style2);

        expect(merged.$container, isNotNull);
        expect(merged.$animation, isNotNull);
      });

      test('merge() with null returns original', () {
        final style = TabViewStyler(container: BoxStyler());
        final merged = style.merge(null);

        expect(merged, equals(style));
      });

      test('call() creates RemixTabView with this style', () {
        final style = TabViewStyler().padding(EdgeInsetsGeometryMix.all(8));

        final tabView = style.call(
          tabId: 'overview',
          child: const Text('Overview'),
        );

        expect(tabView, isA<RemixTabView>());
        expect(tabView.style, same(style));
        expect(tabView.tabId, 'overview');
        expect(tabView.child, isA<Text>());
      });
    });

    group('Equality', () {
      test('two identical styles are equal', () {
        const style1 = TabViewStyler.create();
        const style2 = TabViewStyler.create();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('two styles with different properties are not equal', () {
        final style1 = TabViewStyler(container: BoxStyler());
        const style2 = TabViewStyler.create();

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('TabStyler', () {
    group('Constructors', () {
      test('create() constructs with null parameters', () {
        const style = TabStyler.create();

        expect(style.$container, isNull);
        expect(style.$label, isNull);
        expect(style.$icon, isNull);
        expect(style.$variants, isNull);
        expect(style.$animation, isNull);
        expect(style.$modifier, isNull);
      });

      test('create() constructs with provided parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<TabSpec>>[];
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        final modifier = WidgetModifierConfig();

        final style = TabStyler.create(
          container: container,
          label: label,
          icon: icon,
          variants: variants,
          animation: animation,
          modifier: modifier,
        );

        expect(style.$container, equals(container));
        expect(style.$label, equals(label));
        expect(style.$icon, equals(icon));
        expect(style.$variants, equals(variants));
        expect(style.$animation, equals(animation));
        expect(style.$modifier, equals(modifier));
      });

      test('default constructor converts types correctly', () {
        final style = TabStyler(
          container: FlexBoxStyler(),
          label: TextStyler(),
          icon: IconStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
          variants: [],
          modifier: WidgetModifierConfig(),
        );

        expect(style.$container, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
        expect(style.$variants, isNotNull);
        expect(style.$animation, isNotNull);
        expect(style.$modifier, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'container() adds container styling',
        initial: TabStyler(),
        modify: (style) => style.container(FlexBoxStyler()),
        expect: (style) {
          expect(style.$container, isNotNull);
        },
      );

      styleMethodTest(
        'label() adds label styling',
        initial: TabStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, isNotNull);
        },
      );

      styleMethodTest(
        'icon() adds icon styling',
        initial: TabStyler(),
        modify: (style) => style.icon(IconStyler()),
        expect: (style) {
          expect(style.$icon, isNotNull);
        },
      );

      styleMethodTest(
        'alignment() adds alignment',
        initial: TabStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(TabStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding() adds padding',
        initial: TabStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16)),
        expect: (style) {
          expect(
            style,
            equals(TabStyler.padding(EdgeInsetsGeometryMix.all(16))),
          );
        },
      );

      styleMethodTest(
        'color() adds background color',
        initial: TabStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(TabStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'constraints() adds box constraints',
        initial: TabStyler(),
        modify: (style) =>
            style.constraints(BoxConstraintsMix(minWidth: 100, maxWidth: 200)),
        expect: (style) {
          expect(
            style,
            equals(
              TabStyler.constraints(
                BoxConstraintsMix(minWidth: 100, maxWidth: 200),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration() adds decoration',
        initial: TabStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.red)),
        expect: (style) {
          expect(
            style,
            equals(TabStyler.decoration(BoxDecorationMix(color: Colors.red))),
          );
        },
      );

      styleMethodTest(
        'margin() adds margin',
        initial: TabStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8)),
        expect: (style) {
          expect(style, equals(TabStyler.margin(EdgeInsetsGeometryMix.all(8))));
        },
      );

      styleMethodTest(
        'foregroundDecoration() adds foreground decoration',
        initial: TabStyler(),
        modify: (style) =>
            style.foregroundDecoration(BoxDecorationMix(color: Colors.green)),
        expect: (style) {
          expect(
            style,
            equals(
              TabStyler.foregroundDecoration(
                BoxDecorationMix(color: Colors.green),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform() adds transform',
        initial: TabStyler(),
        modify: (style) => style.transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.topLeft,
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TabStyler.transform(
                Matrix4.rotationZ(0.1),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants() adds variants',
        initial: TabStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, isNotNull);
        },
      );

      styleMethodTest(
        'animate() adds animation config',
        initial: TabStyler(),
        modify: (style) => style.animate(
          AnimationConfig.linear(const Duration(milliseconds: 300)),
        ),
        expect: (style) {
          expect(style.$animation, isNotNull);
        },
      );

      styleMethodTest(
        'wrap() adds widget modifier',
        initial: TabStyler(),
        modify: (style) => style.wrap(WidgetModifierConfig()),
        expect: (style) {
          expect(style.$modifier, isNotNull);
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve() creates StyleSpec', (tester) async {
        const style = TabStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        expect(styleSpec, isA<StyleSpec<TabSpec>>());
        expect(styleSpec.spec, isA<TabSpec>());
      });

      test('merge() combines two styles', () {
        final style1 = TabStyler(container: FlexBoxStyler());
        final style2 = TabStyler(
          label: TextStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        final merged = style1.merge(style2);

        expect(merged.$container, isNotNull);
        expect(merged.$label, isNotNull);
        expect(merged.$animation, isNotNull);
      });

      test('merge() with null returns original', () {
        final style = TabStyler(container: FlexBoxStyler());
        final merged = style.merge(null);

        expect(merged, equals(style));
      });

      test('call() creates RemixTab with this style', () {
        final style = TabStyler().padding(EdgeInsetsGeometryMix.all(8));

        final tab = style.call(
          tabId: 'overview',
          label: 'Overview',
          icon: Icons.info,
          enabled: false,
        );

        expect(tab, isA<RemixTab>());
        expect(tab.style, same(style));
        expect(tab.tabId, 'overview');
        expect(tab.label, 'Overview');
        expect(tab.icon, Icons.info);
        expect(tab.enabled, isFalse);
      });
    });

    group('Equality', () {
      test('two identical styles are equal', () {
        const style1 = TabStyler.create();
        const style2 = TabStyler.create();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('two styles with different properties are not equal', () {
        final style1 = TabStyler(container: FlexBoxStyler());
        const style2 = TabStyler.create();

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
