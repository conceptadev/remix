import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  for (final customChild in [false, true]) {
    testWidgets('tab container preserves dimensions with child: $customChild', (
      tester,
    ) async {
      const key = ValueKey('sized-tab');
      String? selected;
      await tester.pumpRemixApp(
        RemixTabs(
          selectedTabId: 'b',
          onChanged: (value) => selected = value,
          child: Column(
            children: [
              RemixTabBar(
                child: Row(
                  children: [
                    RemixTab(
                      key: key,
                      tabId: 'a',
                      semanticLabel: 'A',
                      label: customChild ? null : 'A',
                      child: customChild
                          ? const SizedBox(width: 10, height: 10)
                          : null,
                      style: TabStyler().container(
                        FlexBoxStyler().width(80).height(40),
                      ),
                    ),
                    const RemixTab(tabId: 'b', label: 'B'),
                  ],
                ),
              ),
              const RemixTabView(tabId: 'b', child: Text('Panel')),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byKey(key)), const Size(80, 40));
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(selected, 'a');
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('explicit builder can replace the styled default', (
    tester,
  ) async {
    const key = ValueKey('custom-builder-tab');
    Widget? defaultContent;
    await tester.pumpRemixApp(
      RemixTabs(
        selectedTabId: 'a',
        child: RemixTabBar(
          child: Row(
            children: [
              RemixTab(
                key: key,
                tabId: 'a',
                semanticLabel: 'A',
                child: const SizedBox(width: 10, height: 10),
                style: TabStyler().container(
                  FlexBoxStyler().width(80).height(40),
                ),
                builder: (_, _, child) {
                  defaultContent = child;
                  return const SizedBox(width: 24, height: 24);
                },
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(defaultContent, isA<FlexBox>());
    expect(tester.getSize(find.byKey(key)), const Size(24, 24));
    expect(tester.takeException(), isNull);
  });
}
