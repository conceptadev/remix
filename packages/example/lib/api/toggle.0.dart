import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: ToggleExample()),
    ),
  );
}

class ToggleExample extends StatefulWidget {
  const ToggleExample({super.key});

  @override
  State<ToggleExample> createState() => _ToggleExampleState();
}

class _ToggleExampleState extends State<ToggleExample> {
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          RemixToggle(
            selected: _isBold,
            onChanged: (value) {
              setState(() => _isBold = value);
            },
            icon: Icons.format_bold,
            style: style,
          ),
          RemixToggle(
            selected: _isItalic,
            onChanged: (value) {
              setState(() => _isItalic = value);
            },
            icon: Icons.format_italic,
            style: style,
          ),
          RemixToggle(
            selected: _isUnderline,
            onChanged: (value) {
              setState(() => _isUnderline = value);
            },
            icon: Icons.format_underline,
            style: style,
          ),
        ],
      ),
    );
  }

  RemixToggleStyler get style {
    return RemixToggleStyler()
        .size(40, 40)
        .iconColor(Colors.grey.shade700)
        .iconSize(22)
        .backgroundColor(Colors.grey.shade100)
        .borderRadiusAll(const Radius.circular(8))
        .onHovered(.color(Colors.grey.shade200))
        .onPressed(.scale(0.93))
        .onSelected(
          .color(Colors.deepPurple.shade50).iconColor(Colors.deepPurple),
        )
        .animate(AnimationConfig.easeOut(200.ms));
  }
}
