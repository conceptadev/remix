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

    // A multi-part spec (e.g. a panel wrapping an interactive trigger) can
    // mount more than one StyleBuilder<S> — one per RemixStyleSpecBuilder
    // call in the widget. Only the one wired to a WidgetStatesController
    // tracks interaction state, so filter for that instead of assuming
    // there is exactly one StyleBuilder<S> in the tree.
    final controllerElements = find
        .byType(StyleBuilder<S>)
        .evaluate()
        .whereType<StatefulElement>()
        .where(
          (element) => (element.widget as StyleBuilder<S>).controller != null,
        )
        .toList();

    if (controllerElements.isEmpty) {
      throw Exception(
        'WidgetStatesController not found in StyleBuilder widget.',
      );
    }

    final controller =
        (controllerElements.first.widget as StyleBuilder<S>).controller!;

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
  final testPointer = TestPointer(1, PointerDeviceKind.mouse)..hover(offset);
  await tester.sendEventToBinding(testPointer.hover(offset));
  await tester.pumpAndSettle();
  addTearDown(() {
    testPointer.removePointer();
  });
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
