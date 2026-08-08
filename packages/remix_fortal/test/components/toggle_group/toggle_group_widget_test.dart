import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('shrink-wraps the segmented-control container', (tester) async {
    final nodes = _focusNodes();
    addTearDown(() => _disposeNodes(nodes));

    await tester.pumpRemixApp(
      FortalToggleGroup<String>(
        items: _items(nodes),
        selectedValue: 'list',
        onChanged: (_) {},
      ),
    );
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(FlexBox));
    expect(size.width, lessThan(400));
    expect(size.height, lessThan(100));
  });
}

List<RemixToggleGroupItem<String>> _items(List<FocusNode> nodes) {
  return [
    RemixToggleGroupItem(
      value: 'list',
      label: 'List',
      icon: Icons.view_list,
      focusNode: nodes[0],
    ),
    RemixToggleGroupItem(
      value: 'grid',
      label: 'Grid',
      icon: Icons.grid_view,
      focusNode: nodes[1],
    ),
    RemixToggleGroupItem(
      value: 'board',
      label: 'Board',
      icon: Icons.view_kanban,
      focusNode: nodes[2],
    ),
  ];
}

List<FocusNode> _focusNodes() => List.generate(3, (index) => FocusNode());

void _disposeNodes(List<FocusNode> nodes) {
  for (final node in nodes) {
    node.dispose();
  }
}
