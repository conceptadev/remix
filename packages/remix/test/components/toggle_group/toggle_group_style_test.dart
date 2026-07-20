import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('RemixToggleGroupStyler', () {
    test('constructors retain container and item styles', () {
      final container = FlexBoxStyler();
      final item = RemixToggleGroupItemStyler();
      final style = RemixToggleGroupStyler(container: container, item: item);

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$item, Prop.maybeMix(item));
    });

    styleMethodTest(
      'sets the group background color',
      initial: RemixToggleGroupStyler(),
      modify: (style) => style.backgroundColor(Colors.blue),
      expect: (style) {
        expect(style, RemixToggleGroupStyler.color(Colors.blue));
      },
    );

    styleMethodTest(
      'sets the default item style',
      initial: RemixToggleGroupStyler(),
      modify: (style) => style.item(RemixToggleGroupItemStyler()),
      expect: (style) {
        expect(style.$item, Prop.maybeMix(RemixToggleGroupItemStyler()));
      },
    );

    test('generic call creates a typed group', () {
      final widget = RemixToggleGroupStyler().call<String>(
        items: const [RemixToggleGroupItem(value: 'list', label: 'List')],
        selectedValue: 'list',
        onChanged: (_) {},
      );

      expect(widget, isA<RemixToggleGroup<String>>());
    });

    testWidgets('Fortal recipe resolves in a Fortal scope', (tester) async {
      await tester.pumpWidget(
        FortalScope(
          child: MaterialApp(
            home: FortalToggleGroup<String>(
              items: const [
                RemixToggleGroupItem(value: 'list', label: 'List'),
                RemixToggleGroupItem(value: 'grid', label: 'Grid'),
              ],
              selectedValue: 'list',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RemixToggleGroup<String>), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    test('Fortal recipe defaults to soft size2', () {
      expect(
        fortalToggleGroupStyler(),
        fortalToggleGroupStyler(variant: .soft, size: .size2),
      );
    });

    testWidgets('all Fortal variant and size combinations resolve', (
      tester,
    ) async {
      for (final variant in FortalToggleGroupVariant.values) {
        for (final size in FortalToggleGroupSize.values) {
          final resolved = await _resolveFortalToggleGroupStyle(
            tester,
            fortalToggleGroupStyler(variant: variant, size: size),
            states: {WidgetState.selected},
          );
          final groupBox = resolved.spec.container.spec.box?.spec;
          final item = resolved.spec.item.spec;
          final itemBox = item.container.spec.box?.spec;

          expect(
            groupBox?.decoration,
            isA<BoxDecoration>(),
            reason: '$variant $size group decoration',
          );
          expect(
            itemBox?.padding,
            isNotNull,
            reason: '$variant $size item padding',
          );
          expect(
            item.container.spec.flex?.spec.spacing,
            isNotNull,
            reason: '$variant $size item spacing',
          );
          expect(
            item.label.spec.style?.fontSize,
            isNotNull,
            reason: '$variant $size label size',
          );
          expect(
            item.icon.spec.size,
            isNotNull,
            reason: '$variant $size icon size',
          );
          expect(
            itemBox?.decoration,
            isA<BoxDecoration>(),
            reason: '$variant $size selected decoration',
          );
          expect(
            item.label.spec.style?.color,
            isNotNull,
            reason: '$variant $size selected foreground',
          );
        }
      }
    });

    testWidgets('Fortal sizes resolve distinct item metrics', (tester) async {
      final paddings = <EdgeInsetsGeometry?>{};
      final spacings = <double?>{};
      final fontSizes = <double?>{};
      final iconSizes = <double?>{};
      final radii = <BorderRadiusGeometry?>{};

      for (final size in FortalToggleGroupSize.values) {
        final resolved = await _resolveFortalToggleGroupStyle(
          tester,
          fortalToggleGroupStyler(size: size),
        );
        final groupDecoration =
            resolved.spec.container.spec.box?.spec.decoration as BoxDecoration?;
        final item = resolved.spec.item.spec;

        paddings.add(item.container.spec.box?.spec.padding);
        spacings.add(item.container.spec.flex?.spec.spacing);
        fontSizes.add(item.label.spec.style?.fontSize);
        iconSizes.add(item.icon.spec.size);
        radii.add(groupDecoration?.borderRadius);
      }

      expect(paddings, hasLength(FortalToggleGroupSize.values.length));
      expect(spacings, hasLength(FortalToggleGroupSize.values.length));
      expect(fontSizes, hasLength(FortalToggleGroupSize.values.length));
      expect(iconSizes, hasLength(FortalToggleGroupSize.values.length));
      expect(radii, hasLength(2));
    });

    testWidgets('Fortal variants resolve distinct selected colors', (
      tester,
    ) async {
      final colors = <Color?>{};

      for (final variant in FortalToggleGroupVariant.values) {
        final resolved = await _resolveFortalToggleGroupStyle(
          tester,
          fortalToggleGroupStyler(variant: variant),
          states: {WidgetState.selected},
        );
        final decoration =
            resolved.spec.item.spec.container.spec.box?.spec.decoration
                as BoxDecoration?;
        colors.add(decoration?.color);
      }

      expect(colors, hasLength(FortalToggleGroupVariant.values.length));
      expect(colors, isNot(contains(null)));
    });

    testWidgets('Fortal high contrast uses accent12 for selected foreground', (
      tester,
    ) async {
      final normal = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.selected},
      );
      final highContrast = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(highContrast: true),
        states: {WidgetState.selected},
      );

      expect(
        normal.spec.item.spec.label.spec.style?.color,
        indigo.light.scale.step(11),
      );
      expect(
        highContrast.spec.item.spec.label.spec.style?.color,
        indigo.light.scale.step(12),
      );
    });

    testWidgets('Fortal item metrics use scaled shared tokens', (tester) async {
      final resolved = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(size: .size3),
        scaling: .percent110,
      );
      final item = resolved.spec.item.spec;
      final padding = item.container.spec.box!.spec.padding!.resolve(
        TextDirection.ltr,
      );

      expect(padding.left, closeTo(17.6, 1e-9));
      expect(padding.top, closeTo(8.8, 1e-9));
      expect(item.container.spec.flex?.spec.spacing, closeTo(6.6, 1e-9));
      expect(item.label.spec.style?.fontSize, closeTo(17.6, 1e-9));
      expect(item.label.spec.style?.height, closeTo(24 / 16, 1e-9));
      expect(item.label.spec.style?.fontWeight, FontWeight.w500);
      expect(item.icon.spec.size, closeTo(22, 1e-9));
    });

    testWidgets('Fortal pressed and disabled precedence is deterministic', (
      tester,
    ) async {
      final pressed = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.pressed},
      );
      final selectedPressed = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.selected, WidgetState.pressed},
      );
      final disabled = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {
          WidgetState.disabled,
          WidgetState.selected,
          WidgetState.hovered,
          WidgetState.pressed,
        },
      );

      expect(_toggleGroupItemColor(pressed), slate.light.scale.alphaStep(4));
      expect(
        _toggleGroupItemColor(selectedPressed),
        indigo.light.scale.step(5),
      );
      expect(_toggleGroupItemColor(disabled), slate.light.scale.alphaStep(3));
      expect(
        disabled.spec.item.spec.label.spec.style?.color,
        slate.light.scale.step(8),
      );
    });

    testWidgets('Fortal hover and focus resolve exact interaction roles', (
      tester,
    ) async {
      final hovered = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.hovered},
      );
      final selectedHovered = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.selected, WidgetState.hovered},
      );
      final focused = await _resolveFortalToggleGroupStyle(
        tester,
        fortalToggleGroupStyler(),
        states: {WidgetState.focused},
      );

      expect(_toggleGroupItemColor(hovered), slate.light.scale.alphaStep(3));
      expect(
        _toggleGroupItemColor(selectedHovered),
        indigo.light.scale.step(4),
      );
      final border =
          (focused.spec.item.spec.container.spec.box?.spec.decoration
                  as BoxDecoration?)
              ?.border;
      expect(border, isA<Border>());
      expect((border as Border).top.color, indigo.light.scale.alphaStep(8));
      expect(border.top.width, 2);
    });
  });

  group('RemixToggleGroupItemStyler', () {
    styleMethodTest(
      'sets foreground color on label and icon',
      initial: RemixToggleGroupItemStyler(),
      modify: (style) => style.foregroundColor(Colors.red),
      expect: (style) {
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      },
    );

    styleMethodTest(
      'adds a selected-state variant',
      initial: RemixToggleGroupItemStyler(),
      modify: (style) => style.onSelected(
        RemixToggleGroupItemStyler().backgroundColor(Colors.purple),
      ),
      expect: (style) {
        expect(style.$variants, hasLength(1));
      },
    );

    styleMethodTest(
      'sets icon and label spacing',
      initial: RemixToggleGroupItemStyler(),
      modify: (style) => style.spacing(8),
      expect: (style) {
        expect(style, RemixToggleGroupItemStyler.spacing(8));
      },
    );
  });
}

Future<StyleSpec<RemixToggleGroupSpec>> _resolveFortalToggleGroupStyle(
  WidgetTester tester,
  RemixToggleGroupStyler style, {
  Set<WidgetState> states = const {},
  FortalScaling scaling = .percent100,
}) async {
  late StyleSpec<RemixToggleGroupSpec> resolved;

  await tester.pumpWidget(
    FortalScope(
      appearance: .light,
      scaling: scaling,
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

Color? _toggleGroupItemColor(StyleSpec<RemixToggleGroupSpec> spec) =>
    (spec.spec.item.spec.container.spec.box!.spec.decoration as BoxDecoration?)
        ?.color;
