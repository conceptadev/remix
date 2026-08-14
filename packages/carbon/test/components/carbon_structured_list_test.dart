import 'dart:ui' show SemanticsRole;

import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonStructuredList renders table roles and selectable rows', (
    tester,
  ) async {
    var selected = false;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonStructuredList(
        semanticLabel: 'Plans',
        rows: [
          const CarbonStructuredListRow(
            header: true,
            cells: [
              CarbonStructuredListCell(child: Text('Plan'), header: true),
              CarbonStructuredListCell(child: Text('Price'), header: true),
            ],
          ),
          CarbonStructuredListRow(
            semanticLabel: 'Starter plan',
            selected: true,
            onPressed: () => selected = true,
            cells: const [
              CarbonStructuredListCell(child: Text('Starter')),
              CarbonStructuredListCell(child: Text(r'$9')),
            ],
          ),
        ],
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Plans')).role,
      SemanticsRole.table,
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Starter plan')),
      isSemantics(isSelected: true, hasSelectedState: true),
    );
    await tester.tap(find.bySemanticsLabel('Starter plan'));
    expect(selected, isTrue);
    semantics.dispose();
  });
}
