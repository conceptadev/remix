import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarbonSize', () {
    test('heights come from the Carbon control-size scale', () {
      expect(CarbonSize.sm.height, 32);
      expect(CarbonSize.md.height, 40);
      expect(CarbonSize.lg.height, 48);
      expect(CarbonSize.x2l.height, 80);
    });

    test('clampTo constrains into a supported range', () {
      expect(
        CarbonSize.xs.clampTo(CarbonSize.sm, CarbonSize.x2l),
        CarbonSize.sm,
      );
      expect(
        CarbonSize.xl.clampTo(CarbonSize.sm, CarbonSize.x2l),
        CarbonSize.xl,
      );
      expect(
        CarbonSize.x2l.clampTo(CarbonSize.sm, CarbonSize.lg),
        CarbonSize.lg,
      );
    });
  });

  group('CarbonLayer', () {
    test('resolves contextual aliases to indexed role tokens', () {
      expect(
        const CarbonLayerData(1).color(CarbonContextualColor.layer),
        CarbonTokens.layer01,
      );
      expect(
        const CarbonLayerData(2).color(CarbonContextualColor.layer),
        CarbonTokens.layer02,
      );
      expect(
        const CarbonLayerData(3).color(CarbonContextualColor.field),
        CarbonTokens.field03,
      );
      expect(
        const CarbonLayerData(1).color(CarbonContextualColor.borderSubtle),
        CarbonTokens.borderSubtle01,
      );
      expect(
        const CarbonLayerData(2).color(CarbonContextualColor.layerAccentHover),
        CarbonTokens.layerAccentHover02,
      );
    });

    testWidgets('a single CarbonLayer steps up from the page (level 1 -> 2)', (
      tester,
    ) async {
      late int single;
      late int nested;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: CarbonLayer(
            child: Builder(
              builder: (context) {
                single = CarbonLayer.levelOf(context);
                return CarbonLayer(
                  child: Builder(
                    builder: (context) {
                      nested = CarbonLayer.levelOf(context);
                      return const SizedBox();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
      expect(single, 2, reason: 'first layer must not be a no-op');
      expect(nested, 3);
    });

    testWidgets('levels clamp at 3', (tester) async {
      late int level;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: CarbonLayer(
            child: CarbonLayer(
              child: CarbonLayer(
                child: Builder(
                  builder: (context) {
                    level = CarbonLayer.levelOf(context);
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      );
      expect(level, 3);
    });
  });

  group('Breakpoints', () {
    test('carbonBreakpointFor returns the active breakpoint', () {
      expect(carbonBreakpointFor(100).name, 'sm');
      expect(carbonBreakpointFor(320).name, 'sm');
      expect(carbonBreakpointFor(700).name, 'md');
      expect(carbonBreakpointFor(1600).name, 'max');
    });
  });

  group('Fluid typography', () {
    test('resolves overrides cumulatively across breakpoints', () {
      expect(CarbonType.resolveFluid('fluidHeading05', 400).fontSize, 32);
      expect(CarbonType.resolveFluid('fluidHeading05', 700).fontSize, 36);
      expect(CarbonType.resolveFluid('fluidHeading05', 1600).fontSize, 60);
    });

    test('throws on an unknown style name in every build mode', () {
      expect(
        () => CarbonType.resolveFluid('fluidHeading99', 400),
        throwsArgumentError,
      );
    });

    testWidgets("fluidTextStyle uses the scope's fontFamily override", (
      tester,
    ) async {
      late TextStyle style;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(700, 800)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CarbonScope(
              overrides: const CarbonThemeOverrides(
                fontFamily: 'IBM Plex Sans',
              ),
              child: Builder(
                builder: (context) {
                  style = CarbonType.fluidTextStyle(context, 'fluidHeading05');
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );
      expect(style.fontFamily, 'IBM Plex Sans');
      expect(style.fontSize, 36);
    });
  });

  group('CarbonMotion', () {
    test('exposes Carbon easing curves', () {
      expect(
        CarbonMotion.curve(
          CarbonMotionIntent.standard,
          CarbonMotionMode.productive,
        ),
        CarbonEasings.standardProductive,
      );
      expect(
        CarbonEasings.standardProductive,
        const Cubic(0.2, 0.0, 0.38, 0.9),
      );
    });

    testWidgets('honors the reduce-motion accessibility setting', (
      tester,
    ) async {
      late bool reduced;
      late Duration resolved;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Builder(
            builder: (context) {
              reduced = CarbonMotion.reducedMotionOf(context);
              resolved = CarbonMotion.duration(
                context,
                const Duration(milliseconds: 240),
              );
              return const SizedBox();
            },
          ),
        ),
      );
      expect(reduced, isTrue);
      expect(resolved, Duration.zero);
    });
  });
}
