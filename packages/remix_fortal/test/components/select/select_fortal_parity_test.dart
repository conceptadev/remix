import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  group('Fortal Select geometry', () {
    for (final (size, expected)
        in <
          (
            FortalSelectSize,
            ({
              double triggerHeight,
              double triggerPadding,
              double gap,
              double triggerRadius,
              double chevron,
              double contentPadding,
              double contentRadius,
              double itemHeight,
              double indicatorWidth,
              double indicatorSize,
              double itemRadius,
              double itemFontSize,
            }),
          )
        >[
          (
            FortalSelectSize.size1,
            (
              triggerHeight: 24,
              triggerPadding: 8,
              gap: 4,
              triggerRadius: 3,
              chevron: 9,
              contentPadding: 4,
              contentRadius: 6,
              itemHeight: 24,
              indicatorWidth: 20,
              indicatorSize: 8,
              itemRadius: 3,
              itemFontSize: 12,
            ),
          ),
          (
            FortalSelectSize.size2,
            (
              triggerHeight: 32,
              triggerPadding: 12,
              gap: 6,
              triggerRadius: 4,
              chevron: 9,
              contentPadding: 8,
              contentRadius: 8,
              itemHeight: 32,
              indicatorWidth: 24,
              indicatorSize: 10,
              itemRadius: 4,
              itemFontSize: 14,
            ),
          ),
          (
            FortalSelectSize.size3,
            (
              triggerHeight: 40,
              triggerPadding: 16,
              gap: 8,
              triggerRadius: 6,
              chevron: 11,
              contentPadding: 8,
              contentRadius: 8,
              itemHeight: 32,
              indicatorWidth: 24,
              indicatorSize: 10,
              itemRadius: 4,
              itemFontSize: 16,
            ),
          ),
        ]) {
      testWidgets('${size.name} matches the pinned CSS metrics', (
        tester,
      ) async {
        final spec = await _resolve(tester, fortalSelectStyle(size: size));
        final trigger = spec.trigger.spec;
        final triggerBox = trigger.container.spec.box!.spec;
        final content = spec.content.spec;
        final item = spec.item.spec;
        final itemBox = item.container.spec.box!.spec;

        expect(triggerBox.constraints!.minHeight, expected.triggerHeight);
        expect(triggerBox.constraints!.maxHeight, expected.triggerHeight);
        expect(
          triggerBox.padding,
          EdgeInsets.symmetric(horizontal: expected.triggerPadding),
        );
        expect(trigger.container.spec.flex!.spec.spacing, expected.gap);
        expect(_radius(triggerBox), expected.triggerRadius);
        expect(trigger.chevron.spec.size, expected.chevron);

        expect(
          content.container.spec.padding,
          EdgeInsets.all(expected.contentPadding),
        );
        expect(_radius(content.container.spec), expected.contentRadius);
        expect(content.container.spec.clipBehavior, Clip.antiAlias);

        expect(itemBox.constraints!.minHeight, expected.itemHeight);
        expect(itemBox.constraints!.maxHeight, expected.itemHeight);
        expect(
          itemBox.padding,
          EdgeInsets.symmetric(horizontal: expected.indicatorWidth),
        );
        expect(_radius(itemBox), expected.itemRadius);
        expect(
          item.indicator.spec.constraints!.minWidth,
          expected.indicatorWidth,
        );
        expect(
          item.indicator.spec.constraints!.maxWidth,
          expected.indicatorWidth,
        );
        expect(item.icon.spec.size, expected.indicatorSize);
        expect(item.text.spec.style!.fontSize, expected.itemFontSize);
      });
    }

    testWidgets('all scalable metrics follow Fortal scaling', (tester) async {
      final spec = await _resolve(
        tester,
        fortalSelectStyle(size: .size1),
        scaling: .percent110,
      );
      final triggerBox = spec.trigger.spec.container.spec.box!.spec;
      final item = spec.item.spec;

      expect(triggerBox.constraints!.minHeight, closeTo(26.4, 1e-9));
      expect(triggerBox.padding, const EdgeInsets.symmetric(horizontal: 8.8));
      expect(item.indicator.spec.constraints!.minWidth, closeTo(22, 1e-9));
      expect(item.icon.spec.size, closeTo(8.8, 1e-9));
      expect(item.text.spec.style!.fontSize, closeTo(13.2, 1e-9));
      expect(spec.trigger.spec.chevron.spec.size, 9);
    });

    testWidgets('full radius promotes only the trigger to a pill', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        fortalSelectStyle(size: .size2),
        radius: .full,
      );

      expect(_radius(spec.trigger.spec.container.spec.box!.spec), 9999);
      expect(_radius(spec.content.spec.container.spec), 12);
      expect(_radius(spec.item.spec.container.spec.box!.spec), 6);
    });
  });

  group('Fortal Select state recipes', () {
    testWidgets('surface trigger uses exact idle, open, and disabled roles', (
      tester,
    ) async {
      final idle = await _resolve(tester, fortalSelectStyle());
      final open = await _resolve(
        tester,
        fortalSelectStyle(),
        states: {WidgetState.selected},
      );
      final disabledHover = await _resolve(
        tester,
        fortalSelectStyle(),
        states: {WidgetState.disabled, WidgetState.hovered},
      );
      final tokens = await _tokens(tester);

      expect(_flexColor(idle.trigger.spec.container), tokens.colorSurface);
      expect(
        idle.trigger.spec.containerEffects!.behindContent!.shadows.single.kind,
        RemixBoxShadowKind.inset,
      );
      expect(
        idle.trigger.spec.containerEffects!.behindContent!.shadows.single.color,
        tokens.grayA7,
      );
      expect(
        open.trigger.spec.containerEffects!.behindContent!.shadows.single.color,
        tokens.grayA8,
      );
      expect(_flexColor(disabledHover.trigger.spec.container), tokens.grayA2);
      expect(
        disabledHover
            .trigger
            .spec
            .containerEffects!
            .behindContent!
            .shadows
            .single
            .color,
        tokens.grayA6,
      );
      expect(
        disabledHover.trigger.spec.label.spec.style!.color,
        tokens.grayA11,
      );
      expect(disabledHover.trigger.spec.chevron.spec.color, tokens.grayA9);
    });

    testWidgets('focus ring straddles the trigger edge with solid focus8', (
      tester,
    ) async {
      final focused = await _resolve(
        tester,
        fortalSelectStyle(),
        states: {WidgetState.focused},
      );
      final tokens = await _tokens(tester);
      final ring = focused.trigger.spec.containerEffects!.overContent!;

      expect(ring.shadows, hasLength(2));
      expect(ring.shadows.first.kind, RemixBoxShadowKind.outer);
      expect(ring.shadows.last.kind, RemixBoxShadowKind.inset);
      expect(
        ring.shadows.map((shadow) => shadow.color),
        everyElement(tokens.focus8),
      );
      expect(
        ring.shadows.map((shadow) => shadow.spreadRadius),
        everyElement(1),
      );
    });

    testWidgets(
      'soft and ghost own the pinned alpha fills and placeholder opacity',
      (tester) async {
        final soft = await _resolve(tester, fortalSelectStyle(variant: .soft));
        final softOpen = await _resolve(
          tester,
          fortalSelectStyle(variant: .soft),
          states: {WidgetState.selected},
        );
        final ghost = await _resolve(
          tester,
          fortalSelectStyle(variant: .ghost),
        );
        final tokens = await _tokens(tester);

        expect(_flexColor(soft.trigger.spec.container), tokens.accentA3);
        expect(_flexColor(softOpen.trigger.spec.container), tokens.accentA4);
        expect(soft.trigger.spec.label.spec.style!.color, tokens.accent12);
        expect(soft.trigger.spec.placeholderOpacity, 0.6);
        expect(_flexColor(ghost.trigger.spec.container), Colors.transparent);
        expect(ghost.trigger.spec.placeholderOpacity, 0.6);
        final ghostBox = ghost.trigger.spec.container.spec.box!.spec;
        expect(
          ghostBox.padding,
          const EdgeInsets.all(
            0,
          ).copyWith(left: 8, right: 8, top: 4, bottom: 4),
        );
        expect(
          ghostBox.margin,
          const EdgeInsets.symmetric(horizontal: -8, vertical: -4),
        );
        expect(ghostBox.constraints, isNull);
      },
    );
  });

  testWidgets('uses the pinned Radix chevron and thick-check vector paths', (
    tester,
  ) async {
    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: Scaffold(
            body: FortalSelect<String>(
              trigger: const RemixSelectTrigger(placeholder: 'Choose'),
              items: const [RemixSelectItem(value: 'a', label: 'Apple')],
              selectedValue: 'a',
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('fortal-select-chevron')), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsNothing);

    await tester.tap(find.byType(RemixSelect<String>));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('fortal-select-indicator')),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.check), findsNothing);
  });
}

