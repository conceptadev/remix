import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonContentSwitcher is a controlled single-select group', (
    tester,
  ) async {
    var selected = 'list';
    await tester.pumpCarbonApp(
      CarbonContentSwitcher<String>(
        selectedValue: selected,
        onChanged: (value) => selected = value,
        semanticLabel: 'View mode',
        items: const [
          CarbonContentSwitcherItem(value: 'list', label: 'List'),
          CarbonContentSwitcherItem(value: 'grid', label: 'Grid'),
        ],
      ),
    );

    await tester.tap(find.text('Grid'));
    expect(selected, 'grid');
  });

  testWidgets('Carbon content-switcher recipe matches Carbon states', (
    tester,
  ) async {
    final base = await _resolve(tester);
    final selected = await _resolve(tester, states: {WidgetState.selected});
    final disabled = await _resolve(tester, states: {WidgetState.disabled});

    expect(base.spec.container.spec.constraints?.minHeight, 40);
    expect(base.spec.container.spec.decoration, isA<BoxDecoration>());
    expect(
      selected.spec.item.spec.container.spec.decoration,
      isA<BoxDecoration>(),
    );
    expect(
      selected.spec.item.spec.label.spec.style?.color,
      selected.textInverse,
    );
    expect(
      disabled.spec.item.spec.label.spec.style?.color,
      disabled.textDisabled,
    );
  });

  testWidgets('CarbonContentSwitcher paints its controlled selection', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      CarbonContentSwitcher<String>(
        selectedValue: 'list',
        onChanged: (_) {},
        items: const [
          CarbonContentSwitcherItem(value: 'list', label: 'List'),
          CarbonContentSwitcherItem(value: 'grid', label: 'Grid'),
        ],
      ),
    );

    final surfaces = tester.widgetList<Box>(
      find.descendant(
        of: find.byType(RemixSegmentedControl<String>),
        matching: find.byType(Box),
      ),
    );
    final context = tester.element(find.byType(RemixSegmentedControl<String>));

    expect(
      surfaces.any(
        (surface) =>
            surface.styleSpec != null &&
            _background(surface.styleSpec!.spec) ==
                CarbonTokens.layerSelectedInverse.resolve(context),
      ),
      isTrue,
    );
  });
}

Future<({SegmentedControlSpec spec, Color textInverse, Color textDisabled})>
_resolve(WidgetTester tester, {Set<WidgetState> states = const {}}) async {
  late ({SegmentedControlSpec spec, Color textInverse, Color textDisabled})
  result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonContentSwitcherStyle().build(context).spec,
              textInverse: CarbonTokens.textInverse.resolve(context),
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

Color? _background(BoxSpec spec) => (spec.decoration as BoxDecoration?)?.color;
