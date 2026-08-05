import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('TextFieldStyler', () {
    group('Constructors', () {
      test('create() constructs with null parameters', () {
        const style = TextFieldStyler.create();

        expect(style.$text, isNull);
        expect(style.$hintText, isNull);
        expect(style.$textAlign, isNull);
        expect(style.$cursorWidth, isNull);
        expect(style.$cursorHeight, isNull);
        expect(style.$cursorRadius, isNull);
        expect(style.$cursorColor, isNull);
        expect(style.$cursorOpacityAnimates, isNull);
        expect(style.$selectionHeightStyle, isNull);
        expect(style.$selectionWidthStyle, isNull);
        expect(style.$scrollPadding, isNull);
        expect(style.$keyboardAppearance, isNull);
        expect(style.$container, isNull);
        expect(style.$helperText, isNull);
        expect(style.$label, isNull);
        expect(style.$variants, isNull);
        expect(style.$animation, isNull);
        expect(style.$modifier, isNull);
      });

      test('create() constructs with provided parameters', () {
        final text = Prop.maybeMix(TextStyler());
        final hintText = Prop.maybeMix(TextStyler());
        final textAlign = Prop.maybe(TextAlign.center);
        final cursorWidth = Prop.maybe(3.0);
        final cursorHeight = Prop.maybe(20.0);
        final cursorRadius = Prop.maybe(const Radius.circular(2));
        final cursorColor = Prop.maybe(Colors.blue);
        final cursorOpacityAnimates = Prop.maybe(true);
        final selectionHeightStyle = Prop.maybe(BoxHeightStyle.max);
        final selectionWidthStyle = Prop.maybe(BoxWidthStyle.max);
        final scrollPadding = Prop.maybe(const EdgeInsets.all(10));
        final keyboardAppearance = Prop.maybe(Brightness.dark);
        final container = Prop.maybeMix(BoxStyler());
        final helperText = Prop.maybeMix(TextStyler());
        final label = Prop.maybeMix(TextStyler());
        final variants = <VariantStyle<TextFieldSpec>>[];
        final animation = AnimationConfig.linear(
          const Duration(milliseconds: 200),
        );
        final modifier = WidgetModifierConfig();

        final style = TextFieldStyler.create(
          text: text,
          hintText: hintText,
          textAlign: textAlign,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          cursorOpacityAnimates: cursorOpacityAnimates,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          scrollPadding: scrollPadding,
          keyboardAppearance: keyboardAppearance,
          container: container,
          helperText: helperText,
          label: label,
          variants: variants,
          animation: animation,
          modifier: modifier,
        );

        expect(style.$text, equals(text));
        expect(style.$hintText, equals(hintText));
        expect(style.$textAlign, equals(textAlign));
        expect(style.$cursorWidth, equals(cursorWidth));
        expect(style.$cursorHeight, equals(cursorHeight));
        expect(style.$cursorRadius, equals(cursorRadius));
        expect(style.$cursorColor, equals(cursorColor));
        expect(style.$cursorOpacityAnimates, equals(cursorOpacityAnimates));
        expect(style.$selectionHeightStyle, equals(selectionHeightStyle));
        expect(style.$selectionWidthStyle, equals(selectionWidthStyle));
        expect(style.$scrollPadding, equals(scrollPadding));
        expect(style.$keyboardAppearance, equals(keyboardAppearance));
        expect(style.$container, equals(container));
        expect(style.$helperText, equals(helperText));
        expect(style.$label, equals(label));
        expect(style.$variants, equals(variants));
        expect(style.$animation, equals(animation));
        expect(style.$modifier, equals(modifier));
      });

      test('default constructor converts types correctly', () {
        final style = TextFieldStyler(
          text: TextStyler(),
          hintText: TextStyler(),
          textAlign: TextAlign.center,
          cursorWidth: 3.0,
          cursorHeight: 20.0,
          cursorRadius: const Radius.circular(2),
          cursorColor: Colors.blue,
          cursorOpacityAnimates: true,
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          scrollPadding: const EdgeInsets.all(10),
          keyboardAppearance: Brightness.dark,
          container: BoxStyler(),
          helperText: TextStyler(),
          label: TextStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
          variants: [],
          modifier: WidgetModifierConfig(),
        );

        expect(style.$text, isNotNull);
        expect(style.$hintText, isNotNull);
        expect(style.$textAlign, isNotNull);
        expect(style.$cursorWidth, isNotNull);
        expect(style.$cursorHeight, isNotNull);
        expect(style.$cursorRadius, isNotNull);
        expect(style.$cursorColor, isNotNull);
        expect(style.$cursorOpacityAnimates, isNotNull);
        expect(style.$selectionHeightStyle, isNotNull);
        expect(style.$selectionWidthStyle, isNotNull);
        expect(style.$scrollPadding, isNotNull);
        expect(style.$keyboardAppearance, isNotNull);
        expect(style.$container, isNotNull);
        expect(style.$helperText, isNotNull);
        expect(style.$label, isNotNull);
        expect(style.$variants, isNotNull);
        expect(style.$animation, isNotNull);
        expect(style.$modifier, isNotNull);
      });
    });

    group('Style Methods', () {
      styleMethodTest(
        'textColor() sets text color',
        initial: TextFieldStyler(),
        modify: (style) => style.textColor(Colors.blue),
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
        'backgroundColor() sets background color',
        initial: TextFieldStyler(),
        modify: (style) => style.backgroundColor(Colors.grey),
        expect: (style) {
          expect(
            style.$container,
            equals(
              Prop.maybeMix(
                BoxStyler(decoration: BoxDecorationMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'container() sets container styling',
        initial: TextFieldStyler(),
        modify: (style) => style.container(BoxStyler()),
        expect: (style) {
          expect(style, equals(TextFieldStyler.container(BoxStyler())));
        },
      );

      styleMethodTest(
        'borderRadius() sets border radius',
        initial: TextFieldStyler(),
        modify: (style) =>
            style.borderRadius(BorderRadiusGeometryMix.circular(8)),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.borderRadius(BorderRadiusGeometryMix.circular(8)),
            ),
          );
        },
      );

      styleMethodTest(
        'padding() sets padding',
        initial: TextFieldStyler(),
        modify: (style) => style.padding(EdgeInsetsGeometryMix.all(16)),
        expect: (style) {
          expect(
            style,
            equals(TextFieldStyler.padding(EdgeInsetsGeometryMix.all(16))),
          );
        },
      );

      styleMethodTest(
        'border() sets border',
        initial: TextFieldStyler(),
        modify: (style) => style.border(
          BoxBorderMix.all(BorderSideMix(color: Colors.black, width: 1)),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.border(
                BoxBorderMix.all(BorderSideMix(color: Colors.black, width: 1)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'width() sets width',
        initial: TextFieldStyler(),
        modify: (style) => style.width(200),
        expect: (style) {
          expect(style, equals(TextFieldStyler.width(200)));
        },
      );

      styleMethodTest(
        'height() sets height',
        initial: TextFieldStyler(),
        modify: (style) => style.height(50),
        expect: (style) {
          expect(style, equals(TextFieldStyler.height(50)));
        },
      );

      styleMethodTest(
        'cursorColor() sets cursor color',
        initial: TextFieldStyler(),
        modify: (style) => style.cursorColor(Color.fromARGB(255, 255, 0, 0)),
        expect: (style) {
          expect(
            style,
            equals(TextFieldStyler.cursorColor(Color.fromARGB(255, 255, 0, 0))),
          );
        },
      );

      styleMethodTest(
        'hintColor() sets hint text color',
        initial: TextFieldStyler(),
        modify: (style) => style.hintColor(Colors.grey),
        expect: (style) {
          expect(
            style.$hintText,
            equals(
              Prop.maybeMix(
                TextStyler(style: TextStyleMix(color: Colors.grey)),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'hintText() sets hint text styling',
        initial: TextFieldStyler(),
        modify: (style) => style.hintText(TextStyler()),
        expect: (style) {
          expect(style, equals(TextFieldStyler.hintText(TextStyler())));
        },
      );

      styleMethodTest(
        'margin() sets margin',
        initial: TextFieldStyler(),
        modify: (style) => style.margin(EdgeInsetsGeometryMix.all(8)),
        expect: (style) {
          expect(
            style,
            equals(TextFieldStyler.margin(EdgeInsetsGeometryMix.all(8))),
          );
        },
      );

      styleMethodTest(
        'spacing() sets spacing',
        initial: TextFieldStyler(),
        modify: (style) => style.spacing(12),
        expect: (style) {
          expect(style, equals(TextFieldStyler(spacing: 12)));
          expect(TextFieldStyler.spacing(12), equals(style));
        },
      );

      styleMethodTest(
        'crossAxisAlignment() aligns the input row',
        initial: TextFieldStyler(),
        modify: (style) => style.crossAxisAlignment(.start),
        expect: (style) {
          expect(style, equals(TextFieldStyler(crossAxisAlignment: .start)));
          expect(TextFieldStyler.crossAxisAlignment(.start), equals(style));
        },
      );

      styleMethodTest(
        'decoration() sets decoration',
        initial: TextFieldStyler(),
        modify: (style) =>
            style.decoration(BoxDecorationMix(color: Colors.red)),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.decoration(BoxDecorationMix(color: Colors.red)),
            ),
          );
        },
      );

      styleMethodTest(
        'alignment() sets alignment',
        initial: TextFieldStyler(),
        modify: (style) => style.alignment(Alignment.center),
        expect: (style) {
          expect(style, equals(TextFieldStyler.alignment(Alignment.center)));
        },
      );

      styleMethodTest(
        'constraints() sets constraints',
        initial: TextFieldStyler(),
        modify: (style) =>
            style.constraints(BoxConstraintsMix(minWidth: 100, maxWidth: 200)),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.constraints(
                BoxConstraintsMix(minWidth: 100, maxWidth: 200),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'textAlign() sets text alignment',
        initial: TextFieldStyler(),
        modify: (style) => style.textAlign(TextAlign.center),
        expect: (style) {
          expect(style, equals(TextFieldStyler.textAlign(TextAlign.center)));
        },
      );

      styleMethodTest(
        'helperText() sets helper text styling',
        initial: TextFieldStyler(),
        modify: (style) => style.helperText(TextStyler().color(Colors.blue)),
        expect: (style) {
          expect(
            style,
            equals(TextFieldStyler.helperText(TextStyler().color(Colors.blue))),
          );
        },
      );

      styleMethodTest(
        'label() sets label styling',
        initial: TextFieldStyler(),
        modify: (style) => style.label(TextStyler().color(Colors.blue)),
        expect: (style) {
          expect(
            style,
            equals(TextFieldStyler.label(TextStyler().color(Colors.blue))),
          );
        },
      );

      styleMethodTest(
        'animate() adds animation config',
        initial: TextFieldStyler(),
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
        initial: TextFieldStyler(),
        modify: (style) => style.variants([]),
        expect: (style) {
          expect(style.$variants, equals([]));
        },
      );

      styleMethodTest(
        'wrap() adds widget modifier',
        initial: TextFieldStyler(),
        modify: (style) => style.wrap(.clipOval()),
        expect: (style) {
          expect(style.$modifier, equals(WidgetModifierConfig.clipOval()));
        },
      );

      styleMethodTest(
        'foregroundDecoration() adds foreground decoration',
        initial: TextFieldStyler(),
        modify: (style) => style.foregroundDecoration(
          BoxDecorationMix(shape: BoxShape.circle),
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.foregroundDecoration(
                BoxDecorationMix(shape: BoxShape.circle),
              ),
            ),
          );
        },
      );

      styleMethodTest(
        'transform() adds transform',
        initial: TextFieldStyler(),
        modify: (style) => style.transform(
          Matrix4.rotationZ(0.1),
          alignment: Alignment.topLeft,
        ),
        expect: (style) {
          expect(
            style,
            equals(
              TextFieldStyler.transform(
                Matrix4.rotationZ(0.1),
                alignment: Alignment.topLeft,
              ),
            ),
          );
        },
      );
    });

    group('Core Methods', () {
      testWidgets('resolve() creates StyleSpec', (tester) async {
        const style = TextFieldStyler.create();

        await tester.pumpMaterialApp(Container());
        final context = tester.element(find.byType(Container));

        final styleSpec = style.resolve(context);

        expect(styleSpec, isA<StyleSpec<TextFieldSpec>>());
        expect(styleSpec.spec, isA<TextFieldSpec>());
      });

      test('merge() combines two styles', () {
        final style1 = TextFieldStyler(text: TextStyler());
        final style2 = TextFieldStyler(
          hintText: TextStyler(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 200)),
        );

        final merged = style1.merge(style2);

        expect(merged.$text, isNotNull);
        expect(merged.$hintText, isNotNull);
        expect(merged.$animation, isNotNull);
      });

      test('merge() with null returns original', () {
        final style = TextFieldStyler(text: TextStyler());
        final merged = style.merge(null);

        expect(merged, equals(style));
      });
    });

    group('Call Method', () {
      testWidgets('call method creates RemixTextField with common parameters', (
        tester,
      ) async {
        final style = TextFieldStyler().backgroundColor(Colors.grey.shade100);
        final controller = TextEditingController();
        final focusNode = FocusNode();

        final textField = style.call(
          controller: controller,
          focusNode: focusNode,
          hintText: 'Enter text',
          label: 'Name',
          helperText: 'Your full name',
          enabled: false,
          autofocus: true,
          obscureText: true,
          maxLines: 1,
          onChanged: (value) {},
          error: true,
        );

        expect(textField, isA<RemixTextField>());
        expect(textField.controller, same(controller));
        expect(textField.focusNode, same(focusNode));
        expect(textField.hintText, equals('Enter text'));
        expect(textField.label, equals('Name'));
        expect(textField.helperText, equals('Your full name'));
        expect(textField.enabled, equals(false));
        expect(textField.autofocus, equals(true));
        expect(textField.obscureText, equals(true));
        expect(textField.maxLines, equals(1));
        expect(textField.error, equals(true));
        expect(textField.style, same(style));

        controller.dispose();
        focusNode.dispose();
      });

      testWidgets(
        'call method creates RemixTextField with minimal parameters',
        (tester) async {
          final style = TextFieldStyler();

          final textField = style.call();

          expect(textField, isA<RemixTextField>());
          expect(textField.enabled, equals(true));
          expect(textField.autofocus, equals(false));
          expect(textField.obscureText, equals(false));
          expect(textField.maxLines, equals(1));
          expect(textField.error, equals(false));
          expect(textField.style, same(style));
        },
      );

      testWidgets(
        'call method creates RemixTextField with leading and trailing',
        (tester) async {
          final style = TextFieldStyler();
          const leading = Icon(Icons.person);
          const trailing = Icon(Icons.clear);

          final textField = style.call(leading: leading, trailing: trailing);

          expect(textField, isA<RemixTextField>());
          expect(textField.leading, same(leading));
          expect(textField.trailing, same(trailing));
        },
      );
    });

    group('Equality', () {
      test('two identical styles are equal', () {
        const style1 = TextFieldStyler.create();
        const style2 = TextFieldStyler.create();

        expect(style1, equals(style2));
        expect(style1.hashCode, equals(style2.hashCode));
      });

      test('two styles with different properties are not equal', () {
        final style1 = TextFieldStyler(text: TextStyler());
        const style2 = TextFieldStyler.create();

        expect(style1, isNot(equals(style2)));
      });
    });
  });
}
