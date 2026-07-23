import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('disabled variants resolve the Radix gray-a3 surface', (
    tester,
  ) async {
    late Color expected;
    late Map<FortalCheckboxVariant, Color?> resolvedColors;

    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: WidgetStateProvider(
            states: const {WidgetState.disabled},
            child: Builder(
              builder: (context) {
                expected = FortalTokens.grayA3.resolve(context);
                resolvedColors = {
                  for (final variant in FortalCheckboxVariant.values)
                    variant:
                        (fortalCheckboxStyler(
                                  variant: variant,
                                ).build(context).spec.container.spec.decoration
                                as BoxDecoration?)
                            ?.color,
                };
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );

    for (final entry in resolvedColors.entries) {
      expect(entry.value, expected, reason: entry.key.name);
    }
  });
}
