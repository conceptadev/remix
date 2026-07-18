import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('Fortal semantic tokens', () {
    testWidgets('resolve to the Radix light and dark semantic colors', (
      tester,
    ) async {
      final light = await _captureFortalTokens(tester, Brightness.light);
      final dark = await _captureFortalTokens(tester, Brightness.dark);

      expect(light.semanticColors, const {
        'background': Color(0xFFFFFFFF),
        'panelSolid': Color(0xFFFFFFFF),
        'panelTranslucent': Color(0xB3FFFFFF),
        'surface': Color(0xD9FFFFFF),
        'overlay': Color(0x66000000),
      });
      expect(dark.semanticColors, const {
        'background': Color(0xFF111113),
        'panelSolid': Color(0xFF18191B),
        'panelTranslucent': Color(0x09D8F4F6),
        'surface': Color(0x40000000),
        'overlay': Color(0x99000000),
      });

      for (final entry in light.semanticColors.entries) {
        expect(
          entry.value,
          isNot(dark.semanticColors[entry.key]),
          reason: '${entry.key} must differ between light and dark modes.',
        );
      }
    });

    testWidgets('bind mode-specific shadow strokes into shadow recipes', (
      tester,
    ) async {
      final light = await _captureFortalTokens(tester, Brightness.light);
      final dark = await _captureFortalTokens(tester, Brightness.dark);

      final expectedLightStroke = Color.lerp(
        slate.light.scale.alphaStep(3),
        slate.light.scale.step(3),
        0.25,
      )!;
      final expectedDarkStroke = Color.lerp(
        slate.dark.scale.alphaStep(6),
        slate.dark.scale.step(6),
        0.25,
      )!;

      expect(light.shadowStroke, expectedLightStroke);
      expect(dark.shadowStroke, expectedDarkStroke);
      expect(light.shadowStroke, isNot(dark.shadowStroke));

      // buildFortalShadows bakes fully-resolved Color values into every
      // BoxShadow layer (not token refs — see the `colors:` parameter it
      // takes), so a shadowStroke-backed layer is pinned by resolved-value
      // equality against the mode's shadowStroke rather than token identity.
      for (final entry in {'light': light, 'dark': dark}.entries) {
        final mode = entry.key;
        final tokens = entry.value;
        expect(
          tokens.shadow2FirstLayerColor,
          tokens.shadowStroke,
          reason: 'shadow2 first layer resolved color ($mode)',
        );
        expect(
          tokens.shadow4FirstLayerColor,
          tokens.shadowStroke,
          reason: 'shadow4 first layer resolved color ($mode)',
        );
        expect(
          tokens.shadow5FirstLayerColor,
          tokens.shadowStroke,
          reason: 'shadow5 first layer resolved color ($mode)',
        );
        expect(
          tokens.shadow6FirstLayerColor,
          tokens.shadowStroke,
          reason: 'shadow6 first layer resolved color ($mode)',
        );
      }

      expect(
        _shadowGeometry(light.shadow3),
        isNot(_shadowGeometry(dark.shadow3)),
      );
      expect(_shadowGeometry(light.shadow3), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 2), blurRadius: 3.0, spreadRadius: -2.0),
        (offset: Offset(0, 3), blurRadius: 12.0, spreadRadius: -4.0),
        (offset: Offset(0, 4), blurRadius: 16.0, spreadRadius: -8.0),
      ]);
      expect(_shadowGeometry(dark.shadow3), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 2), blurRadius: 3.0, spreadRadius: -2.0),
        (offset: Offset(0, 3), blurRadius: 8.0, spreadRadius: -2.0),
        (offset: Offset(0, 4), blurRadius: 12.0, spreadRadius: -4.0),
      ]);

      // shadow1 has no shadowStroke layer: Flutter has no inset-shadow
      // primitive, so buildFortalShadows approximates the CSS inset first
      // layer with a plain gray-alpha outer layer instead (gray alpha step 5
      // light / step 6 dark), followed by mode-specific black/gray layers.
      // The layer *count* also differs (3 in light, 2 in dark).
      final expectedLightShadow1Stroke = slate.light.scale.alphaStep(5);
      final expectedDarkShadow1Stroke = slate.dark.scale.alphaStep(6);

      expect(light.shadow1FirstLayerColor, expectedLightShadow1Stroke);
      expect(dark.shadow1FirstLayerColor, expectedDarkShadow1Stroke);

      expect(
        _shadowGeometry(light.shadow1),
        isNot(_shadowGeometry(dark.shadow1)),
      );
      expect(_shadowGeometry(light.shadow1), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 1.5), blurRadius: 2.0, spreadRadius: 0.0),
        (offset: Offset(0, 1.5), blurRadius: 2.0, spreadRadius: 0.0),
      ]);
      expect(_shadowGeometry(dark.shadow1), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 1), blurRadius: 2.0, spreadRadius: 0.0),
      ]);

      final expectedLightShadow1Colors = [
        slate.light.scale.alphaStep(5),
        slate.light.scale.alphaStep(2),
        blackAlpha[2]!,
      ];
      final expectedDarkShadow1Colors = [
        slate.dark.scale.alphaStep(6),
        blackAlpha[5]!,
      ];
      expect(_shadowColors(light.shadow1), isNot(_shadowColors(dark.shadow1)));
      expect(_shadowColors(light.shadow1), expectedLightShadow1Colors);
      expect(_shadowColors(dark.shadow1), expectedDarkShadow1Colors);

      // shadow4 and shadow5 use identical geometry in both modes; only the
      // mode-specific black/gray alpha steps backing each layer change.
      expect(_shadowGeometry(light.shadow4), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 8), blurRadius: 40.0, spreadRadius: 0.0),
        (offset: Offset(0, 12), blurRadius: 32.0, spreadRadius: -16.0),
      ]);
      expect(_shadowGeometry(dark.shadow4), _shadowGeometry(light.shadow4));

      final expectedLightShadow4Colors = [
        expectedLightStroke,
        blackAlpha[1]!,
        slate.light.scale.alphaStep(3),
      ];
      final expectedDarkShadow4Colors = [
        expectedDarkStroke,
        blackAlpha[3]!,
        blackAlpha[5]!,
      ];
      expect(_shadowColors(light.shadow4), isNot(_shadowColors(dark.shadow4)));
      expect(_shadowColors(light.shadow4), expectedLightShadow4Colors);
      expect(_shadowColors(dark.shadow4), expectedDarkShadow4Colors);

      expect(_shadowGeometry(light.shadow5), const [
        (offset: Offset(0, 0), blurRadius: 0.0, spreadRadius: 1.0),
        (offset: Offset(0, 12), blurRadius: 60.0, spreadRadius: 0.0),
        (offset: Offset(0, 12), blurRadius: 32.0, spreadRadius: -16.0),
      ]);
      expect(_shadowGeometry(dark.shadow5), _shadowGeometry(light.shadow5));

      final expectedLightShadow5Colors = [
        expectedLightStroke,
        blackAlpha[3]!,
        slate.light.scale.alphaStep(5),
      ];
      final expectedDarkShadow5Colors = [
        expectedDarkStroke,
        blackAlpha[5]!,
        blackAlpha[7]!,
      ];
      expect(_shadowColors(light.shadow5), isNot(_shadowColors(dark.shadow5)));
      expect(_shadowColors(light.shadow5), expectedLightShadow5Colors);
      expect(_shadowColors(dark.shadow5), expectedDarkShadow5Colors);
    });
  });
}

