import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('ToggleStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = ToggleStyler();

        expect(style, isNotNull);
        expect(style, isA<ToggleStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(FlexBoxStyler());
        final label = Prop.maybeMix(TextStyler());
        final icon = Prop.maybeMix(IconStyler());
        final variants = <VariantStyle<ToggleSpec>>[];

        final style = ToggleStyler.create(
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

        final style = ToggleStyler(
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
        initial: ToggleStyler(),
        modify: (style) => style.label(TextStyler()),
        expect: (style) {
          expect(style.$label, Prop.maybeMix(TextStyler()));
        },
      );

      styleMethodTest(
        'icon',
        initial: ToggleStyler(),
        modify: (style) => style.icon(IconStyler()),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler())));
        },
      );

      styleMethodTest(
        'alignment',
        initial: ToggleStyler(),
        modify: (style) => style.alignment(Alignment.centerLeft),
        expect: (style) {
          expect(style, equals(ToggleStyler.alignment(Alignment.centerLeft)));
        },
      );

      styleMethodTest(
        'backgroundColor',
        initial: ToggleStyler(),
        modify: (style) => style.backgroundColor(Colors.blue),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                FlexBoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'padding',
        initial: ToggleStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(ToggleStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: ToggleStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(ToggleStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: ToggleStyler(),
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
              ToggleStyler.decoration(
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
        'spacing',
        initial: ToggleStyler(),
        modify: (style) => style.spacing(12.0),
        expect: (style) {
          expect(style, equals(ToggleStyler.spacing(12.0)));
        },
      );

      styleMethodTest(
        'constraints',
        initial: ToggleStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ToggleStyler.constraints(
                BoxConstraintsMix(minWidth: 100.0, minHeight: 40.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'foregroundDecoration',
        initial: ToggleStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              ToggleStyler.foregroundDecoration(
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
        initial: ToggleStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              ToggleStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'flex',
        initial: ToggleStyler(),
        modify: (style) => style.flex(FlexStyler()),
        expect: (style) {
          expect(
            style.$container,
            equals(Prop.maybeMix(FlexBoxStyler().flex(FlexStyler()))),
          );
        },
      );

      styleMethodTest(
        'labelColor',
        initial: ToggleStyler(),
        modify: (style) => style.labelColor(Colors.white),
        expect: (style) {
          expect(
            style.$label,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.white)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'iconColor',
        initial: ToggleStyler(),
        modify: (style) => style.iconColor(Colors.blue),
        expect: (style) {
          expect(
            style.$icon,
            equals(Prop.maybeMix(IconStyler(color: Colors.blue))),
          );
        },
      );

      styleMethodTest(
        'iconSize',
        initial: ToggleStyler(),
        modify: (style) => style.iconSize(24.0),
        expect: (style) {
          expect(style.$icon, equals(Prop.maybeMix(IconStyler(size: 24.0))));
        },
      );

      styleMethodTest(
        'variants',
        initial: ToggleStyler(),
        modify: (style) => style.variants(<VariantStyle<ToggleSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<ToggleSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: ToggleStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: ToggleStyler(),
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
      test('call method creates RemixToggle with required parameters', () {
        final style = ToggleStyler();
        final onChanged = (bool v) {};

        final toggle = style.call(
          selected: false,
          onChanged: onChanged,
          label: 'Test Toggle',
        );

        expect(toggle, isA<RemixToggle>());
        expect(toggle.label, equals('Test Toggle'));
        expect(toggle.onChanged, equals(onChanged));
      });

      test('call method creates RemixToggle with all parameters', () {
        final style = ToggleStyler();
        final focusNode = FocusNode();

        final toggle = style.call(
          selected: true,
          onChanged: (value) {},
          label: 'Bold',
          icon: Icons.format_bold,
          enabled: false,
          enableFeedback: false,
          focusNode: focusNode,
          autofocus: true,
          semanticLabel: 'Test Toggle',
          mouseCursor: SystemMouseCursors.forbidden,
        );

        expect(toggle, isA<RemixToggle>());
        expect(toggle.selected, isTrue);
        expect(toggle.label, equals('Bold'));
        expect(toggle.icon, equals(Icons.format_bold));
        expect(toggle.enabled, isFalse);
        expect(toggle.enableFeedback, isFalse);
        expect(toggle.focusNode, equals(focusNode));
        expect(toggle.autofocus, isTrue);
        expect(toggle.semanticLabel, equals('Test Toggle'));
        expect(toggle.mouseCursor, equals(SystemMouseCursors.forbidden));

        focusNode.dispose();
      });
    });

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = ToggleStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<ToggleSpec>>());
                expect(spec.spec, isA<ToggleSpec>());
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
        final originalStyle = ToggleStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines properties correctly', () {
        final style1 = ToggleStyler(
          container: FlexBoxStyler(alignment: Alignment.centerLeft),
        );
        final style2 = ToggleStyler(
          label: TextStyler(style: TextStyleMix(color: Colors.blue)),
        );

        final merged = style1.merge(style2);

        expect(
          merged.$container,
          equals(Prop.maybeMix(FlexBoxStyler(alignment: Alignment.centerLeft))),
        );
        expect(
          merged.$label,
          equals(
            Prop.maybeMix(TextStyler(style: TextStyleMix(color: Colors.blue))),
          ),
        );
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = ToggleStyler();
        final style2 = ToggleStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = ToggleStyler().padding(EdgeInsetsGeometryMix.all(16.0));
        final style2 = ToggleStyler().padding(EdgeInsetsGeometryMix.all(8.0));

        expect(style1, isNot(equals(style2)));
      });

      test('props list contains all properties', () {
        final style = ToggleStyler();

        expect(style.props, hasLength(6));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$label));
        expect(style.props, contains(style.$icon));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });
  });
}
