import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('Fortal scaled tokens', () {
    for (final scaling in FortalScaling.values) {
      for (final radius in FortalRadius.values) {
        testWidgets('${scaling.name} and ${radius.name}', (tester) async {
          late double space4;
          late double toggleGap1;
          late double toggleGap3;
          late double borderWidth;
          late Radius radius3;
          late Radius radiusFull;
          late Radius radiusThumb;
          late Radius radiusCircle;
          late Radius radius3OrFull;
          late TextStyle text1;
          late TextStyle text3;
          late TextStyle accordionText2;

          await tester.pumpWidget(
            FortalScope(
              brightness: .light,
              scaling: scaling,
              radius: radius,
              child: WidgetsApp(
                color: const Color(0xFF000000),
                builder: (context, child) {
                  space4 = MixScope.tokenOf(FortalTokens.space4, context);
                  toggleGap1 = MixScope.tokenOf(
                    FortalTokens.toggleGap1,
                    context,
                  );
                  toggleGap3 = MixScope.tokenOf(
                    FortalTokens.toggleGap3,
                    context,
                  );
                  borderWidth = MixScope.tokenOf(
                    FortalTokens.borderWidth1,
                    context,
                  );
                  radius3 = MixScope.tokenOf(FortalTokens.radius3, context);
                  radiusFull = MixScope.tokenOf(
                    FortalTokens.radiusFull,
                    context,
                  );
                  radiusThumb = MixScope.tokenOf(
                    FortalTokens.radiusThumb,
                    context,
                  );
                  radiusCircle = MixScope.tokenOf(
                    FortalTokens.radiusCircle,
                    context,
                  );
                  radius3OrFull = MixScope.tokenOf(
                    FortalTokens.radius3OrFull,
                    context,
                  );
                  text1 = MixScope.tokenOf(FortalTokens.text1, context);
                  text3 = MixScope.tokenOf(FortalTokens.text3, context);
                  accordionText2 = MixScope.tokenOf(
                    FortalTokens.accordionText2,
                    context,
                  );
                  return const SizedBox.shrink();
                },
              ),
            ),
          );

          final radiusFactor = switch (radius) {
            .none => 0.0,
            .small => 0.75,
            .medium => 1.0,
            .large || .full => 1.5,
          };
          final expectedRadius3 = 6 * scaling.factor * radiusFactor;
          final expectedFull = radius == .full ? 9999.0 : 0.0;
          final expectedThumb = switch (radius) {
            .none || .small => 0.5,
            .medium || .large || .full => 9999.0,
          };

          expect(space4, closeTo(16 * scaling.factor, 1e-9));
          expect(toggleGap1, closeTo(2 * scaling.factor, 1e-9));
          expect(toggleGap3, closeTo(6 * scaling.factor, 1e-9));
          expect(borderWidth, 1);
          expect(radius3.x, closeTo(expectedRadius3, 1e-9));
          expect(radius3.y, closeTo(expectedRadius3, 1e-9));
          expect(radiusFull, Radius.circular(expectedFull));
          expect(radiusThumb, Radius.circular(expectedThumb));
          expect(radiusCircle, const Radius.circular(9999));
          final expectedRadius3OrFull = expectedRadius3 > expectedFull
              ? expectedRadius3
              : expectedFull;
          expect(radius3OrFull.x, closeTo(expectedRadius3OrFull, 1e-9));
          expect(radius3OrFull.y, closeTo(expectedRadius3OrFull, 1e-9));
          expect(text1.fontSize, closeTo(12 * scaling.factor, 1e-9));
          expect(
            text1.letterSpacing,
            closeTo(0.0025 * 12 * scaling.factor, 1e-9),
          );
          expect(text1.height, closeTo(16 / 12, 1e-9));
          expect(text3.fontSize, closeTo(16 * scaling.factor, 1e-9));
          expect(text3.height, closeTo(24 / 16, 1e-9));
          expect(accordionText2.fontSize, closeTo(15 * scaling.factor, 1e-9));
          expect(accordionText2.height, closeTo(20 / 15, 1e-9));
        });
      }
    }
  });

  testWidgets('gray accent aliases the resolved gray family', (tester) async {
    late Color accent9;
    late Color gray9;

    await tester.pumpWidget(
      FortalScope(
        brightness: .light,
        accent: .gray,
        gray: .slate,
        child: WidgetsApp(
          color: const Color(0xFF000000),
          builder: (context, child) {
            accent9 = MixScope.tokenOf(FortalTokens.accent9, context);
            gray9 = MixScope.tokenOf(FortalTokens.gray9, context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(accent9, gray9);
    expect(accent9, slate.light.scale.step(9));
  });
}
