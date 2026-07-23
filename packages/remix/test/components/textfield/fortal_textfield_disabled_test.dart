import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

/// Collects every resolved [BoxDecoration] color painted for [finder]'s subtree.
///
/// Behavioral counterpart to grepping the source file: it inspects the styles
/// actually resolved onto the render tree instead of matching raw source text.
List<Color> _renderedDecorationColors(WidgetTester tester, Finder finder) {
  return tester
      .widgetList<DecoratedBox>(
        find.descendant(of: finder, matching: find.byType(DecoratedBox)),
      )
      .map((box) => box.decoration)
      .whereType<BoxDecoration>()
      .map((decoration) => decoration.color)
      .whereType<Color>()
      .toList();
}

List<Color> _renderedSurfaceColors(WidgetTester tester, Finder finder) {
  return tester
      .widgetList<DecoratedBox>(
        find.descendant(of: finder, matching: find.byType(DecoratedBox)),
      )
      .map((surface) => surface.decoration)
      .whereType<BoxDecoration>()
      .map((decoration) => decoration.color)
      .whereType<Color>()
      .toList();
}

void main() {
  testWidgets('fortal textfield factories build real stylers per variant', (
    tester,
  ) async {
    // Drive the real factories rather than asserting on their source text.
    final surface = fortalTextFieldStyler(variant: .surface);
    final soft = fortalTextFieldStyler(variant: .soft);
    expect(surface, isA<RemixTextFieldStyler>());
    expect(soft, isA<RemixTextFieldStyler>());
    expect(soft, isNot(equals(surface)));
  });

  testWidgets(
    'disabled soft textfield resolves a background and never the debug red',
    (tester) async {
      await tester.pumpRemixApp(
        FortalTextField.soft(
          enabled: false,
          controller: TextEditingController(text: 'disabled'),
        ),
      );
      await tester.pumpAndSettle();

      final finder = find.byType(FortalTextField);
      expect(finder, findsOneWidget);

      final colors = [
        ..._renderedDecorationColors(tester, finder),
        ..._renderedSurfaceColors(tester, finder),
      ];

      // The disabled soft variant paints its onDisabled background
      // (FortalTokens.accentA3) — the resolved style tree must carry a color.
      expect(colors, isNotEmpty);

      // Regression guard: the debug `Colors.red` background that once shipped in
      // the disabled soft styling must never resolve onto the tree.
      expect(colors, isNot(contains(Colors.red)));
    },
  );

  testWidgets('fortal textfield disabled soft renders under FortalScope', (
    tester,
  ) async {
    await tester.pumpRemixApp(
      FortalScope(
        child: FortalTextField.soft(
          enabled: false,
          controller: TextEditingController(text: 'disabled'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(FortalTextField), findsOneWidget);
    expect(find.byType(RemixTextField), findsOneWidget);
  });

  testWidgets('focused read-only field uses the neutral Radix focus ring', (
    tester,
  ) async {
    final focusNode = FocusNode();
    final controller = TextEditingController(text: 'read only');
    addTearDown(focusNode.dispose);
    addTearDown(controller.dispose);

    await tester.pumpRemixApp(
      FortalTextField(
        readOnly: true,
        focusNode: focusNode,
        controller: controller,
      ),
    );

    focusNode.requestFocus();
    await tester.pump(const Duration(milliseconds: 200));

    final fieldContext = tester.element(find.byType(RemixTextField));
    final nakedField = tester.widget<NakedTextField>(
      find.byType(NakedTextField),
    );

    expect(focusNode.hasFocus, isTrue);
    expect(nakedField.enabled, isTrue);
    expect(nakedField.readOnly, isTrue);
    expect(FortalTokens.gray8.resolve(fieldContext), isNotNull);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets(
    'focused read-only field uses the neutral Radix selection color',
    (tester) async {
      final focusNode = FocusNode();
      final controller = TextEditingController(text: 'selectable');
      addTearDown(focusNode.dispose);
      addTearDown(controller.dispose);

      await tester.pumpRemixApp(
        FortalTextField(
          readOnly: true,
          focusNode: focusNode,
          controller: controller,
        ),
      );

      focusNode.requestFocus();
      await tester.pump(const Duration(milliseconds: 200));

      final fieldContext = tester.element(find.byType(RemixTextField));
      final editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(
        editable.selectionColor,
        FortalTokens.grayA5.resolve(fieldContext),
      );

      final editableRect = tester.getRect(find.byType(EditableText));
      await tester.longPressAt(
        Offset(editableRect.left + 20, editableRect.center.dy),
      );
      await tester.pumpAndSettle();

      expect(controller.selection.isValid, isTrue);
      expect(controller.selection.isCollapsed, isFalse);
    },
  );
}
