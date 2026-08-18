import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Catalog', type: RemixSegmentedControl)
Widget buildSegmentedControlCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 260,
    columns: labelsOf(FortalSegmentedControlSize.values),
    rows: labelsOf(FortalSegmentedControlVariant.values),
    cell: (row, column) => FortalSegmentedControl<String>(
      items: const [
        RemixSegmentedControlItem(value: 'day', label: 'Day'),
        RemixSegmentedControlItem(value: 'week', label: 'Week'),
      ],
      selectedValue: 'day',
      size: FortalSegmentedControlSize.values[column],
      variant: FortalSegmentedControlVariant.values[row],
    ),
  );
}
