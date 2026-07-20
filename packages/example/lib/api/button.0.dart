import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.black, body: ButtonExample()),
    ),
  );
}

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [
          RemixButton(
            onPressed: () {},
            style: destructiveStyle,
            child: const Text('Turn Off'),
          ),
          RemixButton(
            onPressed: () {},
            style: successStyle,
            child: const Text('Turn on'),
          ),
        ],
      ),
    );
  }

  RemixButtonStyler get destructiveStyle {
    return RemixButtonStyler()
        .paddingX(16)
        .paddingY(10)
        .backgroundColor(const Color(0xFF4D1919))
        .shadow(
          BoxShadowMix().color(Colors.redAccent).blurRadius(10).spreadRadius(0),
        )
        .label(TextStyler().uppercase().color(Colors.redAccent))
        .shapeBeveledRectangle(
          borderRadius: BorderRadiusMix()
              .bottomLeft(const Radius.circular(12))
              .topRight(const Radius.circular(12)),
          side: BorderSideMix.width(1).color(Colors.redAccent),
        )
        .wrap(.scale(x: 1, y: 1))
        .onPressed(RemixButtonStyler().wrap(.scale(x: 0.90, y: 0.90)))
        .onHovered(
          RemixButtonStyler()
              .backgroundColor(const Color(0xFF732D2D))
              .animate(.spring(300.ms)),
        )
        .onFocused(
          RemixButtonStyler().backgroundColor(const Color(0xFF732D2D)),
        );
  }

  RemixButtonStyler get successStyle {
    return destructiveStyle
        .backgroundColor(const Color.fromARGB(255, 15, 61, 15))
        .label(TextStyler().uppercase().color(Colors.greenAccent))
        .shapeBeveledRectangle(side: BorderSideMix().color(Colors.greenAccent))
        .shadow(
          BoxShadowMix()
              .color(Colors.greenAccent)
              .blurRadius(10)
              .spreadRadius(0),
        )
        .onHovered(RemixButtonStyler().backgroundColor(const Color(0xFF357857)))
        .onFocused(
          RemixButtonStyler().backgroundColor(const Color(0xFF357857)),
        );
  }
}
