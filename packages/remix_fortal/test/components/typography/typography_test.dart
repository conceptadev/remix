import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

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

    testWidgets('weights map to the shared Fortal tokens', (tester) async {
      const weights = {
        FortalTextWeight.light: FontWeight.w300,
        FortalTextWeight.regular: FontWeight.w400,
        FortalTextWeight.medium: FontWeight.w500,
        FortalTextWeight.bold: FontWeight.w700,
      };
      for (final entry in weights.entries) {
        await _pump(tester, FortalText(entry.key.name, weight: entry.key));
        expect(_text(tester, entry.key.name).style?.fontWeight, entry.value);
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

  group('focus', () {
    testWidgets('focused link draws the outline without moving layout', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await _pump(
        tester,
        FortalLink('focus me', focusNode: focusNode, onPressed: _noop),
      );
      final idleSize = tester.getSize(find.text('focus me'));

      focusNode.requestFocus();
      await tester.pump();

      final effects = _surface(tester).containerEffects!;
      expect(effects.outline.width, 2);
      expect(effects.outlineOffset, 2);
      expect(tester.getSize(find.text('focus me')), idleSize);
      // Focus replaces the underline rather than stacking both.
      expect(_underlined(tester, 'focus me'), isFalse);
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
        ),
      );
      expect(node.getSemanticsData().linkUrl, url);
      handle.dispose();
    });

    testWidgets('inert link exposes no interactive metadata', (tester) async {
      final handle = tester.ensureSemantics();
      await _pump(tester, const FortalLink('Read more'));

      expect(find.byType(NakedButton), findsNothing);
      expect(
        tester
            .getSemantics(find.bySemanticsLabel('Read more'))
            .getSemanticsData()
            .linkUrl,
        isNull,
      );
      handle.dispose();
    });
  });

  group('interaction', () {
    testWidgets('pointer, Enter, and Space each activate once', (tester) async {
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
}

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
  return widget.style.resolve(tester.element(find.byType(RemixBadge))).spec;
}

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

bool _underlined(WidgetTester tester, String text) =>
    _text(tester, text).style?.decoration == TextDecoration.underline;