Future<_FortalTokenSnapshot> _captureFortalTokens(
  WidgetTester tester,
  Brightness brightness,
) async {
  late _FortalTokenSnapshot snapshot;

  await tester.pumpWidget(
    MaterialApp(
      home: FortalScope(
        brightness: brightness,
        child: Builder(
          builder: (context) {
            final shadow1 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow1, context),
            );
            final shadow2 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow2, context),
            );
            final shadow3 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow3, context),
            );
            final shadow4 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow4, context),
            );
            final shadow5 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow5, context),
            );
            final shadow6 = List<BoxShadow>.unmodifiable(
              MixScope.tokenOf(FortalTokens.shadow6, context),
            );

            snapshot = _FortalTokenSnapshot(
              background: MixScope.tokenOf(
                FortalTokens.colorBackground,
                context,
              ),
              panelSolid: MixScope.tokenOf(
                FortalTokens.colorPanelSolid,
                context,
              ),
              panelTranslucent: MixScope.tokenOf(
                FortalTokens.colorPanelTranslucent,
                context,
              ),
              surface: MixScope.tokenOf(FortalTokens.colorSurface, context),
              overlay: MixScope.tokenOf(FortalTokens.colorOverlay, context),
              shadowStroke: MixScope.tokenOf(
                FortalTokens.shadowStroke,
                context,
              ),
              shadow1: shadow1,
              shadow2: shadow2,
              shadow3: shadow3,
              shadow4: shadow4,
              shadow5: shadow5,
              shadow6: shadow6,
              shadow1FirstLayerColor: _resolveColorReference(
                context,
                shadow1.first.color,
              ),
              shadow2FirstLayerColor: _resolveColorReference(
                context,
                shadow2.first.color,
              ),
              shadow4FirstLayerColor: _resolveColorReference(
                context,
                shadow4.first.color,
              ),
              shadow5FirstLayerColor: _resolveColorReference(
                context,
                shadow5.first.color,
              ),
              shadow6FirstLayerColor: _resolveColorReference(
                context,
                shadow6.first.color,
              ),
            );

            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return snapshot;
}

