import 'package:dashboard/data/models.dart';
import 'package:dashboard/main.dart';
import 'package:dashboard/pages/gallery/gallery_actions_page.dart';
import 'package:dashboard/pages/gallery/gallery_display_page.dart';
import 'package:dashboard/pages/gallery/gallery_forms_page.dart';
import 'package:dashboard/pages/gallery/gallery_navigation_page.dart';
import 'package:dashboard/pages/gallery/gallery_overlays_page.dart';
import 'package:dashboard/pages/gallery/gallery_typography_page.dart';
import 'package:dashboard/shell/dashboard_page.dart';
import 'package:dashboard/shell/dashboard_shell.dart';
import 'package:dashboard/theme/theme_scope.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:dashboard/utils/text.dart';
import 'package:dashboard/widgets/gallery_scaffold.dart';
import 'package:dashboard/widgets/status_badge.dart';
import 'package:dashboard/widgets/theme_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:dashboard/ui/ui.dart';

void main() {
  group('gallery preset contracts', () {
    testWidgets('gallery matrices use Mix Grid with content-sized rows', (
      tester,
    ) async {
      await _pumpPage(
        tester,
        GalleryMatrix<String, String>(
          rows: const ['Tall sample'],
          columns: const ['Example'],
          rowLabelBuilder: (label) => label,
          columnLabelBuilder: (label) => label,
          cellBuilder: (_, _, _) => const SizedBox(height: 120),
        ),
      );

      final grid = find.byType(GridBox);
      expect(grid, findsOneWidget);
      expect(tester.getSize(grid).height, greaterThan(180));
      expect(tester.takeException(), isNull);
    });

    testWidgets('action matrices render every variant and size pair', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryActionsPage());

      _expectCartesian<UiButton, UiButtonVariant, UiButtonSize>(
        tester,
        within: _sectionChild(tester, 'Button'),
        rows: UiButtonVariant.values,
        columns: UiButtonSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiIconButton, UiIconButtonVariant, UiIconButtonSize>(
        tester,
        within: _sectionChild(tester, 'Icon button'),
        rows: UiIconButtonVariant.values,
        columns: UiIconButtonSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiToggle, UiToggleVariant, UiToggleSize>(
        tester,
        within: _sectionChild(tester, 'Toggle'),
        rows: UiToggleVariant.values,
        columns: UiToggleSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('form matrices render every variant and size pair', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryFormsPage());

      _expectCartesian<UiTextField, UiTextFieldVariant, UiTextFieldSize>(
        tester,
        within: _sectionChild(tester, 'Text field'),
        rows: UiTextFieldVariant.values,
        columns: UiTextFieldSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiTextArea, UiTextAreaVariant, UiTextAreaSize>(
        tester,
        within: _sectionChild(tester, 'Text area'),
        rows: UiTextAreaVariant.values,
        columns: UiTextAreaSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        UiSegmentedControl<String>,
        UiSegmentedControlVariant,
        UiSegmentedControlSize
      >(
        tester,
        within: _sectionChild(tester, 'Segmented control'),
        rows: UiSegmentedControlVariant.values,
        columns: UiSegmentedControlSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiSelect<String>, UiSelectVariant, UiSelectSize>(
        tester,
        within: _sectionChild(tester, 'Select'),
        rows: UiSelectVariant.values,
        columns: UiSelectSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        UiToggleGroup<String>,
        UiToggleGroupVariant,
        UiToggleGroupSize
      >(
        tester,
        within: _sectionChild(tester, 'Toggle group'),
        rows: UiToggleGroupVariant.values,
        columns: UiToggleGroupSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiCheckbox, UiCheckboxVariant, UiCheckboxSize>(
        tester,
        within: _sectionChild(tester, 'Checkbox'),
        rows: UiCheckboxVariant.values,
        columns: UiCheckboxSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiRadio<int>, UiRadioVariant, UiRadioSize>(
        tester,
        within: _sectionChild(tester, 'Radio'),
        rows: UiRadioVariant.values,
        columns: UiRadioSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiSwitch, UiSwitchVariant, UiSwitchSize>(
        tester,
        within: _sectionChild(tester, 'Switch'),
        rows: UiSwitchVariant.values,
        columns: UiSwitchSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiSlider, UiSliderVariant, UiSliderSize>(
        tester,
        within: _sectionChild(tester, 'Slider'),
        rows: UiSliderVariant.values,
        columns: UiSliderSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('display matrices render their complete preset axes', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryDisplayPage());

      _expectCartesian<UiAvatar, UiAvatarVariant, UiAvatarSize>(
        tester,
        within: _sectionChild(tester, 'Avatar'),
        rows: UiAvatarVariant.values,
        columns: UiAvatarSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiBadge, UiBadgeVariant, UiBadgeSize>(
        tester,
        within: _sectionChild(tester, 'Badge'),
        rows: UiBadgeVariant.values,
        columns: UiBadgeSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiCard, UiCardVariant, UiCardSize>(
        tester,
        within: _sectionChild(tester, 'Card'),
        rows: UiCardVariant.values,
        columns: UiCardSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiCallout, UiCalloutVariant, UiCalloutSize>(
        tester,
        within: _sectionChild(tester, 'Callout'),
        rows: UiCalloutVariant.values,
        columns: UiCalloutSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiProgress, UiProgressVariant, UiProgressSize>(
        tester,
        within: _sectionChild(tester, 'Progress'),
        rows: UiProgressVariant.values,
        columns: UiProgressSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<UiDataList, Axis, UiDataListSize>(
        tester,
        within: _sectionChild(tester, 'Data list'),
        rows: Axis.values,
        columns: UiDataListSize.values,
        rowOf: (widget) => widget.orientation,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('navigation and overlay matrices use every declared preset', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryNavigationPage());

      final sidebarSection = _sectionChild(tester, 'Sidebar');
      final sidebar = tester.widget<UiSidebar<String>>(
        _within<UiSidebar<String>>(sidebarSection),
      );
      expect(sidebar.selectedValue, 'overview');
      expect(sidebar.sections, hasLength(2));
      expect(sidebar.header, isNotNull);
      expect(sidebar.footer, isNotNull);

      _expectValues<UiTab, UiTabsSize>(
        tester,
        within: _sectionChild(tester, 'Tabs'),
        expected: UiTabsSize.values,
        valueOf: (widget) => widget.size,
      );
      _expectCartesian<UiDisclosure, UiDisclosureVariant, UiDisclosureSize>(
        tester,
        within: _sectionChild(tester, 'Disclosure'),
        rows: UiDisclosureVariant.values,
        columns: UiDisclosureSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        UiAccordion<String>,
        UiAccordionVariant,
        UiAccordionSize
      >(
        tester,
        within: _sectionChild(tester, 'Accordion'),
        rows: UiAccordionVariant.values,
        columns: UiAccordionSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );

      await _pumpPage(tester, const GalleryOverlaysPage());
      _expectCartesian<UiMenu<String>, UiMenuVariant, UiMenuSize>(
        tester,
        within: _sectionChild(tester, 'Menu'),
        rows: UiMenuVariant.values,
        columns: UiMenuSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectValues<UiPopover, UiPopoverSize>(
        tester,
        within: _sectionChild(tester, 'Popover'),
        expected: UiPopoverSize.values,
        valueOf: (widget) => widget.size,
      );

      final dialogSection = _sectionChild(tester, 'Dialog');
      final dialogMatrix = tester
          .widget<GalleryEnumMatrix<UiDialogAlign, UiDialogSize>>(
            dialogSection,
          );
      expect(dialogMatrix.rows, UiDialogAlign.values);
      expect(dialogMatrix.columns, UiDialogSize.values);
      expect(
        tester
            .widgetList<UiButton>(
              find.descendant(
                of: dialogSection,
                matching: find.byType(UiButton),
              ),
            )
            .map((button) => button.semanticLabel)
            .toSet(),
        {
          for (final align in UiDialogAlign.values)
            for (final size in UiDialogSize.values)
              'Open ${enumLabel(align)} ${enumLabel(size)} dialog',
        },
      );
    });

    testWidgets('typography matrices use typed preset values', (tester) async {
      await _pumpPage(tester, const GalleryTypographyPage());

      _expectCartesian<UiCode, UiCodeVariant, bool>(
        tester,
        within: _sectionChild(tester, 'Code'),
        rows: UiCodeVariant.values,
        columns: const [false, true],
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.highContrast,
      );
      _expectCartesian<UiKbd, UiKbdVariant, UiTextSize?>(
        tester,
        within: _sectionChild(tester, 'Keyboard keys'),
        rows: UiKbdVariant.values,
        columns: UiTextSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );

      final weights = _sectionChild(tester, 'Weights');
      for (final values in [
        tester
            .widgetList<UiText>(_within<UiText>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<UiHeading>(_within<UiHeading>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<UiCode>(_within<UiCode>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<UiLink>(_within<UiLink>(weights))
            .map((widget) => widget.weight),
      ]) {
        final actual = values.toList();
        expect(actual, hasLength(UiTextWeight.values.length));
        expect(actual.toSet(), UiTextWeight.values.toSet());
      }
    });

    testWidgets('dialog matrix forwards its nondefault alignment and size', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryOverlaysPage());

      final trigger = find.bySemanticsLabel('Open Start Size1 dialog');
      await tester.ensureVisible(trigger);
      await tester.tap(trigger);
      for (var frame = 0; frame < 5; frame++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      final dialog = tester.widget<UiDialog>(find.byType(UiDialog));
      expect(dialog.align, UiDialogAlign.start);
      expect(dialog.size, UiDialogSize.size1);
    });
  });

  group('theme and scope contracts', () {
    testWidgets('theme controls source every option from the current enums', (
      tester,
    ) async {
      await tester.pumpWidget(
        ThemeScope(
          settings: const ThemeSettings(),
          onChanged: (_) {},
          child: MaterialApp(
            builder: (context, child) => UiScope(child: child!),
            home: const Scaffold(body: ThemePanel()),
          ),
        ),
      );

      expect(_segmentedValues<ThemeMode>(tester), ThemeMode.values);
      expect(
        _segmentedValues<UiPanelBackground>(tester),
        UiPanelBackground.values,
      );
      expect(_segmentedValues<UiRadius>(tester), UiRadius.values);
      expect(_segmentedValues<UiScaling>(tester), UiScaling.values);

      final gray = tester.widget<UiSelect<UiGrayColor>>(
        find.byType(UiSelect<UiGrayColor>),
      );
      expect(gray.items.map((item) => item.value).toList(), UiGrayColor.values);
      for (final accent in UiAccentColor.values) {
        expect(find.byKey(ValueKey('accent-${accent.name}')), findsOneWidget);
      }
    });

    testWidgets('an app accent scope overrides only the local accent', (
      tester,
    ) async {
      await tester.pumpWidget(
        const DashboardApp(
          initialSettings: ThemeSettings(
            appearance: .dark,
            accentColor: .blue,
            grayColor: .mauve,
            panelBackground: .translucent,
            radius: .large,
            scaling: .percent110,
          ),
        ),
      );
      await tester.tap(
        find.byKey(const ValueKey(DashboardPage.settings)).first,
      );
      await tester.pump();

      final root = UiTheme.of(tester.element(find.byType(DashboardShell)));
      final danger = UiTheme.of(tester.element(find.text('Danger zone')));

      expect(danger.accent, UiAccentColor.red);
      expect(danger.gray, root.gray);
      expect(danger.brightness, root.brightness);
      expect(danger.panelBackground, root.panelBackground);
      expect(danger.radius, root.radius);
      expect(danger.scaling, root.scaling);
      expect(danger.hasBackground, isFalse);
    });

    testWidgets('domain status scopes and contrast remain semantic', (
      tester,
    ) async {
      await _pumpPage(
        tester,
        Column(
          children: [
            for (final status in OrderStatus.values) StatusBadge.order(status),
            for (final status in CustomerStatus.values)
              StatusBadge.customer(status),
          ],
        ),
      );

      const expectedAccents = <String, UiAccentColor>{
        'Paid': .green,
        'Pending': .amber,
        'Refunded': .red,
        'Cancelled': .gray,
        'Active': .green,
        'Invited': .blue,
        'Suspended': .red,
      };
      for (final entry in expectedAccents.entries) {
        expect(
          UiTheme.of(tester.element(find.text(entry.key))).accent,
          entry.value,
          reason: entry.key,
        );
      }
      expect(
        tester.widgetList<UiBadge>(find.byType(UiBadge)),
        everyElement(
          isA<UiBadge>().having(
            (badge) => badge.highContrast,
            'highContrast',
            isTrue,
          ),
        ),
      );
    });
  });
}

Future<void> _pumpPage(WidgetTester tester, Widget page) {
  return tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => UiScope(child: child!),
      home: Scaffold(body: page),
    ),
  );
}

Finder _sectionChild(WidgetTester tester, String label) {
  final sectionFinder = find.byWidgetPredicate(
    (widget) => widget is GallerySection && widget.label == label,
  );
  expect(sectionFinder, findsOneWidget, reason: label);
  return find.byWidget(tester.widget<GallerySection>(sectionFinder).child);
}

Finder _within<W extends Widget>(Finder parent) => find.descendant(
  of: parent,
  matching: find.byWidgetPredicate((widget) => widget is W),
);

void _expectCartesian<W extends Widget, R, C>(
  WidgetTester tester, {
  required Finder within,
  required List<R> rows,
  required List<C> columns,
  required R Function(W widget) rowOf,
  required C Function(W widget) columnOf,
}) {
  expect(
    {
      for (final widget in tester.widgetList<W>(_within<W>(within)))
        (rowOf(widget), columnOf(widget)),
    },
    {
      for (final row in rows)
        for (final column in columns) (row, column),
    },
  );
}

void _expectValues<W extends Widget, V>(
  WidgetTester tester, {
  required Finder within,
  required List<V> expected,
  required V Function(W widget) valueOf,
}) {
  expect(
    tester.widgetList<W>(_within<W>(within)).map(valueOf).toSet(),
    expected.toSet(),
  );
}

List<T> _segmentedValues<T extends Enum>(WidgetTester tester) {
  final control = tester.widget<UiSegmentedControl<T>>(
    find.byType(UiSegmentedControl<T>),
  );
  return control.items.map((item) => item.value).toList();
}
