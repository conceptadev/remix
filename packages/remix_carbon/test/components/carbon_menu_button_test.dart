import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
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

    final menu = tester.widget<RemixMenu<String>>(
      find.byType(RemixMenu<String>),
    );
    expect(menu.trigger.builder, isNotNull);
    expect(find.byIcon(CarbonIcons.chevronDown), findsOneWidget);
    expect(
      find.ancestor(
        of: find.byIcon(CarbonIcons.chevronDown),
        matching: find.byWidgetPredicate(
          (widget) => widget is IgnorePointer && widget.ignoring,
        ),
      ),
      findsOneWidget,
    );

    await tester.tapAt(tester.getCenter(find.byIcon(CarbonIcons.chevronDown)));
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
