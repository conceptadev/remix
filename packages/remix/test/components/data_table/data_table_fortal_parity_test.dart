import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

/// Pinned `@radix-ui/themes@3.3.0` `table.css` values at 100% scaling and the
/// default `medium` radius:
///
/// ```css
/// .rt-r-size-1 { --table-cell-padding: var(--space-2);
///                --table-cell-min-height: calc(36px * var(--scaling));
///                --table-border-radius: var(--radius-3); font-size: text-2 }
/// .rt-r-size-2 { --table-cell-padding: var(--space-3);
///                --table-cell-min-height: calc(44px * var(--scaling));
///                --table-border-radius: var(--radius-4); font-size: text-2 }
/// .rt-r-size-3 { --table-cell-padding: var(--space-3) var(--space-4);
///                --table-cell-min-height: var(--space-8);
///                --table-border-radius: var(--radius-4); font-size: text-3 }
/// ```
void main() {
  test('public contract has the pinned enum order and Radix defaults', () {
    expect(FortalDataTableSize.values, [
      FortalDataTableSize.size1,
      FortalDataTableSize.size2,
      FortalDataTableSize.size3,
    ]);
    expect(FortalDataTableVariant.values, [
      FortalDataTableVariant.surface,
      FortalDataTableVariant.ghost,
    ]);

    const table = FortalDataTable<int>(rows: [], columns: []);
    expect(table.size, FortalDataTableSize.size2);
    expect(table.variant, FortalDataTableVariant.ghost);
    expect(
      const FortalDataTable<int>.surface(rows: [], columns: []).variant,
      FortalDataTableVariant.surface,
    );
    expect(
      const FortalDataTable<int>.ghost(rows: [], columns: []).variant,
      FortalDataTableVariant.ghost,
    );
  });

  group('sizes', () {
    for (final (size, paddingX, paddingY, minHeight, fontSize, radius)
        in const [
          (FortalDataTableSize.size1, 8.0, 8.0, 36.0, 14.0, 6.0),
          (FortalDataTableSize.size2, 12.0, 12.0, 44.0, 14.0, 8.0),
          (FortalDataTableSize.size3, 16.0, 12.0, 48.0, 16.0, 8.0),
        ]) {
      testWidgets('${size.name} matches the pinned Radix metrics', (
        tester,
      ) async {
        final spec = await _resolve(
          tester,
          fortalDataTableStyle(size: size, variant: .surface),
        );

        for (final cell in [spec.headerCell, spec.bodyCell]) {
          expect(
            cell.spec.padding!.resolve(TextDirection.ltr),
            EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
          );
        }
        expect(spec.headerMinHeight, minHeight);
        expect(spec.rowMinHeight, minHeight);
        expect(spec.headerLabel.spec.style?.fontSize, fontSize);
        expect(_radius(spec.container.spec), radius);
      });
    }

    testWidgets('metrics scale with the theme', (tester) async {
      final spec = await _resolve(
        tester,
        fortalDataTableStyle(size: .size2, variant: .surface),
        scaling: .percent110,
      );

      expect(spec.rowMinHeight, closeTo(48.4, 1e-9));
      expect(
        spec.bodyCell.spec.padding!.resolve(TextDirection.ltr).left,
        closeTo(13.2, 1e-9),
      );
      expect(_radius(spec.container.spec), closeTo(8.8, 1e-9));
    });
  });

  group('shared typography and dividers', () {
    testWidgets('column headers are bold gray-12', (tester) async {
      final tokens = await _tokens(tester);
      final spec = await _resolve(tester, fortalDataTableStyle());

      expect(spec.headerLabel.spec.style?.color, tokens.gray12);
      expect(spec.headerLabel.spec.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('row dividers use gray-a5 without insetting content', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final spec = await _resolve(tester, fortalDataTableStyle());

      for (final row in [spec.headerRow, spec.bodyRow]) {
        final decoration = row.spec.foregroundDecoration! as BoxDecoration;
        final border = decoration.border! as Border;
        expect(border.bottom.color, tokens.grayA5);
        expect(border.bottom.width, 1);
        // The divider is a foreground border, so it reserves no layout space.
        expect((row.spec.decoration as BoxDecoration?)?.border, isNull);
      }
    });
  });

  group('variants', () {
    testWidgets('surface uses the panel, the mixed border, and gray-a2', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final spec = await _resolve(
        tester,
        fortalDataTableStyle(variant: .surface),
      );
      final container = spec.container.spec.decoration! as BoxDecoration;

      expect(container.color, tokens.panel);
      expect((container.border! as Border).top.color, tokens.tableBorder);
      expect((container.border! as Border).top.width, 1);
      expect(spec.container.spec.clipBehavior, Clip.antiAlias);
      expect(_color(spec.headerRow), tokens.grayA2);
    });

    testWidgets('surface drops the divider under the final body row', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        fortalDataTableStyle(variant: .surface),
      );
      final last = spec.lastBodyRow!.spec.foregroundDecoration! as BoxDecoration;

      expect((last.border! as Border).bottom.style, BorderStyle.none);
    });

    testWidgets('ghost keeps a transparent surface and every divider', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        fortalDataTableStyle(variant: .ghost),
      );

      expect(_color(spec.container), Colors.transparent);
      expect(spec.lastBodyRow, isNull);
      expect(spec.bodyRow.spec.foregroundDecoration, isNotNull);
    });

    testWidgets('resolves in dark mode without losing its panel', (
      tester,
    ) async {
      final spec = await _resolve(
        tester,
        fortalDataTableStyle(variant: .surface),
        brightness: Brightness.dark,
      );
      final light = await _resolve(
        tester,
        fortalDataTableStyle(variant: .surface),
      );

      expect(_color(spec.container), isNotNull);
      expect(_color(spec.container), isNot(_color(light.container)));
    });
  });

  group('Fortal extensions', () {
    testWidgets('hover and selection are pure color layers on the row', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final idle = await _resolve(tester, fortalDataTableStyle());
      final hovered = await _resolve(
        tester,
        fortalDataTableStyle(),
        states: {WidgetState.hovered},
      );
      final selected = await _resolve(
        tester,
        fortalDataTableStyle(),
        states: {WidgetState.selected},
      );
      final both = await _resolve(
        tester,
        fortalDataTableStyle(),
        states: {WidgetState.selected, WidgetState.hovered},
      );

      expect(_color(idle.bodyRow), Colors.transparent);
      expect(_color(hovered.bodyRow), tokens.grayA3);
      expect(_color(selected.bodyRow), tokens.accentA3);
      expect(_color(both.bodyRow), tokens.accentA4);
      // No geometry moves between states.
      expect(hovered.bodyCell.spec.padding, idle.bodyCell.spec.padding);
      expect(selected.rowMinHeight, idle.rowMinHeight);
    });

    testWidgets('sort, selection, and pagination controls carry Fortal styles', (
      tester,
    ) async {
      final tokens = await _tokens(tester);
      final spec = await _resolve(tester, fortalDataTableStyle());

      expect(spec.sortIcon.spec.color, tokens.gray11);
      expect(spec.sortIconSpacing, 4.0);
      expect(spec.selectionColumnWidth, 48.0);
      expect(spec.selectionCheckbox, isA<CheckboxStyler>());
      expect(spec.pageButton, isA<IconButtonStyler>());
      expect(spec.pageSizeSelect, isA<SelectStyler>());
      expect(spec.footerLabel.spec.style?.color, tokens.gray11);
    });

    testWidgets('composed controls receive an unresolved inherited style', (
      tester,
    ) async {
      // A pre-resolved spec would freeze each control in the table's widget
      // state — a checked checkbox would lose its `onSelected` appearance — so
      // the table hands them unresolved styles through Mix inheritance and
      // each control resolves against its own states.
      await tester.pumpWidget(
        FortalScope(
          child: WidgetsApp(
            color: Colors.black,
            builder: (context, child) => Align(
              child: SizedBox(
                width: 500,
                child: FortalDataTable<String>(
                  rows: const ['one'],
                  columns: [
                    RemixDataTableColumn<String>(
                      id: 'value',
                      label: 'Value',
                      cellBuilder: (context, row) => Text(row),
                    ),
                  ],
                  rowId: (row) => row,
                  onSelectionChanged: (_) {},
                  totalRows: 42,
                  onPageChanged: (_) {},
                  onPageSizeChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      );

      final checkboxElement = tester.element(find.byType(RemixCheckbox).first);
      final checkboxStyle = Style.maybeOf<CheckboxSpec>(checkboxElement);
      expect(checkboxStyle, isA<CheckboxStyler>());
      // Resolving in the control's own context proves the style arrived
      // unresolved: it still carries the Radix size-1 checkbox geometry.
      expect(
        checkboxStyle!
            .build(checkboxElement)
            .spec
            .container
            .spec
            .constraints
            ?.maxWidth,
        MixScope.tokenOf(FortalTokens.checkboxSize1, checkboxElement),
      );

      expect(
        Style.maybeOf<IconButtonSpec>(
          tester.element(find.byType(RemixIconButton).first),
        ),
        isA<IconButtonStyler>(),
      );
      expect(
        Style.maybeOf<SelectSpec>(tester.element(find.byType(RemixSelect<int>))),
        isA<SelectStyler>(),
      );
    });
  });

  group('rendered Fortal table', () {
    testWidgets('renders a surface table with the pinned row height', (
      tester,
    ) async {
      await tester.pumpWidget(
        FortalScope(
          child: WidgetsApp(
            color: Colors.black,
            builder: (context, child) => Align(
              child: SizedBox(
                width: 400,
                child: FortalDataTable<String>.surface(
                  rows: const ['one', 'two'],
                  columns: [
                    RemixDataTableColumn<String>(
                      id: 'value',
                      label: 'Value',
                      cellBuilder: (context, row) => Text(row),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final table = find.byWidgetPredicate((widget) => widget is Table);
      // Header plus two body rows, each at the pinned 44px minimum.
      expect(tester.getSize(table).height, 44 * 3);
      expect(tester.takeException(), isNull);

      // The surface variant's last row merges lastBodyRow over bodyRow, so
      // exactly one of the three rendered dividers is suppressed.
      final dividers = tester
          .widgetList<Box>(find.byType(Box))
          .map(
            (box) =>
                (box.styleSpec?.spec.foregroundDecoration as BoxDecoration?)
                    ?.border,
          )
          .whereType<Border>()
          .map((border) => border.bottom.style)
          .toList();
      expect(dividers, hasLength(3));
      expect(
        dividers.where((style) => style == BorderStyle.none),
        hasLength(1),
      );
      expect(dividers.last, BorderStyle.none);
    });

    for (final (size, rowHeight) in const [
      (FortalDataTableSize.size1, 36.0),
      (FortalDataTableSize.size2, 44.0),
      (FortalDataTableSize.size3, 48.0),
    ]) {
      testWidgets('${size.name} keeps its pinned row height with selection', (
        tester,
      ) async {
        await _pumpSelectableTable(tester, size: size);

        final table = find.byWidgetPredicate((widget) => widget is Table);
        // A composed control must not inflate the row past its Radix metric.
        expect(tester.getSize(table).height, rowHeight * 2);
      });
    }

    testWidgets('the selection target tracks the column at any scaling', (
      tester,
    ) async {
      await _pumpSelectableTable(tester, scaling: .percent90);

      // Flutter's Table lays every cell out at a tight width, so a target
      // wider than the column would be silently clamped instead of honored.
      expect(
        tester.getSize(find.byType(RemixCheckbox).first),
        const Size(48 * 0.9, 44 * 0.9),
      );
    });

    testWidgets('cell content inherits the gray-12 body typography', (
      tester,
    ) async {
      late Color? inherited;
      late Color gray12;
      await tester.pumpWidget(
        FortalScope(
          child: WidgetsApp(
            color: Colors.black,
            builder: (context, child) {
              gray12 = MixScope.tokenOf(FortalTokens.gray12, context);

              return Align(
                child: SizedBox(
                  width: 400,
                  child: FortalDataTable<String>(
                    rows: const ['one'],
                    columns: [
                      RemixDataTableColumn<String>(
                        id: 'value',
                        label: 'Value',
                        cellBuilder: (context, row) => Builder(
                          builder: (context) {
                            inherited = DefaultTextStyle.of(context).style.color;

                            return Text(row);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

      expect(inherited, gray12);
    });
  });
}

Future<void> _pumpSelectableTable(
  WidgetTester tester, {
  FortalDataTableSize size = .size2,
  FortalScaling scaling = .percent100,
}) async {
  await tester.pumpWidget(
    FortalScope(
      scaling: scaling,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => Align(
          child: SizedBox(
            width: 400,
            child: FortalDataTable<String>.surface(
              size: size,
              rows: const ['one'],
              columns: [
                RemixDataTableColumn<String>(
                  id: 'value',
                  label: 'Value',
                  cellBuilder: (context, row) => Text(row),
                ),
              ],
              rowId: (row) => row,
              onSelectionChanged: (_) {},
            ),
          ),
        ),
      ),
    ),
  );
}

Future<DataTableSpec> _resolve(
  WidgetTester tester,
  DataTableStyler style, {
  FortalScaling scaling = .percent100,
  Brightness brightness = Brightness.light,
  Set<WidgetState> states = const {},
}) async {
  late DataTableSpec result;
  await tester.pumpWidget(
    FortalScope(
      brightness: brightness,
      scaling: scaling,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              result = style.build(context).spec;

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );

  return result;
}

Future<
  ({
    Color panel,
    Color tableBorder,
    Color gray11,
    Color gray12,
    Color grayA2,
    Color grayA3,
    Color grayA5,
    Color accentA3,
    Color accentA4,
  })
>
_tokens(WidgetTester tester) async {
  late ({
    Color panel,
    Color tableBorder,
    Color gray11,
    Color gray12,
    Color grayA2,
    Color grayA3,
    Color grayA5,
    Color accentA3,
    Color accentA4,
  })
  result;
  await tester.pumpWidget(
    FortalScope(
      brightness: .light,
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) {
          Color token(ColorToken value) => MixScope.tokenOf(value, context);
          result = (
            panel: token(FortalTokens.colorPanel),
            tableBorder: token(FortalTokens.dataTableBorder),
            gray11: token(FortalTokens.gray11),
            gray12: token(FortalTokens.gray12),
            grayA2: token(FortalTokens.grayA2),
            grayA3: token(FortalTokens.grayA3),
            grayA5: token(FortalTokens.grayA5),
            accentA3: token(FortalTokens.accentA3),
            accentA4: token(FortalTokens.accentA4),
          );

          return const SizedBox.shrink();
        },
      ),
    ),
  );

  return result;
}

double _radius(BoxSpec box) => (box.decoration! as BoxDecoration).borderRadius!
    .resolve(TextDirection.ltr)
    .topLeft
    .x;

Color? _color(StyleSpec<BoxSpec> style) =>
    (style.spec.decoration as BoxDecoration?)?.color;
