import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('tab stylers resolve every component slot', (tester) async {
    late StyleSpec<RemixTabBarSpec> bar;
    late StyleSpec<RemixTabSpec> tab;
    late StyleSpec<RemixTabViewSpec> view;

    await tester.pumpRemixApp(
      Builder(
        builder: (context) {
          bar = RemixTabBarStyler(
            container: BoxStyler().color(Colors.red),
          ).resolve(context);
          tab = RemixTabStyler(
            container: FlexBoxStyler().color(Colors.blue),
            label: TextStyler(style: TextStyleMix(color: Colors.green)),
            icon: IconStyler(color: Colors.orange),
          ).resolve(context);
          view = RemixTabViewStyler(
            container: BoxStyler().color(Colors.purple),
          ).resolve(context);
          return const SizedBox.shrink();
        },
      ),
    );

    expect(bar.spec.container.spec.decoration, isA<BoxDecoration>());
    expect(tab.spec.container.spec.box?.spec.decoration, isA<BoxDecoration>());
    expect(tab.spec.label.spec.style?.color, Colors.green);
    expect(tab.spec.icon.spec.color, Colors.orange);
    expect(view.spec.container.spec.decoration, isA<BoxDecoration>());
  });

  test('styler merge is immutable and preserves unrelated slots', () {
    final base = RemixTabStyler(label: TextStyler().fontSize(14));
    final merged = base.merge(RemixTabStyler(icon: IconStyler(size: 16)));

    expect(base.$icon, isNull);
    expect(merged.$label, base.$label);
    expect(merged.$icon, isNotNull);
  });

  test('widget factories forward behavior fields', () {
    final tab = RemixTabStyler()(
      tabId: 'one',
      label: 'One',
      enabled: false,
      excludeSemantics: true,
    );
    final view = RemixTabViewStyler()(
      tabId: 'one',
      maintainState: false,
      child: const Text('One'),
    );

    expect(tab.enabled, isFalse);
    expect(tab.excludeSemantics, isTrue);
    expect(view.maintainState, isFalse);
  });

  testWidgets('Fortal tab sizes resolve exact typography', (tester) async {
    final fontSizes = <FortalTabsSize, double?>{};
    final letterSpacings = <FortalTabsSize, double?>{};

    await tester.pumpRemixApp(
      Builder(
        builder: (context) {
          for (final size in FortalTabsSize.values) {
            fontSizes[size] = fortalTabStyler(
              size: size,
            ).resolve(context).spec.label.spec.style?.fontSize;
            letterSpacings[size] = fortalTabStyler(
              size: size,
            ).resolve(context).spec.label.spec.style?.letterSpacing;
          }
          return const SizedBox.shrink();
        },
      ),
    );

    expect(fontSizes, {FortalTabsSize.size1: 12, FortalTabsSize.size2: 14});
    expect(letterSpacings, {FortalTabsSize.size1: 0, FortalTabsSize.size2: 0});
  });

  testWidgets('Fortal selected tabs use the exact active tracking', (
    tester,
  ) async {
    for (final (size, expected) in [
      (FortalTabsSize.size1, -0.12),
      (FortalTabsSize.size2, -0.14),
    ]) {
      final resolved = await _resolveFortalTabStyle(
        tester,
        fortalTabStyler(size: size),
        states: {WidgetState.selected},
      );

      expect(resolved.spec.label.spec.style?.letterSpacing, expected);
      expect(resolved.spec.label.spec.style?.fontWeight, FontWeight.w500);
    }
  });

  testWidgets('Fortal focused hover uses the accent hover fill', (
    tester,
  ) async {
    late Color expected;
    late StyleSpec<RemixTabSpec> resolved;

    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: WidgetStateProvider(
            states: const {WidgetState.focused, WidgetState.hovered},
            child: Builder(
              builder: (context) {
                expected = FortalTokens.accentA3.resolve(context);
                resolved = fortalTabStyler().build(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );

    expect(
      (resolved.spec.container.spec.box?.spec.decoration as BoxDecoration?)
          ?.color,
      expected,
    );
  });
}

Future<StyleSpec<RemixTabSpec>> _resolveFortalTabStyle(
  WidgetTester tester,
  RemixTabStyler style, {
  Set<WidgetState> states = const {},
}) async {
  late StyleSpec<RemixTabSpec> resolved;

  await tester.pumpWidget(
    FortalScope(
      child: MaterialApp(
        home: WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              resolved = style.build(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );

  return resolved;
}
