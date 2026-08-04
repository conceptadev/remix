import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixTextArea', () {
    testWidgets('uses safe multiline defaults', (tester) async {
      await tester.pumpRemixApp(const RemixTextArea());

      final textArea = tester.widget<RemixTextArea>(find.byType(RemixTextArea));
      final nakedTextField = tester.widget<NakedTextField>(
        find.byType(NakedTextField),
      );
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(textArea, isA<RemixTextField>());
      expect(textArea.minLines, 2);
      expect(textArea.maxLines, isNull);
      expect(nakedTextField.keyboardType, TextInputType.multiline);
      expect(nakedTextField.textInputAction, TextInputAction.newline);
      expect(nakedTextField.minLines, 2);
      expect(nakedTextField.maxLines, isNull);
      expect(nakedTextField.expands, isFalse);
      expect(nakedTextField.obscureText, isFalse);
      expect(editableText.minLines, 2);
      expect(editableText.maxLines, isNull);
      expect(editableText.expands, isFalse);
      expect(editableText.obscureText, isFalse);
    });

    testWidgets('preserves newlines through the shared input pipeline', (
      tester,
    ) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      String? changedValue;

      await tester.pumpRemixApp(
        RemixTextArea(
          controller: controller,
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.enterText(find.byType(RemixTextArea), 'first\nsecond');
      await tester.pump();

      expect(controller.text, 'first\nsecond');
      expect(changedValue, 'first\nsecond');
    });

    testWidgets('forwards valid line and input overrides', (tester) async {
      await tester.pumpRemixApp(
        const RemixTextArea(
          minLines: 3,
          maxLines: 5,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
        ),
      );

      final nakedTextField = tester.widget<NakedTextField>(
        find.byType(NakedTextField),
      );
      expect(nakedTextField.minLines, 3);
      expect(nakedTextField.maxLines, 5);
      expect(nakedTextField.keyboardType, TextInputType.streetAddress);
      expect(nakedTextField.textInputAction, TextInputAction.done);
      expect(nakedTextField.expands, isFalse);
      expect(nakedTextField.obscureText, isFalse);
    });

    testWidgets('forwards the complete supported editing surface', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'Initial note');
      final focusNode = FocusNode();
      final undoController = UndoHistoryController();
      final scrollController = ScrollController();
      final groupId = Object();
      final formatter = FilteringTextInputFormatter.allow(RegExp('[a-z ]'));
      final insertion = ContentInsertionConfiguration(
        onContentInserted: (_) {},
        allowedMimeTypes: const ['image/png'],
      );
      const spellCheck = SpellCheckConfiguration.disabled();
      final magnifier = TextMagnifier.adaptiveMagnifierConfiguration;
      void onChanged(String _) {}
      void onEditingComplete() {}
      void onSubmitted(String _) {}
      void onPrivateCommand(String _, Map<String, dynamic> __) {}
      void onTap() {}
      void onTapOutside(PointerDownEvent _) {}
      void onTapUpOutside(PointerUpEvent _) {}
      Widget contextMenuBuilder(
        BuildContext context,
        EditableTextState editableTextState,
      ) => const SizedBox();

      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);
      addTearDown(undoController.dispose);
      addTearDown(scrollController.dispose);

      await tester.pumpRemixApp(
        RemixTextArea(
          key: const ValueKey('complete-surface'),
          controller: controller,
          focusNode: focusNode,
          undoController: undoController,
          groupId: groupId,
          label: 'Notes',
          hintText: 'Write notes',
          helperText: 'Plain text',
          error: false,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          textDirection: TextDirection.rtl,
          enabled: true,
          readOnly: false,
          autofocus: false,
          minLines: 2,
          maxLines: 4,
          maxLength: 120,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          onAppPrivateCommand: onPrivateCommand,
          inputFormatters: [formatter],
          showCursor: true,
          autocorrect: false,
          enableSuggestions: false,
          smartDashesType: SmartDashesType.disabled,
          smartQuotesType: SmartQuotesType.disabled,
          dragStartBehavior: DragStartBehavior.down,
          enableInteractiveSelection: false,
          selectionControls: materialTextSelectionHandleControls,
          onTap: onTap,
          onTapOutside: onTapOutside,
          onPressUpOutside: onTapUpOutside,
          onTapAlwaysCalled: true,
          scrollController: scrollController,
          scrollPhysics: const ClampingScrollPhysics(),
          autofillHints: const [AutofillHints.postalAddress],
          contentInsertionConfiguration: insertion,
          clipBehavior: Clip.none,
          restorationId: 'notes-field',
          stylusHandwritingEnabled: false,
          enableIMEPersonalizedLearning: false,
          contextMenuBuilder: contextMenuBuilder,
          spellCheckConfiguration: spellCheck,
          magnifierConfiguration: magnifier,
          canRequestFocus: true,
          ignorePointers: false,
          leading: const Icon(Icons.notes),
          trailing: const Icon(Icons.edit),
          semanticLabel: 'Detailed notes',
          semanticHint: 'Enter multiple lines',
          excludeSemantics: false,
          style: TextFieldStyler().cursorColor(Colors.indigo),
        ),
      );
      await tester.pump();

      final area = tester.widget<RemixTextArea>(find.byType(RemixTextArea));
      final naked = tester.widget<NakedTextField>(find.byType(NakedTextField));
      expect(area.key, const ValueKey('complete-surface'));
      expect(naked.controller, same(controller));
      expect(naked.focusNode, same(focusNode));
      expect(naked.undoController, same(undoController));
      expect(naked.groupId, same(groupId));
      expect(naked.keyboardType, TextInputType.streetAddress);
      expect(naked.textInputAction, TextInputAction.done);
      expect(naked.textCapitalization, TextCapitalization.sentences);
      expect(naked.textDirection, TextDirection.rtl);
      expect(naked.minLines, 2);
      expect(naked.maxLines, 4);
      expect(naked.maxLength, 120);
      expect(naked.maxLengthEnforcement, MaxLengthEnforcement.none);
      expect(naked.onChanged, same(onChanged));
      expect(naked.onEditingComplete, same(onEditingComplete));
      expect(naked.onSubmitted, same(onSubmitted));
      expect(naked.onAppPrivateCommand, same(onPrivateCommand));
      expect(naked.inputFormatters, contains(same(formatter)));
      expect(naked.showCursor, isTrue);
      expect(naked.autocorrect, isFalse);
      expect(naked.enableSuggestions, isFalse);
      expect(naked.smartDashesType, SmartDashesType.disabled);
      expect(naked.smartQuotesType, SmartQuotesType.disabled);
      expect(naked.dragStartBehavior, DragStartBehavior.down);
      expect(naked.enableInteractiveSelection, isFalse);
      expect(
        naked.selectionControls,
        same(materialTextSelectionHandleControls),
      );
      expect(naked.onTap, same(onTap));
      expect(naked.onTapOutside, same(onTapOutside));
      expect(naked.onTapUpOutside, same(onTapUpOutside));
      expect(naked.onTapAlwaysCalled, isTrue);
      expect(naked.scrollController, same(scrollController));
      expect(naked.scrollPhysics, isA<ClampingScrollPhysics>());
      expect(naked.autofillHints, [AutofillHints.postalAddress]);
      expect(naked.contentInsertionConfiguration, same(insertion));
      expect(naked.clipBehavior, Clip.none);
      expect(naked.restorationId, 'notes-field');
      expect(naked.stylusHandwritingEnabled, isFalse);
      expect(naked.enableIMEPersonalizedLearning, isFalse);
      expect(naked.contextMenuBuilder, same(contextMenuBuilder));
      expect(naked.spellCheckConfiguration, same(spellCheck));
      expect(naked.magnifierConfiguration, same(magnifier));
      expect(naked.canRequestFocus, isTrue);
      expect(naked.ignorePointers, isFalse);
      expect(naked.semanticLabel, 'Detailed notes');
      expect(naked.semanticHint, 'Enter multiple lines\nPlain text');
      expect(naked.excludeSemantics, isFalse);
      expect(naked.expands, isFalse);
      expect(naked.obscureText, isFalse);
      expect(naked.cursorColor, Colors.indigo);
      expect(find.byIcon(Icons.notes), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('uses the canonical fluent styler and raw spec unchanged', (
      tester,
    ) async {
      expect(RemixTextArea.styleFrom(), isA<TextFieldStyler>());

      await tester.pumpRemixApp(
        RemixTextArea(
          style: TextFieldStyler()
              .cursorColor(Colors.teal)
              .textAlign(TextAlign.end),
        ),
      );
      await tester.pump();

      var naked = tester.widget<NakedTextField>(find.byType(NakedTextField));
      expect(naked.cursorColor, Colors.teal);
      expect(naked.textAlign, TextAlign.end);

      await tester.pumpRemixApp(
        const RemixTextArea(
          styleSpec: TextFieldSpec(
            cursorColor: Colors.orange,
            cursorWidth: 5,
            textAlign: TextAlign.center,
          ),
        ),
      );
      await tester.pump();

      naked = tester.widget<NakedTextField>(find.byType(NakedTextField));
      expect(naked.cursorColor, Colors.orange);
      expect(naked.cursorWidth, 5);
      expect(naked.textAlign, TextAlign.center);
    });

    testWidgets(
      'tracks controller and error replacements through shared state',
      (tester) async {
        final firstController = TextEditingController(text: 'first');
        final secondController = TextEditingController(text: 'second');
        addTearDown(firstController.dispose);
        addTearDown(secondController.dispose);
        var controller = firstController;
        var error = false;
        late StateSetter rebuild;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return RemixTextArea(
                controller: controller,
                hintText: 'Add details',
                helperText: error ? 'Notes are required' : 'Optional notes',
                error: error,
                style: TextFieldStyler(cursorColor: Colors.blue).variant(
                  ContextVariant.widgetState(.error),
                  TextFieldStyler(cursorColor: Colors.red),
                ),
              );
            },
          ),
        );
        await tester.pump();

        expect(
          tester.widget<EditableText>(find.byType(EditableText)).controller,
          same(firstController),
        );
        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .cursorColor,
          Colors.blue,
        );

        rebuild(() {
          controller = secondController;
          error = true;
        });
        await tester.pump();

        expect(
          tester.widget<EditableText>(find.byType(EditableText)).controller,
          same(secondController),
        );
        expect(find.text('second'), findsOneWidget);
        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .cursorColor,
          Colors.red,
        );
        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .semanticHint,
          'Add details',
        );
        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .semanticErrorText,
          'Notes are required',
        );
      },
    );

    testWidgets('focuses a caller node from the non-editable composite', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpRemixApp(
        RemixTextArea(label: 'Notes', focusNode: focusNode),
      );
      await tester.tap(find.text('Notes'));
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('wraps and grows without overflow at 200 percent text scale', (
      tester,
    ) async {
      final controller = TextEditingController(
        text: 'A long first line that wraps in a narrow field.\nSecond line.',
      );
      addTearDown(controller.dispose);

      await tester.pumpRemixApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: SizedBox(
            width: 180,
            child: RemixTextArea(
              controller: controller,
              minLines: 2,
              maxLines: 5,
              hintText: 'Long multiline guidance',
            ),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RemixTextArea)).width, 180);
      expect(tester.getSize(find.byType(EditableText)).height, greaterThan(40));
    });

    test('rejects invalid line ranges at construction', () {
      expect(() => RemixTextArea(minLines: 0), throwsAssertionError);
      expect(() => RemixTextArea(maxLines: 0), throwsAssertionError);
      expect(
        () => RemixTextArea(minLines: 3, maxLines: 2),
        throwsAssertionError,
      );
    });

    for (final textDirection in TextDirection.values) {
      testWidgets('top-aligns the empty hint toward ${textDirection.name}', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixTextArea(hintText: 'Write a note'),
          textDirection: textDirection,
        );
        await tester.pump();

        final hint = find.text('Write a note');
        final editable = find.byType(EditableText);
        expect(
          tester.getTopLeft(hint).dy,
          closeTo(tester.getTopLeft(editable).dy, 0.5),
        );
        if (textDirection == TextDirection.ltr) {
          expect(
            tester.getTopLeft(hint).dx,
            closeTo(tester.getTopLeft(editable).dx, 0.5),
          );
        } else {
          expect(
            tester.getTopRight(hint).dx,
            closeTo(tester.getTopRight(editable).dx, 0.5),
          );
        }
      });
    }

    testWidgets('exposes enabled multiline semantics once', (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          const RemixTextArea(
            label: 'Notes',
            hintText: 'Add details',
            helperText: 'Markdown supported',
          ),
        );
        await tester.pump();

        final fields = tester.semantics
            .simulatedAccessibilityTraversal()
            .where(
              (node) => node.getSemanticsData().flagsCollection.isTextField,
            )
            .toList();
        expect(fields, hasLength(1));
        expect(
          fields.single,
          isSemantics(
            label: 'Notes',
            hint: 'Add details\nMarkdown supported',
            isTextField: true,
            isMultiline: true,
            hasEnabledState: true,
            isEnabled: true,
            isReadOnly: false,
            hasTapAction: true,
          ),
        );
      } finally {
        semantics.dispose();
      }
    });

    testWidgets('keeps leading and trailing actions independent', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpRemixApp(
          RemixTextArea(
            semanticLabel: 'Notes',
            leading: IconButton(
              tooltip: 'Insert template',
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
            trailing: IconButton(
              tooltip: 'Clear notes',
              onPressed: () {},
              icon: const Icon(Icons.clear),
            ),
          ),
        );
        await tester.pump();

        final tapNodes = tester.semantics
            .simulatedAccessibilityTraversal()
            .where(
              (node) => node.getSemanticsData().hasAction(SemanticsAction.tap),
            )
            .toList();
        expect(tapNodes, hasLength(3));
        expect(
          tapNodes.where((node) => node.getSemanticsData().label == 'Notes'),
          hasLength(1),
        );
        expect(
          tapNodes.where(
            (node) => node.getSemanticsData().tooltip == 'Insert template',
          ),
          hasLength(1),
        );
        expect(
          tapNodes.where(
            (node) => node.getSemanticsData().tooltip == 'Clear notes',
          ),
          hasLength(1),
        );
      } finally {
        semantics.dispose();
      }
    });

    for (final state in [
      (name: 'read-only', enabled: true, readOnly: true),
      (name: 'disabled', enabled: false, readOnly: false),
    ]) {
      testWidgets('${state.name} keeps multiline field semantics', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixTextArea(
              semanticLabel: 'Notes',
              enabled: state.enabled,
              readOnly: state.readOnly,
            ),
          );
          await tester.pump();

          final fields = tester.semantics
              .simulatedAccessibilityTraversal()
              .where(
                (node) => node.getSemanticsData().flagsCollection.isTextField,
              )
              .toList();
          expect(fields, hasLength(1));
          expect(
            fields.single,
            isSemantics(
              label: 'Notes',
              isTextField: true,
              isMultiline: true,
              hasEnabledState: true,
              isEnabled: state.enabled,
              isReadOnly: true,
              hasTapAction: false,
            ),
          );
        } finally {
          semantics.dispose();
        }
      });
    }
  });
}
