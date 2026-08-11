import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by line design system
// https://designsystem.line.me/LDSG/components/indicators/badge-en

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: BadgeExample()),
    ),
  );
}

class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [
          RemixBadge(label: '8', style: styleLabel),
          RemixBadge(style: styleIcon, child: const Icon(Icons.camera_alt)),
        ],
      ),
    );
  }

  BadgeStyler get styleLabel {
    return BadgeStyler()
        .size(24, 24)
        .wrap(.clipOval())
        .label(
          TextStyler()
              .fontSize(15)
              .wrap(.align(alignment: .center))
              .fontFeatures([const FontFeature.tabularFigures()]),
        )
        .labelColor(Colors.greenAccent.shade700)
        .labelColor(Colors.white)
        .labelFontWeight(FontWeight.bold)
        .labelFontSize(15);
  }

  BadgeStyler get styleIcon {
    return BadgeStyler()
        .size(24, 24)
        .wrap(.clipOval())
        .label(
          TextStyler()
              .fontSize(15)
              .wrap(.align(alignment: .center))
              .fontFeatures([const FontFeature.tabularFigures()]),
        )
        .labelColor(Colors.redAccent)
        .wrap(.iconTheme(color: Colors.white, size: 15));
  }
}
