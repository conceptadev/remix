import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  for (final (size, minHeight, fontSize, radius) in const [
    (FortalTextAreaSize.size1, 48.0, 12.0, 4.0),
    (FortalTextAreaSize.size2, 64.0, 14.0, 4.0),
    (FortalTextAreaSize.size3, 80.0, 16.0, 6.0),
  ]) {
    testWidgets('${size.name} matches pinned multiline metrics', (
      tester,
    ) async {
      final result = await _resolve(tester, size: size);
      final container = result.spec.container.spec;
      final decoration = container.decoration! as BoxDecoration;

      expect(container.constraints?.minHeight, minHeight);
      expect(result.spec.text.spec.style?.fontSize, fontSize);
      expect(result.spec.crossAxisAlignment, CrossAxisAlignment.start);
      expect((decoration.borderRadius! as BorderRadius).topLeft.x, radius);
    });
  }

  testWidgets('all variants preserve the pinned outer content insets', (
    tester,
  ) async {
    const expected = [
      EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ];

    for (final variant in FortalTextAreaVariant.values) {
      for (var index = 0; index < FortalTextAreaSize.values.length; index++) {
        final result = await _resolve(
          tester,
          variant: variant,
          size: FortalTextAreaSize.values[index],
        );
        final actual = result.spec.container.spec.padding!.resolve(
          TextDirection.ltr,
        );
        expect(actual.left, closeTo(expected[index].left, 0.000001));
        expect(actual.top, closeTo(expected[index].top, 0.000001));
        expect(actual.right, closeTo(expected[index].right, 0.000001));
        expect(actual.bottom, closeTo(expected[index].bottom, 0.000001));
      }
    }
  });

  testWidgets('soft TextArea uses accent-12 at 0.65 and accent-8 focus', (
    tester,
  ) async {
    final idle = await _resolve(tester, variant: .soft);
    final focused = await _resolve(
      tester,
      variant: .soft,
      states: {WidgetState.focused},
    );

    expect(
      idle.spec.hintText.spec.style?.color,
      idle.accent12.withValues(alpha: 0.65),
    );
    expect(idle.spec.text.spec.selectionColor, idle.accentA5);
    expect(focused.spec.containerEffects?.outline.color, idle.accent8);
    expect(focused.spec.containerEffects?.outline.width, 2);
    expect(focused.spec.containerEffects?.outlineOffset, -1);
  });

  testWidgets('TextField soft placeholder stays distinct at 0.60', (
    tester,
  ) async {
    final result = await _resolveTextFieldSoft(tester);

    expect(
      result.spec.hintText.spec.style?.color,
      result.accent12.withValues(alpha: 0.60),
    );
    expect(result.spec.containerEffects?.outline.color, result.accent8);
  });

  testWidgets('disabled and error states reuse TextField visual policy', (
    tester,
  ) async {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      for (final variant in FortalTextAreaVariant.values) {
        final disabled = await _resolve(
          tester,
          variant: variant,
          brightness: brightness,
          states: {WidgetState.disabled, WidgetState.focused},
        );
        final error = await _resolve(
          tester,
          variant: variant,
          brightness: brightness,
          states: {WidgetState.error},
        );

        expect(disabled.spec.text.spec.style?.color, disabled.grayA11);
        expect(disabled.spec.text.spec.selectionColor, disabled.grayA5);
        expect(
          disabled.spec.hintText.spec.style?.color,
          variant == .soft
              ? disabled.accent12.withValues(alpha: 0.5)
              : disabled.grayA10.withValues(alpha: disabled.grayA10.a * 0.5),
        );
        expect(disabled.spec.cursorColor, disabled.grayA11);
        expect(disabled.spec.containerEffects?.outline.color, disabled.gray8);
        expect(error.spec.helperText.spec.style?.color, error.error11);
        expect(error.spec.containerEffects?.outline.color, error.error8);
        expect(error.spec.cursorColor, error.error9);
      }
    }
  });

  testWidgets('fixed size-3 minimum does not scale', (tester) async {
    final size2 = await _resolve(tester, size: .size2, scaling: .percent110);
    final size3 = await _resolve(tester, size: .size3, scaling: .percent110);

    expect(size2.spec.container.spec.constraints?.minHeight, 70.4);
    expect(size3.spec.container.spec.constraints?.minHeight, 80);
  });

  testWidgets('all TextArea insets retain their scaled values', (tester) async {
    const expected = [
      EdgeInsets.symmetric(horizontal: 6.6, vertical: 4.4),
      EdgeInsets.symmetric(horizontal: 8.8, vertical: 6.6),
      EdgeInsets.symmetric(horizontal: 13.2, vertical: 8.8),
    ];

    for (final variant in FortalTextAreaVariant.values) {
      for (var index = 0; index < FortalTextAreaSize.values.length; index++) {
        final result = await _resolve(
          tester,
          variant: variant,
          size: FortalTextAreaSize.values[index],
          scaling: .percent110,
        );
        final actual = result.spec.container.spec.padding!.resolve(
          TextDirection.ltr,
        );
        expect(actual.left, closeTo(expected[index].left, 0.000001));
        expect(actual.top, closeTo(expected[index].top, 0.000001));
        expect(actual.right, closeTo(expected[index].right, 0.000001));
        expect(actual.bottom, closeTo(expected[index].bottom, 0.000001));
      }
    }
  });

  testWidgets('neutral selection uses focus-a5 in light and dark themes', (
    tester,
  ) async {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      for (final variant in [
        FortalTextAreaVariant.classic,
        FortalTextAreaVariant.surface,
      ]) {
        final result = await _resolve(
          tester,
          variant: variant,
          brightness: brightness,
        );
        expect(result.spec.text.spec.selectionColor, result.focusA5);
      }
    }
  });

  testWidgets('error retains red precedence over disabled TextArea roles', (
    tester,
  ) async {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      for (final variant in FortalTextAreaVariant.values) {
        final result = await _resolve(
          tester,
          variant: variant,
          brightness: brightness,
          states: {
            WidgetState.disabled,
            WidgetState.focused,
            WidgetState.error,
          },
        );

        expect(result.spec.helperText.spec.style?.color, result.error11);
        expect(result.spec.containerEffects?.outline.color, result.error8);
        expect(result.spec.cursorColor, result.error9);
        expect(result.spec.text.spec.style?.color, result.grayA11);
        expect(result.spec.text.spec.selectionColor, result.grayA5);
      }
    }
  });
}

