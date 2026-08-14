import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonTreeView expands branches and reports selection', (
    tester,
  ) async {
    String? selected;
    Set<String>? expanded;
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      CarbonTreeView<String>(
        semanticLabel: 'Files',
        nodes: const [
          CarbonTreeNode(
            id: 'lib',
            label: 'lib',
            children: [CarbonTreeNode(id: 'main', label: 'main.dart')],
          ),
        ],
        onSelected: (value) => selected = value,
        onExpandedChanged: (value) => expanded = value,
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Files')).role,
      SemanticsRole.list,
    );
    await tester.tap(find.bySemanticsLabel('Expand lib'));
    await tester.pump();
    expect(expanded, {'lib'});
    expect(find.text('main.dart'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('main.dart'));
    expect(selected, 'main');
    semantics.dispose();
  });
}
