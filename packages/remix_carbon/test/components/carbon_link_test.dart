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

    focusNode.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(activations, 1);
    semantics.dispose();
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
}

TextStyle _style(WidgetTester tester, String label) =>
    tester.widget<Text>(find.text(label)).style!;

void _noop() {}
