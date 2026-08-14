import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonSlider preserves range behavior and slider semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var value = 25.0;
    await tester.pumpCarbonApp(
      SizedBox(
        width: 300,
        child: CarbonSlider(
          value: value,
          min: 0,
          max: 100,
          semanticLabel: 'Volume',
          onChanged: (next) => value = next,
        ),
      ),
    );

    final sliderNode = tester.semantics
        .simulatedAccessibilityTraversal()
        .singleWhere(
          (node) => node.getSemanticsData().flagsCollection.isSlider,
        );
    expect(
      sliderNode,
      isSemantics(
        label: 'Volume',
        value: '25%',
        isSlider: true,
        isEnabled: true,
        hasIncreaseAction: true,
        hasDecreaseAction: true,
      ),
    );
    await tester.drag(find.byType(RemixSlider), const Offset(80, 0));
    expect(value, greaterThan(25));
    semantics.dispose();
  });

  testWidgets('Carbon slider recipe matches Carbon rail and thumb geometry', (
    tester,
  ) async {
    final base = await _resolve(tester);
    final hovered = await _resolve(tester, states: {WidgetState.hovered});
    final disabled = await _resolve(tester, states: {WidgetState.disabled});

    expect(base.spec.trackWidth, 2);
    expect(base.spec.rangeWidth, 2);
    expect(base.spec.thumb.spec.constraints?.minWidth, 14);
    expect(base.spec.thumb.spec.constraints?.minHeight, 14);
    expect(hovered.spec.thumb.spec.constraints?.minWidth, 20);
    expect(disabled.spec.trackColor, disabled.borderDisabled);
    expect(disabled.spec.rangeColor, disabled.borderDisabled);
  });
}

Future<({SliderSpec spec, Color borderDisabled})> _resolve(
  WidgetTester tester, {
  Set<WidgetState> states = const {},
}) async {
  late ({SliderSpec spec, Color borderDisabled}) result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonSliderStyle().build(context).spec,
              borderDisabled: CarbonTokens.borderDisabled.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}