Future<SelectSpec> _resolve(
  WidgetTester tester,
  SelectStyler style, {
  Set<WidgetState> states = const {},
  FortalScaling scaling = .percent100,
  FortalRadius radius = .medium,
  Brightness brightness = .light,
}) async {
  late SelectSpec resolved;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      scaling: scaling,
      radius: radius,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateStyleOverride(
          states: states,
          child: Builder(
            builder: (context) {
              resolved = style.build(context).spec;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );
  return resolved;
}

Future<
  ({
    Color colorSurface,
    Color grayA2,
    Color grayA5,
    Color grayA6,
    Color grayA7,
    Color grayA8,
    Color grayA9,
    Color grayA11,
    Color grayA12,
    Color gray12,
    Color accent1,
    Color accent9,
    Color accent12,
    Color accentA3,
    Color accentA4,
    Color accentContrast,
    Color focus8,
    Color whiteA4,
    Color whiteA11,
    Color blackA9,
  })
>
_tokens(WidgetTester tester, {Brightness brightness = .light}) async {
  late ({
    Color colorSurface,
    Color grayA2,
    Color grayA5,
    Color grayA6,
    Color grayA7,
    Color grayA8,
    Color grayA9,
    Color grayA11,
    Color grayA12,
    Color gray12,
    Color accent1,
    Color accent9,
    Color accent12,
    Color accentA3,
    Color accentA4,
    Color accentContrast,
    Color focus8,
    Color whiteA4,
    Color whiteA11,
    Color blackA9,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          Color token(ColorToken value) => MixScope.tokenOf(value, context);
          result = (
            colorSurface: token(FortalTokens.colorSurface),
            grayA2: token(FortalTokens.grayA2),
            grayA5: token(FortalTokens.grayA5),
            grayA6: token(FortalTokens.grayA6),
            grayA7: token(FortalTokens.grayA7),
            grayA8: token(FortalTokens.grayA8),
            grayA9: token(FortalTokens.grayA9),
            grayA11: token(FortalTokens.grayA11),
            grayA12: token(FortalTokens.grayA12),
            gray12: token(FortalTokens.gray12),
            accent1: token(FortalTokens.accent1),
            accent9: token(FortalTokens.accent9),
            accent12: token(FortalTokens.accent12),
            accentA3: token(FortalTokens.accentA3),
            accentA4: token(FortalTokens.accentA4),
            accentContrast: token(FortalTokens.accentContrast),
            focus8: token(FortalTokens.focus8),
            whiteA4: token(FortalTokens.whiteA4),
            whiteA11: token(FortalTokens.whiteA11),
            blackA9: token(FortalTokens.blackA9),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}

double? _radius(BoxSpec spec) {
  return (spec.decoration as BoxDecoration?)?.borderRadius
      ?.resolve(TextDirection.ltr)
      .topLeft
      .x;
}

Color? _flexColor(StyleSpec<FlexBoxSpec> style) =>
    (style.spec.box?.spec.decoration as BoxDecoration?)?.color;
