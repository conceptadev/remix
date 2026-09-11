import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:open_code_fixture/main.dart';
import 'package:open_code_fixture/ui/ui.dart';
import 'package:remix/remix.dart';

void main() {
  test('the default palette retains its Radix Themes 3.3.0 values', () {
    final colors = resolveAcmeTokens(const AcmeThemeConfig());

    expect(colors.colorBackground, const Color(0xFFFFFFFF));
    expect(colors.accent.scale.step(9), const Color(0xFF3E63DD));
    expect(colors.gray.scale.step(12), const Color(0xFF1C2024));
  });

  testWidgets('the example application renders installed source', (
    tester,
  ) async {
    await tester.pumpWidget(const AcmeApp());

    expect(find.byType(AcmeCard), findsOneWidget);
    expect(find.byType(AcmeButton), findsOneWidget);
    expect(find.text('Fortal, now yours'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('every generated Fortal widget builds below AcmeScope', (
    tester,
  ) async {
    final cases = _generatedWidgetCases();
    final seen = <Type>{};

    for (final widgetCase in cases) {
      await tester.pumpWidget(_host(widgetCase.child));
      await tester.pump();

      for (final type in widgetCase.generatedTypes) {
        expect(
          find.byType(type),
          findsOneWidget,
          reason: '${widgetCase.name} must build $type',
        );
        seen.add(type);
      }
      expect(
        tester.takeException(),
        isNull,
        reason: '${widgetCase.name} must build without framework errors',
      );
    }

    expect(seen, _allGeneratedWidgetTypes);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

Widget _host(Widget child) {
  return MaterialApp(
    home: AcmeScope(
      child: Scaffold(
        body: Center(child: SizedBox(width: 640, height: 480, child: child)),
      ),
    ),
  );
}

List<_WidgetCase> _generatedWidgetCases() => [
  _WidgetCase(
    'accordion',
    RemixAccordionGroup<String>(
      controller: RemixAccordionController<String>(),
      child: const AcmeAccordion<String>(
        value: 'item',
        title: 'Item',
        child: Text('Content'),
      ),
    ),
    {AcmeAccordion<String>},
  ),
  const _WidgetCase('avatar', AcmeAvatar(label: 'AC'), {AcmeAvatar}),
  const _WidgetCase('badge', AcmeBadge(label: 'New'), {AcmeBadge}),
  const _WidgetCase('button', AcmeButton(label: 'Save'), {AcmeButton}),
  const _WidgetCase('callout', AcmeCallout(text: 'Notice'), {AcmeCallout}),
  const _WidgetCase('card', AcmeCard(child: Text('Card')), {AcmeCard}),
  _WidgetCase(
    'line chart',
    AcmeLineChart(
      series: [
        LineSeries(
          id: 'revenue',
          label: 'Revenue',
          points: [ChartPoint(id: 'monday', x: 0, y: 18)],
        ),
      ],
    ),
    const {AcmeLineChart},
  ),
  _WidgetCase(
    'bar chart',
    AcmeBarChart(
      groups: [
        BarGroup(
          id: 'q1',
          label: 'Q1',
          bars: [BarValue(id: 'actual', label: 'Actual', toY: 42)],
        ),
      ],
    ),
    const {AcmeBarChart},
  ),
  _WidgetCase(
    'pie chart',
    AcmePieChart(
      slices: [PieSlice(id: 'direct', label: 'Direct', value: 64)],
    ),
    const {AcmePieChart},
  ),
  const _WidgetCase(
    'checkbox',
    AcmeCheckbox(selected: false, label: 'Choice'),
    {AcmeCheckbox},
  ),
  const _WidgetCase(
    'checkbox group item',
    RemixCheckboxGroup<String>(
      values: {},
      child: AcmeCheckboxGroupItem<String>(value: 'a', label: 'Choice A'),
    ),
    {AcmeCheckboxGroupItem<String>},
  ),
  const _WidgetCase(
    'data list',
    AcmeDataList(
      items: [RemixDataListItem(label: 'Name', value: 'Ada')],
    ),
    {AcmeDataList},
  ),
  const _WidgetCase(
    'data table',
    AcmeDataTable<String>(
      rows: [],
      columns: [
        RemixDataTableColumn<String>(
          id: 'value',
          label: 'Value',
          cellBuilder: _stringCell,
        ),
      ],
    ),
    {AcmeDataTable<String>},
  ),
  const _WidgetCase('dialog', AcmeDialog(title: 'Dialog'), {AcmeDialog}),
  const _WidgetCase(
    'disclosure',
    AcmeDisclosure(trigger: Text('More'), content: Text('Details')),
    {AcmeDisclosure},
  ),
  const _WidgetCase('divider', AcmeDivider(), {AcmeDivider}),
  const _WidgetCase(
    'icon button',
    AcmeIconButton(icon: Icons.add, semanticLabel: 'Add'),
    {AcmeIconButton},
  ),
  const _WidgetCase(
    'menu',
    AcmeMenu<String>(
      trigger: RemixMenuTrigger(label: 'Menu'),
      items: [RemixMenuItem(value: 'a', label: 'A')],
    ),
    {AcmeMenu<String>},
  ),
  const _WidgetCase(
    'popover',
    AcmePopover(popoverChild: Text('Content'), child: Text('Open')),
    {AcmePopover},
  ),
  const _WidgetCase('progress', AcmeProgress(value: 0.5), {AcmeProgress}),
  const _WidgetCase(
    'radio',
    RemixRadioGroup<String>(
      groupValue: 'a',
      child: AcmeRadio<String>(value: 'a', semanticLabel: 'Choice A'),
    ),
    {AcmeRadio<String>},
  ),
  const _WidgetCase(
    'segmented control',
    AcmeSegmentedControl<String>(
      items: [RemixSegmentedControlItem(value: 'a', label: 'A')],
      selectedValue: 'a',
    ),
    {AcmeSegmentedControl<String>},
  ),
  const _WidgetCase(
    'select',
    AcmeSelect<String>(
      trigger: RemixSelectTrigger(placeholder: 'Pick'),
      items: [RemixSelectItem(value: 'a', label: 'A')],
    ),
    {AcmeSelect<String>},
  ),
  const _WidgetCase(
    'sidebar',
    AcmeSidebar<String>(
      sections: [
        RemixSidebarSection(
          destinations: [
            RemixSidebarDestination(value: 'overview', label: 'Overview'),
          ],
        ),
      ],
      selectedValue: 'overview',
    ),
    {AcmeSidebar<String>},
  ),
  const _WidgetCase(
    'skeleton',
    AcmeSkeleton(child: SizedBox(width: 80, height: 20)),
    {AcmeSkeleton},
  ),
  const _WidgetCase('slider', AcmeSlider(value: 0.5), {AcmeSlider}),
  const _WidgetCase('spinner', AcmeSpinner(), {AcmeSpinner}),
  const _WidgetCase(
    'switch',
    AcmeSwitch(selected: false, semanticLabel: 'Notifications'),
    {AcmeSwitch},
  ),
  const _WidgetCase(
    'tabs',
    RemixTabs(
      selectedTabId: 'a',
      child: Column(
        children: [
          AcmeTabBar(
            child: Row(
              children: [AcmeTab(tabId: 'a', label: 'A')],
            ),
          ),
          AcmeTabView(tabId: 'a', child: Text('A view')),
        ],
      ),
    ),
    {AcmeTabBar, AcmeTab, AcmeTabView},
  ),
  const _WidgetCase('text', AcmeText('Body'), {AcmeText}),
  const _WidgetCase('text field', AcmeTextField(label: 'Name'), {
    AcmeTextField,
  }),
  const _WidgetCase('text area', AcmeTextArea(label: 'Notes'), {AcmeTextArea}),
  const _WidgetCase('toggle', AcmeToggle(selected: false, label: 'Bold'), {
    AcmeToggle,
  }),
  const _WidgetCase(
    'toggle group',
    AcmeToggleGroup<String>(
      items: [RemixToggleGroupItem(value: 'a', label: 'A')],
      selectedValue: 'a',
    ),
    {AcmeToggleGroup<String>},
  ),
  const _WidgetCase(
    'tooltip',
    AcmeTooltip(tooltipChild: Text('Help'), child: Text('Hover')),
    {AcmeTooltip},
  ),
];

const _allGeneratedWidgetTypes = <Type>{
  AcmeAccordion<String>,
  AcmeAvatar,
  AcmeBadge,
  AcmeButton,
  AcmeCallout,
  AcmeCard,
  AcmeLineChart,
  AcmeBarChart,
  AcmePieChart,
  AcmeCheckbox,
  AcmeCheckboxGroupItem<String>,
  AcmeDataList,
  AcmeDataTable<String>,
  AcmeDialog,
  AcmeDisclosure,
  AcmeDivider,
  AcmeIconButton,
  AcmeMenu<String>,
  AcmePopover,
  AcmeProgress,
  AcmeRadio<String>,
  AcmeSegmentedControl<String>,
  AcmeSelect<String>,
  AcmeSidebar<String>,
  AcmeSkeleton,
  AcmeSlider,
  AcmeSpinner,
  AcmeSwitch,
  AcmeTabBar,
  AcmeTab,
  AcmeTabView,
  AcmeText,
  AcmeTextField,
  AcmeTextArea,
  AcmeToggle,
  AcmeToggleGroup<String>,
  AcmeTooltip,
};

final class _WidgetCase {
  const _WidgetCase(this.name, this.child, this.generatedTypes);

  final String name;
  final Widget child;
  final Set<Type> generatedTypes;
}

Widget _stringCell(BuildContext context, String value) => Text(value);
