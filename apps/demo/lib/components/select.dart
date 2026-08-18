import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Select Component', type: RemixSelect)
Widget buildSelectUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'variant',
    options: FortalSelectVariant.values,
    labelBuilder: (variant) => variant.name,
  );
  final size = context.knobs.object.dropdown(
    label: 'size',
    options: FortalSelectSize.values,
    labelBuilder: (size) => size.name,
    initialOption: FortalSelectSize.size2,
  );

  String selectedValue = 'Apple';
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: StatefulBuilder(
          builder: (context, setState) {
            return FortalSelect(
              variant: variant,
              size: size,
              trigger: RemixSelectTrigger(
                placeholder: context.knobs.string(
                  label: 'Placeholder',
                  initialValue: 'Select item...',
                ),
              ),
              selectedValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value ?? 'Apple';
                });
              },
              items: [
                RemixSelectItem(value: 'Apple', label: 'Apple'),
                RemixSelectItem(value: 'Banana', label: 'Banana'),
                RemixSelectItem(value: 'Orange', label: 'Orange'),
              ],
            );
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixSelect)
Widget buildSelectCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 220,
    columns: labelsOf(FortalSelectSize.values),
    rows: labelsOf(FortalSelectVariant.values),
    // The closed trigger is the part the size and variant enums paint; the
    // popup surface only exists once a cell is tapped.
    cell: (row, column) => FortalSelect<String>(
      trigger: const RemixSelectTrigger(placeholder: 'Select...'),
      items: [RemixSelectItem(value: 'apple', label: 'Apple')],
      selectedValue: 'apple',
      size: FortalSelectSize.values[column],
      variant: FortalSelectVariant.values[row],
    ),
  );
}
