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
}

Finder _pathGlyph(RemixPathGlyph glyph) => find.byWidgetPredicate(
  (widget) => widget is RemixPathIcon && widget.glyph == glyph,
);