Color _resolveColorReference(BuildContext context, Color color) {
  final token = tokenFromReferenceValue<Color>(color);

  return token == null ? color : MixScope.tokenOf(token, context);
}

List<({Offset offset, double blurRadius, double spreadRadius})> _shadowGeometry(
  List<BoxShadow> shadows,
) {
  return [
    for (final shadow in shadows)
      (
        offset: shadow.offset,
        blurRadius: shadow.blurRadius,
        spreadRadius: shadow.spreadRadius,
      ),
  ];
}

/// Extracts each shadow layer's resolved color, in order.
///
/// buildFortalShadows bakes fully-resolved [Color] values into every
/// [BoxShadow] (it takes the theme's resolved [FortalThemeColors] rather than
/// embedding token refs), so pinning the exact color per layer is what
/// catches a swapped gray/black alpha step for a given brightness — the
/// layer count and geometry alone wouldn't change.
List<Color> _shadowColors(List<BoxShadow> shadows) {
  return [for (final shadow in shadows) shadow.color];
}

class _FortalTokenSnapshot {
  const _FortalTokenSnapshot({
    required this.background,
    required this.panelSolid,
    required this.panelTranslucent,
    required this.surface,
    required this.overlay,
    required this.shadowStroke,
    required this.shadow1,
    required this.shadow2,
    required this.shadow3,
    required this.shadow4,
    required this.shadow5,
    required this.shadow6,
    required this.shadow1FirstLayerColor,
    required this.shadow2FirstLayerColor,
    required this.shadow4FirstLayerColor,
    required this.shadow5FirstLayerColor,
    required this.shadow6FirstLayerColor,
  });

  final Color background;
  final Color panelSolid;
  final Color panelTranslucent;
  final Color surface;
  final Color overlay;
  final Color shadowStroke;
  final List<BoxShadow> shadow1;
  final List<BoxShadow> shadow2;
  final List<BoxShadow> shadow3;
  final List<BoxShadow> shadow4;
  final List<BoxShadow> shadow5;
  final List<BoxShadow> shadow6;
  final Color shadow1FirstLayerColor;
  final Color shadow2FirstLayerColor;
  final Color shadow4FirstLayerColor;
  final Color shadow5FirstLayerColor;
  final Color shadow6FirstLayerColor;

  Map<String, Color> get semanticColors => {
    'background': background,
    'panelSolid': panelSolid,
    'panelTranslucent': panelTranslucent,
    'surface': surface,
    'overlay': overlay,
  };
}
