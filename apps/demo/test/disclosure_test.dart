import 'package:demo/components/disclosure.dart';
import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('Remix use case opens and closes its content', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: FortalScope(child: Builder(builder: buildRemixDisclosureUseCase)),
      ),
    );

    expect(find.byType(RemixDisclosure), findsOneWidget);
    expect(find.textContaining('Standard delivery'), findsOneWidget);
    expect(
      tester
          .getSemantics(find.text('When will my order arrive?'))
          .getSemanticsData()
          .label,
      'When will my order arrive?',
    );

    await tester.tap(find.text('When will my order arrive?'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Standard delivery'), findsNothing);
    semantics.dispose();
  });

  testWidgets('catalog renders every Fortal size and variant', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: FortalScope(
          child: Builder(builder: buildDisclosureCatalogUseCase),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    final matrix = tester.widget<CatalogMatrix>(find.byType(CatalogMatrix));
    expect(matrix.rows, labelsOf(FortalDisclosureVariant.values));
    expect(matrix.columns, labelsOf(FortalDisclosureSize.values));
    expect(
      find.byType(FortalDisclosure),
      findsNWidgets(
        FortalDisclosureVariant.values.length *
            FortalDisclosureSize.values.length,
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
