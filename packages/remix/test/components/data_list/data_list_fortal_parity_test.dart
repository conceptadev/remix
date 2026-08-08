import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  for (final (size, fontSize, rowSpacing) in const [
    (FortalDataListSize.size1, 12.0, 12.0),
    (FortalDataListSize.size2, 14.0, 16.0),
    (FortalDataListSize.size3, 16.0, 20.0),
  ]) {
    testWidgets('${size.name} matches pinned typography and spacing', (
      tester,
    ) async {
      final result = await _resolve(tester, size: size);
      final spec = result.spec;

      expect(spec.label.spec.style?.fontSize, fontSize);
      expect(spec.value.spec.style?.fontSize, fontSize);
      expect(spec.label.spec.style?.fontWeight, FontWeight.normal);
      expect(spec.value.spec.style?.fontWeight, FontWeight.normal);
      expect(spec.label.spec.style?.color, result.grayA11);
      expect(spec.value.spec.style?.color, result.gray12);
      expect(spec.rowSpacing, rowSpacing);
      expect(spec.columnSpacing, rowSpacing);
      expect(spec.labelValueSpacing, 4);
      expect(spec.minLabelWidth, 120);
    });
  }

  testWidgets('high contrast promotes labels to gray-12', (tester) async {
    final result = await _resolve(tester, highContrast: true);

    expect(result.spec.label.spec.style?.color, result.gray12);
    expect(result.spec.value.spec.style?.color, result.gray12);
  });

  testWidgets('row spacing scales while the label minimum stays fixed', (
    tester,
  ) async {
    final result = await _resolve(tester, size: .size3, scaling: .percent110);

    expect(result.spec.rowSpacing, 22);
    expect(result.spec.columnSpacing, 22);
    expect(result.spec.labelValueSpacing, 4.4);
    expect(result.spec.minLabelWidth, 120);
    expect(result.spec.label.spec.style?.fontSize, 17.6);
  });
}

Future<({DataListSpec spec, Color grayA11, Color gray12})> _resolve(
  WidgetTester tester, {
  FortalDataListSize size = FortalDataListSize.size2,
  bool highContrast = false,
  FortalScaling scaling = FortalScaling.percent100,
}) async {
  late ({DataListSpec spec, Color grayA11, Color gray12}) result;
  await tester.pumpWidget(
    FortalScope(
      scaling: scaling,
      child: Builder(
        builder: (context) {
          result = (
            spec: fortalDataListStyle(
              size: size,
              highContrast: highContrast,
            ).build(context).spec,
            grayA11: MixScope.tokenOf(FortalTokens.grayA11, context),
            gray12: MixScope.tokenOf(FortalTokens.gray12, context),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}
