import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('AccordionStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = AccordionStyler();

        expect(style, isNotNull);
        expect(style, isA<AccordionStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final containerEffects = Prop.maybeMix(
          RemixBoxEffectsMix(backdropBlur: 4),
        );
        final trigger = Prop.maybeMix(FlexBoxStyler());
        final leadingIcon = Prop.maybeMix(IconStyler());
        final title = Prop.maybeMix(TextStyler());
        final trailingIcon = Prop.maybeMix(IconStyler());
        final content = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<AccordionSpec>>[];

        final style = AccordionStyler.create(
          container: container,
          containerEffects: containerEffects,
          trigger: trigger,
          leadingIcon: leadingIcon,
          title: title,
          trailingIcon: trailingIcon,
          content: content,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$containerEffects, equals(containerEffects));
        expect(style.$trigger, equals(trigger));
        expect(style.$leadingIcon, equals(leadingIcon));
        expect(style.$title, equals(title));
        expect(style.$trailingIcon, equals(trailingIcon));
        expect(style.$content, equals(content));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();
        final containerEffects = RemixBoxEffectsMix(backdropBlur: 4);
        final triggerStyler = FlexBoxStyler();
        final titleStyler = TextStyler();
        final contentStyler = BoxStyler();

        final style = AccordionStyler(
          container: containerStyler,
          containerEffects: containerEffects,
          trigger: triggerStyler,
          title: titleStyler,
          content: contentStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$containerEffects, isNotNull);
        expect(style.$trigger, isNotNull);
        expect(style.$title, isNotNull);
        expect(style.$content, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'container',
        initial: AccordionStyler(),
        modify: (style) => style.container(BoxStyler()),
        expect: (style) {
          expect(style.$container, equals(Prop.maybeMix(BoxStyler())));
        },
      );

      styleMethodTest(
        'containerEffects',
        initial: AccordionStyler(),
        modify: (style) =>
            style.containerEffects(RemixBoxEffectsMix(backdropBlur: 4)),
        expect: (style) {
          expect(
            style.$containerEffects,
            equals(Prop.maybeMix(RemixBoxEffectsMix(backdropBlur: 4))),
          );
        },
      );

      styleMethodTest(
        'trigger',
        initial: AccordionStyler(),
        modify: (style) => style.trigger(FlexBoxStyler()),
        expect: (style) {
          expect(style.$trigger, equals(Prop.maybeMix(FlexBoxStyler())));
        },
      );

      styleMethodTest(
        'leadingIcon',
        initial: AccordionStyler(),
        modify: (style) => style.leadingIcon(IconStyler()),
        expect: (style) {
          expect(style.$leadingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'title',
        initial: AccordionStyler(),
        modify: (style) => style.title(TextStyler()),
        expect: (style) {
          expect(style.$title, equals(Prop.maybeMix(TextStyler())));
        },
      );

      styleMethodTest(
        'trailingIcon',
        initial: AccordionStyler(),
        modify: (style) => style.trailingIcon(IconStyler()),
        expect: (style) {
          expect(style.$trailingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'content',
        initial: AccordionStyler(),
        modify: (style) => style.content(BoxStyler()),
        expect: (style) {
          expect(style.$content, equals(Prop.maybeMix(BoxStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: AccordionStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(AccordionStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: AccordionStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(AccordionStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: AccordionStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(AccordionStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: AccordionStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(AccordionStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'decoration',
        initial: AccordionStyler(),
        modify: (style) => style.decoration(
          BoxDecorationMix(
            color: Colors.red,
            borderRadius: BorderRadiusMix.circular(8.0),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              AccordionStyler.decoration(
                BoxDecorationMix(
                  color: Colors.red,
                  borderRadius: BorderRadiusMix.circular(8.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: AccordionStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              AccordionStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size',
        initial: AccordionStyler(),
        modify: (style) => style.size(200.0, 50.0),
        expect: (style) {
          expect(style, equals(AccordionStyler.size(200.0, 50.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: AccordionStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              AccordionStyler.borderRadius(BorderRadiusMix.circular(12.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: AccordionStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              AccordionStyler.foregroundDecoration(
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
        initial: AccordionStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              AccordionStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: AccordionStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$trigger,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'backgroundColor',
        initial: AccordionStyler(),
        modify: (style) => style.backgroundColor(Colors.red),
        expect: (style) {
          expect(
            style.$trigger,
            equals(
              Prop.maybeMix(
                FlexBoxStyler(decoration: BoxDecorationMix(color: Colors.red)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'spacing',
        initial: AccordionStyler(),
        modify: (style) => style.spacing(8.0),
        expect: (style) {
          expect(style, equals(AccordionStyler.spacing(8.0)));
        },
      );

      styleMethodTest(
        'titleColor',
        initial: AccordionStyler(),
        modify: (style) => style.titleColor(Colors.blue),
        expect: (style) {
          expect(
            style.$title,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'titleFontSize',
        initial: AccordionStyler(),
        modify: (style) => style.titleFontSize(20.0),
        expect: (style) {
          expect(
            style.$title,
            equals(
              Prop.maybeMix(TextStyler(style: TextStyleMix(fontSize: 20.0))),
            ),
          );
        },
      );

      styleMethodTest(
        'titleFontWeight',
        initial: AccordionStyler(),
        modify: (style) => style.titleFontWeight(FontWeight.bold),
        expect: (style) {
          expect(
            style.$title,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'titleStyle',
        initial: AccordionStyler(),
        modify: (style) =>
            style.titleStyle(TextStyleMix(color: Colors.green, fontSize: 18.0)),
        expect: (style) {
          expect(
            style.$title,
            equals(
              Prop.maybeMix(
                TextStyler(
                  style: TextStyleMix(color: Colors.green, fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'leadingIconColor',
        initial: AccordionStyler(),
        modify: (style) => style.leadingIconColor(Colors.orange),
        expect: (style) {
          expect(
            style.$leadingIcon,
            equals(Prop.maybeMix(IconStyler(color: Colors.orange))),
          );
        },
      );

      styleMethodTest(
        'leadingIconSize',
        initial: AccordionStyler(),
        modify: (style) => style.leadingIconSize(24.0),
        expect: (style) {
          expect(
            style.$leadingIcon,
            equals(Prop.maybeMix(IconStyler(size: 24.0))),
          );
        },
      );

      styleMethodTest(
        'trailingIconColor',
        initial: AccordionStyler(),
        modify: (style) => style.trailingIconColor(Colors.purple),
        expect: (style) {
          expect(
            style.$trailingIcon,
            equals(Prop.maybeMix(IconStyler(color: Colors.purple))),
          );
        },
      );

      styleMethodTest(
        'trailingIconSize',
        initial: AccordionStyler(),
        modify: (style) => style.trailingIconSize(16.0),
        expect: (style) {
          expect(
            style.$trailingIcon,
            equals(Prop.maybeMix(IconStyler(size: 16.0))),
          );
        },
      );

      styleMethodTest(
        'contentColor',
        initial: AccordionStyler(),
        modify: (style) => style.contentColor(Colors.grey),
        expect: (style) {
          expect(
            style.$content,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'contentPadding',
        initial: AccordionStyler(),
        modify: (style) =>
            style.contentPadding(EdgeInsetsGeometryMix.all(12.0)),
        expect: (style) {
          expect(
            style.$content,
            equals(
              Prop.maybeMix(
                BoxStyler(padding: EdgeInsetsGeometryMix.all(12.0)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'contentDecoration',
        initial: AccordionStyler(),
        modify: (style) =>
            style.contentDecoration(BoxDecorationMix(color: Colors.white)),
        expect: (style) {
          expect(
            style.$content,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.white)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'wrap',
        initial: AccordionStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'variants',
        initial: AccordionStyler(),
        modify: (style) => style.variants(<VariantStyle<AccordionSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<AccordionSpec>>[]));
        },
      );
    });

    group('Factory Constructors', () {
      test('container factory', () {
        final style = AccordionStyler.container(BoxStyler());
        expect(style.$container, isNotNull);
      });

      test('containerEffects factory', () {
        final style = AccordionStyler.containerEffects(
          RemixBoxEffectsMix(backdropBlur: 4),
        );
        expect(style.$containerEffects, isNotNull);
      });

      test('color factory', () {
        final style = AccordionStyler.color(Colors.red);
        expect(style.$trigger, isNotNull);
      });

      test('padding factory', () {
        final style = AccordionStyler.padding(EdgeInsetsGeometryMix.all(16.0));
        expect(style.$trigger, isNotNull);
      });

      test('margin factory', () {
        final style = AccordionStyler.margin(EdgeInsetsGeometryMix.all(8.0));
        expect(style.$trigger, isNotNull);
      });

      test('decoration factory', () {
        final style = AccordionStyler.decoration(
          BoxDecorationMix(color: Colors.blue),
        );
        expect(style.$trigger, isNotNull);
      });

      test('alignment factory', () {
        final style = AccordionStyler.alignment(Alignment.center);
        expect(style.$trigger, isNotNull);
      });

      test('constraints factory', () {
        final style = AccordionStyler.constraints(
          BoxConstraintsMix(minWidth: 100.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('borderRadius factory', () {
        final style = AccordionStyler.borderRadius(
          BorderRadiusMix.circular(8.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('spacing factory', () {
        final style = AccordionStyler.spacing(8.0);
        expect(style.$trigger, isNotNull);
      });

      test('title factory', () {
        final style = AccordionStyler.title(
          TextStyler(style: TextStyleMix(color: Colors.red)),
        );
        expect(style.$title, isNotNull);
      });

      test('leadingIcon factory', () {
        final style = AccordionStyler.leadingIcon(
          IconStyler(color: Colors.green, size: 24.0),
        );
        expect(style.$leadingIcon, isNotNull);
      });

      test('trailingIcon factory', () {
        final style = AccordionStyler.trailingIcon(
          IconStyler(color: Colors.purple, size: 16.0),
        );
        expect(style.$trailingIcon, isNotNull);
      });

      test('content factory', () {
        final style = AccordionStyler.content(
          BoxStyler(
            padding: EdgeInsetsGeometryMix.all(12.0),
            decoration: BoxDecorationMix(color: Colors.white),
          ),
        );
        expect(style.$content, isNotNull);
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = AccordionStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<AccordionSpec>>());
                expect(spec.spec, isA<AccordionSpec>());
                expect(spec.spec.trigger, isA<StyleSpec<FlexBoxSpec>>());
                expect(spec.spec.leadingIcon, isA<StyleSpec<IconSpec>>());
                expect(spec.spec.title, isA<StyleSpec<TextSpec>>());
                expect(spec.spec.trailingIcon, isA<StyleSpec<IconSpec>>());
                expect(spec.spec.content, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge combines two styles', () {
        final style1 = AccordionStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );
        final style2 = AccordionStyler().color(Colors.blue);

        final merged = style1.merge(style2);

        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged.$trigger, isNotNull);
      });

      test('call creates RemixAccordion with this style', () {
        final style = AccordionStyler().backgroundColor(Colors.blue);

        final accordion = style.call<String>(
          value: 'details',
          title: 'Details',
          child: const Text('Content'),
          enabled: false,
        );

        expect(accordion, isA<RemixAccordion<String>>());
        expect(accordion.style, same(style));
        expect(accordion.value, 'details');
        expect(accordion.title, 'Details');
        expect(accordion.child, isA<Text>());
        expect(accordion.enabled, isFalse);
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = AccordionStyler();
        final style2 = AccordionStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = AccordionStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = AccordionStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });
    });

    group('Props', () {
      test('props list contains all properties', () {
        final style = AccordionStyler();

        expect(style.props, hasLength(10));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$containerEffects));
        expect(style.props, contains(style.$trigger));
        expect(style.props, contains(style.$leadingIcon));
        expect(style.props, contains(style.$title));
        expect(style.props, contains(style.$trailingIcon));
        expect(style.props, contains(style.$content));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });
  });
}
