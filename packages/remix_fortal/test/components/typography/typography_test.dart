import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('metrics', () {
    testWidgets('all nine sizes resolve the pinned scale across scaling', (
      tester,
    ) async {
      const fontSizes = [12.0, 14, 16, 18, 20, 24, 28, 35, 60];
      for (final (scaling, factor) in const [
        (FortalScaling.percent90, 0.9),
        (FortalScaling.percent100, 1.0),
        (FortalScaling.percent110, 1.1),
      ]) {
        for (var i = 0; i < FortalTextSize.values.length; i++) {
          final label = '${scaling.name}-$i';
          await _pump(
            tester,
            FortalText(label, size: FortalTextSize.values[i]),
            scaling: scaling,
          );
          expect(
            _text(tester, label).style?.fontSize,
            closeTo(fontSizes[i] * factor, 1e-9),
          );
        }
      }
    });

    testWidgets('heading keeps the pinned line boxes and bold size6 default', (
      tester,
    ) async {
      const fontSizes = [12.0, 14, 16, 18, 20, 24, 28, 35, 60];
      const lineHeights = [16.0, 18, 22, 24, 26, 30, 36, 40, 60];
      for (var i = 0; i < FortalTextSize.values.length; i++) {
        final label = 'h$i';
        await _pump(
          tester,
          FortalHeading(label, size: FortalTextSize.values[i]),
        );
        final style = _text(tester, label).style!;
        expect(style.fontSize, closeTo(fontSizes[i], 1e-9));
        expect(style.fontSize! * style.height!, closeTo(lineHeights[i], 1e-9));
      }

      await _pump(tester, const FortalHeading('default'));
      final style = _text(tester, 'default').style!;
      expect(style.fontSize, 24);
      expect(style.fontWeight, FontWeight.w700);
    });

    testWidgets('code applies the nested Radix font-size adjustments', (
      tester,
    ) async {
      await _pump(
        tester,
        const Column(
          children: [
            FortalCode.soft('ambient'),
            FortalCode.soft('explicit', size: FortalTextSize.size2),
            FortalCode.ghost('ghost', size: FortalTextSize.size2),
          ],
        ),
      );

      final ambient = _text(tester, 'ambient').style!;
      expect(ambient.fontSize, closeTo(20 * 0.95 * 0.95, 1e-9));
      expect(ambient.height, 1.25);
      expect(ambient.letterSpacing, closeTo(2 - 0.007 * 18.05, 1e-9));
      expect(ambient.fontFamily, 'Menlo');

      final explicit = _text(tester, 'explicit').style!;
      expect(explicit.fontSize, closeTo(14 * 0.95 * 0.95, 1e-9));
      expect(explicit.fontSize! * explicit.height!, closeTo(20, 1e-9));

      // Ghost keeps the outer adjustment only.
      expect(_text(tester, 'ghost').style!.fontSize, closeTo(14 * 0.95, 1e-9));
    });

    testWidgets('kbd uses distinct unsized and explicit type factors', (
      tester,
    ) async {
      await _pump(
        tester,
        const Column(
          children: [
            FortalKbd.soft('ambient'),
            FortalKbd.soft('explicit', size: FortalTextSize.size2),
          ],
        ),
      );

      expect(_text(tester, 'ambient').style?.fontSize, 15);
      final explicit = _text(tester, 'explicit').style!;
      expect(explicit.fontSize, closeTo(11.2, 1e-9));
      expect(explicit.height, 1.7);
      expect(explicit.wordSpacing, closeTo(-1.12, 1e-9));
      expect(explicit.fontWeight, FontWeight.normal);
    });

    testWidgets('an explicit kbd size scales its letter spacing by 0.8 too', (
      tester,
    ) async {
      // Upstream `--letter-spacing-N` is an em, so it re-resolves against
      // Kbd's own 0.8em rather than the token's own font size.
      for (var i = 0; i < FortalTextSize.values.length; i++) {
        final size = FortalTextSize.values[i];
        final label = 'kbd$i';
        await _pump(tester, FortalKbd.soft(label, size: size));
        final style = _text(tester, label).style!;
        expect(style.fontSize, closeTo(_fontSizes[i] * 0.8, 1e-9));
        expect(style.letterSpacing, closeTo(_letterSpacings[i] * 0.8, 1e-9));
        expect(
          _surface(tester).container.spec.constraints?.minWidth,
          closeTo(1.75 * _fontSizes[i] * 0.8, 1e-9),
          reason: size.name,
        );
      }

      // The inherited path keeps Flutter's absolute letter-spacing
      // inheritance; there is no em intent left to rescale.
      await _pump(tester, const FortalKbd.soft('inherited'));
      expect(_text(tester, 'inherited').style?.letterSpacing, 2);
    });

    testWidgets('code letter spacing adds the pinned -0.007em to the token', (
      tester,
    ) async {
      for (var i = 0; i < FortalTextSize.values.length; i++) {
        final size = FortalTextSize.values[i];
        final label = 'code$i';
        await _pump(tester, FortalCode.soft(label, size: size));
        final style = _text(tester, label).style!;
        final fontSize = _fontSizes[i] * 0.95 * 0.95;
        expect(style.fontSize, closeTo(fontSize, 1e-9));
        expect(
          style.letterSpacing,
          closeTo(_letterSpacings[i] - 0.007 * fontSize, 1e-9),
          reason: size.name,
        );
      }
    });

    testWidgets('weights map to the shared Fortal tokens', (tester) async {
      const weights = {
        FortalTextWeight.light: FontWeight.w300,
        FortalTextWeight.regular: FontWeight.w400,
        FortalTextWeight.medium: FontWeight.w500,
        FortalTextWeight.bold: FontWeight.w700,
      };
      // Text, Heading, Code, and Link all read the same four weight tokens;
      // Kbd deliberately pins regular regardless of the ambient style.
      final builders = <String, Widget Function(String, FortalTextWeight)>{
        'text': (label, weight) => FortalText(label, weight: weight),
        'heading': (label, weight) => FortalHeading(label, weight: weight),
        'code': (label, weight) => FortalCode.soft(label, weight: weight),
        'link': (label, weight) =>
            FortalLink(label, weight: weight, onPressed: _noop),
      };

      for (final builder in builders.entries) {
        for (final entry in weights.entries) {
          final label = '${builder.key}-${entry.key.name}';
          await _pump(tester, builder.value(label, entry.key));
          expect(
            _text(tester, label).style?.fontWeight,
            entry.value,
            reason: label,
          );
        }
      }
    });
  });

  group('flow', () {
    testWidgets('truncate wins over softWrap and TextAlign passes through', (
      tester,
    ) async {
      await _pump(
        tester,
        const Column(
          children: [
            FortalText('wrap'),
            FortalText('nowrap', softWrap: false),
            FortalText('truncated', truncate: true),
            FortalText('aligned', align: TextAlign.end),
          ],
        ),
      );

      expect(_text(tester, 'wrap').softWrap, isTrue);
      expect(_text(tester, 'nowrap').softWrap, isFalse);
      expect(_text(tester, 'truncated').softWrap, isFalse);
      expect(_text(tester, 'truncated').maxLines, 1);
      expect(_text(tester, 'truncated').overflow, TextOverflow.ellipsis);
      // start/end are only reachable now that Flutter's TextAlign is used.
      expect(_text(tester, 'aligned').textAlign, TextAlign.end);
    });
  });

  group('regressions', () {
    testWidgets('em geometry survives an ambient style with no fontSize', (
      tester,
    ) async {
      await _pump(
        tester,
        Column(
          children: [
            const FortalCode.soft('code'),
            const FortalKbd.soft('kbd'),
            const FortalLink('inert'),
            FortalLink('actionable', onPressed: _noop),
          ],
        ),
        ambient: const TextStyle(color: Colors.purple),
      );

      expect(tester.takeException(), isNull);
      expect(
        _text(tester, 'code').style?.fontSize,
        closeTo(kDefaultFontSize * 0.95 * 0.95, 1e-9),
      );
      expect(
        _text(tester, 'kbd').style?.fontSize,
        closeTo(kDefaultFontSize * 0.75, 1e-9),
      );
    });

    testWidgets('inert links never underline; upstream gates on anchors', (
      tester,
    ) async {
      await _pump(
        tester,
        const Column(
          children: [
            FortalLink('inert always', underline: FortalLinkUnderline.always),
            FortalLink(
              'inert high auto',
              highContrast: true,
              underline: FortalLinkUnderline.auto,
            ),
          ],
        ),
      );

      expect(_underlined(tester, 'inert always'), isFalse);
      expect(_underlined(tester, 'inert high auto'), isFalse);
    });

    testWidgets('actionable links underline per mode', (tester) async {
      await _pump(
        tester,
        Column(
          children: [
            FortalLink(
              'always',
              underline: FortalLinkUnderline.always,
              onPressed: _noop,
            ),
            FortalLink(
              'none',
              underline: FortalLinkUnderline.none,
              onPressed: _noop,
            ),
            FortalLink(
              'high auto',
              highContrast: true,
              underline: FortalLinkUnderline.auto,
              onPressed: _noop,
            ),
          ],
        ),
      );

      expect(_underlined(tester, 'always'), isTrue);
      expect(_underlined(tester, 'none'), isFalse);
      expect(_underlined(tester, 'high auto'), isTrue);
    });
  });

  group('code variants', () {
    testWidgets('every variant resolves the pinned fill and foreground', (
      tester,
    ) async {
      for (final brightness in Brightness.values) {
        final tokens = await _accentTokens(tester, brightness);
        for (final highContrast in [false, true]) {
          for (final variant in FortalCodeVariant.values) {
            await _pump(
              tester,
              FortalCode(
                '${variant.name}-$highContrast',
                variant: variant,
                highContrast: highContrast,
              ),
              brightness: brightness,
            );
            final fill = _boxColor(_surface(tester));
            final fg = _text(
              tester,
              '${variant.name}-$highContrast',
            ).style?.color;

            switch (variant) {
              case FortalCodeVariant.solid:
                expect(fill, highContrast ? tokens.accent12 : tokens.accentA9);
                expect(
                  fg,
                  highContrast ? tokens.accent1 : tokens.accentContrast,
                );
              case FortalCodeVariant.soft:
                expect(fill, tokens.accentA3);
                expect(fg, highContrast ? tokens.accent12 : tokens.accentA11);
              case FortalCodeVariant.outline:
                expect(fg, highContrast ? tokens.accent12 : tokens.accentA11);
              case FortalCodeVariant.ghost:
                // Upstream gates ghost's colour on an explicit accent, so an
                // opt-out ghost inherits the ambient foreground.
                expect(fill, isNull);
                expect(fg, isNull);
            }
          }
        }
      }
    });

    testWidgets('outline draws one ring, two at high contrast', (tester) async {
      final tokens = await _accentTokens(tester, Brightness.light);
      for (final highContrast in [false, true]) {
        await _pump(
          tester,
          FortalCode.outline(
            'ring-$highContrast',
            size: FortalTextSize.size9,
            highContrast: highContrast,
          ),
        );
        final shadows = _surface(
          tester,
        ).containerEffects!.behindContent!.shadows;
        expect(shadows, hasLength(highContrast ? 2 : 1));
        expect(
          shadows.first.color,
          highContrast ? tokens.accentA7 : tokens.accentA8,
        );
        for (final shadow in shadows) {
          expect(shadow.spreadRadius, closeTo(0.033 * 60 * 0.95 * 0.95, 1e-9));
        }
      }
    });

    testWidgets('ghost gains the accent foreground only when opted in', (
      tester,
    ) async {
      final tokens = await _accentTokens(tester, Brightness.light);
      await _pump(
        tester,
        const Column(
          children: [
            FortalCode.ghost('plain ghost'),
            FortalCode.ghost('accent ghost', accent: true),
            FortalCode.ghost(
              'accent hc ghost',
              accent: true,
              highContrast: true,
            ),
          ],
        ),
      );
      expect(_text(tester, 'plain ghost').style?.color, isNull);
      expect(_text(tester, 'accent ghost').style?.color, tokens.accentA11);
      expect(_text(tester, 'accent hc ghost').style?.color, tokens.accent12);
    });

    testWidgets('truncation and kbd min-width reach the rendered box', (
      tester,
    ) async {
      await _pump(
        tester,
        const SizedBox(
          width: 60,
          child: FortalCode.soft('a very long code sample', truncate: true),
        ),
      );
      final code = _text(tester, 'a very long code sample');
      expect(code.maxLines, 1);
      expect(code.overflow, TextOverflow.ellipsis);

      await _pump(
        tester,
        const FortalKbd.soft('x', size: FortalTextSize.size2),
      );
      expect(
        _surface(tester).container.spec.constraints?.minWidth,
        closeTo(1.75 * 14 * 0.8, 1e-9),
      );
    });
  });

  group('kbd variants', () {
    testWidgets('classic and soft resolve their pinned fills in both modes', (
      tester,
    ) async {
      for (final brightness in Brightness.values) {
        final gray1 = await _resolveToken(
          tester,
          FortalTokens.gray1,
          brightness: brightness,
        );
        final grayA3 = await _resolveToken(
          tester,
          FortalTokens.grayA3,
          brightness: brightness,
        );
        final gray12 = await _resolveToken(
          tester,
          FortalTokens.gray12,
          brightness: brightness,
        );

        for (final (variant, fill) in [
          (FortalKbdVariant.classic, gray1),
          (FortalKbdVariant.soft, grayA3),
        ]) {
          final label = '${variant.name}-${brightness.name}';
          await _pump(
            tester,
            FortalKbd(label, variant: variant),
            brightness: brightness,
          );
          expect(_boxColor(_surface(tester)), fill, reason: label);
          expect(_text(tester, label).style?.color, gray12, reason: label);
        }
      }
    });

    testWidgets('soft draws no key-cap stack', (tester) async {
      await _pump(tester, const FortalKbd.soft('soft'));
      expect(_surface(tester).containerEffects?.behindContent, isNull);
    });
  });

  group('link', () {
    testWidgets('underline thickness follows the pinned min/max ramp', (
      tester,
    ) async {
      // Upstream is `min(2px, max(1px, 0.05em))`, so the ramp is flat at 1
      // through size5, rises through size8, and clamps at 2 for size9.
      const expected = [1.0, 1, 1, 1, 1, 1.2, 1.4, 1.75, 2];
      for (var i = 0; i < FortalTextSize.values.length; i++) {
        final size = FortalTextSize.values[i];
        final label = 'link$i';
        await _pump(
          tester,
          FortalLink(
            label,
            size: size,
            underline: FortalLinkUnderline.always,
            onPressed: _noop,
          ),
        );
        final style = _text(tester, label).style!;
        expect(style.fontSize, closeTo(_fontSizes[i], 1e-9));
        expect(
          style.decorationThickness,
          closeTo(expected[i], 1e-9),
          reason: size.name,
        );
        expect(style.decorationStyle, TextDecorationStyle.solid);
      }
    });

    testWidgets('an unlined link carries no decoration metrics', (
      tester,
    ) async {
      await _pump(
        tester,
        FortalLink(
          'plain',
          underline: FortalLinkUnderline.none,
          onPressed: _noop,
        ),
      );
      final style = _text(tester, 'plain').style!;
      expect(style.decoration, anyOf(isNull, TextDecoration.none));
      expect(style.decorationThickness, isNull);
    });

    testWidgets('foreground follows accent and high contrast in both modes', (
      tester,
    ) async {
      for (final brightness in Brightness.values) {
        final accentA11 = await _resolveToken(
          tester,
          FortalTokens.accentA11,
          brightness: brightness,
        );
        final accent12 = await _resolveToken(
          tester,
          FortalTokens.accent12,
          brightness: brightness,
        );

        await _pump(
          tester,
          Column(
            children: [
              FortalLink('plain-${brightness.name}', onPressed: _noop),
              FortalLink(
                'high-${brightness.name}',
                highContrast: true,
                onPressed: _noop,
              ),
            ],
          ),
          brightness: brightness,
        );
        expect(
          _text(tester, 'plain-${brightness.name}').style?.color,
          accentA11,
        );
        expect(_text(tester, 'high-${brightness.name}').style?.color, accent12);
      }
    });

    testWidgets('high-contrast auto underlines from a different accent step', (
      tester,
    ) async {
      final accentA5 = await _resolveToken(tester, FortalTokens.accentA5);
      final accentA6 = await _resolveToken(tester, FortalTokens.accentA6);
      final grayA6 = await _resolveToken(tester, FortalTokens.grayA6);

      await _pump(
        tester,
        Column(
          children: [
            FortalLink(
              'always',
              underline: FortalLinkUnderline.always,
              onPressed: _noop,
            ),
            FortalLink(
              'auto high',
              underline: FortalLinkUnderline.auto,
              highContrast: true,
              onPressed: _noop,
            ),
          ],
        ),
      );

      // Color.lerp is the recorded sRGB approximation of Radix's OKLab mix.
      expect(
        _text(tester, 'always').style?.decorationColor,
        Color.lerp(accentA5, grayA6, 0.5),
      );
      expect(
        _text(tester, 'auto high').style?.decorationColor,
        Color.lerp(accentA6, grayA6, 0.5),
      );
    });

    testWidgets('size and weight resolve the shared typography tokens', (
      tester,
    ) async {
      const weights = {
        FortalTextWeight.light: FontWeight.w300,
        FortalTextWeight.regular: FontWeight.w400,
        FortalTextWeight.medium: FontWeight.w500,
        FortalTextWeight.bold: FontWeight.w700,
      };
      for (final entry in weights.entries) {
        await _pump(
          tester,
          FortalLink(
            entry.key.name,
            size: FortalTextSize.size4,
            weight: entry.key,
            onPressed: _noop,
          ),
        );
        final style = _text(tester, entry.key.name).style!;
        expect(style.fontWeight, entry.value);
        expect(style.fontSize, 18);
      }
    });

    testWidgets('flow settings reach an actionable and an inert link', (
      tester,
    ) async {
      await _pump(
        tester,
        Column(
          children: [
            FortalLink('wrapped', onPressed: _noop),
            FortalLink('clipped', truncate: true, onPressed: _noop),
            const FortalLink('inert clipped', truncate: true),
          ],
        ),
      );

      expect(_text(tester, 'wrapped').softWrap, isTrue);
      for (final label in ['clipped', 'inert clipped']) {
        expect(_text(tester, label).softWrap, isFalse, reason: label);
        expect(_text(tester, label).maxLines, 1, reason: label);
        expect(
          _text(tester, label).overflow,
          TextOverflow.ellipsis,
          reason: label,
        );
      }
    });
  });

  group('focus', () {
    testWidgets('link focus treatment follows the highlight mode', (
      tester,
    ) async {
      final previousStrategy = FocusManager.instance.highlightStrategy;
      addTearDown(() {
        FocusManager.instance.highlightStrategy = previousStrategy;
      });
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await _pump(
        tester,
        FortalLink(
          'focus me',
          underline: FortalLinkUnderline.always,
          focusNode: focusNode,
          onPressed: _noop,
        ),
      );
      final idleSize = tester.getSize(find.text('focus me'));
      expect(_underlined(tester, 'focus me'), isTrue);

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      expect(focusNode.hasFocus, isTrue);
      expect(
        _linkSurface(tester, 'focus me').containerEffects?.outline.width ?? 0,
        0,
      );
      expect(_underlined(tester, 'focus me'), isTrue);
      expect(tester.getSize(find.text('focus me')), idleSize);

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
      await tester.pump();

      final effects = _linkSurface(tester, 'focus me').containerEffects!;
      expect(effects.outline.width, 2);
      expect(effects.outlineOffset, 2);
      expect(_underlined(tester, 'focus me'), isFalse);
      expect(tester.getSize(find.text('focus me')), idleSize);

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      await tester.pump();

      expect(
        _linkSurface(tester, 'focus me').containerEffects?.outline.width ?? 0,
        0,
      );
      expect(_underlined(tester, 'focus me'), isTrue);
    });

    testWidgets('focus-visible outline takes precedence over hover underline', (
      tester,
    ) async {
      final previousStrategy = FocusManager.instance.highlightStrategy;
      addTearDown(() {
        FocusManager.instance.highlightStrategy = previousStrategy;
      });
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await _pump(
        tester,
        FortalLink(
          'hover me',
          underline: FortalLinkUnderline.hover,
          focusNode: focusNode,
          onPressed: _noop,
        ),
      );
      expect(_underlined(tester, 'hover me'), isFalse);

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(find.text('hover me')));
      await tester.pump();
      expect(_underlined(tester, 'hover me'), isTrue);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(
        _linkSurface(tester, 'hover me').containerEffects?.outline.width,
        2,
      );
      expect(_underlined(tester, 'hover me'), isFalse);

      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      await tester.pump();
      expect(
        _linkSurface(tester, 'hover me').containerEffects?.outline.width ?? 0,
        0,
      );
      expect(_underlined(tester, 'hover me'), isTrue);
    });
  });

  group('theme', () {
    for (final brightness in Brightness.values) {
      testWidgets('kbd classic keeps all six ${brightness.name} layers', (
        tester,
      ) async {
        await _pump(
          tester,
          const FortalKbd.classic('classic'),
          brightness: brightness,
        );

        final shadows = _surface(
          tester,
        ).containerEffects!.behindContent!.shadows;
        expect(shadows, hasLength(6));
        expect(shadows.map((s) => s.kind), const [
          RemixBoxShadowKind.inset,
          RemixBoxShadowKind.inset,
          RemixBoxShadowKind.inset,
          RemixBoxShadowKind.inset,
          RemixBoxShadowKind.outer,
          RemixBoxShadowKind.outer,
        ]);
      });
    }

    testWidgets('neutral and accent colours differ between light and dark', (
      tester,
    ) async {
      final resolved = <Brightness, (Color?, Color?)>{};
      for (final brightness in Brightness.values) {
        await _pump(
          tester,
          const Column(
            children: [
              FortalKbd.soft('kbd'),
              FortalText('accent', accent: true),
            ],
          ),
          brightness: brightness,
        );
        resolved[brightness] = (
          _text(tester, 'kbd').style?.color,
          _text(tester, 'accent').style?.color,
        );
      }

      // Guards the class of bug where a stale scope pins tokens to one theme.
      expect(
        resolved[Brightness.light]!.$1,
        isNot(resolved[Brightness.dark]!.$1),
      );
      expect(
        resolved[Brightness.light]!.$2,
        isNot(resolved[Brightness.dark]!.$2),
      );
    });
  });

  group('semantics', () {
    testWidgets('heading publishes one exact header node', (tester) async {
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        const FortalHeading(
          'Visual title',
          semanticLabel: 'Chapter title',
          headingLevel: 4,
          size: FortalTextSize.size2,
        ),
      );

      final node = tester.getSemantics(find.bySemanticsLabel('Chapter title'));
      expect(node, matchesSemantics(label: 'Chapter title', isHeader: true));
      expect(node.getSemanticsData().headingLevel, 4);
      // Visual size stays independent of the semantic level.
      expect(_text(tester, 'Visual title').style?.fontSize, 14);
      handle.dispose();
    });

    testWidgets('kbd publishes one keyboard-key node without an action', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        const FortalKbd('Escape', semanticLabel: 'Escape key'),
      );

      expect(
        tester.getSemantics(find.bySemanticsLabel('Escape key')),
        matchesSemantics(label: 'Escape key', isKeyboardKey: true),
      );
      handle.dispose();
    });

    testWidgets('actionable link is one link node with no nested button', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final url = Uri.parse('https://example.com/docs');
      await _pump(tester, FortalLink('Docs', linkUrl: url, onPressed: _noop));

      final node = tester.getSemantics(find.bySemanticsLabel('Docs'));
      expect(
        node,
        matchesSemantics(
          label: 'Docs',
          isLink: true,
          isFocusable: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
          // NakedLink publishes the focus stop through the same node, so
          // assistive tech can move focus here without a separate target.
          hasFocusAction: true,
        ),
      );
      expect(node.getSemanticsData().linkUrl, url);
      expect(find.byType(NakedButton), findsNothing);
      handle.dispose();
    });

    testWidgets('inert link is prose, not a disabled control', (tester) async {
      final handle = tester.ensureSemantics();
      await _pump(tester, const FortalLink('Read more'));

      expect(find.byType(NakedLink), findsNothing);
      // No enabled state either: a link with no callback is body text, and
      // announcing it as unavailable would be wrong.
      expect(
        tester.getSemantics(find.bySemanticsLabel('Read more')),
        matchesSemantics(label: 'Read more'),
      );
      handle.dispose();
    });
  });

  group('interaction', () {
    testWidgets('pointer and Enter activate once each; Space does not', (
      tester,
    ) async {
      var activations = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await _pump(
        tester,
        FortalLink(
          'Activate',
          focusNode: focusNode,
          enableFeedback: false,
          onPressed: () => activations++,
        ),
      );

      await tester.tap(find.text('Activate'));
      expect(activations, 1);
      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(activations, 2);
      await tester.sendKeyEvent(LogicalKeyboardKey.numpadEnter);
      expect(activations, 3);
      // A Link takes Enter, not Space. Space scrolls the page for a real
      // anchor; the previous Button-backed recipe activated on it by mistake.
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(activations, 3);
    });

    testWidgets('disabled link cannot focus or activate', (tester) async {
      var activations = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await _pump(
        tester,
        FortalLink(
          'Disabled',
          enabled: false,
          focusNode: focusNode,
          onPressed: () => activations++,
        ),
      );

      await tester.tap(find.text('Disabled'));
      focusNode.requestFocus();
      await tester.pump();
      expect(activations, 0);
      expect(focusNode.hasFocus, isFalse);
    });
  });

  group('accent', () {
    testWidgets('text and heading take the accent only when opted in', (
      tester,
    ) async {
      final accentA11 = await _resolveToken(tester, FortalTokens.accentA11);
      final accent12 = await _resolveToken(tester, FortalTokens.accent12);

      await _pump(
        tester,
        const Column(
          children: [
            FortalText('inherited text'),
            FortalText('accent text', accent: true),
            FortalText('accent hc text', accent: true, highContrast: true),
            FortalHeading('inherited heading'),
            FortalHeading('accent heading', accent: true),
            FortalHeading(
              'accent hc heading',
              accent: true,
              highContrast: true,
            ),
          ],
        ),
      );

      // highContrast alone is inert: upstream gates the colour on the accent.
      expect(_text(tester, 'inherited text').style?.color, isNull);
      expect(_text(tester, 'accent text').style?.color, accentA11);
      expect(_text(tester, 'accent hc text').style?.color, accent12);
      expect(_text(tester, 'inherited heading').style?.color, isNull);
      expect(_text(tester, 'accent heading').style?.color, accentA11);
      expect(_text(tester, 'accent hc heading').style?.color, accent12);
    });

    testWidgets('heading flow settings match the shared text flow', (
      tester,
    ) async {
      await _pump(
        tester,
        const Column(
          children: [
            FortalHeading('heading wrap'),
            FortalHeading('heading nowrap', softWrap: false),
            FortalHeading('heading clipped', truncate: true),
            FortalHeading('heading aligned', align: TextAlign.end),
          ],
        ),
      );

      expect(_text(tester, 'heading wrap').softWrap, isTrue);
      expect(_text(tester, 'heading nowrap').softWrap, isFalse);
      expect(_text(tester, 'heading clipped').maxLines, 1);
      expect(_text(tester, 'heading clipped').overflow, TextOverflow.ellipsis);
      expect(_text(tester, 'heading aligned').textAlign, TextAlign.end);
    });
  });

  group('defaults', () {
    test('public wrappers keep their documented default arguments', () {
      const text = FortalText('t');
      const heading = FortalHeading('h');
      const code = FortalCode('c');
      const kbd = FortalKbd('k');
      const link = FortalLink('l');

      expect(text.size, isNull);
      expect(text.weight, isNull);
      expect(text.align, isNull);
      expect(text.softWrap, isTrue);
      expect(text.truncate, isFalse);
      expect(text.accent, isFalse);
      expect(text.highContrast, isFalse);

      expect(heading.headingLevel, 1);
      expect(heading.size, FortalTextSize.size6);
      expect(heading.weight, FortalTextWeight.bold);
      expect(heading.excludeSemantics, isFalse);

      expect(code.size, isNull);
      expect(code.variant, FortalCodeVariant.soft);
      expect(code.weight, isNull);

      expect(kbd.size, isNull);
      expect(kbd.variant, FortalKbdVariant.classic);
      expect(kbd.excludeSemantics, isFalse);

      expect(link.size, isNull);
      expect(link.weight, isNull);
      expect(link.underline, FortalLinkUnderline.auto);
      expect(link.enabled, isTrue);
      expect(link.onPressed, isNull);
      expect(link.linkUrl, isNull);
      expect(link.autofocus, isFalse);
      expect(link.enableFeedback, isTrue);
      expect(link.mouseCursor, SystemMouseCursors.click);
    });

    test('named variant constructors pin their variant', () {
      expect(const FortalCode.solid('c').variant, FortalCodeVariant.solid);
      expect(const FortalCode.soft('c').variant, FortalCodeVariant.soft);
      expect(const FortalCode.outline('c').variant, FortalCodeVariant.outline);
      expect(const FortalCode.ghost('c').variant, FortalCodeVariant.ghost);
      expect(const FortalKbd.classic('k').variant, FortalKbdVariant.classic);
      expect(const FortalKbd.soft('k').variant, FortalKbdVariant.soft);
    });

    testWidgets('excludeSemantics drops the published node', (tester) async {
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        const Column(
          children: [
            FortalHeading('Silent heading', excludeSemantics: true),
            FortalKbd('Silent key', excludeSemantics: true),
            FortalLink('Silent link', excludeSemantics: true),
          ],
        ),
      );

      for (final label in ['Silent heading', 'Silent key', 'Silent link']) {
        expect(find.bySemanticsLabel(label), findsNothing, reason: label);
      }
      handle.dispose();
    });
  });
}

