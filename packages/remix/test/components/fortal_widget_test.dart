import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

typedef _StyleAwareFortalMenuConstructor =
    FortalMenu<String> Function({
      required RemixMenuTrigger trigger,
      required List<RemixMenuItemData<String>> items,
      MenuStyler? style,
    });

void main() {
  group('Fortal widgets', () {
    test('named constructors pin variants and infer generic types', () {
      const button = FortalButton.soft(label: 'Save');
      const accordion = FortalAccordion.soft(value: 'item', child: SizedBox());
      const radio = FortalRadio.soft(value: 'option');
      const menu = FortalMenu.soft(
        trigger: RemixMenuTrigger(label: 'Menu'),
        items: [RemixMenuItem(value: 'a', label: 'A')],
      );
      const select = FortalSelect.ghost(
        trigger: RemixSelectTrigger(placeholder: 'Pick'),
        items: [RemixSelectItem(value: 'a', label: 'A')],
      );
      const segmented = FortalSegmentedControl.classic(
        items: [RemixSegmentedControlItem(value: 'a', label: 'A')],
        selectedValue: 'a',
      );
      const textArea = FortalTextArea.soft();

      expect(button.variant, FortalButtonVariant.soft);
      expect(accordion, isA<FortalAccordion<String>>());
      expect(accordion.variant, FortalAccordionVariant.soft);
      expect(radio, isA<FortalRadio<String>>());
      expect(radio.variant, FortalRadioVariant.soft);
      expect(menu, isA<FortalMenu<String>>());
      expect(menu.variant, FortalMenuVariant.soft);
      expect(select, isA<FortalSelect<String>>());
      expect(select.variant, FortalSelectVariant.ghost);
      expect(segmented, isA<FortalSegmentedControl<String>>());
      expect(segmented.variant, FortalSegmentedControlVariant.classic);
      expect(textArea.variant, FortalTextAreaVariant.soft);
    });

    test('FortalMenu constructors do not expose style overrides', () {
      final constructors = [
        FortalMenu<String>.new,
        FortalMenu<String>.solid,
        FortalMenu<String>.soft,
      ];

      for (final constructor in constructors) {
        expect(constructor, isNot(isA<_StyleAwareFortalMenuConstructor>()));
      }
    });

    testWidgets('renders FortalAccordion', (tester) async {
      await tester.pumpRemixApp(
        RemixAccordionGroup<String>(
          controller: RemixAccordionController<String>(),
          child: const FortalAccordion<String>(
            value: 'item',
            title: 'Item',
            child: Text('Content'),
          ),
        ),
      );

      expect(find.byType(FortalAccordion<String>), findsOneWidget);
      expect(find.byType(RemixAccordion<String>), findsOneWidget);
    });

    testWidgets('forwards FortalAvatar recipe parameters', (tester) async {
      await tester.pumpRemixApp(
        const FortalAvatar.solid(
          label: 'LF',
          highContrast: true,
          fallbackLength: 2,
        ),
      );

      expect(find.byType(FortalAvatar), findsOneWidget);
      expect(find.byType(RemixAvatar), findsOneWidget);

      final generated = tester.widget<FortalAvatar>(find.byType(FortalAvatar));
      expect(generated.variant, FortalAvatarVariant.solid);
      expect(generated.highContrast, isTrue);
      expect(generated.fallbackLength, 2);

      final avatar = tester.widget<RemixAvatar>(find.byType(RemixAvatar));
      expect(
        avatar.style,
        fortalAvatarStyle(
          variant: .solid,
          highContrast: true,
          fallbackLength: 2,
        ),
      );
    });

    testWidgets('renders FortalBadge', (tester) async {
      await tester.pumpRemixApp(const FortalBadge(label: 'New'));

      expect(find.byType(FortalBadge), findsOneWidget);
      expect(find.byType(RemixBadge), findsOneWidget);
    });

    testWidgets('non-solid FortalBadge variants use accessible accent text', (
      tester,
    ) async {
      final colors = resolveFortalTokens(const FortalThemeConfig());

      for (final variant in [
        FortalBadgeVariant.soft,
        FortalBadgeVariant.surface,
        FortalBadgeVariant.outline,
      ]) {
        await tester.pumpRemixApp(
          FortalBadge(label: variant.name, variant: variant),
        );
        await tester.pumpAndSettle();

        final label = tester.widget<Text>(find.text(variant.name));
        expect(
          label.style?.color,
          colors.accent.scale.alphaStep(11),
          reason: '${variant.name} badges use the accent text step',
        );
      }
    });

    test('accent text step meets WCAG AA over soft badge backgrounds', () {
      for (final brightness in Brightness.values) {
        for (final accent in FortalAccentColor.values) {
          final colors = resolveFortalTokens(
            FortalThemeConfig(accent: accent, brightness: brightness),
          );
          final background = Color.alphaBlend(
            colors.accent.scale.alphaStep(3),
            colors.colorBackground,
          );
          final foreground = colors.accent.scale.step(12);

          expect(
            _contrastRatio(foreground, background),
            greaterThanOrEqualTo(4.5),
            reason:
                '${accent.name}/${brightness.name} soft badges must meet '
                'WCAG AA contrast',
          );
        }
      }
    });

    testWidgets('renders FortalButton', (tester) async {
      await tester.pumpRemixApp(const FortalButton(label: 'Save'));

      expect(find.byType(FortalButton), findsOneWidget);
      expect(find.byType(RemixButton), findsOneWidget);
    });

    testWidgets('renders FortalCard', (tester) async {
      await tester.pumpRemixApp(
        const FortalCard(child: SizedBox(width: 24, height: 24)),
      );

      expect(find.byType(FortalCard), findsOneWidget);
      expect(find.byType(RemixCard), findsOneWidget);
    });

    testWidgets('renders FortalCallout', (tester) async {
      await tester.pumpRemixApp(const FortalCallout(text: 'Heads up'));

      expect(find.byType(FortalCallout), findsOneWidget);
      expect(find.byType(RemixCallout), findsOneWidget);
    });

    testWidgets('renders FortalCheckbox', (tester) async {
      await tester.pumpRemixApp(const FortalCheckbox(selected: true));

      expect(find.byType(FortalCheckbox), findsOneWidget);
      expect(find.byType(RemixCheckbox), findsOneWidget);
    });

    testWidgets('renders FortalDivider', (tester) async {
      await tester.pumpRemixApp(const FortalDivider());

      expect(find.byType(FortalDivider), findsOneWidget);
      expect(find.byType(RemixDivider), findsOneWidget);
    });

    testWidgets('renders FortalIconButton', (tester) async {
      await tester.pumpRemixApp(const FortalIconButton(icon: Icons.add));

      expect(find.byType(FortalIconButton), findsOneWidget);
      expect(find.byType(RemixIconButton), findsOneWidget);
    });

    testWidgets('renders FortalProgress', (tester) async {
      await tester.pumpRemixApp(const FortalProgress(value: 0.5));

      expect(find.byType(FortalProgress), findsOneWidget);
      expect(find.byType(RemixProgress), findsOneWidget);
    });

    testWidgets('renders FortalRadio', (tester) async {
      await tester.pumpRemixApp(
        const RemixRadioGroup<String>(
          groupValue: 'option',
          child: FortalRadio<String>(value: 'option'),
        ),
      );

      expect(find.byType(FortalRadio<String>), findsOneWidget);
      expect(find.byType(RemixRadio<String>), findsOneWidget);
    });

    testWidgets('renders FortalSlider', (tester) async {
      await tester.pumpRemixApp(const FortalSlider(value: 0.5));

      expect(find.byType(FortalSlider), findsOneWidget);
      expect(find.byType(RemixSlider), findsOneWidget);
    });

    testWidgets('renders FortalSpinner', (tester) async {
      await tester.pumpRemixApp(const FortalSpinner());

      expect(find.byType(FortalSpinner), findsOneWidget);
      expect(find.byType(RemixSpinner), findsOneWidget);
    });

    testWidgets('renders FortalSwitch', (tester) async {
      await tester.pumpRemixApp(const FortalSwitch(selected: true));

      expect(find.byType(FortalSwitch), findsOneWidget);
      expect(find.byType(RemixSwitch), findsOneWidget);
    });

    testWidgets('renders FortalTextField', (tester) async {
      await tester.pumpRemixApp(const FortalTextField(hintText: 'Email'));

      expect(find.byType(FortalTextField), findsOneWidget);
      expect(find.byType(RemixTextField), findsOneWidget);
    });

    testWidgets('renders the new Fortal wrappers', (tester) async {
      await tester.pumpRemixApp(
        const Column(
          children: [
            FortalSkeleton(),
            FortalSegmentedControl<String>(
              items: [RemixSegmentedControlItem(value: 'a', label: 'A')],
              selectedValue: 'a',
            ),
            FortalTextArea(hintText: 'Notes'),
            FortalDataList(
              items: [RemixDataListItem(label: 'Status', value: 'Active')],
            ),
          ],
        ),
      );

      expect(find.byType(FortalSkeleton), findsOneWidget);
      expect(find.byType(FortalSegmentedControl<String>), findsOneWidget);
      expect(find.byType(FortalTextArea), findsOneWidget);
      expect(find.byType(FortalDataList), findsOneWidget);
      expect(find.byType(RemixSkeleton), findsOneWidget);
      expect(find.byType(RemixSegmentedControl<String>), findsOneWidget);
      expect(find.byType(RemixTextArea), findsOneWidget);
      expect(find.byType(RemixDataList), findsOneWidget);
    });

    testWidgets('renders FortalToggle', (tester) async {
      await tester.pumpRemixApp(
        const FortalToggle(selected: true, label: 'Bold'),
      );

      expect(find.byType(FortalToggle), findsOneWidget);
      expect(find.byType(RemixToggle), findsOneWidget);
    });

    testWidgets('renders FortalToggleGroup', (tester) async {
      await tester.pumpRemixApp(
        FortalToggleGroup<String>(
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

    testWidgets('forwards FortalMenu recipe parameters', (tester) async {
      await tester.pumpRemixApp(
        const FortalMenu<String>.soft(
          size: .size1,
          highContrast: true,
          trigger: RemixMenuTrigger(label: 'Menu'),
          items: [
            RemixMenuCheckboxItem(
              value: 'checked',
              label: 'Checked',
              checked: true,
            ),
          ],
        ),
      );

      expect(find.byType(FortalMenu<String>), findsOneWidget);
      expect(find.byType(RemixMenu<String>), findsOneWidget);

      final generated = tester.widget<FortalMenu<String>>(
        find.byType(FortalMenu<String>),
      );
      expect(generated.variant, FortalMenuVariant.soft);
      expect(generated.size, FortalMenuSize.size1);
      expect(generated.highContrast, isTrue);

      final menu = tester.widget<RemixMenu<String>>(
        find.byType(RemixMenu<String>),
      );
      expect(
        menu.style,
        fortalMenuStyle(variant: .soft, size: .size1, highContrast: true),
      );
    });

    testWidgets('renders FortalSelect', (tester) async {
      await tester.pumpRemixApp(
        FortalSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Pick'),
          items: const [RemixSelectItem(value: 'a', label: 'A')],
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
                child: Row(
                  children: const [
                    FortalTab(tabId: 'a', label: 'A'),
                    FortalTab(tabId: 'b', label: 'B'),
                  ],
                ),
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
    });
  });
}

double _contrastRatio(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final lighter = firstLuminance > secondLuminance
      ? firstLuminance
      : secondLuminance;
  final darker = firstLuminance > secondLuminance
      ? secondLuminance
      : firstLuminance;

  return (lighter + 0.05) / (darker + 0.05);
}
