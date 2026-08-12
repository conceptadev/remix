import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by design.alberta.ca design system
// https://design.alberta.ca/components/callout#tab-0

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: CalloutExample()),
    ),
  );
}

class CalloutExample extends StatelessWidget {
  const CalloutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RemixCallout(
        text: 'Callout important information for the user.',
        icon: Icons.info_outline,
        style: style,
      ),
    );
  }

  CalloutStyler get style {
    return CalloutStyler()
        .color(Colors.grey.shade200)
        .spacing(12)
        .height(60)
        .padding(.right(12))
        .icon(
          IconStyler()
              .size(24)
              .color(Colors.white)
              .wrap(
                .box(
                  BoxStyler()
                      .color(Colors.blue.shade900)
                      .padding(.horizontal(12))
                      .height(.infinity),
                ),
              ),
        )
        .mainAxisSize(.min);
  }
}
