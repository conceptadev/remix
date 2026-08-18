import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalCode)
Widget buildCodeCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: labelsOf(FortalCodeVariant.values),
    cell: (row, column) => FortalCode(
      'code()',
      size: FortalTextSize.values[column],
      variant: FortalCodeVariant.values[row],
    ),
  );
}
