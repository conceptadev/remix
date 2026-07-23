import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('defaults to Radix size3, soft, and normal contrast', () {
    const avatar = FortalAvatar(label: 'LF');

    expect(avatar.size, FortalAvatarSize.size3);
    expect(avatar.variant, FortalAvatarVariant.soft);
    expect(avatar.highContrast, isFalse);
  });

  group('Fortal Avatar geometry', () {
    for (final (size, dimension, radius) in const [
      (FortalAvatarSize.size1, 24.0, 4.0),
      (FortalAvatarSize.size2, 32.0, 4.0),
      (FortalAvatarSize.size3, 40.0, 6.0),
      (FortalAvatarSize.size4, 48.0, 6.0),
      (FortalAvatarSize.size5, 64.0, 8.0),
      (FortalAvatarSize.size6, 80.0, 12.0),
      (FortalAvatarSize.size7, 96.0, 12.0),
      (FortalAvatarSize.size8, 128.0, 16.0),
      (FortalAvatarSize.size9, 160.0, 16.0),
    ]) {
      testWidgets('${size.name} matches the pinned dimension and radius', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          fortalAvatarStyler(size: size, fallbackLength: 1),
        );
        final box = spec.container.spec;
        final decoration = box.decoration as BoxDecoration;

        expect(box.constraints!.minWidth, dimension);
        expect(box.constraints!.maxWidth, dimension);
        expect(box.constraints!.minHeight, dimension);
        expect(box.constraints!.maxHeight, dimension);
        expect(
          decoration.borderRadius!.resolve(TextDirection.ltr).topLeft.x,
          radius,
        );
        expect(spec.label.spec.style!.height, 1);
        expect(spec.label.spec.style!.fontWeight, FontWeight.w500);
      });
    }

    testWidgets('explicit pixel sizes and type scale with the theme', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        fortalAvatarStyler(size: .size6, fallbackLength: 1),
        scaling: .percent110,
      );

      expect(spec.container.spec.constraints!.minWidth, closeTo(88, 1e-9));
      expect(spec.label.spec.style!.fontSize, closeTo(30.8, 1e-9));
    });

    testWidgets('one- and two-letter fallbacks use the pinned type sizes', (
      tester,
    ) async {
      final one = await _resolve(
        tester,
        fortalAvatarStyler(size: .size3, fallbackLength: 1),
      );
      final two = await _resolve(
        tester,
        fortalAvatarStyler(size: .size3, fallbackLength: 2),
      );

      expect(one.label.spec.style!.fontSize, 18);
      expect(two.label.spec.style!.fontSize, 16);
      expect(one.label.spec.style!.letterSpacing, 0);
      expect(two.label.spec.style!.letterSpacing, 0);
    });

    testWidgets('full radius promotes every size to a circle', (tester) async {
      final spec = await _resolve(
        tester,
        fortalAvatarStyler(size: .size9, fallbackLength: 1),
        radius: .full,
      );
      final decoration = spec.container.spec.decoration as BoxDecoration;

      expect(
        decoration.borderRadius!.resolve(TextDirection.ltr).topLeft.x,
        9999,
      );
    });
  });

  group('Fortal Avatar variants', () {
    testWidgets('soft and solid resolve normal and high-contrast roles', (
      tester,
    ) async {
      final soft = await _resolve(tester, fortalAvatarStyler());
      final softHigh = await _resolve(
        tester,
        fortalAvatarStyler(highContrast: true),
      );
      final solid = await _resolve(tester, fortalAvatarStyler(variant: .solid));
      final solidHigh = await _resolve(
        tester,
        fortalAvatarStyler(variant: .solid, highContrast: true),
      );
      final tokens = await _tokens(tester);

      expect(_color(soft), tokens.accentA3);
      expect(soft.label.spec.style!.color, tokens.accentA11);
      expect(_color(softHigh), tokens.accentA3);
      expect(softHigh.label.spec.style!.color, tokens.accent12);
      expect(_color(solid), tokens.accent9);
      expect(solid.label.spec.style!.color, tokens.accentContrast);
      expect(_color(solidHigh), tokens.accent12);
      expect(solidHigh.label.spec.style!.color, tokens.accent1);
    });
  });
}

Future<RemixAvatarSpec> _resolve(
  WidgetTester tester,
  RemixAvatarStyler style, {
  FortalScaling scaling = .percent100,
  FortalRadius radius = .medium,
}) async {
  late RemixAvatarSpec resolved;
  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
      radius: radius,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          resolved = style.build(context).spec;
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return resolved;
}

Future<
  ({
    Color accent1,
    Color accent9,
    Color accent12,
    Color accentA3,
    Color accentA11,
    Color accentContrast,
  })
>
_tokens(WidgetTester tester) async {
  late ({
    Color accent1,
    Color accent9,
    Color accent12,
    Color accentA3,
    Color accentA11,
    Color accentContrast,
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
            accent9: token(FortalTokens.accent9),
            accent12: token(FortalTokens.accent12),
            accentA3: token(FortalTokens.accentA3),
            accentA11: token(FortalTokens.accentA11),
            accentContrast: token(FortalTokens.accentContrast),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}

Color? _color(RemixAvatarSpec spec) =>
    (spec.container.spec.decoration as BoxDecoration?)?.color;
