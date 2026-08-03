import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('public contract has the pinned enum order and defaults', () {
    expect(FortalCardSize.values, [
      FortalCardSize.size1,
      FortalCardSize.size2,
      FortalCardSize.size3,
      FortalCardSize.size4,
      FortalCardSize.size5,
    ]);
    expect(FortalCardVariant.values, [
      FortalCardVariant.surface,
      FortalCardVariant.classic,
      FortalCardVariant.ghost,
    ]);

    const card = FortalCard(child: Text('Card'));
    expect(card.size, FortalCardSize.size1);
    expect(card.variant, FortalCardVariant.surface);
  });

  group('geometry', () {
    for (final (size, padding, radius) in const [
      (FortalCardSize.size1, 12.0, 8.0),
      (FortalCardSize.size2, 16.0, 8.0),
      (FortalCardSize.size3, 24.0, 12.0),
      (FortalCardSize.size4, 32.0, 12.0),
      (FortalCardSize.size5, 48.0, 16.0),
    ]) {
      testWidgets('${size.name} matches the pinned padding and radius', (
        tester,
      ) async {
        final spec = await _resolve(tester, fortalCardStyle(size: size));
        final box = spec.container.spec;

        expect(box.padding, EdgeInsets.all(padding));
        expect(_radius(box), radius);
        expect(box.clipBehavior, Clip.antiAlias);
      });
    }

    testWidgets('padding and radius scale with the theme', (tester) async {
      final spec = await _resolve(
        tester,
        fortalCardStyle(size: .size5),
        scaling: .percent110,
      );
      expect(
        spec.container.spec.padding!.resolve(TextDirection.ltr).left,
        closeTo(52.8, 1e-9),
      );
      expect(_radius(spec.container.spec), closeTo(17.6, 1e-9));
    });
  });

  group('variants and states', () {
    testWidgets('surface uses the panel layer and exact mixed strokes', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final idle = await _resolve(tester, fortalCardStyle());
      final hovered = await _resolve(
        tester,
        fortalCardStyle(),
        states: {WidgetState.hovered},
      );
      final pressed = await _resolve(
        tester,
        fortalCardStyle(),
        states: {WidgetState.pressed},
      );
      final open = await _resolve(
        tester,
        fortalCardStyle(),
        states: {WidgetState.selected},
      );
      final openAndPressed = await _resolve(
        tester,
        fortalCardStyle(),
        states: {WidgetState.selected, WidgetState.pressed},
      );

      expect(idle.containerEffects!.backdropBlur, 64);
      expect(idle.containerEffects!.behindContent!.gradientInsets, [1]);
      expect(
        (idle.containerEffects!.behindContent!.gradients.single
                as LinearGradient)
            .colors,
        [tokens.panel, tokens.panel],
      );
      expect(
        idle.containerEffects!.overContent!.shadows.single.color,
        tokens.stroke5,
      );
      expect(idle.containerEffects!.overContent!.shadows.single.shapeInset, 1);
      expect(
        hovered.containerEffects!.overContent!.shadows.single.color,
        tokens.stroke7,
      );
      expect(
        pressed.containerEffects!.overContent!.shadows.single.color,
        tokens.stroke6,
      );
      expect(
        open.containerEffects!.overContent!.shadows.single.color,
        tokens.stroke7,
      );
      expect(
        openAndPressed.containerEffects!.overContent!.shadows.single.color,
        tokens.stroke7,
      );
    });

    testWidgets('classic preserves separate outer and inset shadow stacks', (
      tester,
    ) async {
      final idle = await _resolve(tester, fortalCardStyle(variant: .classic));
      final hovered = await _resolve(
        tester,
        fortalCardStyle(variant: .classic),
        states: {WidgetState.hovered},
      );
      final pressed = await _resolve(
        tester,
        fortalCardStyle(variant: .classic),
        states: {WidgetState.pressed},
      );
      final open = await _resolve(
        tester,
        fortalCardStyle(variant: .classic),
        states: {WidgetState.selected},
      );
      final openAndPressed = await _resolve(
        tester,
        fortalCardStyle(variant: .classic),
        states: {WidgetState.selected, WidgetState.pressed},
      );

      for (final spec in [idle, hovered, pressed]) {
        expect(spec.containerEffects!.behindContent!.shadows, hasLength(6));
        expect(spec.containerEffects!.overContent!.shadows, hasLength(6));
        expect(
          spec.containerEffects!.behindContent!.shadows.every(
            (shadow) => shadow.shapeInset == 0,
          ),
          isTrue,
        );
        expect(
          spec.containerEffects!.overContent!.shadows.every(
            (shadow) => shadow.shapeInset == 1,
          ),
          isTrue,
        );
      }
      expect(
        hovered.containerEffects!.behindContent!.shadows,
        isNot(idle.containerEffects!.behindContent!.shadows),
      );
      expect(
        pressed.containerEffects!.overContent!.shadows,
        isNot(idle.containerEffects!.overContent!.shadows),
      );
      expect(
        open.containerEffects!.behindContent!.shadows,
        hovered.containerEffects!.behindContent!.shadows,
      );
      expect(
        open.containerEffects!.overContent!.shadows,
        hovered.containerEffects!.overContent!.shadows,
      );
      expect(
        openAndPressed.containerEffects!.behindContent!.shadows,
        hovered.containerEffects!.behindContent!.shadows,
      );
      expect(
        openAndPressed.containerEffects!.overContent!.shadows,
        hovered.containerEffects!.overContent!.shadows,
      );
    });

    testWidgets('ghost cancels its padding and uses exact state fills', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final idle = await _resolve(
        tester,
        fortalCardStyle(variant: .ghost, size: .size3),
      );
      final hovered = await _resolve(
        tester,
        fortalCardStyle(variant: .ghost, size: .size3),
        states: {WidgetState.hovered},
      );
      final pressed = await _resolve(
        tester,
        fortalCardStyle(variant: .ghost, size: .size3),
        states: {WidgetState.pressed},
      );
      final open = await _resolve(
        tester,
        fortalCardStyle(variant: .ghost, size: .size3),
        states: {WidgetState.selected},
      );
      final openAndPressed = await _resolve(
        tester,
        fortalCardStyle(variant: .ghost, size: .size3),
        states: {WidgetState.selected, WidgetState.pressed},
      );

      expect(idle.container.spec.padding, const EdgeInsets.all(24));
      expect(idle.container.spec.margin, const EdgeInsets.all(-24));
      expect(_boxColor(idle.container), Colors.transparent);
      expect(_boxColor(hovered.container), tokens.grayA3);
      expect(_boxColor(pressed.container), tokens.grayA4);
      expect(_boxColor(open.container), tokens.grayA3);
      expect(_boxColor(openAndPressed.container), tokens.grayA3);
    });

    testWidgets('focus uses the pinned non-layout outline', (tester) async {
      final tokens = await _tokens(tester);
      final focused = await _resolve(
        tester,
        fortalCardStyle(),
        states: {WidgetState.focused},
      );

      expect(focused.containerEffects!.outline.color, tokens.focus8);
      expect(focused.containerEffects!.outline.width, 2);
      expect(focused.containerEffects!.outlineOffset, -1);
    });

    testWidgets('focused active and ghost compound states match CSS', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      for (final variant in [
        FortalCardVariant.surface,
        FortalCardVariant.classic,
      ]) {
        final activeAndFocused = await _resolve(
          tester,
          fortalCardStyle(variant: variant),
          states: {WidgetState.pressed, WidgetState.focused},
        );
        expect(
          activeAndFocused.containerEffects!.behindContent!.gradients,
          hasLength(2),
        );
        expect(
          (activeAndFocused.containerEffects!.behindContent!.gradients.first
                  as LinearGradient)
              .colors,
          [tokens.accentA2, tokens.accentA2],
        );

        final openAndFocused = await _resolve(
          tester,
          fortalCardStyle(variant: variant),
          states: {WidgetState.selected, WidgetState.focused},
        );
        expect(
          openAndFocused.containerEffects!.behindContent!.gradients,
          hasLength(1),
        );
      }

      for (final states in [
        {WidgetState.hovered, WidgetState.focused},
        {WidgetState.pressed, WidgetState.focused},
        {WidgetState.selected, WidgetState.focused},
        {WidgetState.selected, WidgetState.pressed, WidgetState.focused},
      ]) {
        final ghost = await _resolve(
          tester,
          fortalCardStyle(variant: .ghost),
          states: states,
        );
        expect(_boxColor(ghost.container), tokens.accentA2);
      }
    });
  });
}

