import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('defaults to Radix size1, soft, and normal contrast', () {
    const badge = FortalBadge(child: Text('New'));

    expect(badge.size, FortalBadgeSize.size1);
    expect(badge.variant, FortalBadgeVariant.soft);
    expect(badge.highContrast, isFalse);
  });

  group('Fortal Badge geometry', () {
    for (final (size, padding, radius, fontSize) in const [
      (
        FortalBadgeSize.size1,
        EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        3.0,
        12.0,
      ),
      (
        FortalBadgeSize.size2,
        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        4.0,
        12.0,
      ),
      (
        FortalBadgeSize.size3,
        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        4.0,
        14.0,
      ),
    ]) {
      testWidgets('${size.name} matches pinned metrics', (tester) async {
        final spec = await _resolve(tester, fortalBadgeStyler(size: size));
        final box = spec.container.spec;

        expect(box.padding, padding);
        expect(_radius(box), radius);
        expect(spec.label.spec.style!.fontSize, fontSize);
        expect(spec.label.spec.style!.fontWeight, FontWeight.w500);
      });
    }

    testWidgets('scaling applies to metrics and full radius makes a pill', (
      tester,
    ) async {
      final scaled = await _resolve(
        tester,
        fortalBadgeStyler(size: .size3),
        scaling: .percent110,
      );
      final full = await _resolve(tester, fortalBadgeStyler(), radius: .full);

      final padding = scaled.container.spec.padding!.resolve(TextDirection.ltr);
      expect(padding.left, closeTo(11, 1e-9));
      expect(padding.top, closeTo(4.4, 1e-9));
      expect(scaled.label.spec.style!.fontSize, closeTo(15.4, 1e-9));
      expect(_radius(full.container.spec), 9999);
    });

    testWidgets('shrink-wraps its surface inside a bounded parent', (
      tester,
    ) async {
      const slotWidth = 110.0;
      const slotHeight = 48.0;
      await tester.pumpWidget(
        const FortalScope(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: slotWidth,
                height: slotHeight,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FortalBadge(child: Text('Active')),
                ),
              ),
            ),
          ),
        ),
      );

      final badgeSize = tester.getSize(find.byType(DecoratedBox));
      expect(badgeSize.width, lessThan(slotWidth));
      expect(badgeSize.height, lessThan(slotHeight));
    });
  });

  group('Fortal Badge variants', () {
    testWidgets(
      'variants resolve exact fills, inset strokes, and contrast roles',
      (tester) async {
        final tokens = await _tokens(tester);
        final soft = await _resolve(tester, fortalBadgeStyler());
        final solidHigh = await _resolve(
          tester,
          fortalBadgeStyler(variant: .solid, highContrast: true),
        );
        final surface = await _resolve(
          tester,
          fortalBadgeStyler(variant: .surface),
        );
        final outlineHigh = await _resolve(
          tester,
          fortalBadgeStyler(variant: .outline, highContrast: true),
        );

        expect(_color(soft.container.spec), tokens.accentA3);
        expect(soft.label.spec.style!.color, tokens.accentA11);
        expect(_color(solidHigh.container.spec), tokens.accent12);
        expect(solidHigh.label.spec.style!.color, tokens.accent1);
        expect(_color(surface.container.spec), tokens.accentSurface);
        expect(
          surface.effects!.background!.shadows.single.color,
          tokens.accentA6,
        );
        expect(
          outlineHigh.effects!.background!.shadows.map(
            (shadow) => shadow.color,
          ),
          [tokens.accentA7, tokens.grayA11],
        );
        expect(outlineHigh.label.spec.style!.color, tokens.accent12);
      },
    );
  });
}

Future<RemixBadgeSpec> _resolve(
  WidgetTester tester,
  RemixBadgeStyler style, {
  FortalScaling scaling = .percent100,
  FortalRadius radius = .medium,
}) async {
  late RemixBadgeSpec result;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
      radius: radius,
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
    Color accent1,
    Color accent12,
    Color accentA3,
    Color accentA6,
    Color accentA7,
    Color accentA11,
    Color accentSurface,
    Color grayA11,
  })
>
_tokens(WidgetTester tester) async {
  late ({
    Color accent1,
    Color accent12,
    Color accentA3,
    Color accentA6,
    Color accentA7,
    Color accentA11,
    Color accentSurface,
    Color grayA11,
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
            accent1: token(FortalTokens.accent1),
            accent12: token(FortalTokens.accent12),
            accentA3: token(FortalTokens.accentA3),
            accentA6: token(FortalTokens.accentA6),
            accentA7: token(FortalTokens.accentA7),
            accentA11: token(FortalTokens.accentA11),
            accentSurface: token(FortalTokens.accentSurface),
            grayA11: token(FortalTokens.grayA11),
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

Color? _color(BoxSpec box) => (box.decoration as BoxDecoration?)?.color;
