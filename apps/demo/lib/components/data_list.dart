import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: RemixDataList)
Widget buildDataListCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 240,
    columns: labelsOf(FortalDataListSize.values),
    rows: noRowAxis,
    cell: (row, column) => FortalDataList(
      items: const [
        RemixDataListItem(label: 'Status', value: 'Active'),
        RemixDataListItem(label: 'Owner', value: 'Ada'),
      ],
      size: FortalDataListSize.values[column],
    ),
  );
}
