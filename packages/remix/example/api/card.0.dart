import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by dell design system
// https://www.delldesignsystem.com/components/card/?tab=Design

void main() {
  runApp(
    WidgetsApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      textStyle: const TextStyle(color: Color(0xFF202020), fontSize: 16),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      home: const ColoredBox(color: Colors.white, child: CardExample()),
    ),
  );
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [RemixCard(style: style)],
      ),
    );
  }

  CardStyler get style {
    return CardStyler()
        .size(300, 200)
        .color(Colors.white)
        .borderRadius(.all(const Radius.circular(4)))
        .border(.color(Colors.grey.shade300));
  }
}
