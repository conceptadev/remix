import 'package:carbon/carbon.dart';
import 'package:carbon/src/foundation/carbon_theme.dart';
import 'package:carbon/src/tokens/generated/carbon_component_tokens.g.dart';
import 'package:carbon/src/tokens/generated/carbon_layout.g.dart';
import 'package:carbon/src/tokens/generated/carbon_themes.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/mix.dart';

void main() {
  group('Source manifest', () {
    test('records the pinned Carbon baseline', () {
      expect(
        CarbonSourceManifest.carbonCommit,
        '188d23202ec1092322dee92cf0df9d9958224ae4',
      );
      expect(CarbonSourceManifest.license, 'Apache-2.0');
      expect(CarbonSourceManifest.packageVersions['@carbon/themes'], '11.79.0');
    });

    test('inventory counts match the baseline', () {
      expect(CarbonSourceManifest.roleColorCount, 234);
      expect(CarbonSourceManifest.paletteColorCount, 246);
      expect(CarbonSourceManifest.componentTokenCount, 78);
    });
  });

  group('Fixed layout scale', () {
    test('breakpoints match Carbon widths and columns', () {
      final widths = {for (final b in carbonBreakpoints) b.name: b.width};
      expect(widths, {
        'sm': 320.0,
        'md': 672.0,
        'lg': 1056.0,
        'xlg': 1312.0,
        'max': 1584.0,
      });
      expect(carbonBreakpoints.firstWhere((b) => b.name == 'sm').columns, 4);
      expect(carbonBreakpoints.firstWhere((b) => b.name == 'lg').columns, 16);
    });

    test('control sizes span 24..80px and cover every CarbonSize', () {
      expect(carbonControlSizePx['xSmall'], 24);
      expect(carbonControlSizePx['xxLarge'], 80);
      // Guards the enum<->generated-map string bridge: an upstream key rename
      // must fail here, not at first widget build.
      for (final size in CarbonSize.values) {
        expect(size.height, isA<double>(), reason: 'size $size must resolve');
      }
    });
  });

  group('Theme role resolution', () {
    Color colorOf(CarbonTheme theme, ColorToken token) =>
        buildCarbonTokenMap(theme)[token]! as Color;

    test('all four themes expose the same 234 role names', () {
      final white = carbonRoleColorsWhite.keys.toSet();
      expect(white.length, 234);
      for (final roles in [
        carbonRoleColorsG10,
        carbonRoleColorsG90,
        carbonRoleColorsG100,
      ]) {
        expect(roles.keys.toSet(), white);
      }
    });

    test('background/text roles resolve per theme', () {
      expect(
        colorOf(CarbonTheme.white, CarbonTokens.background),
        const Color(0xFFFFFFFF),
      );
      expect(
        colorOf(CarbonTheme.g100, CarbonTokens.background),
        const Color(0xFF161616),
      );
      expect(
        colorOf(CarbonTheme.white, CarbonTokens.textPrimary),
        const Color(0xFF161616),
      );
      expect(
        colorOf(CarbonTheme.g100, CarbonTokens.textPrimary),
        const Color(0xFFF4F4F4),
      );
    });

    test('spacing, type, motion and weight tokens resolve', () {
      final map = buildCarbonTokenMap(CarbonTheme.white);
      expect(map[CarbonTokens.spacing01], 2.0);
      expect(map[CarbonTokens.spacing05], 16.0);
      expect(map[CarbonTokens.spacing13], 160.0);
      expect((map[CarbonTokens.body01]! as TextStyle).fontSize, 14.0);
      expect(
        map[CarbonTokens.durationFast01],
        const Duration(milliseconds: 70),
      );
      expect(map[CarbonTokens.fontWeightRegular], FontWeight.w400);
    });

    test('base maps are cached and unmodifiable', () {
      final a = buildCarbonTokenMap(CarbonTheme.g90);
      final b = buildCarbonTokenMap(CarbonTheme.g90);
      expect(
        identical(a, b),
        isTrue,
        reason: 'no-override builds must reuse the cached base map',
      );
      expect(
        () => a[CarbonTokens.background] = const Color(0x00000000),
        throwsUnsupportedError,
      );
    });

    test('typed overrides win without mutating generated maps', () {
      const override = Color(0xFF00FF00);
      final map = buildCarbonTokenMap(
        CarbonTheme.white,
        overrides: CarbonThemeOverrides(
          colors: {CarbonTokens.background: override},
        ),
      );
      expect(map[CarbonTokens.background], override);
      // Generated map is unchanged.
      expect(
        carbonRoleColorsWhite[CarbonTokens.background],
        const Color(0xFFFFFFFF),
      );
    });

    test('fontFamily override applies to every fixed text style', () {
      final map = buildCarbonTokenMap(
        CarbonTheme.white,
        overrides: const CarbonThemeOverrides(fontFamily: 'IBM Plex Sans'),
      );
      expect(
        (map[CarbonTokens.body01]! as TextStyle).fontFamily,
        'IBM Plex Sans',
      );
      expect(
        (map[CarbonTokens.heading07]! as TextStyle).fontFamily,
        'IBM Plex Sans',
      );
    });
  });

  group('Component tokens', () {
    test('button primary resolves', () {
      expect(
        carbonComponentColorsWhite[CarbonComponentTokens.buttonPrimary],
        const Color(0xFF0F62FE),
      );
    });

    test('partial-theme tokens are omitted, not fabricated', () {
      // notificationActionHover exists only for white + g10 upstream.
      expect(
        carbonComponentColorsWhite.containsKey(
          CarbonComponentTokens.notificationActionHover,
        ),
        isTrue,
      );
      expect(
        carbonComponentColorsG100.containsKey(
          CarbonComponentTokens.notificationActionHover,
        ),
        isFalse,
      );
    });
  });

  group('Indexed role families', () {
    test('CarbonContextualColor covers every generated family', () {
      // If a Carbon upgrade adds an indexed role family (e.g. layerBackground
      // appeared in v11), the alias enum must grow with it.
      final aliasNames = CarbonContextualColor.values
          .map((a) => a.name)
          .toSet();
      expect(aliasNames, carbonIndexedRoleFamilies.keys.toSet());
    });

    test('every alias resolves each of the three levels', () {
      for (final alias in CarbonContextualColor.values) {
        final family = carbonIndexedRoleFamilies[alias.name]!;
        for (var level = 1; level <= 3; level++) {
          expect(CarbonLayerData(level).color(alias), family[level - 1]);
        }
      }
    });
  });

  group('CarbonFontFamilies', () {
    test('exposes usable family names with separate fallbacks', () {
      expect(CarbonFontFamilies.sans, 'IBM Plex Sans');
      expect(CarbonFontFamilies.mono, 'IBM Plex Mono');
      expect(CarbonFontFamilies.sansFallback, contains('sans-serif'));
      // A family name must never be a raw CSS stack.
      expect(CarbonFontFamilies.sans.contains(','), isFalse);
    });
  });
}
