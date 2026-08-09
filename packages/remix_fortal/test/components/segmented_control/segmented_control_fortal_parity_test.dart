import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  for (final (size, height, fontSize, paddingX, gap, radius, activeSpacing)
      in const [
        (FortalSegmentedControlSize.size1, 24.0, 12.0, 12.0, 4.0, 4.0, -0.12),
        (FortalSegmentedControlSize.size2, 32.0, 14.0, 16.0, 8.0, 4.0, -0.14),
        (FortalSegmentedControlSize.size3, 40.0, 16.0, 16.0, 12.0, 6.0, -0.16),
      ]) {
    testWidgets('${size.name} matches pinned track and item metrics', (
      tester,
    ) async {
      final result = await _resolve(tester, size: size);
      final track = result.spec.container.spec;
      final item = result.spec.item.spec;

      expect(track.constraints?.minHeight, height);
      expect(track.constraints?.maxHeight, double.infinity);
      expect(item.container.spec.constraints?.minHeight, height);
      expect(item.label.spec.style?.fontSize, fontSize);
      expect(
        item.container.spec.padding?.resolve(TextDirection.ltr),
        EdgeInsets.symmetric(horizontal: paddingX),
      );
      expect(item.spacing, gap);
      expect(_radius(track), radius);
      expect(_radiusOrNull(item.container.spec), isNull);
    });

    testWidgets('${size.name} metrics and active tracking scale with Fortal', (
      tester,
    ) async {
      final result = await _resolve(
        tester,
        size: size,
        scaling: .percent110,
        states: {WidgetState.selected},
      );
      final track = result.spec.container.spec;
      final item = result.spec.item.spec;

      expect(track.constraints?.minHeight, closeTo(height * 1.1, 1e-9));
      expect(
        item.container.spec.constraints?.minHeight,
        closeTo(height * 1.1, 1e-9),
      );
      expect(item.label.spec.style?.fontSize, closeTo(fontSize * 1.1, 1e-9));
      expect(
        item.container.spec.padding?.resolve(TextDirection.ltr).horizontal,
        closeTo(paddingX * 2.2, 1e-9),
      );
      expect(item.spacing, closeTo(gap * 1.1, 1e-9));
      expect(_radius(track), closeTo(radius * 1.1, 1e-9));
      expect(
        item.label.spec.style?.letterSpacing,
        closeTo(activeSpacing * 1.1, 1e-9),
      );
    });
  }

  testWidgets('track layers and disabled color match the pinned source', (
    tester,
  ) async {
    final idle = await _resolve(tester);
    final disabled = await _resolve(tester, states: {WidgetState.disabled});
    final idleDecoration =
        idle.spec.container.spec.decoration! as BoxDecoration;
    final disabledDecoration =
        disabled.spec.container.spec.decoration! as BoxDecoration;

    // Radix stacks a gray-a3 background-image over color-surface (gray-3 when
    // disabled). Both track layers pre-blend into the single Flutter fill.
    expect(
      idleDecoration.color,
      Color.alphaBlend(idle.grayA3, idle.colorSurface),
    );
    expect(disabledDecoration.color, Color.alphaBlend(idle.grayA3, idle.gray3));
    expect(idle.spec.container.spec.clipBehavior, Clip.antiAlias);
  });

  testWidgets('labels stay on one line so a narrow track cannot clip them', (
    tester,
  ) async {
    for (final states in [
      const <WidgetState>{},
      {WidgetState.selected},
      {WidgetState.disabled},
    ]) {
      final result = await _resolve(tester, states: states);
      final label = result.spec.item.spec.label.spec;

      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);
    }
  });

  testWidgets('vertical controls keep one size height per segment', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FortalScope(
          child: Center(
            child: FortalSegmentedControl<String>(
              orientation: Axis.vertical,
              items: const [
                RemixSegmentedControlItem(value: 'day', label: 'Day'),
                RemixSegmentedControlItem(value: 'week', label: 'Week'),
              ],
              selectedValue: 'day',
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(
      tester
          .getSize(find.byKey(const ValueKey('RemixSegmentedControl.track')))
          .height,
      64,
    );
  });

  testWidgets('the track paints no layer over the selected indicator', (
    tester,
  ) async {
    final idle = await _resolve(tester);
    final disabled = await _resolve(tester, states: {WidgetState.disabled});

    expect(idle.spec.container.spec.foregroundDecoration, isNull);
    expect(disabled.spec.container.spec.foregroundDecoration, isNull);
  });

  testWidgets('selected surface composes inset fill, ring, and focus', (
    tester,
  ) async {
    final selected = await _resolve(
      tester,
      states: {WidgetState.selected, WidgetState.focused},
    );
    final effects = selected.spec.item.spec.containerEffects!;

    expect(effects.behindContent?.gradients, hasLength(1));
    expect(effects.behindContent?.gradientInsets, [1]);
    expect((effects.behindContent!.gradients.single as LinearGradient).colors, [
      selected.indicatorBackground,
      selected.indicatorBackground,
    ]);
    expect(effects.overContent?.shadows, hasLength(1));
    expect(effects.overContent?.shadows.single.color, selected.grayA4);
    expect(effects.overContent?.shadows.single.shapeInset, 1);
    expect(effects.outline.color, selected.focus8);
    expect(effects.outline.width, 2);
    expect(effects.outlineOffset, -1);
  });

  testWidgets('classic selected state preserves all five shadow-2 layers', (
    tester,
  ) async {
    final selected = await _resolve(
      tester,
      variant: .classic,
      states: {WidgetState.selected},
    );
    final shadows =
        selected.spec.item.spec.containerEffects!.overContent!.shadows;

    expect(shadows, hasLength(5));
    expect(shadows.map((shadow) => shadow.shapeInset), everyElement(1));
    expect(shadows, selected.classicIndicatorShadows);
  });

  testWidgets('disabled selected state removes selected ring and inset', (
    tester,
  ) async {
    final result = await _resolve(
      tester,
      states: {WidgetState.selected, WidgetState.disabled},
    );
    final item = result.spec.item.spec;
    final effects = item.containerEffects!;

    expect(effects.behindContent?.gradientInsets, isEmpty);
    expect((effects.behindContent!.gradients.single as LinearGradient).colors, [
      result.grayA3,
      result.grayA3,
    ]);
    expect(effects.overContent?.shadows, isEmpty);
    expect(item.label.spec.style?.color, result.grayA8);
    expect(_radius(item.container.spec), 4);
  });

  testWidgets('inactive hover relies on track clipping and focus stays round', (
    tester,
  ) async {
    final idle = await _resolve(tester);
    final hovered = await _resolve(tester, states: {WidgetState.hovered});
    final pressed = await _resolve(tester, states: {WidgetState.pressed});
    final focused = await _resolve(tester, states: {WidgetState.focused});

    expect(_color(idle.spec.item.spec.container.spec), isNull);
    expect(_color(hovered.spec.item.spec.container.spec), idle.grayA2);
    expect(_radiusOrNull(hovered.spec.item.spec.container.spec), isNull);
    expect(_color(pressed.spec.item.spec.container.spec), isNull);
    expect(_radius(focused.spec.item.spec.container.spec), 4);
  });

  testWidgets('selected labels use medium tab typography', (tester) async {
    final size1 = await _resolve(
      tester,
      size: .size1,
      states: {WidgetState.selected},
    );
    final size2 = await _resolve(
      tester,
      size: .size2,
      states: {WidgetState.selected},
    );
    final size3 = await _resolve(
      tester,
      size: .size3,
      states: {WidgetState.selected},
    );

    expect(size1.spec.item.spec.label.spec.style?.fontWeight, FontWeight.w500);
    expect(size1.spec.item.spec.label.spec.style?.letterSpacing, -0.12);
    expect(size1.spec.item.spec.label.spec.style?.wordSpacing, 0);
    expect(size2.spec.item.spec.label.spec.style?.letterSpacing, -0.14);
    expect(size3.spec.item.spec.label.spec.style?.letterSpacing, -0.16);
  });
}

Future<
  ({
    SegmentedControlSpec spec,
    Color colorSurface,
    Color grayA2,
    Color grayA3,
    Color grayA4,
    Color grayA8,
    Color gray3,
    Color indicatorBackground,
    Color focus8,
    List<RemixBoxShadow> classicIndicatorShadows,
  })
>
_resolve(
  WidgetTester tester, {
  FortalSegmentedControlSize size = FortalSegmentedControlSize.size2,
  FortalSegmentedControlVariant variant = FortalSegmentedControlVariant.surface,
  FortalScaling scaling = FortalScaling.percent100,
  Set<WidgetState> states = const {},
}) async {
  late ({
    SegmentedControlSpec spec,
    Color colorSurface,
    Color grayA2,
    Color grayA3,
    Color grayA4,
    Color grayA8,
    Color gray3,
    Color indicatorBackground,
    Color focus8,
    List<RemixBoxShadow> classicIndicatorShadows,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      scaling: scaling,
      child: WidgetStateStyleOverride(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: fortalSegmentedControlStyle(
                size: size,
                variant: variant,
              ).build(context).spec,
              colorSurface: MixScope.tokenOf(
                FortalTokens.colorSurface,
                context,
              ),
              grayA2: MixScope.tokenOf(FortalTokens.grayA2, context),
              grayA3: MixScope.tokenOf(FortalTokens.grayA3, context),
              grayA4: MixScope.tokenOf(FortalTokens.grayA4, context),
              grayA8: MixScope.tokenOf(FortalTokens.grayA8, context),
              gray3: MixScope.tokenOf(FortalTokens.gray3, context),
              indicatorBackground: MixScope.tokenOf(
                FortalTokens.segmentedControlIndicatorBackground,
                context,
              ),
              focus8: MixScope.tokenOf(FortalTokens.focus8, context),
              classicIndicatorShadows: MixScope.tokenOf(
                FortalTokens.segmentedControlClassicIndicatorShadows,
                context,
              ),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}

double _radius(BoxSpec box) =>
    ((box.decoration! as BoxDecoration).borderRadius! as BorderRadius)
        .topLeft
        .x;

double? _radiusOrNull(BoxSpec box) =>
    ((box.decoration as BoxDecoration?)?.borderRadius as BorderRadius?)
        ?.topLeft
        .x;

Color? _color(BoxSpec box) => (box.decoration as BoxDecoration?)?.color;
