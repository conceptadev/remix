import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Color(0xFFECEFEB), body: SelectExample()),
    ),
  );
}

class SelectExample extends StatefulWidget {
  const SelectExample({super.key});

  @override
  State<SelectExample> createState() => _SelectExampleState();
}

class _SelectExampleState extends State<SelectExample> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RemixSelect(
        trigger: const RemixSelectTrigger(placeholder: 'Text Value'),
        entries: [
          RemixSelectItem(
            value: 'option1',
            label: 'Option 1',
            enabled: true,
            style: itemStyle,
          ),
          RemixSelectItem(
            value: 'option2',
            label: 'Option 2',
            enabled: false,
            style: itemStyle,
          ),
        ],
        selectedValue: _selectedValue,
        style: style,
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
      ),
    );
  }

  RemixSelectMenuItemStyler get itemStyle {
    return RemixSelectMenuItemStyler()
        .iconSize(16)
        .paddingAll(8)
        .borderRadiusAll(const Radius.circular(8))
        .onHovered(RemixSelectMenuItemStyler().color(Colors.blueGrey.shade50))
        .onDisabled(
          RemixSelectMenuItemStyler().labelColor(Colors.grey.shade300),
        );
  }

  RemixSelectStyler get style {
    return RemixSelectStyler()
        .trigger(
          RemixSelectTriggerStyler()
              .color(Colors.transparent)
              .borderAll(color: const Color(0xFF898988))
              .paddingY(10)
              .paddingX(12)
              .borderRadiusAll(const Radius.circular(12)),
        )
        .content(
          RemixSelectContentStyler()
              .width(200)
              .marginY(5)
              .paddingAll(6)
              .color(Colors.white)
              .borderRadiusAll(const Radius.circular(12)),
        );
  }
}
