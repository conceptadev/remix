import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('Fortal widgets', () {
    test('constructors pin variants and infer generic types', () {
      const button = FortalButton(variant: .soft, child: Text('Save'));
      const accordion = FortalAccordion(
        variant: .soft,
        value: 'item',
        child: SizedBox(),
      );
      const radio = FortalRadio(variant: .soft, value: 'option');
      const menu = FortalMenu<String>(
        variant: .soft,
        trigger: Text('Menu'),
        entries: [RemixMenuAction(value: 'a', child: Text('A'))],
      );
      const select = FortalSelect<String>(
        triggerVariant: .ghost,
        trigger: RemixSelectTrigger(placeholder: 'Pick'),
        entries: [RemixSelectItem(value: 'a', label: 'A')],
      );

      expect(button.variant, FortalButtonVariant.soft);
      expect(accordion, isA<FortalAccordion<String>>());
      expect(accordion.variant, FortalAccordionVariant.soft);
      expect(radio, isA<FortalRadio<String>>());
      expect(radio.variant, FortalRadioVariant.soft);
      expect(menu, isA<FortalMenu<String>>());
      expect(menu.variant, FortalMenuVariant.soft);
      expect(select, isA<FortalSelect<String>>());
      expect(select.triggerVariant, FortalSelectTriggerVariant.ghost);
    });

    testWidgets('renders FortalAccordion', (tester) async {
      await tester.pumpRemixApp(
        RemixAccordionGroup<String>(
          controller: RemixAccordionController<String>(),
          child: const FortalAccordion<String>(
            value: 'item',
            color: .red,
            radius: .small,
            title: 'Item',
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(FortalAccordion<String>), findsOneWidget);
      expect(find.byType(RemixAccordion<String>), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixAccordion<String>));
    });

    testWidgets('renders FortalAvatar', (tester) async {
      await tester.pumpRemixApp(
        const FortalAvatar(color: .red, radius: .small, label: 'LF'),
      );

      expect(find.byType(FortalAvatar), findsOneWidget);
      expect(find.byType(RemixAvatar), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixAvatar));
    });

    testWidgets('renders FortalBadge', (tester) async {
      await tester.pumpRemixApp(
        const FortalBadge(
          color: .red,
          radius: .small,
          highContrast: true,
          child: Text('New'),
        ),
      );

      expect(find.byType(FortalBadge), findsOneWidget);
      expect(find.byType(RemixBadge), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixBadge));
    });

    testWidgets('renders FortalButton', (tester) async {
      await tester.pumpRemixApp(
        const FortalButton(
          color: .red,
          radius: .small,
          highContrast: true,
          child: Text('Save'),
        ),
      );

      expect(find.byType(FortalButton), findsOneWidget);
      expect(find.byType(RemixButton), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixButton));
    });

    testWidgets('renders FortalCard', (tester) async {
      await tester.pumpRemixApp(
        const FortalCard(child: SizedBox(width: 24, height: 24)),
      );

      expect(find.byType(FortalCard), findsOneWidget);
      expect(find.byType(RemixCard), findsOneWidget);
    });

    testWidgets('renders FortalCallout', (tester) async {
      await tester.pumpRemixApp(
        const FortalCallout(
          color: .red,
          highContrast: true,
          child: Text('Heads up'),
        ),
      );

      expect(find.byType(FortalCallout), findsOneWidget);
      expect(find.byType(RemixCallout), findsOneWidget);
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixCallout),
        expectsRadius: false,
      );
    });

    testWidgets('renders FortalCheckbox', (tester) async {
      await tester.pumpRemixApp(
        const FortalCheckbox(color: .red, highContrast: true, selected: true),
      );

      expect(find.byType(FortalCheckbox), findsOneWidget);
      expect(find.byType(RemixCheckbox), findsOneWidget);
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixCheckbox),
        expectsRadius: false,
      );
    });

    testWidgets('renders FortalDivider', (tester) async {
      await tester.pumpRemixApp(const FortalDivider(color: .red));

      expect(find.byType(FortalDivider), findsOneWidget);
      expect(find.byType(RemixDivider), findsOneWidget);
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixDivider),
        expectsRadius: false,
      );

      final divider = tester.widget<Box>(
        find.descendant(
          of: find.byType(RemixDivider),
          matching: find.byType(Box),
        ),
      );
      final decoration = divider.styleSpec!.spec.decoration as BoxDecoration;
      expect(decoration.color, red.light.scale.alphaStep(6));
    });

    testWidgets('renders FortalIconButton', (tester) async {
      await tester.pumpRemixApp(
        const FortalIconButton(
          color: .red,
          radius: .small,
          highContrast: true,
          semanticLabel: 'Add',
          child: Icon(Icons.add),
        ),
      );

      expect(find.byType(FortalIconButton), findsOneWidget);
      expect(find.byType(RemixIconButton), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixIconButton));
    });

    testWidgets('renders FortalProgress', (tester) async {
      await tester.pumpRemixApp(
        const FortalProgress(
          color: .red,
          radius: .small,
          highContrast: true,
          value: 50,
        ),
      );

      expect(find.byType(FortalProgress), findsOneWidget);
      expect(find.byType(RemixProgress), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixProgress));
    });

    testWidgets('renders FortalRadio', (tester) async {
      await tester.pumpRemixApp(
        const RemixRadioGroup<String>(
          groupValue: 'option',
          child: FortalRadio<String>(
            color: .red,
            highContrast: true,
            value: 'option',
          ),
        ),
      );

      expect(find.byType(FortalRadio<String>), findsOneWidget);
      expect(find.byType(RemixRadio<String>), findsOneWidget);
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixRadio<String>),
        expectsRadius: false,
      );
    });

    testWidgets('renders FortalSlider', (tester) async {
      await tester.pumpRemixApp(
        const FortalSlider(
          color: .red,
          radius: .small,
          highContrast: true,
          values: [50],
        ),
      );

      expect(find.byType(FortalSlider), findsOneWidget);
      expect(find.byType(RemixSlider), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixSlider));
    });

    testWidgets('renders FortalSpinner', (tester) async {
      await tester.pumpRemixApp(const FortalSpinner());

      expect(find.byType(FortalSpinner), findsOneWidget);
      expect(find.byType(RemixSpinner), findsOneWidget);
    });

    testWidgets('renders FortalSwitch', (tester) async {
      await tester.pumpRemixApp(
        const FortalSwitch(
          color: .red,
          radius: .small,
          highContrast: true,
          selected: true,
        ),
      );

      expect(find.byType(FortalSwitch), findsOneWidget);
      expect(find.byType(RemixSwitch), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixSwitch));
    });

    testWidgets('renders FortalTextField', (tester) async {
      await tester.pumpRemixApp(
        const FortalTextField(color: .red, radius: .small, hintText: 'Email'),
      );

      expect(find.byType(FortalTextField), findsOneWidget);
      expect(find.byType(RemixTextField), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixTextField));
    });

    testWidgets('renders FortalToggle', (tester) async {
      await tester.pumpRemixApp(
        const FortalToggle(
          color: .red,
          radius: .small,
          highContrast: true,
          selected: true,
          label: 'Bold',
        ),
      );

      expect(find.byType(FortalToggle), findsOneWidget);
      expect(find.byType(RemixToggle), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixToggle));
    });

    testWidgets('renders FortalToggleGroup', (tester) async {
      await tester.pumpRemixApp(
        FortalToggleGroup<String>(
          color: .red,
          radius: .small,
          highContrast: true,
          selectedValue: 'a',
          onChanged: (_) {},
          items: const [
            RemixToggleGroupItem(value: 'a', label: 'A'),
            RemixToggleGroupItem(value: 'b', label: 'B'),
          ],
        ),
      );

      expect(find.byType(FortalToggleGroup<String>), findsOneWidget);
      expect(find.byType(RemixToggleGroup<String>), findsOneWidget);
      _expectFortalTokenOverride(tester, find.byType(RemixToggleGroup<String>));
    });

    testWidgets('renders FortalDialog', (tester) async {
      await tester.pumpRemixApp(const FortalDialog(title: 'Hello'));
      expect(find.byType(FortalDialog), findsOneWidget);
      expect(find.byType(RemixDialog), findsOneWidget);
    });

    testWidgets('renders FortalTooltip', (tester) async {
      await tester.pumpRemixApp(
        const FortalTooltip(tooltipChild: Text('tip'), child: Text('target')),
      );
      expect(find.byType(FortalTooltip), findsOneWidget);
      expect(find.byType(RemixTooltip), findsOneWidget);
    });

    testWidgets('renders FortalMenu', (tester) async {
      await tester.pumpRemixApp(
        FortalMenu<String>(
          color: .red,
          trigger: const Text('Menu'),
          entries: const [RemixMenuAction(value: 'a', child: Text('A'))],
        ),
      );
      expect(find.byType(FortalMenu<String>), findsOneWidget);
      expect(find.byType(RemixMenu<String>), findsOneWidget);
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();
      _expectFortalTokenOverride(
        tester,
        find.text('A'),
        expectedRadius: const Radius.circular(6),
      );
    });

    testWidgets('renders FortalSelect', (tester) async {
      await tester.pumpRemixApp(
        FortalSelect<String>(
          triggerColor: .red,
          triggerRadius: .small,
          contentColor: .red,
          contentHighContrast: true,
          trigger: const RemixSelectTrigger(placeholder: 'Pick'),
          entries: const [RemixSelectItem(value: 'a', label: 'A')],
          onChanged: (_) {},
        ),
      );
      expect(find.byType(FortalSelect<String>), findsOneWidget);
      expect(find.byType(RemixSelect<String>), findsOneWidget);
    });

    testWidgets('renders FortalTabBar/Tab/TabView', (tester) async {
      await tester.pumpRemixApp(
        RemixTabs(
          selectedTabId: 'a',
          onChanged: (_) {},
          child: Column(
            children: [
              FortalTabBar(
                color: .red,
                highContrast: true,
                children: const [
                  FortalTab(tabId: 'a', label: 'A'),
                  FortalTab(tabId: 'b', label: 'B'),
                ],
              ),
              const FortalTabView(tabId: 'a', child: Text('A view')),
              const FortalTabView(tabId: 'b', child: Text('B view')),
            ],
          ),
        ),
      );
      expect(find.byType(FortalTabBar), findsOneWidget);
      expect(find.byType(FortalTab), findsNWidgets(2));
      expect(find.byType(FortalTabView), findsNWidgets(2));
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixTabBar),
        expectsRadius: false,
      );
      _expectFortalTokenOverride(
        tester,
        find.byType(RemixTab).first,
        expectsRadius: false,
      );
    });
  });
}

void _expectFortalTokenOverride(
  WidgetTester tester,
  Finder finder, {
  bool expectsRadius = true,
  Radius expectedRadius = const Radius.circular(4.5),
}) {
  final context = tester.element(finder);

  expect(
    MixScope.tokenOf(FortalTokens.accent9, context),
    red.light.scale.step(9),
  );
  if (expectsRadius) {
    expect(MixScope.tokenOf(FortalTokens.radius3, context), expectedRadius);
  }
}
