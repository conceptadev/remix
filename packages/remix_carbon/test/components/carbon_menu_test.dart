import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonMenu opens, selects, and closes', (tester) async {
    String? selected;
    await tester.pumpCarbonApp(
      CarbonMenu<String>(
        trigger: const RemixMenuTrigger(label: 'Actions'),
        items: const [
          RemixMenuItem(value: 'edit', label: 'Edit'),
          RemixMenuItem(value: 'delete', label: 'Delete'),
        ],
        onSelected: (value) => selected = value,
      ),
    );

    await tester.tap(find.text('Actions'));
    await tester.pump();
    expect(find.text('Edit'), findsOneWidget);
    await tester.tap(find.text('Edit'));
    await tester.pump();
    expect(selected, 'edit');
    expect(find.text('Edit'), findsNothing);
  });

  testWidgets('Carbon menu recipe matches popup and row geometry', (
    tester,
  ) async {
    late MenuSpec spec;
    late Color layer;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            spec = carbonMenuStyle().build(context).spec;
            layer = CarbonLayer.of(
              context,
            ).color(CarbonContextualColor.layer).resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(spec.overlay.spec.box?.spec.constraints?.minWidth, 160);
    expect(spec.overlay.spec.box?.spec.constraints?.maxWidth, 288);
    expect(
      (spec.overlay.spec.box?.spec.decoration as BoxDecoration?)?.color,
      layer,
    );
    expect(spec.item.spec.container.spec.box?.spec.constraints?.minHeight, 32);
    expect(spec.item.spec.label.spec.style?.fontSize, 14);
  });
}
