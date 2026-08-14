import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonCodeSnippet exposes code and an accessible copy action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var copied = '';
    await tester.pumpCarbonApp(
      CarbonCodeSnippet(
        code: 'flutter test',
        onCopy: (value) => copied = value,
      ),
    );

    expect(find.text('flutter test'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Copy code'));
    await tester.pump();
    expect(copied, 'flutter test');
    expect(find.bySemanticsLabel('Code snippet'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('multi-line snippets can collapse and expand', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonCodeSnippet(
        code: 'one\ntwo\nthree\nfour',
        type: CarbonCodeSnippetType.multi,
        collapsedLines: 2,
      ),
    );

    expect(find.text('Show more'), findsOneWidget);
    await tester.tap(find.text('Show more'));
    await tester.pump();
    expect(find.text('Show less'), findsOneWidget);
  });
}
