import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
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

    test('an empty caller style leaves the recipe untouched', () {
      expect(
        acmeButtonStyle(style: const ButtonStyler.create()),
        acmeButtonStyle(),
      );
    });
  });

  group('AcmeButton generated API', () {
    testWidgets('the unnamed constructor takes dynamic values', (tester) async {
      for (final variant in AcmeButtonVariant.values) {
        for (final size in AcmeButtonSize.values) {
          await _pumpButton(
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
        await _pumpButton(tester, entry.value);

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
      await _pumpButton(
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

      await _pumpButton(
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

      await _pumpButton(
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

      await _pumpButton(
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
      await _pumpButton(
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

      await _pumpButton(
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

      await _pumpButton(
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

      await _pumpButton(
        tester,
        AcmeButton.primary(label: 'Publish', onPressed: () {}),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Publish'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('excludeSemantics hides the whole control', (tester) async {
      final handle = tester.ensureSemantics();

      await _pumpButton(
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

      await _pumpButton(
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

      await _pumpButton(
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
        await _pumpButton(
          tester,
          AcmeButton(size: size, label: 'Saving', onPressed: () {}),
        );
        await tester.pumpAndSettle();
        final idle = tester.getSize(find.byType(AcmeButton));

        await _pumpButton(
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

Widget _host(Widget child) =>
    WidgetsApp(color: const Color(0xFF000000), builder: (_, _) => child);

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
}) async {
  final previousStrategy = FocusManager.instance.highlightStrategy;
  FocusManager.instance.highlightStrategy = highlightStrategy;
  addTearDown(() => FocusManager.instance.highlightStrategy = previousStrategy);

  final effective =
      styler ??
      acmeButtonStyle(
        variant: variant,
        size: size,
        style: style ?? const ButtonStyler.create(),
      );
  late StyleSpec<ButtonSpec> resolved;

  await tester.pumpWidget(
    AcmeThemeScope(
      data: theme,
      child: _host(
        WidgetStateProvider(
          states: states,
          child: _Probe((context) => resolved = effective.build(context)),
        ),
      ),
    ),
  );

  return resolved;
}

Future<void> _pumpButton(
  WidgetTester tester,
  Widget button, {
  AcmeThemeData theme = const AcmeThemeData.light(),
}) {
  return tester.pumpWidget(
    AcmeThemeScope(
      data: theme,
      child: _host(Center(child: button)),
    ),
  );
}

/// The spec the rendered button actually resolved.
///
/// Remix publishes it below `RemixButton` for its own subtree, which is the
/// only place the resolved recipe is observable from outside.
StyleSpec<ButtonSpec> _resolvedSpec(WidgetTester tester) {
  return tester
      .widget<StyleSpecProvider<ButtonSpec>>(
        find.byType(StyleSpecProvider<ButtonSpec>),
      )
      .spec;
}

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
