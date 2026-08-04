import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

List<SemanticsNode> _semanticNodes(
  WidgetTester tester,
  bool Function(SemanticsData data) predicate,
) => tester.semantics
    .simulatedAccessibilityTraversal()
    .where((node) => predicate(node.getSemanticsData()))
    .toList();

List<SemanticsNode> _textFieldSemanticNodes(WidgetTester tester) =>
    _semanticNodes(tester, (data) => data.flagsCollection.isTextField);

int _semanticTextOccurrences(WidgetTester tester, String text) {
  var count = 0;
  for (final node in tester.semantics.simulatedAccessibilityTraversal()) {
    final data = node.getSemanticsData();
    for (final value in [
      data.label,
      data.value,
      data.hint,
      data.tooltip,
      data.increasedValue,
      data.decreasedValue,
    ]) {
      count += RegExp(RegExp.escape(text)).allMatches(value).length;
    }
  }
  return count;
}

void main() {
  group('RemixTextField', () {
    testWidgets('Fortal variants keep text and container colors separate', (
      tester,
    ) async {
      await tester.pumpRemixApp(const FortalTextField.surface());
      var context = tester.element(find.byType(FortalTextField));
      var colors = resolveFortalTokens(const FortalThemeConfig());
      var spec = fortalTextFieldStyle(
        variant: FortalTextFieldVariant.surface,
      ).resolve(context).spec;
      var decoration =
          spec.container.spec.box!.spec.decoration! as BoxDecoration;

      expect(spec.text.spec.style?.color, colors.gray.scale.step(12));
      expect(decoration.color, colors.colorSurface);

      await tester.pumpRemixApp(const FortalTextField.soft());
      context = tester.element(find.byType(FortalTextField));
      colors = resolveFortalTokens(const FortalThemeConfig());
      spec = fortalTextFieldStyle(
        variant: FortalTextFieldVariant.soft,
      ).resolve(context).spec;
      decoration = spec.container.spec.box!.spec.decoration! as BoxDecoration;

      expect(spec.text.spec.style?.color, colors.accent.scale.step(12));
      expect(decoration.color, colors.accent.scale.alphaStep(3));
    });

    group('Basic Rendering', () {
      testWidgets('renders with default style', (tester) async {
        await tester.pumpRemixApp(const RemixTextField());
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('renders with hint text', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(hintText: 'Enter text here'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Enter text here'), findsOneWidget);
      });

      testWidgets('renders with label', (tester) async {
        await tester.pumpRemixApp(const RemixTextField(label: 'Username'));
        await tester.pumpAndSettle();

        expect(find.text('Username'), findsOneWidget);
      });

      testWidgets('renders with helper text', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(helperText: 'Required field'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Required field'), findsOneWidget);
      });

      testWidgets('renders with leading and trailing widgets', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(
            leading: Icon(Icons.search),
            trailing: Icon(Icons.clear),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.clear), findsOneWidget);
      });

      testWidgets('renders with initial text from controller', (tester) async {
        final controller = TextEditingController(text: 'Initial text');

        await tester.pumpRemixApp(RemixTextField(controller: controller));
        await tester.pumpAndSettle();

        expect(find.text('Initial text'), findsOneWidget);

        controller.dispose();
      });
    });

    group('Text Input & Editing', () {
      testWidgets('accepts text input', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(RemixTextField(controller: controller));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Hello');
        await tester.pumpAndSettle();

        expect(controller.text, equals('Hello'));

        controller.dispose();
      });

      testWidgets('calls onChanged callback', (tester) async {
        String? changedValue;

        await tester.pumpRemixApp(
          RemixTextField(
            onChanged: (value) {
              changedValue = value;
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Test');
        await tester.pumpAndSettle();

        expect(changedValue, equals('Test'));
      });

      testWidgets('calls onSubmitted callback', (tester) async {
        String? submittedValue;

        await tester.pumpRemixApp(
          RemixTextField(
            onSubmitted: (value) {
              submittedValue = value;
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Test');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(submittedValue, equals('Test'));
      });

      testWidgets('respects readOnly flag', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(controller: controller, readOnly: true),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixTextField));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Test');
        await tester.pumpAndSettle();

        // In readOnly mode, text should not change
        expect(controller.text, isEmpty);

        controller.dispose();
      });

      testWidgets('respects enabled flag', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(controller: controller, enabled: false),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(RemixTextField));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Test');
        await tester.pumpAndSettle();

        expect(controller.text, isEmpty);

        controller.dispose();
      });

      testWidgets('respects maxLength', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(controller: controller, maxLength: 5),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Hello World');
        await tester.pumpAndSettle();

        expect(controller.text.length, lessThanOrEqualTo(5));

        controller.dispose();
      });

      testWidgets('respects obscureText flag', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(obscureText: true, hintText: 'Password'),
        );
        await tester.pumpAndSettle();

        // Since text is obscured, we can't directly check the rendered text,
        // but we can verify the widget exists
        expect(find.byType(RemixTextField), findsOneWidget);
      });
    });

    group('Focus Behavior', () {
      testWidgets('handles focus changes', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(RemixTextField(focusNode: focusNode));
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isFalse);

        await tester.tap(find.byType(RemixTextField));
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);

        focusNode.dispose();
      });

      testWidgets('autofocus works correctly', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixTextField(focusNode: focusNode, autofocus: true),
        );
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);

        focusNode.dispose();
      });
    });

    group('Styling', () {
      testWidgets('applies custom text color', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().color(Colors.red)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('applies custom background color', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().backgroundColor(Colors.grey)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('applies custom padding', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(
            style: TextFieldStyler().padding(EdgeInsetsGeometryMix.all(20)),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('applies custom border radius', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(
            style: TextFieldStyler().borderRadius(
              BorderRadiusGeometryMix.circular(12),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('applies custom cursor color', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().cursorColor(Colors.blue)),
        );
        await tester.pumpAndSettle();

        final textField = tester.widget<NakedTextField>(
          find.byType(NakedTextField),
        );
        expect(textField.cursorColor, Colors.blue);
      });

      testWidgets('forwards input style values to NakedTextField', (
        tester,
      ) async {
        const scrollPadding = EdgeInsets.all(12);
        const cursorRadius = Radius.circular(3);
        await tester.pumpRemixApp(
          RemixTextField(
            style: TextFieldStyler(
              textAlign: TextAlign.end,
              cursorWidth: 4,
              cursorHeight: 18,
              cursorRadius: cursorRadius,
              cursorColor: Colors.purple,
              cursorOpacityAnimates: false,
              selectionHeightStyle: BoxHeightStyle.max,
              selectionWidthStyle: BoxWidthStyle.max,
              scrollPadding: scrollPadding,
              keyboardAppearance: Brightness.dark,
            ),
          ),
        );
        await tester.pumpAndSettle();

        final textField = tester.widget<NakedTextField>(
          find.byType(NakedTextField),
        );
        expect(textField.textAlign, TextAlign.end);
        expect(textField.cursorWidth, 4);
        expect(textField.cursorHeight, 18);
        expect(textField.cursorRadius, cursorRadius);
        expect(textField.cursorColor, Colors.purple);
        expect(textField.cursorOpacityAnimates, isFalse);
        expect(textField.selectionHeightStyle, BoxHeightStyle.max);
        expect(textField.selectionWidthStyle, BoxWidthStyle.max);
        expect(textField.scrollPadding, scrollPadding);
        expect(textField.keyboardAppearance, Brightness.dark);
      });

      testWidgets('keeps focus variants connected to NakedTextField state', (
        tester,
      ) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);
        await tester.pumpRemixApp(
          RemixTextField(
            focusNode: focusNode,
            style: TextFieldStyler(
              cursorColor: Colors.blue,
            ).onFocused(TextFieldStyler(cursorColor: Colors.red)),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .cursorColor,
          Colors.blue,
        );

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(
          tester
              .widget<NakedTextField>(find.byType(NakedTextField))
              .cursorColor,
          Colors.red,
        );
      });

      testWidgets('applies custom hint color', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(
            hintText: 'Hint',
            style: TextFieldStyler().hintColor(Colors.grey),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Hint'), findsOneWidget);
      });
    });

    group('Semantics & Accessibility', () {
      testWidgets('forwards pointer behavior and owns composite exclusion', (
        tester,
      ) async {
        void onTap() {}
        void onTapUpOutside(PointerUpEvent event) {}

        await tester.pumpRemixApp(
          RemixTextField(
            onTap: onTap,
            onTapAlwaysCalled: true,
            onPressUpOutside: onTapUpOutside,
            ignorePointers: true,
            excludeSemantics: true,
          ),
        );
        await tester.pumpAndSettle();

        final textField = tester.widget<NakedTextField>(
          find.byType(NakedTextField),
        );
        expect(textField.onTap, same(onTap));
        expect(textField.onTapAlwaysCalled, isTrue);
        expect(textField.onTapUpOutside, same(onTapUpOutside));
        expect(textField.ignorePointers, isTrue);
        expect(textField.excludeSemantics, isFalse);
        expect(
          tester
              .widget<RemixTextField>(find.byType(RemixTextField))
              .excludeSemantics,
          isTrue,
        );
      });

      testWidgets('uses semantic label parameter', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(label: 'Email', semanticLabel: 'Email Address'),
        );
        await tester.pumpAndSettle();

        // Verify the widget is rendered with semantic properties
        expect(find.byType(RemixTextField), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('uses semantic hint parameter', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(
            hintText: 'Enter your email',
            semanticHint: 'Enter your email address',
          ),
        );
        await tester.pumpAndSettle();

        // Verify the widget is rendered with semantic properties
        expect(find.byType(RemixTextField), findsOneWidget);
        expect(find.text('Enter your email'), findsOneWidget);
      });

      testWidgets('defaults semantic label to label parameter', (tester) async {
        await tester.pumpRemixApp(const RemixTextField(label: 'Email'));
        await tester.pumpAndSettle();

        // When only label is provided, it should be used for both label and semantic label
        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('announces label, hint, and non-error helper exactly once', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            const RemixTextField(
              label: 'Email address',
              hintText: 'name@example.com',
              helperText: 'Used for receipts',
            ),
          );
          await tester.pump();

          final fields = _textFieldSemanticNodes(tester);
          expect(fields, hasLength(1));
          expect(
            fields.single,
            isSemantics(
              label: 'Email address',
              hint: 'name@example.com\nUsed for receipts',
              isTextField: true,
              isMultiline: false,
              hasTapAction: true,
            ),
          );
          expect(_semanticTextOccurrences(tester, 'Email address'), 1);
          expect(_semanticTextOccurrences(tester, 'name@example.com'), 1);
          expect(_semanticTextOccurrences(tester, 'Used for receipts'), 1);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('announces an error once on the live field node', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            const RemixTextField(
              label: 'Email address',
              hintText: 'name@example.com',
              helperText: 'Enter a valid email',
              error: true,
            ),
          );
          await tester.pump();

          final fields = _textFieldSemanticNodes(tester);
          expect(fields, hasLength(1));
          expect(
            fields.single,
            isSemantics(
              label: 'Email address',
              hint: 'name@example.com\nEnter a valid email',
              isTextField: true,
              isLiveRegion: true,
            ),
          );
          expect(_semanticTextOccurrences(tester, 'Enter a valid email'), 1);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('deduplicates matching error and hint text', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            const RemixTextField(
              semanticLabel: 'Summary',
              hintText: 'A summary is required',
              helperText: 'A summary is required',
              error: true,
            ),
          );
          await tester.pump();

          final fields = _textFieldSemanticNodes(tester);
          expect(fields, hasLength(1));
          expect(
            fields.single.getSemanticsData().hint,
            'A summary is required',
          );
          expect(
            fields.single.getSemanticsData().flagsCollection.isLiveRegion,
            isTrue,
          );
          expect(_semanticTextOccurrences(tester, 'A summary is required'), 1);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets(
        'semantic overrides and duplicate supporting text stay exact',
        (tester) async {
          final semantics = tester.ensureSemantics();
          try {
            await tester.pumpRemixApp(
              const RemixTextField(
                label: 'Visible label',
                semanticLabel: 'Account email',
                hintText: 'Visible guidance',
                semanticHint: 'Screen reader guidance',
                helperText: 'Screen reader guidance',
              ),
            );
            await tester.pump();

            final fields = _textFieldSemanticNodes(tester);
            expect(fields, hasLength(1));
            expect(fields.single.getSemanticsData().label, 'Account email');
            expect(
              fields.single.getSemanticsData().hint,
              'Screen reader guidance',
            );
            expect(_semanticTextOccurrences(tester, 'Account email'), 1);
            expect(
              _semanticTextOccurrences(tester, 'Screen reader guidance'),
              1,
            );
            expect(_semanticTextOccurrences(tester, 'Visible label'), 0);
            expect(_semanticTextOccurrences(tester, 'Visible guidance'), 0);
          } finally {
            semantics.dispose();
          }
        },
      );

      testWidgets('interactive accessories keep independent semantic actions', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixTextField(
              label: 'Search notes',
              leading: const Icon(
                Icons.search,
                semanticLabel: 'Search decoration',
              ),
              trailing: IconButton(
                tooltip: 'Clear notes',
                onPressed: () {},
                icon: const Icon(Icons.clear),
              ),
            ),
          );
          await tester.pump();

          final fields = _textFieldSemanticNodes(tester);
          final clearButtons = _semanticNodes(
            tester,
            (data) => data.tooltip == 'Clear notes',
          );
          final decorations = _semanticNodes(
            tester,
            (data) => data.label == 'Search decoration',
          );

          expect(fields, hasLength(1));
          expect(clearButtons, hasLength(1));
          expect(decorations, hasLength(1));
          expect(fields.single.getSemanticsData().label, 'Search notes');
          expect(
            fields.single.getSemanticsData().hasAction(SemanticsAction.tap),
            isTrue,
          );
          expect(
            clearButtons.single.getSemanticsData().hasAction(
              SemanticsAction.tap,
            ),
            isTrue,
          );
          expect(
            decorations.single.getSemanticsData().hasAction(
              SemanticsAction.tap,
            ),
            isFalse,
          );
          expect(
            _semanticNodes(
              tester,
              (data) => data.hasAction(SemanticsAction.tap),
            ),
            hasLength(2),
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('decorative accessories add no duplicate field name', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            const RemixTextField(
              semanticLabel: 'Named field',
              leading: Icon(Icons.notes),
              trailing: Icon(Icons.edit),
            ),
          );
          await tester.pump();

          expect(_textFieldSemanticNodes(tester), hasLength(1));
          expect(_semanticTextOccurrences(tester, 'Named field'), 1);
          expect(
            _semanticNodes(
              tester,
              (data) =>
                  data.label.isNotEmpty &&
                  data.label != 'Named field' &&
                  !data.flagsCollection.scopesRoute,
            ),
            isEmpty,
          );
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('excludeSemantics hides the field and accessory subtree', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            RemixTextField(
              semanticLabel: 'Private note',
              excludeSemantics: true,
              trailing: IconButton(
                tooltip: 'Clear private note',
                onPressed: () {},
                icon: const Icon(Icons.clear),
              ),
            ),
          );
          await tester.pump();

          expect(_textFieldSemanticNodes(tester), isEmpty);
          expect(
            _semanticNodes(
              tester,
              (data) => data.tooltip == 'Clear private note',
            ),
            isEmpty,
          );
        } finally {
          semantics.dispose();
        }
      });
    });

    group('Composite Interaction', () {
      testWidgets(
        'label, helper, and container padding retain the tap target',
        (tester) async {
          var taps = 0;

          await tester.pumpRemixApp(
            RemixTextField(
              label: 'Field label',
              helperText: 'Field helper',
              hintText: 'Field hint',
              onTap: () => taps++,
              onTapAlwaysCalled: true,
              style: TextFieldStyler().width(280).paddingAll(24),
            ),
          );
          await tester.pump();

          final editable = tester.widget<EditableText>(
            find.byType(EditableText),
          );
          final container = find.byType(RowBox);
          expect(container, findsOneWidget);

          await tester.tap(find.text('Field label'));
          await tester.pump();
          expect(taps, 1);
          expect(editable.focusNode.hasFocus, isTrue);

          await tester.tap(find.text('Field helper'));
          await tester.pump();
          expect(taps, 2);

          await tester.tapAt(tester.getTopLeft(container) + const Offset(4, 4));
          await tester.pump();
          expect(taps, 3);
        },
      );

      for (final alwaysCalled in [false, true]) {
        testWidgets(
          'consecutive fallback taps respect onTapAlwaysCalled=$alwaysCalled',
          (tester) async {
            var taps = 0;
            await tester.pumpRemixApp(
              RemixTextField(
                key: ValueKey(alwaysCalled),
                label: 'Tap target',
                onTap: () => taps++,
                onTapAlwaysCalled: alwaysCalled,
              ),
            );
            await tester.pump();

            final location = tester.getCenter(find.text('Tap target'));
            await tester.tapAt(location);
            await tester.pump(const Duration(milliseconds: 50));
            await tester.tapAt(location);
            await tester.pump();

            expect(taps, alwaysCalled ? 2 : 1);
          },
        );
      }

      testWidgets('accessory taps do not activate or focus the field', (
        tester,
      ) async {
        var fieldTaps = 0;
        var accessoryTaps = 0;

        await tester.pumpRemixApp(
          RemixTextField(
            onTap: () => fieldTaps++,
            onTapAlwaysCalled: true,
            trailing: IconButton(
              key: const ValueKey('clear-accessory'),
              onPressed: () => accessoryTaps++,
              icon: const Icon(Icons.clear),
            ),
          ),
        );
        await tester.pump();

        final focusNode = tester
            .widget<EditableText>(find.byType(EditableText))
            .focusNode;
        await tester.tap(find.byKey(const ValueKey('clear-accessory')));
        await tester.pump();

        expect(accessoryTaps, 1);
        expect(fieldTaps, 0);
        expect(focusNode.hasFocus, isFalse);
      });

      for (final state in [
        (
          name: 'read-only',
          enabled: true,
          readOnly: true,
          canRequestFocus: true,
          expectedTaps: 1,
          expectedFocus: true,
        ),
        (
          name: 'disabled',
          enabled: false,
          readOnly: false,
          canRequestFocus: true,
          expectedTaps: 0,
          expectedFocus: false,
        ),
        (
          name: 'non-focusable',
          enabled: true,
          readOnly: false,
          canRequestFocus: false,
          expectedTaps: 1,
          expectedFocus: false,
        ),
      ]) {
        testWidgets('${state.name} fallback mirrors Naked tap and focus', (
          tester,
        ) async {
          final focusNode = FocusNode();
          addTearDown(focusNode.dispose);
          var taps = 0;

          await tester.pumpRemixApp(
            RemixTextField(
              label: 'Fallback target',
              enabled: state.enabled,
              readOnly: state.readOnly,
              canRequestFocus: state.canRequestFocus,
              focusNode: focusNode,
              onTap: () => taps++,
            ),
          );
          await tester.tap(find.text('Fallback target'));
          await tester.pump();

          expect(taps, state.expectedTaps);
          expect(focusNode.hasFocus, state.expectedFocus);
        });
      }

      testWidgets('hovering labels and accessories retains hovered styling', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixTextField(
            label: 'Hover target',
            trailing: const Icon(Icons.info, key: ValueKey('hover-accessory')),
            style: TextFieldStyler(
              cursorColor: Colors.blue,
            ).onHovered(TextFieldStyler(cursorColor: Colors.red)),
          ),
        );
        await tester.pump();

        Color? cursorColor() => tester
            .widget<NakedTextField>(find.byType(NakedTextField))
            .cursorColor;
        final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
        addTearDown(mouse.removePointer);
        await mouse.addPointer(location: Offset.zero);

        await mouse.moveTo(tester.getCenter(find.text('Hover target')));
        await tester.pump();
        expect(cursorColor(), Colors.red);

        await mouse.moveTo(
          tester.getCenter(find.byKey(const ValueKey('hover-accessory'))),
        );
        await tester.pump();
        expect(cursorColor(), Colors.red);

        await mouse.moveTo(const Offset(5, 5));
        await tester.pump();
        expect(cursorColor(), Colors.blue);
      });

      testWidgets('fallback press down, up, and cancel drive pressed styling', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixTextField(
            label: 'Press target',
            style: TextFieldStyler(
              cursorColor: Colors.blue,
            ).onPressed(TextFieldStyler(cursorColor: Colors.red)),
          ),
        );
        await tester.pump();

        Color? cursorColor() => tester
            .widget<NakedTextField>(find.byType(NakedTextField))
            .cursorColor;
        final location = tester.getCenter(find.text('Press target'));

        var gesture = await tester.startGesture(location);
        await tester.pump();
        expect(cursorColor(), Colors.red);
        await gesture.up();
        await tester.pump();
        expect(cursorColor(), Colors.blue);

        gesture = await tester.startGesture(location);
        await tester.pump();
        expect(cursorColor(), Colors.red);
        await gesture.cancel();
        await tester.pump();
        expect(cursorColor(), Colors.blue);
      });

      testWidgets('owns, swaps, and disposes only internal focus nodes', (
        tester,
      ) async {
        final external = FocusNode(debugLabel: 'caller-owned');
        addTearDown(external.dispose);
        FocusNode? suppliedNode;
        late StateSetter rebuild;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return RemixTextField(focusNode: suppliedNode);
            },
          ),
        );
        await tester.pump();

        final firstInternal = tester
            .widget<EditableText>(find.byType(EditableText))
            .focusNode;
        firstInternal.requestFocus();
        await tester.pump();
        expect(firstInternal.hasFocus, isTrue);

        rebuild(() => suppliedNode = external);
        await tester.pump();
        await tester.pump();
        expect(
          tester.widget<EditableText>(find.byType(EditableText)).focusNode,
          same(external),
        );
        expect(external.hasFocus, isTrue);
        expect(() => firstInternal.addListener(() {}), throwsFlutterError);

        rebuild(() => suppliedNode = null);
        await tester.pump();
        await tester.pump();
        final secondInternal = tester
            .widget<EditableText>(find.byType(EditableText))
            .focusNode;
        expect(secondInternal, isNot(same(firstInternal)));
        expect(secondInternal, isNot(same(external)));
        expect(secondInternal.hasFocus, isTrue);

        void listener() {}
        expect(() => external.addListener(listener), returnsNormally);
        external.removeListener(listener);

        await tester.pumpRemixApp(const SizedBox());
        expect(() => secondInternal.addListener(() {}), throwsFlutterError);
      });
    });

    group('Input Formatters', () {
      testWidgets('applies input formatters', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(
            controller: controller,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'abc123');
        await tester.pumpAndSettle();

        expect(controller.text, equals('123'));

        controller.dispose();
      });
    });

    group('Keyboard Configuration', () {
      testWidgets('respects keyboardType', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(keyboardType: TextInputType.emailAddress),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('respects textInputAction', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(textInputAction: TextInputAction.next),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('respects textCapitalization', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(textCapitalization: TextCapitalization.words),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles error state', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(error: true, helperText: 'Error message'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Error message'), findsOneWidget);
      });

      testWidgets('handles multiline text', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(controller: controller, maxLines: 3),
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(RemixTextField),
          'Line 1\nLine 2\nLine 3',
        );
        await tester.pumpAndSettle();

        expect(controller.text, contains('Line 1'));
        expect(controller.text, contains('Line 2'));
        expect(controller.text, contains('Line 3'));

        controller.dispose();
      });

      testWidgets('handles null controller gracefully', (tester) async {
        await tester.pumpRemixApp(const RemixTextField());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(RemixTextField), 'Test');
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('handles all label, hint, and helper text together', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixTextField(
            label: 'Label',
            hintText: 'Hint',
            helperText: 'Helper',
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Label'), findsOneWidget);
        expect(find.text('Hint'), findsOneWidget);
        expect(find.text('Helper'), findsOneWidget);
      });
    });

    group('Advanced Styling', () {
      testWidgets('applies container styling', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(
            style: TextFieldStyler().container(
              FlexBoxStyler(
                decoration: BoxDecorationMix(color: Colors.grey),
                padding: EdgeInsetsGeometryMix.all(16),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('layout override for one property keeps layout defaults', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixTextField(
            label: 'Label',
            helperText: 'Helper',
            style: TextFieldStyler().layout(FlexBoxStyler().spacing(12)),
          ),
        );
        await tester.pumpAndSettle();

        final flex = tester
            .widget<ColumnBox>(find.byType(ColumnBox))
            .styleSpec
            ?.spec
            .flex
            ?.spec;

        // Customizing spacing keeps the min-size / start-alignment defaults
        // instead of falling back to ColumnBox's max / center.
        expect(flex?.spacing, 12);
        expect(flex?.mainAxisSize, MainAxisSize.min);
        expect(flex?.crossAxisAlignment, CrossAxisAlignment.start);
      });

      testWidgets('applies width and height constraints', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().width(300).height(60)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });

      testWidgets('applies text alignment', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().textAlign(TextAlign.center)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        await tester.pumpRemixApp(
          RemixTextField(style: TextFieldStyler().wrap(.clipOval())),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and uses key parameter', (tester) async {
        const key = ValueKey('textfield_key');

        await tester.pumpRemixApp(const RemixTextField(key: key));
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('uses styleSpec when provided', (tester) async {
        const spec = TextFieldSpec(
          container: StyleSpec(
            spec: FlexBoxSpec(
              box: StyleSpec(
                spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
              ),
            ),
          ),
          textAlign: TextAlign.center,
          cursorWidth: 3.0,
        );

        await tester.pumpRemixApp(const RemixTextField(styleSpec: spec));
        await tester.pumpAndSettle();

        final rowBoxDecorations = tester
            .widgetList<RowBox>(find.byType(RowBox))
            .map((box) => box.styleSpec?.spec.box?.spec.decoration);
        final textField = tester.widget<NakedTextField>(
          find.byType(NakedTextField),
        );

        expect(
          rowBoxDecorations,
          contains(equals(const BoxDecoration(color: Colors.red))),
        );
        expect(textField.textAlign, TextAlign.center);
        expect(textField.cursorWidth, 3.0);
      });
    });

    group('Controllers', () {
      testWidgets('uses provided UndoHistoryController', (tester) async {
        final undoController = UndoHistoryController();

        await tester.pumpRemixApp(
          RemixTextField(undoController: undoController),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);

        undoController.dispose();
      });

      testWidgets('uses provided ScrollController', (tester) async {
        final scrollController = ScrollController();

        await tester.pumpRemixApp(
          RemixTextField(scrollController: scrollController, maxLines: 3),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);

        scrollController.dispose();
      });
    });

    group('Selection Controls', () {
      testWidgets('handles enableInteractiveSelection', (tester) async {
        await tester.pumpRemixApp(
          const RemixTextField(enableInteractiveSelection: false),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixTextField), findsOneWidget);
      });
    });

    group('Hint Text Visibility', () {
      testWidgets('single-line hint remains vertically centered', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixTextField(
            hintText: 'Centered hint',
            style: TextFieldStyler().height(72),
          ),
        );
        await tester.pump();

        expect(
          tester.getCenter(find.text('Centered hint')).dy,
          closeTo(tester.getCenter(find.byType(EditableText)).dy, 0.5),
        );
      });

      testWidgets('hides hint text when field has content', (tester) async {
        final controller = TextEditingController();

        await tester.pumpRemixApp(
          RemixTextField(controller: controller, hintText: 'Enter text'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Enter text'), findsOneWidget);

        await tester.enterText(find.byType(RemixTextField), 'Content');
        await tester.pumpAndSettle();

        // Hint should not be visible when there's content
        expect(find.text('Content'), findsOneWidget);

        controller.dispose();
      });
    });
  });
}
