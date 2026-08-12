import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by gov.br design system
// https://www.gov.br/ds/components/avatar?tab=desenvolvedor

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: AvatarExample()),
    ),
  );
}

class AvatarExample extends StatelessWidget {
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: .center,
        spacing: 16,
        children: [
          RemixAvatar(label: 'LF', style: labelStyle),
          RemixAvatar(icon: Icons.person, style: iconStyle),
          RemixAvatar(style: image),
        ],
      ),
    );
  }

  AvatarStyler get labelStyle {
    return AvatarStyler()
        .color(Colors.deepPurpleAccent)
        .size(50, 50)
        .shape(.circle())
        .wrap(.clipOval())
        .labelColor(Colors.white)
        .iconColor(Colors.white)
        .labelFontWeight(FontWeight.bold)
        .labelFontSize(15);
  }

  AvatarStyler get iconStyle {
    return AvatarStyler()
        .color(Colors.deepOrangeAccent)
        .size(70, 70)
        .labelColor(Colors.white)
        .iconColor(Colors.white)
        .iconSize(70)
        .icon(IconStyler().wrap(.translate(x: 0, y: 12)))
        .shape(.circle())
        .wrap(.clipOval());
  }

  AvatarStyler get image {
    return AvatarStyler()
        .size(90, 90)
        .backgroundImageUrl('https://i.pravatar.cc/150?img=48')
        .shape(.circle());
  }
}
