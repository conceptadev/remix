import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/mix.dart';
import 'package:remix/src/utilities/remix_style.dart'
    show RemixDefaultContentStyle;

void main() {
  testWidgets(
    'RemixDefaultContentStyle provides defaults while descendants can override',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RemixDefaultContentStyle(
            text: StyleSpec(
              spec: TextSpec(
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            icon: StyleSpec(spec: IconSpec(color: Colors.green, size: 19)),
            child: Row(
              children: [
                Icon(Icons.star),
                Text('Inherited'),
                Icon(Icons.close, color: Colors.red, size: 13),
                Text(
                  'Explicit',
                  style: TextStyle(color: Colors.orange, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      );

      final inheritedTextContext = tester.element(find.text('Inherited'));
      final inheritedIconContext = tester.element(find.byIcon(Icons.star));
      expect(
        DefaultTextStyle.of(inheritedTextContext).style.color,
        Colors.blue,
      );
      expect(DefaultTextStyle.of(inheritedTextContext).style.fontSize, 15);
      expect(IconTheme.of(inheritedIconContext).color, Colors.green);
      expect(IconTheme.of(inheritedIconContext).size, 19);

      final explicitText = tester.widget<Text>(find.text('Explicit'));
      final explicitIcon = tester.widget<Icon>(find.byIcon(Icons.close));
      expect(explicitText.style?.color, Colors.orange);
      expect(explicitText.style?.fontSize, 17);
      expect(explicitIcon.color, Colors.red);
      expect(explicitIcon.size, 13);
    },
  );
}