Future<
  ({
    TextFieldSpec spec,
    Color accent8,
    Color accentA5,
    Color accent12,
    Color focusA5,
    Color gray8,
    Color grayA5,
    Color grayA10,
    Color grayA11,
    Color error8,
    Color error9,
    Color error11,
  })
>
_resolve(
  WidgetTester tester, {
  FortalTextAreaVariant variant = FortalTextAreaVariant.surface,
  FortalTextAreaSize size = FortalTextAreaSize.size2,
  FortalScaling scaling = FortalScaling.percent100,
  Brightness brightness = Brightness.light,
  Set<WidgetState> states = const {},
}) async {
  late ({
    TextFieldSpec spec,
    Color accent8,
    Color accentA5,
    Color accent12,
    Color focusA5,
    Color gray8,
    Color grayA5,
    Color grayA10,
    Color grayA11,
    Color error8,
    Color error9,
    Color error11,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      scaling: scaling,
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: fortalTextAreaStyle(
                variant: variant,
                size: size,
              ).build(context).spec,
              accent8: MixScope.tokenOf(FortalTokens.accent8, context),
              accentA5: MixScope.tokenOf(FortalTokens.accentA5, context),
              accent12: MixScope.tokenOf(FortalTokens.accent12, context),
              focusA5: MixScope.tokenOf(FortalTokens.focusA5, context),
              gray8: MixScope.tokenOf(FortalTokens.gray8, context),
              grayA5: MixScope.tokenOf(FortalTokens.grayA5, context),
              grayA10: MixScope.tokenOf(FortalTokens.grayA10, context),
              grayA11: MixScope.tokenOf(FortalTokens.grayA11, context),
              error8: MixScope.tokenOf(FortalTokens.error8, context),
              error9: MixScope.tokenOf(FortalTokens.error9, context),
              error11: MixScope.tokenOf(FortalTokens.error11, context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}

Future<({TextFieldSpec spec, Color accent8, Color accent12})>
_resolveTextFieldSoft(WidgetTester tester) async {
  late ({TextFieldSpec spec, Color accent8, Color accent12}) result;
  await tester.pumpWidget(
    FortalScope(
      child: WidgetStateProvider(
        states: const {WidgetState.focused},
        child: Builder(
          builder: (context) {
            result = (
              spec: fortalTextFieldStyle(variant: .soft).build(context).spec,
              accent8: MixScope.tokenOf(FortalTokens.accent8, context),
              accent12: MixScope.tokenOf(FortalTokens.accent12, context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}
