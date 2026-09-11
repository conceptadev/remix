import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('FortalButton recipe', () {
    test('defaults to solid variant and size2', () {
      expect(
        fortalButtonStyle(),
        equals(fortalButtonStyle(variant: .solid, size: .size2)),
      );
    });

    for (final variant in FortalButtonVariant.values) {
      testWidgets('resolves $variant variant', (tester) async {
        final resolved = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyle(variant: variant),
        );

        expect(resolved, isA<StyleSpec<ButtonSpec>>());
        expect(resolved.spec, isA<ButtonSpec>());
        final context = tester.element(find.byType(SizedBox).last);
        Color color(ColorToken token) => MixScope.tokenOf(token, context);
        final box = resolved.spec.container.spec.box!.spec;
        final expectedFill = switch (variant) {
          FortalButtonVariant.classic ||
          FortalButtonVariant.solid => color(FortalTokens.accent9),
          FortalButtonVariant.soft => color(FortalTokens.accentA3),
          FortalButtonVariant.surface => color(FortalTokens.accentSurface),
          FortalButtonVariant.outline => null,
          FortalButtonVariant.ghost => Colors.transparent,
        };
        expect((box.decoration as BoxDecoration?)?.color, expectedFill);
        final expectedLabel =
            variant == FortalButtonVariant.classic ||
                variant == FortalButtonVariant.solid
            ? color(FortalTokens.accentContrast)
            : color(FortalTokens.accentA11);
        expect(resolved.spec.label.spec.style!.color, expectedLabel);
        final effects = resolved.spec.containerEffects?.behindContent;
        if (variant == FortalButtonVariant.classic) {
          expect(effects!.gradients, isNotEmpty);
        } else if (variant == FortalButtonVariant.surface ||
            variant == FortalButtonVariant.outline) {
          expect(
            effects!.shadows.single.color,
            color(
              variant == FortalButtonVariant.surface
                  ? FortalTokens.accentA7
                  : FortalTokens.accentA8,
            ),
          );
          expect(effects.shadows.single.spreadRadius, 1);
        } else {
          expect(effects, isNull);
        }
      });
    }

    testWidgets('each size resolves distinct layout metrics', (tester) async {
      final resolvedBySize = <FortalButtonSize, StyleSpec<ButtonSpec>>{};

      for (final size in FortalButtonSize.values) {
        resolvedBySize[size] = await _resolveFortalButtonStyle(
          tester,
          fortalButtonStyle(size: size),
        );
      }

      final paddings = resolvedBySize.values
          .map((spec) => spec.spec.container.spec.box?.spec.padding)
          .toSet();
      final spacings = resolvedBySize.values
          .map((spec) => spec.spec.container.spec.flex?.spec.spacing)
          .toSet();
      final heights = resolvedBySize.values
          .map(
            (spec) => spec.spec.container.spec.box?.spec.constraints?.minHeight,
          )
          .toSet();

      expect(paddings, hasLength(FortalButtonSize.values.length));
      expect(heights, hasLength(FortalButtonSize.values.length));
      expect(spacings, hasLength(3));
    });
  });
}

Future<StyleSpec<ButtonSpec>> _resolveFortalButtonStyle(
  WidgetTester tester,
  ButtonStyler style,
) async {
  late final StyleSpec<ButtonSpec> resolved;

  await tester.pumpRemixApp(
    Builder(
      builder: (context) {
        resolved = style.resolve(context);

        return const SizedBox.shrink();
      },
    ),
  );

  return resolved;
}
