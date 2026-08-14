import 'dart:convert';
import 'dart:io';

import 'package:carbon_example/component_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_atlas/golden.dart';
import 'package:mix_atlas/mix_atlas.dart';

void main() {
  test('catalog covers every pinned Carbon family', () {
    carbonAtlasCatalog.validate();

    final manifest =
        jsonDecode(
              File(
                '../reference/carbon_1_114_0/manifest.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    final manifestFamilies = <dynamic>[
      ...manifest['coreFamilies'] as List<dynamic>,
      ...manifest['extensions'] as List<dynamic>,
    ];
    final expectedIds =
        manifestFamilies
            .map(
              (family) => (family as Map<String, dynamic>)['id']
                  .toString()
                  .replaceAll('_', '-'),
            )
            .toList()
          ..sort();
    final actualIds =
        carbonAtlasCatalog.atlases.map((atlas) => atlas.id).toList()..sort();
    final buttonAtlas = carbonAtlasCatalog.atlases.firstWhere(
      (atlas) => atlas.id == 'button',
    );
    final metadata = atlasCatalogMetadata(carbonAtlasCatalog);

    expect(carbonAtlasCatalog.themes, hasLength(4));
    expect(actualIds, expectedIds);
    expect(actualIds, hasLength(44));
    expect(buttonAtlas.rows, hasLength(40));
    expect(buttonAtlas.scenarios, hasLength(6));
    expect(metadata['schema'], 'mix_atlas/catalog/v1');
  });

  testWidgets('live viewer renders the complete Carbon catalog', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(home: AtlasCatalogViewer(catalog: carbonAtlasCatalog)),
    );

    expect(find.text('Carbon for Flutter'), findsOneWidget);
    expect(find.text('Accordion'), findsWidgets);
    expect(find.text('W'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final atlas in carbonAtlasCatalog.atlases) {
    testWidgets('${atlas.id} atlas renders without exceptions', (tester) async {
      tester.view.physicalSize = const Size(1600, 1200);
      addTearDown(tester.view.reset);

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

      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('button atlas - white', (tester) async {
    await expectAtlasGolden(
      tester,
      atlas: carbonAtlasCatalog.atlases.firstWhere(
        (atlas) => atlas.id == 'button',
      ),
      theme: carbonAtlasCatalog.themes.first,
    );
  });
}
