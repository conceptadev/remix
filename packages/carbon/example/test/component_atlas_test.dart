import 'package:carbon_example/component_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_atlas/golden.dart';
import 'package:mix_atlas/mix_atlas.dart';

void main() {
  test('catalog covers Carbon button variants and themes', () {
    carbonAtlasCatalog.validate();

    final atlas = carbonAtlasCatalog.atlases.first;
    final iconAtlas = carbonAtlasCatalog.atlases.last;
    final metadata = atlasCatalogMetadata(carbonAtlasCatalog);

    expect(carbonAtlasCatalog.themes, hasLength(4));
    expect(carbonAtlasCatalog.atlases, hasLength(2));
    expect(atlas.rows, hasLength(35));
    expect(atlas.scenarios, hasLength(6));
    expect(iconAtlas.id, 'button-icons');
    expect(iconAtlas.rows, hasLength(14));
    expect(iconAtlas.scenarios, hasLength(6));
    expect(metadata['schema'], 'mix_atlas/catalog/v1');
  });

  testWidgets('live viewer renders the Carbon catalog', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(home: AtlasCatalogViewer(catalog: carbonAtlasCatalog)),
    );

    expect(find.text('Carbon for Flutter'), findsOneWidget);
    expect(find.text('Kind / Size'), findsOneWidget);
    expect(find.text('210 cells'), findsOneWidget);
    expect(find.text('White'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('icon button atlas renders every cell with an icon', (
    tester,
  ) async {
    final atlas = carbonAtlasCatalog.atlases.last;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => carbonAtlasCatalog.themes.first.builder(
            context,
            SingleChildScrollView(child: AtlasView(atlas: atlas)),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.add), findsNWidgets(84));
    expect(tester.takeException(), isNull);
  });

  testWidgets('button atlas - white', (tester) async {
    await expectAtlasGolden(
      tester,
      atlas: carbonAtlasCatalog.atlases.first,
      theme: carbonAtlasCatalog.themes.first,
    );
  });

  testWidgets('button icon atlas - white', (tester) async {
    await expectAtlasGolden(
      tester,
      atlas: carbonAtlasCatalog.atlases.last,
      theme: carbonAtlasCatalog.themes.first,
    );
  });

  testWidgets('button icon atlas - gray 100', (tester) async {
    await expectAtlasGolden(
      tester,
      atlas: carbonAtlasCatalog.atlases.last,
      theme: carbonAtlasCatalog.themes.last,
    );
  });
}
