import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

const _sliderKey = ValueKey('slider');

void main() {
  group('RemixSlider contract', () {
    test('defaults match the Radix-shaped arbitrary-thumb contract', () {
      final slider = RemixSlider(values: const [25]);

      expect(slider.min, 0);
      expect(slider.max, 100);
      expect(slider.step, 1);
      expect(slider.minSpacing, 0);
      expect(slider.orientation, Axis.horizontal);
      expect(slider.inverted, isFalse);
      expect(slider.enabled, isTrue);
      expect(slider.excludeSemantics, isFalse);
    });

    test('rejects invalid scalar configuration', () {
      expect(() => RemixSlider(values: const []), returnsNormally);
      expect(
        () => RemixSlider(values: const [50], min: 100, max: 0),
        throwsAssertionError,
      );
      expect(
        () => RemixSlider(values: const [50], step: 0),
        throwsAssertionError,
      );
      expect(
        () => RemixSlider(values: const [50], minSpacing: -1),
        throwsAssertionError,
      );
    });

    testWidgets('delegates value and per-thumb list validation', (
      tester,
    ) async {
      await tester.pumpWidget(_harness(values: const [], onChanged: (_) {}));
      expect(tester.takeException(), isA<AssertionError>());

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        _harness(values: const [60, 40], onChanged: (_) {}),
      );
      expect(tester.takeException(), isA<AssertionError>());

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          focusNodes: const [null],
          onChanged: (_) {},
        ),
      );
      expect(tester.takeException(), isA<AssertionError>());
    });
  });

  group('RemixSlider visual composition', () {
    testWidgets('width-only layout keeps the full interaction target', (
      tester,
    ) async {
      final changes = <List<double>>[];
      await tester.pumpWidget(
        FortalScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      child: RemixSlider(
                        key: _sliderKey,
                        values: const [0],
                        onChanged: changes.add,
                        style: RemixSliderStyler()
                            .thickness(2)
                            .thumbSize(const Size(24, 24)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final sliderRect = tester.getRect(find.byKey(_sliderKey));
      expect(sliderRect.height, 48);

      await tester.tapAt(
        Offset(sliderRect.center.dx, sliderRect.center.dy + 20),
      );
      await tester.pump();
      expect(changes.last, [50]);
    });

    testWidgets('renders one visual thumb per value and spans first to last', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(values: const [20, 50, 80], onChanged: (_) {}),
      );

      final sliderRect = tester.getRect(find.byKey(_sliderKey));
      final trackRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-track')),
      );
      final rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      final centers = [
        for (var index = 0; index < 3; index++)
          tester.getCenter(find.byKey(ValueKey('remix-slider-thumb-$index'))),
      ];

      expect(sliderRect.size, const Size(200, 48));
      expect(trackRect.size, const Size(200, 8));
      expect(centers.map((point) => point.dx), [
        sliderRect.left + 40,
        sliderRect.left + 100,
        sliderRect.left + 160,
      ]);
      expect(rangeRect.left, sliderRect.left + 40);
      expect(rangeRect.width, 120);
    });

    testWidgets('a single thumb fills from the logical minimum', (
      tester,
    ) async {
      await tester.pumpWidget(_harness(values: const [25], onChanged: (_) {}));

      final sliderRect = tester.getRect(find.byKey(_sliderKey));
      final rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      final thumb = tester.getCenter(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
      );

      expect(thumb.dx, sliderRect.left + 50);
      expect(rangeRect.left, sliderRect.left);
      expect(rangeRect.right, thumb.dx);
    });

    testWidgets('RTL and inversion map both the thumb and filled origin', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(
          values: const [25],
          textDirection: TextDirection.rtl,
          onChanged: (_) {},
        ),
      );

      var sliderRect = tester.getRect(find.byKey(_sliderKey));
      var rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      var thumb = tester.getCenter(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
      );
      expect(thumb.dx, sliderRect.left + 150);
      expect(rangeRect.left, thumb.dx);
      expect(rangeRect.right, sliderRect.right);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        _harness(values: const [25], inverted: true, onChanged: (_) {}),
      );
      sliderRect = tester.getRect(find.byKey(_sliderKey));
      rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      thumb = tester.getCenter(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
      );
      expect(thumb.dx, sliderRect.left + 150);
      expect(rangeRect.left, thumb.dx);
      expect(rangeRect.right, sliderRect.right);
    });

    testWidgets('vertical orientation grows bottom-up unless inverted', (
      tester,
    ) async {
      await tester.pumpWidget(
        _harness(
          values: const [25],
          orientation: Axis.vertical,
          size: const Size(48, 200),
          onChanged: (_) {},
        ),
      );

      var sliderRect = tester.getRect(find.byKey(_sliderKey));
      var trackRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-track')),
      );
      var rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      var thumb = tester.getCenter(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
      );
      expect(sliderRect.size, const Size(48, 200));
      expect(trackRect.size, const Size(8, 200));
      expect(thumb.dy, sliderRect.top + 150);
      expect(rangeRect.top, thumb.dy);
      expect(rangeRect.bottom, sliderRect.bottom);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        _harness(
          values: const [25],
          orientation: Axis.vertical,
          inverted: true,
          size: const Size(48, 200),
          onChanged: (_) {},
        ),
      );
      sliderRect = tester.getRect(find.byKey(_sliderKey));
      trackRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-track')),
      );
      rangeRect = tester.getRect(
        find.byKey(const ValueKey('remix-slider-range')),
      );
      thumb = tester.getCenter(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
      );
      expect(thumb.dy, sliderRect.top + 50);
      expect(trackRect.size, const Size(8, 200));
      expect(rangeRect.top, sliderRect.top);
      expect(rangeRect.bottom, thumb.dy);
    });

    testWidgets('wires every resolved surface slot and blend mode', (
      tester,
    ) async {
      const track = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.grey)],
      );
      const trackOverlay = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.black12)],
      );
      const range = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.blue)],
      );
      const rangeOverlay = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.blueGrey)],
      );
      const thumb = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.white)],
      );
      const thumbOverlay = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.black26)],
      );
      await tester.pumpWidget(
        _harness(
          values: const [25, 75],
          onChanged: (_) {},
          styleSpec: RemixSliderSpec(
            track: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            range: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            thumb: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            trackEffects: RemixBoxEffectsSpec(
              behindContent: track,
              overContent: trackOverlay,
            ),
            rangeEffects: RemixBoxEffectsSpec(
              behindContent: range,
              overContent: rangeOverlay,
            ),
            thumbEffects: RemixBoxEffectsSpec(
              behindContent: thumb,
              overContent: thumbOverlay,
            ),
            blendMode: BlendMode.multiply,
          ),
        ),
      );

      expect(find.byKey(const ValueKey('remix-slider-track')), findsOneWidget);
      expect(find.byKey(const ValueKey('remix-slider-range')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('remix-slider-thumb-0')),
        findsOneWidget,
      );
      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.byType(RemixBlendMode), findsOneWidget);
      expect(
        tester.widget<RemixBlendMode>(find.byType(RemixBlendMode)).blendMode,
        BlendMode.multiply,
      );
    });

    testWidgets('paints the focus overlay only around the focused thumb', (
      tester,
    ) async {
      const focusOverlay = RemixBoxEffectLayerSpec(
        shadows: [RemixBoxShadow(color: Colors.purple)],
      );
      final first = FocusNode();
      final second = FocusNode();
      addTearDown(first.dispose);
      addTearDown(second.dispose);
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          focusNodes: [first, second],
          styleSpec: RemixSliderSpec(
            thumb: const StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
            thumbFocusEffects: RemixBoxEffectsSpec(overContent: focusOverlay),
          ),
          onChanged: (_) {},
        ),
      );

      final idlePaintCount = find.byType(CustomPaint).evaluate().length;

      second.requestFocus();
      await tester.pump();
      expect(
        find.byType(CustomPaint).evaluate().length,
        greaterThan(idlePaintCount),
      );
    });
  });

  group('RemixSlider controlled behavior', () {
    testWidgets('tap changes the nearest thumb and supports three thumbs', (
      tester,
    ) async {
      final changes = <List<double>>[];
      await tester.pumpWidget(
        _harness(values: const [10, 50, 90], onChanged: changes.add),
      );

      await tester.tapAt(_pointAt(tester, 0.6));
      await tester.pump();
      expect(changes.last, [10, 60, 90]);

      await tester.tapAt(_pointAt(tester, 0.95));
      await tester.pump();
      expect(changes.last, [10, 60, 95]);
    });

    testWidgets('pointer input snaps and cannot cross minimum spacing', (
      tester,
    ) async {
      final changes = <List<double>>[];
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          step: 10,
          minSpacing: 10,
          onChanged: changes.add,
        ),
      );

      await tester.tapAt(_pointAt(tester, 0.44));
      await tester.pump();
      expect(changes.last, [40, 80]);

      final gesture = await tester.startGesture(_pointAt(tester, 0.4));
      await gesture.moveTo(_pointAt(tester, 0.95));
      await tester.pump();
      await gesture.up();
      await tester.pump();
      expect(changes.last, [70, 80]);
    });

    testWidgets('owner rejection leaves visual values unchanged', (
      tester,
    ) async {
      final changes = <List<double>>[];
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          acceptChanges: false,
          onChanged: changes.add,
        ),
      );

      await tester.tapAt(_pointAt(tester, 0.3));
      await tester.pump();

      expect(changes.last, [30, 80]);
      final sliderRect = tester.getRect(find.byKey(_sliderKey));
      expect(
        tester.getCenter(find.byKey(const ValueKey('remix-slider-thumb-0'))).dx,
        sliderRect.left + 40,
      );
    });

    testWidgets('reports complete drag lifecycle lists and aggregate states', (
      tester,
    ) async {
      final starts = <List<double>>[];
      final ends = <List<double>>[];
      final dragging = <bool>[];
      final focused = <bool>[];
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          onChanged: (_) {},
          onChangeStart: starts.add,
          onChangeEnd: ends.add,
          onDragChange: dragging.add,
          onFocusChange: focused.add,
        ),
      );

      final gesture = await tester.startGesture(_pointAt(tester, 0.2));
      await gesture.moveTo(_pointAt(tester, 0.4));
      await tester.pump();
      await gesture.up();
      await tester.pump();

      expect(starts, [
        [20, 80],
      ]);
      expect(ends, [
        [40, 80],
      ]);
      expect(dragging, [true, false]);
      expect(focused, contains(true));
    });

    testWidgets('reports hover entry and exit', (tester) async {
      final hovers = <bool>[];
      await tester.pumpWidget(
        _harness(
          values: const [50],
          onChanged: (_) {},
          onHoverChange: hovers.add,
        ),
      );

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(find.byKey(_sliderKey)));
      await tester.pump();
      await mouse.moveTo(const Offset(799, 599));
      await tester.pump();

      expect(hovers, [true, false]);
    });

    testWidgets('RTL, inversion, and vertical input follow visual direction', (
      tester,
    ) async {
      final changes = <List<double>>[];
      await tester.pumpWidget(
        _harness(
          values: const [50],
          textDirection: TextDirection.rtl,
          onChanged: changes.add,
        ),
      );
      await tester.tapAt(_pointAt(tester, 0.25));
      await tester.pump();
      expect(changes.last, [75]);

      await tester.pumpWidget(const SizedBox.shrink());
      changes.clear();
      await tester.pumpWidget(
        _harness(values: const [50], inverted: true, onChanged: changes.add),
      );
      await tester.tapAt(_pointAt(tester, 0.25));
      await tester.pump();
      expect(changes.last, [75]);

      await tester.pumpWidget(const SizedBox.shrink());
      changes.clear();
      await tester.pumpWidget(
        _harness(
          values: const [50],
          orientation: Axis.vertical,
          size: const Size(48, 200),
          onChanged: changes.add,
        ),
      );
      await tester.tapAt(_verticalPointAt(tester, 0.25));
      await tester.pump();
      expect(changes.last, [75]);
    });

    testWidgets('disabled slider ignores pointer and hover input', (
      tester,
    ) async {
      final changes = <List<double>>[];
      final hovers = <bool>[];
      await tester.pumpWidget(
        _harness(
          values: const [50],
          enabled: false,
          onChanged: changes.add,
          onHoverChange: hovers.add,
        ),
      );

      await tester.tapAt(_pointAt(tester, 0.75));
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer();
      await mouse.moveTo(tester.getCenter(find.byKey(_sliderKey)));
      await tester.pump();
      await mouse.removePointer();

      expect(changes, isEmpty);
      expect(hovers, isEmpty);
    });
  });

  group('RemixSlider keyboard and semantics', () {
    testWidgets('routes keyboard input to the independently focused thumb', (
      tester,
    ) async {
      final first = FocusNode();
      final second = FocusNode();
      final changes = <List<double>>[];
      addTearDown(first.dispose);
      addTearDown(second.dispose);
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          focusNodes: [first, second],
          onChanged: changes.add,
        ),
      );

      second.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();

      expect(first.hasFocus, isFalse);
      expect(second.hasFocus, isTrue);
      expect(changes.last, [20, 79]);
    });

    testWidgets('exposes one labeled slider node per thumb', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(
          values: const [20, 50, 80],
          semanticLabels: const ['Minimum', 'Target', 'Maximum'],
          onChanged: (_) {},
        ),
      );

      final data = _sliderNodes(
        tester,
      ).map((node) => node.getSemanticsData()).toList();
      expect(data, hasLength(3));
      expect(data.map((value) => value.label), [
        'Minimum',
        'Target',
        'Maximum',
      ]);
      expect(data.map((value) => value.value), ['20%', '50%', '80%']);
      for (final value in data) {
        expect(value.flagsCollection.isSlider, isTrue);
        expect(value.hasAction(ui.SemanticsAction.increase), isTrue);
        expect(value.hasAction(ui.SemanticsAction.decrease), isTrue);
      }
      handle.dispose();
    });

    testWidgets('uses per-thumb semantic formatters and target actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final changes = <List<double>>[];
      await tester.pumpWidget(
        _harness(
          values: const [20, 80],
          step: 5,
          semanticFormatterCallbacks: [
            (value) => 'From ${value.round()} dollars',
            (value) => 'To ${value.round()} dollars',
          ],
          onChanged: changes.add,
        ),
      );

      var nodes = _sliderNodes(tester);
      expect(nodes[0].getSemanticsData().value, 'From 20 dollars');
      expect(nodes[0].getSemanticsData().increasedValue, 'From 25 dollars');
      expect(nodes[1].getSemanticsData().value, 'To 80 dollars');

      _performSemanticsAction(tester, nodes[1], ui.SemanticsAction.decrease);
      await tester.pump();
      expect(changes.last, [20, 75]);

      nodes = _sliderNodes(tester);
      expect(nodes[1].getSemanticsData().value, 'To 75 dollars');
      handle.dispose();
    });

    testWidgets('disabled semantics retain values but remove actions', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(values: const [25, 75], enabled: false, onChanged: (_) {}),
      );

      final data = _sliderNodes(
        tester,
      ).map((node) => node.getSemanticsData()).toList();
      expect(data.map((value) => value.value), ['25%', '75%']);
      for (final value in data) {
        expect(value.flagsCollection.isEnabled, ui.Tristate.isFalse);
        expect(value.hasAction(ui.SemanticsAction.increase), isFalse);
        expect(value.hasAction(ui.SemanticsAction.decrease), isFalse);
      }
      handle.dispose();
    });

    testWidgets('can exclude every thumb semantics node', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _harness(
          values: const [25, 75],
          excludeSemantics: true,
          onChanged: (_) {},
        ),
      );

      expect(_sliderNodes(tester), isEmpty);
      handle.dispose();
    });
  });
}

