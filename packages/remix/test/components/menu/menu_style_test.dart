import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('menu and item stylers expose every compositional slot', () {
    final item = RemixMenuItemStyler()
        .label(TextStyler().color(Colors.red))
        .leadingIcon(IconStyler().size(12))
        .trailingIcon(IconStyler().size(10))
        .indicator(BoxStyler().alignment(.center))
        .indicatorIcon(IconStyler().size(9))
        .leadingInset(8)
        .checkableLeadingInset(20)
        .trailingInset(8)
        .adjacentItemSpacing(8);
    final style = RemixMenuStyler()
        .overlay(FlexBoxStyler().paddingAll(8))
        .containerEffects(
          RemixBoxEffectsMix(behindContent: RemixBoxEffectLayerMix()),
        )
        .item(item)
        .label(item)
        .divider(RemixDividerStyler().height(1));

    expect(style, isA<RemixMenuStyler>());
    expect(item, isA<RemixMenuItemStyler>());
  });

  test('Fortal exposes the complete Radix size and variant matrix', () {
    expect(FortalMenuSize.values, [FortalMenuSize.size1, FortalMenuSize.size2]);
    expect(FortalMenuVariant.values, [
      FortalMenuVariant.solid,
      FortalMenuVariant.soft,
    ]);

    for (final size in FortalMenuSize.values) {
      for (final variant in FortalMenuVariant.values) {
        expect(
          fortalMenuStyler(size: size, variant: variant, highContrast: true),
          isA<RemixMenuStyler>(),
        );
      }
    }
  });

  test('FortalMenu defaults match Radix Themes 3.3.0', () {
    const menu = FortalMenu<String>(
      trigger: Text('Open'),
      entries: [RemixMenuAction(value: 'a', child: Text('A'))],
    );

    expect(menu.size, FortalMenuSize.size2);
    expect(menu.variant, FortalMenuVariant.solid);
    expect(menu.highContrast, isFalse);
    expect(menu.positioning.side, OverlaySide.bottom);
    expect(menu.positioning.alignment, OverlayAlignment.start);
    expect(menu.positioning.sideOffset, 4);
    expect(menu.positioning.collisionPadding, const EdgeInsets.all(10));
  });

  testWidgets(
    'Fortal item states resolve highlight submenu disabled and high contrast roles',
    (tester) async {
      for (final variant in FortalMenuVariant.values) {
        final expectedHighlight = variant == FortalMenuVariant.solid
            ? indigo.light.scale.step(9)
            : indigo.light.scale.alphaStep(4);
        for (final state in [
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.pressed,
        ]) {
          final spec = await _resolveMenuItem(
            tester,
            fortalMenuItemStyler(variant: variant),
            states: {state},
          );
          expect(_menuItemColor(spec), expectedHighlight);
        }

        final submenu = await _resolveMenuItem(
          tester,
          fortalMenuItemStyler(variant: variant),
          states: {WidgetState.selected},
        );
        expect(
          _menuItemColor(submenu),
          variant == FortalMenuVariant.solid
              ? slate.light.scale.alphaStep(3)
              : indigo.light.scale.alphaStep(3),
        );

        final disabled = await _resolveMenuItem(
          tester,
          fortalMenuItemStyler(variant: variant),
          states: {WidgetState.disabled},
        );
        expect(_menuItemColor(disabled), Colors.transparent);
        expect(
          disabled.spec.label.spec.style?.color,
          slate.light.scale.alphaStep(8),
        );
      }

      final highContrast = await _resolveMenuItem(
        tester,
        fortalMenuItemStyler(highContrast: true),
        states: {WidgetState.hovered},
      );
      expect(_menuItemColor(highContrast), indigo.light.scale.step(12));
      expect(
        highContrast.spec.label.spec.style?.color,
        indigo.light.scale.step(1),
      );
    },
  );
}

Future<StyleSpec<RemixMenuItemSpec>> _resolveMenuItem(
  WidgetTester tester,
  RemixMenuItemStyler style, {
  Set<WidgetState> states = const {},
}) async {
  late StyleSpec<RemixMenuItemSpec> resolved;
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

Color? _menuItemColor(StyleSpec<RemixMenuItemSpec> spec) =>
    (spec.spec.container.spec.box?.spec.decoration as BoxDecoration?)?.color;
