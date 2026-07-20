import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: SpinnerExample()),
    ),
  );
}

class SpinnerExample extends StatefulWidget {
  const SpinnerExample({super.key});

  @override
  State<SpinnerExample> createState() => _SpinnerExampleState();
}

class _SpinnerExampleState extends State<SpinnerExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: .center,
          spacing: 16,
          children: [
            RemixSpinner(style: styleDefault),
            RemixSpinner(style: styleMuted),
            RemixSpinner(style: styleCustomColors),
          ],
        ),
      ),
    );
  }

  RemixSpinnerStyler get styleDefault {
    return RemixSpinnerStyler().color(Colors.blue);
  }

  RemixSpinnerStyler get styleMuted {
    return RemixSpinnerStyler().color(Colors.green).opacity(0.45);
  }

  RemixSpinnerStyler get styleCustomColors {
    return RemixSpinnerStyler()
        .color(Colors.redAccent)
        .leafRadius(const Radius.circular(3))
        .duration(2.s);
  }
}
