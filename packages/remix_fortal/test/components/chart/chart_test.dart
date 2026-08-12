import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_chart/mix_chart.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  group('Fortal chart recipes', () {
    testWidgets('resolve the active Fortal theme and contextual palette', (
      tester,
    ) async {
      late StyleSpec<LineChartSpec> resolved;
      late List<Color> publicPalette;

      await tester.pumpWidget(
        FortalScope(
          accent: .orange,
          brightness: .dark,
          child: Builder(
            builder: (context) {
              publicPalette = resolveFortalChartPalette(context);
              resolved = fortalLineChartStyle().build(context);
              return const SizedBox();
            },
          ),
        ),
      );

      final colors = resolveFortalTokens(
        const FortalThemeConfig(accent: .orange, brightness: .dark),
      );
      final spec = resolved.spec;

      expect(spec.palette, publicPalette);
      expect(spec.palette!.first, colors.accent.scale.step(9));
      expect(spec.palette, hasLength(greaterThanOrEqualTo(7)));
      expect(spec.palette!.toSet(), hasLength(spec.palette!.length));
      expect(
        spec.grid!.spec.stroke!.spec.color,
        colors.gray.scale.alphaStep(5),
      );
      expect(spec.tooltip!.spec.backgroundColor, colors.colorPanelTranslucent);
    });

    testWidgets('high contrast uses the Fortal step-12 palette', (
      tester,
    ) async {
      late StyleSpec<PieChartSpec> resolved;

      await tester.pumpWidget(
        FortalScope(
          accent: .indigo,
          child: Builder(
            builder: (context) {
              resolved = fortalPieChartStyle(highContrast: true).build(context);
              return const SizedBox();
            },
          ),
        ),
      );

      final colors = resolveFortalTokens(
        const FortalThemeConfig(accent: .indigo),
      );
      expect(resolved.spec.palette!.first, colors.accent.scale.step(12));
    });

    testWidgets('caller palette overrides the contextual default', (
      tester,
    ) async {
      const palette = [Color(0xFF112233), Color(0xFF445566)];
      late StyleSpec<BarChartSpec> resolved;

      await tester.pumpWidget(
        FortalScope(
          child: Builder(
            builder: (context) {
              resolved = fortalBarChartStyle(palette: palette).build(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolved.spec.palette, palette);
    });

    testWidgets('pie selection expansion follows Fortal spacing', (
      tester,
    ) async {
      late StyleSpec<PieChartSpec> resolved;
      late double expectedOffset;

      await tester.pumpWidget(
        FortalScope(
          child: Builder(
            builder: (context) {
              expectedOffset = MixScope.tokenOf(FortalTokens.space2, context);
              resolved = fortalPieChartStyle().build(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolved.spec.selectedSliceRadiusOffset, expectedOffset);
    });
  });

  group('Fortal chart widgets', () {
    test('forward recipe and chart constructor parameters', () {
      final line = FortalLineChart(
        highContrast: true,
        showMarkers: true,
        semanticsLabel: 'Revenue',
        series: [_lineSeries()],
      );
      final bar = FortalBarChart(
        highContrast: true,
        semanticsLabel: 'Orders',
        groups: [_barGroup()],
      );
      final pie = FortalPieChart(
        centerRadius: 40,
        showLabels: true,
        semanticsLabel: 'Channels',
        slices: [_pieSlice()],
      );

      expect(line.highContrast, isTrue);
      expect(line.showMarkers, isTrue);
      expect(line.semanticsLabel, 'Revenue');
      expect(bar.highContrast, isTrue);
      expect(bar.semanticsLabel, 'Orders');
      expect(pie.centerRadius, 40);
      expect(pie.showLabels, isTrue);
      expect(pie.semanticsLabel, 'Channels');
    });

    testWidgets('render through the mix_chart widgets', (tester) async {
      await tester.pumpWidget(
        FortalScope(
          child: MaterialApp(
            home: Column(
              children: [
                SizedBox(
                  width: 360,
                  height: 180,
                  child: FortalLineChart(series: [_lineSeries()]),
                ),
                SizedBox(
                  width: 360,
                  height: 180,
                  child: FortalBarChart(groups: [_barGroup()]),
                ),
                SizedBox(
                  width: 360,
                  height: 180,
                  child: FortalPieChart(slices: [_pieSlice()]),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(FortalLineChart), findsOneWidget);
      expect(find.byType(FortalBarChart), findsOneWidget);
      expect(find.byType(FortalPieChart), findsOneWidget);
      expect(find.byType(LineChart), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
      expect(find.byType(PieChart), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('package boundary', () {
    test('Fortal does not import the private chart renderer', () {
      final sources = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));

      for (final source in sources) {
        expect(
          source.readAsStringSync(),
          isNot(contains('package:fl_chart')),
          reason: '${source.path} crosses the mix_chart renderer boundary',
        );
      }
    });

    test('mix_chart belongs to Fortal rather than core Remix', () {
      final fortalPubspec = File('pubspec.yaml').readAsStringSync();
      final remixPubspec = File('../remix/pubspec.yaml').readAsStringSync();

      expect(
        fortalPubspec,
        contains(RegExp(r'^name: remix_fortal$', multiLine: true)),
      );
      expect(
        fortalPubspec,
        contains(RegExp(r'^  mix_chart:', multiLine: true)),
      );
      expect(remixPubspec, isNot(contains('mix_chart:')));
    });
  });
}

LineSeries _lineSeries() => LineSeries(
  id: 'revenue',
  label: 'Revenue',
  points: [
    ChartPoint(id: 'monday', x: 0, y: 18),
    ChartPoint(id: 'tuesday', x: 1, y: 31),
  ],
);

BarGroup _barGroup() => BarGroup(
  id: 'q1',
  label: 'Q1',
  bars: [BarValue(id: 'actual', label: 'Actual', toY: 42)],
);

PieSlice _pieSlice() => PieSlice(id: 'mobile', label: 'Mobile', value: 64);
