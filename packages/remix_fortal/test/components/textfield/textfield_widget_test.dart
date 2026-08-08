import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/gestures.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('Fortal variants keep text and container colors separate', (
    tester,
  ) async {
    await tester.pumpRemixApp(const FortalTextField.surface());
    var context = tester.element(find.byType(FortalTextField));
    var colors = resolveFortalTokens(const FortalThemeConfig());
    var spec = fortalTextFieldStyle(
      variant: FortalTextFieldVariant.surface,
    ).resolve(context).spec;
    var decoration = spec.container.spec.decoration! as BoxDecoration;

    expect(spec.text.spec.style?.color, colors.gray.scale.step(12));
    expect(decoration.color, colors.colorSurface);

    await tester.pumpRemixApp(const FortalTextField.soft());
    context = tester.element(find.byType(FortalTextField));
    colors = resolveFortalTokens(const FortalThemeConfig());
    spec = fortalTextFieldStyle(
      variant: FortalTextFieldVariant.soft,
    ).resolve(context).spec;
    decoration = spec.container.spec.decoration! as BoxDecoration;

    expect(spec.text.spec.style?.color, colors.accent.scale.step(12));
    expect(decoration.color, colors.accent.scale.alphaStep(3));
  });
  testWidgets('read-only Fortal fields stay focusable and selectable', (
    tester,
  ) async {
    final controller = TextEditingController(
      text: 'Selectable read-only value',
    );
    final focusNode = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);
    late Color grayA5;

    await tester.pumpRemixApp(
      Builder(
        builder: (context) {
          grayA5 = MixScope.tokenOf(FortalTokens.grayA5, context);
          return FortalTextField.surface(
            controller: controller,
            focusNode: focusNode,
            readOnly: true,
          );
        },
      ),
    );

    final editable = find.byType(EditableText);
    final gesture = await tester.startGesture(
      tester.getCenter(editable) - const Offset(70, 0),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump(kPressTimeout);
    await gesture.moveBy(const Offset(120, 0));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(focusNode.hasFocus, isTrue);
    expect(controller.selection.isCollapsed, isFalse);
    expect(tester.widget<EditableText>(editable).selectionColor, grayA5);
  });
  testWidgets('all Fortal input variants apply read-only color roles', (
    tester,
  ) async {
    final cases = <({String name, TextFieldStyler style, bool textArea})>[
      for (final variant in FortalTextFieldVariant.values)
        (
          name: 'TextField ${variant.name}',
          style: fortalTextFieldStyle(variant: variant),
          textArea: false,
        ),
      for (final variant in FortalTextAreaVariant.values)
        (
          name: 'TextArea ${variant.name}',
          style: fortalTextAreaStyle(variant: variant),
          textArea: true,
        ),
    ];

    for (final testCase in cases) {
      final controller = TextEditingController(text: testCase.name);
      final focusNode = FocusNode();
      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);
      late Color grayA5;
      late Color grayA11;

      await tester.pumpRemixApp(
        Builder(
          builder: (context) {
            grayA5 = MixScope.tokenOf(FortalTokens.grayA5, context);
            grayA11 = MixScope.tokenOf(FortalTokens.grayA11, context);
            return testCase.textArea
                ? RemixTextArea(
                    controller: controller,
                    focusNode: focusNode,
                    readOnly: true,
                    style: testCase.style,
                  )
                : RemixTextField(
                    controller: controller,
                    focusNode: focusNode,
                    readOnly: true,
                    style: testCase.style,
                  );
          },
        ),
      );

      await tester.tap(find.byType(EditableText));
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );
      await tester.pump();

      expect(focusNode.hasFocus, isTrue, reason: testCase.name);
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).selectionColor,
        grayA5,
        reason: testCase.name,
      );
      expect(
        tester.widget<NakedTextField>(find.byType(NakedTextField)).cursorColor,
        grayA11,
        reason: testCase.name,
      );
      expect(controller.selection.isCollapsed, isFalse);
    }
  });
}
