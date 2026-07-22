import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixCard', () {
    testWidgets('is a passive semantic-preserving container by default', (
      tester,
    ) async {
      await tester.pumpRemixApp(const RemixCard(child: Text('Passive card')));

      expect(find.byKey(const ValueKey('remix-card-surface')), findsOneWidget);
      expect(find.byType(NakedButton), findsNothing);
      final semantics = tester.getSemantics(find.text('Passive card'));
      expect(semantics.getSemanticsData().role, ui.SemanticsRole.none);
      expect(semantics.label, contains('Passive card'));
    });

    testWidgets('adds pointer and keyboard activation only with a callback', (
      tester,
    ) async {
      var activations = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpRemixApp(
        RemixCard(
          onTap: () => activations++,
          focusNode: focusNode,
          child: const Text('Interactive card'),
        ),
      );

      expect(find.byType(NakedButton), findsOneWidget);
      await tester.tap(find.text('Interactive card'));
      expect(activations, 1);

      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(activations, 2);

      final semantics = tester.getSemantics(find.text('Interactive card'));
      expect(semantics.getSemanticsData().flagsCollection.isButton, isTrue);
    });

    testWidgets('forwards long-press and press-state callbacks', (
      tester,
    ) async {
      var longPresses = 0;
      final pressStates = <bool>[];
      await tester.pumpRemixApp(
        RemixCard(
          onLongPress: () => longPresses++,
          onPressChange: pressStates.add,
          child: const SizedBox(width: 80, height: 40),
        ),
      );

      await tester.longPress(find.byType(RemixCard));

      expect(longPresses, 1);
      expect(pressStates, containsAllInOrder([true, false]));
    });

    testWidgets('a disabled interactive card does not invoke callbacks', (
      tester,
    ) async {
      var activations = 0;
      await tester.pumpRemixApp(
        RemixCard(
          onTap: () => activations++,
          enabled: false,
          child: const Text('Disabled card'),
        ),
      );

      await tester.tap(find.text('Disabled card'));
      expect(activations, 0);
      final semantics = tester.getSemantics(find.text('Disabled card'));
      expect(semantics.getSemanticsData().flagsCollection.isButton, isTrue);
      expect(
        semantics.getSemanticsData().hasAction(ui.SemanticsAction.tap),
        isFalse,
      );
    });

    testWidgets('labels a passive card without making it a button', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixCard(
          semanticLabel: 'Account summary',
          child: Text('Balance'),
        ),
      );

      final semantics = tester.getSemantics(
        find.bySemanticsLabel(RegExp('Account summary')),
      );
      expect(semantics.getSemanticsData().role, ui.SemanticsRole.none);
      expect(find.byType(NakedButton), findsNothing);
    });

    testWidgets('can exclude either passive or interactive content semantics', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixCard(
          onTap: () {},
          semanticLabel: 'Hidden card',
          excludeSemantics: true,
          child: const Text('Hidden content'),
        ),
      );

      expect(find.bySemanticsLabel(RegExp('Hidden')), findsNothing);
    });

    testWidgets('wires the resolved surface layer to the shared renderer', (
      tester,
    ) async {
      const surface = RemixSurfaceLayerSpec(
        shadows: [RemixPaintShadow(color: Colors.red)],
      );
      const overlay = RemixSurfaceLayerSpec(
        shadows: [
          RemixPaintShadow(kind: RemixPaintShadowKind.inset, blurRadius: 1),
        ],
      );
      await tester.pumpRemixApp(
        const RemixCard(
          styleSpec: RemixCardSpec(
            container: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            effects: RemixSurfaceEffectsSpec(
              background: surface,
              foreground: overlay,
              backdropBlur: 4,
            ),
          ),
          child: Text('Surface card'),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    test('styler call forwards interaction and semantic fields', () {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      void onTap() {}
      final card = RemixCardStyler()
          .height(40)
          .call(
            onTap: onTap,
            enabled: false,
            focusNode: focusNode,
            autofocus: true,
            focusOnTap: true,
            semanticLabel: 'Card',
            excludeSemantics: true,
          );

      expect(card.onTap, same(onTap));
      expect(card.enabled, isFalse);
      expect(card.focusNode, same(focusNode));
      expect(card.autofocus, isTrue);
      expect(card.focusOnTap, isTrue);
      expect(card.semanticLabel, 'Card');
      expect(card.excludeSemantics, isTrue);
    });
  });
}
