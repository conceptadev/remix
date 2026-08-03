import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_methods.dart';

void main() {
  group('ToggleGroupStyler', () {
    test('constructors retain container and item styles', () {
      final container = FlexBoxStyler();
      final item = ToggleGroupItemStyler();
      final style = ToggleGroupStyler(container: container, item: item);

      expect(style.$container, Prop.maybeMix(container));
      expect(style.$item, Prop.maybeMix(item));
    });

    styleMethodTest(
      'sets the group background color',
      initial: ToggleGroupStyler(),
      modify: (style) => style.backgroundColor(Colors.blue),
      expect: (style) {
        expect(style, ToggleGroupStyler.color(Colors.blue));
      },
    );

    styleMethodTest(
      'sets the default item style',
      initial: ToggleGroupStyler(),
      modify: (style) => style.item(ToggleGroupItemStyler()),
      expect: (style) {
        expect(style.$item, Prop.maybeMix(ToggleGroupItemStyler()));
      },
    );

    test('generic call creates a typed group', () {
      final widget = ToggleGroupStyler().call<String>(
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
        fortalToggleGroupStyle(),
        fortalToggleGroupStyle(variant: .soft, size: .size2),
      );
    });

    testWidgets('all Fortal variant and size combinations resolve', (
      tester,
    ) async {
      for (final variant in FortalToggleGroupVariant.values) {
        for (final size in FortalToggleGroupSize.values) {
          final resolved = await _resolveFortalToggleGroupStyle(
            tester,
            fortalToggleGroupStyle(variant: variant, size: size),
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
          fortalToggleGroupStyle(size: size),
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
          fortalToggleGroupStyle(variant: variant),
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
  });

  group('ToggleGroupItemStyler', () {
    styleMethodTest(
      'sets foreground color on label and icon',
      initial: ToggleGroupItemStyler(),
      modify: (style) => style.foregroundColor(Colors.red),
      expect: (style) {
        expect(style.$label, isNotNull);
        expect(style.$icon, isNotNull);
      },
    );

    styleMethodTest(
      'adds a selected-state variant',
      initial: ToggleGroupItemStyler(),
      modify: (style) => style.onSelected(
        ToggleGroupItemStyler().backgroundColor(Colors.purple),
      ),
      expect: (style) {
        expect(style.$variants, hasLength(1));
      },
    );

    styleMethodTest(
      'sets icon and label spacing',
      initial: ToggleGroupItemStyler(),
      modify: (style) => style.spacing(8),
      expect: (style) {
        expect(style, ToggleGroupItemStyler.spacing(8));
      },
    );
  });
}

Future<StyleSpec<ToggleGroupSpec>> _resolveFortalToggleGroupStyle(
  WidgetTester tester,
  ToggleGroupStyler style, {
  Set<WidgetState> states = const {},
}) async {
  late StyleSpec<ToggleGroupSpec> resolved;

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
