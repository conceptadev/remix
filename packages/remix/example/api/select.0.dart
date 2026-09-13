import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    WidgetsApp(
      color: Color(0xFFECEFEB),
      debugShowCheckedModeBanner: false,
      textStyle: const TextStyle(color: Color(0xFF202020), fontSize: 16),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      home: const ColoredBox(color: Color(0xFFECEFEB), child: SelectExample()),
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
        items: [
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

  SelectMenuItemStyler get itemStyle {
    return SelectMenuItemStyler()
        .iconSize(16)
        .padding(.all(8))
        .borderRadius(.all(const Radius.circular(8)))
        .onHovered(SelectMenuItemStyler().color(Colors.blueGrey.shade50))
        .onDisabled(SelectMenuItemStyler().labelColor(Colors.grey.shade300));
  }

  SelectStyler get style {
    return SelectStyler()
        .trigger(
          SelectTriggerStyler()
              .color(Colors.transparent)
              .border(.color(const Color(0xFF898988)))
              .padding(.vertical(10))
              .padding(.horizontal(12))
              .borderRadius(.all(const Radius.circular(12))),
        )
        .menuContainer(
          FlexBoxStyler()
              .width(200)
              .margin(.vertical(5))
              .padding(.all(6))
              .color(Colors.white)
              .borderRadius(.all(const Radius.circular(12))),
        );
  }
}
