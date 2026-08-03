import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('SelectStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SelectStyler();

        expect(style, isNotNull);
        expect(style, isA<SelectStyler>());
      });

      test('create constructor with all parameters', () {
        final menuContainer = Prop.maybeMix(FlexBoxStyler());
        final trigger = Prop.maybeMix(SelectTriggerStyler());
        final variants = <VariantStyle<SelectSpec>>[];

        final style = SelectStyler.create(
          menuContainer: menuContainer,
          trigger: trigger,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$menuContainer, equals(menuContainer));
        expect(style.$trigger, equals(trigger));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final menuContainerStyler = FlexBoxStyler();
        final triggerStyler = SelectTriggerStyler();

        final style = SelectStyler(
          menuContainer: menuContainerStyler,
          trigger: triggerStyler,
        );

        expect(style, isNotNull);
        expect(style.$menuContainer, isNotNull);
        expect(style.$trigger, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'menuContainer',
        initial: SelectStyler(),
        modify: (style) => style.menuContainer(
          FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(8.0)),
        ),
        expect: (style) {
          expect(
            style.$menuContainer,
            equals(
              Prop.maybeMix(
                FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(8.0)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'trigger',
        initial: SelectStyler(),
        modify: (style) =>
            style.trigger(SelectTriggerStyler().alignment(Alignment.center)),
        expect: (style) {
          expect(
            style.$trigger,
            equals(
              Prop.maybeMix(SelectTriggerStyler().alignment(Alignment.center)),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: SelectStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SelectStyler.foregroundDecoration(
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
        initial: SelectStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              SelectStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: SelectStyler(),
        modify: (style) => style.variants(<VariantStyle<SelectSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<SelectSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: SelectStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: SelectStyler(),
        modify: (style) =>
            style.animate(AnimationConfig.linear(const Duration(seconds: 1))),
        expect: (style) {
          expect(
            style.$animation,
            equals(AnimationConfig.linear(const Duration(seconds: 1))),
          );
        },
      );
    });

    group('Call Method', () {
      test('call method creates RemixSelect with required parameters', () {
        final style = SelectStyler();
        final trigger = RemixSelectTrigger(placeholder: 'Select');
        final items = [
          RemixSelectItem(value: 'a', label: 'A'),
          RemixSelectItem(value: 'b', label: 'B'),
        ];

        final select = style.call<String>(trigger: trigger, items: items);

        expect(select, isA<RemixSelect<String>>());
        expect(select.trigger, equals(trigger));
        expect(select.items, equals(items));
        expect(select.enabled, isTrue);
        expect(select.closeOnSelect, isTrue);
      });

      test('call method creates RemixSelect with all parameters', () {
        final style = SelectStyler();
        final trigger = RemixSelectTrigger(placeholder: 'Select');
        final items = [RemixSelectItem(value: 1, label: 'One')];
        final focusNode = FocusNode();

        final select = style.call<int>(
          trigger: trigger,
          items: items,
          selectedValue: 1,
          onChanged: (value) {},
          onOpen: () {},
          onClose: () {},
          enabled: false,
          closeOnSelect: false,
          semanticLabel: 'Test Select',
          focusNode: focusNode,
        );

        expect(select, isA<RemixSelect<int>>());
        expect(select.selectedValue, equals(1));
        expect(select.enabled, isFalse);
        expect(select.closeOnSelect, isFalse);
        expect(select.semanticLabel, equals('Test Select'));
        expect(select.focusNode, equals(focusNode));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SelectStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SelectSpec>>());
                expect(spec.spec, isA<SelectSpec>());
                expect(spec.spec.trigger, isA<StyleSpec<SelectTriggerSpec>>());
                expect(spec.spec.menuContainer, isA<StyleSpec<FlexBoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = SelectStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SelectStyler();
        final style2 = SelectStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SelectStyler().menuContainer(
          FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(8.0)),
        );
        final style2 = SelectStyler().menuContainer(
          FlexBoxStyler(padding: EdgeInsetsGeometryMix.all(16.0)),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('SelectTriggerStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SelectTriggerStyler();

        expect(style, isNotNull);
        expect(style, isA<SelectTriggerStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<SelectTriggerSpec>>[];

        final style = SelectTriggerStyler.create(
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
    });

    group('Style Methods', () {
      styleMethodTest(
        'label',
        initial: SelectTriggerStyler(),
        modify: (style) =>
            style.label(TextStyler(style: TextStyleMix(color: Colors.blue))),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'icon',
        initial: SelectTriggerStyler(),
        modify: (style) => style.icon(IconStyler(color: Colors.red)),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.red))),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: SelectTriggerStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(
            style,
            equals(SelectTriggerStyler.alignment(Alignment.center)),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: SelectTriggerStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              SelectTriggerStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: SelectTriggerStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(SelectTriggerStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: SelectTriggerStyler(),
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
              SelectTriggerStyler.decoration(
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
        'constraints',
        initial: SelectTriggerStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 50.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SelectTriggerStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 50.0),
              ),
            ),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SelectTriggerStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SelectTriggerSpec>>());
                expect(spec.spec, isA<SelectTriggerSpec>());
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
        final originalStyle = SelectTriggerStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SelectTriggerStyler();
        final style2 = SelectTriggerStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SelectTriggerStyler().label(
          TextStyler(style: TextStyleMix(color: Colors.blue)),
        );
        final style2 = SelectTriggerStyler().label(
          TextStyler(style: TextStyleMix(color: Colors.red)),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });

  group('SelectMenuItemStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SelectMenuItemStyler();

        expect(style, isNotNull);
        expect(style, isA<SelectMenuItemStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final text = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<SelectMenuItemSpec>>[];

        final style = SelectMenuItemStyler.create(
          container: container,
          text: text,
          icon: icon,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$text, equals(text));
        expect(style.$icon, equals(icon));
        expect(style.$variants, equals(variants));
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'text',
        initial: SelectMenuItemStyler(),
        modify: (style) =>
            style.text(TextStyler(style: TextStyleMix(color: Colors.blue))),
        expect: (style) {
          expect(
            style.$text,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'icon',
        initial: SelectMenuItemStyler(),
        modify: (style) => style.icon(IconStyler(color: Colors.red)),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.red))),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: SelectMenuItemStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(
            style,
            equals(SelectMenuItemStyler.alignment(Alignment.center)),
          );
        },
      );

      styleMethodTest(
        'label delegates to text',
        initial: SelectMenuItemStyler(),
        modify: (style) =>
            style.label(TextStyler(style: TextStyleMix(color: Colors.green))),
        expect: (style) {
          expect(
            style.$text,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: SelectMenuItemStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              SelectMenuItemStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: SelectMenuItemStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.blue)),
        expect: (style) {
          expect(
            style,
            equals(
              SelectMenuItemStyler.decoration(
                BoxDecorationMix(color: Colors.blue),
              ),
            ),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SelectMenuItemStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SelectMenuItemSpec>>());
                expect(spec.spec, isA<SelectMenuItemSpec>());
                expect(spec.spec.container, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.text, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.icon, isA<StyleSpec<IconSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = SelectMenuItemStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SelectMenuItemStyler();
        final style2 = SelectMenuItemStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SelectMenuItemStyler().text(
          TextStyler(style: TextStyleMix(color: Colors.blue)),
        );
        final style2 = SelectMenuItemStyler().text(
          TextStyler(style: TextStyleMix(color: Colors.red)),
        );

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
