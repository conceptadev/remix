import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

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
        expect(
          result.spec.container.spec.padding?.resolve(TextDirection.ltr),
          expected[index],
        );
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
    expect(focused.spec.containerEffects?.outline.color, idle.accent8);
    expect(focused.spec.containerEffects?.outline.width, 2);
    expect(focused.spec.containerEffects?.outlineOffset, -1);
  });

  testWidgets('TextField soft correction stays distinct at 0.60', (
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
    final disabled = await _resolve(tester, states: {WidgetState.disabled});
    final error = await _resolve(tester, states: {WidgetState.error});

    expect(disabled.spec.text.spec.style?.color, disabled.gray11);
    expect(disabled.spec.hintText.spec.style?.color, disabled.grayA8);
    expect(error.spec.helperText.spec.style?.color, error.error11);
    expect(error.spec.containerEffects?.outline.color, error.error8);
  });

  testWidgets('fixed size-3 minimum does not scale', (tester) async {
    final size2 = await _resolve(tester, size: .size2, scaling: .percent110);
    final size3 = await _resolve(tester, size: .size3, scaling: .percent110);

    expect(size2.spec.container.spec.constraints?.minHeight, 70.4);
    expect(size3.spec.container.spec.constraints?.minHeight, 80);
  });
}

Future<
  ({
    TextFieldSpec spec,
    Color accent8,
    Color accent12,
    Color gray11,
    Color grayA8,
    Color error8,
    Color error11,
  })
>
_resolve(
  WidgetTester tester, {
  FortalTextAreaVariant variant = FortalTextAreaVariant.surface,
  FortalTextAreaSize size = FortalTextAreaSize.size2,
  FortalScaling scaling = FortalScaling.percent100,
  Set<WidgetState> states = const {},
}) async {
  late ({
    TextFieldSpec spec,
    Color accent8,
    Color accent12,
    Color gray11,
    Color grayA8,
    Color error8,
    Color error11,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
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
              accent12: MixScope.tokenOf(FortalTokens.accent12, context),
              gray11: MixScope.tokenOf(FortalTokens.gray11, context),
              grayA8: MixScope.tokenOf(FortalTokens.grayA8, context),
              error8: MixScope.tokenOf(FortalTokens.error8, context),
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
