import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('Carbon tabs switch panels and expose tab semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var selected = 'overview';

    await tester.pumpCarbonApp(
      StatefulBuilder(
        builder: (context, setState) => CarbonTabs(
          selectedTabId: selected,
          onChanged: (value) => setState(() => selected = value),
          child: const Column(
            children: [
              CarbonTabBar(
                child: Row(
                  children: [
                    CarbonTab(tabId: 'overview', label: 'Overview'),
                    CarbonTab(tabId: 'details', label: 'Details'),
                  ],
                ),
              ),
              CarbonTabView(tabId: 'overview', child: Text('Overview panel')),
              CarbonTabView(tabId: 'details', child: Text('Details panel')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Overview panel'), findsOneWidget);
    expect(find.text('Details panel'), findsNothing);
    expect(
      tester.getSemantics(find.text('Overview')),
      isSemantics(
        label: 'Overview',
        isSelected: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );

    await tester.tap(find.text('Details'));
    await tester.pumpAndSettle();
    expect(selected, 'details');
    expect(find.text('Overview panel'), findsNothing);
    expect(find.text('Details panel'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('Carbon tab recipe matches line-tab states', (tester) async {
    final base = await _resolve(tester);
    final hovered = await _resolve(tester, states: {WidgetState.hovered});
    final selected = await _resolve(tester, states: {WidgetState.selected});
    final disabled = await _resolve(tester, states: {WidgetState.disabled});

    expect(base.spec.container.spec.box?.spec.constraints?.minHeight, 40);
    expect(base.spec.label.spec.style?.fontSize, 14);
    expect(_bottomBorder(base.spec), base.borderSubtle);
    expect(_bottomBorder(hovered.spec), hovered.borderStrong);
    expect(_bottomBorder(selected.spec), selected.borderInteractive);
    expect(disabled.spec.label.spec.style?.color, disabled.textDisabled);
  });
}

Future<
  ({
    TabSpec spec,
    Color borderSubtle,
    Color borderStrong,
    Color borderInteractive,
    Color textDisabled,
  })
>
_resolve(WidgetTester tester, {Set<WidgetState> states = const {}}) async {
  late ({
    TabSpec spec,
    Color borderSubtle,
    Color borderStrong,
    Color borderInteractive,
    Color textDisabled,
  })
  result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonTabStyle().build(context).spec,
              borderSubtle: CarbonLayer.of(
                context,
              ).color(CarbonContextualColor.borderSubtle).resolve(context),
              borderStrong: CarbonLayer.of(
                context,
              ).color(CarbonContextualColor.borderStrong).resolve(context),
              borderInteractive: CarbonTokens.borderInteractive.resolve(
                context,
              ),
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

Color? _bottomBorder(TabSpec spec) {
  final decoration = spec.container.spec.box?.spec.decoration as BoxDecoration?;
  return (decoration?.border as Border?)?.bottom.color;
}
