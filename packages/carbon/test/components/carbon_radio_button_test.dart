import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonRadioButtonGroup controls labeled radio options', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    String? selected = 'a';
    await tester.pumpCarbonApp(
      CarbonRadioButtonGroup<String>(
        groupValue: selected,
        semanticLabel: 'Choice',
        onChanged: (value) => selected = value,
        child: const Column(
          children: [
            CarbonRadioButton(value: 'a', label: 'Alpha'),
            CarbonRadioButton(value: 'b', label: 'Beta'),
          ],
        ),
      ),
    );

    final group = tester.semantics
        .simulatedAccessibilityTraversal()
        .singleWhere((node) => node.role == SemanticsRole.radioGroup);
    expect(group.label, 'Choice');
    await tester.tap(find.text('Beta'));
    expect(selected, 'b');
    semantics.dispose();
  });

  testWidgets('Carbon radio recipe uses 18px ring and 9px indicator', (
    tester,
  ) async {
    late RadioSpec spec;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonRadioButtonStyle().build(context).spec;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.container.spec.constraints?.minWidth, 18);
    expect(spec.container.spec.constraints?.minHeight, 18);
    expect(spec.indicator.spec.constraints?.minWidth, 9);
    expect(spec.indicator.spec.constraints?.minHeight, 9);
  });
}
