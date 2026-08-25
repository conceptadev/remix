import 'package:dashboard/data/models.dart';
import 'package:dashboard/main.dart';
import 'package:dashboard/pages/gallery/gallery_actions_page.dart';
import 'package:dashboard/pages/gallery/gallery_display_page.dart';
import 'package:dashboard/pages/gallery/gallery_forms_page.dart';
import 'package:dashboard/pages/gallery/gallery_navigation_page.dart';
import 'package:dashboard/pages/gallery/gallery_overlays_page.dart';
import 'package:dashboard/pages/gallery/gallery_typography_page.dart';
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
import 'package:remix_fortal/remix_fortal.dart';

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

      _expectCartesian<FortalButton, FortalButtonVariant, FortalButtonSize>(
        tester,
        within: _sectionChild(tester, 'Button'),
        rows: FortalButtonVariant.values,
        columns: FortalButtonSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalIconButton,
        FortalIconButtonVariant,
        FortalIconButtonSize
      >(
        tester,
        within: _sectionChild(tester, 'Icon button'),
        rows: FortalIconButtonVariant.values,
        columns: FortalIconButtonSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalToggle, FortalToggleVariant, FortalToggleSize>(
        tester,
        within: _sectionChild(tester, 'Toggle'),
        rows: FortalToggleVariant.values,
        columns: FortalToggleSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('form matrices render every variant and size pair', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryFormsPage());

      _expectCartesian<
        FortalTextField,
        FortalTextFieldVariant,
        FortalTextFieldSize
      >(
        tester,
        within: _sectionChild(tester, 'Text field'),
        rows: FortalTextFieldVariant.values,
        columns: FortalTextFieldSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalTextArea,
        FortalTextAreaVariant,
        FortalTextAreaSize
      >(
        tester,
        within: _sectionChild(tester, 'Text area'),
        rows: FortalTextAreaVariant.values,
        columns: FortalTextAreaSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalSegmentedControl<String>,
        FortalSegmentedControlVariant,
        FortalSegmentedControlSize
      >(
        tester,
        within: _sectionChild(tester, 'Segmented control'),
        rows: FortalSegmentedControlVariant.values,
        columns: FortalSegmentedControlSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalSelect<String>,
        FortalSelectVariant,
        FortalSelectSize
      >(
        tester,
        within: _sectionChild(tester, 'Select'),
        rows: FortalSelectVariant.values,
        columns: FortalSelectSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalToggleGroup<String>,
        FortalToggleGroupVariant,
        FortalToggleGroupSize
      >(
        tester,
        within: _sectionChild(tester, 'Toggle group'),
        rows: FortalToggleGroupVariant.values,
        columns: FortalToggleGroupSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalCheckbox,
        FortalCheckboxVariant,
        FortalCheckboxSize
      >(
        tester,
        within: _sectionChild(tester, 'Checkbox'),
        rows: FortalCheckboxVariant.values,
        columns: FortalCheckboxSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalRadio<int>, FortalRadioVariant, FortalRadioSize>(
        tester,
        within: _sectionChild(tester, 'Radio'),
        rows: FortalRadioVariant.values,
        columns: FortalRadioSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalSwitch, FortalSwitchVariant, FortalSwitchSize>(
        tester,
        within: _sectionChild(tester, 'Switch'),
        rows: FortalSwitchVariant.values,
        columns: FortalSwitchSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalSlider, FortalSliderVariant, FortalSliderSize>(
        tester,
        within: _sectionChild(tester, 'Slider'),
        rows: FortalSliderVariant.values,
        columns: FortalSliderSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('display matrices render their complete preset axes', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryDisplayPage());

      _expectCartesian<FortalAvatar, FortalAvatarVariant, FortalAvatarSize>(
        tester,
        within: _sectionChild(tester, 'Avatar'),
        rows: FortalAvatarVariant.values,
        columns: FortalAvatarSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalBadge, FortalBadgeVariant, FortalBadgeSize>(
        tester,
        within: _sectionChild(tester, 'Badge'),
        rows: FortalBadgeVariant.values,
        columns: FortalBadgeSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalCard, FortalCardVariant, FortalCardSize>(
        tester,
        within: _sectionChild(tester, 'Card'),
        rows: FortalCardVariant.values,
        columns: FortalCardSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalCallout, FortalCalloutVariant, FortalCalloutSize>(
        tester,
        within: _sectionChild(tester, 'Callout'),
        rows: FortalCalloutVariant.values,
        columns: FortalCalloutSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalProgress,
        FortalProgressVariant,
        FortalProgressSize
      >(
        tester,
        within: _sectionChild(tester, 'Progress'),
        rows: FortalProgressVariant.values,
        columns: FortalProgressSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<FortalDataList, Axis, FortalDataListSize>(
        tester,
        within: _sectionChild(tester, 'Data list'),
        rows: Axis.values,
        columns: FortalDataListSize.values,
        rowOf: (widget) => widget.orientation,
        columnOf: (widget) => widget.size,
      );
    });

    testWidgets('navigation and overlay matrices use every declared preset', (
      tester,
    ) async {
      await _pumpPage(tester, const GalleryNavigationPage());

      _expectValues<FortalTab, FortalTabsSize>(
        tester,
        within: _sectionChild(tester, 'Tabs'),
        expected: FortalTabsSize.values,
        valueOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalDisclosure,
        FortalDisclosureVariant,
        FortalDisclosureSize
      >(
        tester,
        within: _sectionChild(tester, 'Disclosure'),
        rows: FortalDisclosureVariant.values,
        columns: FortalDisclosureSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectCartesian<
        FortalAccordion<String>,
        FortalAccordionVariant,
        FortalAccordionSize
      >(
        tester,
        within: _sectionChild(tester, 'Accordion'),
        rows: FortalAccordionVariant.values,
        columns: FortalAccordionSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );

      await _pumpPage(tester, const GalleryOverlaysPage());
      _expectCartesian<FortalMenu<String>, FortalMenuVariant, FortalMenuSize>(
        tester,
        within: _sectionChild(tester, 'Menu'),
        rows: FortalMenuVariant.values,
        columns: FortalMenuSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );
      _expectValues<FortalPopover, FortalPopoverSize>(
        tester,
        within: _sectionChild(tester, 'Popover'),
        expected: FortalPopoverSize.values,
        valueOf: (widget) => widget.size,
      );

      final dialogSection = _sectionChild(tester, 'Dialog');
      final dialogMatrix = tester
          .widget<GalleryEnumMatrix<FortalDialogAlign, FortalDialogSize>>(
            dialogSection,
          );
      expect(dialogMatrix.rows, FortalDialogAlign.values);
      expect(dialogMatrix.columns, FortalDialogSize.values);
      expect(
        tester
            .widgetList<FortalButton>(
              find.descendant(
                of: dialogSection,
                matching: find.byType(FortalButton),
              ),
            )
            .map((button) => button.semanticLabel)
            .toSet(),
        {
          for (final align in FortalDialogAlign.values)
            for (final size in FortalDialogSize.values)
              'Open ${enumLabel(align)} ${enumLabel(size)} dialog',
        },
      );
    });

    testWidgets('typography matrices use typed preset values', (tester) async {
      await _pumpPage(tester, const GalleryTypographyPage());

      _expectCartesian<FortalCode, FortalCodeVariant, bool>(
        tester,
        within: _sectionChild(tester, 'Code'),
        rows: FortalCodeVariant.values,
        columns: const [false, true],
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.highContrast,
      );
      _expectCartesian<FortalKbd, FortalKbdVariant, FortalTextSize?>(
        tester,
        within: _sectionChild(tester, 'Keyboard keys'),
        rows: FortalKbdVariant.values,
        columns: FortalTextSize.values,
        rowOf: (widget) => widget.variant,
        columnOf: (widget) => widget.size,
      );

      final weights = _sectionChild(tester, 'Weights');
      for (final values in [
        tester
            .widgetList<FortalText>(_within<FortalText>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<FortalHeading>(_within<FortalHeading>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<FortalCode>(_within<FortalCode>(weights))
            .map((widget) => widget.weight),
        tester
            .widgetList<FortalLink>(_within<FortalLink>(weights))
            .map((widget) => widget.weight),
      ]) {
        final actual = values.toList();
        expect(actual, hasLength(FortalTextWeight.values.length));
        expect(actual.toSet(), FortalTextWeight.values.toSet());
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

      final dialog = tester.widget<FortalDialog>(find.byType(FortalDialog));
      expect(dialog.align, FortalDialogAlign.start);
      expect(dialog.size, FortalDialogSize.size1);
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
            builder: (context, child) => FortalScope(child: child!),
            home: const Scaffold(body: ThemePanel()),
          ),
        ),
      );

      expect(_segmentedValues<ThemeMode>(tester), ThemeMode.values);
      expect(
        _segmentedValues<FortalPanelBackground>(tester),
        FortalPanelBackground.values,
      );
      expect(_segmentedValues<FortalRadius>(tester), FortalRadius.values);
      expect(_segmentedValues<FortalScaling>(tester), FortalScaling.values);

      final gray = tester.widget<FortalSelect<FortalGrayColor>>(
        find.byType(FortalSelect<FortalGrayColor>),
      );
      expect(
        gray.items.map((item) => item.value).toList(),
        FortalGrayColor.values,
      );
      for (final accent in FortalAccentColor.values) {
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
      await tester.tap(find.byKey(const ValueKey('nav-settings')).first);
      await tester.pump();

      final root = FortalTheme.of(tester.element(find.byType(DashboardShell)));
      final danger = FortalTheme.of(tester.element(find.text('Danger zone')));

      expect(danger.accent, FortalAccentColor.red);
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

      const expectedAccents = <String, FortalAccentColor>{
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
          FortalTheme.of(tester.element(find.text(entry.key))).accent,
          entry.value,
          reason: entry.key,
        );
      }
      expect(
        tester.widgetList<FortalBadge>(find.byType(FortalBadge)),
        everyElement(
          isA<FortalBadge>().having(
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
      builder: (context, child) => FortalScope(child: child!),
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
  final control = tester.widget<FortalSegmentedControl<T>>(
    find.byType(FortalSegmentedControl<T>),
  );
  return control.items.map((item) => item.value).toList();
}
