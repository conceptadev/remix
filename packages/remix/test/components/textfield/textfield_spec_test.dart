import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixTextFieldSpec', () {
    group('Constructor', () {
      test('creates with default properties', () {
        const spec = RemixTextFieldSpec();

        expect(spec.text, equals(const StyleSpec(spec: TextSpec())));
        expect(spec.hintText, equals(const StyleSpec(spec: TextSpec())));
        expect(spec.textAlign, equals(TextAlign.start));
        expect(spec.cursorWidth, equals(2.0));
        expect(spec.cursorHeight, isNull);
        expect(spec.cursorRadius, isNull);
        expect(spec.cursorColor, isNull);
        expect(spec.cursorOpacityAnimates, isNull);
        expect(spec.selectionHeightStyle, equals(BoxHeightStyle.tight));
        expect(spec.selectionWidthStyle, equals(BoxWidthStyle.tight));
        expect(spec.scrollPadding, equals(const EdgeInsets.all(20.0)));
        expect(spec.keyboardAppearance, isNull);
        expect(spec.container, equals(const StyleSpec(spec: FlexBoxSpec())));
        expect(spec.helperText, equals(const StyleSpec(spec: TextSpec())));
        expect(spec.label, equals(const StyleSpec(spec: TextSpec())));
      });

      test('creates with provided properties', () {
        final text = StyleSpec(spec: const TextSpec());
        final hintText = StyleSpec(spec: const TextSpec());
        const textAlign = TextAlign.center;
        const cursorWidth = 3.0;
        const cursorHeight = 20.0;
        const cursorRadius = Radius.circular(2);
        const cursorColor = Colors.blue;
        const cursorOpacityAnimates = true;
        const selectionHeightStyle = BoxHeightStyle.max;
        const selectionWidthStyle = BoxWidthStyle.max;
        const scrollPadding = EdgeInsets.all(10);
        const keyboardAppearance = Brightness.dark;
        final container = StyleSpec(spec: const FlexBoxSpec());
        final helperText = StyleSpec(spec: const TextSpec());
        final label = StyleSpec(spec: const TextSpec());

        final spec = RemixTextFieldSpec(
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
        );

        expect(spec.text, equals(text));
        expect(spec.hintText, equals(hintText));
        expect(spec.textAlign, equals(textAlign));
        expect(spec.cursorWidth, equals(cursorWidth));
        expect(spec.cursorHeight, equals(cursorHeight));
        expect(spec.cursorRadius, equals(cursorRadius));
        expect(spec.cursorColor, equals(cursorColor));
        expect(spec.cursorOpacityAnimates, equals(cursorOpacityAnimates));
        expect(spec.selectionHeightStyle, equals(selectionHeightStyle));
        expect(spec.selectionWidthStyle, equals(selectionWidthStyle));
        expect(spec.scrollPadding, equals(scrollPadding));
        expect(spec.keyboardAppearance, equals(keyboardAppearance));
        expect(spec.container, equals(container));
        expect(spec.helperText, equals(helperText));
        expect(spec.label, equals(label));
      });
    });

    group('copyWith', () {
      test('returns copy when no parameters provided', () {
        const spec = RemixTextFieldSpec();
        final copy = spec.copyWith();

        expect(copy.text, equals(spec.text));
        expect(copy.hintText, equals(spec.hintText));
        expect(copy.textAlign, equals(spec.textAlign));
        expect(copy.cursorWidth, equals(spec.cursorWidth));
        expect(copy.cursorHeight, equals(spec.cursorHeight));
        expect(copy.cursorRadius, equals(spec.cursorRadius));
        expect(copy.cursorColor, equals(spec.cursorColor));
        expect(copy.selectionHeightStyle, equals(spec.selectionHeightStyle));
        expect(copy.selectionWidthStyle, equals(spec.selectionWidthStyle));
        expect(copy.scrollPadding, equals(spec.scrollPadding));
        expect(copy.keyboardAppearance, equals(spec.keyboardAppearance));
        expect(copy.container, equals(spec.container));
        expect(copy.helperText, equals(spec.helperText));
        expect(copy.label, equals(spec.label));
      });

      test('returns copy with new text', () {
        const spec = RemixTextFieldSpec();
        final newText = StyleSpec(
          spec: const TextSpec(),
          animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
        );

        final copy = spec.copyWith(text: newText);

        expect(copy.text, equals(newText));
        expect(copy.text, isNot(equals(spec.text)));
        expect(copy.hintText, equals(spec.hintText));
      });

      test('returns copy with new cursor properties', () {
        const spec = RemixTextFieldSpec();

        final copy = spec.copyWith(
          cursorWidth: 5.0,
          cursorHeight: 25.0,
          cursorRadius: const Radius.circular(4),
          cursorColor: Colors.red,
        );

        expect(copy.cursorWidth, equals(5.0));
        expect(copy.cursorHeight, equals(25.0));
        expect(copy.cursorRadius, equals(const Radius.circular(4)));
        expect(copy.cursorColor, equals(Colors.red));
        expect(copy.textAlign, equals(spec.textAlign));
      });

      test('returns copy with new text alignment', () {
        const spec = RemixTextFieldSpec();

        final copy = spec.copyWith(textAlign: TextAlign.center);

        expect(copy.textAlign, equals(TextAlign.center));
        expect(copy.textAlign, isNot(equals(spec.textAlign)));
      });
    });

    group('lerp', () {
      test('returns value equal to this when other is null', () {
        const spec = RemixTextFieldSpec();
        final lerped = spec.lerp(null, 0.5);

        // StyleSpec fields should be preserved
        expect(lerped.text, equals(spec.text));
        expect(lerped.hintText, equals(spec.hintText));
        expect(lerped.container, equals(spec.container));
        expect(lerped.helperText, equals(spec.helperText));
        expect(lerped.label, equals(spec.label));
      });

      test('interpolates between two specs at t=0', () {
        const spec1 = RemixTextFieldSpec();
        const spec2 = RemixTextFieldSpec(
          textAlign: TextAlign.center,
          cursorWidth: 4.0,
        );

        final result = spec1.lerp(spec2, 0.0);

        expect(result.textAlign, equals(spec1.textAlign));
        expect(result.cursorWidth, equals(spec1.cursorWidth));
      });

      test('interpolates between two specs at t=1', () {
        const spec1 = RemixTextFieldSpec();
        const spec2 = RemixTextFieldSpec(
          textAlign: TextAlign.center,
          cursorWidth: 4.0,
        );

        final result = spec1.lerp(spec2, 1.0);

        expect(result.textAlign, equals(spec2.textAlign));
        expect(result.cursorWidth, equals(spec2.cursorWidth));
      });

      test('interpolates between two specs at t=0.5', () {
        const spec1 = RemixTextFieldSpec(cursorWidth: 2.0);
        const spec2 = RemixTextFieldSpec(cursorWidth: 4.0);

        final result = spec1.lerp(spec2, 0.5);

        expect(result.cursorWidth, equals(3.0));
      });

      test('interpolates colors correctly', () {
        const spec1 = RemixTextFieldSpec(cursorColor: Colors.red);
        const spec2 = RemixTextFieldSpec(cursorColor: Colors.blue);

        final result = spec1.lerp(spec2, 0.5);

        expect(result.cursorColor, isNotNull);
        expect(
          result.cursorColor,
          equals(Color.lerp(Colors.red, Colors.blue, 0.5)),
        );
      });

      test('interpolates edge insets correctly', () {
        const spec1 = RemixTextFieldSpec(scrollPadding: EdgeInsets.all(10));
        const spec2 = RemixTextFieldSpec(scrollPadding: EdgeInsets.all(20));

        final result = spec1.lerp(spec2, 0.5);

        expect(result.scrollPadding, equals(const EdgeInsets.all(15)));
      });
    });

    group('Equality & Props', () {
      test('two specs with same properties are equal', () {
        const spec1 = RemixTextFieldSpec();
        const spec2 = RemixTextFieldSpec();

        expect(spec1, equals(spec2));
        expect(spec1.hashCode, equals(spec2.hashCode));
      });

      test('two specs with different properties are not equal', () {
        const spec1 = RemixTextFieldSpec();
        const spec2 = RemixTextFieldSpec(textAlign: TextAlign.center);

        expect(spec1, isNot(equals(spec2)));
      });

      test('props includes all relevant properties', () {
        const spec = RemixTextFieldSpec();

        expect(spec.props.length, equals(17));
        expect(spec.props, contains(spec.text));
        expect(spec.props, contains(spec.hintText));
        expect(spec.props, contains(spec.textAlign));
        expect(spec.props, contains(spec.cursorWidth));
        expect(spec.props, contains(spec.cursorHeight));
        expect(spec.props, contains(spec.cursorRadius));
        expect(spec.props, contains(spec.cursorColor));
        expect(spec.props, contains(spec.cursorOpacityAnimates));
        expect(spec.props, contains(spec.selectionHeightStyle));
        expect(spec.props, contains(spec.selectionWidthStyle));
        expect(spec.props, contains(spec.scrollPadding));
        expect(spec.props, contains(spec.keyboardAppearance));
        expect(spec.props, contains(spec.container));
        expect(spec.props, contains(spec.layout));
        expect(spec.props, contains(spec.helperText));
        expect(spec.props, contains(spec.label));
      });
    });

    group('Diagnostic Support', () {
      test('debugFillProperties includes all properties', () {
        const spec = RemixTextFieldSpec();
        final builder = DiagnosticPropertiesBuilder();

        spec.debugFillProperties(builder);

        final properties = builder.properties;
        expect(properties.any((p) => p.name == 'text'), isTrue);
        expect(properties.any((p) => p.name == 'hintText'), isTrue);
        expect(properties.any((p) => p.name == 'textAlign'), isTrue);
        expect(properties.any((p) => p.name == 'cursorWidth'), isTrue);
        expect(properties.any((p) => p.name == 'cursorHeight'), isTrue);
        expect(properties.any((p) => p.name == 'cursorRadius'), isTrue);
        expect(properties.any((p) => p.name == 'cursorColor'), isTrue);
        expect(
          properties.any((p) => p.name == 'cursorOpacityAnimates'),
          isTrue,
        );
        expect(properties.any((p) => p.name == 'selectionHeightStyle'), isTrue);
        expect(properties.any((p) => p.name == 'selectionWidthStyle'), isTrue);
        expect(properties.any((p) => p.name == 'scrollPadding'), isTrue);
        expect(properties.any((p) => p.name == 'keyboardAppearance'), isTrue);
        expect(properties.any((p) => p.name == 'container'), isTrue);
        expect(properties.any((p) => p.name == 'helperText'), isTrue);
        expect(properties.any((p) => p.name == 'label'), isTrue);
      });
    });

    group('Edge Cases', () {
      test('handles null optional properties correctly', () {
        const spec = RemixTextFieldSpec(
          cursorHeight: null,
          cursorRadius: null,
          cursorColor: null,
          keyboardAppearance: null,
          cursorOpacityAnimates: null,
        );

        expect(spec.cursorHeight, isNull);
        expect(spec.cursorRadius, isNull);
        expect(spec.cursorColor, isNull);
        expect(spec.keyboardAppearance, isNull);
        expect(spec.cursorOpacityAnimates, isNull);
      });

      test('lerp handles null properties', () {
        const spec1 = RemixTextFieldSpec(cursorColor: null);
        const spec2 = RemixTextFieldSpec(cursorColor: Colors.blue);

        final result = spec1.lerp(spec2, 0.5);

        expect(result.cursorColor, isNotNull);
      });
    });
  });
}
