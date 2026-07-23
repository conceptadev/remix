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
        icon: Icons.info_outline,
        style: style,
        child: const Text('Callout important information for the user.'),
      ),
    );
  }

  RemixCalloutStyler get style {
    return RemixCalloutStyler()
        .backgroundColor(Colors.grey.shade200)
        .spacing(12)
        .height(60)
        .paddingRight(12)
        .icon(
          .size(24)
              .color(Colors.white)
              .wrap(
                .box(
                  .color(Colors.blue.shade900).paddingX(12).height(.infinity),
                ),
              ),
        )
        .mainAxisSize(.min);
  }
}
