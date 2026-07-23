import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixAccordionStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = RemixAccordionStyler();

        expect(style, isNotNull);
        expect(style, isA<RemixAccordionStyler>());
      });

      test('create constructor with all parameters', () {
        final trigger = Prop.maybeMix(FlexBoxStyler());
        final leadingIcon = Prop.maybeMix(IconStyler());
        final title = Prop.maybeMix(TextStyler());
        final trailingIcon = Prop.maybeMix(IconStyler());
        final content = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<RemixAccordionSpec>>[];

        final style = RemixAccordionStyler.create(
          trigger: trigger,
          leadingIcon: leadingIcon,
          title: title,
          trailingIcon: trailingIcon,
          content: content,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$trigger, equals(trigger));
        expect(style.$leadingIcon, equals(leadingIcon));
        expect(style.$title, equals(title));
        expect(style.$trailingIcon, equals(trailingIcon));
        expect(style.$content, equals(content));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final triggerStyler = FlexBoxStyler();
        final titleStyler = TextStyler();
        final contentStyler = BoxStyler();

        final style = RemixAccordionStyler(
          trigger: triggerStyler,
          title: titleStyler,
          content: contentStyler,
        );

        expect(style, isNotNull);
        expect(style.$trigger, isNotNull);
        expect(style.$title, isNotNull);
        expect(style.$content, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'trigger',
        initial: RemixAccordionStyler(),
        modify: (style) => style.trigger(FlexBoxStyler()),
        expect: (style) {
          expect(style.$trigger, equals(Prop.maybeMix(FlexBoxStyler())));
        },
      );

      styleMethodTest(
        'leadingIcon',
        initial: RemixAccordionStyler(),
        modify: (style) => style.leadingIcon(IconStyler()),
        expect: (style) {
          expect(style.$leadingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'title',
        initial: RemixAccordionStyler(),
        modify: (style) => style.title(TextStyler()),
        expect: (style) {
          expect(style.$title, equals(Prop.maybeMix(TextStyler())));
        },
      );

      styleMethodTest(
        'trailingIcon',
        initial: RemixAccordionStyler(),
        modify: (style) => style.trailingIcon(IconStyler()),
        expect: (style) {
          expect(style.$trailingIcon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'content',
        initial: RemixAccordionStyler(),
        modify: (style) => style.content(BoxStyler()),
        expect: (style) {
          expect(style.$content, equals(Prop.maybeMix(BoxStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: RemixAccordionStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(
            style,
            equals(RemixAccordionStyler.alignment(Alignment.centerLeft)),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: RemixAccordionStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixAccordionStyler.padding(EdgeInsetsGeometryMix.all(16.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: RemixAccordionStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(RemixAccordionStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'color',
        initial: RemixAccordionStyler(),
        modify: (style) => style.color(Colors.blue),
        expect: (style) {
          expect(style, equals(RemixAccordionStyler.color(Colors.blue)));
        },
      );

      styleMethodTest(
        'decoration',
        initial: RemixAccordionStyler(),
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
              RemixAccordionStyler.decoration(
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
        initial: RemixAccordionStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixAccordionStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'size',
        initial: RemixAccordionStyler(),
        modify: (style) => style.size(200.0, 50.0),
        expect: (style) {
          expect(style, equals(RemixAccordionStyler.size(200.0, 50.0)));
        },
      );

      styleMethodTest(
        'borderRadius',
        initial: RemixAccordionStyler(),
        modify: (style) => style.borderRadius(BorderRadiusMix.circular(12.0)),
        expect: (style) {
          expect(
            style,
            equals(
              RemixAccordionStyler.borderRadius(BorderRadiusMix.circular(12.0)),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: RemixAccordionStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              RemixAccordionStyler.foregroundDecoration(
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
        initial: RemixAccordionStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              RemixAccordionStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
        modify: (style) => style.spacing(8.0),
        expect: (style) {
          expect(style, equals(RemixAccordionStyler.spacing(8.0)));
        },
      );

      styleMethodTest(
        'titleColor',
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
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
        initial: RemixAccordionStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'variants',
        initial: RemixAccordionStyler(),
        modify: (style) => style.variants(<VariantStyle<RemixAccordionSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<RemixAccordionSpec>>[]));
        },
      );
    });

    group('Factory Constructors', () {
      test('color factory', () {
        final style = RemixAccordionStyler.color(Colors.red);
        expect(style.$trigger, isNotNull);
      });

      test('padding factory', () {
        final style = RemixAccordionStyler.padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('margin factory', () {
        final style = RemixAccordionStyler.margin(
          EdgeInsetsGeometryMix.all(8.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('decoration factory', () {
        final style = RemixAccordionStyler.decoration(
          BoxDecorationMix(color: Colors.blue),
        );
        expect(style.$trigger, isNotNull);
      });

      test('alignment factory', () {
        final style = RemixAccordionStyler.alignment(Alignment.center);
        expect(style.$trigger, isNotNull);
      });

      test('constraints factory', () {
        final style = RemixAccordionStyler.constraints(
          BoxConstraintsMix(minWidth: 100.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('borderRadius factory', () {
        final style = RemixAccordionStyler.borderRadius(
          BorderRadiusMix.circular(8.0),
        );
        expect(style.$trigger, isNotNull);
      });

      test('spacing factory', () {
        final style = RemixAccordionStyler.spacing(8.0);
        expect(style.$trigger, isNotNull);
      });

      test('title factory', () {
        final style = RemixAccordionStyler.title(
          TextStyler(style: TextStyleMix(color: Colors.red)),
        );
        expect(style.$title, isNotNull);
      });

      test('leadingIcon factory', () {
        final style = RemixAccordionStyler.leadingIcon(
          IconStyler(color: Colors.green, size: 24.0),
        );
        expect(style.$leadingIcon, isNotNull);
      });

      test('trailingIcon factory', () {
        final style = RemixAccordionStyler.trailingIcon(
          IconStyler(color: Colors.purple, size: 16.0),
        );
        expect(style.$trailingIcon, isNotNull);
      });

      test('content factory', () {
        final style = RemixAccordionStyler.content(
          BoxStyler(
            padding: EdgeInsetsGeometryMix.all(12.0),
            decoration: BoxDecorationMix(color: Colors.white),
          ),
        );
        expect(style.$content, isNotNull);
      });
    });

    group('Fortal styles', () {
      test('default style is surface size2', () {
        final defaultStyle = fortalAccordionStyler();
        final explicitStyle = fortalAccordionStyler(
          variant: FortalAccordionVariant.surface,
          size: FortalAccordionSize.size2,
        );

        expect(defaultStyle, equals(explicitStyle));
      });

      test('variant and size enums create distinct styles', () {
        final surface = fortalAccordionStyler(variant: .surface);
        final soft = fortalAccordionStyler(variant: .soft);
        final small = fortalAccordionStyler(size: .size1);
        final large = fortalAccordionStyler(size: .size3);

        expect(surface, isNot(equals(soft)));
        expect(small, isNot(equals(large)));
      });

      test('all variant and size combinations produce complete styles', () {
        for (final variant in FortalAccordionVariant.values) {
          for (final size in FortalAccordionSize.values) {
            final style = fortalAccordionStyler(variant: variant, size: size);

            expect(style.$trigger, isNotNull);
            expect(style.$title, isNotNull);
            expect(style.$trailingIcon, isNotNull);
            expect(style.$content, isNotNull);
          }
        }
      });

      testWidgets('uses scaled type, icon, and radius tokens', (tester) async {
        final scaled = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(size: .size2),
          scaling: .percent110,
        );
        final square = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(size: .size2),
          radius: .none,
        );

        expect(scaled.title.spec.style?.fontSize, closeTo(16.5, 1e-9));
        expect(scaled.title.spec.style?.height, closeTo(20 / 15, 1e-9));
        expect(scaled.title.spec.style?.fontWeight, FontWeight.w500);
        expect(scaled.trailingIcon.spec.size, closeTo(22, 1e-9));
        expect(_triggerRadius(scaled), closeTo(8.8, 1e-9));
        expect(_triggerRadius(square), 0);
      });

      testWidgets('defines hover, press, focus, and disabled precedence', (
        tester,
      ) async {
        final hovered = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(),
          states: {WidgetState.hovered},
        );
        final pressed = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(),
          states: {WidgetState.pressed},
        );
        final focused = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(),
          states: {WidgetState.focused},
        );
        final disabled = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(),
          states: {
            WidgetState.disabled,
            WidgetState.hovered,
            WidgetState.pressed,
          },
        );
        final softPressed = await _resolveFortalAccordionStyle(
          tester,
          fortalAccordionStyler(variant: .soft),
          states: {WidgetState.pressed},
        );

        expect(_triggerColor(hovered), slate.light.scale.step(2));
        expect(_triggerColor(pressed), slate.light.scale.step(3));
        expect(
          _triggerBorder(focused).top.color,
          indigo.light.scale.alphaStep(8),
        );
        expect(_triggerBorder(focused).top.width, 2);
        expect(_triggerColor(disabled), slate.light.scale.alphaStep(3));
        expect(disabled.title.spec.style?.color, slate.light.scale.step(8));
        expect(_triggerColor(softPressed), indigo.light.scale.step(4));
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = RemixAccordionStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<RemixAccordionSpec>>());
                expect(spec.spec, isA<RemixAccordionSpec>());
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
        final style1 = RemixAccordionStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );
        final style2 = RemixAccordionStyler().color(Colors.blue);

        final merged = style1.merge(style2);

        expect(merged, isNot(same(style1)));
        expect(merged, isNot(same(style2)));
        expect(merged.$trigger, isNotNull);
      });

      test('call creates RemixAccordion with this style', () {
        final style = RemixAccordionStyler().backgroundColor(Colors.blue);

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
        final style1 = RemixAccordionStyler();
        final style2 = RemixAccordionStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = RemixAccordionStyler().padding(
          EdgeInsetsGeometryMix.all(16.0),
        );
        final style2 = RemixAccordionStyler().padding(
          EdgeInsetsGeometryMix.all(8.0),
        );

        expect(style1, isNot(equals(style2)));
      });
    });

    group('Props', () {
      test('props list contains all properties', () {
        final style = RemixAccordionStyler();

        expect(style.props, hasLength(8));
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

Future<RemixAccordionSpec> _resolveFortalAccordionStyle(
  WidgetTester tester,
  RemixAccordionStyler style, {
  Set<WidgetState> states = const {},
  FortalScaling scaling = .percent100,
  FortalRadius radius = .medium,
}) async {
  late RemixAccordionSpec resolved;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
      radius: radius,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              resolved = style.build(context).spec;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return resolved;
}

BoxDecoration _triggerDecoration(RemixAccordionSpec spec) =>
    spec.trigger.spec.box!.spec.decoration! as BoxDecoration;

Color? _triggerColor(RemixAccordionSpec spec) => _triggerDecoration(spec).color;

Border _triggerBorder(RemixAccordionSpec spec) =>
    _triggerDecoration(spec).border! as Border;

double _triggerRadius(RemixAccordionSpec spec) =>
    (_triggerDecoration(spec).borderRadius! as BorderRadius).topLeft.x;
