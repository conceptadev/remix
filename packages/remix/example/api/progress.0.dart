import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Shadcn
// https://ui.shadcn.com/docs/components/progress

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
      home: const ColoredBox(color: Colors.white, child: ProgressExample()),
    ),
  );
}

class ProgressExample extends StatelessWidget {
  const ProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: RemixProgress(value: 0.3, style: style));
  }

  ProgressStyler get style {
    return ProgressStyler()
        .wrap(.clipRRect(borderRadius: .circular(10)))
        .trackColor(Colors.grey.shade300)
        .indicatorColor(Colors.grey.shade900)
        .width(300)
        .height(10);
  }
}
