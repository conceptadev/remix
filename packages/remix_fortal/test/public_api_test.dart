import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'helpers/test_helpers.dart';

void main() {
  test('the Fortal surface frame helper is public', () {
    final frame = fortalSurfaceFrame(
      fillColor: const Color(0xFFFFFFFF),
      borderColor: const Color(0xFF000000),
      borderWidth: 1,
      radius: const Radius.circular(8),
    );

    expect(frame, isA<BoxStyler>());
  });

  test('new Fortal controls expose generated public wrappers', () {
    const segmented = FortalSegmentedControl<String>.classic(
      items: [RemixSegmentedControlItem(value: 'one', label: 'One')],
      selectedValue: 'one',
      size: FortalSegmentedControlSize.size3,
    );
    const textArea = FortalTextArea.soft(
      hintText: 'Notes',
      size: FortalTextAreaSize.size1,
    );

    expect(segmented, isA<FortalSegmentedControl<String>>());
    expect(segmented.variant, FortalSegmentedControlVariant.classic);
    expect(segmented.size, FortalSegmentedControlSize.size3);
    expect(textArea, isA<FortalTextArea>());
    expect(textArea.variant, FortalTextAreaVariant.soft);
    expect(textArea.size, FortalTextAreaSize.size1);
    expect(fortalSegmentedControlStyle(), isA<SegmentedControlStyler>());
    expect(fortalTextAreaStyle(), isA<TextFieldStyler>());
  });

  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });

  test('the Fortal skeleton wrapper is constructible from the public API', () {
    expect(const FortalSkeleton(), isA<FortalSkeleton>());
    expect(fortalSkeletonStyle(), isA<SkeletonStyler>());
  });

  test('the Fortal data list wrapper is constructible from the public API', () {
    const item = RemixDataListItem(label: 'Name', value: 'Jane');
    const fortal = FortalDataList(
      items: [item],
      size: FortalDataListSize.size3,
      highContrast: true,
    );

    expect(fortal, isA<FortalDataList>());
    expect(fortal.size, FortalDataListSize.size3);
    expect(fortal.highContrast, isTrue);
    expect(fortalDataListStyle(), isA<DataListStyler>());
  });

  test(
    'the Fortal data table wrapper is constructible from the public API',
    () {
      const fortal = FortalDataTable<String>.surface(
        rows: ['one'],
        columns: [],
        size: FortalDataTableSize.size3,
      );

      expect(fortal, isA<FortalDataTable<String>>());
      expect(fortal.variant, FortalDataTableVariant.surface);
      expect(fortalDataTableStyle(), isA<DataTableStyler>());
    },
  );

  test('the typography wrappers are constructible from the public API', () {
    const text = FortalText(
      'Body',
      size: FortalTextSize.size3,
      weight: FortalTextWeight.medium,
    );
    const heading = FortalHeading(
      'Title',
      headingLevel: 2,
      size: FortalTextSize.size4,
      weight: FortalTextWeight.medium,
    );
    const code = FortalCode.outline('code', size: FortalTextSize.size2);
    const kbd = FortalKbd.soft('⌘K', semanticLabel: 'Command K');
    const link = FortalLink(
      'Docs',
      underline: FortalLinkUnderline.always,
      size: FortalTextSize.size2,
    );

    expect(text.size, FortalTextSize.size3);
    expect(text.weight, FortalTextWeight.medium);
    expect(heading.headingLevel, 2);
    expect(heading.size, FortalTextSize.size4);
    expect(code.variant, FortalCodeVariant.outline);
    expect(kbd.variant, FortalKbdVariant.soft);
    expect(link.underline, FortalLinkUnderline.always);
    expect(fortalTextStyle(), isA<TextStyler>());
    expect(fortalHeadingStyle(), isA<TextStyler>());
  });

  testWidgets('the context-bound typography recipes are public', (
    tester,
  ) async {
    final recipes = await resolveInFortalScope(
      tester,
      (context) => (
        code: fortalCodeStyle(context),
        kbd: fortalKbdStyle(context),
        link: fortalLinkStyle(context, actionable: true),
      ),
    );

    expect(recipes.code, isA<BadgeStyler>());
    expect(recipes.kbd, isA<BadgeStyler>());
    expect(recipes.link, isA<LinkStyler>());
  });

  test('Fortal chart wrappers are constructible from the public API', () {
    final line = FortalLineChart(
      series: [
        LineSeries(
          id: 'revenue',
          label: 'Revenue',
          points: [ChartPoint(id: 'monday', x: 0, y: 18)],
        ),
      ],
    );
    final bar = FortalBarChart(
      groups: [
        BarGroup(
          id: 'q1',
          label: 'Q1',
          bars: [BarValue(id: 'actual', label: 'Actual', toY: 42)],
        ),
      ],
    );
    final pie = FortalPieChart(
      slices: [PieSlice(id: 'direct', label: 'Direct', value: 64)],
    );

    expect(line, isA<FortalLineChart>());
    expect(bar, isA<FortalBarChart>());
    expect(pie, isA<FortalPieChart>());
    expect(fortalLineChartStyle(), isA<LineChartStyler>());
    expect(fortalBarChartStyle(), isA<BarChartStyler>());
    expect(fortalPieChartStyle(), isA<PieChartStyler>());
  });
}
