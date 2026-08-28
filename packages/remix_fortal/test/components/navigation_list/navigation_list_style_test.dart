import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

const _sections = <RemixNavigationSection<String>>[
  RemixNavigationSection(
    label: 'Workspace',
    destinations: [
      RemixNavigationDestination(
        value: 'overview',
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
      RemixNavigationDestination(
        value: 'customers',
        label: 'Customers',
        icon: Icons.people_outline,
      ),
    ],
  ),
];

void main() {
  test('Fortal recipe exposes the dashboard navigation metrics', () {
    final style = fortalNavigationListStyle();

    expect(style, isA<NavigationListStyler>());
    expect(style.$container, isNotNull);
    expect(style.$sectionLabel, isNotNull);
    expect(style.$destinations, isNotNull);
    expect(style.$destination, isNotNull);
  });

  testWidgets('generated wrapper preserves generic navigation inputs', (
    tester,
  ) async {
    String? selected;
    await tester.pumpRemixApp(
      FortalNavigationList<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (value) => selected = value,
        semanticLabel: 'Primary navigation',
      ),
    );

    expect(find.byType(RemixNavigationList<String>), findsOneWidget);
    expect(find.text('WORKSPACE'), findsOneWidget);

    await tester.tap(find.text('Customers'));
    await tester.pump();
    expect(selected, 'customers');
  });

  testWidgets('recipe reuses ghost size2 toggle states and full-width rows', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      FortalNavigationList<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (_) {},
      ),
    );

    final selected = tester.resolvedSpecOf<ToggleSpec>(find.text('Overview'));
    final idle = tester.resolvedSpecOf<ToggleSpec>(find.text('Customers'));
    final selectedBox = selected.container.spec.box?.spec;
    final selectedFlex = selected.container.spec.flex?.spec;

    expect(
      selectedBox?.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
    expect(selectedFlex?.spacing, 4);
    expect(selectedFlex?.mainAxisSize, MainAxisSize.max);
    expect(selectedFlex?.mainAxisAlignment, MainAxisAlignment.start);
    expect(
      selectedBox?.decoration,
      isA<BoxDecoration>().having(
        (decoration) => decoration.color,
        'selected color',
        isNot(
          equals(
            (idle.container.spec.box?.spec.decoration as BoxDecoration?)?.color,
          ),
        ),
      ),
    );
    expect(selected.label.spec.style?.fontSize, 14);
    expect(selected.icon.spec.size, 16);
  });

  testWidgets('high contrast keeps selected content distinct', (tester) async {
    Future<Color?> selectedLabelColor(bool highContrast) async {
      await tester.pumpRemixApp(
        FortalNavigationList<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
          highContrast: highContrast,
        ),
      );
      return tester
          .resolvedSpecOf<ToggleSpec>(find.text('Overview'))
          .label
          .spec
          .style
          ?.color;
    }

    final normal = await selectedLabelColor(false);
    final highContrast = await selectedLabelColor(true);

    expect(normal, isNotNull);
    expect(highContrast, isNotNull);
    expect(highContrast, isNot(normal));
  });
}
