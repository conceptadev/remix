import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('focus-visible hover keeps the Radix accent hover treatment', (
    tester,
  ) async {
    final hovered = await _resolve(tester, const {WidgetState.hovered});
    final focusedHovered = await _resolve(tester, const {
      WidgetState.focused,
      WidgetState.hovered,
    });

    expect(_containerColor(hovered.spec), hovered.grayA3);
    expect(_containerColor(focusedHovered.spec), focusedHovered.accentA3);
    expect(_containerBorder(focusedHovered.spec)?.top.width, 2);
  });
}

Future<({TabSpec spec, Color grayA3, Color accentA3})> _resolve(
  WidgetTester tester,
  Set<WidgetState> states,
) async {
  late ({TabSpec spec, Color grayA3, Color accentA3}) result;

  await tester.pumpWidget(
    FortalScope(
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateStyleOverride(
          states: states,
          child: Builder(
            builder: (context) {
              result = (
                spec: fortalTabStyle().build(context).spec,
                grayA3: MixScope.tokenOf(FortalTokens.grayA3, context),
                accentA3: MixScope.tokenOf(FortalTokens.accentA3, context),
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );

  return result;
}

Color? _containerColor(TabSpec spec) {
  return _containerDecoration(spec)?.color;
}

Border? _containerBorder(TabSpec spec) =>
    _containerDecoration(spec)?.border as Border?;

BoxDecoration? _containerDecoration(TabSpec spec) =>
    spec.container.spec.box?.spec.decoration as BoxDecoration?;
