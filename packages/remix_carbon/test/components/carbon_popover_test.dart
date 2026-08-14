import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets(
    'CarbonPopover toggles anchored content and disclosure semantics',
    (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpCarbonApp(
        const CarbonPopover(
          semanticLabel: 'More information',
          popoverChild: Text('Popover details'),
          child: Text('Open'),
        ),
      );

      expect(find.text('Popover details'), findsNothing);
      await tester.tap(find.text('Open'));
      await tester.pump();
      expect(find.text('Popover details'), findsOneWidget);
      final triggerNode = tester.semantics
          .simulatedAccessibilityTraversal()
          .singleWhere(
            (node) => node.getSemanticsData().label == 'More information',
          );
      expect(
        triggerNode,
        isSemantics(
          label: 'More information',
          hasExpandedState: true,
          isExpanded: true,
          hasTapAction: true,
        ),
      );
      semantics.dispose();
    },
  );

  testWidgets('Carbon popover recipe uses current layer and max width', (
    tester,
  ) async {
    late PopoverSpec spec;
    late Color layer;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonPopoverStyle().build(context).spec;
            layer = CarbonLayer.of(
              context,
            ).color(CarbonContextualColor.layer).resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.container.spec.constraints?.maxWidth, 368);
    expect((spec.container.spec.decoration as BoxDecoration?)?.color, layer);
  });
}
