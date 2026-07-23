import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as ftest;
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mix/mix.dart';
import 'package:remix/remix.dart';

@isTest
void styleMethodTest<S>(
  String description, {
  required S initial,
  required S Function(S) modify,
  required void Function(S) expect,
}) {
  ftest.test(description, () {
    final newStyle = modify(initial);

    ftest.expect(newStyle, ftest.isNot(ftest.same(initial)));
    ftest.expect(newStyle, ftest.isA<S>());
    expect(newStyle);
  });
}

@isTest
void widgetControllerTest<S extends Spec<S>>(
  String description, {
  required Widget Function() build,
  Future<void> Function(WidgetTester tester)? act,
  required Set<WidgetState> expectedStates,
}) {
  ftest.testWidgets(description, (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(padding: const EdgeInsets.all(8.0), child: build()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await act?.call(tester);

    // Use find to get all descendants of type StyleBuilder
    final finder = find.byType(StyleBuilder<S>);
    ftest.expect(finder, ftest.findsOneWidget);

    final styleBuilderElements = finder
        .evaluate()
        .whereType<StatefulElement>()
        .toList();

    if (styleBuilderElements.isEmpty) {
      throw Exception('StyleBuilder widget not found in widget tree.');
    }

    // Get the controller from the first StyleBuilder's widget
    final styleBuilderWidget =
        styleBuilderElements.first.widget as StyleBuilder<S>;

    final controller = styleBuilderWidget.controller;

    if (controller == null) {
      throw Exception(
        'WidgetStatesController not found in StyleBuilder widget.',
      );
    }

    final states = controller.value;
    expect(states, equals(expectedStates));
  });
}

Future<void> sendKeyAndSettle(
  WidgetTester tester,
  LogicalKeyboardKey key,
) async {
  await tester.sendKeyEvent(key);
  await tester.pumpAndSettle();
}

Future<void> hoverAction<T>(WidgetTester tester) async {
  final offset = tester.getCenter(find.byType(T));
  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await gesture.addPointer(location: Offset.zero);
  await gesture.moveTo(offset);
  await tester.pumpAndSettle();
  addTearDown(gesture.removePointer);
}

Future<void> focusAction<T>(WidgetTester tester) async {
  final buttonFinder = find.byType(T);
  expect(buttonFinder, findsOneWidget);
  await tester.ensureVisible(buttonFinder);
  await tester.pump();
  await tester.sendKeyEvent(LogicalKeyboardKey.tab);
  await tester.pumpAndSettle();
}

Future<void> pressAction<T>(WidgetTester tester) async {
  final buttonFinder = find.byType(T);
  expect(buttonFinder, findsOneWidget);
  await tester.press(buttonFinder);
  await tester.pumpAndSettle();
}
