import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Slider Component', type: RemixSlider)
Widget buildSliderUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);
  final divisions = context.knobs.int.input(
    label: 'divisions',
    initialValue: 2,
  );
  final value = context.knobs.double.slider(
    label: 'value',
    min: 0,
    max: 1,
    initialValue: 0.25,
  );
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: FortalSlider(
            values: [value],
            min: 0,
            max: 1,
            step: divisions > 0 ? 1 / divisions : 0.01,
            onChanged: (values) => knobState.updateKnob('value', values.single),
            enabled: context.knobs.boolean(
              label: 'enabled',
              initialValue: true,
            ),
            variant: context.knobs.object.dropdown(
              label: 'variant',
              options: FortalSliderVariant.values,
              labelBuilder: (variant) => variant.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: FortalSliderSize.values,
              labelBuilder: (size) => size.name,
              initialOption: FortalSliderSize.size2,
            ),
          ),
        ),
      ),
    ),
  );
}
