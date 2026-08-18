import 'package:demo/helpers/catalog.dart';
import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Toggle Group Component', type: RemixToggleGroup)
Widget buildToggleGroupUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);
  final selectedValue = context.knobs.object.dropdown<String>(
    label: 'Selected value',
    options: const ['list', 'grid', 'board'],
    initialOption: 'list',
  );
  final orientation = context.knobs.object.dropdown<Axis>(
    label: 'Orientation',
    options: Axis.values,
    initialOption: Axis.horizontal,
    labelBuilder: (value) => value.name,
  );

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalToggleGroup<String>(
          items: const [
            RemixToggleGroupItem(
              value: 'list',
              label: 'List',
              icon: Icons.view_list,
            ),
            RemixToggleGroupItem(
              value: 'grid',
              label: 'Grid',
              icon: Icons.grid_view,
            ),
            RemixToggleGroupItem(
              value: 'board',
              label: 'Board',
              icon: Icons.view_kanban,
            ),
          ],
          selectedValue: selectedValue,
          onChanged: (value) {
            if (value != null) knobState.updateKnob('Selected value', value);
          },
          orientation: orientation,
          loop: context.knobs.boolean(label: 'Loop', initialValue: true),
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          variant: context.knobs.object.dropdown(
            label: 'Variant',
            options: FortalToggleGroupVariant.values,
            initialOption: FortalToggleGroupVariant.soft,
            labelBuilder: (value) => value.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'Size',
            options: FortalToggleGroupSize.values,
            initialOption: FortalToggleGroupSize.size2,
            labelBuilder: (value) => value.name,
          ),
          semanticLabel: 'View style',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixToggleGroup)
Widget buildToggleGroupCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 260,
    columns: labelsOf(FortalToggleGroupSize.values),
    rows: labelsOf(FortalToggleGroupVariant.values),
    cell: (row, column) => FortalToggleGroup<String>(
      items: const [
        RemixToggleGroupItem(
          value: 'list',
          label: 'List',
          icon: Icons.view_list,
        ),
        RemixToggleGroupItem(
          value: 'grid',
          label: 'Grid',
          icon: Icons.grid_view,
        ),
      ],
      selectedValue: 'list',
      size: FortalToggleGroupSize.values[column],
      variant: FortalToggleGroupVariant.values[row],
    ),
  );
}
