import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonDatePicker selects a date from its calendar', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    DateTime? selected = DateTime(2026, 8, 13);
    await tester.pumpCarbonApp(
      StatefulBuilder(
        builder: (context, setState) => CarbonDatePicker(
          value: selected,
          label: 'Start date',
          onChanged: (value) => setState(() => selected = value),
        ),
      ),
    );

    expect(
      tester.getSemantics(find.bySemanticsLabel('Choose Start date')),
      isSemantics(label: 'Choose Start date', value: '2026-08-13'),
    );
    await tester.tap(find.bySemanticsLabel('Choose Start date'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('August 20, 2026'));
    await tester.pumpAndSettle();

    expect(selected, DateTime(2026, 8, 20));
    expect(find.text('2026-08-20'), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Choose Start date')),
      isSemantics(label: 'Choose Start date', value: '2026-08-20'),
    );
    semantics.dispose();
  });

  testWidgets('CarbonDatePicker disables dates outside its bounds', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      CarbonDatePicker(
        value: DateTime(2026, 8, 13),
        minDate: DateTime(2026, 8, 10),
        maxDate: DateTime(2026, 8, 20),
        onChanged: (_) {},
      ),
    );
    await tester.tap(find.bySemanticsLabel('Choose date'));
    await tester.pumpAndSettle();

    expect(
      tester.getSemantics(find.bySemanticsLabel('August 9, 2026')),
      isSemantics(hasEnabledState: true, isEnabled: false),
    );
  });

  testWidgets('CarbonDateRangePicker preserves an ordered range', (
    tester,
  ) async {
    DateTime? start = DateTime(2026, 8, 20);
    DateTime? end = DateTime(2026, 8, 24);
    await tester.pumpCarbonApp(
      StatefulBuilder(
        builder: (context, setState) => CarbonDateRangePicker(
          startDate: start,
          endDate: end,
          onChanged: (nextStart, nextEnd) => setState(() {
            start = nextStart;
            end = nextEnd;
          }),
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Choose Start date'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('August 26, 2026'));
    await tester.pumpAndSettle();

    expect(start, DateTime(2026, 8, 26));
    expect(end, isNull);
  });
}
