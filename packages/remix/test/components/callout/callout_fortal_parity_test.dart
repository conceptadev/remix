import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('defaults to Radix size2, soft, and normal contrast', () {
    const callout = FortalCallout(child: Text('Heads up'));

    expect(callout.size, FortalCalloutSize.size2);
    expect(callout.variant, FortalCalloutVariant.soft);
    expect(callout.highContrast, isFalse);
  });

  group('Fortal Callout geometry', () {
    for (final (size, padding, gap, radius, fontSize) in const [
      (FortalCalloutSize.size1, 12.0, 8.0, 6.0, 14.0),
      (FortalCalloutSize.size2, 16.0, 12.0, 8.0, 14.0),
      (FortalCalloutSize.size3, 24.0, 16.0, 12.0, 16.0),
    ]) {
      testWidgets('${size.name} matches pinned metrics', (tester) async {
        final spec = await _resolve(tester, fortalCalloutStyler(size: size));
        final flex = spec.container.spec;
        final box = flex.box!.spec;

        expect(box.padding, EdgeInsets.all(padding));
        expect(flex.flex!.spec.spacing, gap);
        expect(_radius(box), radius);
        expect(spec.text.spec.style!.fontSize, fontSize);
        expect(flex.flex!.spec.crossAxisAlignment, CrossAxisAlignment.start);
      });
    }

    testWidgets('geometry and type scale with Fortal scaling', (tester) async {
      final spec = await _resolve(
        tester,
        fortalCalloutStyler(size: .size3),
        scaling: .percent110,
      );
      expect(
        spec.container.spec.box!.spec.padding!.resolve(TextDirection.ltr).left,
        closeTo(26.4, 1e-9),
      );
      expect(spec.container.spec.flex!.spec.spacing, closeTo(17.6, 1e-9));
      expect(spec.text.spec.style!.fontSize, closeTo(17.6, 1e-9));
    });
  });

  group('Fortal Callout variants', () {
    testWidgets('variants resolve pinned alpha fills and inset strokes', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final soft = await _resolve(tester, fortalCalloutStyler());
      final surface = await _resolve(
        tester,
        fortalCalloutStyler(variant: .surface),
      );
      final outlineHigh = await _resolve(
        tester,
        fortalCalloutStyler(variant: .outline, highContrast: true),
      );

      expect(soft.surface!.color, tokens.accentA3);
      expect(soft.text.spec.style!.color, tokens.accentA11);
      expect(surface.surface!.color, tokens.accentA2);
      expect(surface.surface!.shadows.single.color, tokens.accentA6);
      expect(outlineHigh.surface!.color, isNull);
      expect(outlineHigh.surface!.shadows.single.color, tokens.accentA7);
      expect(outlineHigh.text.spec.style!.color, tokens.accent12);
    });
  });
}

Future<RemixCalloutSpec> _resolve(
  WidgetTester tester,
  RemixCalloutStyler style, {
  FortalScaling scaling = .percent100,
}) async {
  late RemixCalloutSpec result;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          result = style.build(context).spec;
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}

Future<
  ({
    Color accent12,
    Color accentA2,
    Color accentA3,
    Color accentA6,
    Color accentA7,
    Color accentA11,
  })
>
_tokens(WidgetTester tester) async {
  late ({
    Color accent12,
    Color accentA2,
    Color accentA3,
    Color accentA6,
    Color accentA7,
    Color accentA11,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          Color token(ColorToken value) => MixScope.tokenOf(value, context);
          result = (
            accent12: token(FortalTokens.accent12),
            accentA2: token(FortalTokens.accentA2),
            accentA3: token(FortalTokens.accentA3),
            accentA6: token(FortalTokens.accentA6),
            accentA7: token(FortalTokens.accentA7),
            accentA11: token(FortalTokens.accentA11),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}

double _radius(BoxSpec box) => (box.decoration as BoxDecoration).borderRadius!
    .resolve(TextDirection.ltr)
    .topLeft
    .x;
