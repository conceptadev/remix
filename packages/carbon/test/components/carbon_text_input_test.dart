import 'dart:ui' show SemanticsInputType, SemanticsValidationResult;

import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  group('CarbonTextInput', () {
    testWidgets('forwards editing behavior and accessible field semantics', (
      tester,
    ) async {
      var value = '';

      await tester.pumpCarbonApp(
        CarbonTextInput(
          label: 'Account email',
          hintText: 'name@example.com',
          helperText: 'Used for account notices',
          keyboardType: TextInputType.emailAddress,
          onChanged: (next) => value = next,
        ),
      );

      final beforeFocus = tester.state<EditableTextState>(
        find.byType(EditableText),
      );
      await tester.showKeyboard(find.byType(RemixTextField));
      final afterFocus = tester.state<EditableTextState>(
        find.byType(EditableText),
      );
      expect(afterFocus, same(beforeFocus));
      tester.testTextInput.enterText('ada@example.com');
      await tester.idle();
      expect(value, 'ada@example.com');
      expect(find.text('Account email'), findsOneWidget);
      expect(find.text('Used for account notices'), findsOneWidget);

      final semantics = tester.ensureSemantics();
      await tester.pump();
      final fields = tester.semantics
          .simulatedAccessibilityTraversal()
          .where((node) => node.getSemanticsData().flagsCollection.isTextField)
          .toList();
      expect(fields, hasLength(1));
      final node = fields.single;
      expect(
        node,
        isSemantics(
          label: 'Account email',
          value: 'ada@example.com',
          isTextField: true,
          isEnabled: true,
          hasEnabledState: true,
          isFocused: true,
          hasFocusAction: true,
          hasTapAction: true,
          hasSetTextAction: true,
          hasSetSelectionAction: true,
          inputType: SemanticsInputType.email,
        ),
      );
      semantics.dispose();
    });

    testWidgets('resolves Carbon size, type, field, and state tokens', (
      tester,
    ) async {
      for (final entry in const {
        CarbonSize.xs: 24.0,
        CarbonSize.sm: 32.0,
        CarbonSize.md: 40.0,
        CarbonSize.lg: 48.0,
      }.entries) {
        final result = await _resolveTextInput(tester, size: entry.key);
        final container = result.spec.container.spec;

        expect(container.constraints?.minHeight, entry.value);
        expect(container.constraints?.maxHeight, entry.value);
        expect(
          container.padding?.resolve(TextDirection.ltr),
          const EdgeInsets.symmetric(horizontal: 16),
        );
        expect(_background(container), result.field);
        expect(_borderBottom(container)?.color, result.borderStrong);
        expect(result.spec.text.spec.style?.fontSize, 14);
        expect(result.spec.label.spec.style?.fontSize, 12);
      }

      final focused = await _resolveTextInput(
        tester,
        states: {WidgetState.focused},
      );
      expect(focused.spec.containerEffects?.outline.color, focused.focus);
      expect(focused.spec.containerEffects?.outline.width, 2);
      expect(focused.spec.containerEffects?.outlineOffset, -2);

      final invalid = await _resolveTextInput(
        tester,
        states: {WidgetState.error},
      );
      expect(
        invalid.spec.containerEffects?.outline.color,
        invalid.supportError,
      );
      expect(invalid.spec.helperText.spec.style?.color, invalid.textError);

      final disabled = await _resolveTextInput(
        tester,
        states: {WidgetState.disabled},
      );
      expect(disabled.spec.text.spec.style?.color, disabled.textDisabled);
      expect(disabled.spec.hintText.spec.style?.color, disabled.textDisabled);
    });

    testWidgets('inherits and clamps CarbonLayoutScope size', (tester) async {
      await tester.pumpCarbonApp(
        const CarbonLayoutScope(
          size: CarbonSize.x2l,
          child: CarbonTextInput(hintText: 'Contextual'),
        ),
      );

      final box = tester
          .widgetList<ConstrainedBox>(
            find.descendant(
              of: find.byType(CarbonTextInput),
              matching: find.byType(ConstrainedBox),
            ),
          )
          .firstWhere((widget) => widget.constraints.maxHeight == 48);
      expect(box.constraints.minHeight, 48);
    });

    testWidgets('error is exposed as invalid semantics', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpCarbonApp(
        const CarbonTextInput(
          label: 'Project name',
          helperText: 'A name is required',
          error: true,
        ),
      );

      final fields = tester.semantics
          .simulatedAccessibilityTraversal()
          .where((node) => node.getSemanticsData().flagsCollection.isTextField)
          .toList();
      expect(fields, hasLength(1));
      expect(
        fields.single.getSemanticsData().validationResult,
        SemanticsValidationResult.invalid,
      );
      semantics.dispose();
    });
  });

  testWidgets('CarbonTextArea preserves multiline behavior', (tester) async {
    await tester.pumpCarbonApp(
      const CarbonTextArea(label: 'Description', minLines: 3),
    );

    final remix = tester.widget<RemixTextField>(find.byType(RemixTextArea));
    expect(remix.keyboardType, TextInputType.multiline);
    expect(remix.maxLines, isNull);
    expect(remix.minLines, 3);
  });

  testWidgets('CarbonPasswordInput owns an accessible visibility toggle', (
    tester,
  ) async {
    await tester.pumpCarbonApp(const CarbonPasswordInput(label: 'Password'));

    expect(
      tester.widget<RemixTextField>(find.byType(RemixTextField)).obscureText,
      isTrue,
    );
    await tester.tap(find.bySemanticsLabel('Show password'));
    await tester.pump();
    expect(
      tester.widget<RemixTextField>(find.byType(RemixTextField)).obscureText,
      isFalse,
    );
    expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
  });
}

Future<
  ({
    TextFieldSpec spec,
    Color field,
    Color borderStrong,
    Color focus,
    Color supportError,
    Color textError,
    Color textDisabled,
  })
>
_resolveTextInput(
  WidgetTester tester, {
  CarbonSize size = CarbonSize.md,
  Set<WidgetState> states = const {},
}) async {
  late ({
    TextFieldSpec spec,
    Color field,
    Color borderStrong,
    Color focus,
    Color supportError,
    Color textError,
    Color textDisabled,
  })
  result;
  await tester.pumpWidget(
    CarbonScope(
      child: WidgetStateProvider(
        states: states,
        child: Builder(
          builder: (context) {
            result = (
              spec: carbonTextInputStyle(size: size).build(context).spec,
              field: CarbonLayer.of(
                context,
              ).color(CarbonContextualColor.field).resolve(context),
              borderStrong: CarbonLayer.of(
                context,
              ).color(CarbonContextualColor.borderStrong).resolve(context),
              focus: CarbonTokens.focus.resolve(context),
              supportError: CarbonTokens.supportError.resolve(context),
              textError: CarbonTokens.textError.resolve(context),
              textDisabled: CarbonTokens.textDisabled.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}

Color? _background(BoxSpec spec) => (spec.decoration as BoxDecoration?)?.color;

BorderSide? _borderBottom(BoxSpec spec) =>
    ((spec.decoration as BoxDecoration?)?.border as Border?)?.bottom;
