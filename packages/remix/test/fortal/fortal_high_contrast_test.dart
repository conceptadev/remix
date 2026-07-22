import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('Fortal high-contrast recipes', () {
    testWidgets('solid controls retain dark high-contrast interaction roles', (
      tester,
    ) async {
      for (final state in [WidgetState.hovered, WidgetState.pressed]) {
        final button = await _resolveFortalStyle(
          tester,
          (context) => fortalButtonStyler(highContrast: true).build(context),
          brightness: .dark,
          states: {state},
        );
        final iconButton = await _resolveFortalStyle(
          tester,
          (context) =>
              fortalIconButtonStyler(highContrast: true).build(context),
          brightness: .dark,
          states: {state},
        );

        expect(
          _flexBoxColor(button.spec.container),
          indigo.dark.scale.step(12),
          reason: 'Button ${state.name} background must remain high contrast.',
        );
        expect(_textColor(button.spec.label), slate.dark.scale.step(1));
        expect(
          _boxColor(iconButton.spec.container),
          indigo.dark.scale.step(12),
          reason:
              'Icon button ${state.name} background must remain high contrast.',
        );
        expect(iconButton.spec.icon.spec.color, slate.dark.scale.step(1));
      }
    });

    testWidgets('soft and surface controls retain distinct base fills', (
      tester,
    ) async {
      final softButton = await _resolveFortalStyle(
        tester,
        (context) => fortalButtonStyler(variant: .soft).build(context),
      );
      final surfaceButton = await _resolveFortalStyle(
        tester,
        (context) => fortalButtonStyler(variant: .surface).build(context),
      );
      final softIconButton = await _resolveFortalStyle(
        tester,
        (context) => fortalIconButtonStyler(variant: .soft).build(context),
      );
      final surfaceIconButton = await _resolveFortalStyle(
        tester,
        (context) => fortalIconButtonStyler(variant: .surface).build(context),
      );

      expect(
        _flexBoxColor(softButton.spec.container),
        indigo.light.scale.alphaStep(3),
      );
      expect(_flexBoxColor(surfaceButton.spec.container), indigo.light.surface);
      expect(
        _boxColor(softIconButton.spec.container),
        indigo.light.scale.alphaStep(3),
      );
      expect(_boxColor(surfaceIconButton.spec.container), indigo.light.surface);
    });

    testWidgets('solid interactions meet contrast for every accent and mode', (
      tester,
    ) async {
      for (final brightness in Brightness.values) {
        for (final accent in FortalAccentColor.values) {
          for (final state in [WidgetState.hovered, WidgetState.pressed]) {
            final button = await _resolveFortalStyle(
              tester,
              (context) =>
                  fortalButtonStyler(highContrast: true).build(context),
              accent: accent,
              brightness: brightness,
              states: {state},
            );
            final iconButton = await _resolveFortalStyle(
              tester,
              (context) =>
                  fortalIconButtonStyler(highContrast: true).build(context),
              accent: accent,
              brightness: brightness,
              states: {state},
            );

            final buttonBackground = _flexBoxColor(button.spec.container)!;
            final buttonForeground = _textColor(button.spec.label)!;
            final iconBackground = _boxColor(iconButton.spec.container)!;
            final iconForeground = iconButton.spec.icon.spec.color!;

            expect(
              _contrastRatio(buttonBackground, buttonForeground),
              greaterThanOrEqualTo(4.5),
              reason: '$accent $brightness button ${state.name}',
            );
            expect(
              _contrastRatio(iconBackground, iconForeground),
              greaterThanOrEqualTo(3.0),
              reason: '$accent $brightness icon button ${state.name}',
            );
          }
        }
      }
    });

    testWidgets('icon button variants resolve stronger accent roles', (
      tester,
    ) async {
      for (final variant in FortalIconButtonVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalIconButtonStyler(variant: variant).build(context),
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalIconButtonStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
        );

        if (variant == .solid || variant == .classic) {
          expect(_boxColor(normal.spec.container), indigo.light.scale.step(9));
          expect(
            _boxColor(highContrast.spec.container),
            indigo.light.scale.step(12),
          );
          expect(normal.spec.icon.spec.color, indigo.light.contrast);
          expect(highContrast.spec.icon.spec.color, slate.light.scale.step(1));
        } else {
          expect(normal.spec.icon.spec.color, indigo.light.scale.alphaStep(11));
          expect(
            highContrast.spec.icon.spec.color,
            indigo.light.scale.step(12),
          );
        }
      }
    });

    testWidgets('badge variants resolve stronger accent roles', (tester) async {
      for (final variant in FortalBadgeVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalBadgeStyler(variant: variant).build(context),
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalBadgeStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
        );

        if (variant == .solid) {
          expect(_boxColor(normal.spec.container), indigo.light.scale.step(9));
          expect(
            _boxColor(highContrast.spec.container),
            indigo.light.scale.step(12),
          );
          expect(_textColor(normal.spec.label), indigo.light.contrast);
          expect(
            _textColor(highContrast.spec.label),
            indigo.light.scale.step(1),
          );
        } else {
          expect(
            _textColor(normal.spec.label),
            indigo.light.scale.alphaStep(11),
          );
          expect(
            _textColor(highContrast.spec.label),
            indigo.light.scale.step(12),
          );
        }
      }
    });

    testWidgets('callout variants resolve accent12 foregrounds', (
      tester,
    ) async {
      for (final variant in FortalCalloutVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalCalloutStyler(variant: variant).build(context),
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalCalloutStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
        );

        expect(_textColor(normal.spec.text), indigo.light.scale.alphaStep(11));
        expect(_textColor(highContrast.spec.text), indigo.light.scale.step(12));
        expect(normal.spec.icon.spec.color, indigo.light.scale.alphaStep(11));
        expect(highContrast.spec.icon.spec.color, indigo.light.scale.step(12));
      }
    });

    testWidgets('selected checkbox variants resolve stronger roles', (
      tester,
    ) async {
      for (final variant in FortalCheckboxVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalCheckboxStyler(variant: variant).build(context),
          states: {WidgetState.selected},
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalCheckboxStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
          states: {WidgetState.selected},
        );

        if (variant == .classic || variant == .surface) {
          expect(_boxColor(normal.spec.container), indigo.light.indicator);
          expect(
            _boxColor(highContrast.spec.container),
            indigo.light.scale.step(12),
          );
          expect(normal.spec.indicator.spec.color, indigo.light.contrast);
          expect(
            highContrast.spec.indicator.spec.color,
            indigo.light.scale.step(1),
          );
        } else {
          expect(
            normal.spec.indicator.spec.color,
            indigo.light.scale.alphaStep(11),
          );
          expect(
            highContrast.spec.indicator.spec.color,
            indigo.light.scale.step(12),
          );
        }
      }
    });

    testWidgets('selected radio variants resolve stronger roles', (
      tester,
    ) async {
      for (final variant in FortalRadioVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalRadioStyler(variant: variant).build(context),
          states: {WidgetState.selected},
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalRadioStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
          states: {WidgetState.selected},
        );

        if (variant == .classic || variant == .surface) {
          expect(_boxColor(normal.spec.container), indigo.light.indicator);
          expect(
            _boxColor(highContrast.spec.container),
            indigo.light.scale.step(12),
          );
          expect(_boxColor(normal.spec.indicator), indigo.light.contrast);
          expect(
            _boxColor(highContrast.spec.indicator),
            indigo.light.scale.step(1),
          );
        } else {
          expect(_boxColor(normal.spec.indicator), indigo.light.scale.step(11));
          expect(
            _boxColor(highContrast.spec.indicator),
            indigo.light.scale.step(12),
          );
        }
      }
    });

    testWidgets('selected switch variants resolve accent12 tracks', (
      tester,
    ) async {
      for (final variant in FortalSwitchVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalSwitchStyler(variant: variant).build(context),
          states: {WidgetState.selected},
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalSwitchStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
          states: {WidgetState.selected},
        );

        final expectedNormal = switch (variant) {
          .classic || .surface => indigo.light.track,
          .soft => indigo.light.scale.alphaStep(4),
        };
        final expectedHighContrast = switch (variant) {
          .classic || .surface => indigo.light.scale.step(12),
          .soft => indigo.light.scale.alphaStep(6),
        };
        expect(_boxColor(normal.spec.container), expectedNormal);
        expect(_boxColor(highContrast.spec.container), expectedHighContrast);
      }
    });

    testWidgets('selected switches retain the exact white Radix thumb', (
      tester,
    ) async {
      for (final variant in FortalSwitchVariant.values) {
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalSwitchStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
          brightness: .dark,
          states: {WidgetState.selected},
        );

        expect(
          _boxColor(highContrast.spec.thumb),
          Colors.white,
          reason: '$variant must contrast with its accent12 track.',
        );
      }
    });

    testWidgets('selected toggle variants resolve accent12 foregrounds', (
      tester,
    ) async {
      for (final variant in FortalToggleVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalToggleStyler(variant: variant).build(context),
          states: {WidgetState.selected},
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalToggleStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
          states: {WidgetState.selected},
        );

        final expectedNormal = switch (variant) {
          .ghost => indigo.light.scale.step(11),
          .outline => indigo.light.scale.step(11),
        };
        expect(_textColor(normal.spec.label), expectedNormal);
        expect(
          _textColor(highContrast.spec.label),
          indigo.light.scale.step(12),
        );
      }
    });

    testWidgets('select owns contrast on solid content, not its trigger', (
      tester,
    ) async {
      final normal = await _resolveFortalStyle(
        tester,
        (context) => fortalSelectStyler(
          triggerVariant: .soft,
          contentVariant: .solid,
        ).build(context),
      );
      final highContrast = await _resolveFortalStyle(
        tester,
        (context) => fortalSelectStyler(
          triggerVariant: .soft,
          contentVariant: .solid,
          contentHighContrast: true,
        ).build(context),
      );

      expect(
        _textColor(normal.spec.trigger.spec.label),
        indigo.light.scale.step(12),
      );
      expect(
        _textColor(highContrast.spec.trigger.spec.label),
        indigo.light.scale.step(12),
      );
      expect(
        normal.spec.trigger.spec.icon.spec.color,
        indigo.light.scale.step(12),
      );
      expect(
        highContrast.spec.trigger.spec.icon.spec.color,
        indigo.light.scale.step(12),
      );

      final hoveredNormal = await _resolveFortalStyle(
        tester,
        (context) => fortalSelectStyler(
          triggerVariant: .soft,
          contentVariant: .solid,
        ).build(context),
        states: {WidgetState.hovered},
      );
      final hoveredHighContrast = await _resolveFortalStyle(
        tester,
        (context) => fortalSelectStyler(
          triggerVariant: .soft,
          contentVariant: .solid,
          contentHighContrast: true,
        ).build(context),
        states: {WidgetState.hovered},
      );
      expect(
        _textColor(hoveredNormal.spec.item.spec.text),
        indigo.light.contrast,
      );
      expect(
        _textColor(hoveredHighContrast.spec.item.spec.text),
        indigo.light.scale.step(1),
      );
      expect(
        hoveredNormal.spec.item.spec.icon.spec.color,
        indigo.light.contrast,
      );
      expect(
        hoveredHighContrast.spec.item.spec.icon.spec.color,
        indigo.light.scale.step(1),
      );
    });

    testWidgets('slider variants resolve accent12 ranges', (tester) async {
      for (final variant in FortalSliderVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalSliderStyler(variant: variant).build(context),
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalSliderStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
        );

        final expectedNormal = switch (variant) {
          .classic || .surface => indigo.light.indicator,
          .soft => indigo.light.scale.step(6),
        };
        expect(_boxColor(normal.spec.range), expectedNormal);
        final contrastGradient =
            highContrast.spec.rangeEffects!.background!.gradients.last
                as LinearGradient;
        expect(contrastGradient.colors, everyElement(blackAlpha[8]));
      }
    });

    testWidgets('progress variants resolve accent12 indicators', (
      tester,
    ) async {
      for (final variant in FortalProgressVariant.values) {
        final normal = await _resolveFortalStyle(
          tester,
          (context) => fortalProgressStyler(variant: variant).build(context),
        );
        final highContrast = await _resolveFortalStyle(
          tester,
          (context) => fortalProgressStyler(
            variant: variant,
            highContrast: true,
          ).build(context),
        );

        final expectedNormal = switch (variant) {
          .classic || .surface => indigo.light.indicator,
          .soft => indigo.light.scale.step(8),
        };
        expect(_boxColor(normal.spec.indicator), expectedNormal);
        expect(
          _boxColor(highContrast.spec.indicator),
          indigo.light.scale.step(12),
        );
      }
    });

    testWidgets('progress variants respect the configured radius scale', (
      tester,
    ) async {
      for (final variant in FortalProgressVariant.values) {
        final style = await _resolveFortalStyle(
          tester,
          (context) => fortalProgressStyler(variant: variant).build(context),
          radius: .none,
        );

        expect(_boxBorderRadius(style.spec.indicator), BorderRadius.zero);
        expect(_boxBorderRadius(style.spec.container), BorderRadius.zero);
      }
    });

    testWidgets('selected tabs resolve an accent12 underline', (tester) async {
      final normal = await _resolveFortalStyle(
        tester,
        (context) => fortalTabStyler().build(context),
        states: {WidgetState.selected},
      );
      final highContrast = await _resolveFortalStyle(
        tester,
        (context) => fortalTabStyler(highContrast: true).build(context),
        states: {WidgetState.selected},
      );

      expect(_tabUnderlineColor(normal), const Color(0xFF3E63DD));
      expect(_tabUnderlineColor(highContrast), const Color(0xFF1F2D5C));
    });
  });
}

