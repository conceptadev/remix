import 'dart:ui' show PointerDeviceKind, Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixLink', () {
    group('rendering', () {
      testWidgets('renders a label', (tester) async {
        await tester.pumpRemixApp(const RemixLink(label: 'Docs'));
        await tester.pumpAndSettle();

        expect(find.byType(StyledText), findsOneWidget);
        expect(find.text('Docs'), findsOneWidget);
      });

      testWidgets('renders a child instead of a label', (tester) async {
        await tester.pumpRemixApp(
          const RemixLink(
            label: 'ignored',
            child: Icon(Icons.open_in_new, key: ValueKey('icon')),
            // Interactive so the child path is exercised under NakedLink too.
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('icon')), findsOneWidget);
        expect(find.text('ignored'), findsNothing);
      });

      testWidgets('applies the supplied style to the label', (tester) async {
        await tester.pumpRemixApp(
          RemixLink(
            label: 'Styled',
            style: LinkStyler().label(TextStyler().color(Colors.teal)),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.widget<Text>(find.text('Styled')).style?.color,
          Colors.teal,
        );
      });
    });

    group('activation', () {
      testWidgets('tap, Enter, and Numpad Enter each activate once', (
        tester,
      ) async {
        var activations = 0;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixLink(
            label: 'Go',
            focusNode: focusNode,
            enableFeedback: false,
            onPressed: () => activations++,
          ),
        );

        await tester.tap(find.text('Go'));
        expect(activations, 1);

        focusNode.requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        expect(activations, 2);
        await tester.sendKeyEvent(LogicalKeyboardKey.numpadEnter);
        expect(activations, 3);
      });

      testWidgets('Space does not activate a link', (tester) async {
        var activations = 0;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixLink(
            label: 'Go',
            focusNode: focusNode,
            enableFeedback: false,
            onPressed: () => activations++,
          ),
        );

        focusNode.requestFocus();
        await tester.pump();
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        expect(activations, 0);
      });

      testWidgets('a disabled link neither focuses nor activates', (
        tester,
      ) async {
        var activations = 0;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixLink(
            label: 'Go',
            enabled: false,
            focusNode: focusNode,
            onPressed: () => activations++,
          ),
        );

        await tester.tap(find.text('Go'));
        focusNode.requestFocus();
        await tester.pump();

        expect(activations, 0);
        expect(focusNode.hasFocus, isFalse);
      });
    });

    group('semantics', () {
      testWidgets('an actionable link publishes role, URL, and tap', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();
        final url = Uri.parse('https://example.com/docs');

        await tester.pumpRemixApp(
          RemixLink(label: 'Docs', linkUrl: url, onPressed: () {}),
        );

        final node = tester.getSemantics(find.bySemanticsLabel('Docs'));
        final data = node.getSemanticsData();
        expect(data.flagsCollection.isLink, isTrue);
        expect(data.flagsCollection.isButton, isFalse);
        expect(data.flagsCollection.isEnabled, Tristate.isTrue);
        expect(data.hasAction(SemanticsAction.tap), isTrue);
        expect(data.linkUrl, url);
        handle.dispose();
      });

      testWidgets('semanticLabel replaces the visible name', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixLink(
            label: 'Docs',
            semanticLabel: 'Read the documentation',
            semanticHint: 'Opens in a new window',
            onPressed: () {},
          ),
        );

        final data = tester
            .getSemantics(find.bySemanticsLabel('Read the documentation'))
            .getSemanticsData();
        expect(data.label, 'Read the documentation');
        expect(data.hint, 'Opens in a new window');
        handle.dispose();
      });

      testWidgets('a link with no callback is prose, not a disabled control', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(const RemixLink(label: 'Read more'));

        expect(find.byType(NakedLink), findsNothing);
        expect(
          tester.getSemantics(find.bySemanticsLabel('Read more')),
          matchesSemantics(label: 'Read more'),
        );
        handle.dispose();
      });

      // NakedLink gates the Link role on effective-enabled, so a disabled link
      // announces as unavailable text rather than as an unavailable link.
      testWidgets('a disabled link announces disabled and drops the role', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixLink(label: 'Go', enabled: false, onPressed: () {}),
        );

        final data = tester
            .getSemantics(find.bySemanticsLabel('Go'))
            .getSemanticsData();
        expect(data.flagsCollection.isEnabled, Tristate.isFalse);
        expect(data.flagsCollection.isLink, isFalse);
        expect(data.hasAction(SemanticsAction.tap), isFalse);
        handle.dispose();
      });

      testWidgets('excludeSemantics drops the node on both paths', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        for (final onPressed in <VoidCallback?>[null, () {}]) {
          await tester.pumpRemixApp(
            RemixLink(
              label: 'Hidden',
              excludeSemantics: true,
              onPressed: onPressed,
            ),
          );

          expect(find.bySemanticsLabel('Hidden'), findsNothing);
        }
        handle.dispose();
      });

      testWidgets('multi-child content still publishes one link node', (
        tester,
      ) async {
        final handle = tester.ensureSemantics();

        await tester.pumpRemixApp(
          RemixLink(
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Read more'), Icon(Icons.arrow_forward)],
            ),
          ),
        );

        // getSemantics throws if the subtree resolves to more than one node,
        // so this also proves the role and the name landed together rather
        // than splitting across a link node and a separate text node.
        final data = tester
            .getSemantics(find.byType(RemixLink))
            .getSemanticsData();
        expect(data.flagsCollection.isLink, isTrue);
        expect(data.label, 'Read more');
        handle.dispose();
      });
    });

    group('interaction state', () {
      testWidgets('neither path inherits an ancestor widget state', (
        tester,
      ) async {
        // One LinkStyler must behave the same whether or not the link is
        // actionable. The actionable path is isolated by its own Naked state
        // controller; the inert path publishes an empty scope for the same
        // reason. Without that, a link inside a hovered card renders hovered.
        final style = LinkStyler()
            .label(TextStyler().color(Colors.black))
            .onHovered(LinkStyler().label(TextStyler().color(Colors.red)));

        for (final onPressed in <VoidCallback?>[null, () {}]) {
          await tester.pumpRemixApp(
            WidgetStateProvider(
              states: const {WidgetState.hovered},
              child: RemixLink(
                label: 'Nested',
                onPressed: onPressed,
                style: style,
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            tester.widget<Text>(find.text('Nested')).style?.color,
            Colors.black,
            reason: 'onPressed: $onPressed',
          );
        }
      });

      testWidgets('hover and focus reach the resolved style', (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          RemixLink(
            label: 'Stateful',
            focusNode: focusNode,
            onPressed: () {},
            style: LinkStyler()
                .label(TextStyler().color(Colors.black))
                .onHovered(LinkStyler().label(TextStyler().color(Colors.red)))
                .onFocused(LinkStyler().label(TextStyler().color(Colors.blue))),
          ),
        );

        expect(
          tester.widget<Text>(find.text('Stateful')).style?.color,
          Colors.black,
        );

        final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
        addTearDown(mouse.removePointer);
        await mouse.addPointer(location: Offset.zero);
        await mouse.moveTo(tester.getCenter(find.text('Stateful')));
        await tester.pumpAndSettle();
        expect(
          tester.widget<Text>(find.text('Stateful')).style?.color,
          Colors.red,
        );

        await mouse.moveTo(Offset.zero);
        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(
          tester.widget<Text>(find.text('Stateful')).style?.color,
          Colors.blue,
        );
      });
    });

    group('styler helper', () {
      testWidgets('calling a LinkStyler builds a RemixLink', (tester) async {
        var pressed = false;
        await tester.pumpRemixApp(
          LinkStyler()(label: 'Called', onPressed: () => pressed = true),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Called'));
        expect(pressed, isTrue);
      });

      test('LinkStyler.call forwards every widget input', () {
        final style = LinkStyler();
        final url = Uri.parse('https://example.com');
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        final defaults = style(label: 'Default');
        final configured = style(
          label: 'Configured',
          onPressed: () {},
          enabled: false,
          linkUrl: url,
          focusNode: focusNode,
          autofocus: true,
          enableFeedback: false,
          mouseCursor: SystemMouseCursors.basic,
          semanticLabel: 'Name',
          semanticHint: 'Hint',
          excludeSemantics: true,
        );

        expect(defaults.enabled, isTrue);
        expect(defaults.onPressed, isNull);
        expect(defaults.linkUrl, isNull);
        expect(defaults.autofocus, isFalse);
        expect(defaults.enableFeedback, isTrue);
        expect(defaults.mouseCursor, SystemMouseCursors.click);
        expect(defaults.excludeSemantics, isFalse);

        expect(configured.enabled, isFalse);
        expect(configured.onPressed, isNotNull);
        expect(configured.linkUrl, url);
        expect(configured.focusNode, same(focusNode));
        expect(configured.autofocus, isTrue);
        expect(configured.enableFeedback, isFalse);
        expect(configured.mouseCursor, SystemMouseCursors.basic);
        expect(configured.semanticLabel, 'Name');
        expect(configured.semanticHint, 'Hint');
        expect(configured.excludeSemantics, isTrue);
        expect(configured.style, same(style));
      });
    });
  });
}
