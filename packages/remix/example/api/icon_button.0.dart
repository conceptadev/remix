import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Github design system
// https://primer.style/product/components/icon-button/

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: IconButtonExample()),
    ),
  );
}

class IconButtonExample extends StatelessWidget {
  const IconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [
          RemixIconButton(
            icon: CupertinoIcons.heart,
            onPressed: () {},
            style: style,
          ),
          RemixIconButton(
            icon: CupertinoIcons.heart,
            onPressed: () {},
            style: style,
            loading: true,
          ),
        ],
      ),
    );
  }

  IconButtonStyler get style {
    return IconButtonStyler()
        .iconColor(Colors.blueGrey.shade700)
        .iconSize(22)
        .size(40, 40)
        .color(Colors.blueGrey.shade50.withValues(alpha: 0.6))
        .border(.color(Colors.blueGrey.shade100).width(1.5))
        .borderRadius(.all(const Radius.circular(8)))
        .spinner(
          SpinnerStyler()
              .size(22)
              .strokeWidth(1.3)
              .indicatorColor(Colors.blueGrey.shade600),
        )
        .onHovered(
          IconButtonStyler().color(
            Colors.blueGrey.shade100.withValues(alpha: 0.4),
          ),
        )
        .onPressed(
          IconButtonStyler().color(
            Colors.blueGrey.shade100.withValues(alpha: 0.8),
          ),
        );
  }
}
