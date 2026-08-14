import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonCheckbox forwards controlled behavior and semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    bool? value = false;
    await tester.pumpCarbonApp(
      CarbonCheckbox(
        selected: value,
        label: 'Email updates',
        onChanged: (next) => value = next,
      ),
    );

    expect(
      tester.getSemantics(find.byType(RemixCheckbox)),
      isSemantics(
        label: 'Email updates',
        hasCheckedState: true,
        isChecked: false,
        isEnabled: true,
        hasTapAction: true,
      ),
    );
    await tester.tap(find.text('Email updates'));
    expect(value, isTrue);
    semantics.dispose();
  });

  testWidgets(
    'CarbonCheckbox recipe matches Carbon geometry and state colors',
    (tester) async {
      final base = await _resolve(tester);
      final selected = await _resolve(tester, states: {WidgetState.selected});
      final disabled = await _resolve(tester, states: {WidgetState.disabled});

      expect(base.spec.container.spec.constraints?.minWidth, 16);
      expect(base.spec.container.spec.constraints?.minHeight, 16);
      expect(base.spec.container.spec.decoration, isA<BoxDecoration>());
      expect(base.spec.labelSpacing, 8);
      expect(base.spec.label.spec.style?.fontSize, 14);
      expect(_background(selected.spec.container.spec), selected.iconPrimary);
      expect(disabled.spec.label.spec.style?.color, disabled.textDisabled);
    },
  );

  testWidgets('CarbonCheckbox renders its controlled selected state', (
    tester,
  ) async {
    await tester.pumpCarbonApp(
      CarbonCheckbox(selected: true, label: 'Email updates', onChanged: (_) {}),
    );

    final surface = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(RemixCheckbox),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    final context = tester.element(find.byType(RemixCheckbox));

    expect(
      (surface.decoration as BoxDecoration).color,
      CarbonTokens.iconPrimary.resolve(context),
    );
    expect(
      find.descendant(
        of: find.byType(RemixCheckbox),
        matching: find.byType(CustomPaint),
      ),
      findsWidgets,
    );
  });

  testWidgets('CarbonCheckboxGroup owns immutable typed membership', (
    tester,
  ) async {
    Set<String>? next;
    await tester.pumpCarbonApp(
      CarbonCheckboxGroup<String>(
        values: const {'a'},
        semanticLabel: 'Options',
        onChanged: (value) => next = value,
        child: const Column(
          children: [
            CarbonCheckboxGroupItem(value: 'a', label: 'Alpha'),
            CarbonCheckboxGroupItem(value: 'b', label: 'Beta'),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Beta'));
    expect(next, {'a', 'b'});
    expect(() => next!.add('c'), throwsUnsupportedError);
  });
}

Future<({CheckboxSpec spec, Color iconPrimary, Color textDisabled})> _resolve(
  WidgetTester tester, {
  Set<WidgetState> states = const {},
}) async {
  late ({CheckboxSpec spec, Color iconPrimary, Color textDisabled}) result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonCheckboxStyle().build(context).spec,
              iconPrimary: CarbonTokens.iconPrimary.resolve(context),
              textDisabled: CarbonTokens.textDisabled.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}

Color? _background(BoxSpec spec) => (spec.decoration as BoxDecoration?)?.color;
