import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  testWidgets('root scope establishes the Radix root text run', (tester) async {
    // Upstream `.radix-themes` sets the page's default text run, not just its
    // tokens: `--default-font-size` is `--font-size-3`, `--default-line-height`
    // is 1.5, `--default-letter-spacing` is 0, `--default-font-weight` is
    // regular, and `color.css` adds `color: var(--gray-12)`.
    for (final (scaling, factor) in const [
      (FortalScaling.percent90, 0.9),
      (FortalScaling.percent100, 1.0),
      (FortalScaling.percent110, 1.1),
    ]) {
      for (final brightness in Brightness.values) {
        late TextStyle root;
        late Color gray12;
        await tester.pumpWidget(
          FortalScope(
            brightness: brightness,
            scaling: scaling,
            child: Builder(
              builder: (context) {
                root = DefaultTextStyle.of(context).style;
                gray12 = MixScope.tokenOf(FortalTokens.gray12, context);

                return const SizedBox();
              },
            ),
          ),
        );

        final reason = '${scaling.name}/${brightness.name}';
        expect(root.fontSize, closeTo(16 * factor, 1e-9), reason: reason);
        expect(root.height, closeTo(1.5, 1e-9), reason: reason);
        expect(root.letterSpacing, 0, reason: reason);
        expect(root.fontWeight, FontWeight.w400, reason: reason);
        expect(root.color, gray12, reason: reason);
        // Radix's `--default-font-family` is the platform system stack, so the
        // root deliberately pins no family.
        expect(root.fontFamily, isNull, reason: reason);
      }
    }
  });

  testWidgets('unsized typography measures 1em against the root, not the host', (
    tester,
  ) async {
    // The host supplies a deliberately wrong ambient size; the scope must win.
    await tester.pumpWidget(
      DefaultTextStyle(
        style: const TextStyle(fontSize: 40),
        child: const FortalScope(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [FortalText('body'), FortalCode.soft('code')],
            ),
          ),
        ),
      ),
    );

    expect(tester.widget<Text>(find.text('body')).style?.fontSize, isNull);
    expect(
      tester
          .renderObject<RenderParagraph>(find.text('body'))
          .text
          .style
          ?.fontSize,
      16,
    );
    // Code's em geometry is derived from the resolved ambient size.
    expect(
      tester.widget<Text>(find.text('code')).style?.fontSize,
      closeTo(16 * 0.95 * 0.95, 1e-9),
    );
  });

  testWidgets('unsized typography inherits a nearer text style', (
    tester,
  ) async {
    await tester.pumpWidget(
      const FortalScope(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 20, letterSpacing: 2),
            child: Column(
              children: [FortalText('body'), FortalCode.soft('code')],
            ),
          ),
        ),
      ),
    );

    expect(
      tester
          .renderObject<RenderParagraph>(find.text('body'))
          .text
          .style
          ?.fontSize,
      20,
    );
    expect(
      tester.widget<Text>(find.text('code')).style?.fontSize,
      closeTo(20 * 0.95 * 0.95, 1e-9),
    );
  });

  testWidgets('a nested scope preserves the nearest text style', (
    tester,
  ) async {
    // Accent and scaling are the two reasons a real subtree re-scopes; neither
    // is a reason to restate the run the surrounding page already set.
    await tester.pumpWidget(
      const FortalScope(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFF00FF00),
            ),
            child: FortalScope(
              accent: .red,
              scaling: .percent110,
              child: Column(
                children: [FortalText('body'), FortalCode.soft('code')],
              ),
            ),
          ),
        ),
      ),
    );

    final body = tester
        .renderObject<RenderParagraph>(find.text('body'))
        .text
        .style!;
    expect(body.fontSize, 20);
    expect(body.fontWeight, FontWeight.w700);
    expect(body.letterSpacing, 2);
    expect(body.color, const Color(0xFF00FF00));
    // Code keeps deriving its em geometry from that preserved ambient size.
    expect(
      tester.widget<Text>(find.text('code')).style?.fontSize,
      closeTo(20 * 0.95 * 0.95, 1e-9),
    );
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

  testWidgets('captured themes rebuild tokens and keep their nearest style', (
    tester,
  ) async {
    // `DefaultTextStyle` is itself an `InheritedTheme`, so the capture already
    // carries the actual nearest run across; the theme only has to rebuild the
    // Mix tokens a route would otherwise lose.
    final root = await _captureThemes(tester, ambient: null);
    expect(root.accent, isNotNull);
    expect(root.text.fontSize, 16);
    expect(root.text.color, root.gray12);

    final nested = await _captureThemes(
      tester,
      ambient: const TextStyle(fontSize: 20, letterSpacing: 2),
    );
    expect(nested.accent, isNotNull);
    expect(nested.text.fontSize, 20);
    expect(nested.text.letterSpacing, 2);
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

/// Pumps a scope, captures its themes from a descendant, and re-pumps that
/// capture on its own so the wrapped values are the ones under assertion.
///
/// A non-null [ambient] inserts a nearer text style and a nested scope beneath
/// it, which is the shape of a subtree that re-scopes tokens mid-page.
Future<({Color accent, Color gray12, TextStyle text})> _captureThemes(
  WidgetTester tester, {
  required TextStyle? ambient,
}) async {
  late BuildContext sourceContext;
  final probe = Builder(
    builder: (context) {
      sourceContext = context;
      return const SizedBox();
    },
  );

  await tester.pumpWidget(
    FortalScope(
      accent: .red,
      child: ambient == null
          ? probe
          : DefaultTextStyle(
              style: ambient,
              child: FortalScope(scaling: .percent110, child: probe),
            ),
    ),
  );

  final captured = InheritedTheme.capture(
    from: sourceContext,
    to: tester.element(find.byType(FortalScope).first),
  );
  late ({Color accent, Color gray12, TextStyle text}) result;
  await tester.pumpWidget(
    captured.wrap(
      Builder(
        builder: (context) {
          result = (
            accent: MixScope.tokenOf(FortalTokens.accent9, context),
            gray12: MixScope.tokenOf(FortalTokens.gray12, context),
            text: DefaultTextStyle.of(context).style,
          );

          return const SizedBox();
        },
      ),
    ),
  );

  return result;
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
