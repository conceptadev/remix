import 'package:dashboard/main.dart';
import 'package:dashboard/theme/theme_settings.dart';
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
    expect(find.byType(FortalPieChart), findsNWidgets(4));

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
    for (final chart in tester.widgetList<FortalPieChart>(
      find.byType(FortalPieChart),
    )) {
      expect(chart.palette, palette);
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

    final badgeChart = tester
        .widgetList<FortalPieChart>(find.byType(FortalPieChart))
        .singleWhere(
          (chart) =>
              chart.slices.isNotEmpty &&
              chart.slices.every((slice) => slice.badge != null),
        );
    for (final slice in badgeChart.slices) {
      final badgeSpec = slice.style!.resolve(context).spec;
      final badgePosition = badgeSpec.badgePosition;
      expect(badgePosition, lessThanOrEqualTo(0.75));
      expect(badgeSpec.radius, isNotNull);
      expect(badgeSpec.radius!, lessThanOrEqualTo(48));
    }

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

    final donut = tester.widget<FortalPieChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is FortalPieChart &&
            widget.semanticsLabel == 'Revenue contribution by channel',
      ),
    );
    expect(donut.slices.every((slice) => slice.style != null), isTrue);
    final donutContext = tester.element(safeArea);
    for (final slice in donut.slices) {
      final radius = slice.style!.resolve(donutContext).spec.radius;
      expect(radius, isNotNull);
      expect(donut.centerRadius + radius!, lessThanOrEqualTo(80));
    }

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

    final traffic = tester.widget<FortalPieChart>(
      find.byWidgetPredicate(
        (widget) =>
            widget is FortalPieChart &&
            widget.semanticsLabel == 'Traffic share by device',
      ),
    );
    expect(traffic.showLabels, isFalse);

    expect(tester.takeException(), isNull);
  });

  testWidgets('selected gallery donut preserves visual clearance', (
    tester,
  ) async {
    await _pumpCompactCharts(tester);

    final interactiveFinder = find.byWidgetPredicate(
      (widget) =>
          widget is FortalPieChart && widget.semanticsLabel == 'Product mix',
    );
    final interactive = tester.widget<FortalPieChart>(interactiveFinder);
    final availableRadius = tester.getSize(interactiveFinder).shortestSide / 2;
    final chartContext = tester.element(interactiveFinder);

    const selectedSliceExpansion = 8.0;
    const visualClearance = 4.0;
    for (final slice in interactive.slices.where(
      (slice) => interactive.selectedSliceIds.contains(slice.id),
    )) {
      final radius = slice.style!.resolve(chartContext).spec.radius;
      expect(radius, isNotNull);
      expect(
        interactive.centerRadius +
            radius! +
            selectedSliceExpansion +
            visualClearance,
        lessThanOrEqualTo(availableRadius),
      );
    }

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
