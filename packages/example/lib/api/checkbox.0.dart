import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Carbon design system
// https://carbondesignsystem.com/components/checkbox/usage/

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: CheckboxExample()),
    ),
  );
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RemixCheckbox(
        selected: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value ?? false;
          });
        },
        style: style,
      ),
    );
  }

  RemixCheckboxStyler get style {
    return RemixCheckboxStyler()
        .size(24, 24)
        .icon(.size(20).color(Colors.white))
        .onSelected(.color(Colors.grey.shade900))
        .borderRadiusAll(const Radius.circular(3))
        .border(
          BoxBorderMix.all(BorderSideMix().color(Colors.black87).width(2)),
        );
  }
}
