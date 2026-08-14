import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonSelect supports items, groups, and controlled selection', (
    tester,
  ) async {
    String? selected;
    await tester.pumpCarbonApp(
      CarbonSelect<String>(
        label: 'Region',
        placeholder: 'Choose a region',
        items: const [
          CarbonSelectItem(value: 'global', label: 'Global'),
          CarbonSelectItemGroup(
            label: 'Americas',
            items: [
              CarbonSelectItem(value: 'na', label: 'North America'),
              CarbonSelectItem(value: 'sa', label: 'South America'),
            ],
          ),
        ],
        selectedValue: selected,
        onChanged: (value) => selected = value,
      ),
    );

    await tester.tap(find.text('Choose a region'));
    await tester.pumpAndSettle();
    expect(find.text('Americas'), findsOneWidget);
    await tester.tap(find.text('North America'));
    await tester.pumpAndSettle();
    expect(selected, 'na');
  });

  testWidgets('CarbonSelect exposes the selected item as its semantic value', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpCarbonApp(
      const CarbonSelect<String>(
        label: 'Region',
        placeholder: 'Choose a region',
        items: [
          CarbonSelectItem(value: 'global', label: 'Global'),
          CarbonSelectItem(
            value: 'na',
            label: 'North America',
            semanticLabel: 'North American region',
          ),
        ],
        selectedValue: 'na',
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Region')),
      isSemantics(label: 'Region', value: 'North American region'),
    );
    semantics.dispose();
  });

  testWidgets('CarbonSelect rejects a hidden selected item', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonSelect<String>(
        placeholder: 'Choose a region',
        items: [
          CarbonSelectItem(value: 'global', label: 'Global'),
          CarbonSelectItem(value: 'hidden', label: 'Hidden', hidden: true),
        ],
        selectedValue: 'hidden',
      ),
    );

    final error = tester.takeException();
    expect(error, isA<AssertionError>());
    expect(
      error.toString(),
      contains('selectedValue must match a visible entry'),
    );
  });

  testWidgets(
    'Carbon select recipe matches field geometry and disabled state',
    (tester) async {
      final base = await _resolve(tester);
      final disabled = await _resolve(tester, states: {WidgetState.disabled});

      expect(
        base.spec.trigger.spec.container.spec.box?.spec.constraints?.minHeight,
        40,
      );
      expect(base.spec.trigger.spec.label.spec.style?.fontSize, 14);
      expect(base.spec.trigger.spec.indicator.spec.size, 16);
      expect(
        disabled.spec.trigger.spec.label.spec.style?.color,
        disabled.textDisabled,
      );
    },
  );
}

Future<({SelectSpec spec, Color textDisabled})> _resolve(
  WidgetTester tester, {
  Set<WidgetState> states = const {},
}) async {
  late ({SelectSpec spec, Color textDisabled}) result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonSelectStyle().build(context).spec,
              textDisabled: CarbonTokens.textDisabled.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}
