import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

const _sections = <RemixSidebarSection<String>>[
  RemixSidebarSection(
    label: 'Workspace',
    destinations: [
      RemixSidebarDestination(
        value: 'overview',
        label: 'Overview',
        icon: Icons.space_dashboard_outlined,
      ),
      RemixSidebarDestination(
        value: 'customers',
        label: 'Customers',
        icon: Icons.people_outline,
      ),
    ],
  ),
];

void main() {
  test('Fortal recipe exposes the dashboard navigation metrics', () {
    final style = fortalSidebarStyle();

    expect(style, isA<SidebarStyler>());
    expect(style.$container, isNotNull);
    expect(style.$content, isNotNull);
    expect(style.$footer, isNotNull);
    expect(style.$sectionLabel, isNotNull);
    expect(style.$destinations, isNotNull);
    expect(style.$destination, isNotNull);

    // Width and header padding belong to the host, not to the recipe.
    expect(style.$header, isNull);
  });

  testWidgets('recipe paints the panel surface and the footer divider', (
    tester,
  ) async {
    const panelPadding = EdgeInsets.fromLTRB(1, 2, 3, 4);
    await tester.pumpRemixApp(
      SizedBox(
        height: 400,
        width: 256,
        child: FortalSidebar<String>(
          panelPadding: panelPadding,
          header: const Text('Acme'),
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
          footer: const Text('Account'),
        ),
      ),
    );

    final spec = tester.resolvedSpecOf<SidebarSpec>(find.text('Overview'));
    final panel = spec.container.spec.box?.spec.decoration as BoxDecoration?;
    expect(panel?.color, isNotNull);
    expect(panel?.border, isA<BorderDirectional>());
    expect((panel?.border as BorderDirectional?)?.end.width, greaterThan(0));
    expect(spec.container.spec.box?.spec.padding, panelPadding);

    final footer = spec.footer.spec.decoration as BoxDecoration?;
    expect((footer?.border as Border?)?.top.width, greaterThan(0));

    // The recipe pads the scrolling region rather than the panel.
    expect(spec.content.spec.box?.spec.padding, isNotNull);
  });

  testWidgets('generated wrapper preserves generic navigation inputs', (
    tester,
  ) async {
    String? selected;
    await tester.pumpRemixApp(
      FortalSidebar<String>(
        sections: _sections,
        selectedValue: 'overview',
        onSelected: (value) => selected = value,
        semanticLabel: 'Primary navigation',
      ),
    );

    expect(find.byType(RemixSidebar<String>), findsOneWidget);
    expect(find.text('WORKSPACE'), findsOneWidget);

    await tester.tap(find.text('Customers'));
    await tester.pump();
    expect(selected, 'customers');
  });

  testWidgets('recipe uses ghost size2 content in 48-high full-width rows', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      FortalSidebar<String>(
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
    expect(selectedBox?.constraints?.minHeight, 48);
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

  testWidgets('destination rows meet mobile tap-target guidelines', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpRemixApp(
      SizedBox(
        width: 256,
        child: FortalSidebar<String>(
          sections: _sections,
          selectedValue: 'overview',
          onSelected: (_) {},
        ),
      ),
    );

    expect(
      tester.getSize(find.byType(RemixToggle).first).height,
      greaterThanOrEqualTo(48),
    );
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    semantics.dispose();
  });

  testWidgets('high contrast keeps selected content distinct', (tester) async {
    Future<Color?> selectedLabelColor(bool highContrast) async {
      await tester.pumpRemixApp(
        FortalSidebar<String>(
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
