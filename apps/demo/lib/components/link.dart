import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalLink)
Widget buildLinkCatalogUseCase(BuildContext context) {
  final rowValues = [
    for (final underline in FortalLinkUnderline.values)
      for (final weight in FortalTextWeight.values)
        (underline: underline, weight: weight),
  ];
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: [
      for (final value in rowValues)
        '${value.underline.name} / ${value.weight.name}',
    ],
    cell: (row, column) => FortalLink(
      'Link',
      onPressed: () {},
      size: FortalTextSize.values[column],
      underline: rowValues[row].underline,
      weight: rowValues[row].weight,
    ),
  );
}
