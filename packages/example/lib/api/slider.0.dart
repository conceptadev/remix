import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Uber design system
// https://base.uber.com/6d2425e9f/p/30cac1-slider

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: SliderExample()),
    ),
  );
}

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _selectedValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: RemixSlider(
          value: _selectedValue,
          min: 0,
          max: 1,
          snapDivisions: 100,
          style: style,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ),
    );
  }

  RemixSliderStyler get style {
    return RemixSliderStyler()
        .thumbSize(const Size(24, 24))
        .thumb(
          .shape(CircleBorderMix()).shadow(
            BoxShadowMix()
                .color(Colors.black45)
                .blurRadius(4)
                .offset(x: 0, y: 2),
          ),
        )
        .thumbColor(Colors.black)
        .thickness(2)
        .trackColor(Colors.grey.shade300)
        .rangeColor(Colors.black)
        .onDisabled(
          .track(.color(Colors.grey.shade300))
              .rangeColor(Colors.blueGrey)
              .thumbColor(Colors.white.withValues(alpha: 0.6)),
        );
  }
}
