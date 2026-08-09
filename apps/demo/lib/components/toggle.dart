import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Toggle Component', type: RemixToggle)
Widget buildToggleUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalToggle(
          selected: context.knobs.boolean(
            label: 'Selected',
            initialValue: false,
          ),
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          label: context.knobs.string(label: 'Label', initialValue: 'Bold'),
          icon: Icons.alarm_sharp,
          onChanged: (value) => knobState.updateKnob('Selected', value),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalToggleVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalToggleSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalToggleSize.size2,
          ),
        ),
      ),
    ),
  );
}
