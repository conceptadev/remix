import 'package:flutter/gestures.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_code_fixture/main.dart';
import 'package:open_code_fixture/ui/ui.dart';
import 'package:remix/remix.dart';

void main() {
  group('AcmeThemeData exact values', () {
    test('light carries the declared palette', () {
      const theme = AcmeThemeData.light();

      expect(theme.background, const Color(0xFFFFFFFF));
      expect(theme.foreground, const Color(0xFF171717));
      expect(theme.primary, const Color(0xFF171717));
      expect(theme.primaryForeground, const Color(0xFFFAFAFA));
      expect(theme.secondary, const Color(0xFFF5F5F5));
      expect(theme.secondaryForeground, const Color(0xFF171717));
      expect(theme.muted, const Color(0xFFF5F5F5));
      expect(theme.mutedForeground, const Color(0xFF737373));
      expect(theme.accent, const Color(0xFFE5E5E5));
      expect(theme.accentForeground, const Color(0xFF171717));
      expect(theme.destructive, const Color(0xFFB91C1C));
      expect(theme.destructiveForeground, const Color(0xFFFFFFFF));
      expect(theme.border, const Color(0xFFE5E5E5));
      expect(theme.focusRing, const Color(0xFF737373));
      expect(theme.radius, const Radius.circular(8));
    });

    test('dark carries the declared palette', () {
      const theme = AcmeThemeData.dark();

      expect(theme.background, const Color(0xFF0A0A0A));
      expect(theme.foreground, const Color(0xFFFAFAFA));
      expect(theme.primary, const Color(0xFFFAFAFA));
      expect(theme.primaryForeground, const Color(0xFF171717));
      expect(theme.secondary, const Color(0xFF262626));
      expect(theme.secondaryForeground, const Color(0xFFFAFAFA));
      expect(theme.muted, const Color(0xFF262626));
      expect(theme.mutedForeground, const Color(0xFFA3A3A3));
      expect(theme.accent, const Color(0xFF404040));
      expect(theme.accentForeground, const Color(0xFFFAFAFA));
      expect(theme.destructive, const Color(0xFFDC2626));
      expect(theme.destructiveForeground, const Color(0xFFFFFFFF));
      expect(theme.border, const Color(0xFF404040));
      expect(theme.focusRing, const Color(0xFFA3A3A3));
      expect(theme.radius, const Radius.circular(8));
    });

    test('every declared token has a value and nothing else is exported', () {
      for (final theme in const [AcmeThemeData.light(), AcmeThemeData.dark()]) {
        final tokens = theme.tokens;

        expect(AcmeTokens.colors, hasLength(14));
        expect(tokens, hasLength(AcmeTokens.colors.length + 1));
        expect(tokens.keys.toSet(), <MixToken<Object?>>{
          ...AcmeTokens.colors,
          AcmeTokens.radius,
        });
        for (final token in AcmeTokens.colors) {
          expect(tokens[token], isA<Color>(), reason: token.name);
        }
        expect(tokens[AcmeTokens.radius], theme.radius);
      }
    });

    test('the token map cannot be mutated in place', () {
      final tokens = const AcmeThemeData.light().tokens;

      expect(
        () => tokens[AcmeTokens.background] = const Color(0xFF00FF00),
        throwsUnsupportedError,
      );
      expect(() => tokens.remove(AcmeTokens.radius), throwsUnsupportedError);
      expect(() => tokens.clear(), throwsUnsupportedError);
    });
  });

  group('AcmeThemeData value semantics', () {
    test('copyWith replaces only what it is given', () {
      const base = AcmeThemeData.light();
      final changed = base.copyWith(
        primary: const Color(0xFF4F46E5),
        radius: const Radius.circular(2),
      );

      expect(changed.primary, const Color(0xFF4F46E5));
      expect(changed.radius, const Radius.circular(2));
      expect(changed.background, base.background);
      expect(changed.destructive, base.destructive);
      expect(changed, isNot(base));
    });

    test('copyWith with no arguments is an equal value', () {
      const base = AcmeThemeData.dark();

      expect(base.copyWith(), base);
      expect(base.copyWith().hashCode, base.hashCode);
    });

    test('equality and hashCode cover every field', () {
      const light = AcmeThemeData.light();

      expect(light, const AcmeThemeData.light());
      expect(light.hashCode, const AcmeThemeData.light().hashCode);
      expect(light, isNot(const AcmeThemeData.dark()));

      // One probe per field: a forgotten field in `==` would let one of these
      // compare equal to the untouched theme.
      final probes = <AcmeThemeData>[
        light.copyWith(background: const Color(0xFF000001)),
        light.copyWith(foreground: const Color(0xFF000002)),
        light.copyWith(primary: const Color(0xFF000003)),
        light.copyWith(primaryForeground: const Color(0xFF000004)),
        light.copyWith(secondary: const Color(0xFF000005)),
        light.copyWith(secondaryForeground: const Color(0xFF000006)),
        light.copyWith(muted: const Color(0xFF000007)),
        light.copyWith(mutedForeground: const Color(0xFF000008)),
        light.copyWith(accent: const Color(0xFF000009)),
        light.copyWith(accentForeground: const Color(0xFF00000A)),
        light.copyWith(destructive: const Color(0xFF00000B)),
        light.copyWith(destructiveForeground: const Color(0xFF00000C)),
        light.copyWith(border: const Color(0xFF00000D)),
        light.copyWith(focusRing: const Color(0xFF00000E)),
        light.copyWith(radius: const Radius.circular(1)),
      ];

      expect(probes, hasLength(15));
      for (final probe in probes) {
        expect(probe, isNot(light));
      }
      expect(probes.toSet(), hasLength(probes.length));
    });
  });

  group('AcmeTheme inheritance', () {
    testWidgets('of and maybeOf read the installed theme', (tester) async {
      AcmeThemeData? insideMaybe;
      AcmeThemeData? insideOf;
      AcmeThemeData? outsideMaybe;
      Object? outsideError;

      await tester.pumpWidget(
        _host(
          Column(
            children: [
              _Probe((context) => outsideMaybe = AcmeTheme.maybeOf(context)),
              _Probe((context) {
                try {
                  AcmeTheme.of(context);
                } catch (error) {
                  outsideError = error;
                }
              }),
              AcmeThemeScope(
                data: const AcmeThemeData.dark(),
                child: _Probe((context) {
                  insideMaybe = AcmeTheme.maybeOf(context);
                  insideOf = AcmeTheme.of(context);
                }),
              ),
            ],
          ),
        ),
      );

      expect(outsideMaybe, isNull);
      expect(outsideError, isA<FlutterError>());
      expect(insideMaybe, const AcmeThemeData.dark());
      expect(insideOf, const AcmeThemeData.dark());
    });

    testWidgets('a nested scope replaces values for its subtree only', (
      tester,
    ) async {
      final inner = const AcmeThemeData.light().copyWith(
        primary: const Color(0xFF4F46E5),
      );
      late AcmeThemeData outerTheme;
      late Color outerPrimary;
      late AcmeThemeData innerTheme;
      late Color innerPrimary;
      late AcmeThemeData afterTheme;
      late Color afterPrimary;

      await tester.pumpWidget(
        _host(
          AcmeThemeScope(
            data: const AcmeThemeData.light(),
            child: Column(
              children: [
                _Probe((context) {
                  outerTheme = AcmeTheme.of(context);
                  outerPrimary = AcmeTokens.primary.resolve(context);
                }),
                AcmeThemeScope(
                  data: inner,
                  child: _Probe((context) {
                    innerTheme = AcmeTheme.of(context);
                    innerPrimary = AcmeTokens.primary.resolve(context);
                  }),
                ),
                _Probe((context) {
                  afterTheme = AcmeTheme.of(context);
                  afterPrimary = AcmeTokens.primary.resolve(context);
                }),
              ],
            ),
          ),
        ),
      );

      expect(outerTheme, const AcmeThemeData.light());
      expect(outerPrimary, const Color(0xFF171717));
      expect(innerTheme, inner);
      expect(innerPrimary, const Color(0xFF4F46E5));
      expect(afterTheme, const AcmeThemeData.light());
      expect(afterPrimary, const Color(0xFF171717));
    });

    test('updateShouldNotify follows value equality', () {
      const child = SizedBox.shrink();
      const light = AcmeTheme(data: AcmeThemeData.light(), child: child);
      const sameLight = AcmeTheme(data: AcmeThemeData.light(), child: child);
      const dark = AcmeTheme(data: AcmeThemeData.dark(), child: child);

      expect(light.updateShouldNotify(sameLight), isFalse);
      expect(light.updateShouldNotify(dark), isTrue);
    });

    testWidgets('replacing the theme rebuilds dependents and tokens', (
      tester,
    ) async {
      var builds = 0;
      late Color primary;

      Widget app(AcmeThemeData data) => _host(
        AcmeThemeScope(
          data: data,
          child: _Probe((context) {
            builds += 1;
            primary = AcmeTokens.primary.resolve(context);
          }),
        ),
      );

      await tester.pumpWidget(app(const AcmeThemeData.light()));
      expect(primary, const Color(0xFF171717));
      final buildsAfterFirst = builds;

      await tester.pumpWidget(app(const AcmeThemeData.dark()));
      expect(primary, const Color(0xFFFAFAFA));
      expect(builds, greaterThan(buildsAfterFirst));
    });

    testWidgets('InheritedTheme.wrap carries the theme and its tokens', (
      tester,
    ) async {
      Widget? captured;
      AcmeThemeData? capturedTheme;
      Color? capturedPrimary;
      Radius? capturedRadius;

      await tester.pumpWidget(
        _host(
          AcmeThemeScope(
            data: const AcmeThemeData.dark(),
            child: _Probe((context) {
              captured ??= InheritedTheme.captureAll(
                context,
                _Probe((probeContext) {
                  capturedTheme = AcmeTheme.maybeOf(probeContext);
                  capturedPrimary = AcmeTokens.primary.resolve(probeContext);
                  capturedRadius = AcmeTokens.radius.resolve(probeContext);
                }),
              );
            }),
          ),
        ),
      );

      expect(captured, isNotNull);
      expect(capturedTheme, isNull, reason: 'not built inside the scope');

      // Rebuild the captured subtree with no scope above it: `wrap` has to
      // reinstall both halves, or the tokens resolve against nothing.
      await tester.pumpWidget(_host(captured!));

      expect(capturedTheme, const AcmeThemeData.dark());
      expect(capturedPrimary, const Color(0xFFFAFAFA));
      expect(capturedRadius, const Radius.circular(8));
    });
  });

  group('acmeButtonStyle variants', () {
    for (final theme in _themes) {
      testWidgets('primary resolves its fill and content in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveStyle(
          tester,
          theme: theme.data,
          variant: AcmeButtonVariant.primary,
        );

        expect(_background(spec), theme.data.primary);
        _expectContent(spec, theme.data.primaryForeground);
        expect(_border(spec), isNull);
        expect(_borderRadius(spec), BorderRadius.all(theme.data.radius));
      });

      testWidgets('secondary resolves its fill and content in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveStyle(
          tester,
          theme: theme.data,
          variant: AcmeButtonVariant.secondary,
        );

        expect(_background(spec), theme.data.secondary);
        _expectContent(spec, theme.data.secondaryForeground);
        expect(_border(spec), isNull);
        expect(_borderRadius(spec), BorderRadius.all(theme.data.radius));
      });

      testWidgets(
        'destructive resolves its fill and content in ${theme.name}',
        (tester) async {
          final spec = await _resolveStyle(
            tester,
            theme: theme.data,
            variant: AcmeButtonVariant.destructive,
          );

          expect(_background(spec), theme.data.destructive);
          _expectContent(spec, theme.data.destructiveForeground);
          expect(_border(spec), isNull);
          expect(_borderRadius(spec), BorderRadius.all(theme.data.radius));
        },
      );

      testWidgets('outline is transparent with a 1px border in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveStyle(
          tester,
          theme: theme.data,
          variant: AcmeButtonVariant.outline,
        );

        expect(_background(spec), const Color(0x00000000));
        _expectContent(spec, theme.data.foreground);
        expect(_border(spec), Border.all(color: theme.data.border, width: 1));
        expect(_borderRadius(spec), BorderRadius.all(theme.data.radius));
      });

      testWidgets('ghost is transparent and borderless in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveStyle(
          tester,
          theme: theme.data,
          variant: AcmeButtonVariant.ghost,
        );

        expect(_background(spec), const Color(0x00000000));
        _expectContent(spec, theme.data.foreground);
        expect(_border(spec), isNull);
        expect(_borderRadius(spec), BorderRadius.all(theme.data.radius));
      });
    }

    testWidgets('every variant resolves a distinct idle appearance', (
      tester,
    ) async {
      final appearances = <String>{};
      for (final variant in AcmeButtonVariant.values) {
        final spec = await _resolveStyle(
          tester,
          theme: const AcmeThemeData.light(),
          variant: variant,
        );
        appearances.add(
          '${_background(spec)}/${_labelColor(spec)}/'
          '${_border(spec)}',
        );
      }

      // ghost and outline share a fill and a content color; the border is the
      // only difference, which is exactly what this asserts.
      expect(appearances, hasLength(AcmeButtonVariant.values.length));
    });
  });

  group('acmeButtonStyle sizes', () {
    const expected = <AcmeButtonSize, _Metrics>{
      AcmeButtonSize.small: (
        minHeight: 32.0,
        paddingX: 12.0,
        gap: 6.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      AcmeButtonSize.medium: (
        minHeight: 36.0,
        paddingX: 16.0,
        gap: 8.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      AcmeButtonSize.large: (
        minHeight: 40.0,
        paddingX: 20.0,
        gap: 8.0,
        labelSize: 16.0,
        iconSize: 18.0,
      ),
    };

    test('every size is covered', () {
      expect(expected.keys, containsAll(AcmeButtonSize.values));
      expect(expected, hasLength(AcmeButtonSize.values.length));
    });

    for (final entry in expected.entries) {
      testWidgets('${entry.key.name} has its exact metrics', (tester) async {
        final spec = await _resolveStyle(
          tester,
          theme: const AcmeThemeData.light(),
          size: entry.key,
        );
        final metrics = entry.value;

        expect(_minHeight(spec), metrics.minHeight);
        expect(
          _padding(spec),
          EdgeInsets.symmetric(horizontal: metrics.paddingX),
        );
        expect(_spacing(spec), metrics.gap);
        expect(spec.spec.label.spec.style?.fontSize, metrics.labelSize);
        expect(spec.spec.label.spec.style?.fontWeight, FontWeight.w500);
        expect(spec.spec.icon.spec.size, metrics.iconSize);
        expect(spec.spec.spinner.spec.size, metrics.iconSize);
      });
    }

    testWidgets('layout and spinner defaults are shared by every size', (
      tester,
    ) async {
      for (final size in AcmeButtonSize.values) {
        final spec = await _resolveStyle(
          tester,
          theme: const AcmeThemeData.light(),
          size: size,
        );
        final flex = spec.spec.container.spec.flex?.spec;

        expect(flex?.direction, Axis.horizontal, reason: size.name);
        expect(flex?.mainAxisSize, MainAxisSize.min, reason: size.name);
        expect(
          flex?.mainAxisAlignment,
          MainAxisAlignment.center,
          reason: size.name,
        );
        expect(
          flex?.crossAxisAlignment,
          CrossAxisAlignment.center,
          reason: size.name,
        );
        expect(spec.spec.spinner.spec.opacity, 0.65, reason: size.name);
        expect(
          spec.spec.spinner.spec.duration,
          const Duration(milliseconds: 800),
          reason: size.name,
        );
      }
    });
  });

  group('acmeButtonStyle states', () {
    for (final theme in _themes) {
      testWidgets('filled variants dim their own fill in ${theme.name}', (
        tester,
      ) async {
        final fills = <AcmeButtonVariant, Color>{
          AcmeButtonVariant.primary: theme.data.primary,
          AcmeButtonVariant.secondary: theme.data.secondary,
          AcmeButtonVariant.destructive: theme.data.destructive,
        };

        for (final entry in fills.entries) {
          final hovered = await _resolveStyle(
            tester,
            theme: theme.data,
            variant: entry.key,
            states: const {WidgetState.hovered},
          );
          final pressed = await _resolveStyle(
            tester,
            theme: theme.data,
            variant: entry.key,
            states: const {WidgetState.pressed},
          );

          expect(
            _background(hovered),
            entry.value.withValues(alpha: 0.9),
            reason: '${entry.key.name} hovered',
          );
          expect(
            _background(pressed),
            entry.value.withValues(alpha: 0.8),
            reason: '${entry.key.name} pressed',
          );
        }
      });

      testWidgets('outline and ghost hover onto accent in ${theme.name}', (
        tester,
      ) async {
        for (final variant in const [
          AcmeButtonVariant.outline,
          AcmeButtonVariant.ghost,
        ]) {
          final hovered = await _resolveStyle(
            tester,
            theme: theme.data,
            variant: variant,
            states: const {WidgetState.hovered},
          );
          final pressed = await _resolveStyle(
            tester,
            theme: theme.data,
            variant: variant,
            states: const {WidgetState.pressed},
          );

          expect(
            _background(hovered),
            theme.data.accent,
            reason: '${variant.name} hovered',
          );
          _expectContent(hovered, theme.data.accentForeground);
          expect(
            _background(pressed),
            theme.data.accent.withValues(alpha: 0.8),
            reason: '${variant.name} pressed',
          );
        }
      });

      testWidgets('focus-visible draws the ring in ${theme.name}', (
        tester,
      ) async {
        final focused = await _resolveStyle(
          tester,
          theme: theme.data,
          states: const {WidgetState.focused},
        );
        final effects = focused.spec.containerEffects;

        expect(effects, isNotNull);
        expect(effects!.outline.color, theme.data.focusRing);
        expect(effects.outline.width, 2);
        expect(effects.outline.strokeAlign, BorderSide.strokeAlignInside);
        expect(effects.outline.style, BorderStyle.solid);
        expect(effects.outlineOffset, 2);
      });
    }

    testWidgets('idle draws no ring', (tester) async {
      final idle = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
      );

      expect(idle.spec.containerEffects?.outline.width ?? 0, 0);
    });

    testWidgets('focus-visible needs traditional highlight modality', (
      tester,
    ) async {
      final touchFocused = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.focused},
        highlightStrategy: FocusHighlightStrategy.alwaysTouch,
      );

      expect(touchFocused.spec.containerEffects?.outline.width ?? 0, 0);
    });

    testWidgets('disabled fades the control and clears the ring', (
      tester,
    ) async {
      final disabled = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.disabled},
      );

      expect(
        disabled.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
      expect(disabled.spec.containerEffects?.outline.style, BorderStyle.none);
    });

    testWidgets('pressed wins over hovered', (tester) async {
      const theme = AcmeThemeData.light();
      final both = await _resolveStyle(
        tester,
        theme: theme,
        states: const {WidgetState.hovered, WidgetState.pressed},
      );

      expect(_background(both), theme.primary.withValues(alpha: 0.8));
    });

    testWidgets('disabled wins over focus-visible', (tester) async {
      final both = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(both.spec.containerEffects?.outline.style, BorderStyle.none);
      expect(
        both.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });
  });

  group('enabled contrast is at least 4.5:1 over the page background', () {
    for (final theme in _themes) {
      for (final variant in AcmeButtonVariant.values) {
        for (final state in const <({String name, Set<WidgetState> states})>[
          (name: 'idle', states: <WidgetState>{}),
          (name: 'hovered', states: {WidgetState.hovered}),
          (name: 'pressed', states: {WidgetState.pressed}),
        ]) {
          testWidgets('${theme.name} ${variant.name} ${state.name}', (
            tester,
          ) async {
            final spec = await _resolveStyle(
              tester,
              theme: theme.data,
              variant: variant,
              states: state.states,
            );
            final fill = _background(spec);
            final label = _labelColor(spec);

            expect(fill, isNotNull);
            expect(label, isNotNull);

            // The control paints onto the page, and the label paints onto
            // the control: compositing both is what a reader actually sees.
            final surface = Color.alphaBlend(fill!, theme.data.background);
            final content = Color.alphaBlend(label!, surface);

            expect(
              _contrastRatio(content, surface),
              greaterThanOrEqualTo(4.5),
              reason: '${theme.name}/${variant.name}/${state.name}',
            );
            expect(_iconColor(spec), label);
            expect(_spinnerColor(spec), label);
          });
        }
      }
    }
  });

  group('customization', () {
    testWidgets('a theme-wide copyWith restyles every button', (tester) async {
      final branded = const AcmeThemeData.light().copyWith(
        primary: const Color(0xFF4F46E5),
        primaryForeground: const Color(0xFFFFFFFF),
        radius: const Radius.circular(2),
      );

      final spec = await _resolveStyle(tester, theme: branded);

      expect(_background(spec), const Color(0xFF4F46E5));
      expect(_labelColor(spec), const Color(0xFFFFFFFF));
      expect(_borderRadius(spec), const BorderRadius.all(Radius.circular(2)));
    });

    testWidgets('a recipe-wide wrapper stays a plain function call', (
      tester,
    ) async {
      // "Recipe-wide" is not a framework concept here: the recipe is a
      // function, so an application-wide tweak is a function that calls it.
      ButtonStyler compactButtonStyle({
        AcmeButtonVariant variant = AcmeButtonVariant.primary,
      }) => acmeButtonStyle(
        variant: variant,
        size: AcmeButtonSize.small,
        style: ButtonStyler().padding(.horizontal(4)),
      );

      final spec = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        styler: compactButtonStyle(variant: AcmeButtonVariant.ghost),
      );

      expect(_minHeight(spec), 32);
      expect(_padding(spec), const EdgeInsets.symmetric(horizontal: 4));
      expect(_labelColor(spec), const AcmeThemeData.light().foreground);
    });

    testWidgets('the caller style merges last', (tester) async {
      final spec = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        style: ButtonStyler()
            .color(const Color(0xFF7C3AED))
            .minHeight(48)
            .label(.color(const Color(0xFFFFFF00))),
      );

      expect(_background(spec), const Color(0xFF7C3AED));
      expect(_minHeight(spec), 48);
      expect(_labelColor(spec), const Color(0xFFFFFF00));
      // Untouched recipe values survive.
      expect(_spacing(spec), 8);
      expect(spec.spec.spinner.spec.opacity, 0.65);
    });

    testWidgets('an idle override does not reach the hover fragment', (
      tester,
    ) async {
      const theme = AcmeThemeData.light();
      final style = ButtonStyler().color(const Color(0xFF7C3AED));

      final idle = await _resolveStyle(tester, theme: theme, style: style);
      final hovered = await _resolveStyle(
        tester,
        theme: theme,
        style: style,
        states: const {WidgetState.hovered},
      );

      expect(_background(idle), const Color(0xFF7C3AED));
      // The recipe's hover fragment still wins while hovered: state overrides
      // need a matching state fragment.
      expect(_background(hovered), theme.primary.withValues(alpha: 0.9));
    });

    testWidgets('a matching state fragment does override the recipe', (
      tester,
    ) async {
      final hovered = await _resolveStyle(
        tester,
        theme: const AcmeThemeData.light(),
        style: ButtonStyler().onHovered(
          ButtonStyler().color(const Color(0xFF5B21B6)),
        ),
        states: const {WidgetState.hovered},
      );

      expect(_background(hovered), const Color(0xFF5B21B6));
    });
  });

  group('AcmeButton generated API', () {
    testWidgets('the unnamed constructor takes dynamic values', (tester) async {
      for (final variant in AcmeButtonVariant.values) {
        for (final size in AcmeButtonSize.values) {
          await _pumpInScope(
            tester,
            AcmeButton(variant: variant, size: size, label: 'Go'),
          );

          final widget = tester.widget<AcmeButton>(find.byType(AcmeButton));
          expect(widget.variant, variant);
          expect(widget.size, size);
          expect(
            tester.widget<RemixButton>(find.byType(RemixButton)).style,
            acmeButtonStyle(variant: variant, size: size),
          );
        }
      }
    });

    testWidgets('every named variant constructor pins its own variant', (
      tester,
    ) async {
      final named = <AcmeButtonVariant, AcmeButton>{
        AcmeButtonVariant.primary: const AcmeButton.primary(label: 'Go'),
        AcmeButtonVariant.secondary: const AcmeButton.secondary(label: 'Go'),
        AcmeButtonVariant.outline: const AcmeButton.outline(label: 'Go'),
        AcmeButtonVariant.ghost: const AcmeButton.ghost(label: 'Go'),
        AcmeButtonVariant.destructive: const AcmeButton.destructive(
          label: 'Go',
        ),
      };

      expect(named, hasLength(AcmeButtonVariant.values.length));
      expect(named.keys, containsAll(AcmeButtonVariant.values));

      for (final entry in named.entries) {
        await _pumpInScope(tester, entry.value);

        expect(entry.value.variant, entry.key);
        expect(entry.value.size, AcmeButtonSize.medium);
        expect(
          tester.widget<RemixButton>(find.byType(RemixButton)).style,
          acmeButtonStyle(variant: entry.key),
        );
      }
    });

    testWidgets('named constructors still accept size and style', (
      tester,
    ) async {
      await _pumpInScope(
        tester,
        AcmeButton.destructive(
          label: 'Delete',
          size: AcmeButtonSize.large,
          style: ButtonStyler().minHeight(60),
        ),
      );

      final spec = _resolvedSpec(tester);
      expect(_minHeight(spec), 60);
      expect(spec.spec.label.spec.style?.fontSize, 16);
      expect(_background(spec), const AcmeThemeData.light().destructive);
    });

    testWidgets('forwards the complete safe RemixButton surface', (
      tester,
    ) async {
      var pressed = 0;
      var longPressed = 0;
      final focusNode = FocusNode(debugLabel: 'ui-button');
      addTearDown(focusNode.dispose);

      await _pumpInScope(
        tester,
        AcmeButton(
          key: const ValueKey<String>('forwarded'),
          variant: AcmeButtonVariant.outline,
          size: AcmeButtonSize.large,
          style: ButtonStyler().minHeight(44),
          label: 'Save',
          leadingIcon: _leading,
          trailingIcon: _trailing,
          textBuilder: (context, spec, text) =>
              StyledText('<$text>', styleSpec: StyleSpec(spec: spec)),
          leadingIconBuilder: (context, spec, icon) => StyledIcon(
            icon: icon,
            styleSpec: StyleSpec(spec: spec),
          ),
          trailingIconBuilder: (context, spec, icon) => StyledIcon(
            icon: icon,
            styleSpec: StyleSpec(spec: spec),
          ),
          loadingBuilder: (context, spec) => RemixSpinner(styleSpec: spec),
          loading: false,
          enabled: true,
          onPressed: () => pressed += 1,
          onLongPress: () => longPressed += 1,
          focusNode: focusNode,
          autofocus: true,
          enableFeedback: false,
          semanticLabel: 'Save the document',
          semanticHint: 'Writes changes to disk',
          excludeSemantics: false,
          mouseCursor: SystemMouseCursors.grab,
        ),
      );
      await tester.pumpAndSettle();

      final remix = tester.widget<RemixButton>(find.byType(RemixButton));
      expect(remix.key, const ValueKey<String>('forwarded'));
      expect(remix.label, 'Save');
      expect(remix.leadingIcon, _leading);
      expect(remix.trailingIcon, _trailing);
      expect(remix.textBuilder, isNotNull);
      expect(remix.leadingIconBuilder, isNotNull);
      expect(remix.trailingIconBuilder, isNotNull);
      expect(remix.loadingBuilder, isNotNull);
      expect(remix.loading, isFalse);
      expect(remix.enabled, isTrue);
      expect(remix.onPressed, isNotNull);
      expect(remix.onLongPress, isNotNull);
      expect(remix.focusNode, same(focusNode));
      expect(remix.autofocus, isTrue);
      expect(remix.enableFeedback, isFalse);
      expect(remix.semanticLabel, 'Save the document');
      expect(remix.semanticHint, 'Writes changes to disk');
      expect(remix.excludeSemantics, isFalse);
      expect(remix.mouseCursor, SystemMouseCursors.grab);
      // The recipe owns `style`, and raw `styleSpec` is deliberately not part
      // of the generated surface.
      expect(
        remix.style,
        acmeButtonStyle(
          variant: AcmeButtonVariant.outline,
          size: AcmeButtonSize.large,
          style: ButtonStyler().minHeight(44),
        ),
      );
      expect(remix.styleSpec, isNull);

      // The three content builders render in the idle state. The loading
      // builder is exercised in the dedicated loading test below.
      expect(find.text('<Save>'), findsOneWidget);
      expect(find.byIcon(_leading), findsOneWidget);
      expect(find.byIcon(_trailing), findsOneWidget);
      expect(find.byType(RemixSpinner), findsNothing);
      expect(_minHeight(_resolvedSpec(tester)), 44);
      expect(focusNode.hasFocus, isTrue);
      expect(pressed, 0);
      expect(longPressed, 0);
    });

    testWidgets('forwards and renders the custom loading builder', (
      tester,
    ) async {
      const loadingKey = ValueKey<String>('custom-loading');
      var builds = 0;
      SpinnerSpec? receivedSpec;

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Save',
          loading: true,
          loadingBuilder: (context, spec) {
            builds += 1;
            receivedSpec = spec;

            return const SizedBox(key: loadingKey, width: 16, height: 16);
          },
        ),
      );
      await tester.pump();

      final remix = tester.widget<RemixButton>(find.byType(RemixButton));
      expect(remix.loadingBuilder, isNotNull);
      expect(builds, greaterThan(0));
      expect(receivedSpec?.size, 16);
      expect(find.byKey(loadingKey), findsOneWidget);
      expect(find.byType(RemixSpinner), findsNothing);
    });
  });

  group('AcmeButton delegates behavior to Remix', () {
    testWidgets('press and long-press reach the callbacks', (tester) async {
      var pressed = 0;
      var longPressed = 0;

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Go',
          onPressed: () => pressed += 1,
          onLongPress: () => longPressed += 1,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AcmeButton));
      await tester.pumpAndSettle();
      expect(pressed, 1);

      await tester.longPress(find.byType(AcmeButton));
      await tester.pumpAndSettle();
      expect(longPressed, 1);
    });

    testWidgets('hovering repaints with the hover fill', (tester) async {
      await _pumpInScope(
        tester,
        AcmeButton.primary(label: 'Go', onPressed: () {}),
      );
      await tester.pumpAndSettle();

      expect(
        _background(_resolvedSpec(tester)),
        const AcmeThemeData.light().primary,
      );

      final pointer = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(pointer.removePointer);
      await pointer.addPointer(location: Offset.zero);
      await tester.pump();
      await pointer.moveTo(tester.getCenter(find.byType(AcmeButton)));
      await tester.pumpAndSettle();

      expect(
        _background(_resolvedSpec(tester)),
        const AcmeThemeData.light().primary.withValues(alpha: 0.9),
      );
    });

    testWidgets('focus is delegated to the supplied node', (tester) async {
      final focusNode = FocusNode(debugLabel: 'delegated');
      addTearDown(focusNode.dispose);
      var focusChanges = 0;

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Go',
          focusNode: focusNode,
          onPressed: () => focusChanges += 1,
        ),
      );
      await tester.pumpAndSettle();

      expect(focusNode.hasFocus, isFalse);
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(focusNode.hasFocus, isTrue);
      expect(focusChanges, 0);
    });

    testWidgets('publishes its accessible name, hint, and action', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await _pumpInScope(
        tester,
        AcmeButton.destructive(
          label: 'Delete',
          semanticLabel: 'Delete file',
          semanticHint: 'Removes the file permanently',
          onPressed: () {},
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Delete file')),
        isSemantics(
          label: 'Delete file',
          hint: 'Removes the file permanently',
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          hasTapAction: true,
          hasLongPressAction: false,
        ),
      );
      handle.dispose();
    });

    testWidgets('falls back to the label as the accessible name', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await _pumpInScope(
        tester,
        AcmeButton.primary(label: 'Publish', onPressed: () {}),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Publish'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('excludeSemantics hides the whole control', (tester) async {
      final handle = tester.ensureSemantics();

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Hidden',
          semanticLabel: 'Hidden action',
          excludeSemantics: true,
          onPressed: () {},
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hidden'), findsOneWidget);
      expect(find.bySemanticsLabel('Hidden action'), findsNothing);
      expect(find.bySemanticsLabel('Hidden'), findsNothing);
      handle.dispose();
    });

    testWidgets('a disabled button neither reacts nor advertises a tap', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var pressed = 0;

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Go',
          enabled: false,
          onPressed: () => pressed += 1,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AcmeButton), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(pressed, 0);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Go')),
        isSemantics(
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
        ),
      );
      handle.dispose();
    });

    testWidgets('a loading button shows the Remix spinner and ignores taps', (
      tester,
    ) async {
      var pressed = 0;

      await _pumpInScope(
        tester,
        AcmeButton.primary(
          label: 'Saving',
          loading: true,
          onPressed: () => pressed += 1,
        ),
      );
      await tester.pump();

      expect(find.byType(RemixSpinner), findsOneWidget);

      await tester.tap(find.byType(AcmeButton), warnIfMissed: false);
      await tester.pump();

      expect(pressed, 0);
    });

    testWidgets('loading does not change the footprint', (tester) async {
      for (final size in AcmeButtonSize.values) {
        await _pumpInScope(
          tester,
          AcmeButton(size: size, label: 'Saving', onPressed: () {}),
        );
        await tester.pumpAndSettle();
        final idle = tester.getSize(find.byType(AcmeButton));

        await _pumpInScope(
          tester,
          AcmeButton(
            size: size,
            label: 'Saving',
            loading: true,
            onPressed: () {},
          ),
        );
        await tester.pump();
        final loading = tester.getSize(find.byType(AcmeButton));

        expect(loading, idle, reason: size.name);
        expect(idle.height, greaterThanOrEqualTo(_minHeights[size]!));
      }
    });
  });

  group('acmeCheckboxStyle sizes', () {
    const expected = <AcmeCheckboxSize, _CheckboxMetrics>{
      AcmeCheckboxSize.small: (
        box: 16.0,
        indicator: 10.0,
        gap: 8.0,
        labelSize: 14.0,
      ),
      AcmeCheckboxSize.medium: (
        box: 18.0,
        indicator: 11.0,
        gap: 8.0,
        labelSize: 14.0,
      ),
      AcmeCheckboxSize.large: (
        box: 20.0,
        indicator: 13.0,
        gap: 10.0,
        labelSize: 16.0,
      ),
    };

    test('every size is covered', () {
      expect(expected.keys, containsAll(AcmeCheckboxSize.values));
      expect(expected, hasLength(AcmeCheckboxSize.values.length));
    });

    for (final entry in expected.entries) {
      testWidgets('${entry.key.name} has its exact metrics', (tester) async {
        final spec = await _checkboxSpec(
          tester,
          theme: const AcmeThemeData.light(),
          size: entry.key,
        );
        final metrics = entry.value;

        expect(
          _checkboxConstraints(spec),
          BoxConstraints.tight(Size.square(metrics.box)),
        );
        expect(spec.spec.indicator.spec.size, metrics.indicator);
        expect(spec.spec.labelSpacing, metrics.gap);
        expect(spec.spec.label.spec.style?.fontSize, metrics.labelSize);
        expect(spec.spec.container.spec.alignment, Alignment.center);
      });
    }
  });

  group('acmeCheckboxStyle appearance', () {
    for (final theme in _themes) {
      testWidgets('unchecked reads as an empty outlined box in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(tester, theme: theme.data);

        expect(_checkboxBackground(spec), theme.data.background);
        expect(
          _checkboxBorder(spec),
          Border.all(color: theme.data.border, width: 1),
        );
        expect(spec.spec.label.spec.style?.color, theme.data.foreground);
        // Unchecked renders no indicator at all, so the recipe deliberately
        // leaves its color to the states that can show one.
        expect(spec.spec.indicator.spec.color, isNull);
      });

      testWidgets('checked fills with primary in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(
          tester,
          theme: theme.data,
          selected: true,
        );

        expect(_checkboxBackground(spec), theme.data.primary);
        expect(
          _checkboxBorder(spec),
          Border.all(color: theme.data.primary, width: 1),
        );
        expect(spec.spec.indicator.spec.color, theme.data.primaryForeground);
      });

      testWidgets('the checked glyph clears 4.5:1 in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(
          tester,
          theme: theme.data,
          selected: true,
        );
        final surface = Color.alphaBlend(
          _checkboxBackground(spec)!,
          theme.data.background,
        );
        final glyph = Color.alphaBlend(
          spec.spec.indicator.spec.color!,
          surface,
        );

        expect(_contrastRatio(glyph, surface), greaterThanOrEqualTo(4.5));
      });
    }

    testWidgets('the corner radius is clamped to the box, not the control', (
      tester,
    ) async {
      const light = AcmeThemeData.light();
      final cases = <Radius, Radius>{
        // The shipped themes ask for 8, which a 16-20px box cannot wear.
        light.radius: const Radius.circular(4),
        // A pill theme would otherwise draw a circle, which reads as a radio.
        const Radius.circular(999): const Radius.circular(4),
        // A theme asking for less than the cap still wins.
        const Radius.circular(2): const Radius.circular(2),
        Radius.zero: Radius.zero,
      };

      for (final entry in cases.entries) {
        final spec = await _checkboxSpec(
          tester,
          theme: light.copyWith(radius: entry.key),
        );

        expect(
          _checkboxBorderRadius(spec),
          BorderRadius.all(entry.value),
          reason: '${entry.key}',
        );
      }
    });
  });

  group('acmeCheckboxStyle states', () {
    for (final theme in _themes) {
      testWidgets('an unchecked box hovers onto accent in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(
          tester,
          theme: theme.data,
          hovered: true,
        );

        expect(_checkboxBackground(spec), theme.data.accent);
      });

      testWidgets('a checked box dims its own fill in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(
          tester,
          theme: theme.data,
          selected: true,
          hovered: true,
        );
        final dimmed = theme.data.primary.withValues(alpha: 0.9);

        // The nested hover fragment inside the checked fragment wins over the
        // top-level one: a hovered checked box must not fall back to accent.
        expect(_checkboxBackground(spec), dimmed);
        expect(_checkboxBorder(spec), Border.all(color: dimmed, width: 1));
      });

      testWidgets('focus-visible draws the ring in ${theme.name}', (
        tester,
      ) async {
        final spec = await _checkboxSpec(
          tester,
          theme: theme.data,
          focused: true,
        );
        final effects = spec.spec.containerEffects;

        expect(effects, isNotNull);
        expect(effects!.outline.color, theme.data.focusRing);
        expect(effects.outline.width, 2);
        expect(effects.outline.strokeAlign, BorderSide.strokeAlignInside);
        expect(effects.outline.style, BorderStyle.solid);
        expect(effects.outlineOffset, 2);
      });
    }

    testWidgets('idle draws no ring', (tester) async {
      final spec = await _checkboxSpec(
        tester,
        theme: const AcmeThemeData.light(),
      );

      expect(spec.spec.containerEffects?.outline.width ?? 0, 0);
    });

    testWidgets('focus-visible needs traditional highlight modality', (
      tester,
    ) async {
      final spec = await _checkboxSpec(
        tester,
        theme: const AcmeThemeData.light(),
        focused: true,
        highlightStrategy: FocusHighlightStrategy.alwaysTouch,
      );

      expect(spec.spec.containerEffects?.outline.width ?? 0, 0);
    });

    testWidgets('disabled fades the control and clears the ring', (
      tester,
    ) async {
      final spec = await _checkboxSpec(
        tester,
        theme: const AcmeThemeData.light(),
        enabled: false,
      );

      expect(
        spec.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
      expect(spec.spec.containerEffects?.outline.style, BorderStyle.none);
    });

    testWidgets('disabled wins over focus-visible', (tester) async {
      // Declared last in the recipe, so it beats every earlier fragment. A
      // disabled control is not focusable under traditional traversal, so the
      // ordering is asserted on the styler itself; the fragments below set no
      // colors, which is why a bare resolution is trustworthy here.
      final spec = await _resolve(
        tester,
        acmeCheckboxStyle(),
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(spec.spec.containerEffects?.outline.style, BorderStyle.none);
      expect(
        spec.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });

    testWidgets('indeterminate wears the checked surface', (tester) async {
      const theme = AcmeThemeData.light();
      final spec = await _checkboxSpec(
        tester,
        theme: theme,
        selected: null,
        tristate: true,
      );

      expect(_checkboxBackground(spec), theme.primary);
      expect(spec.spec.indicator.spec.color, theme.primaryForeground);
    });
  });

  group('acmeCheckboxStyle customization', () {
    testWidgets('the caller style merges last', (tester) async {
      final spec = await _checkboxSpec(
        tester,
        theme: const AcmeThemeData.light(),
        style: CheckboxStyler()
            .color(const Color(0xFF7C3AED))
            .label(.color(const Color(0xFFFFFF00))),
      );

      expect(_checkboxBackground(spec), const Color(0xFF7C3AED));
      expect(spec.spec.label.spec.style?.color, const Color(0xFFFFFF00));
      // Untouched recipe values survive.
      expect(spec.spec.labelSpacing, 8);
      expect(spec.spec.indicator.spec.size, 11);
    });

    testWidgets('an idle override does not reach the checked fragment', (
      tester,
    ) async {
      const theme = AcmeThemeData.light();
      final style = CheckboxStyler().color(const Color(0xFF7C3AED));

      final idle = await _checkboxSpec(tester, theme: theme, style: style);
      final checked = await _checkboxSpec(
        tester,
        theme: theme,
        style: style,
        selected: true,
      );

      expect(_checkboxBackground(idle), const Color(0xFF7C3AED));
      expect(_checkboxBackground(checked), theme.primary);
    });

    testWidgets('a matching state fragment does override the recipe', (
      tester,
    ) async {
      final checked = await _checkboxSpec(
        tester,
        theme: const AcmeThemeData.light(),
        style: CheckboxStyler().onSelected(
          CheckboxStyler().color(const Color(0xFF5B21B6)),
        ),
        selected: true,
      );

      expect(_checkboxBackground(checked), const Color(0xFF5B21B6));
    });

    test('a group option resolves the same recipe as a lone checkbox', () {
      for (final size in AcmeCheckboxSize.values) {
        expect(
          acmeCheckboxGroupItemStyle(size: size),
          acmeCheckboxStyle(size: size),
          reason: size.name,
        );
      }
    });
  });

  group('AcmeCheckbox generated API', () {
    testWidgets('forwards the complete safe RemixCheckbox surface', (
      tester,
    ) async {
      final focusNode = FocusNode(debugLabel: 'ui-checkbox');
      addTearDown(focusNode.dispose);

      await _pumpInScope(
        tester,
        AcmeCheckbox(
          key: const ValueKey<String>('forwarded'),
          size: AcmeCheckboxSize.large,
          style: CheckboxStyler().labelSpacing(20),
          selected: null,
          onChanged: (_) {},
          enabled: true,
          tristate: true,
          checkedIcon: _leading,
          uncheckedIcon: _trailing,
          indeterminateIcon: _leading,
          focusNode: focusNode,
          autofocus: true,
          enableFeedback: false,
          label: 'Some selected',
          semanticLabel: 'Partially selected',
          minimumTapTargetSize: const Size.square(44),
          mouseCursor: SystemMouseCursors.grab,
        ),
      );
      await tester.pumpAndSettle();

      final remix = tester.widget<RemixCheckbox>(find.byType(RemixCheckbox));
      expect(remix.key, const ValueKey<String>('forwarded'));
      expect(remix.selected, isNull);
      expect(remix.tristate, isTrue);
      expect(remix.enabled, isTrue);
      expect(remix.onChanged, isNotNull);
      expect(remix.checkedIcon, _leading);
      expect(remix.uncheckedIcon, _trailing);
      expect(remix.indeterminateIcon, _leading);
      expect(remix.focusNode, same(focusNode));
      expect(remix.autofocus, isTrue);
      expect(remix.enableFeedback, isFalse);
      expect(remix.label, 'Some selected');
      expect(remix.semanticLabel, 'Partially selected');
      expect(remix.minimumTapTargetSize, const Size.square(44));
      expect(remix.mouseCursor, SystemMouseCursors.grab);
      expect(
        remix.style,
        acmeCheckboxStyle(
          size: AcmeCheckboxSize.large,
          style: CheckboxStyler().labelSpacing(20),
        ),
      );
      expect(remix.styleSpec, isNull);
      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('toggling reaches the callback and repaints', (tester) async {
      bool? received;

      await _pumpInScope(
        tester,
        AcmeCheckbox(
          selected: false,
          label: 'Email me',
          onChanged: (value) => received = value,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        _checkboxBackground(_resolvedSpecOf<CheckboxSpec>(tester)),
        const AcmeThemeData.light().background,
      );

      await tester.tap(find.byType(AcmeCheckbox));
      await tester.pumpAndSettle();

      expect(received, isTrue);
    });

    testWidgets('publishes checkbox semantics and honours enabled', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      var toggles = 0;

      await _pumpInScope(
        tester,
        AcmeCheckbox(
          selected: true,
          label: 'Email me',
          enabled: false,
          onChanged: (_) => toggles += 1,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AcmeCheckbox), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(toggles, 0);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Email me')),
        isSemantics(
          isChecked: true,
          hasCheckedState: true,
          hasEnabledState: true,
          isEnabled: false,
        ),
      );
      handle.dispose();
    });

    testWidgets('a group option toggles the group set', (tester) async {
      Set<String> values = const {'design'};

      await tester.pumpWidget(
        AcmeThemeScope(
          data: const AcmeThemeData.light(),
          child: _host(
            StatefulBuilder(
              builder: (context, setState) => RemixCheckboxGroup<String>(
                values: values,
                semanticLabel: 'Interests',
                onChanged: (next) => setState(() => values = next),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AcmeCheckboxGroupItem<String>(
                      value: 'design',
                      label: 'Design',
                    ),
                    AcmeCheckboxGroupItem<String>(value: 'code', label: 'Code'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Every option is styled by the recipe without a per-call-site styler.
      for (final provider in tester.widgetList<StyleSpecProvider<CheckboxSpec>>(
        find.byType(StyleSpecProvider<CheckboxSpec>),
      )) {
        expect(provider.spec.spec.labelSpacing, 8);
      }

      await tester.tap(find.text('Code'));
      await tester.pumpAndSettle();

      expect(values, {'design', 'code'});
    });
  });

  group('acmeTabBarStyle and acmeTabViewStyle', () {
    for (final theme in _themes) {
      testWidgets('the strip carries one hairline in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveTabBar(tester, theme: theme.data);
        final flex = spec.spec.container.spec.flex?.spec;

        expect(
          _flexBorder(spec.spec.container),
          Border(bottom: BorderSide(color: theme.data.border, width: 1)),
        );
        expect(flex?.direction, Axis.horizontal);
        // Max, so the rule spans its container rather than stopping at the
        // last tab.
        expect(flex?.mainAxisSize, MainAxisSize.max);
        expect(flex?.crossAxisAlignment, CrossAxisAlignment.end);
      });
    }

    testWidgets('the panel is pushed clear of the strip', (tester) async {
      final spec = await _resolveTabView(
        tester,
        theme: const AcmeThemeData.light(),
      );

      expect(spec.spec.container.spec.padding, const EdgeInsets.only(top: 16));
    });

    testWidgets('both recipes take a caller style that merges last', (
      tester,
    ) async {
      final bar = await _resolveTabBar(
        tester,
        theme: const AcmeThemeData.light(),
        style: TabBarStyler().color(const Color(0xFF7C3AED)),
      );
      final view = await _resolveTabView(
        tester,
        theme: const AcmeThemeData.light(),
        style: TabViewStyler().padding(.top(40)),
      );

      expect(
        _flexDecoration(bar.spec.container)?.color,
        const Color(0xFF7C3AED),
      );
      expect(view.spec.container.spec.padding, const EdgeInsets.only(top: 40));
    });
  });

  group('acmeTabStyle sizes', () {
    const expected = <AcmeTabSize, _Metrics>{
      AcmeTabSize.small: (
        minHeight: 32.0,
        paddingX: 10.0,
        gap: 6.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      AcmeTabSize.medium: (
        minHeight: 36.0,
        paddingX: 12.0,
        gap: 8.0,
        labelSize: 14.0,
        iconSize: 16.0,
      ),
      AcmeTabSize.large: (
        minHeight: 40.0,
        paddingX: 16.0,
        gap: 8.0,
        labelSize: 16.0,
        iconSize: 18.0,
      ),
    };

    test('every size is covered', () {
      expect(expected.keys, containsAll(AcmeTabSize.values));
      expect(expected, hasLength(AcmeTabSize.values.length));
    });

    for (final entry in expected.entries) {
      testWidgets('${entry.key.name} has its exact metrics', (tester) async {
        final spec = await _resolveTab(
          tester,
          theme: const AcmeThemeData.light(),
          size: entry.key,
        );
        final metrics = entry.value;
        final box = spec.spec.container.spec.box?.spec;
        final flex = spec.spec.container.spec.flex?.spec;

        expect(box?.constraints?.minHeight, metrics.minHeight);
        expect(
          box?.padding,
          EdgeInsets.symmetric(horizontal: metrics.paddingX),
        );
        expect(flex?.spacing, metrics.gap);
        expect(spec.spec.label.spec.style?.fontSize, metrics.labelSize);
        expect(spec.spec.label.spec.style?.fontWeight, FontWeight.w500);
        expect(spec.spec.icon.spec.size, metrics.iconSize);
      });
    }
  });

  group('acmeTabStyle states', () {
    for (final theme in _themes) {
      testWidgets('an unselected tab is muted in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveTab(tester, theme: theme.data);

        expect(spec.spec.label.spec.style?.color, theme.data.mutedForeground);
        expect(spec.spec.icon.spec.color, theme.data.mutedForeground);
        // The selected edge is already present, merely transparent, so
        // selecting a tab repaints instead of reflowing the strip.
        expect(
          _flexBorder(spec.spec.container),
          const Border(bottom: BorderSide(color: Color(0x00000000), width: 2)),
        );
      });

      testWidgets('hover promotes the content in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveTab(
          tester,
          theme: theme.data,
          states: const {WidgetState.hovered},
        );

        expect(spec.spec.label.spec.style?.color, theme.data.foreground);
        expect(spec.spec.icon.spec.color, theme.data.foreground);
        expect(_flexDecoration(spec.spec.container)?.color, theme.data.accent);
      });

      testWidgets('the selected tab is marked in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveTab(
          tester,
          theme: theme.data,
          states: const {WidgetState.selected},
        );

        expect(spec.spec.label.spec.style?.color, theme.data.foreground);
        expect(
          _flexBorder(spec.spec.container),
          Border(bottom: BorderSide(color: theme.data.primary, width: 2)),
        );
      });

      testWidgets('a hovered selected tab keeps both marks in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolveTab(
          tester,
          theme: theme.data,
          states: const {WidgetState.selected, WidgetState.hovered},
        );

        expect(_flexDecoration(spec.spec.container)?.color, theme.data.accent);
        expect(
          _flexBorder(spec.spec.container),
          Border(bottom: BorderSide(color: theme.data.primary, width: 2)),
        );
      });

      testWidgets('focus-visible draws a ring that takes no space in '
          '${theme.name}', (tester) async {
        final spec = await _resolveTab(
          tester,
          theme: theme.data,
          states: const {WidgetState.focused},
        );

        // A foreground decoration, because a real border would inset the
        // label; `TabSpec` has no effects layer to paint an outline into.
        expect(
          _flexForegroundBorder(spec.spec.container),
          Border.all(
            color: theme.data.focusRing,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        );
      });
    }

    testWidgets('idle draws no ring', (tester) async {
      final spec = await _resolveTab(
        tester,
        theme: const AcmeThemeData.light(),
      );

      expect(_flexForegroundBorder(spec.spec.container), isNull);
    });

    testWidgets('disabled fades the tab and clears the ring', (tester) async {
      final spec = await _resolveTab(
        tester,
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(
        spec.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
      // Merging leaves the ring's color and width in place and turns its
      // style off, which is what stops Flutter painting it.
      expect(
        (_flexForegroundBorder(spec.spec.container) as Border?)?.top.style,
        BorderStyle.none,
      );
    });

    testWidgets('the caller style merges last', (tester) async {
      final spec = await _resolveTab(
        tester,
        theme: const AcmeThemeData.light(),
        style: TabStyler().color(const Color(0xFF7C3AED)).minHeight(60),
      );

      expect(
        _flexDecoration(spec.spec.container)?.color,
        const Color(0xFF7C3AED),
      );
      expect(spec.spec.container.spec.box?.spec.constraints?.minHeight, 60);
      // Untouched recipe values survive.
      expect(spec.spec.icon.spec.size, 16);
    });
  });

  group('Acme tabs delegate behavior to Remix', () {
    testWidgets('forwards the curated RemixTab surface', (tester) async {
      final focusNode = FocusNode(debugLabel: 'ui-tab');
      addTearDown(focusNode.dispose);

      await _pumpTabs(
        tester,
        selected: 'one',
        tabs: [
          AcmeTab(
            key: const ValueKey<String>('forwarded'),
            size: AcmeTabSize.large,
            style: TabStyler().minHeight(48),
            tabId: 'one',
            label: 'One',
            icon: _leading,
            enabled: true,
            mouseCursor: SystemMouseCursors.grab,
            enableFeedback: false,
            focusNode: focusNode,
            onFocusChange: (_) {},
            onHoverChange: (_) {},
            onPressChange: (_) {},
            semanticLabel: 'First tab',
          ),
        ],
      );
      await tester.pumpAndSettle();

      final remix = tester.widget<RemixTab>(find.byType(RemixTab));
      expect(remix.key, const ValueKey<String>('forwarded'));
      expect(remix.tabId, 'one');
      expect(remix.label, 'One');
      expect(remix.icon, _leading);
      expect(remix.enabled, isTrue);
      expect(remix.mouseCursor, SystemMouseCursors.grab);
      expect(remix.enableFeedback, isFalse);
      expect(remix.focusNode, same(focusNode));
      expect(remix.onFocusChange, isNotNull);
      expect(remix.onHoverChange, isNotNull);
      expect(remix.onPressChange, isNotNull);
      expect(remix.semanticLabel, 'First tab');
      expect(
        remix.style,
        acmeTabStyle(size: AcmeTabSize.large, style: TabStyler().minHeight(48)),
      );
      expect(remix.styleSpec, isNull);
      // `builder` would drag `package:naked_ui` into the adapter, so it is
      // deliberately outside the generated surface.
      expect(remix.builder, isNull);
    });

    testWidgets('selecting a tab reports it and swaps the panel', (
      tester,
    ) async {
      final selections = <String>[];

      await _pumpTabs(
        tester,
        selected: 'one',
        onChanged: selections.add,
        tabs: const [
          AcmeTab(tabId: 'one', label: 'One'),
          AcmeTab(tabId: 'two', label: 'Two'),
        ],
        views: const [
          AcmeTabView(tabId: 'one', child: Text('Panel one')),
          AcmeTabView(tabId: 'two', child: Text('Panel two')),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('Panel one'), findsOneWidget);

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      expect(selections, ['two']);
    });

    testWidgets('a disabled tab is not selectable', (tester) async {
      final selections = <String>[];

      await _pumpTabs(
        tester,
        selected: 'one',
        onChanged: selections.add,
        tabs: const [
          AcmeTab(tabId: 'one', label: 'One'),
          AcmeTab(tabId: 'two', label: 'Two', enabled: false),
        ],
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Two'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(selections, isEmpty);
    });

    testWidgets('the strip publishes a tab bar with named tabs', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await _pumpTabs(
        tester,
        selected: 'one',
        tabs: const [
          AcmeTab(tabId: 'one', label: 'One'),
          AcmeTab(tabId: 'two', label: 'Two', semanticLabel: 'Second'),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('One'), findsOneWidget);
      expect(find.bySemanticsLabel('Second'), findsOneWidget);
      handle.dispose();
    });
  });

  group('the gallery renders every installed component', () {
    // The gallery is the only place the installed widgets are composed the way
    // an application composes them, so it is where a layout mistake — an
    // unbounded vertical divider, a bar that collapses to nothing — actually
    // shows up. A recipe can resolve perfectly and still not lay out.
    for (final size in const [Size(1200, 3000), Size(420, 3000)]) {
      testWidgets('at ${size.width.toInt()}x${size.height.toInt()}', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(const AcmeGalleryApp());
        // Not `pumpAndSettle`: the gallery holds a spinner and a skeleton,
        // and both animate forever by design.
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull);
        expect(find.byType(AcmeThemeSection), findsNWidgets(3));
        for (final finder in [
          find.byType(AcmeButton),
          find.byType(AcmeCheckbox),
          find.byType(AcmeTab),
          find.byType(AcmeBadge),
          find.byType(AcmeIconButton),
          find.byType(AcmeToggle),
          find.byType(AcmeAvatar),
          find.byType(AcmeSpinner),
          find.byType(AcmeLink),
          find.byType(AcmeProgress),
          find.byType(AcmeSkeleton),
          find.byType(AcmeCard),
          find.byType(AcmeCallout),
          find.byType(AcmeDivider),
          find.byType(AcmeSwitch),
          find.byType(AcmeRadio<String>),
          find.byType(AcmeSlider),
          find.byType(AcmeTextField),
          find.byType(AcmeTextArea),
          find.byType(AcmeToggleGroup<String>),
          find.byType(AcmeSegmentedControl<String>),
        ]) {
          expect(finder, findsWidgets);
        }
      });
    }
  });

  group('acmeCardStyle', () {
    for (final theme in _themes) {
      testWidgets('is an outlined surface in ${theme.name}', (tester) async {
        final spec = await _resolve(tester, acmeCardStyle(), theme: theme.data);
        final box = spec.spec.container.spec;

        // The page fill on purpose: a card is told apart by its outline, not
        // by a second surface color. See the recipe's own note.
        expect(_boxBackground(spec.spec.container), theme.data.background);
        expect(
          _boxBorder(spec.spec.container),
          Border.all(color: theme.data.border, width: 1),
        );
        expect(
          _boxBorderRadius(spec.spec.container),
          BorderRadius.all(theme.data.radius),
        );
        expect(box.padding, const EdgeInsets.all(16));
      });
    }

    testWidgets('the caller style merges last', (tester) async {
      final spec = await _resolve(
        tester,
        acmeCardStyle(style: CardStyler().color(const Color(0xFF7C3AED))),
        theme: const AcmeThemeData.light(),
      );

      expect(_boxBackground(spec.spec.container), const Color(0xFF7C3AED));
      expect(spec.spec.container.spec.padding, const EdgeInsets.all(16));
    });

    testWidgets('renders its child inside a RemixCard', (tester) async {
      await _pumpInScope(tester, const AcmeCard(child: Text('Contents')));

      expect(find.byType(RemixCard), findsOneWidget);
      expect(find.text('Contents'), findsOneWidget);
      expect(
        tester.widget<RemixCard>(find.byType(RemixCard)).style,
        acmeCardStyle(),
      );
    });
  });

  group('acmeBadgeStyle', () {
    for (final theme in _themes) {
      for (final entry in <AcmeBadgeVariant, ({Color fill, Color content})>{
        AcmeBadgeVariant.primary: (
          fill: theme.data.primary,
          content: theme.data.primaryForeground,
        ),
        AcmeBadgeVariant.secondary: (
          fill: theme.data.secondary,
          content: theme.data.secondaryForeground,
        ),
        AcmeBadgeVariant.destructive: (
          fill: theme.data.destructive,
          content: theme.data.destructiveForeground,
        ),
        AcmeBadgeVariant.outline: (
          fill: const Color(0x00000000),
          content: theme.data.foreground,
        ),
      }.entries) {
        testWidgets('${entry.key.name} in ${theme.name}', (tester) async {
          final spec = await _resolve(
            tester,
            acmeBadgeStyle(variant: entry.key),
            theme: theme.data,
          );

          expect(_boxBackground(spec.spec.container), entry.value.fill);
          expect(spec.spec.label.spec.style?.color, entry.value.content);
          expect(
            _boxBorder(spec.spec.container),
            entry.key == AcmeBadgeVariant.outline
                ? Border.all(color: theme.data.border, width: 1)
                : isNull,
          );
          // The composited label has to stay readable on the page.
          final surface = Color.alphaBlend(
            entry.value.fill,
            theme.data.background,
          );
          expect(
            _contrastRatio(
              Color.alphaBlend(entry.value.content, surface),
              surface,
            ),
            greaterThanOrEqualTo(4.5),
          );
        });
      }
    }

    testWidgets('shares one geometry across every variant', (tester) async {
      for (final variant in AcmeBadgeVariant.values) {
        final spec = await _resolve(
          tester,
          acmeBadgeStyle(variant: variant),
          theme: const AcmeThemeData.light(),
        );

        expect(
          spec.spec.container.spec.padding,
          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          reason: variant.name,
        );
        expect(spec.spec.label.spec.style?.fontSize, 12, reason: variant.name);
        expect(
          spec.spec.label.spec.style?.fontWeight,
          FontWeight.w500,
          reason: variant.name,
        );
      }
    });

    testWidgets('every named constructor pins its own variant', (tester) async {
      final named = <AcmeBadgeVariant, AcmeBadge>{
        AcmeBadgeVariant.primary: const AcmeBadge.primary(label: 'A'),
        AcmeBadgeVariant.secondary: const AcmeBadge.secondary(label: 'A'),
        AcmeBadgeVariant.outline: const AcmeBadge.outline(label: 'A'),
        AcmeBadgeVariant.destructive: const AcmeBadge.destructive(label: 'A'),
      };

      expect(named.keys, containsAll(AcmeBadgeVariant.values));
      for (final entry in named.entries) {
        await _pumpInScope(tester, entry.value);

        expect(entry.value.variant, entry.key);
        expect(
          tester.widget<RemixBadge>(find.byType(RemixBadge)).style,
          acmeBadgeStyle(variant: entry.key),
        );
      }
    });
  });

  group('acmeDividerStyle', () {
    for (final theme in _themes) {
      testWidgets('is a hairline in the border token in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeDividerStyle(),
          theme: theme.data,
        );

        expect(_boxBackground(spec.spec.container), theme.data.border);
      });
    }

    testWidgets('each orientation pins one axis and stretches the other', (
      tester,
    ) async {
      final horizontal = await _resolve(
        tester,
        acmeDividerStyle(),
        theme: const AcmeThemeData.light(),
      );
      final vertical = await _resolve(
        tester,
        acmeDividerStyle(orientation: Axis.vertical),
        theme: const AcmeThemeData.light(),
      );

      // The pinned axis is tight; the other stays unbounded so the wrapping
      // FractionallySizedBox can stretch it to the parent.
      expect(horizontal.spec.container.spec.constraints?.maxHeight, 1);
      expect(horizontal.spec.container.spec.constraints?.minHeight, 1);
      expect(
        horizontal.spec.container.spec.constraints?.maxWidth,
        double.infinity,
      );
      expect(vertical.spec.container.spec.constraints?.maxWidth, 1);
      expect(vertical.spec.container.spec.constraints?.minWidth, 1);
      expect(
        vertical.spec.container.spec.constraints?.maxHeight,
        double.infinity,
      );
      expect(horizontal, isNot(vertical));
    });

    testWidgets('renders full width in a bounded parent', (tester) async {
      await _pumpInScope(
        tester,
        const SizedBox(width: 200, child: AcmeDivider()),
      );
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(RemixDivider)).width, 200);
    });
  });

  group('acmeSpinnerStyle', () {
    const diameters = <AcmeSpinnerSize, double>{
      AcmeSpinnerSize.small: 16,
      AcmeSpinnerSize.medium: 20,
      AcmeSpinnerSize.large: 24,
    };

    test('every size is covered', () {
      expect(diameters.keys, containsAll(AcmeSpinnerSize.values));
    });

    for (final theme in _themes) {
      testWidgets('takes the foreground color in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeSpinnerStyle(),
          theme: theme.data,
        );

        expect(spec.spec.color, theme.data.foreground);
        expect(spec.spec.duration, const Duration(milliseconds: 800));
      });
    }

    for (final entry in diameters.entries) {
      testWidgets('${entry.key.name} is ${entry.value}px', (tester) async {
        final spec = await _resolve(
          tester,
          acmeSpinnerStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(spec.spec.size, entry.value);
      });
    }

    testWidgets('the caller style merges last', (tester) async {
      final spec = await _resolve(
        tester,
        acmeSpinnerStyle(style: SpinnerStyler().size(64)),
        theme: const AcmeThemeData.light(),
      );

      expect(spec.spec.size, 64);
      expect(spec.spec.color, const AcmeThemeData.light().foreground);
    });
  });

  group('acmeSkeletonStyle', () {
    for (final theme in _themes) {
      testWidgets('pulses between the two neutral surfaces in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeSkeletonStyle(),
          theme: theme.data,
        );

        expect(_boxBackground(spec.spec.container), theme.data.muted);
        expect(spec.spec.pulseColor, theme.data.accent);
        expect(
          _boxBorderRadius(spec.spec.container),
          BorderRadius.all(theme.data.radius),
        );
        expect(spec.spec.duration, const Duration(milliseconds: 1000));
      });
    }

    testWidgets('a wrapped child keeps sizing both states', (tester) async {
      await _pumpInScope(
        tester,
        const AcmeSkeleton(loading: false, child: Text('Jane Appleseed')),
      );
      await tester.pumpAndSettle();
      final loaded = tester.getSize(find.byType(AcmeSkeleton));

      await _pumpInScope(
        tester,
        const AcmeSkeleton(child: Text('Jane Appleseed')),
      );
      await tester.pump();

      expect(tester.getSize(find.byType(AcmeSkeleton)), loaded);
    });
  });

  group('acmeProgressStyle', () {
    const thicknesses = <AcmeProgressSize, double>{
      AcmeProgressSize.small: 4,
      AcmeProgressSize.medium: 6,
      AcmeProgressSize.large: 8,
    };

    test('every size is covered', () {
      expect(thicknesses.keys, containsAll(AcmeProgressSize.values));
    });

    for (final theme in _themes) {
      testWidgets('track and indicator take their tokens in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeProgressStyle(),
          theme: theme.data,
        );

        expect(_boxBackground(spec.spec.track), theme.data.muted);
        expect(_boxBackground(spec.spec.indicator), theme.data.primary);
      });
    }

    for (final entry in thicknesses.entries) {
      testWidgets('${entry.key.name} is a ${entry.value}px rounded bar', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeProgressStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );
        final radius = BorderRadius.all(Radius.circular(entry.value / 2));

        for (final part in [
          spec.spec.container,
          spec.spec.track,
          spec.spec.indicator,
        ]) {
          expect(part.spec.constraints?.maxHeight, entry.value);
          expect(_boxBorderRadius(part), radius);
        }
        // The bar spans its parent; the indicator is sized by Remix from the
        // value, so only the container and the track claim the full width.
        expect(spec.spec.container.spec.constraints?.maxWidth, double.infinity);
        expect(spec.spec.track.spec.constraints?.maxWidth, double.infinity);
        expect(spec.spec.container.spec.clipBehavior, Clip.antiAlias);
      });
    }

    testWidgets('publishes its progress semantics', (tester) async {
      final handle = tester.ensureSemantics();

      await _pumpInScope(
        tester,
        const SizedBox(
          width: 200,
          child: AcmeProgress(value: 0.4, semanticsLabel: 'Upload'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Upload'), findsOneWidget);
      expect(tester.getSize(find.byType(RemixProgress)).width, 200);
      handle.dispose();
    });
  });

  group('acmeAvatarStyle', () {
    const expected = <AcmeAvatarSize, ({double diameter, double labelSize})>{
      AcmeAvatarSize.small: (diameter: 32, labelSize: 12),
      AcmeAvatarSize.medium: (diameter: 40, labelSize: 14),
      AcmeAvatarSize.large: (diameter: 48, labelSize: 16),
    };

    test('every size is covered', () {
      expect(expected.keys, containsAll(AcmeAvatarSize.values));
    });

    for (final entry in expected.entries) {
      testWidgets('${entry.key.name} is a circle with scaled initials', (
        tester,
      ) async {
        const theme = AcmeThemeData.light();
        final spec = await _resolve(
          tester,
          acmeAvatarStyle(size: entry.key),
          theme: theme,
        );

        expect(
          spec.spec.container.spec.constraints,
          BoxConstraints.tight(Size.square(entry.value.diameter)),
        );
        expect(
          _boxBorderRadius(spec.spec.container),
          const BorderRadius.all(Radius.circular(999)),
        );
        expect(spec.spec.label.spec.style?.fontSize, entry.value.labelSize);
        // `foreground`, not `mutedForeground`: initials are content, and
        // `mutedForeground` on `muted` is 4.35:1 in the light theme.
        expect(spec.spec.label.spec.style?.color, theme.foreground);
        expect(spec.spec.icon.spec.color, theme.foreground);
        expect(_boxBackground(spec.spec.container), theme.muted);
        expect(spec.spec.container.spec.clipBehavior, Clip.antiAlias);
      });
    }

    testWidgets('renders its initials through Remix', (tester) async {
      await _pumpInScope(tester, const AcmeAvatar(label: 'AC'));
      await tester.pumpAndSettle();

      expect(find.byType(RemixAvatar), findsOneWidget);
      expect(find.text('AC'), findsOneWidget);
    });
  });

  group('acmeLinkStyle', () {
    for (final theme in _themes) {
      testWidgets('is underlined body text in ${theme.name}', (tester) async {
        final spec = await _resolve(tester, acmeLinkStyle(), theme: theme.data);

        expect(spec.spec.label.spec.style?.color, theme.data.foreground);
        expect(
          spec.spec.label.spec.style?.decoration,
          TextDecoration.underline,
        );
        expect(spec.spec.label.spec.style?.decorationColor, theme.data.border);
        // Inline text: the recipe must not pin a size, or a link inside a
        // heading would render at body scale.
        expect(spec.spec.label.spec.style?.fontSize, isNull);
      });

      testWidgets('hover and focus promote the underline in ${theme.name}', (
        tester,
      ) async {
        for (final states in const [
          {WidgetState.hovered},
          {WidgetState.focused},
        ]) {
          final spec = await _resolve(
            tester,
            acmeLinkStyle(),
            theme: theme.data,
            states: states,
          );

          expect(
            spec.spec.label.spec.style?.decorationColor,
            theme.data.foreground,
            reason: '$states',
          );
        }
      });
    }

    testWidgets('disabled fades the link', (tester) async {
      final spec = await _resolve(
        tester,
        acmeLinkStyle(),
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.disabled},
      );

      expect(
        spec.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });

    testWidgets('a link with no callback wears the disabled fragment', (
      tester,
    ) async {
      // Remix derives "disabled" from `enabled && onPressed != null`, so a
      // decorative link resolves the recipe's disabled fragment without the
      // caller ever saying `enabled: false`. Asserting the resolved modifier
      // is what proves that; a tap that does nothing would only restate that
      // the widget was built without a callback.
      await _pumpInScope(tester, const AcmeLink(label: 'Docs'));
      await tester.pumpAndSettle();

      expect(
        _resolvedSpecOf<LinkSpec>(tester).widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
      expect(find.text('Docs'), findsOneWidget);

      var pressed = 0;
      await _pumpInScope(
        tester,
        AcmeLink(label: 'Docs', onPressed: () => pressed += 1),
      );
      await tester.pumpAndSettle();

      expect(_resolvedSpecOf<LinkSpec>(tester).widgetModifiers, isNull);

      await tester.tap(find.byType(AcmeLink));
      await tester.pumpAndSettle();

      expect(pressed, 1);
    });
  });

  group('acmeCalloutStyle', () {
    for (final theme in _themes) {
      testWidgets('neutral sits on the muted surface in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeCalloutStyle(),
          theme: theme.data,
        );

        expect(_flexDecoration(spec.spec.container)?.color, theme.data.muted);
        expect(
          _flexBorder(spec.spec.container),
          Border.all(color: theme.data.border, width: 1),
        );
        expect(spec.spec.text.spec.style?.color, theme.data.foreground);
        expect(spec.spec.icon.spec.color, theme.data.mutedForeground);
      });

      testWidgets('destructive is outline-only in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeCalloutStyle(variant: AcmeCalloutVariant.destructive),
          theme: theme.data,
        );

        expect(
          _flexDecoration(spec.spec.container)?.color,
          const Color(0x00000000),
        );
        expect(
          _flexBorder(spec.spec.container),
          Border.all(color: theme.data.destructive, width: 1),
        );
        // The sentence stays in `foreground`: `destructive` is a fill color,
        // and on the dark page it measures below the 4.5:1 body-text floor.
        expect(spec.spec.text.spec.style?.color, theme.data.foreground);
        expect(spec.spec.icon.spec.color, theme.data.destructive);
        expect(
          _contrastRatio(theme.data.foreground, theme.data.background),
          greaterThanOrEqualTo(4.5),
        );
        // The border and the glyph are non-text, where WCAG asks for 3:1.
        expect(
          _contrastRatio(theme.data.destructive, theme.data.background),
          greaterThanOrEqualTo(3.0),
        );
      });
    }

    testWidgets('both tones share one layout', (tester) async {
      for (final variant in AcmeCalloutVariant.values) {
        final spec = await _resolve(
          tester,
          acmeCalloutStyle(variant: variant),
          theme: const AcmeThemeData.light(),
        );
        final box = spec.spec.container.spec.box?.spec;
        final flex = spec.spec.container.spec.flex?.spec;

        expect(
          box?.padding,
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          reason: variant.name,
        );
        expect(flex?.spacing, 8, reason: variant.name);
        expect(
          flex?.crossAxisAlignment,
          CrossAxisAlignment.start,
          reason: variant.name,
        );
        expect(spec.spec.text.spec.style?.fontSize, 14, reason: variant.name);
        expect(spec.spec.icon.spec.size, 16, reason: variant.name);
      }
    });

    testWidgets('the named constructors pin their tone', (tester) async {
      for (final entry in <AcmeCalloutVariant, AcmeCallout>{
        AcmeCalloutVariant.neutral: const AcmeCallout.neutral(text: 'Note'),
        AcmeCalloutVariant.destructive: const AcmeCallout.destructive(
          text: 'Note',
        ),
      }.entries) {
        await _pumpInScope(tester, entry.value);

        expect(entry.value.variant, entry.key);
        expect(find.text('Note'), findsOneWidget);
      }
    });
  });

  group('acmeIconButtonStyle', () {
    const edges = <AcmeIconButtonSize, ({double edge, double iconSize})>{
      AcmeIconButtonSize.small: (edge: 32, iconSize: 16),
      AcmeIconButtonSize.medium: (edge: 36, iconSize: 16),
      AcmeIconButtonSize.large: (edge: 40, iconSize: 18),
    };

    test('every size is covered', () {
      expect(edges.keys, containsAll(AcmeIconButtonSize.values));
    });

    for (final entry in edges.entries) {
      testWidgets('${entry.key.name} is a square with a centered glyph', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeIconButtonStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(
          spec.spec.container.spec.constraints,
          BoxConstraints.tight(Size.square(entry.value.edge)),
        );
        expect(spec.spec.container.spec.alignment, Alignment.center);
        expect(spec.spec.icon.spec.size, entry.value.iconSize);
        expect(spec.spec.spinner.spec.size, entry.value.iconSize);
      });
    }

    for (final theme in _themes) {
      testWidgets('filled variants dim their own fill in ${theme.name}', (
        tester,
      ) async {
        final fills = <AcmeIconButtonVariant, Color>{
          AcmeIconButtonVariant.primary: theme.data.primary,
          AcmeIconButtonVariant.secondary: theme.data.secondary,
          AcmeIconButtonVariant.destructive: theme.data.destructive,
        };

        for (final entry in fills.entries) {
          final idle = await _resolve(
            tester,
            acmeIconButtonStyle(variant: entry.key),
            theme: theme.data,
          );
          final hovered = await _resolve(
            tester,
            acmeIconButtonStyle(variant: entry.key),
            theme: theme.data,
            states: const {WidgetState.hovered},
          );
          final pressed = await _resolve(
            tester,
            acmeIconButtonStyle(variant: entry.key),
            theme: theme.data,
            states: const {WidgetState.pressed},
          );

          expect(_boxBackground(idle.spec.container), entry.value);
          expect(
            _boxBackground(hovered.spec.container),
            entry.value.withValues(alpha: 0.9),
            reason: '${entry.key.name} hovered',
          );
          expect(
            _boxBackground(pressed.spec.container),
            entry.value.withValues(alpha: 0.8),
            reason: '${entry.key.name} pressed',
          );
        }
      });

      testWidgets('outline and ghost hover onto accent in ${theme.name}', (
        tester,
      ) async {
        for (final variant in const [
          AcmeIconButtonVariant.outline,
          AcmeIconButtonVariant.ghost,
        ]) {
          final idle = await _resolve(
            tester,
            acmeIconButtonStyle(variant: variant),
            theme: theme.data,
          );
          final hovered = await _resolve(
            tester,
            acmeIconButtonStyle(variant: variant),
            theme: theme.data,
            states: const {WidgetState.hovered},
          );

          expect(_boxBackground(idle.spec.container), const Color(0x00000000));
          expect(idle.spec.icon.spec.color, theme.data.foreground);
          expect(
            _boxBorder(idle.spec.container),
            variant == AcmeIconButtonVariant.outline
                ? Border.all(color: theme.data.border, width: 1)
                : isNull,
          );
          expect(_boxBackground(hovered.spec.container), theme.data.accent);
          expect(hovered.spec.icon.spec.color, theme.data.accentForeground);
          expect(
            hovered.spec.spinner.spec.color,
            theme.data.accentForeground,
            reason: variant.name,
          );
        }
      });
    }

    testWidgets('focus-visible rings and disabled clears it', (tester) async {
      const theme = AcmeThemeData.light();
      final focused = await _resolve(
        tester,
        acmeIconButtonStyle(),
        theme: theme,
        states: const {WidgetState.focused},
      );
      final disabled = await _resolve(
        tester,
        acmeIconButtonStyle(),
        theme: theme,
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(focused.spec.containerEffects?.outline.color, theme.focusRing);
      expect(focused.spec.containerEffects?.outline.width, 2);
      expect(focused.spec.containerEffects?.outlineOffset, 2);
      expect(disabled.spec.containerEffects?.outline.style, BorderStyle.none);
      expect(
        disabled.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });

    testWidgets('forwards the safe RemixIconButton surface', (tester) async {
      var pressed = 0;

      await _pumpInScope(
        tester,
        AcmeIconButton.outline(
          icon: _leading,
          semanticLabel: 'Confirm',
          semanticHint: 'Applies the change',
          size: AcmeIconButtonSize.large,
          style: IconButtonStyler().size(60, 60),
          onPressed: () => pressed += 1,
        ),
      );
      await tester.pumpAndSettle();

      final remix = tester.widget<RemixIconButton>(
        find.byType(RemixIconButton),
      );
      expect(remix.icon, _leading);
      expect(remix.semanticLabel, 'Confirm');
      expect(remix.semanticHint, 'Applies the change');
      expect(remix.styleSpec, isNull);
      expect(
        remix.style,
        acmeIconButtonStyle(
          variant: AcmeIconButtonVariant.outline,
          size: AcmeIconButtonSize.large,
          style: IconButtonStyler().size(60, 60),
        ),
      );

      await tester.tap(find.byType(AcmeIconButton));
      await tester.pumpAndSettle();
      expect(pressed, 1);
    });

    testWidgets('a loading icon button shows the Remix spinner', (
      tester,
    ) async {
      await _pumpInScope(
        tester,
        AcmeIconButton.primary(
          icon: _leading,
          semanticLabel: 'Saving',
          loading: true,
          onPressed: () {},
        ),
      );
      await tester.pump();

      expect(find.byType(RemixSpinner), findsOneWidget);
    });
  });

  group('acmeToggleStyle', () {
    for (final theme in _themes) {
      testWidgets('off is transparent with foreground content in '
          '${theme.name}', (tester) async {
        for (final variant in AcmeToggleVariant.values) {
          final spec = await _resolve(
            tester,
            acmeToggleStyle(variant: variant),
            theme: theme.data,
          );

          expect(
            _flexDecoration(spec.spec.container)?.color,
            const Color(0x00000000),
            reason: variant.name,
          );
          expect(spec.spec.label.spec.style?.color, theme.data.foreground);
          expect(spec.spec.icon.spec.color, theme.data.foreground);
          expect(
            _flexBorder(spec.spec.container),
            variant == AcmeToggleVariant.outline
                ? Border.all(color: theme.data.border, width: 1)
                : isNull,
            reason: variant.name,
          );
        }
      });

      testWidgets('hover and on stay distinguishable in ${theme.name}', (
        tester,
      ) async {
        final hovered = await _resolve(
          tester,
          acmeToggleStyle(),
          theme: theme.data,
          states: const {WidgetState.hovered},
        );
        final on = await _resolve(
          tester,
          acmeToggleStyle(),
          theme: theme.data,
          states: const {WidgetState.selected},
        );

        expect(
          _flexDecoration(hovered.spec.container)?.color,
          theme.data.muted,
        );
        expect(hovered.spec.label.spec.style?.color, theme.data.foreground);
        expect(_flexDecoration(on.spec.container)?.color, theme.data.accent);
        expect(on.spec.label.spec.style?.color, theme.data.accentForeground);
        expect(theme.data.muted, isNot(theme.data.accent));
      });
    }

    testWidgets('sizes match the button scale', (tester) async {
      const heights = <AcmeToggleSize, double>{
        AcmeToggleSize.small: 32,
        AcmeToggleSize.medium: 36,
        AcmeToggleSize.large: 40,
      };
      expect(heights.keys, containsAll(AcmeToggleSize.values));

      for (final entry in heights.entries) {
        final spec = await _resolve(
          tester,
          acmeToggleStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(
          spec.spec.container.spec.box?.spec.constraints?.minHeight,
          entry.value,
          reason: entry.key.name,
        );
      }
    });

    testWidgets('focus-visible rings without moving the label', (tester) async {
      const theme = AcmeThemeData.light();
      final idle = await _resolve(tester, acmeToggleStyle(), theme: theme);
      final focused = await _resolve(
        tester,
        acmeToggleStyle(),
        theme: theme,
        states: const {WidgetState.focused},
      );

      expect(_flexForegroundBorder(idle.spec.container), isNull);
      expect(
        _flexForegroundBorder(focused.spec.container),
        Border.all(
          color: theme.focusRing,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      );
      // The ring must not arrive as a real border: Flutter insets a
      // container's content by its border widths, so focusing would nudge the
      // label. This is the assertion that would fail if the recipe reached
      // for `.border(...)` instead of `.foregroundDecoration(...)`.
      expect(_flexBorder(idle.spec.container), isNull);
      expect(_flexBorder(focused.spec.container), isNull);
    });

    testWidgets('disabled fades the control and clears the ring', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        acmeToggleStyle(),
        theme: const AcmeThemeData.light(),
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(
        spec.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
      expect(
        (_flexForegroundBorder(spec.spec.container) as Border?)?.top.style,
        BorderStyle.none,
      );
    });

    testWidgets('toggling reaches the callback and reports its state', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final changes = <bool>[];

      await _pumpInScope(
        tester,
        AcmeToggle.outline(
          selected: false,
          label: 'Bold',
          onChanged: changes.add,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AcmeToggle));
      await tester.pumpAndSettle();

      expect(changes, [true]);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Bold')),
        isSemantics(hasEnabledState: true, isEnabled: true),
      );
      handle.dispose();
    });
  });

  group('acmeSwitchStyle', () {
    const heights = <AcmeSwitchSize, double>{
      AcmeSwitchSize.small: 16,
      AcmeSwitchSize.medium: 20,
      AcmeSwitchSize.large: 24,
    };

    test('every size is covered', () {
      expect(heights.keys, containsAll(AcmeSwitchSize.values));
    });

    for (final entry in heights.entries) {
      testWidgets('${entry.key.name} keeps the thumb flush in the track', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeSwitchStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(spec.spec.container.spec.constraints?.maxHeight, entry.value);
        expect(
          spec.spec.container.spec.constraints?.maxWidth,
          entry.value * 1.8,
        );
        // Track height minus the 2px inset on both sides: the thumb must not
        // spill out of the rail at any size.
        expect(
          spec.spec.thumb.spec.constraints?.maxHeight,
          entry.value - 4,
          reason: entry.key.name,
        );
        expect(spec.spec.container.spec.padding, const EdgeInsets.all(2));
      });
    }

    for (final theme in _themes) {
      testWidgets('only the track carries the state in ${theme.name}', (
        tester,
      ) async {
        final off = await _resolve(
          tester,
          acmeSwitchStyle(),
          theme: theme.data,
        );
        final on = await _resolve(
          tester,
          acmeSwitchStyle(),
          theme: theme.data,
          states: const {WidgetState.selected},
        );

        expect(_boxBackground(off.spec.container), theme.data.muted);
        expect(_boxBackground(on.spec.container), theme.data.primary);
        // The thumb never changes, so it has to stay visible on both tracks.
        for (final spec in [off, on]) {
          expect(_boxBackground(spec.spec.thumb), theme.data.background);
        }
        expect(
          _contrastRatio(theme.data.background, theme.data.primary),
          greaterThanOrEqualTo(3.0),
        );
      });
    }

    testWidgets('focus rings the track and disabled clears it', (tester) async {
      const theme = AcmeThemeData.light();
      final focused = await _resolve(
        tester,
        acmeSwitchStyle(),
        theme: theme,
        states: const {WidgetState.focused},
      );
      final disabled = await _resolve(
        tester,
        acmeSwitchStyle(),
        theme: theme,
        states: const {WidgetState.focused, WidgetState.disabled},
      );

      expect(focused.spec.trackEffects?.outline.color, theme.focusRing);
      expect(focused.spec.trackEffects?.outline.width, 2);
      expect(disabled.spec.trackEffects?.outline.style, BorderStyle.none);
      expect(
        disabled.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });

    testWidgets('toggling reaches the callback and reports switch semantics', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final changes = <bool>[];

      await _pumpInScope(
        tester,
        AcmeSwitch(
          selected: false,
          semanticLabel: 'Notifications',
          onChanged: changes.add,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AcmeSwitch));
      await tester.pumpAndSettle();

      expect(changes, [true]);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Notifications')),
        isSemantics(hasEnabledState: true, isEnabled: true, isToggled: false),
      );
      handle.dispose();
    });
  });

  group('acmeRadioStyle', () {
    const expected = <AcmeRadioSize, ({double diameter, double dot})>{
      AcmeRadioSize.small: (diameter: 16, dot: 6),
      AcmeRadioSize.medium: (diameter: 18, dot: 7),
      AcmeRadioSize.large: (diameter: 20, dot: 8),
    };

    test('every size is covered', () {
      expect(expected.keys, containsAll(AcmeRadioSize.values));
    });

    for (final entry in expected.entries) {
      testWidgets('${entry.key.name} is a circle around a smaller dot', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeRadioStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(
          spec.spec.container.spec.constraints,
          BoxConstraints.tight(Size.square(entry.value.diameter)),
        );
        expect(
          spec.spec.indicator.spec.constraints,
          BoxConstraints.tight(Size.square(entry.value.dot)),
        );
        for (final part in [spec.spec.container, spec.spec.indicator]) {
          expect(
            _boxBorderRadius(part),
            const BorderRadius.all(Radius.circular(999)),
          );
        }
      });
    }

    for (final theme in _themes) {
      testWidgets('chosen keeps an open middle in ${theme.name}', (
        tester,
      ) async {
        final unchosen = await _resolve(
          tester,
          acmeRadioStyle(),
          theme: theme.data,
        );
        final chosen = await _resolve(
          tester,
          acmeRadioStyle(),
          theme: theme.data,
          states: const {WidgetState.selected},
        );

        expect(_boxBackground(unchosen.spec.container), theme.data.background);
        expect(
          _boxBorder(unchosen.spec.container),
          Border.all(color: theme.data.border, width: 1),
        );
        // The surface stays the page color: the dot is the mark, not a fill.
        expect(_boxBackground(chosen.spec.container), theme.data.background);
        expect(
          _boxBorder(chosen.spec.container),
          Border.all(color: theme.data.primary, width: 1.5),
        );
        expect(_boxBackground(chosen.spec.indicator), theme.data.primary);
        expect(
          _contrastRatio(theme.data.primary, theme.data.background),
          greaterThanOrEqualTo(3.0),
        );
      });

      testWidgets(
        'a chosen radio dims its own ring on hover in ${theme.name}',
        (tester) async {
          final spec = await _resolve(
            tester,
            acmeRadioStyle(),
            theme: theme.data,
            states: const {WidgetState.selected, WidgetState.hovered},
          );
          final dimmed = theme.data.primary.withValues(alpha: 0.9);

          expect(
            _boxBorder(spec.spec.container),
            Border.all(color: dimmed, width: 1.5),
          );
          expect(_boxBackground(spec.spec.indicator), dimmed);
        },
      );
    }

    testWidgets('selecting one option clears the other', (tester) async {
      String? chosen = 'free';

      await tester.pumpWidget(
        AcmeThemeScope(
          data: const AcmeThemeData.light(),
          child: _host(
            StatefulBuilder(
              builder: (context, setState) => RemixRadioGroup<String>(
                groupValue: chosen,
                semanticLabel: 'Plan',
                onChanged: (value) => setState(() => chosen = value),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AcmeRadio<String>(value: 'free', semanticLabel: 'Free'),
                    AcmeRadio<String>(value: 'pro', semanticLabel: 'Pro'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.bySemanticsLabel('Pro'));
      await tester.pumpAndSettle();

      expect(chosen, 'pro');
    });
  });

  group('acmeSliderStyle', () {
    const rails = <AcmeSliderSize, double>{
      AcmeSliderSize.small: 4,
      AcmeSliderSize.medium: 6,
      AcmeSliderSize.large: 8,
    };

    test('every size is covered', () {
      expect(rails.keys, containsAll(AcmeSliderSize.values));
    });

    for (final entry in rails.entries) {
      testWidgets('${entry.key.name} scales the thumb with the rail', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeSliderStyle(size: entry.key),
          theme: const AcmeThemeData.light(),
        );

        expect(spec.spec.trackWidth, entry.value);
        expect(spec.spec.rangeWidth, entry.value);
        expect(
          spec.spec.thumb.spec.constraints,
          BoxConstraints.tight(Size.square(entry.value * 2.5)),
        );
      });
    }

    for (final theme in _themes) {
      testWidgets('rail, range, and thumb take their tokens in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeSliderStyle(),
          theme: theme.data,
        );

        // The same pairing the progress bar uses: a slider is a progress bar
        // you can grab.
        expect(spec.spec.trackColor, theme.data.muted);
        expect(spec.spec.rangeColor, theme.data.primary);
        expect(_boxBackground(spec.spec.thumb), theme.data.background);
        expect(
          _boxBorder(spec.spec.thumb),
          Border.all(color: theme.data.primary, width: 2),
        );
      });
    }

    testWidgets('focus rings the thumb and disabled fades the control', (
      tester,
    ) async {
      const theme = AcmeThemeData.light();
      final focused = await _resolve(
        tester,
        acmeSliderStyle(),
        theme: theme,
        states: const {WidgetState.focused},
      );
      final disabled = await _resolve(
        tester,
        acmeSliderStyle(),
        theme: theme,
        states: const {WidgetState.disabled},
      );

      expect(focused.spec.thumbFocusEffects?.outline.color, theme.focusRing);
      expect(
        disabled.widgetModifiers,
        contains(
          isA<OpacityModifier>().having((m) => m.opacity, 'opacity', 0.5),
        ),
      );
    });

    testWidgets('forwards the curated RemixSlider surface', (tester) async {
      await _pumpInScope(
        tester,
        SizedBox(
          width: 200,
          child: AcmeSlider(
            value: 0.5,
            min: 0,
            max: 10,
            snapDivisions: 5,
            semanticLabel: 'Volume',
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final remix = tester.widget<RemixSlider>(find.byType(RemixSlider));
      expect(remix.min, 0);
      expect(remix.max, 10);
      expect(remix.snapDivisions, 5);
      expect(remix.semanticLabel, 'Volume');
      expect(remix.style, acmeSliderStyle());
      // `semanticFormatterCallback` would drag `package:naked_ui` into the
      // adapter, so it is deliberately outside the generated surface.
      expect(remix.semanticFormatterCallback, isNull);
    });
  });

  group('acmeTextFieldStyle and acmeTextAreaStyle', () {
    const heights = <AcmeTextFieldSize, ({double minHeight, double textSize})>{
      AcmeTextFieldSize.small: (minHeight: 32, textSize: 14),
      AcmeTextFieldSize.medium: (minHeight: 36, textSize: 14),
      AcmeTextFieldSize.large: (minHeight: 40, textSize: 16),
    };

    test('every size is covered', () {
      expect(heights.keys, containsAll(AcmeTextFieldSize.values));
    });

    for (final entry in heights.entries) {
      testWidgets('${entry.key.name} sizes the field and its text', (
        tester,
      ) async {
        const theme = AcmeThemeData.light();
        final field = await _resolve(
          tester,
          acmeTextFieldStyle(size: entry.key),
          theme: theme,
        );
        final area = await _resolve(
          tester,
          acmeTextAreaStyle(size: entry.key),
          theme: theme,
        );

        expect(
          field.spec.container.spec.constraints?.minHeight,
          entry.value.minHeight,
        );
        expect(field.spec.text.spec.style?.fontSize, entry.value.textSize);
        // A text area rests taller, because `RemixTextArea` defaults to two
        // lines and the box must not grow the moment the second one arrives.
        expect(
          area.spec.container.spec.constraints?.minHeight,
          entry.value.minHeight * 2.5,
        );
      });
    }

    for (final theme in _themes) {
      testWidgets('the four text roles take their tokens in ${theme.name}', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          acmeTextFieldStyle(),
          theme: theme.data,
        );

        expect(spec.spec.text.spec.style?.color, theme.data.foreground);
        // The placeholder must read as quieter than a real value.
        expect(
          spec.spec.hintText.spec.style?.color,
          theme.data.mutedForeground,
        );
        expect(spec.spec.label.spec.style?.color, theme.data.foreground);
        expect(
          spec.spec.helperText.spec.style?.color,
          theme.data.mutedForeground,
        );
        expect(spec.spec.cursorColor, theme.data.foreground);
        expect(
          _boxBorder(spec.spec.container),
          Border.all(color: theme.data.border, width: 1),
        );
      });

      testWidgets(
        'error outlines the field and colors the helper in ${theme.name}',
        (tester) async {
          final spec = await _resolve(
            tester,
            acmeTextFieldStyle(),
            theme: theme.data,
            states: const {WidgetState.error},
          );

          expect(
            _boxBorder(spec.spec.container),
            Border.all(color: theme.data.destructive, width: 1),
          );
          // The outline carries the tone, where the non-text floor is 3:1.
          // The message that explains the problem stays `foreground` and gets
          // heavier, because `destructive` is 4.1:1 on the dark page.
          expect(spec.spec.helperText.spec.style?.color, theme.data.foreground);
          expect(spec.spec.helperText.spec.style?.fontWeight, FontWeight.w500);
          expect(spec.spec.text.spec.style?.color, theme.data.foreground);
        },
      );
    }

    testWidgets('the area only differs in height and alignment', (
      tester,
    ) async {
      const theme = AcmeThemeData.light();
      final field = await _resolve(tester, acmeTextFieldStyle(), theme: theme);
      final area = await _resolve(tester, acmeTextAreaStyle(), theme: theme);

      expect(field.spec.crossAxisAlignment, CrossAxisAlignment.center);
      expect(area.spec.crossAxisAlignment, CrossAxisAlignment.start);
      // Everything the two share comes from one place in the recipe.
      expect(area.spec.text.spec.style, field.spec.text.spec.style);
      expect(area.spec.label.spec.style, field.spec.label.spec.style);
      expect(_boxBorder(area.spec.container), _boxBorder(field.spec.container));
    });

    testWidgets('an invalid field announces itself', (tester) async {
      final handle = tester.ensureSemantics();

      await _pumpInScope(
        tester,
        const SizedBox(
          width: 220,
          child: AcmeTextField(
            label: 'Slug',
            helperText: 'Spaces are not allowed.',
            error: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Slug')),
        isSemantics(validationResult: SemanticsValidationResult.invalid),
      );
      handle.dispose();
    });

    testWidgets('typing reaches the callback', (tester) async {
      final typed = <String>[];

      await _pumpInScope(
        tester,
        _overlaid(
          SizedBox(
            width: 220,
            child: AcmeTextField(label: 'Workspace', onChanged: typed.add),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(EditableText), 'acme');
      await tester.pumpAndSettle();

      expect(typed, ['acme']);
    });
  });

  group('acmeToggleGroupStyle and acmeSegmentedControlStyle', () {
    for (final theme in _themes) {
      testWidgets(
        'a toggle group option mirrors a lone toggle in ${theme.name}',
        (tester) async {
          for (final variant in AcmeToggleGroupVariant.values) {
            final group = await _resolve(
              tester,
              acmeToggleGroupStyle(variant: variant),
              theme: theme.data,
            );
            final item = group.spec.item.spec;

            expect(
              _flexDecoration(item.container)?.color,
              const Color(0x00000000),
              reason: variant.name,
            );
            expect(item.label.spec.style?.color, theme.data.foreground);
            expect(
              _flexBorder(item.container),
              variant == AcmeToggleGroupVariant.outline
                  ? Border.all(color: theme.data.border, width: 1)
                  : isNull,
              reason: variant.name,
            );
          }
        },
      );

      testWidgets(
        'the segmented track recesses its segments in ${theme.name}',
        (tester) async {
          final spec = await _resolve(
            tester,
            acmeSegmentedControlStyle(),
            theme: theme.data,
          );

          // The chosen segment is lifted onto the page color, out of the
          // track.
          expect(_boxBackground(spec.spec.container), theme.data.muted);
          expect(spec.spec.container.spec.padding, const EdgeInsets.all(3));
          expect(spec.spec.spacing, 0);
          expect(
            _boxBackground(spec.spec.item.spec.container),
            const Color(0x00000000),
          );
          // Every segment's label is `foreground`: `mutedForeground` on the
          // `muted` track measures 4.35:1 in the light theme. The chosen
          // segment is marked by its raised surface and a heavier weight.
          expect(
            spec.spec.item.spec.label.spec.style?.color,
            theme.data.foreground,
          );
          expect(
            spec.spec.item.spec.label.spec.style?.fontWeight,
            FontWeight.w400,
          );
        },
      );
    }

    testWidgets('the segment radius is pulled in by the track inset', (
      tester,
    ) async {
      const light = AcmeThemeData.light();
      final cases = <Radius, Radius>{
        // The shipped 8 leaves 5 once the 3px inset is taken off.
        light.radius: const Radius.circular(5),
        // A radius smaller than the inset clamps at square rather than going
        // negative.
        const Radius.circular(2): Radius.zero,
        Radius.zero: Radius.zero,
      };

      for (final entry in cases.entries) {
        final spec = await _resolve(
          tester,
          acmeSegmentedControlStyle(),
          theme: light.copyWith(radius: entry.key),
        );

        expect(
          _boxBorderRadius(spec.spec.item.spec.container),
          BorderRadius.all(entry.value),
          reason: '${entry.key}',
        );
      }
    });

    testWidgets('one recipe styles every option without a per-item styler', (
      tester,
    ) async {
      String? weight = 'bold';

      await tester.pumpWidget(
        AcmeThemeScope(
          data: const AcmeThemeData.light(),
          child: _host(
            StatefulBuilder(
              builder: (context, setState) => AcmeToggleGroup<String>(
                selectedValue: weight,
                semanticLabel: 'Weight',
                onChanged: (value) => setState(() => weight = value),
                items: const [
                  RemixToggleGroupItem(value: 'bold', label: 'Bold'),
                  RemixToggleGroupItem(value: 'italic', label: 'Italic'),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Bold'), findsOneWidget);
      await tester.tap(find.text('Italic'));
      await tester.pumpAndSettle();

      expect(weight, 'italic');
    });

    testWidgets('a segmented control reports the chosen segment', (
      tester,
    ) async {
      final chosen = <String>[];

      await _pumpInScope(
        tester,
        AcmeSegmentedControl<String>(
          selectedValue: 'list',
          semanticLabel: 'View',
          onChanged: chosen.add,
          items: const [
            RemixSegmentedControlItem(value: 'list', label: 'List'),
            RemixSegmentedControlItem(value: 'board', label: 'Board'),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Board'));
      await tester.pumpAndSettle();

      expect(chosen, ['board']);
    });
  });

  group(
    'resolved content clears its WCAG floor over the surface it lands on',
    () {
      // The recipes decide which token lands on which surface, and a pairing
      // that reads fine in one theme can fail in the other. This group resolves
      // the real specs and measures them rather than trusting the token names:
      // it is what would have caught `mutedForeground` initials on a `muted`
      // avatar, which measure 4.35:1 in the light theme.
      //
      // 4.5:1 is WCAG 2 for body-size text; 3.0:1 is the non-text floor that
      // applies to glyphs and component boundaries.
      for (final theme in _themes) {
        testWidgets('avatar fallback in ${theme.name}', (tester) async {
          final spec = await _resolve(
            tester,
            acmeAvatarStyle(),
            theme: theme.data,
          );
          final surface = _boxBackground(spec.spec.container)!;

          _expectReadable(
            spec.spec.label.spec.style!.color!,
            surface,
            page: theme.data.background,
            floor: 4.5,
            reason: 'initials',
          );
          _expectReadable(
            spec.spec.icon.spec.color!,
            surface,
            page: theme.data.background,
            floor: 3.0,
            reason: 'fallback glyph',
          );
        });

        testWidgets('callout tones in ${theme.name}', (tester) async {
          for (final variant in AcmeCalloutVariant.values) {
            final spec = await _resolve(
              tester,
              acmeCalloutStyle(variant: variant),
              theme: theme.data,
            );
            final surface = _flexDecoration(spec.spec.container)!.color!;

            _expectReadable(
              spec.spec.text.spec.style!.color!,
              surface,
              page: theme.data.background,
              floor: 4.5,
              reason: '${variant.name} sentence',
            );
            _expectReadable(
              spec.spec.icon.spec.color!,
              surface,
              page: theme.data.background,
              floor: 3.0,
              reason: '${variant.name} glyph',
            );
          }
        });

        testWidgets('link in every state in ${theme.name}', (tester) async {
          for (final states in const [
            <WidgetState>{},
            {WidgetState.hovered},
            {WidgetState.focused},
          ]) {
            final spec = await _resolve(
              tester,
              acmeLinkStyle(),
              theme: theme.data,
              states: states,
            );

            _expectReadable(
              spec.spec.label.spec.style!.color!,
              const Color(0x00000000),
              page: theme.data.background,
              floor: 4.5,
              reason: '$states',
            );
          }
        });

        testWidgets('tab in every state in ${theme.name}', (tester) async {
          for (final states in const [
            <WidgetState>{},
            {WidgetState.hovered},
            {WidgetState.selected},
          ]) {
            final spec = await _resolve(
              tester,
              acmeTabStyle(),
              theme: theme.data,
              states: states,
            );

            _expectReadable(
              spec.spec.label.spec.style!.color!,
              _flexDecoration(spec.spec.container)?.color ??
                  const Color(0x00000000),
              page: theme.data.background,
              floor: 4.5,
              reason: '$states',
            );
          }
        });

        testWidgets('toggle in every state in ${theme.name}', (tester) async {
          for (final variant in AcmeToggleVariant.values) {
            for (final states in const [
              <WidgetState>{},
              {WidgetState.hovered},
              {WidgetState.selected},
            ]) {
              final spec = await _resolve(
                tester,
                acmeToggleStyle(variant: variant),
                theme: theme.data,
                states: states,
              );

              _expectReadable(
                spec.spec.label.spec.style!.color!,
                _flexDecoration(spec.spec.container)!.color!,
                page: theme.data.background,
                floor: 4.5,
                reason: '${variant.name} $states',
              );
            }
          }
        });

        testWidgets('text input roles in ${theme.name}', (tester) async {
          for (final states in const [
            <WidgetState>{},
            {WidgetState.error},
          ]) {
            final spec = await _resolve(
              tester,
              acmeTextFieldStyle(),
              theme: theme.data,
              states: states,
            );
            final field = _boxBackground(spec.spec.container)!;
            // The label and the helper are siblings of the field box inside
            // the recipe's `layout` column, so they sit on the page, not on
            // the field's own surface.
            const page = Color(0x00000000);

            for (final role in <String, ({TextStyle? style, Color surface})>{
              'value': (style: spec.spec.text.spec.style, surface: field),
              'placeholder': (
                style: spec.spec.hintText.spec.style,
                surface: field,
              ),
              'label': (style: spec.spec.label.spec.style, surface: page),
              'helper': (style: spec.spec.helperText.spec.style, surface: page),
            }.entries) {
              _expectReadable(
                role.value.style!.color!,
                role.value.surface,
                page: theme.data.background,
                floor: 4.5,
                reason: '${role.key} $states',
              );
            }
          }
        });

        testWidgets('group options in ${theme.name}', (tester) async {
          for (final states in const [
            <WidgetState>{},
            {WidgetState.hovered},
            {WidgetState.selected},
          ]) {
            final toggleGroup = await _resolve(
              tester,
              acmeToggleGroupStyle(),
              theme: theme.data,
              states: states,
            );
            final segmented = await _resolve(
              tester,
              acmeSegmentedControlStyle(),
              theme: theme.data,
              states: states,
            );

            _expectReadable(
              toggleGroup.spec.item.spec.label.spec.style!.color!,
              _flexDecoration(toggleGroup.spec.item.spec.container)!.color!,
              page: theme.data.background,
              floor: 4.5,
              reason: 'toggle group $states',
            );
            // A segment sits on the track, which sits on the page.
            _expectReadable(
              segmented.spec.item.spec.label.spec.style!.color!,
              _boxBackground(segmented.spec.item.spec.container)!,
              page: Color.alphaBlend(
                _boxBackground(segmented.spec.container)!,
                theme.data.background,
              ),
              floor: 4.5,
              reason: 'segmented control $states',
            );
          }
        });

        testWidgets('icon button in every variant in ${theme.name}', (
          tester,
        ) async {
          for (final variant in AcmeIconButtonVariant.values) {
            for (final states in const [
              <WidgetState>{},
              {WidgetState.hovered},
              {WidgetState.pressed},
            ]) {
              final spec = await _resolve(
                tester,
                acmeIconButtonStyle(variant: variant),
                theme: theme.data,
                states: states,
              );

              // A glyph is the whole content here, so it is held to the
              // non-text floor rather than the body-text one.
              _expectReadable(
                spec.spec.icon.spec.color!,
                _boxBackground(spec.spec.container)!,
                page: theme.data.background,
                floor: 3.0,
                reason: '${variant.name} $states',
              );
            }
          }
        });
      }
    },
  );

  test('an empty caller style leaves every recipe untouched', () {
    // The `style` seam has to be free when it is unused: a recipe that
    // resolved differently with `const XStyler.create()` than without it would
    // make every generated adapter subtly different from the recipe it calls.
    expect(
      acmeAvatarStyle(style: const AvatarStyler.create()),
      acmeAvatarStyle(),
    );
    expect(acmeBadgeStyle(style: const BadgeStyler.create()), acmeBadgeStyle());
    expect(
      acmeButtonStyle(style: const ButtonStyler.create()),
      acmeButtonStyle(),
    );
    expect(
      acmeCalloutStyle(style: const CalloutStyler.create()),
      acmeCalloutStyle(),
    );
    expect(acmeCardStyle(style: const CardStyler.create()), acmeCardStyle());
    expect(
      acmeCheckboxStyle(style: const CheckboxStyler.create()),
      acmeCheckboxStyle(),
    );
    expect(
      acmeDividerStyle(style: const DividerStyler.create()),
      acmeDividerStyle(),
    );
    expect(
      acmeIconButtonStyle(style: const IconButtonStyler.create()),
      acmeIconButtonStyle(),
    );
    expect(acmeLinkStyle(style: const LinkStyler.create()), acmeLinkStyle());
    expect(
      acmeProgressStyle(style: const ProgressStyler.create()),
      acmeProgressStyle(),
    );
    expect(acmeRadioStyle(style: const RadioStyler.create()), acmeRadioStyle());
    expect(
      acmeSegmentedControlStyle(style: const SegmentedControlStyler.create()),
      acmeSegmentedControlStyle(),
    );
    expect(
      acmeSkeletonStyle(style: const SkeletonStyler.create()),
      acmeSkeletonStyle(),
    );
    expect(
      acmeSliderStyle(style: const SliderStyler.create()),
      acmeSliderStyle(),
    );
    expect(
      acmeSpinnerStyle(style: const SpinnerStyler.create()),
      acmeSpinnerStyle(),
    );
    expect(
      acmeSwitchStyle(style: const SwitchStyler.create()),
      acmeSwitchStyle(),
    );
    expect(acmeTabStyle(style: const TabStyler.create()), acmeTabStyle());
    expect(
      acmeTabBarStyle(style: const TabBarStyler.create()),
      acmeTabBarStyle(),
    );
    expect(
      acmeTabViewStyle(style: const TabViewStyler.create()),
      acmeTabViewStyle(),
    );
    expect(
      acmeTextFieldStyle(style: const TextFieldStyler.create()),
      acmeTextFieldStyle(),
    );
    expect(
      acmeTextAreaStyle(style: const TextFieldStyler.create()),
      acmeTextAreaStyle(),
    );
    expect(
      acmeToggleStyle(style: const ToggleStyler.create()),
      acmeToggleStyle(),
    );
    expect(
      acmeToggleGroupStyle(style: const ToggleGroupStyler.create()),
      acmeToggleGroupStyle(),
    );
  });
}

// -- helpers ----------------------------------------------------------------

typedef _Metrics = ({
  double minHeight,
  double paddingX,
  double gap,
  double labelSize,
  double iconSize,
});

const _minHeights = <AcmeButtonSize, double>{
  AcmeButtonSize.small: 32.0,
  AcmeButtonSize.medium: 36.0,
  AcmeButtonSize.large: 40.0,
};

const _themes = <({String name, AcmeThemeData data})>[
  (name: 'light', data: AcmeThemeData.light()),
  (name: 'dark', data: AcmeThemeData.dark()),
];

/// Two arbitrary glyphs; the fixture bundles no icon font, and `find.byIcon`
/// matches on [IconData] rather than on rendered pixels.
const IconData _leading = IconData(0x2713);
const IconData _trailing = IconData(0x2715);

/// The minimal host: `WidgetsApp` and nothing from Material or Cupertino.
Widget _host(Widget child) =>
    WidgetsApp(color: const Color(0xFF000000), builder: (_, _) => child);

/// [child] under an `Overlay`, which is what a focused text field requires.
///
/// `EditableText` asserts on an `Overlay` ancestor the moment it takes focus,
/// for its selection handles and magnifier. A real application gets one from
/// its `Navigator`; the bare `WidgetsApp(builder: ...)` above does not, so the
/// tests that focus a field add one rather than reaching for `MaterialApp`.
Widget _overlaid(Widget child) =>
    Overlay(initialEntries: [OverlayEntry(builder: (_) => child)]);

/// Renders [child] and hands its context back, so a test can read inherited
/// values from exactly where a real widget would.
class _Probe extends StatelessWidget {
  const _Probe(this.onBuild);

  final void Function(BuildContext context) onBuild;

  @override
  Widget build(BuildContext context) {
    onBuild(context);

    return const SizedBox.shrink();
  }
}

/// Resolves a recipe against a theme and a set of widget states.
Future<StyleSpec<ButtonSpec>> _resolveStyle(
  WidgetTester tester, {
  required AcmeThemeData theme,
  AcmeButtonVariant variant = AcmeButtonVariant.primary,
  AcmeButtonSize size = AcmeButtonSize.medium,
  ButtonStyler? style,
  ButtonStyler? styler,
  Set<WidgetState> states = const {},
  FocusHighlightStrategy highlightStrategy =
      FocusHighlightStrategy.alwaysTraditional,
}) => _resolve(
  tester,
  styler ??
      acmeButtonStyle(
        variant: variant,
        size: size,
        style: style ?? const ButtonStyler.create(),
      ),
  theme: theme,
  states: states,
  highlightStrategy: highlightStrategy,
);

/// Mounts one widget under a theme scope, centered, with no host framework.
Future<void> _pumpInScope(
  WidgetTester tester,
  Widget child, {
  AcmeThemeData theme = const AcmeThemeData.light(),
}) {
  return tester.pumpWidget(
    AcmeThemeScope(
      data: theme,
      child: _host(Center(child: child)),
    ),
  );
}

/// The spec the rendered button actually resolved.
///
/// Remix publishes it below `RemixButton` for its own subtree, which is the
/// only place the resolved recipe is observable from outside.
StyleSpec<ButtonSpec> _resolvedSpec(WidgetTester tester) =>
    _resolvedSpecOf<ButtonSpec>(tester);

BoxDecoration? _decoration(StyleSpec<ButtonSpec> spec) =>
    spec.spec.container.spec.box?.spec.decoration as BoxDecoration?;

Color? _background(StyleSpec<ButtonSpec> spec) => _decoration(spec)?.color;

BoxBorder? _border(StyleSpec<ButtonSpec> spec) => _decoration(spec)?.border;

BorderRadiusGeometry? _borderRadius(StyleSpec<ButtonSpec> spec) =>
    _decoration(spec)?.borderRadius;

Color? _labelColor(StyleSpec<ButtonSpec> spec) =>
    spec.spec.label.spec.style?.color;

Color? _iconColor(StyleSpec<ButtonSpec> spec) => spec.spec.icon.spec.color;

Color? _spinnerColor(StyleSpec<ButtonSpec> spec) =>
    spec.spec.spinner.spec.color;

double? _minHeight(StyleSpec<ButtonSpec> spec) =>
    spec.spec.container.spec.box?.spec.constraints?.minHeight;

EdgeInsetsGeometry? _padding(StyleSpec<ButtonSpec> spec) =>
    spec.spec.container.spec.box?.spec.padding;

double? _spacing(StyleSpec<ButtonSpec> spec) =>
    spec.spec.container.spec.flex?.spec.spacing;

void _expectContent(StyleSpec<ButtonSpec> spec, Color expected) {
  expect(_labelColor(spec), expected, reason: 'label');
  expect(_iconColor(spec), expected, reason: 'icon');
  expect(_spinnerColor(spec), expected, reason: 'spinner');
}

typedef _CheckboxMetrics = ({
  double box,
  double indicator,
  double gap,
  double labelSize,
});

/// Resolves a recipe against a theme and a set of widget states.
///
/// One generic body because every recipe in this layer is the same shape: a
/// `Style<S>` built from tokens, resolved under a `MixScope` and a set of
/// widget states.
Future<StyleSpec<S>> _resolve<S extends Spec<S>>(
  WidgetTester tester,
  Style<S> style, {
  required AcmeThemeData theme,
  Set<WidgetState> states = const {},
  FocusHighlightStrategy highlightStrategy =
      FocusHighlightStrategy.alwaysTraditional,
}) async {
  final previousStrategy = FocusManager.instance.highlightStrategy;
  FocusManager.instance.highlightStrategy = highlightStrategy;
  addTearDown(() => FocusManager.instance.highlightStrategy = previousStrategy);

  late StyleSpec<S> resolved;
  await tester.pumpWidget(
    AcmeThemeScope(
      data: theme,
      child: _host(
        WidgetStateProvider(
          states: states,
          child: _Probe((context) => resolved = style.build(context)),
        ),
      ),
    ),
  );

  return resolved;
}

/// Resolves the Checkbox recipe the way a consumer sees it: under a real
/// `AcmeCheckbox`.
///
/// Bare `Style.build` cannot stand in for the colored fragments. Remix keys
/// its indeterminate variant on
/// `NakedCheckboxState.maybeOf(context)?.isChecked == null`, which is equally
/// true when there is no checkbox above the context at all — so a resolution
/// with no widget silently wears the checked surface. Driving the real states
/// also proves the recipe against the interactions Remix actually reports.
Future<StyleSpec<CheckboxSpec>> _checkboxSpec(
  WidgetTester tester, {
  required AcmeThemeData theme,
  bool? selected = false,
  bool tristate = false,
  bool enabled = true,
  bool hovered = false,
  bool focused = false,
  AcmeCheckboxSize size = AcmeCheckboxSize.medium,
  CheckboxStyler? style,
  FocusHighlightStrategy highlightStrategy =
      FocusHighlightStrategy.alwaysTraditional,
}) async {
  final previousStrategy = FocusManager.instance.highlightStrategy;
  FocusManager.instance.highlightStrategy = highlightStrategy;
  addTearDown(() => FocusManager.instance.highlightStrategy = previousStrategy);

  final focusNode = FocusNode(debugLabel: 'checkbox-probe');
  addTearDown(focusNode.dispose);

  await _pumpInScope(
    tester,
    AcmeCheckbox(
      size: size,
      style: style ?? const CheckboxStyler.create(),
      selected: selected,
      tristate: tristate,
      enabled: enabled,
      label: 'Probe',
      focusNode: focusNode,
      onChanged: (_) {},
    ),
    theme: theme,
  );
  await tester.pumpAndSettle();

  if (focused) {
    focusNode.requestFocus();
    await tester.pumpAndSettle();
  }
  if (hovered) {
    final pointer = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(pointer.removePointer);
    await pointer.addPointer(location: Offset.zero);
    await tester.pump();
    await pointer.moveTo(tester.getCenter(find.byType(AcmeCheckbox)));
    await tester.pumpAndSettle();
  }

  return _resolvedSpecOf<CheckboxSpec>(tester);
}

Future<StyleSpec<TabSpec>> _resolveTab(
  WidgetTester tester, {
  required AcmeThemeData theme,
  AcmeTabSize size = AcmeTabSize.medium,
  TabStyler? style,
  Set<WidgetState> states = const {},
}) => _resolve(
  tester,
  acmeTabStyle(size: size, style: style ?? const TabStyler.create()),
  theme: theme,
  states: states,
);

Future<StyleSpec<TabBarSpec>> _resolveTabBar(
  WidgetTester tester, {
  required AcmeThemeData theme,
  TabBarStyler? style,
}) => _resolve(
  tester,
  acmeTabBarStyle(style: style ?? const TabBarStyler.create()),
  theme: theme,
);

Future<StyleSpec<TabViewSpec>> _resolveTabView(
  WidgetTester tester, {
  required AcmeThemeData theme,
  TabViewStyler? style,
}) => _resolve(
  tester,
  acmeTabViewStyle(style: style ?? const TabViewStyler.create()),
  theme: theme,
);

/// Mounts [tabs] and [views] inside the behavioral `RemixTabs` root.
Future<void> _pumpTabs(
  WidgetTester tester, {
  required String selected,
  required List<Widget> tabs,
  List<Widget> views = const [],
  ValueChanged<String>? onChanged,
  AcmeThemeData theme = const AcmeThemeData.light(),
}) {
  return tester.pumpWidget(
    AcmeThemeScope(
      data: theme,
      child: _host(
        RemixTabs(
          selectedTabId: selected,
          onChanged: onChanged,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AcmeTabBar(
                child: Row(mainAxisSize: MainAxisSize.min, children: tabs),
              ),
              ...views,
            ],
          ),
        ),
      ),
    ),
  );
}

/// The spec a rendered Remix widget actually resolved.
///
/// Remix publishes it below the widget for its own subtree, which is the only
/// place the resolved recipe is observable from outside.
StyleSpec<S> _resolvedSpecOf<S extends Spec<S>>(WidgetTester tester) {
  return tester
      .widget<StyleSpecProvider<S>>(find.byType(StyleSpecProvider<S>))
      .spec;
}

BoxConstraints? _checkboxConstraints(StyleSpec<CheckboxSpec> spec) =>
    spec.spec.container.spec.constraints;

Color? _checkboxBackground(StyleSpec<CheckboxSpec> spec) =>
    _boxBackground(spec.spec.container);

BoxBorder? _checkboxBorder(StyleSpec<CheckboxSpec> spec) =>
    _boxBorder(spec.spec.container);

BorderRadiusGeometry? _checkboxBorderRadius(StyleSpec<CheckboxSpec> spec) =>
    _boxBorderRadius(spec.spec.container);

BoxDecoration? _boxDecoration(StyleSpec<BoxSpec> container) =>
    container.spec.decoration as BoxDecoration?;

Color? _boxBackground(StyleSpec<BoxSpec> container) =>
    _boxDecoration(container)?.color;

BoxBorder? _boxBorder(StyleSpec<BoxSpec> container) =>
    _boxDecoration(container)?.border;

BorderRadiusGeometry? _boxBorderRadius(StyleSpec<BoxSpec> container) =>
    _boxDecoration(container)?.borderRadius;

BoxDecoration? _flexDecoration(StyleSpec<FlexBoxSpec> container) =>
    container.spec.box?.spec.decoration as BoxDecoration?;

BoxBorder? _flexBorder(StyleSpec<FlexBoxSpec> container) =>
    _flexDecoration(container)?.border;

BoxBorder? _flexForegroundBorder(StyleSpec<FlexBoxSpec> container) =>
    (container.spec.box?.spec.foregroundDecoration as BoxDecoration?)?.border;

/// Asserts [content] stays readable where the recipe actually puts it.
///
/// Both colors may be translucent, and the surface may be the page itself, so
/// each layer is composited before measuring: that is what a reader sees.
void _expectReadable(
  Color content,
  Color surface, {
  required Color page,
  required double floor,
  required String reason,
}) {
  final composited = Color.alphaBlend(surface, page);

  expect(
    _contrastRatio(Color.alphaBlend(content, composited), composited),
    greaterThanOrEqualTo(floor),
    reason: reason,
  );
}

/// WCAG 2 contrast ratio between two opaque colors.
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
