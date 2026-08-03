import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('SwitchStyler', () {
    group('Constructors', () {
      test('default constructor creates valid instance', () {
        final style = SwitchStyler();

        expect(style, isNotNull);
        expect(style, isA<SwitchStyler>());
      });

      test('create constructor with all parameters', () {
        final container = Prop.maybeMix(BoxStyler());
        final thumb = Prop.maybeMix(BoxStyler());
        final variants = <VariantStyle<SwitchSpec>>[];

        final style = SwitchStyler.create(
          container: container,
          thumb: thumb,
          variants: variants,
        );

        expect(style, isNotNull);
        expect(style.$container, equals(container));
        expect(style.$thumb, equals(thumb));
        expect(style.$variants, equals(variants));
      });

      test('constructor with styler parameters', () {
        final containerStyler = BoxStyler();
        final thumbStyler = BoxStyler();

        final style = SwitchStyler(
          container: containerStyler,
          thumb: thumbStyler,
        );

        expect(style, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$thumb, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'thumbColor',
        initial: SwitchStyler(),
        modify: (style) => style.thumbColor(Colors.blue),
        expect: (style) {
          expect(
            style.$thumb,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'thumb',
        initial: SwitchStyler(),
        modify: (style) => style.thumb(
          BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
        ),
        expect: (style) {
          expect(
            style.$thumb,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.green)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment',
        initial: SwitchStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(SwitchStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'padding',
        initial: SwitchStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16.0)),
        expect: (style) {
          expect(
            style,
            equals(SwitchStyler.padding(EdgeInsetsGeometryMix.all(16.0))),
          );
        },
      );

      styleMethodTest(
        'margin',
        initial: SwitchStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8.0)),
        expect: (style) {
          expect(
            style,
            equals(SwitchStyler.margin(EdgeInsetsGeometryMix.all(8.0))),
          );
        },
      );

      styleMethodTest(
        'constraints',
        initial: SwitchStyler(),
        modify: (style) => style.constraints(
          BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SwitchStyler.constraints(
                BoxConstraintsMix(minWidth: 20.0, minHeight: 20.0),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'decoration',
        initial: SwitchStyler(),
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
              SwitchStyler.decoration(
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
        'foregroundDecoration',
        initial: SwitchStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(BorderSideMix(color: Colors.red)),
          ),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              SwitchStyler.foregroundDecoration(
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
        initial: SwitchStyler(),
        modify: (style) =>
            style.transform(Matrix4.identity(), alignment: Alignment.topLeft),
        expect: (style) {
          expect(
            style,
            equals(
              SwitchStyler.transform(
                Matrix4.identity(),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'variants',
        initial: SwitchStyler(),
        modify: (style) => style.variants(<VariantStyle<SwitchSpec>>[]),
        expect: (style) {
          expect(style.$variants, equals(<VariantStyle<SwitchSpec>>[]));
        },
      );

      styleMethodTest(
        'wrap',
        initial: SwitchStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'animate',
        initial: SwitchStyler(),
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

    group('Core Methods', () {
      testWidgets('resolve method returns StyleSpec', (
        WidgetTester tester,
      ) async {
        final style = SwitchStyler();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final spec = style.resolve(context);

                expect(spec, isA<StyleSpec<SwitchSpec>>());
                expect(spec.spec, isA<SwitchSpec>());
                expect(spec.spec.container, isA<StyleSpec<BoxSpec>>());
                expect(spec.spec.thumb, isA<StyleSpec<BoxSpec>>());

                return Container();
              },
            ),
          ),
        );
      });

      test('merge with null returns style equal to original', () {
        final originalStyle = SwitchStyler();

        final mergedStyle = originalStyle.merge(null);

        expect(mergedStyle, equals(originalStyle));
      });

      test('merge combines properties correctly', () {
        final style1 = SwitchStyler(
          container: BoxStyler(alignment: Alignment.centerLeft),
        );
        final style2 = SwitchStyler(
          thumb: BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
        );

        final merged = style1.merge(style2);

        expect(
          merged.$container,
          equals(Prop.maybeMix(BoxStyler(alignment: Alignment.centerLeft))),
        );
        expect(
          merged.$thumb,
          equals(
            Prop.maybeMix(
              BoxStyler(decoration: BoxDecorationMix(color: Colors.blue)),
            ),
          ),
        );
      });
    });

    group('Call Method', () {
      testWidgets('call method creates RemixSwitch with all parameters', (
        tester,
      ) async {
        final style = SwitchStyler().thumbColor(Colors.white);
        final focusNode = FocusNode();

        final switchWidget = style.call(
          selected: true,
          onChanged: (value) {},
          enabled: false,
          enableFeedback: false,
          focusNode: focusNode,
          autofocus: true,
          semanticLabel: 'Test Switch',
          mouseCursor: SystemMouseCursors.forbidden,
        );

        expect(switchWidget, isA<RemixSwitch>());
        expect(switchWidget.selected, equals(true));
        expect(switchWidget.enabled, equals(false));
        expect(switchWidget.enableFeedback, equals(false));
        expect(switchWidget.focusNode, same(focusNode));
        expect(switchWidget.autofocus, equals(true));
        expect(switchWidget.semanticLabel, equals('Test Switch'));
        expect(switchWidget.mouseCursor, equals(SystemMouseCursors.forbidden));
        expect(switchWidget.style, same(style));

        focusNode.dispose();
      });

      testWidgets('call method creates RemixSwitch with minimal parameters', (
        tester,
      ) async {
        final style = SwitchStyler();

        final switchWidget = style.call(selected: false, onChanged: (v) {});

        expect(switchWidget, isA<RemixSwitch>());
        expect(switchWidget.selected, equals(false));
        expect(switchWidget.enabled, equals(true));
        expect(switchWidget.enableFeedback, equals(true));
        expect(switchWidget.style, same(style));
      });
    });

    group('Equality', () {
      test('identical styles are equal', () {
        final style1 = SwitchStyler();
        final style2 = SwitchStyler();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('styles with different properties are not equal', () {
        final style1 = SwitchStyler().thumbColor(Colors.blue);
        final style2 = SwitchStyler().thumbColor(Colors.red);

        expect(style1, isNot(equals(style2)));
      });

      test('props list contains all properties', () {
        final style = SwitchStyler();

        expect(style.props, hasLength(7));
        expect(style.props, contains(style.$container));
        expect(style.props, contains(style.$thumb));
        expect(style.props, contains(style.$variants));
        expect(style.props, contains(style.$animation));
        expect(style.props, contains(style.$modifier));
      });
    });
  });
}
