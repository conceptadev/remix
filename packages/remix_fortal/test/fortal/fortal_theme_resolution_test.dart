import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('theme configuration stores only canonical nullable overrides', () {
    const config = FortalThemeConfig();

    expect(config.accent, isNull);
    expect(config.gray, isNull);
    expect(config.brightness, isNull);
    expect(config.panelBackground, isNull);
    expect(config.radius, isNull);
    expect(config.scaling, isNull);
    expect(config.hasBackground, isNull);
  });

  testWidgets('root scope resolves the documented defaults', (tester) async {
    late FortalThemeData data;

    await tester.pumpWidget(
      FortalScope(
        child: Builder(
          builder: (context) {
            data = FortalTheme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(data.accent, FortalAccentColor.indigo);
    expect(data.gray, FortalGrayColor.slate);
    expect(data.brightness, Brightness.light);
    expect(data.panelBackground, FortalPanelBackground.translucent);
    expect(data.radius, FortalRadius.medium);
    expect(data.scaling, FortalScaling.percent100);
    expect(data.hasBackground, isTrue);
  });

  testWidgets('nested scopes inherit unspecified values without repainting', (
    tester,
  ) async {
    late FortalThemeData outer;
    late FortalThemeData inner;

    await tester.pumpWidget(
      FortalScope(
        accent: .red,
        gray: .mauve,
        brightness: .dark,
        radius: .large,
        child: Builder(
          builder: (context) {
            outer = FortalTheme.of(context);
            return FortalScope(
              scaling: .percent110,
              child: Builder(
                builder: (context) {
                  inner = FortalTheme.of(context);
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );

    expect(inner.accent, outer.accent);
    expect(inner.gray, outer.gray);
    expect(inner.brightness, outer.brightness);
    expect(inner.radius, outer.radius);
    expect(inner.scaling, FortalScaling.percent110);
    expect(inner.hasBackground, isFalse);
  });

  testWidgets('captured themes rebuild their Mix token scope', (tester) async {
    late BuildContext sourceContext;

    await tester.pumpWidget(
      FortalScope(
        accent: .red,
        child: Builder(
          builder: (context) {
            sourceContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    final captured = InheritedTheme.capture(
      from: sourceContext,
      to: tester.element(find.byType(FortalScope)),
    );
    late Color accent;
    await tester.pumpWidget(
      captured.wrap(
        Builder(
          builder: (context) {
            accent = MixScope.tokenOf(FortalTokens.accent9, context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(accent, isNotNull);
  });

  testWidgets('component recipe tokens resolve exact light and dark values', (
    tester,
  ) async {
    final light = await _captureRecipeTokens(
      tester,
      brightness: Brightness.light,
    );
    final dark = await _captureRecipeTokens(
      tester,
      brightness: Brightness.dark,
    );

    expect(light.pulseDuration, const Duration(milliseconds: 1000));
    expect(light.indicatorBackground, light.colorBackground);
    expect(dark.indicatorBackground, dark.grayA3);
    expect(light.classicIndicatorShadows, hasLength(5));
    expect(dark.classicIndicatorShadows, hasLength(5));
    for (final shadows in [
      light.classicIndicatorShadows,
      dark.classicIndicatorShadows,
    ]) {
      expect(shadows.map((shadow) => shadow.shapeInset), everyElement(1));
    }
    expect(light.textAreaMinHeight3, 80);
    expect(light.dataListRowGap3, 20);
    expect(light.dataListLabelMinWidth, 120);
  });

  testWidgets('recipe spacing tokens scale while fixed CSS lengths do not', (
    tester,
  ) async {
    final scaled = await _captureRecipeTokens(
      tester,
      brightness: Brightness.light,
      scaling: FortalScaling.percent110,
    );

    expect(scaled.textAreaMinHeight3, 80);
    expect(scaled.dataListRowGap3, 22);
    expect(scaled.dataListLabelMinWidth, 120);
  });
}

Future<
  ({
    Duration pulseDuration,
    Color indicatorBackground,
    Color colorBackground,
    Color grayA3,
    List<RemixBoxShadow> classicIndicatorShadows,
    double textAreaMinHeight3,
    double dataListRowGap3,
    double dataListLabelMinWidth,
  })
>
_captureRecipeTokens(
  WidgetTester tester, {
  required Brightness brightness,
  FortalScaling scaling = FortalScaling.percent100,
}) async {
  late ({
    Duration pulseDuration,
    Color indicatorBackground,
    Color colorBackground,
    Color grayA3,
    List<RemixBoxShadow> classicIndicatorShadows,
    double textAreaMinHeight3,
    double dataListRowGap3,
    double dataListLabelMinWidth,
  })
  result;

  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      scaling: scaling,
      child: Builder(
        builder: (context) {
          result = (
            pulseDuration: MixScope.tokenOf(
              FortalTokens.skeletonPulseDuration,
              context,
            ),
            indicatorBackground: MixScope.tokenOf(
              FortalTokens.segmentedControlIndicatorBackground,
              context,
            ),
            colorBackground: MixScope.tokenOf(
              FortalTokens.colorBackground,
              context,
            ),
            grayA3: MixScope.tokenOf(FortalTokens.grayA3, context),
            classicIndicatorShadows: MixScope.tokenOf(
              FortalTokens.segmentedControlClassicIndicatorShadows,
              context,
            ),
            textAreaMinHeight3: MixScope.tokenOf(
              FortalTokens.textAreaMinHeight3,
              context,
            ),
            dataListRowGap3: MixScope.tokenOf(
              FortalTokens.dataListRowGap3,
              context,
            ),
            dataListLabelMinWidth: MixScope.tokenOf(
              FortalTokens.dataListLabelMinWidth,
              context,
            ),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return result;
}
