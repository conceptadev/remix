import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_box_effects.dart'
    show RemixBoxAdapter;

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixSlider', () {
    group('Basic Rendering', () {
      testWidgets('renders slider with minimal props', (tester) async {
        await tester.pumpRemixApp(const RemixSlider(value: 0.5));
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider with custom range', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 50.0, min: 0.0, max: 100.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at minimum value', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.0, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at maximum value', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 1.0, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('contains SizedBox widget', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.5, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(SizedBox), findsWidgets);
      });

      testWidgets('contains Stack widget', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.5, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(Stack), findsWidgets);
      });
    });

    group('Value Validation', () {
      test('accepts value at lower boundary (min)', () {
        expect(
          () => RemixSlider(
            value: 0.0,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          returnsNormally,
        );
      });

      test('accepts value at upper boundary (max)', () {
        expect(
          () => RemixSlider(
            value: 1.0,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          returnsNormally,
        );
      });

      test('accepts value in middle range', () {
        expect(
          () => RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          returnsNormally,
        );
      });

      test('throws assertion error when value is less than min', () {
        expect(
          () => RemixSlider(
            value: -0.1,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error when value is greater than max', () {
        expect(
          () => RemixSlider(
            value: 1.1,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error when min is greater than max', () {
        expect(
          () => RemixSlider(
            value: 0.5,
            min: 1.0,
            max: 0.0,
            onChanged: (value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error when min equals max', () {
        expect(
          () => RemixSlider(
            value: 0.0,
            min: 1.0,
            max: 1.0,
            onChanged: (value) {},
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error when snapDivisions is zero', () {
        expect(
          () =>
              RemixSlider(value: 0.5, snapDivisions: 0, onChanged: (value) {}),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error when snapDivisions is negative', () {
        expect(
          () =>
              RemixSlider(value: 0.5, snapDivisions: -2, onChanged: (value) {}),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('Styling', () {
      testWidgets('applies custom style', (tester) async {
        final customStyle = SliderStyler().trackColor(Colors.blue);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies thumb color styling', (tester) async {
        final customStyle = SliderStyler().thumbColor(Colors.red);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies range color styling', (tester) async {
        final customStyle = SliderStyler().rangeColor(Colors.green);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies thumb size styling', (tester) async {
        final customStyle = SliderStyler().thumbSize(const Size(24, 24));

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies thickness styling', (tester) async {
        final customStyle = SliderStyler().thickness(12.0);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies track thickness styling', (tester) async {
        final customStyle = SliderStyler().trackThickness(10.0);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies range thickness styling', (tester) async {
        final customStyle = SliderStyler().rangeThickness(8.0);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Different Values', () {
      testWidgets('renders slider at 0% (empty)', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.0, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at 25%', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.25, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at 50%', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.5, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at 75%', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.75, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('renders slider at 100% (full)', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 1.0, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Interaction', () {
      testWidgets('handles swipe right to increase value', (tester) async {
        double changedValue = 0.5;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) => RemixSlider(
              value: changedValue,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  changedValue = value;
                });
              },
              enabled: true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Drag (swipe right) the slider's thumb
        final sliderFinder = find.byType(RemixSlider);
        // final sliderCenter = tester.getCenter(sliderFinder);

        // Drag a reasonable amount to the right
        await tester.drag(sliderFinder, const Offset(100.0, 0.0));
        await tester.pumpAndSettle();

        // After swiping right, the value should have increased
        expect(changedValue, greaterThan(0.5));
        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('does not react to swipe when disabled', (tester) async {
        double changedValue = 0.5;
        bool onChangeStartCalled = false;
        bool onChangeEndCalled = false;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) => RemixSlider(
              value: changedValue,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  changedValue = value;
                });
              },
              onChangeStart: (value) => onChangeStartCalled = true,
              onChangeEnd: (value) => onChangeEndCalled = true,
              enabled: false,
            ),
          ),
        );
        await tester.pumpAndSettle();

        final sliderFinder = find.byType(RemixSlider);
        // Try to drag (swipe right) the slider's thumb
        await tester.drag(sliderFinder, const Offset(100.0, 0.0));
        await tester.pumpAndSettle();

        // Value should not have changed
        expect(changedValue, equals(0.5));
        expect(onChangeStartCalled, isFalse);
        expect(onChangeEndCalled, isFalse);
        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('does not react to swipe when onChanged is omitted', (
        tester,
      ) async {
        bool onChangeStartCalled = false;
        bool onChangeEndCalled = false;

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChangeStart: (value) => onChangeStartCalled = true,
            onChangeEnd: (value) => onChangeEndCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        final sliderFinder = find.byType(RemixSlider);
        await tester.drag(sliderFinder, const Offset(100.0, 0.0));
        await tester.pumpAndSettle();

        expect(onChangeStartCalled, isFalse);
        expect(onChangeEndCalled, isFalse);
        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles onChangeStart callback', (tester) async {
        bool onChangeStartCalled = false;

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            onChangeStart: (value) => onChangeStartCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        final sliderFinder = find.byType(RemixSlider);
        // Try to drag (swipe right) the slider's thumb
        await tester.drag(sliderFinder, const Offset(100.0, 0.0));
        await tester.pumpAndSettle();

        // Value should not have changed
        expect(onChangeStartCalled, isTrue);
        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles onChangeEnd callback', (tester) async {
        bool onChangeEndCalled = false;

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            onChangeEnd: (value) => onChangeEndCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        final sliderFinder = find.byType(RemixSlider);
        // Try to drag (swipe right) the slider's thumb
        await tester.drag(sliderFinder, const Offset(100.0, 0.0));
        await tester.pumpAndSettle();

        // Value should not have changed
        expect(onChangeEndCalled, isTrue);
        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Focus', () {
      testWidgets('accepts focusNode parameter', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
        focusNode.dispose();
      });

      testWidgets('handles autofocus parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            autofocus: true,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);

        expect(tester.binding.focusManager.primaryFocus, isNotNull);
      });

      testWidgets('can request focus programmatically', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            focusNode: focusNode,
          ),
        );
        await tester.pumpAndSettle();

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
        focusNode.dispose();
      });

      for (final useRawSpec in [false, true]) {
        final source = useRawSpec ? 'raw styleSpec' : 'fluent style';
        testWidgets('thumb focus effect from $source follows highlight mode', (
          tester,
        ) async {
          final previousStrategy = FocusManager.instance.highlightStrategy;
          addTearDown(() {
            FocusManager.instance.highlightStrategy = previousStrategy;
          });
          FocusManager.instance.highlightStrategy =
              FocusHighlightStrategy.alwaysTouch;
          final focusNode = FocusNode();
          addTearDown(focusNode.dispose);
          final style = _sliderFocusStyle();

          await tester.pumpRemixApp(
            Builder(
              builder: (context) => RemixSlider(
                value: 0.5,
                onChanged: (value) {},
                focusNode: focusNode,
                style: style,
                styleSpec: useRawSpec ? style.resolve(context).spec : null,
              ),
            ),
          );
          await tester.pumpAndSettle();

          focusNode.requestFocus();
          await tester.pumpAndSettle();

          expect(focusNode.hasFocus, isTrue);
          expect(_sliderThumb(tester).containerEffects?.outline.width, 0);

          FocusManager.instance.highlightStrategy =
              FocusHighlightStrategy.alwaysTraditional;
          await tester.pump();

          expect(focusNode.hasFocus, isTrue);
          expect(_sliderThumb(tester).containerEffects?.outline.width, 3);

          FocusManager.instance.highlightStrategy =
              FocusHighlightStrategy.alwaysTouch;
          await tester.pump();

          expect(focusNode.hasFocus, isTrue);
          expect(_sliderThumb(tester).containerEffects?.outline.width, 0);
        });
      }

      testWidgets('forced focus state renders the thumb focus effect', (
        tester,
      ) async {
        final previousStrategy = FocusManager.instance.highlightStrategy;
        addTearDown(() {
          FocusManager.instance.highlightStrategy = previousStrategy;
        });
        FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.alwaysTouch;
        final style = _sliderFocusStyle();

        await tester.pumpRemixApp(
          WidgetStateStyleOverride(
            states: const {WidgetState.focused},
            child: RemixSlider(value: 0.5, onChanged: (value) {}, style: style),
          ),
        );
        await tester.pumpAndSettle();

        expect(_sliderThumb(tester).containerEffects?.outline.width, 3);
      });
    });

    group('Snap Divisions', () {
      testWidgets('accepts snapDivisions parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            snapDivisions: 10,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles null snapDivisions', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            snapDivisions: null,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Feedback', () {
      testWidgets('accepts enableFeedback parameter', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            enableFeedback: true,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles disabled feedback', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            enableFeedback: false,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles very small value', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.01, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles very large value', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.99, min: 0.0, max: 1.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles negative range', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: -50.0,
            min: -100.0,
            max: 0.0,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles large range', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(
            value: 500.0,
            min: 0.0,
            max: 1000.0,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles very small range', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 0.005, min: 0.0, max: 0.01, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Key Parameter', () {
      testWidgets('accepts and respects key parameter', (tester) async {
        const key = ValueKey('slider_key');

        await tester.pumpRemixApp(
          RemixSlider(
            key: key,
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('Advanced Styling', () {
      testWidgets('applies multiple style methods', (tester) async {
        final customStyle = SliderStyler()
            .trackColor(Colors.blue)
            .rangeColor(Colors.red)
            .thumbColor(Colors.green)
            .thickness(12.0);

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies thumb styling with decoration', (tester) async {
        final customStyle = SliderStyler().thumb(
          BoxStyler(
            decoration: BoxDecorationMix(
              color: Colors.blue,
              borderRadius: BorderRadiusMix.circular(8.0),
            ),
          ),
        );

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('applies border radius styling', (tester) async {
        final customStyle = SliderStyler().borderRadius(
          BorderRadiusMix.circular(16.0),
        );

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Widget Modifiers', () {
      testWidgets('applies widget modifiers from style', (tester) async {
        final customStyle = SliderStyler().wrap(.clipOval());

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            style: customStyle,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('StyleSpec Parameter', () {
      testWidgets('applies raw styleSpec when provided', (tester) async {
        final spec = SliderSpec(
          thumb: const StyleSpec(
            spec: BoxSpec(decoration: BoxDecoration(color: Colors.red)),
          ),
        );

        await tester.pumpRemixApp(
          RemixSlider(
            value: 0.5,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {},
            styleSpec: spec,
          ),
        );
        await tester.pumpAndSettle();

        final decorations = tester
            .widgetList<Box>(find.byType(Box))
            .map((box) => box.styleSpec?.spec.decoration);

        expect(
          decorations,
          contains(equals(const BoxDecoration(color: Colors.red))),
        );
      });
    });

    group('Value Updates', () {
      testWidgets('renders correctly when value changes', (tester) async {
        double sliderValue = 0.5;

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return RemixSlider(
                value: sliderValue,
                min: 0.0,
                max: 1.0,
                onChanged: (value) => setState(() => sliderValue = value),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });

      testWidgets('handles min and max bounds correctly', (tester) async {
        await tester.pumpRemixApp(
          RemixSlider(value: 25.0, min: 0.0, max: 100.0, onChanged: (value) {}),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixSlider), findsOneWidget);
      });
    });

    group('Direction-aware visuals and interaction', () {
      Widget sizedSlider({
        required double value,
        TextDirection direction = TextDirection.ltr,
        ValueChanged<double>? onChanged,
        bool enabled = true,
        FocusNode? focusNode,
        String? semanticLabel,
        NakedSliderSemanticFormatterCallback? semanticFormatterCallback,
      }) {
        return SizedBox(
          width: 240,
          child: RemixSlider(
            value: value,
            onChanged: onChanged ?? (_) {},
            enabled: enabled,
            focusNode: focusNode,
            semanticLabel: semanticLabel,
            semanticFormatterCallback: semanticFormatterCallback,
            style: SliderStyler(thumb: BoxStyler().size(20, 20)),
          ),
        );
      }

      testWidgets('LTR places the thumb and range from the left', (
        tester,
      ) async {
        await tester.pumpRemixApp(sizedSlider(value: 0.25));
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        expect(thumb.center.dx, lessThan(slider.center.dx));
      });

      testWidgets('RTL places the thumb and range from the right', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          sizedSlider(value: 0.25),
          textDirection: TextDirection.rtl,
        );
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        expect(thumb.center.dx, greaterThan(slider.center.dx));
      });

      // A track thicker than the thumb drives the horizontal inset, so the
      // thumb must travel across the inset track, not the full slider box.
      Widget thickTrackSlider({required double value}) {
        return SizedBox(
          width: 240,
          child: RemixSlider(
            value: value,
            onChanged: (_) {},
            style: SliderStyler(
              thumb: BoxStyler().size(20, 20),
            ).trackThickness(60),
          ),
        );
      }

      testWidgets('thumb centers on the track start at the minimum value', (
        tester,
      ) async {
        await tester.pumpRemixApp(thickTrackSlider(value: 0));
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        // horizontalOverflow = max(thumb 20 / 2, track 60 / 2) = 30.
        expect(thumb.center.dx, moreOrLessEquals(slider.left + 30));
      });

      testWidgets('thumb centers on the track end at the maximum value', (
        tester,
      ) async {
        await tester.pumpRemixApp(thickTrackSlider(value: 1));
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        expect(thumb.center.dx, moreOrLessEquals(slider.right - 30));
      });

      testWidgets('thumb centers on the track midpoint at the middle value', (
        tester,
      ) async {
        await tester.pumpRemixApp(thickTrackSlider(value: 0.5));
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        expect(thumb.center.dx, moreOrLessEquals(slider.center.dx));
      });

      testWidgets('RTL thumb centers on the track end at the minimum value', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          thickTrackSlider(value: 0),
          textDirection: TextDirection.rtl,
        );
        await tester.pumpAndSettle();

        final slider = tester.getRect(find.byType(RemixSlider));
        final thumb = tester.getRect(find.byWidget(_sliderThumb(tester)));
        expect(thumb.center.dx, moreOrLessEquals(slider.right - 30));
      });

      testWidgets('semantic increase and decrease change the value', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          var value = 0.5;
          await tester.pumpRemixApp(
            StatefulBuilder(
              builder: (context, setState) {
                return sizedSlider(
                  value: value,
                  semanticLabel: 'Volume',
                  onChanged: (next) => setState(() => value = next),
                );
              },
            ),
          );
          await tester.pumpAndSettle();

          tester.semantics.increase(find.semantics.byLabel('Volume'));
          await tester.pumpAndSettle();
          expect(value, greaterThan(0.5));

          tester.semantics.decrease(find.semantics.byLabel('Volume'));
          await tester.pumpAndSettle();
          expect(value, lessThan(1.0));
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('keyboard arrows, Home, End, Page Up, and Page Down', (
        tester,
      ) async {
        var value = 0.5;
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        await tester.pumpRemixApp(
          StatefulBuilder(
            builder: (context, setState) {
              return sizedSlider(
                value: value,
                focusNode: focusNode,
                onChanged: (next) => setState(() => value = next),
              );
            },
          ),
        );
        await tester.pumpAndSettle();
        focusNode.requestFocus();
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pump();
        expect(value, greaterThan(0.5));

        await tester.sendKeyEvent(LogicalKeyboardKey.home);
        await tester.pump();
        expect(value, 0);

        await tester.sendKeyEvent(LogicalKeyboardKey.end);
        await tester.pump();
        expect(value, 1);

        await tester.sendKeyEvent(LogicalKeyboardKey.pageDown);
        await tester.pump();
        expect(value, lessThan(1));

        await tester.sendKeyEvent(LogicalKeyboardKey.pageUp);
        await tester.pump();
        expect(value, greaterThan(0));
      });

      testWidgets('disabled slider does not change from keys or semantics', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          var value = 0.5;
          final focusNode = FocusNode();
          addTearDown(focusNode.dispose);
          await tester.pumpRemixApp(
            sizedSlider(
              value: value,
              enabled: false,
              focusNode: focusNode,
              semanticLabel: 'Volume',
              onChanged: (next) => value = next,
            ),
          );
          await tester.pumpAndSettle();
          focusNode.requestFocus();
          await tester.pump();
          await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
          await tester.pump();
          expect(value, 0.5);
        } finally {
          semantics.dispose();
        }
      });

      testWidgets('external focus node receives focus', (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);
        await tester.pumpRemixApp(
          sizedSlider(value: 0.5, focusNode: focusNode),
        );
        await tester.pumpAndSettle();
        focusNode.requestFocus();
        await tester.pump();
        expect(focusNode.hasFocus, isTrue);
      });

      testWidgets('semantic formatter is announced', (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          await tester.pumpRemixApp(
            sizedSlider(
              value: 0.5,
              semanticLabel: 'Volume',
              semanticFormatterCallback: (value) =>
                  '${(value * 100).round()} percent',
            ),
          );
          await tester.pumpAndSettle();

          final node = tester.getSemantics(find.bySemanticsLabel('Volume'));
          expect(node.value, contains('50'));
        } finally {
          semantics.dispose();
        }
      });
    });
  });
}

RemixBoxAdapter _sliderThumb(WidgetTester tester) {
  return tester
      .widgetList<RemixBoxAdapter>(find.byType(RemixBoxAdapter))
      .singleWhere(
        (widget) => widget.styleSpec.spec.constraints?.maxWidth == 20,
      );
}

SliderStyler _sliderFocusStyle() {
  return SliderStyler(
    thumb: BoxStyler().size(20, 20),
    thumbFocusEffects: RemixBoxEffectsMix.outline(
      BorderSideMix(
        color: Colors.red,
        width: 3,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
  );
}
