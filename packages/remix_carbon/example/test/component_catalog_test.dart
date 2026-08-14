import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_carbon/remix_carbon.dart';
import 'package:remix_carbon_example/catalog_app.dart';
import 'package:remix_carbon_example/component_catalog.dart';

void main() {
  test('catalog covers every pinned Carbon family exactly once', () {
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
    final actualIds = carbonComponentCatalog.map((demo) => demo.id).toList()
      ..sort();

    expect(actualIds, expectedIds);
    expect(actualIds, hasLength(44));
    expect(actualIds.toSet(), hasLength(actualIds.length));
    expect(
      carbonComponentCatalog,
      everyElement(
        isA<ComponentDemo>()
            .having((demo) => demo.examples, 'examples', isNotEmpty)
            .having((demo) => demo.summary, 'summary', isNotEmpty),
      ),
    );
  });

  for (final component in carbonComponentCatalog) {
    testWidgets('${component.id} examples render without exceptions', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1600, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: CarbonScope(
            child: CatalogEventScope(
              onEvent: (_) {},
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: 1200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final example in component.examples)
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Builder(builder: example.builder),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('catalog supports search, selection, and live interaction', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CarbonCatalogApp());
    await tester.pump();

    expect(find.text('Remix Carbon'), findsOneWidget);
    expect(find.text('44 components'), findsOneWidget);
    expect(find.text('Button'), findsWidgets);

    await tester.enterText(find.byType(EditableText).first, 'Toggle');
    await tester.pump();
    expect(find.byKey(const Key('component-toggle')), findsOneWidget);

    await tester.tap(find.byKey(const Key('component-toggle')));
    await tester.pump();
    expect(find.text('Notifications'), findsOneWidget);

    await tester.tap(find.text('Notifications'));
    await tester.pump();
    expect(find.text('Notifications disabled'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('catalog navigation becomes a drawer on narrow screens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 860);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CarbonCatalogApp());
    await tester.pump();

    expect(find.byKey(const Key('open-navigation')), findsOneWidget);
    expect(find.byKey(const Key('component-accordion')), findsNothing);

    await tester.tap(find.byKey(const Key('open-navigation')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const Key('component-accordion')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('catalog search stays synchronized across breakpoints', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 860);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CarbonCatalogApp());
    await tester.pump();
    await tester.enterText(find.byType(EditableText).first, 'Accordion');
    await tester.pump();

    tester.view.physicalSize = const Size(430, 860);
    await tester.pump();
    await tester.tap(find.byKey(const Key('open-navigation')));
    await tester.pump(const Duration(milliseconds: 300));

    final searchField = tester.widget<EditableText>(
      find.byType(EditableText).first,
    );
    expect(searchField.controller.text, 'Accordion');
    expect(find.byKey(const Key('component-accordion')), findsOneWidget);
    expect(find.byKey(const Key('component-button')), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
