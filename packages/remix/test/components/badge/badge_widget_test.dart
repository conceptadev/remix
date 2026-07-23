import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixBadge', () {
    testWidgets('renders arbitrary content', (tester) async {
      await tester.pumpRemixApp(
        const RemixBadge(child: Row(children: [Icon(Icons.star), Text('New')])),
      );

      expect(find.byType(Box), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('resolved text style and icon theme are inherited', (
      tester,
    ) async {
      const textColor = Color(0xFF123456);
      const iconColor = Color(0xFF654321);
      await tester.pumpRemixApp(
        RemixBadge(
          style: RemixBadgeStyler(
            label: TextStyler().color(textColor).fontSize(13),
          ),
          child: const _IconAndText(iconColor: iconColor),
        ),
      );

      final text = tester.widget<Text>(find.text('Inherited'));
      expect(text.style, isNull);
      expect(
        DefaultTextStyle.of(tester.element(find.text('Inherited'))).style.color,
        textColor,
      );
    });

    testWidgets('raw style spec uses its surface and text style', (
      tester,
    ) async {
      const color = Color(0xFF224466);
      await tester.pumpRemixApp(
        const RemixBadge(
          styleSpec: RemixBadgeSpec(
            container: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: color)),
            ),
            containerEffects: RemixBoxEffectsSpec(
              behindContent: RemixBoxEffectLayerSpec(
                shadows: [RemixBoxShadow(color: color)],
              ),
            ),
          ),
          child: Text('Spec'),
        ),
      );
      expect(find.byType(CustomPaint), findsWidgets);
      expect(
        DefaultTextStyle.of(tester.element(find.text('Spec'))).style.color,
        color,
      );
    });
  });
}

class _IconAndText extends StatelessWidget {
  const _IconAndText({required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    // An explicit icon color remains authoritative over the inherited theme.
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: iconColor),
        const Text('Inherited'),
      ],
    );
  }
}
