import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
// The painter is internal, so this reaches past the barrel on purpose: the
// point of the test is that the resolved effects arrive at the widget that
// actually draws them.
import 'package:remix/src/rendering/remix_box_effects.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixLink focus ring', () {
    // A link carries no fill, border, or padding, so its container slot exists
    // for exactly one reason: hosting the focus-visible ring. Resolving the
    // effects is not enough — dropping the box would still resolve them and
    // silently paint nothing, which spec-level assertions cannot see.
    testWidgets('resolved container effects reach the painter', (tester) async {
      final previousStrategy = FocusManager.instance.highlightStrategy;
      addTearDown(() {
        FocusManager.instance.highlightStrategy = previousStrategy;
      });
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;

      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpRemixApp(
        RemixLink(
          label: 'Ringed',
          focusNode: focusNode,
          onPressed: () {},
          style: LinkStyler()
              .borderRadius(BorderRadiusGeometryMix.circular(4))
              .onFocusVisible(
                LinkStyler().containerEffects(
                  RemixBoxEffectsMix(
                    outline: BorderSideMix(color: Colors.blue, width: 2),
                    outlineOffset: 2,
                  ),
                ),
              ),
        ),
      );
      await tester.pumpAndSettle();

      RemixBoxEffectsSpec? paintedEffects() => tester
          .widget<RemixBoxAdapter>(find.byType(RemixBoxAdapter))
          .containerEffects;

      expect(paintedEffects()?.outline.width ?? 0, 0, reason: 'idle');

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      final focused = paintedEffects();
      expect(focused, isNotNull);
      expect(focused!.outline.width, 2);
      expect(focused.outline.color, Colors.blue);
      expect(focused.outlineOffset, 2);
    });
  });
}