Future<T> _resolveFortalStyle<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve, {
  FortalAccentColor accent = .indigo,
  Brightness brightness = .light,
  FortalRadius radius = .medium,
  Set<WidgetState> states = const {},
}) async {
  late T style;

  await tester.pumpWidget(
    FortalScope(
      accentColor: accent,
      appearance: brightness == .dark ? .dark : .light,
      radius: radius,
      child: MaterialApp(
        home: WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              style = resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );

  return style;
}

Color? _boxColor(StyleSpec<BoxSpec> style) =>
    (style.spec.decoration as BoxDecoration?)?.color;

Color? _flexBoxColor(StyleSpec<FlexBoxSpec> style) =>
    (style.spec.box?.spec.decoration as BoxDecoration?)?.color;

BorderRadiusGeometry? _boxBorderRadius(StyleSpec<BoxSpec> style) =>
    switch (style.spec.decoration) {
      BoxDecoration(:final borderRadius) => borderRadius,
      ShapeDecoration(shape: RoundedRectangleBorder(:final borderRadius)) =>
        borderRadius,
      _ => null,
    };

double _contrastRatio(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final lighter = firstLuminance > secondLuminance
      ? firstLuminance
      : secondLuminance;
  final darker = firstLuminance > secondLuminance
      ? secondLuminance
      : firstLuminance;

  return (lighter + 0.05) / (darker + 0.05);
}

Color? _textColor(StyleSpec<TextSpec> style) => style.spec.style?.color;

Color? _tabUnderlineColor(StyleSpec<RemixTabSpec> style) {
  final modifiers = style.widgetModifiers?.whereType<BoxModifier>().toList();
  final decoration = modifiers?.single.spec.decoration as BoxDecoration?;
  final border = decoration?.border;

  return border is Border ? border.bottom.color : null;
}
