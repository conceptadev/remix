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
            semanticLabel: 'Favorite',
            onPressed: () {},
            style: style,
            child: const Icon(CupertinoIcons.heart),
          ),
          RemixIconButton(
            semanticLabel: 'Favorite loading',
            onPressed: () {},
            style: style,
            loading: true,
            child: const Icon(CupertinoIcons.heart),
          ),
        ],
      ),
    );
  }

  RemixIconButtonStyler get style {
    return RemixIconButtonStyler()
        .foregroundColor(Colors.blueGrey.shade700)
        .iconSize(22)
        .size(40, 40)
        .backgroundColor(Colors.blueGrey.shade50.withValues(alpha: 0.6))
        .borderAll(color: Colors.blueGrey.shade100, width: 1.5)
        .borderRadiusAll(const Radius.circular(8))
        .spinner(.size(22).color(Colors.blueGrey.shade600))
        .onHovered(.color(Colors.blueGrey.shade100.withValues(alpha: 0.4)))
        .onPressed(.color(Colors.blueGrey.shade100.withValues(alpha: 0.8)));
  }
}
