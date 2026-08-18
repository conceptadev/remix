import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalKbd)
Widget buildKbdCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: labelsOf(FortalKbdVariant.values),
    cell: (row, column) => FortalKbd(
      'Shift',
      size: FortalTextSize.values[column],
      variant: FortalKbdVariant.values[row],
    ),
  );
}