Future<CardSpec> _resolve(
  WidgetTester tester,
  CardStyler style, {
  FortalScaling scaling = .percent100,
  Set<WidgetState> states = const {},
}) async {
  late CardSpec result;
  await tester.pumpWidget(
    FortalScope(
      brightness: .light,
      scaling: scaling,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              result = style.build(context).spec;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return result;
}

Future<
  ({
    Color panel,
    Color stroke5,
    Color stroke6,
    Color stroke7,
    Color grayA3,
    Color grayA4,
    Color accentA2,
    Color focus8,
  })
>
_tokens(WidgetTester tester) async {
  late ({
    Color panel,
    Color stroke5,
    Color stroke6,
    Color stroke7,
    Color grayA3,
    Color grayA4,
    Color accentA2,
    Color focus8,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      brightness: .light,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          Color token(ColorToken value) => MixScope.tokenOf(value, context);
          result = (
            panel: token(FortalTokens.colorPanel),
            stroke5: token(FortalTokens.grayStroke5),
            stroke6: token(FortalTokens.grayStroke6),
            stroke7: token(FortalTokens.grayStroke7),
            grayA3: token(FortalTokens.grayA3),
            grayA4: token(FortalTokens.grayA4),
            accentA2: token(FortalTokens.accentA2),
            focus8: token(FortalTokens.focus8),
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

Color? _boxColor(StyleSpec<BoxSpec> style) =>
    (style.spec.decoration as BoxDecoration?)?.color;