const _fontSizes = [12.0, 14, 16, 18, 20, 24, 28, 35, 60];
const _letterSpacings = [
  0.0025 * 12,
  0.0,
  0.0,
  -0.0025 * 18,
  -0.005 * 20,
  -0.00625 * 24,
  -0.0075 * 28,
  -0.01 * 35,
  -0.025 * 60,
];

void _noop() {}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  FortalScaling scaling = FortalScaling.percent100,
  Brightness brightness = Brightness.light,
  TextStyle ambient = const TextStyle(
    fontSize: 20,
    height: 1.4,
    letterSpacing: 2,
    color: Colors.purple,
  ),
}) => tester.pumpWidget(
  MaterialApp(
    home: FortalScope(
      scaling: scaling,
      brightness: brightness,
      child: Scaffold(
        body: DefaultTextStyle(style: ambient, child: child),
      ),
    ),
  ),
);

Text _text(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text));

BadgeSpec _surface(WidgetTester tester) {
  final widget = tester.widget<RemixBadge>(find.byType(RemixBadge));
  return widget.styleSpec ??
      widget.style.resolve(tester.element(find.byType(RemixBadge))).spec;
}

/// Reads a link's *resolved* spec.
///
/// [RemixLink] resolves its style beneath the Naked state scope, so reading the
/// widget's own `style` field would report the idle snapshot; the published
/// provider is the only place the hover and focus-visible variants have landed.
LinkSpec _linkSurface(WidgetTester tester, String text) =>
    tester.resolvedSpecOf<LinkSpec>(find.text(text));

