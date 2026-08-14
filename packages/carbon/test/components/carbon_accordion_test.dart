import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonAccordion exposes controlled disclosure behavior', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final controller = RemixAccordionController<String>(max: 1);
    addTearDown(controller.dispose);

    await tester.pumpCarbonApp(
      CarbonAccordionGroup<String>(
        controller: controller,
        child: Column(
          children: const [
            CarbonAccordion<String>(
              value: 'first',
              title: 'First section',
              child: Text('First panel'),
            ),
            CarbonAccordion<String>(
              value: 'second',
              title: 'Second section',
              child: Text('Second panel'),
            ),
          ],
        ),
      ),
    );

    expect(find.text('First panel'), findsNothing);
    expect(find.byIcon(CarbonIcons.chevronRight), findsNWidgets(2));
    expect(find.byIcon(CarbonIcons.chevronDown), findsNothing);
    expect(
      tester.getSemantics(find.text('First section')),
      isSemantics(
        label: 'First section',
        hasTapAction: true,
        isEnabled: true,
        hasExpandedState: true,
        isExpanded: false,
      ),
    );

    await tester.tap(find.text('First section'));
    await tester.pumpAndSettle();
    expect(controller.values, {'first'});
    expect(find.text('First panel'), findsOneWidget);
    expect(find.byIcon(CarbonIcons.chevronRight), findsOneWidget);
    expect(find.byIcon(CarbonIcons.chevronDown), findsOneWidget);

    await tester.tap(find.text('Second section'));
    await tester.pumpAndSettle();
    expect(controller.values, {'second'});
    expect(find.text('First panel'), findsNothing);
    expect(find.text('Second panel'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('Carbon accordion recipe matches Carbon geometry and states', (
    tester,
  ) async {
    final base = await _resolve(tester);
    final hovered = await _resolve(tester, states: {WidgetState.hovered});
    final disabled = await _resolve(tester, states: {WidgetState.disabled});

    expect(base.spec.trigger.spec.box?.spec.constraints?.minHeight, 40);
    expect(base.spec.title.spec.style?.fontSize, 14);
    expect(base.spec.trailingIcon.spec.size, 16);
    expect(
      _background(hovered.spec.trigger.spec.box!.spec),
      hovered.layerHover,
    );
    expect(disabled.spec.title.spec.style?.color, disabled.textDisabled);
  });
}

Future<({AccordionSpec spec, Color layerHover, Color textDisabled})> _resolve(
  WidgetTester tester, {
  Set<WidgetState> states = const {},
}) async {
  late ({AccordionSpec spec, Color layerHover, Color textDisabled}) result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonAccordionStyle().build(context).spec,
              layerHover: CarbonLayer.of(
                context,
              ).color(CarbonContextualColor.layerHover).resolve(context),
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
