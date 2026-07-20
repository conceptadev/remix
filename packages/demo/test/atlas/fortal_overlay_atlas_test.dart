import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_atlas/mix_atlas.dart';
import 'package:remix/remix.dart';

import 'support/fortal_atlas_catalog.dart';

void main() {
  for (final testCase in const [
    (atlasId: 'menu', content: 'Actions'),
    (atlasId: 'popover', content: 'Popover content'),
    (atlasId: 'select', content: 'Option two'),
    (atlasId: 'tooltip', content: 'Helpful context'),
  ]) {
    testWidgets(
      '${testCase.atlasId} captures open content inside each overlay cell',
      (tester) async {
        final atlas = fortalAtlasCatalog.atlases.firstWhere(
          (atlas) => atlas.id == testCase.atlasId,
        );

        await _pumpAtlas(tester, atlas);

        final content = find.text(testCase.content);
        expect(content, findsNWidgets(_expectedOpenCellCount(atlas)));
        for (var index = 0; index < content.evaluate().length; index += 1) {
          final item = content.at(index);
          final host = find.ancestor(
            of: item,
            matching: find.byType(AtlasOverlayHost),
          );
          expect(host, findsOneWidget);

          final itemRect = tester.getRect(item);
          final hostRect = tester.getRect(host);
          expect(
            hostRect.contains(itemRect.topLeft) &&
                hostRect.contains(itemRect.bottomRight),
            isTrue,
            reason: '${testCase.atlasId} overlay content escaped its cell',
          );
        }
      },
    );
  }

  testWidgets('spinner captures a stable reduced-motion frame', (tester) async {
    final atlas = fortalAtlasCatalog.atlases.firstWhere(
      (atlas) => atlas.id == 'spinner',
    );

    await _pumpAtlas(tester, atlas);

    Iterable<RemixSpinnerPainter> painters() => tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((paint) => paint.painter)
        .whereType<RemixSpinnerPainter>();

    expect(painters(), isNotEmpty);
    expect(painters().every((painter) => painter.animation.value == 0), isTrue);

    await tester.pump(const Duration(milliseconds: 333));
    expect(painters().every((painter) => painter.animation.value == 0), isTrue);
  });
}

int _expectedOpenCellCount(ComponentAtlas atlas) {
  final openScenarios = atlas.scenarios
      .where(
        (scenario) => switch (atlas.id) {
          'select' => !scenario.states.contains(WidgetState.disabled),
          'tooltip' => scenario.props['open'] == true,
          _ => true,
        },
      )
      .length;

  return atlas.rows.length * openScenarios;
}

Future<void> _pumpAtlas(WidgetTester tester, ComponentAtlas atlas) async {
  tester.view
    ..devicePixelRatio = 1
    ..physicalSize = const Size(1600, 1600);
  addTearDown(tester.view.reset);

  final theme = fortalAtlasCatalog.themes.first;
  await tester.pumpWidget(
    MaterialApp(
      home: SingleChildScrollView(
        child: Builder(
          builder: (context) => theme.builder(
            context,
            Material(
              color: theme.background,
              child: AtlasView(atlas: atlas),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
}
