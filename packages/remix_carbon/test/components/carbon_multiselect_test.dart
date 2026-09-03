import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonMultiselect emits an immutable selection and stays open', (
    tester,
  ) async {
    var selected = <String>{'one'};
    await tester.pumpCarbonApp(
      StatefulBuilder(
        builder: (context, setState) => SizedBox(
          width: 280,
          child: CarbonMultiselect<String>(
            label: 'Projects',
            placeholder: 'Choose projects',
            items: const [
              CarbonMultiselectItem(value: 'one', label: 'One'),
              CarbonMultiselectItem(value: 'two', label: 'Two'),
            ],
            selectedValues: selected,
            onChanged: (next) => setState(() => selected = next),
          ),
        ),
      ),
    );

    final menu = tester.widget<RemixMenu<String>>(
      find.byType(RemixMenu<String>),
    );
    expect(menu.trigger.builder, isNotNull);
    expect(find.byIcon(CarbonIcons.chevronDown), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Two'));
    await tester.pump();

    expect(selected, {'one', 'two'});
    expect(() => selected.add('three'), throwsUnsupportedError);
    expect(find.text('One'), findsWidgets);
  });

  testWidgets('CarbonMultiselect validates selected values', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonMultiselect<String>(
        placeholder: 'Choose',
        items: [CarbonMultiselectItem(value: 'one', label: 'One')],
        selectedValues: {'missing'},
      ),
    );

    expect(tester.takeException(), isA<AssertionError>());
  });
}
