import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';

void main() {
  testWidgets('default controls render under WidgetsApp', (tester) async {
    await tester.pumpWidget(
      MixScope.empty(
        child: WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (context, child) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const RemixSpinner(),
                RemixCheckbox(
                  selected: true,
                  onChanged: (_) {},
                  minimumTapTargetSize: Size.zero,
                ),
                RemixAccordionGroup<String>(
                  controller: RemixAccordionController<String>(),
                  child: const RemixAccordion<String>(
                    value: 'material-free',
                    title: 'Material free',
                    child: Text('Panel'),
                  ),
                ),
                RemixIconButton(
                  iconBuilder: (context, spec, icon) =>
                      const SizedBox.square(dimension: 12),
                  semanticLabel: 'Custom icon',
                  onPressed: () {},
                ),
                SizedBox(
                  width: 600,
                  child: RemixDataTable<int>(
                    rows: const [1],
                    columns: [
                      RemixDataTableColumn<int>(
                        id: 'value',
                        label: 'Value',
                        sortable: true,
                        cellBuilder: (context, row) => Text('$row'),
                      ),
                    ],
                    onSortChanged: (_) {},
                    totalRows: 1,
                    pageSizeOptions: const [10],
                    onPageChanged: (_) {},
                    onPageSizeChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(_pathGlyph(RemixPathGlyph.check), findsOneWidget);
    expect(_pathGlyph(RemixPathGlyph.plus), findsOneWidget);
    expect(_pathGlyph(RemixPathGlyph.caretSort), findsOneWidget);
    expect(_pathGlyph(RemixPathGlyph.chevronLeft), findsOneWidget);
    expect(_pathGlyph(RemixPathGlyph.chevronRight), findsOneWidget);
  });

  testWidgets('path defaults honor IconTheme and IconSpec behavior', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MixScope.empty(
        child: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: IconTheme(
                data: const IconThemeData(
                  size: 10,
                  color: Color(0xFFFF0000),
                  opacity: 0.5,
                  shadows: [
                    Shadow(
                      color: Color(0xFF00FF00),
                      offset: Offset(1, 1),
                      blurRadius: 1,
                    ),
                  ],
                  applyTextScaling: true,
                ),
                child: const RemixPathIcon(
                  glyph: RemixPathGlyph.chevronRight,
                  matchTextDirection: true,
                  styleSpec: StyleSpec(
                    spec: IconSpec(
                      semanticsLabel: 'Next page',
                      textDirection: TextDirection.ltr,
                      blendMode: BlendMode.src,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(RemixPathIcon)), const Size.square(20));
    expect(find.bySemanticsLabel('Next page'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(RemixPathIcon),
        matching: find.byType(CustomPaint),
      ),
      paints
        ..path(color: const Color(0xFF00FF00), hasMaskFilter: true)
        ..something((method, arguments) {
          if (method != #drawPath) return false;
          final paint = arguments[1] as Paint;
          return (paint.color.a - 0.5).abs() < 0.001 &&
              paint.color.r == 1 &&
              paint.color.g == 0 &&
              paint.color.b == 0 &&
              paint.blendMode == BlendMode.src;
        }),
    );
    expect(
      find.descendant(
        of: find.byType(RemixPathIcon),
        matching: find.byType(CustomPaint),
      ),
      paints..everything(
        (method, arguments) =>
            method != #scale || (arguments.first as double) >= 0,
      ),
    );
    semantics.dispose();
  });
}

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);
