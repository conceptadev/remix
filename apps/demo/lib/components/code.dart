import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: FortalCode)
Widget buildCodeCatalogUseCase(BuildContext context) {
  final rowValues = [
    for (final variant in FortalCodeVariant.values)
      for (final weight in FortalTextWeight.values)
        (variant: variant, weight: weight),
  ];
  return CatalogMatrix(
    columns: labelsOf(FortalTextSize.values),
    rows: [
      for (final value in rowValues)
        '${value.variant.name} / ${value.weight.name}',
    ],
    cell: (row, column) => FortalCode(
      'code()',
      size: FortalTextSize.values[column],
      variant: rowValues[row].variant,
      weight: rowValues[row].weight,
    ),
  );
}
