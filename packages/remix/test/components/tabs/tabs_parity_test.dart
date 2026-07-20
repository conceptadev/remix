import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixTabBar structural contract', () {
    test('styler call accepts actual tab children and layout inputs', () {
      final styler = RemixTabBarStyler();
      const children = <Widget>[
        RemixTab(tabId: 'one', label: 'One'),
        RemixTab(tabId: 'two', label: 'Two'),
      ];
      final bar = styler(
        children: children,
        wrap: RemixTabBarWrap.wrapReverse,
        justify: RemixTabBarJustify.end,
      );

      expect(bar.style, same(styler));
      expect(bar.children, same(children));
      expect(bar.wrap, RemixTabBarWrap.wrapReverse);
      expect(bar.justify, RemixTabBarJustify.end);
    });

    testWidgets('uses root orientation for a nowrap scrolling list', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixTabs(
          selectedTabId: 'one',
          orientation: Axis.vertical,
          child: RemixTabBar(
            children: [
              RemixTab(tabId: 'one', label: 'One'),
              RemixTab(tabId: 'two', label: 'Two'),
            ],
          ),
        ),
      );

      final scroll = tester.widget<SingleChildScrollView>(
        find.descendant(
          of: find.byType(RemixTabBar),
          matching: find.byType(SingleChildScrollView),
        ),
      );
      expect(scroll.scrollDirection, Axis.vertical);
      expect(find.byType(NakedTabBar), findsOneWidget);
    });

    testWidgets('wraps actual children with requested justification', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const SizedBox(
          width: 160,
          child: RemixTabs(
            selectedTabId: 'one',
            child: RemixTabBar(
              wrap: RemixTabBarWrap.wrap,
              justify: RemixTabBarJustify.center,
              children: [
                SizedBox(
                  width: 100,
                  child: RemixTab(tabId: 'one', label: 'One'),
                ),
                SizedBox(
                  width: 100,
                  child: RemixTab(tabId: 'two', label: 'Two'),
                ),
              ],
            ),
          ),
        ),
      );

      final wrap = tester.widget<Wrap>(find.byType(Wrap));
      expect(wrap.alignment, WrapAlignment.center);
      expect(wrap.children, hasLength(2));
      expect(tester.getTopLeft(find.text('Two')).dy, greaterThan(0));
    });

    testWidgets('maps every wrap justify and orientation to rendered layout', (
      tester,
    ) async {
      const expectedMainAxis = <RemixTabBarJustify, MainAxisAlignment>{
        RemixTabBarJustify.start: MainAxisAlignment.start,
        RemixTabBarJustify.center: MainAxisAlignment.center,
        RemixTabBarJustify.end: MainAxisAlignment.end,
      };
      const expectedWrap = <RemixTabBarJustify, WrapAlignment>{
        RemixTabBarJustify.start: WrapAlignment.start,
        RemixTabBarJustify.center: WrapAlignment.center,
        RemixTabBarJustify.end: WrapAlignment.end,
      };

      for (final orientation in Axis.values) {
        for (final wrapMode in RemixTabBarWrap.values) {
          for (final justify in RemixTabBarJustify.values) {
            await tester.pumpRemixApp(
              SizedBox(
                width: 200,
                height: 200,
                child: RemixTabs(
                  selectedTabId: 'one',
                  orientation: orientation,
                  child: RemixTabBar(
                    wrap: wrapMode,
                    justify: justify,
                    children: const [
                      RemixTab(tabId: 'one', label: 'One'),
                      RemixTab(tabId: 'two', label: 'Two'),
                    ],
                  ),
                ),
              ),
            );

            final bar = find.byType(RemixTabBar);
            final nakedBar = tester.widget<NakedTabBar>(
              find.descendant(of: bar, matching: find.byType(NakedTabBar)),
            );
            if (wrapMode == RemixTabBarWrap.nowrap) {
              final scroll = tester.widget<SingleChildScrollView>(
                find.descendant(
                  of: bar,
                  matching: find.byType(SingleChildScrollView),
                ),
              );
              final flex = nakedBar.child as Flex;
              expect(scroll.scrollDirection, orientation);
              expect(flex.direction, orientation);
              expect(flex.mainAxisAlignment, expectedMainAxis[justify]);
              continue;
            }

            final renderedWrap = nakedBar.child as Wrap;
            expect(renderedWrap.direction, orientation);
            expect(renderedWrap.alignment, expectedWrap[justify]);
            if (orientation == Axis.horizontal) {
              expect(
                renderedWrap.verticalDirection,
                wrapMode == RemixTabBarWrap.wrapReverse
                    ? VerticalDirection.up
                    : VerticalDirection.down,
              );
              expect(renderedWrap.textDirection, TextDirection.ltr);
            } else {
              expect(renderedWrap.verticalDirection, VerticalDirection.down);
              expect(
                renderedWrap.textDirection,
                wrapMode == RemixTabBarWrap.wrapReverse
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              );
            }
          }
        }
      }
    });

    testWidgets('exposes one tab-bar semantics role', (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          const RemixTabs(
            selectedTabId: 'one',
            child: RemixTabBar(
              children: [RemixTab(tabId: 'one', label: 'One')],
            ),
          ),
        );

        expect(
          find.descendant(
            of: find.byType(NakedTabBar),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics &&
                  widget.properties.role == SemanticsRole.tabBar,
            ),
          ),
          findsOneWidget,
        );
      } finally {
        semantics.dispose();
      }
    });
  });

  group('RemixTab fields', () {
    test('forwards semantic exclusion through its styler', () {
      final tab = RemixTabStyler()(
        tabId: 'one',
        label: 'One',
        excludeSemantics: true,
      );
      expect(tab.excludeSemantics, isTrue);
    });

    test('tab views expose state-maintenance control', () {
      const view = RemixTabView(
        tabId: 'one',
        maintainState: false,
        child: Text('One'),
      );
      expect(view.maintainState, isFalse);
    });
  });
}
