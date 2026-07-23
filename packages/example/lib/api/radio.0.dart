import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by olist
// https://designsystem.olist.io/latest/components/radio

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: RadioExample()),
    ),
  );
}

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RemixRadioGroup<String>(
        groupValue: _selectedValue,
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        child: Column(
          crossAxisAlignment: .center,
          spacing: 16,
          mainAxisSize: .min,
          children: [
            Row(
              spacing: 8,
              mainAxisSize: .min,
              children: [
                RemixRadio<String>(value: 'option1', style: style),
                const Text('Option 1'),
              ],
            ),
            Row(
              spacing: 8,
              mainAxisSize: .min,
              children: [
                RemixRadio<String>(value: 'option2', style: style),
                const Text('Option 2'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RemixRadioStyler get style {
    return RemixRadioStyler()
        .borderRadiusAll(const Radius.circular(30))
        .size(22, 22)
        .border(
          BoxBorderMix.all(
            BorderSideMix()
                .color(Colors.blueGrey.shade100)
                .width(2.4)
                .strokeAlign(BorderSide.strokeAlignInside),
          ),
        )
        .onHovered(
          .shadow(
            BoxShadowMix()
                .color(Colors.blueGrey.shade50.withValues(alpha: 0.7))
                .blurRadius(0)
                .spreadRadius(9),
          ),
        )
        .onPressed(
          .border(
            BoxBorderMix.all(
              BorderSideMix()
                  .color(Colors.blueGrey.shade100)
                  .width(6)
                  .strokeAlign(BorderSide.strokeAlignInside),
            ),
          ),
        )
        .onSelected(
          .border(
            BoxBorderMix.all(
              BorderSideMix()
                  .color(Colors.blueAccent.shade700)
                  .width(6)
                  .strokeAlign(BorderSide.strokeAlignInside),
            ),
          ),
        );
  }
}
