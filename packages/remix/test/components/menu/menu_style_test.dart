import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixMenuTriggerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixMenuTriggerStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixMenuTriggerStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<RemixMenuTriggerSpec>>[];

        final style = RemixMenuTriggerStyler.create(
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

        final style = RemixMenuTriggerStyler(
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
        initial: RemixMenuTriggerStyler(),
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
        initial: RemixMenuTriggerStyler(),
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
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(RemixMenuTriggerStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'alignment',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixMenuTriggerStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'size',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.size(100.0, 50.0),
        expect: (style) {
          expect(style, equals(RemixMenuTriggerStyler.size(100.0, 50.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(8.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.borderRadius(
                BorderRadiusMix.circular(8.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: RemixMenuTriggerStyler(),
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
              RemixMenuTriggerStyler.decoration(
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
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.margin(EdgeInsetsGeometryMix.all(8.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: RemixMenuTriggerStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.foregroundDecoration(
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
        initial: RemixMenuTriggerStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuTriggerStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: RemixMenuTriggerStyler(),
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
        initial: RemixMenuTriggerStyler(),
        modify: (style) =>
            style.variants(<VariantStyle<RemixMenuTriggerSpec>>[]),
        expect: (style) {
          expect(
            style.$variants,
            equals(<VariantStyle<RemixMenuTriggerSpec>>[]),
          );
        },
      );

      styleMethodTest(
        'wrap',
        initial: RemixMenuTriggerStyler(),
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
        final style = RemixMenuTriggerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixMenuTriggerSpec>>());
                expect(spec.spec, isA<RemixMenuTriggerSpec>());
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
        final originalStyle = RemixMenuTriggerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RemixMenuTriggerStyler();
        final style2 = RemixMenuTriggerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixMenuTriggerStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = RemixMenuTriggerStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('RemixMenuStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixMenuStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixMenuStyler>());
      });

      test('create constructor with all parameters', () {
        final trigger = Prop.maybeMix(RemixMenuTriggerStyler());
        final overlay = Prop.maybeMix(FlexBoxStyler());
        final item = Prop.maybeMix(RemixMenuItemStyler());
        final divider = Prop.maybeMix(RemixDividerStyler());
        final variants = <VariantStyle<RemixMenuSpec>>[];

        final style = RemixMenuStyler.create(
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
        final triggerStyle = RemixMenuTriggerStyler();
        final overlayStyler = FlexBoxStyler();
        final itemStyle = RemixMenuItemStyler();
        final dividerStyle = RemixDividerStyler();

        final style = RemixMenuStyler(
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
        initial: RemixMenuStyler(),
        modify: (style) => style.trigger(RemixMenuTriggerStyler()),
        expect: (style) {
          expect(
            style.$trigger,
            equals(Prop.maybeMix(RemixMenuTriggerStyler())),
          );
        },
      );

      styleMethodTest(
        'overlay',
        initial: RemixMenuStyler(),
        modify: (style) => style.overlay(FlexBoxStyler()),
        expect: (style) {
          expect(style.$overlay, equals(Prop.maybeMix(FlexBoxStyler())));
        },
      );

      styleMethodTest(
        'item',
        initial: RemixMenuStyler(),
        modify: (style) => style.item(RemixMenuItemStyler()),
        expect: (style) {
          expect(style.$item, equals(Prop.maybeMix(RemixMenuItemStyler())));
        },
      );

      styleMethodTest(
        'divider',
        initial: RemixMenuStyler(),
        modify: (style) => style.divider(RemixDividerStyler()),
        expect: (style) {
          expect(style.$divider, equals(Prop.maybeMix(RemixDividerStyler())));
        },
      );

      styleMethodTest(
        'variants',
        initial: RemixMenuStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixMenuSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixMenuSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: RemixMenuStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixMenu with required parameters', () {
        final style = RemixMenuStyler();

        final menu = style.call<String>(
          trigger: const RemixMenuTrigger(label: 'Options'),
          items: [const RemixMenuItem<String>(value: 'copy', label: 'Copy')],
        );

        expect(menu, isA<RemixMenu<String>>());
        expect(menu.trigger.label, equals('Options'));
        expect(menu.items.length, equals(1));
      });

      test('call method creates RemixMenu with all parameters', () {
        final style = RemixMenuStyler();
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
        final style = RemixMenuStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixMenuSpec>>());
                expect(spec.spec, isA<RemixMenuSpec>());
                expect(
                  spec.spec.trigger,
                  isA<StyleSpec<RemixMenuTriggerSpec>>(),
                );
                expect(spec.spec.overlay, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.item, isA<StyleSpec<RemixMenuItemSpec>>());
                expect(spec.spec.divider, isA<StyleSpec<RemixDividerSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = RemixMenuStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RemixMenuStyler();
        final style2 = RemixMenuStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixMenuStyler().trigger(
          RemixMenuTriggerStyler().padding(EdgeInsetsGeometryMix.all(16.0)),
        );
        final style2 = RemixMenuStyler().trigger(
          RemixMenuTriggerStyler().padding(EdgeInsetsGeometryMix.all(8.0)),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('RemixMenuItemStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixMenuItemStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixMenuItemStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final leadingIcon = Prop.maybeMix(IconStyler());
        final trailingIcon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<RemixMenuItemSpec>>[];

        final style = RemixMenuItemStyler.create(
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

        final style = RemixMenuItemStyler(
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
        initial: RemixMenuItemStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, Prop.maybeMix(TextStyler()));
        },
      );

      styleMethodTest(
        'leadingIcon',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.leadingIcon(IconStyler()),
        expect: (style) {
          expect(style.$leadingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'trailingIcon',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.trailingIcon(IconStyler()),
        expect: (style) {
          expect(style.$trailingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixMenuItemStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuItemStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(RemixMenuItemStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'size',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.size(200.0, 48.0),
        expect: (style) {
          expect(style, equals(RemixMenuItemStyler.size(200.0, 48.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(4.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuItemStyler.borderRadius(BorderRadiusMix.circular(4.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 150.0, minHeight: 36.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuItemStyler.constraints(
                BoxConstraintsMix(minWidth: 150.0, minHeight: 36.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: RemixMenuItemStyler(),
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
              RemixMenuItemStyler.decoration(
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
        initial: RemixMenuItemStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(4.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixMenuItemStyler.margin(EdgeInsetsGeometryMix.all(4.0))),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: RemixMenuItemStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.blue)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuItemStyler.foregroundDecoration(
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
        initial: RemixMenuItemStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.center),
        expect: (style) {
          expect(
            style,
            equals(
              RemixMenuItemStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.center,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: RemixMenuItemStyler(),
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
        initial: RemixMenuItemStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixMenuItemSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixMenuItemSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: RemixMenuItemStyler(),
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
        final style = RemixMenuItemStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixMenuItemSpec>>());
                expect(spec.spec, isA<RemixMenuItemSpec>());
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
        final originalStyle = RemixMenuItemStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = RemixMenuItemStyler();
        final style2 = RemixMenuItemStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixMenuItemStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = RemixMenuItemStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
