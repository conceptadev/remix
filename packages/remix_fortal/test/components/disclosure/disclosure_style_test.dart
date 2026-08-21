import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  group('Fortal disclosure styles', () {
    test('default style is surface size2', () {
      expect(
        fortalDisclosureStyle(),
        fortalDisclosureStyle(variant: .surface, size: .size2),
      );
    });

    testWidgets('all variant and size combinations produce complete styles', (
      tester,
    ) async {
      for (final variant in FortalDisclosureVariant.values) {
        for (final size in FortalDisclosureSize.values) {
          final spec = await _resolve(
            tester,
            fortalDisclosureStyle(variant: variant, size: size),
          );

          expect(spec.container.spec.decoration, isA<BoxDecoration>());
          expect(spec.trigger.spec.padding, isNotNull);
          expect(spec.trigger.widgetModifiers, isNotEmpty);
          expect(spec.content.spec.padding, isNotNull);
          expect(spec.content.widgetModifiers, isNotEmpty);
        }
      }
    });

    testWidgets('hovered, pressed, focused, and disabled states resolve', (
      tester,
    ) async {
      final idle = await _resolve(tester, fortalDisclosureStyle());
      final hovered = await _resolve(
        tester,
        fortalDisclosureStyle(),
        states: {WidgetState.hovered},
      );
      final pressed = await _resolve(
        tester,
        fortalDisclosureStyle(),
        states: {WidgetState.pressed},
      );
      final focused = await _resolve(
        tester,
        fortalDisclosureStyle(),
        states: {WidgetState.focused},
      );
      final disabled = await _resolve(
        tester,
        fortalDisclosureStyle(),
        states: {WidgetState.disabled},
      );

      expect(_color(hovered.trigger), isNot(_color(idle.trigger)));
      expect(_color(pressed.trigger), isNot(_color(idle.trigger)));
      expect(
        (focused.trigger.spec.decoration as BoxDecoration).border,
        isNotNull,
      );
      expect(_color(disabled.trigger), isNot(_color(idle.trigger)));
    });
  });
}

Color? _color(StyleSpec<BoxSpec> box) {
  return (box.spec.decoration as BoxDecoration?)?.color;
}

Future<DisclosureSpec> _resolve(
  WidgetTester tester,
  DisclosureStyler style, {
  Set<WidgetState> states = const {},
}) async {
  late DisclosureSpec result;
  await tester.pumpWidget(
    FortalScope(
      brightness: .light,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateStyleOverride(
          states: states,
          child: Builder(
            builder: (context) {
              result = style.build(context).spec;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return result;
}
