import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Slider Component', type: RemixSlider)
Widget buildSliderUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: FortalSlider(
            onChanged: (value) => knobState.updateKnob('value', value),
            enabled: context.knobs.boolean(
              label: 'enabled',
              initialValue: true,
            ),
            snapDivisions: context.knobs.int.input(
              label: 'snapDivisions',
              initialValue: 2,
            ),
            value: context.knobs.double.slider(
              label: 'value',
              min: 0,
              max: 1,
              initialValue: 0.25,
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
