import 'package:demo/helpers/catalog.dart';
import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Checkbox Component', type: RemixCheckbox)
Widget buildCheckboxUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalCheckbox(
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          selected: context.knobs.boolean(label: 'Checked', initialValue: true),
          onChanged: (value) => knobState.updateKnob('Checked', value),
          semanticLabel: context.knobs.string(
            label: 'Label',
            initialValue: 'Label',
          ),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalCheckboxVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalCheckboxSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalCheckboxSize.size2,
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixCheckbox)
Widget buildCheckboxCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalCheckboxSize.values),
    rows: labelsOf(FortalCheckboxVariant.values),
    cell: (row, column) => FortalCheckbox(
      selected: true,
      size: FortalCheckboxSize.values[column],
      variant: FortalCheckboxVariant.values[row],
    ),
  );
}
