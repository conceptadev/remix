import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  testWidgets('badge applies its resolved foreground color to icons', (
    tester,
  ) async {
    const iconKey = ValueKey('badge-icon');

    await tester.pumpRemixApp(
      IconTheme(
        data: const IconThemeData(color: Colors.purple),
        child: RemixBadge(
          style: RemixBadgeStyler().foregroundColor(Colors.green),
          child: const Icon(Icons.check, key: iconKey),
        ),
      ),
    );

    expect(
      IconTheme.of(tester.element(find.byKey(iconKey))).color,
      Colors.green,
    );
  });

  testWidgets('spinner preserves unkeyed child state when loading changes', (
    tester,
  ) async {
    var loading = false;
    var initializationCount = 0;
    late StateSetter rebuild;

    await tester.pumpRemixApp(
      StatefulBuilder(
        builder: (context, setState) {
          rebuild = setState;
          return RemixSpinner(
            loading: loading,
            child: _StatefulProbe(onInitialize: () => initializationCount++),
          );
        },
      ),
    );
    expect(initializationCount, 1);

    rebuild(() => loading = true);
    await tester.pump();
    expect(initializationCount, 1);

    rebuild(() => loading = false);
    await tester.pump();
    expect(initializationCount, 1);
  });

  testWidgets('tab bounds grow to fit the visible interaction style', (
    tester,
  ) async {
    const tabKey = ValueKey('resizing-tab');
    final focusNode = FocusNode();
    final changes = <String>[];
    addTearDown(focusNode.dispose);

    final style = RemixTabStyler()
        .container(FlexBoxStyler().paddingX(2).paddingY(2))
        .onSelected(
          RemixTabStyler().container(FlexBoxStyler().paddingX(0).paddingY(0)),
        )
        .onFocused(
          RemixTabStyler().container(FlexBoxStyler().paddingX(30).paddingY(10)),
        );

    await tester.pumpRemixApp(
      RemixTabs(
        selectedTabId: 'other',
        onChanged: changes.add,
        child: RemixTabBar(
          children: [
            RemixTab(
              key: tabKey,
              tabId: 'target',
              label: 'Target',
              focusNode: focusNode,
              style: style,
            ),
            const RemixTab(tabId: 'other', label: 'Other'),
          ],
        ),
      ),
    );

    final restingSize = tester.getSize(find.byKey(tabKey));
    focusNode.requestFocus();
    await tester.pump();

    final rect = tester.getRect(find.byKey(tabKey));
    expect(rect.width, greaterThan(restingSize.width + 50));
    expect(rect.height, greaterThan(restingSize.height + 15));

    changes.clear();
    await tester.tapAt(Offset(rect.right - 1, rect.center.dy));
    await tester.pump();
    expect(changes, ['target']);
  });

  testWidgets('tight slider thumb constraints include their padding', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      SizedBox(
        width: 200,
        height: 48,
        child: RemixSlider(
          values: const [50],
          onChanged: (_) {},
          style: RemixSliderStyler().thumb(
            BoxStyler().size(16, 16).paddingAll(2),
          ),
        ),
      ),
    );

    expect(
      tester.getSize(find.byKey(const ValueKey('remix-slider-thumb-0'))),
      const Size.square(16),
    );
  });
}

class _StatefulProbe extends StatefulWidget {
  const _StatefulProbe({required this.onInitialize});

  final VoidCallback onInitialize;

  @override
  State<_StatefulProbe> createState() => _StatefulProbeState();
}

class _StatefulProbeState extends State<_StatefulProbe> {
  @override
  void initState() {
    super.initState();
    widget.onInitialize();
  }

  @override
  Widget build(BuildContext context) => const SizedBox(width: 80, height: 32);
}
