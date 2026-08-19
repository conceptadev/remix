import 'package:demo/helpers/catalog.dart';
import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Switch Component', type: RemixSwitch)
Widget buildSwitchUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalSwitch(
          semanticLabel: 'Toggle',
          selected: context.knobs.boolean(label: 'Toggle', initialValue: true),
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          onChanged: (value) => knobState.updateKnob('Toggle', value),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalSwitchVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalSwitchSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalSwitchSize.size2,
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixSwitch)
Widget buildSwitchCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalSwitchSize.values),
    rows: labelsOf(FortalSwitchVariant.values),
    cell: (row, column) => FortalSwitch(
      semanticLabel: 'Toggle',
      selected: true,
      size: FortalSwitchSize.values[column],
      variant: FortalSwitchVariant.values[row],
    ),
  );
}