Widget _harness({
  required List<double> values,
  required ValueChanged<List<double>>? onChanged,
  ValueChanged<List<double>>? onChangeStart,
  ValueChanged<List<double>>? onChangeEnd,
  ValueChanged<bool>? onHoverChange,
  ValueChanged<bool>? onDragChange,
  ValueChanged<bool>? onFocusChange,
  double min = 0,
  double max = 100,
  double step = 1,
  double minSpacing = 0,
  Axis orientation = Axis.horizontal,
  bool inverted = false,
  bool enabled = true,
  bool acceptChanges = true,
  TextDirection textDirection = TextDirection.ltr,
  List<FocusNode?>? focusNodes,
  int? autofocusThumbIndex,
  List<String?>? semanticLabels,
  List<RemixSliderSemanticFormatterCallback?>? semanticFormatterCallbacks,
  bool excludeSemantics = false,
  RemixSliderSpec? styleSpec,
  Size size = const Size(200, 48),
}) {
  var currentValues = List<double>.of(values);

  return FortalScope(
    child: MaterialApp(
      home: Directionality(
        textDirection: textDirection,
        child: Scaffold(
          body: Center(
            child: SizedBox.fromSize(
              size: size,
              child: StatefulBuilder(
                builder: (context, setState) => RemixSlider(
                  key: _sliderKey,
                  values: currentValues,
                  min: min,
                  max: max,
                  step: step,
                  minSpacing: minSpacing,
                  orientation: orientation,
                  inverted: inverted,
                  enabled: enabled,
                  focusNodes: focusNodes,
                  autofocusThumbIndex: autofocusThumbIndex,
                  semanticLabels: semanticLabels,
                  semanticFormatterCallbacks: semanticFormatterCallbacks,
                  excludeSemantics: excludeSemantics,
                  styleSpec: styleSpec,
                  onChanged: onChanged == null
                      ? null
                      : (next) {
                          onChanged(next);
                          if (acceptChanges) {
                            setState(
                              () => currentValues = List<double>.of(next),
                            );
                          }
                        },
                  onChangeStart: onChangeStart,
                  onChangeEnd: onChangeEnd,
                  onHoverChange: onHoverChange,
                  onDragChange: onDragChange,
                  onFocusChange: onFocusChange,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Offset _pointAt(WidgetTester tester, double percentage) {
  final rect = tester.getRect(find.byKey(_sliderKey));

  return Offset(rect.left + rect.width * percentage, rect.center.dy);
}

Offset _verticalPointAt(WidgetTester tester, double percentageFromTop) {
  final rect = tester.getRect(find.byKey(_sliderKey));

  return Offset(rect.center.dx, rect.top + rect.height * percentageFromTop);
}

List<SemanticsNode> _sliderNodes(WidgetTester tester) {
  final root = tester.getSemantics(find.byType(Scaffold));
  final nodes = <SemanticsNode>[];

  void collect(SemanticsNode node) {
    if (node.getSemanticsData().flagsCollection.isSlider) nodes.add(node);
    node.visitChildren((child) {
      collect(child);

      return true;
    });
  }

  collect(root);

  return nodes;
}

void _performSemanticsAction(
  WidgetTester tester,
  SemanticsNode node,
  ui.SemanticsAction action,
) {
  tester.binding.performSemanticsAction(
    ui.SemanticsActionEvent(
      type: action,
      viewId: tester.view.viewId,
      nodeId: node.id,
    ),
  );
}
