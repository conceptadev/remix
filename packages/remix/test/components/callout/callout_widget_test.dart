import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_surface.dart'
    show RemixSurfaceFlexBox;

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixCallout', () {
    testWidgets('renders arbitrary icon and body content', (tester) async {
      await tester.pumpRemixApp(
        const RemixCallout(
          icon: Icon(Icons.info),
          child: Column(children: [Text('Title'), Text('Description')]),
        ),
      );

      expect(find.byType(RemixSurfaceFlexBox), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('resolved styles are inherited by arbitrary content', (
      tester,
    ) async {
      const color = Color(0xFF123456);
      await tester.pumpRemixApp(
        RemixCallout(
          style: RemixCalloutStyler(
            text: TextStyler().color(color).fontSize(15),
            icon: IconStyler().color(color).size(17),
          ),
          icon: const Icon(Icons.info),
          child: const Text('Inherited'),
        ),
      );

      final textContext = tester.element(find.text('Inherited'));
      final iconContext = tester.element(find.byIcon(Icons.info));
      expect(DefaultTextStyle.of(textContext).style.color, color);
      expect(IconTheme.of(iconContext).color, color);
      expect(IconTheme.of(iconContext).size, 17);
    });

    testWidgets('raw style spec provides surface layers', (tester) async {
      const color = Color(0xFF224466);
      await tester.pumpRemixApp(
        const RemixCallout(
          styleSpec: RemixCalloutSpec(
            surface: RemixSurfaceLayerSpec(color: color),
          ),
          child: Text('Spec'),
        ),
      );

      final surface = tester.widget<RemixSurfaceFlexBox>(
        find.byType(RemixSurfaceFlexBox),
      );
      expect(surface.surface!.color, color);
    });
  });
}
