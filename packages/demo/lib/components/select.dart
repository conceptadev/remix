import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Select Component', type: RemixSelect)
Widget buildSelectUseCase(BuildContext context) {
  final triggerVariant = context.knobs.object.dropdown(
    label: 'trigger variant',
    options: FortalSelectTriggerVariant.values,
    labelBuilder: (variant) => variant.name,
  );
  final contentVariant = context.knobs.object.dropdown(
    label: 'content variant',
    options: FortalSelectContentVariant.values,
    labelBuilder: (variant) => variant.name,
  );
  final size = context.knobs.object.dropdown(
    label: 'size',
    options: FortalSelectSize.values,
    labelBuilder: (size) => size.name,
    initialOption: FortalSelectSize.size3,
  );

  String selectedValue = 'Apple';
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: StatefulBuilder(
          builder: (context, setState) {
            return FortalSelect(
              triggerVariant: triggerVariant,
              contentVariant: contentVariant,
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
              entries: [
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
