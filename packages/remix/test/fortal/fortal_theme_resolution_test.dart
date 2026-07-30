import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('theme configuration stores only canonical nullable overrides', () {
    const config = FortalThemeConfig();

    expect(config.accent, isNull);
    expect(config.gray, isNull);
    expect(config.brightness, isNull);
    expect(config.panelBackground, isNull);
    expect(config.radius, isNull);
    expect(config.scaling, isNull);
    expect(config.hasBackground, isNull);
  });

  testWidgets('root scope resolves the documented defaults', (tester) async {
    late FortalThemeData data;

    await tester.pumpWidget(
      FortalScope(
        child: Builder(
          builder: (context) {
            data = FortalTheme.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(data.accent, FortalAccentColor.indigo);
    expect(data.gray, FortalGrayColor.slate);
    expect(data.brightness, Brightness.light);
    expect(data.panelBackground, FortalPanelBackground.translucent);
    expect(data.radius, FortalRadius.medium);
    expect(data.scaling, FortalScaling.percent100);
    expect(data.hasBackground, isTrue);
  });

  testWidgets('nested scopes inherit unspecified values without repainting', (
    tester,
  ) async {
    late FortalThemeData outer;
    late FortalThemeData inner;

    await tester.pumpWidget(
      FortalScope(
        accent: .red,
        gray: .mauve,
        brightness: .dark,
        radius: .large,
        child: Builder(
          builder: (context) {
            outer = FortalTheme.of(context);
            return FortalScope(
              scaling: .percent110,
              child: Builder(
                builder: (context) {
                  inner = FortalTheme.of(context);
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );

    expect(inner.accent, outer.accent);
    expect(inner.gray, outer.gray);
    expect(inner.brightness, outer.brightness);
    expect(inner.radius, outer.radius);
    expect(inner.scaling, FortalScaling.percent110);
    expect(inner.hasBackground, isFalse);
  });

  testWidgets('captured themes rebuild their Mix token scope', (tester) async {
    late BuildContext sourceContext;

    await tester.pumpWidget(
      FortalScope(
        accent: .red,
        child: Builder(
          builder: (context) {
            sourceContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    final captured = InheritedTheme.capture(
      from: sourceContext,
      to: tester.element(find.byType(FortalScope)),
    );
    late Color accent;
    await tester.pumpWidget(
      captured.wrap(
        Builder(
          builder: (context) {
            accent = MixScope.tokenOf(FortalTokens.accent9, context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(accent, isNotNull);
  });
}
