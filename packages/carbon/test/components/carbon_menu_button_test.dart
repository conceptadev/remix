import 'package:carbon/carbon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonMenuButton selects an action', (tester) async {
    String? selected;
    await tester.pumpCarbonApp(
      CarbonMenuButton<String>(
        label: 'Create',
        items: const [
          RemixMenuItem(value: 'file', label: 'File'),
          RemixMenuItem(value: 'folder', label: 'Folder'),
        ],
        onSelected: (value) => selected = value,
      ),
    );

    await tester.tap(find.textContaining('Create'));
    await tester.pump();
    await tester.tap(find.text('Folder'));
    await tester.pump();
    expect(selected, 'folder');
  });

  testWidgets('CarbonOverflowMenu uses an accessible trigger label', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonOverflowMenu<String>(
        semanticLabel: 'Row actions',
        items: [RemixMenuItem(value: 'delete', label: 'Delete')],
      ),
    );

    final node = tester.semantics.simulatedAccessibilityTraversal().singleWhere(
      (item) => item.getSemanticsData().label == 'Row actions',
    );
    expect(node, isSemantics(label: 'Row actions', hasTapAction: true));
    semantics.dispose();
  });
}
