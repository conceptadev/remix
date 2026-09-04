import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonLink exposes link semantics and keyboard activation', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    var activations = 0;
    await tester.pumpCarbonApp(
      CarbonLink(
        label: 'Carbon guidance',
        focusNode: focusNode,
        onPressed: () => activations++,
      ),
    );

    expect(find.byType(RemixLink), findsOneWidget);

    final node = tester.getSemantics(find.text('Carbon guidance'));
    expect(
      node,
      isSemantics(
        label: 'Carbon guidance',
        isLink: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(focusNode.hasFocus, isTrue);
    expect(
      _style(tester, 'Carbon guidance').decoration,
      TextDecoration.underline,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(activations, 1);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(activations, 1);
    semantics.dispose();
  });

  testWidgets('CarbonLink keeps inline links underlined when disabled', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      const Column(
        children: [
          CarbonLink(label: 'Inline', inline: true, onPressed: _noop),
          CarbonLink(
            label: 'Disabled inline',
            inline: true,
            enabled: false,
            onPressed: _noop,
          ),
        ],
      ),
    );

    expect(_style(tester, 'Inline').decoration, TextDecoration.underline);
    expect(
      _style(tester, 'Disabled inline').decoration,
      TextDecoration.underline,
    );
  });

  testWidgets('CarbonLink uses Carbon size and state tokens', (tester) async {
    await tester.pumpCarbonApp(
      const Column(
        children: [
          CarbonLink(
            label: 'Small',
            size: CarbonLinkSize.small,
            onPressed: _noop,
          ),
          CarbonLink(label: 'Medium', onPressed: _noop),
          CarbonLink(
            label: 'Large',
            size: CarbonLinkSize.large,
            visited: true,
            onPressed: _noop,
          ),
        ],
      ),
    );

    expect(_style(tester, 'Small').fontSize, 12);
    expect(_style(tester, 'Medium').fontSize, 14);
    expect(_style(tester, 'Large').fontSize, 16);
    expect(
      _style(tester, 'Large').color,
      CarbonTokens.linkVisited.resolve(tester.element(find.text('Large'))),
    );
  });

  testWidgets('CarbonLink forwards destination metadata to RemixLink', (
    tester,
  ) async {
    final destination = Uri.parse('https://example.com/carbon');
    await tester.pumpCarbonApp(
      CarbonLink(label: 'Carbon docs', linkUrl: destination, onPressed: _noop),
    );

    final link = tester.widget<RemixLink>(find.byType(RemixLink));
    expect(link.linkUrl, destination);
  });

  testWidgets('CarbonLink forwards its disabled state', (tester) async {
    final semantics = tester.ensureSemantics();
    var activations = 0;
    await tester.pumpCarbonApp(
      CarbonLink(
        label: 'Unavailable',
        enabled: false,
        onPressed: () => activations++,
      ),
    );

    await tester.tap(find.text('Unavailable'));

    expect(activations, 0);
    expect(
      tester.getSemantics(find.text('Unavailable')),
      isSemantics(
        label: 'Unavailable',
        hasEnabledState: true,
        isEnabled: false,
        hasTapAction: false,
      ),
    );
    expect(
      _style(tester, 'Unavailable').color,
      CarbonTokens.textDisabled.resolve(
        tester.element(find.text('Unavailable')),
      ),
    );
    semantics.dispose();
  });
}

TextStyle _style(WidgetTester tester, String label) =>
    tester.widget<Text>(find.text(label)).style!;

void _noop() {}
