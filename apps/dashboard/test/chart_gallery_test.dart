import 'package:dashboard/main.dart';
import 'package:dashboard/pages/charts_page.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:dashboard/widgets/analytics_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('charts destination presents every Fortal chart family', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const DashboardApp(initialSettings: ThemeSettings(appearance: .light)),
    );

    final destination = find.byKey(const ValueKey('nav-charts'));
    expect(destination, findsOneWidget);
    await tester.tap(destination);
    await tester.pump();

    expect(
      find.text(
        'Fortal-native chart patterns for comparison, composition, interaction, and empty states.',
      ),
      findsOneWidget,
    );
    expect(find.byType(FortalLineChart), findsNWidgets(4));
    expect(find.byType(FortalBarChart), findsNWidgets(4));
    expect(find.byType(PieChart), findsNWidgets(4));
    expect(find.byType(FortalPieChart), findsOneWidget);

    for (final title in const [
      'Revenue momentum',
      'Per-series patterns',
      'Steps and gaps',
      'Viewport labels',
      'Actual versus plan',
      'Revenue mix',
      'Floating changes',
      'Tracks and labels',
      'Traffic channels',
      'Interactive product mix',
      'Badge markers',
      'Safe empty state',
    ]) {
      expect(find.text(title), findsOneWidget, reason: title);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('gallery colors and comparison patterns follow Fortal', (
    tester,
  ) async {
    await tester.pumpWidget(
      const DashboardApp(
        initialSettings: ThemeSettings(appearance: .dark, accentColor: .orange),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('nav-charts')));
    await tester.pump();

    final page = find.byKey(const ValueKey('charts-page'));
    final context = tester.element(page);
    final palette = resolveFortalChartPalette(context);

    for (final chart in tester.widgetList<FortalLineChart>(
      find.byType(FortalLineChart),
    )) {
      expect(chart.palette, palette);
    }
    for (final chart in tester.widgetList<FortalBarChart>(
      find.byType(FortalBarChart),
    )) {
      expect(chart.palette, palette);
    }
    for (final chart in tester.widgetList<PieChart>(find.byType(PieChart))) {
      expect(chart.style.build(context).spec.palette, palette);
    }

    final quantitativeAxes = <ChartAxis>[
      for (final chart in tester.widgetList<FortalLineChart>(
        find.byType(FortalLineChart),
      ))
        ?chart.yAxis,
      for (final chart in tester.widgetList<FortalBarChart>(
        find.byType(FortalBarChart),
      ))
        ?chart.yAxis,
    ];
    for (final axis in quantitativeAxes) {
      final tickCount = (axis.max! - axis.min!) / axis.interval!;
      expect(tickCount, closeTo(tickCount.roundToDouble(), 0.0001));
    }

    final comparison = tester.widget<FortalLineChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is FortalLineChart &&
            widget.key == const ValueKey('charts-line-patterns'),
      ),
    );
    final planLine = comparison.series.last.style!.resolve(context).spec;
    expect(planLine.stroke!.spec.dashArray, [6, 4]);
    expect(planLine.marker!.spec.shape, ChartMarkerShape.square);

    final grouped = tester.widget<FortalBarChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is FortalBarChart &&
            widget.key == const ValueKey('charts-bar-grouped'),
      ),
    );
    final planBar = grouped.groups.first.bars.last.style!.resolve(context).spec;
    expect(planBar.borderDashArray, [4, 3]);
    expect(planBar.border!.color, palette[1]);

    final badgeChart = tester.widget<PieChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is PieChart &&
            widget.semanticsLabel == 'Device traffic with badge markers',
      ),
    );
    final badgeSpec = badgeChart.style.build(context).spec.slice!.spec;
    expect(badgeSpec.badgePosition, 0.72);
    expect(badgeSpec.radius, 48);
    expect(badgeChart.slices.every((slice) => slice.style == null), isTrue);

    expect(
      find.byKey(const ValueKey('legend-pattern-plan-dashed')),
      findsWidgets,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('overview donut has safe space and visible data legends', (
    tester,
  ) async {
    await tester.pumpWidget(const DashboardApp());

    final safeArea = find.byKey(
      const ValueKey('overview-channel-chart-safe-area'),
    );
    expect(safeArea, findsOneWidget);
    final padding = tester.widget<Padding>(safeArea).padding as EdgeInsets;
    expect(padding.vertical, greaterThanOrEqualTo(16));

    final donut = tester.widget<PieChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is PieChart &&
            widget.semanticsLabel == 'Revenue contribution by channel',
      ),
    );
    final donutContext = tester.element(safeArea);
    final donutSpec = donut.style.build(donutContext).spec;
    expect(donut.slices.every((slice) => slice.style == null), isTrue);
    expect(donutSpec.slice!.spec.radius, 36);
    expect(
      donutSpec.centerRadius! + donutSpec.slice!.spec.radius!,
      lessThanOrEqualTo(80),
    );

    expect(find.byKey(const ValueKey('overview-order-legend')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('overview-channel-legend')),
      findsOneWidget,
    );
    for (final label in const [
      'Actual',
      'Plan',
      'Direct 46%',
      'Partners 31%',
      'Marketplace 23%',
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('traffic pie keeps names in its clean legend', (tester) async {
    await _pumpCompactCharts(tester);

    final traffic = tester.widget<PieChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is PieChart &&
            widget.semanticsLabel == 'Traffic share by device',
      ),
    );
    final trafficContext = tester.element(
      find.byWidgetPredicate(
        (widget) =>
            widget is PieChart &&
            widget.semanticsLabel == 'Traffic share by device',
      ),
    );
    final trafficSpec = traffic.style.build(trafficContext).spec;
    expect(trafficSpec.slice!.spec.showLabel, isFalse);
    expect(trafficSpec.slice!.spec.radius, 72);
    expect(traffic.slices.every((slice) => slice.style == null), isTrue);

    expect(tester.takeException(), isNull);
  });

  testWidgets('selected gallery donut preserves visual clearance', (
    tester,
  ) async {
    await _pumpCompactCharts(tester);

    final interactiveFinder = find.byWidgetPredicate(
      (widget) => widget is PieChart && widget.semanticsLabel == 'Product mix',
    );
    final interactive = tester.widget<PieChart>(interactiveFinder);
    final availableRadius = tester.getSize(interactiveFinder).shortestSide / 2;
    final chartContext = tester.element(interactiveFinder);
    final chartSpec = interactive.style.build(chartContext).spec;

    const visualClearance = 4.0;
    expect(interactive.selectedSliceIds, isNotEmpty);
    expect(
      chartSpec.centerRadius! +
          chartSpec.slice!.spec.radius! +
          chartSpec.selectedSliceRadiusOffset! +
          visualClearance,
      lessThanOrEqualTo(availableRadius),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('compact pie legends use the available horizontal space', (
    tester,
  ) async {
    await _pumpCompactCharts(tester);

    final coreCenter = tester.getCenter(find.text('Core 54%'));
    final teamsCenter = tester.getCenter(find.text('Teams 27%'));
    final enterpriseCenter = tester.getCenter(find.text('Enterprise 19%'));

    expect(teamsCenter.dy, closeTo(coreCenter.dy, 0.5));
    expect(enterpriseCenter.dy - coreCenter.dy, lessThanOrEqualTo(24.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('floating bars preserve gains and genuine declines', (
    tester,
  ) async {
    await _pumpCompactCharts(tester);

    final chart = tester.widget<FortalBarChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is FortalBarChart &&
            widget.semanticsLabel == 'Monthly floating inventory changes',
      ),
    );
    final ranges = [
      for (final group in chart.groups)
        (group.bars.single.fromY, group.bars.single.toY),
    ];

    expect(ranges, const [
      (12.0, 18.0),
      (18.0, 14.0),
      (14.0, 22.0),
      (22.0, 17.0),
      (17.0, 25.0),
      (25.0, 31.0),
    ]);
    expect(ranges.where((range) => range.$2 < range.$1), hasLength(2));
  });

  testWidgets('compact viewport badges do not overlap adjacent labels', (
    tester,
  ) async {
    await _pumpCompactCharts(tester);

    final viewportChart = find.byWidgetPredicate(
      (widget) =>
          widget is FortalLineChart &&
          widget.semanticsLabel ==
              'Revenue chart with scalable horizontal viewport',
    );
    final badges = find.descendant(
      of: viewportChart,
      matching: find.byType(FortalBadge),
    );
    expect(badges, findsWidgets);
    for (final badge in tester.widgetList<FortalBadge>(badges)) {
      expect(badge.size, FortalBadgeSize.size1);
    }

    final rects = [
      for (final element in badges.evaluate())
        tester.getRect(find.byWidget(element.widget)),
    ]..sort((left, right) => left.left.compareTo(right.left));
    for (var index = 1; index < rects.length; index++) {
      expect(
        rects[index - 1].overlaps(rects[index]),
        isFalse,
        reason: '${rects[index - 1]} overlaps ${rects[index]}',
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('overview charts use a three two one responsive grid', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    Future<List<Offset>> pumpAt(double width) async {
      await tester.pumpWidget(
        FortalScope(
          child: MaterialApp(
            home: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(width: width, child: const AnalyticsCharts()),
            ),
          ),
        ),
      );
      expect(find.byKey(const ValueKey('overview-chart-grid')), findsOneWidget);
      return [
        tester.getCenter(find.text('Revenue trend')),
        tester.getCenter(find.text('Order volume')),
        tester.getCenter(find.text('Channel mix')),
      ];
    }

    final wide = await pumpAt(1200);
    expect(wide[1].dy, closeTo(wide[0].dy, 0.5));
    expect(wide[2].dy, closeTo(wide[0].dy, 0.5));

    final medium = await pumpAt(1000);
    expect(medium[1].dy, closeTo(medium[0].dy, 0.5));
    expect(medium[2].dy, greaterThan(medium[0].dy));

    final compact = await pumpAt(700);
    expect(compact[1].dy, greaterThan(compact[0].dy));
    expect(compact[2].dy, greaterThan(compact[1].dy));
    expect(tester.takeException(), isNull);
  });

  testWidgets('charts gallery two-column rows share height', (tester) async {
    tester.view.physicalSize = const Size(1200, 3600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const FortalScope(child: MaterialApp(home: ChartsPage())),
    );

    Rect card(String title) => tester.getRect(
      find
          .ancestor(of: find.text(title), matching: find.byType(FortalCard))
          .first,
    );

    final momentum = card('Revenue momentum');
    final patterns = card('Per-series patterns');
    expect(patterns.top, closeTo(momentum.top, 0.5));
    expect(patterns.height, closeTo(momentum.height, 0.5));
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpCompactCharts(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const DashboardApp());
  await tester.tap(find.byKey(const ValueKey('dashboard-menu')).first);
  for (var frame = 0; frame < 5; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.tap(find.byKey(const ValueKey('nav-charts')).first);
  for (var frame = 0; frame < 5; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
