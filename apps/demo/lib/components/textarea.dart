import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalTextArea)
Widget buildTextAreaCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 240,
    columns: labelsOf(FortalTextAreaSize.values),
    rows: labelsOf(FortalTextAreaVariant.values),
    cell: (row, column) => SizedBox(
      width: 200,
      child: FortalTextArea(
        hintText: 'Text area',
        size: FortalTextAreaSize.values[column],
        variant: FortalTextAreaVariant.values[row],
      ),
    ),
  );
}
