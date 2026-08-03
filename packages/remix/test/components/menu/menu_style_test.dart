import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('MenuTriggerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = MenuTriggerStyler();

        expect(style, isNotNull);
        expect(style, isA<MenuTriggerStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<MenuTriggerSpec>>[];

        final style = MenuTriggerStyler.create(
          container: container,
          label: label,
          icon: icon,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$label, equals(label));
        expect(style.$icon, equals(icon));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = FlexBoxStyler();
        final labelStyler = TextStyler();
        final iconStyler = IconStyler();

        final style = MenuTriggerStyler(
          container: containerStyler,
          label: labelStyler,
          icon: iconStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'label',
        initial: MenuTriggerStyler(),
        modify: (style) =>
            style.label(TextStyler().color(Colors.red).fontSize(14)),
        expect: (style) {
          expect(
            style.$label,
            Prop.maybeMix(TextStyler().color(Colors.red).fontSize(14)),
          );
        },
      );

      styleMethodTest(
        'icon',
        initial: MenuTriggerStyler(),
        modify: (style) => style.icon(IconStyler().color(Colors.red).size(16)),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler().color(Colors.red).size(16))),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: MenuTriggerStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(MenuTriggerStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: MenuTriggerStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(MenuTriggerStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'alignment',
        initial: MenuTriggerStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(MenuTriggerStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'size',
        initial: MenuTriggerStyler(),
        modify: (style) => style.size(100.0, 50.0),
        expect: (style) {
          expect(style, equals(MenuTriggerStyler.size(100.0, 50.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: MenuTriggerStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(8.0)),
        expect: (style) {
          expect(
            style,
            equals(
              MenuTriggerStyler.borderRadius(BorderRadiusMix.circular(8.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: MenuTriggerStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              MenuTriggerStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: MenuTriggerStyler(),
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
              MenuTriggerStyler.decoration(
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
        'margin',
        initial: MenuTriggerStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(MenuTriggerStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: MenuTriggerStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              MenuTriggerStyler.foregroundDecoration(
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
        initial: MenuTriggerStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              MenuTriggerStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: MenuTriggerStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$container,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: MenuTriggerStyler(),
        modify: (style) => style.variants(<VariantStyle<MenuTriggerSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<MenuTriggerSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: MenuTriggerStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = MenuTriggerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<MenuTriggerSpec>>());
                expect(spec.spec, isA<MenuTriggerSpec>());
                expect(spec.spec.container, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.label, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.icon, isA<StyleSpec<IconSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = MenuTriggerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = MenuTriggerStyler();
        final style2 = MenuTriggerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = MenuTriggerStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = MenuTriggerStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('MenuStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = MenuStyler();

        expect(style, isNotNull);
        expect(style, isA<MenuStyler>());
      });

      test('create constructor with all parameters', () {
        final trigger = Prop.maybeMix(MenuTriggerStyler());
        final overlay = Prop.maybeMix(FlexBoxStyler());
        final item = Prop.maybeMix(MenuItemStyler());
        final divider = Prop.maybeMix(DividerStyler());
        final variants = <VariantStyle<MenuSpec>>[];

        final style = MenuStyler.create(
          trigger: trigger,
          overlay: overlay,
          item: item,
          divider: divider,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$trigger, equals(trigger));
        expect(style.$overlay, equals(overlay));
        expect(style.$item, equals(item));
        expect(style.$divider, equals(divider));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final triggerStyle = MenuTriggerStyler();
        final overlayStyler = FlexBoxStyler();
        final itemStyle = MenuItemStyler();
        final dividerStyle = DividerStyler();

        final style = MenuStyler(
          trigger: triggerStyle,
          overlay: overlayStyler,
          item: itemStyle,
          divider: dividerStyle,
        );

        expect(style, isNotNull);
        expect(style.$trigger, isNotNull);
        expect(style.$overlay, isNotNull);
        expect(style.$item, isNotNull);
        expect(style.$divider, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'trigger',
        initial: MenuStyler(),
        modify: (style) => style.trigger(MenuTriggerStyler()),
        expect: (style) {
          expect(style.$trigger, equals(Prop.maybeMix(MenuTriggerStyler())));
        },
      );

      styleMethodTest(
        'overlay',
        initial: MenuStyler(),
        modify: (style) => style.overlay(FlexBoxStyler()),
        expect: (style) {
          expect(style.$overlay, equals(Prop.maybeMix(FlexBoxStyler())));
        },
      );

      styleMethodTest(
        'item',
        initial: MenuStyler(),
        modify: (style) => style.item(MenuItemStyler()),
        expect: (style) {
          expect(style.$item, equals(Prop.maybeMix(MenuItemStyler())));
        },
      );

      styleMethodTest(
        'divider',
        initial: MenuStyler(),
        modify: (style) => style.divider(DividerStyler()),
        expect: (style) {
          expect(style.$divider, equals(Prop.maybeMix(DividerStyler())));
        },
      );

      styleMethodTest(
        'variants',
        initial: MenuStyler(),
        modify: (style) => style.variants(<VariantStyle<MenuSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<MenuSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: MenuStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixMenu with required parameters', () {
        final style = MenuStyler();

        final menu = style.call<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [const RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        );

        expect(menu, isA<RemixMenu<String>>());
        expect(menu.trigger.label, equals('Options'));
        expect(menu.items.length, equals(1));
      });

      test('call method creates RemixMenu with all parameters', () {
        final style = MenuStyler();
        final controller = MenuController();
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        void onSelected(String value) {}
        void onOpen() {}
        void onClose() {}
        void onCanceled() {}
        void onOpenRequested(Offset? position, VoidCallback showOverlay) {}
        void onCloseRequested(VoidCallback hideOverlay) {}
        const positioning = OverlayPositionConfig(
          side: OverlaySide.top,
          alignment: OverlayAlignment.end,
        );

        final menu = style.call<String>(
          trigger: const RemixMenuTrigger(
            label: 'Options',
            icon: Icons.more_vert,
          ),
          items: [
            const RemixMenuItem<String>(value: 'copy', label: 'Copy'),
            const RemixMenuDivider<String>(),
            const RemixMenuItem<String>(value: 'paste', label: 'Paste'),
          ],
          controller: controller,
          onSelected: onSelected,
          onOpen: onOpen,
          onClose: onClose,
          onCanceled: onCanceled,
          onOpenRequested: onOpenRequested,
          onCloseRequested: onCloseRequested,
          consumeOutsideTaps: false,
          useRootOverlay: true,
          closeOnClickOutside: false,
          triggerFocusNode: focusNode,
          positioning: positioning,
        );

        expect(menu, isA<RemixMenu<String>>());
        expect(menu.trigger.label, equals('Options'));
        expect(menu.trigger.icon, equals(Icons.more_vert));
        expect(menu.items.length, equals(3));
        expect(menu.controller, equals(controller));
        expect(menu.onSelected, same(onSelected));
        expect(menu.onOpen, same(onOpen));
        expect(menu.onClose, same(onClose));
        expect(menu.onCanceled, same(onCanceled));
        expect(menu.onOpenRequested, same(onOpenRequested));
        expect(menu.onCloseRequested, same(onCloseRequested));
        expect(menu.consumeOutsideTaps, isFalse);
        expect(menu.useRootOverlay, isTrue);
        expect(menu.closeOnClickOutside, isFalse);
        expect(menu.triggerFocusNode, equals(focusNode));
        expect(menu.positioning, same(positioning));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = MenuStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<MenuSpec>>());
                expect(spec.spec, isA<MenuSpec>());
                expect(spec.spec.trigger, isA<StyleSpec<MenuTriggerSpec>>());
                expect(spec.spec.overlay, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.item, isA<StyleSpec<MenuItemSpec>>());
                expect(spec.spec.divider, isA<StyleSpec<DividerSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = MenuStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = MenuStyler();
        final style2 = MenuStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = MenuStyler().trigger(
          MenuTriggerStyler().padding(EdgeInsetsGeometryMix.all(16.0)),
        );
        final style2 = MenuStyler().trigger(
          MenuTriggerStyler().padding(EdgeInsetsGeometryMix.all(8.0)),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('MenuItemStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = MenuItemStyler();

        expect(style, isNotNull);
        expect(style, isA<MenuItemStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final leadingIcon = Prop.maybeMix(IconStyler());
        final trailingIcon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<MenuItemSpec>>[];

        final style = MenuItemStyler.create(
          container: container,
          label: label,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$label, equals(label));
        expect(style.$leadingIcon, equals(leadingIcon));
        expect(style.$trailingIcon, equals(trailingIcon));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = FlexBoxStyler();
        final labelStyler = TextStyler();
        final leadingIconStyler = IconStyler();
        final trailingIconStyler = IconStyler();

        final style = MenuItemStyler(
          container: containerStyler,
          label: labelStyler,
          leadingIcon: leadingIconStyler,
          trailingIcon: trailingIconStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$leadingIcon, isNotNull);
        expect(style.$trailingIcon, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'label',
        initial: MenuItemStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, Prop.maybeMix(TextStyler()));
        },
      );

      styleMethodTest(
        'leadingIcon',
        initial: MenuItemStyler(),
        modify: (style) => style.leadingIcon(IconStyler()),
        expect: (style) {
          expect(style.$leadingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'trailingIcon',
        initial: MenuItemStyler(),
        modify: (style) => style.trailingIcon(IconStyler()),
        expect: (style) {
          expect(style.$trailingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: MenuItemStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(style, equals(MenuItemStyler.alignment(Alignment.centerLeft)));
        },
      );

      styleMethodTest(
        'padding',
        initial: MenuItemStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(MenuItemStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: MenuItemStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(MenuItemStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'size',
        initial: MenuItemStyler(),
        modify: (style) => style.size(200.0, 48.0),
        expect: (style) {
          expect(style, equals(MenuItemStyler.size(200.0, 48.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: MenuItemStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(4.0)),
        expect: (style) {
          expect(
            style,
            equals(MenuItemStyler.borderRadius(BorderRadiusMix.circular(4.0))),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: MenuItemStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 150.0, minHeight: 36.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              MenuItemStyler.constraints(
                BoxConstraintsMix(minWidth: 150.0, minHeight: 36.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: MenuItemStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.grey,
            borderRadius: BorderRadiusMix.circular(4.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              MenuItemStyler.decoration(
                BoxDecorationMix(
                  color: Colors.grey,
                  borderRadius: BorderRadiusMix.circular(4.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: MenuItemStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(MenuItemStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: MenuItemStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.blue)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              MenuItemStyler.foregroundDecoration(
                BoxDecorationMix(
                  border: BoxBorderMix.all(BorderSideMix(color: Colors.blue)),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform',
        initial: MenuItemStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.center),
        expect: (style) {
          expect(
            style,
            equals(
              MenuItemStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.center,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: MenuItemStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$container,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: MenuItemStyler(),
        modify: (style) => style.variants(<VariantStyle<MenuItemSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<MenuItemSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: MenuItemStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = MenuItemStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<MenuItemSpec>>());
                expect(spec.spec, isA<MenuItemSpec>());
                expect(spec.spec.container, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.label, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.leadingIcon, isA<StyleSpec<IconSpec>>());
                expect(spec.spec.trailingIcon, isA<StyleSpec<IconSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = MenuItemStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = MenuItemStyler();
        final style2 = MenuItemStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = MenuItemStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = MenuItemStyler().padding(EdgeInsetsGeometryMix.all(8.0));

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
