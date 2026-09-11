import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  for (final explicit in [false, true]) {
    testWidgets(
      'tooltip text defaults respect explicit child values: $explicit',
      (tester) async {
        await tester.pumpRemixApp(
          RemixTooltip(
            style: TooltipStyler()
                .waitDuration(Duration.zero)
                .label(
                  TextStyler()
                      .fontSize(17)
                      .textAlign(TextAlign.end)
                      .maxLines(2)
                      .softWrap(false)
                      .overflow(TextOverflow.ellipsis)
                      .textWidthBasis(TextWidthBasis.longestLine)
                      .textHeightBehavior(
                        TextHeightBehaviorMix(applyHeightToFirstAscent: false),
                      ),
                ),
            tooltipChild: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Audit tooltip',
                style: explicit ? const TextStyle(fontSize: 21) : null,
                textAlign: explicit ? TextAlign.center : null,
                maxLines: explicit ? 3 : null,
                softWrap: explicit ? true : null,
                overflow: explicit ? TextOverflow.clip : null,
                textWidthBasis: explicit ? TextWidthBasis.parent : null,
                textHeightBehavior: explicit
                    ? const TextHeightBehavior(applyHeightToFirstAscent: true)
                    : null,
              ),
            ),
            child: const Text('Trigger'),
          ),
        );
        await tester.pumpAndSettle();
        final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await mouse.addPointer(location: Offset.zero);
        await mouse.moveTo(tester.getCenter(find.text('Trigger')));
        await tester.pumpAndSettle();
        final label = tester.widget<RichText>(
          find.descendant(
            of: find.text('Audit tooltip'),
            matching: find.byType(RichText),
          ),
        );
        expect(label.text.style!.fontSize, explicit ? 21 : 17);
        expect(label.textAlign, explicit ? TextAlign.center : TextAlign.end);
        expect(label.maxLines, explicit ? 3 : 2);
        expect(label.softWrap, explicit);
        expect(
          label.overflow,
          explicit ? TextOverflow.clip : TextOverflow.ellipsis,
        );
        expect(
          label.textWidthBasis,
          explicit ? TextWidthBasis.parent : TextWidthBasis.longestLine,
        );
        expect(label.textHeightBehavior!.applyHeightToFirstAscent, explicit);
        expect(tester.takeException(), isNull);
        await mouse.removePointer();
        await tester.pumpAndSettle();
      },
    );
  }
}
