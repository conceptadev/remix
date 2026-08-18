import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: RemixDataTable)
Widget buildDataTableCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 300,
    columns: labelsOf(FortalDataTableSize.values),
    rows: labelsOf(FortalDataTableVariant.values),
    cell: (row, column) => SizedBox(
      width: 280,
      child: FortalDataTable<String>(
        rows: const ['Ada', 'Grace'],
        columns: [
          RemixDataTableColumn<String>(
            id: 'name',
            label: 'Name',
            cellBuilder: (context, name) => FortalText(name),
          ),
        ],
        size: FortalDataTableSize.values[column],
        variant: FortalDataTableVariant.values[row],
      ),
    ),
  );
}
