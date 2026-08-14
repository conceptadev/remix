import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonDataTable maps Carbon sorting and table semantics', (
    tester,
  ) async {
    CarbonDataTableSort? sort;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      SizedBox(
        width: 500,
        child: CarbonDataTable<String>(
          semanticLabel: 'People',
          rows: const ['Ada', 'Grace'],
          columns: [
            CarbonDataTableColumn<String>(
              id: 'name',
              label: 'Name',
              sortable: true,
              cellBuilder: (context, row) => Text(row),
            ),
          ],
          onSortChanged: (next) => sort = next,
        ),
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('People')).role,
      SemanticsRole.table,
    );
    await tester.tap(find.bySemanticsLabel('Name'));
    expect(sort?.columnId, 'name');
    expect(sort?.direction, CarbonDataTableSortDirection.ascending);
    semantics.dispose();
  });

  testWidgets('CarbonDataTable emits immutable selection', (tester) async {
    Set<Object>? selection;
    await tester.pumpCarbonApp(
      SizedBox(
        width: 500,
        child: CarbonDataTable<String>(
          rows: const ['Ada'],
          columns: [
            CarbonDataTableColumn<String>(
              id: 'name',
              label: 'Name',
              cellBuilder: (context, row) => Text(row),
            ),
          ],
          rowIdBuilder: (row) => row,
          onSelectionChanged: (next) => selection = next,
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Select row'));
    expect(selection, {'Ada'});
    expect(() => selection!.add('Grace'), throwsUnsupportedError);
  });
}
