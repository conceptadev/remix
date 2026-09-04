import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  const idleOverride = Color(0xFF123456);
  const hoverOverride = Color(0xFFABCDEF);

  group('Fortal style overrides', () {
    testWidgets('Button merges idle and hovered overrides last', (
      tester,
    ) async {
      final idle = await _resolve(
        tester,
        (context) => fortalButtonStyle(
          style: ButtonStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
      );
      final hovered = await _resolve(
        tester,
        (context) => fortalButtonStyle(
          style: ButtonStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
        states: const {WidgetState.hovered},
      );

      expect(_buttonColor(idle), idleOverride);
      expect(_buttonColor(hovered), hoverOverride);
    });

    testWidgets('Checkbox merges idle and hovered overrides last', (
      tester,
    ) async {
      final idle = await _resolve(
        tester,
        (context) => fortalCheckboxStyle(
          variant: .soft,
          style: CheckboxStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
      );
      final hovered = await _resolve(
        tester,
        (context) => fortalCheckboxStyle(
          variant: .soft,
          style: CheckboxStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
        states: const {WidgetState.hovered},
      );

      expect(_boxColor(idle.container), idleOverride);
      expect(_boxColor(hovered.container), hoverOverride);
    });

    testWidgets('TextField merges idle and hovered overrides last', (
      tester,
    ) async {
      final idle = await _resolve(
        tester,
        (context) => fortalTextFieldStyle(
          style: TextFieldStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
      );
      final hovered = await _resolve(
        tester,
        (context) => fortalTextFieldStyle(
          style: TextFieldStyler()
              .color(idleOverride)
              .onHovered(.color(hoverOverride)),
        ).build(context).spec,
        states: const {WidgetState.hovered},
      );

      expect(_boxColor(idle.container), idleOverride);
      expect(_boxColor(hovered.container), hoverOverride);
    });
  });
}

Future<T> _resolve<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve, {
  Set<WidgetState> states = const {},
}) async {
  late T value;
  await tester.pumpWidget(
    FortalScope(
      child: MaterialApp(
        home: WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              value = resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return value;
}

Color? _buttonColor(ButtonSpec spec) =>
    (spec.container.spec.box?.spec.decoration as BoxDecoration?)?.color;

Color? _boxColor(StyleSpec<BoxSpec> style) =>
    (style.spec.decoration as BoxDecoration?)?.color;
