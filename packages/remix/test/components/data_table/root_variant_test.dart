import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('root context updates preserve nested selected typography', (
    tester,
  ) async {
    final brightness = ValueNotifier(Brightness.light);
    addTearDown(brightness.dispose);
    final style = DataTableStyler()
        .cellText(TextStyler().fontSize(12))
        .onDark(
          DataTableStyler().cellText(
            TextStyler()
                .fontSize(24)
                .onSelected(TextStyler().fontWeight(FontWeight.w700)),
          ),
        );
    await tester.pumpWidget(
      MaterialApp(
        home: ValueListenableBuilder<Brightness>(
          valueListenable: brightness,
          builder: (_, value, _) => MediaQuery(
            data: MediaQueryData(platformBrightness: value),
            child: Scaffold(
              body: RemixDataTable<String>(
                rows: const ['Ada', 'Blaise'],
                columns: [
                  RemixDataTableColumn<String>(
                    id: 'name',
                    label: 'Name',
                    cellBuilder: (_, row) => Text(row),
                  ),
                ],
                rowId: (row) => row,
                selectedRowIds: const {'Ada'},
                onSelectionChanged: (_) {},
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
    TextStyle? rendered(String label) => tester
        .widget<RichText>(
          find.descendant(
            of: find.text(label),
            matching: find.byType(RichText),
          ),
        )
        .text
        .style;
    expect(rendered('Ada')?.fontSize, 12);
    brightness.value = Brightness.dark;
    await tester.pump();
    expect(rendered('Ada')?.fontSize, 24);
    expect(rendered('Blaise')?.fontSize, 24);
    expect(rendered('Ada')?.fontWeight, FontWeight.w700);
    expect(rendered('Blaise')?.fontWeight, isNot(FontWeight.w700));
    brightness.value = Brightness.light;
    await tester.pump();
    expect(rendered('Ada')?.fontSize, 12);
    expect(rendered('Ada')?.fontWeight, isNot(FontWeight.w700));
  });

  for (final dark in [false, true]) {
    for (final raw in [false, true]) {
      testWidgets('root variants dark=$dark raw=$raw', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: (_, child) => MediaQuery(
              data: MediaQueryData(
                platformBrightness: dark ? Brightness.dark : Brightness.light,
              ),
              child: child!,
            ),
            home: Scaffold(
              body: RemixDataTable<String>(
                rows: const ['Ada'],
                columns: [
                  RemixDataTableColumn<String>(
                    id: 'name',
                    label: 'Name',
                    cellBuilder: (_, row) => Text(row),
                  ),
                ],
                style: DataTableStyler()
                    .cellText(TextStyler().fontSize(12))
                    .onDark(
                      DataTableStyler().cellText(TextStyler().fontSize(24)),
                    ),
                styleSpec: raw
                    ? const DataTableSpec(
                        cellText: StyleSpec(
                          spec: TextSpec(style: TextStyle(fontSize: 19)),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        );
        final text = tester.widget<RichText>(
          find.descendant(
            of: find.text('Ada'),
            matching: find.byType(RichText),
          ),
        );
        expect(
          text.text.style?.fontSize,
          raw
              ? 19
              : dark
              ? 24
              : 12,
        );
      });
    }
  }

  testWidgets('root dark variant reaches rendered cell text', (tester) async {
    final style = DataTableStyler()
        .cellText(TextStyler().fontSize(12))
        .onDark(DataTableStyler().cellText(TextStyler().fontSize(24)));
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        builder: (_, child) => MediaQuery(
          data: const MediaQueryData(platformBrightness: Brightness.dark),
          child: child!,
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              expect(
                style.build(context).spec.cellText.spec.style?.fontSize,
                24,
              );
              return RemixDataTable<String>(
                rows: const ['Ada'],
                columns: [
                  RemixDataTableColumn<String>(
                    id: 'name',
                    label: 'Name',
                    cellBuilder: (_, row) => Text(row),
                  ),
                ],
                style: style,
              );
            },
          ),
        ),
      ),
    );
    final text = tester.widget<RichText>(
      find.descendant(of: find.text('Ada'), matching: find.byType(RichText)),
    );
    expect(text.text.style?.fontSize, 24);
  });
}
