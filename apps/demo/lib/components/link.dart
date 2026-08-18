import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalLink)
Widget buildLinkCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: labelsOf(FortalLinkUnderline.values),
    cell: (row, column) => FortalLink(
      'Link',
      onPressed: () {},
      size: FortalTextSize.values[column],
      underline: FortalLinkUnderline.values[row],
    ),
  );
}
