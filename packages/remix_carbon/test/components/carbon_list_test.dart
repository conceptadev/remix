import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('Carbon lists expose list and list-item roles', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonUnorderedList(
        children: [
          CarbonListItem(child: Text('First')),
          CarbonListItem(child: Text('Second')),
        ],
      ),
    );

    expect(
      tester.getSemantics(find.byType(CarbonUnorderedList)).role,
      SemanticsRole.list,
    );
    expect(
      tester.getSemantics(find.byType(CarbonListItem).at(0)).role,
      SemanticsRole.listItem,
    );
    expect(
      tester.getSemantics(find.byType(CarbonListItem).at(1)).role,
      SemanticsRole.listItem,
    );
    semantics.dispose();
  });

  testWidgets('ordered lists render stable ordinal markers', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonOrderedList(
        start: 3,
        children: [
          CarbonListItem(child: Text('Third')),
          CarbonListItem(child: Text('Fourth')),
        ],
      ),
    );

    expect(find.text('3.'), findsOneWidget);
    expect(find.text('4.'), findsOneWidget);
  });
}
