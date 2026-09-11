import 'dart:convert';
import 'dart:io';

import 'package:demo/components/checkbox_group.dart';
import 'package:demo/components/sidebar.dart';
import 'package:demo/components/skeleton.dart';
import 'package:demo/components/toast.dart';
import 'package:demo/main.directories.g.dart';
import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  test('preview theme query matches the catalog addon contract', () {
    final addon = FortalThemeAddon();
    expect(addon.groupName, 'theme');
    for (final name in ['light', 'dark']) {
      expect(addon.valueFromQueryGroup({'name': name}).name, name);
    }
  });

  test('every documentation component maps to real Widgetbook routes', () {
    final root = WidgetbookRoot(children: directories);
    final routes = root.leaves
        .whereType<WidgetbookUseCase>()
        .map((node) => node.path)
        .toSet();
    final manifest =
        jsonDecode(
              File('../../docs/component-previews.json').readAsStringSync(),
            )
            as Map<String, dynamic>;
    final pages = Directory('../../docs/components')
        .listSync()
        .whereType<File>()
        .map((file) => file.uri.pathSegments.last.replaceAll('.mdx', ''))
        .toSet();
    expect(manifest.keys.toSet(), pages);
    for (final entry in manifest.entries) {
      expect(File('lib/components/${entry.key}.dart').existsSync(), isTrue);
      final cases = entry.value['cases'] as List;
      expect(cases, isNotEmpty);
      for (final example in cases) {
        expect(
          routes,
          contains(example['path']),
          reason: '${entry.key}: ${example['name']}',
        );
      }
    }
  });

  Future<void> show(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(MaterialApp(home: FortalScope(child: child)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);
  }

  testWidgets(
    'checkbox example changes its controlled set and keeps research disabled',
    (tester) async {
      await show(tester, const CheckboxGroupExample());
      await tester.tap(find.text('Code'));
      await tester.pump();
      expect(find.text('Selected: Design, Code'), findsOneWidget);
      await tester.tap(find.text('Research'));
      await tester.pump();
      expect(find.text('Selected: Design, Code'), findsOneWidget);
    },
  );

  testWidgets('sidebar example changes selection and keeps billing disabled', (
    tester,
  ) async {
    await show(tester, const SidebarExample());
    await tester.tap(find.text('Settings'));
    await tester.pump();
    expect(find.text('Selected: Settings'), findsOneWidget);
    await tester.tap(find.text('Billing'));
    await tester.pump();
    expect(find.text('Selected: Settings'), findsOneWidget);
  });

  testWidgets('skeleton example can reveal its content', (tester) async {
    await show(tester, const SkeletonExample());
    expect(
      tester.widget<FortalSkeleton>(find.byType(FortalSkeleton)).loading,
      isTrue,
    );
    await tester.tap(find.text('Show content'));
    await tester.pump();
    expect(
      tester.widget<FortalSkeleton>(find.byType(FortalSkeleton)).loading,
      isFalse,
    );
    expect(find.text('Show skeleton'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('toast example shows a toast whose Undo runs once', (
    tester,
  ) async {
    await show(tester, const ToastExample());
    await tester.tap(find.text('Archive conversation'));
    await tester.pumpAndSettle();
    expect(find.text('Conversation archived'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('Undone: 1'), findsOneWidget);
    expect(find.text('Conversation archived'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
