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
            RemixSpinner(style: styleWithTrack),
            RemixSpinner(style: styleCustomColors),
          ],
        ),
      ),
    );
  }

  SpinnerStyler get styleDefault {
    return SpinnerStyler().indicatorColor(Colors.blue);
  }

  SpinnerStyler get styleWithTrack {
    return SpinnerStyler()
        .indicatorColor(Colors.green)
        .trackColor(Colors.green.withValues(alpha: 0.2));
  }

  SpinnerStyler get styleCustomColors {
    return SpinnerStyler()
        .indicatorColor(Colors.redAccent)
        .trackColor(Colors.red.withValues(alpha: 0.15))
        .duration(2.s);
  }
}
