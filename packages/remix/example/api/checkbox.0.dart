import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Carbon design system
// https://carbondesignsystem.com/components/checkbox/usage/

void main() {
  runApp(
    WidgetsApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      textStyle: const TextStyle(color: Color(0xFF202020), fontSize: 16),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      home: const ColoredBox(color: Colors.white, child: CheckboxExample()),
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
        label: 'Receive updates',
        style: style,
      ),
    );
  }

  CheckboxStyler get style {
    return CheckboxStyler()
        .size(24, 24)
        .icon(IconStyler().size(20).color(Colors.white))
        .onSelected(CheckboxStyler().fillColor(Colors.grey.shade900))
        .borderRadius(.all(const Radius.circular(3)))
        .border(
          BoxBorderMix.all(BorderSideMix().color(Colors.black87).width(2)),
        );
  }
}
