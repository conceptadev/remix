import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalHeading)
Widget buildHeadingCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: labelsOf(FortalTextWeight.values),
    cell: (row, column) => FortalHeading(
      'Heading',
      size: FortalTextSize.values[column],
      weight: FortalTextWeight.values[row],
    ),
  );
}
