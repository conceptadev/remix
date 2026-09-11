import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interests', type: RemixCheckboxGroup)
Widget buildCheckboxGroupUseCase(BuildContext context) =>
    const CheckboxGroupExample();

class CheckboxGroupExample extends StatefulWidget {
  const CheckboxGroupExample({super.key});

  @override
  State<CheckboxGroupExample> createState() => _CheckboxGroupExampleState();
}

class _CheckboxGroupExampleState extends State<CheckboxGroupExample> {
  Set<String> _values = {'Design'};

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          RemixCheckboxGroup<String>(
            values: _values,
            onChanged: (values) => setState(() => _values = values),
            semanticLabel: 'Interests',
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FortalCheckboxGroupItem(value: 'Design', label: 'Design'),
                FortalCheckboxGroupItem(value: 'Code', label: 'Code'),
                FortalCheckboxGroupItem(
                  value: 'Research',
                  label: 'Research',
                  enabled: false,
                ),
              ],
            ),
          ),
          Text('Selected: ${_values.isEmpty ? 'none' : _values.join(', ')}'),
        ],
      ),
    ),
  );
}