Color? _boxColor(BadgeSpec spec) =>
    (spec.container.spec.decoration as BoxDecoration?)?.color;

Future<
  ({
    Color accent1,
    Color accent12,
    Color accentA3,
    Color accentA7,
    Color accentA8,
    Color accentA9,
    Color accentA11,
    Color accentContrast,
  })
>
_accentTokens(WidgetTester tester, Brightness brightness) async {
  late ({
    Color accent1,
    Color accent12,
    Color accentA3,
    Color accentA7,
    Color accentA8,
    Color accentA9,
    Color accentA11,
    Color accentContrast,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      child: Builder(
        builder: (context) {
          Color token(ColorToken value) => MixScope.tokenOf(value, context);
          result = (
            accent1: token(FortalTokens.accent1),
            accent12: token(FortalTokens.accent12),
            accentA3: token(FortalTokens.accentA3),
            accentA7: token(FortalTokens.accentA7),
            accentA8: token(FortalTokens.accentA8),
            accentA9: token(FortalTokens.accentA9),
            accentA11: token(FortalTokens.accentA11),
            accentContrast: token(FortalTokens.accentContrast),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return result;
}

Future<Color> _resolveToken(
  WidgetTester tester,
  ColorToken token, {
  Brightness brightness = Brightness.light,
}) async {
  late Color result;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      child: Builder(
        builder: (context) {
          result = MixScope.tokenOf(token, context);

          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return result;
}

bool _underlined(WidgetTester tester, String text) =>
    _text(tester, text).style?.decoration == TextDecoration.underline;
