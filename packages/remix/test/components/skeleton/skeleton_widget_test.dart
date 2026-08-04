import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

// This directory never uses `pumpAndSettle`: the pulse repeats forever, so
// every expectation below advances explicit frames instead.
void main() {
  group('RemixSkeleton', () {
    group('Defaults and structure', () {
      testWidgets('loading defaults to true', (tester) async {
        await _pumpSkeleton(tester, const RemixSkeleton(child: Text('Ready')));

        final skeleton = tester.widget<RemixSkeleton>(
          find.byType(RemixSkeleton),
        );

        expect(skeleton.loading, isTrue);
      });

      testWidgets('a childless loaded skeleton collapses to nothing', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(loading: false, style: _blockStyle()),
        );

        expect(tester.getSize(find.byType(RemixSkeleton)), Size.zero);
        expect(_boxes(), findsNothing);
      });

      testWidgets('a childless loading skeleton resolves its styled size', (
        tester,
      ) async {
        await _pumpSkeleton(tester, RemixSkeleton(style: _blockStyle()));

        expect(tester.getSize(find.byType(RemixSkeleton)), _childSize);
        expect(_pulseDecoration(tester).borderRadius, BorderRadius.circular(4));
      });

      testWidgets('rejects a non-positive duration in debug', (tester) async {
        // Release builds fall back to the 1000 ms default instead of throwing.
        await tester.pumpRemixApp(
          RemixSkeleton(style: _blockStyle().duration(Duration.zero)),
        );

        expect(tester.takeException(), isA<AssertionError>());
      });
    });

    group('Geometry', () {
      testWidgets('matches the child size under a loose parent', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _blockStyle(), child: _child()),
        );

        expect(
          tester.getSize(find.byType(RemixSkeleton)),
          tester.getSize(find.byKey(_childKey)),
        );
        expect(tester.getSize(find.byType(RemixSkeleton)), _childSize);
      });

      testWidgets('matches the child size under a tight parent', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          SizedBox(
            width: 300,
            height: 90,
            child: RemixSkeleton(style: _blockStyle(), child: _child()),
          ),
        );

        expect(
          tester.getSize(find.byType(RemixSkeleton)),
          tester.getSize(find.byKey(_childKey)),
        );
        expect(tester.getSize(find.byType(RemixSkeleton)), const Size(300, 90));
      });

      testWidgets('matches the child size under an intrinsic parent', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: RemixSkeleton(style: _blockStyle(), child: _child()),
            ),
          ),
        );

        expect(tester.getSize(find.byType(RemixSkeleton)), _childSize);
      });

      testWidgets('the pulse does not resize the skeleton over time', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle(), child: _child()),
        );

        final sizes = <Size>[tester.getSize(find.byType(RemixSkeleton))];
        for (var frame = 0; frame < 4; frame++) {
          await tester.pump(const Duration(milliseconds: 500));
          sizes.add(tester.getSize(find.byType(RemixSkeleton)));
        }

        expect(sizes, everyElement(_childSize));
      });

      testWidgets('toggling loading does not change the size', (tester) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _blockStyle(), child: _child()),
        );
        final loadingSize = tester.getSize(find.byType(RemixSkeleton));

        await _pumpSkeleton(
          tester,
          RemixSkeleton(loading: false, style: _blockStyle(), child: _child()),
        );

        expect(tester.getSize(find.byType(RemixSkeleton)), loadingSize);
      });

      testWidgets('still matches the child at a doubled text scale', (
        tester,
      ) async {
        Widget build({required bool loading}) => RemixSkeleton(
          loading: loading,
          style: _blockStyle(),
          child: const Text(_buttonLabel),
        );

        await _pumpSkeleton(tester, build(loading: false), textScale: 2);
        final loadedSize = tester.getSize(find.byType(RemixSkeleton));

        await _pumpSkeleton(tester, build(loading: true), textScale: 2);

        expect(tester.getSize(find.byType(RemixSkeleton)), loadedSize);
        expect(loadedSize, tester.getSize(find.text(_buttonLabel)));
      });

      testWidgets('renders identically in RTL', (tester) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _blockStyle(), child: _child()),
        );
        final ltr = tester.getSize(find.byType(RemixSkeleton));

        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _blockStyle(), child: _child()),
          textDirection: TextDirection.rtl,
        );

        expect(tester.getSize(find.byType(RemixSkeleton)), ltr);
        expect(
          tester.getRect(find.byKey(_childKey)),
          tester.getRect(find.byType(RemixSkeleton)),
        );
      });
    });

    group('Suppression while loading', () {
      testWidgets('contributes none of the child semantics', (tester) async {
        final handle = tester.ensureSemantics();
        try {
          await _pumpSkeleton(
            tester,
            RemixSkeleton(style: _blockStyle(), child: _button()),
          );

          final nodes = tester.semantics
              .simulatedAccessibilityTraversal()
              .map((node) => node.getSemanticsData())
              .toList();

          expect(nodes.where((data) => data.label == _buttonLabel), isEmpty);
          expect(nodes.where((data) => data.flagsCollection.isButton), isEmpty);
          expect(
            nodes.where((data) => data.flagsCollection.isTextField),
            isEmpty,
          );
          expect(
            nodes.where((data) => data.hasAction(SemanticsAction.tap)),
            isEmpty,
          );
        } finally {
          handle.dispose();
        }
      });

      testWidgets('does not deliver taps to the hidden child', (tester) async {
        var taps = 0;

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: _blockStyle(),
            child: _button(onPressed: () => taps++),
          ),
        );

        await tester.tap(find.byType(RemixSkeleton), warnIfMissed: false);
        await tester.pump();

        expect(taps, 0);
      });

      testWidgets('is skipped by keyboard traversal', (tester) async {
        final focusNode = FocusNode(debugLabel: 'skeleton child');
        addTearDown(focusNode.dispose);

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: _blockStyle(),
            child: _button(focusNode: focusNode),
          ),
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        expect(focusNode.hasFocus, isFalse);
        expect(primaryFocus, isNot(focusNode));
      });

      testWidgets('disables the ticker inside the hidden child', (
        tester,
      ) async {
        late bool tickerEnabled;

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: _blockStyle(),
            child: Builder(
              builder: (context) {
                tickerEnabled = TickerMode.valuesOf(context).enabled;

                return const SizedBox(width: 40, height: 40);
              },
            ),
          ),
        );

        expect(tickerEnabled, isFalse);
      });
    });

    group('Restoration when loaded', () {
      testWidgets('restores the exact child semantics', (tester) async {
        final handle = tester.ensureSemantics();
        try {
          await _pumpSkeleton(tester, _button());
          final bare = tester
              .getSemantics(find.bySemanticsLabel(_buttonLabel))
              .getSemanticsData();

          await _pumpSkeleton(
            tester,
            RemixSkeleton(
              loading: false,
              style: _blockStyle(),
              child: _button(),
            ),
          );
          final wrapped = tester
              .getSemantics(find.bySemanticsLabel(_buttonLabel))
              .getSemanticsData();

          expect(wrapped.label, bare.label);
          expect(wrapped.role, bare.role);
          expect(wrapped.flagsCollection, bare.flagsCollection);
          expect(wrapped.actions, bare.actions);
        } finally {
          handle.dispose();
        }
      });

      testWidgets('restores pointer input', (tester) async {
        var taps = 0;

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            loading: false,
            style: _blockStyle(),
            child: _button(onPressed: () => taps++),
          ),
        );

        await tester.tap(find.byType(RemixSkeleton));
        await tester.pump();

        expect(taps, 1);
      });

      testWidgets('restores keyboard traversal', (tester) async {
        final focusNode = FocusNode(debugLabel: 'skeleton child');
        addTearDown(focusNode.dispose);

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            loading: false,
            style: _blockStyle(),
            child: _button(focusNode: focusNode),
          ),
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        expect(focusNode.hasFocus, isTrue);
      });

      testWidgets('restores the child ticker', (tester) async {
        late bool tickerEnabled;

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            loading: false,
            style: _blockStyle(),
            child: Builder(
              builder: (context) {
                tickerEnabled = TickerMode.valuesOf(context).enabled;

                return const SizedBox(width: 40, height: 40);
              },
            ),
          ),
        );

        expect(tickerEnabled, isTrue);
      });

      testWidgets('runs no pulse ticker when loaded', (tester) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(loading: false, style: _pulseStyle(), child: _child()),
        );

        expect(_boxes(), findsNothing);
        expect(tester.binding.hasScheduledFrame, isFalse);
      });
    });

    group('Child identity', () {
      testWidgets('keeps a keyed stateful child mounted once across toggles', (
        tester,
      ) async {
        _CounterState.mounts = 0;
        _CounterState.disposals = 0;

        Widget build({required bool loading}) => RemixSkeleton(
          loading: loading,
          style: _blockStyle(),
          child: const _Counter(key: ValueKey('counter')),
        );

        await _pumpSkeleton(tester, build(loading: false));
        final state = tester.state<_CounterState>(find.byType(_Counter));
        state.increment();
        await tester.pump();
        expect(state.count, 1);

        await _pumpSkeleton(tester, build(loading: true));
        expect(tester.state<_CounterState>(find.byType(_Counter)), same(state));
        expect(state.count, 1);

        await _pumpSkeleton(tester, build(loading: false));
        expect(tester.state<_CounterState>(find.byType(_Counter)), same(state));
        expect(state.count, 1);
        expect(find.byType(_Counter), findsOneWidget);

        expect(_CounterState.mounts, 1);
        expect(_CounterState.disposals, 0);
      });
    });

    group('Focus release', () {
      testWidgets('releases focus already held inside the child', (
        tester,
      ) async {
        final focusNode = FocusNode(debugLabel: 'skeleton child');
        addTearDown(focusNode.dispose);

        Widget build({required bool loading}) => RemixSkeleton(
          loading: loading,
          style: _blockStyle(),
          child: _button(focusNode: focusNode),
        );

        await _pumpSkeleton(tester, build(loading: false));
        focusNode.requestFocus();
        await tester.pump();
        expect(focusNode.hasFocus, isTrue);

        await _pumpSkeleton(tester, build(loading: true));

        expect(focusNode.hasFocus, isFalse);
        expect(primaryFocus, isNot(focusNode));
      });
    });

    group('Pulse painting', () {
      testWidgets('interpolates the fill toward pulseColor', (tester) async {
        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));

        expect(_pulseDecoration(tester).color, isSameColorAs(_baseColor));

        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));

        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseDecoration(tester).color, isSameColorAs(_pulseColor));

        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));
      });

      testWidgets('keeps the rest of the decoration untouched', (tester) async {
        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));

        expect(_pulseDecoration(tester).borderRadius, BorderRadius.circular(4));
        expect(tester.getSize(find.byType(RemixSkeleton)), _childSize);
      });

      testWidgets('interpolates a shape fill without losing the shape', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: SkeletonStyler()
                .size(40, 40)
                .color(_baseColor)
                .shapeCircle()
                .pulseColor(_pulseColor)
                .duration(_leg),
          ),
        );

        final initial = _decorationOf(tester);
        expect(initial, isA<ShapeDecoration>());
        expect((initial as ShapeDecoration).color, isSameColorAs(_baseColor));

        await tester.pump(const Duration(milliseconds: 500));

        final pulsed = _decorationOf(tester) as ShapeDecoration;
        expect(pulsed.color, isSameColorAs(_midColor));
        expect(pulsed.shape, initial.shape);
        expect(tester.getSize(find.byType(RemixSkeleton)), const Size(40, 40));
      });

      testWidgets('falls back to opacity when a gradient covers the fill', (
        tester,
      ) async {
        // The gradient paints over the fill color, so lerping the fill would
        // animate nothing at all. The container has to fade instead.
        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: SkeletonStyler()
                .size(_childSize.width, _childSize.height)
                .color(_baseColor)
                .linearGradient(colors: const [_baseColor, _pulseColor])
                .pulseColor(_pulseColor)
                .duration(_leg),
          ),
        );

        expect(_pulseDecoration(tester).gradient, isNotNull);
        expect(_pulseOpacities(tester), [1.0]);

        await tester.pump(const Duration(milliseconds: 500));

        expect(_pulseOpacities(tester), [0.75]);
        expect(_pulseDecoration(tester).color, isSameColorAs(_baseColor));
      });

      testWidgets('falls back to opacity without a resolvable fill', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: SkeletonStyler()
                .size(_childSize.width, _childSize.height)
                .pulseColor(_pulseColor)
                .duration(_leg),
          ),
        );

        expect(_pulseOpacities(tester), [1.0]);

        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseOpacities(tester), [0.75]);

        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseOpacities(tester), [0.5]);
      });

      testWidgets('composes a caller opacity with the pulse fallback', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: SkeletonStyler()
                .size(_childSize.width, _childSize.height)
                .container(BoxStyler().wrap(WidgetModifierConfig.opacity(0.4)))
                .duration(_leg),
          ),
        );

        expect(_pulseOpacities(tester), [1.0, 0.4]);

        await tester.pump(const Duration(milliseconds: 1000));

        // The caller's 0.4 survives; only the pulse leg moved.
        expect(_pulseOpacities(tester), [0.5, 0.4]);
      });
    });

    group('Reduced motion', () {
      testWidgets('stays on the base frame when animations are disabled', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle()),
          disableAnimations: true,
        );

        expect(_pulseDecoration(tester).color, isSameColorAs(_baseColor));
        expect(tester.binding.hasScheduledFrame, isFalse);

        await tester.pump(const Duration(milliseconds: 500));

        expect(_pulseDecoration(tester).color, isSameColorAs(_baseColor));
        expect(tester.takeException(), isNull);
      });

      testWidgets('stops pulsing when reduced motion turns on at runtime', (
        tester,
      ) async {
        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));

        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle()),
          disableAnimations: true,
        );

        expect(_pulseDecoration(tester).color, isSameColorAs(_baseColor));
        expect(tester.binding.hasScheduledFrame, isFalse);
      });

      testWidgets('resumes pulsing when reduced motion turns off', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle()),
          disableAnimations: true,
        );
        expect(tester.binding.hasScheduledFrame, isFalse);

        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));

        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));
      });
    });

    group('Dynamic updates', () {
      testWidgets('changes duration without replacing the controller', (
        tester,
      ) async {
        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));

        await _pumpSkeleton(
          tester,
          RemixSkeleton(
            style: _pulseStyle(leg: const Duration(milliseconds: 400)),
          ),
        );

        // A replaced controller would snap back to the base frame.
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));

        // 100 ms is a quarter of the new leg, so the phase advances to 0.75.
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          _pulseDecoration(tester).color,
          isSameColorAs(Color.lerp(_baseColor, _pulseColor, 0.75)!),
        );
      });

      testWidgets('adopts new pulse endpoints without restarting', (
        tester,
      ) async {
        const nextPulse = Color(0xFF00FF00);

        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));

        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle(pulseColor: nextPulse)),
        );

        expect(
          _pulseDecoration(tester).color,
          isSameColorAs(Color.lerp(_baseColor, nextPulse, 0.5)!),
        );
      });

      testWidgets('keeps pulsing after the child is removed', (tester) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle(), child: _child()),
        );

        await _pumpSkeleton(tester, RemixSkeleton(style: _pulseStyle()));
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byKey(_childKey), findsNothing);
        expect(_pulseDecoration(tester).color, isSameColorAs(_midColor));
      });

      testWidgets('unmounting mid-pulse leaves no ticker or pending frame', (
        tester,
      ) async {
        await _pumpSkeleton(
          tester,
          RemixSkeleton(style: _pulseStyle(), child: _child()),
        );
        await tester.pump(const Duration(milliseconds: 317));

        await _pumpSkeleton(tester, const SizedBox.shrink());

        expect(find.byType(RemixSkeleton), findsNothing);
        expect(tester.binding.hasScheduledFrame, isFalse);
        expect(tester.takeException(), isNull);
      });
    });
  });
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

const _leg = Duration(milliseconds: 1000);
const _baseColor = Color(0xFFEEEEEE);
const _pulseColor = Color(0xFFCCCCCC);
const _childKey = ValueKey('skeleton-child');
const _childSize = Size(120, 24);
const _buttonLabel = 'Save';

final Color _midColor = Color.lerp(_baseColor, _pulseColor, 0.5)!;

/// Geometry only: the resolved decoration carries no fill, so the pulse takes
/// the generic opacity fallback.
SkeletonStyler _blockStyle() =>
    SkeletonStyler().size(_childSize.width, _childSize.height).borderRounded(4);

/// Both endpoints resolve, so the pulse interpolates the container fill.
SkeletonStyler _pulseStyle({Color? pulseColor, Duration? leg}) => _blockStyle()
    .color(_baseColor)
    .pulseColor(pulseColor ?? _pulseColor)
    .duration(leg ?? _leg);

Widget _child() => SizedBox(
  key: _childKey,
  width: _childSize.width,
  height: _childSize.height,
);

Widget _button({VoidCallback? onPressed, FocusNode? focusNode}) => SizedBox(
  width: _childSize.width,
  height: _childSize.height,
  child: TextButton(
    focusNode: focusNode,
    onPressed: onPressed ?? () {},
    child: const Text(_buttonLabel),
  ),
);

Future<void> _pumpSkeleton(
  WidgetTester tester,
  Widget widget, {
  bool disableAnimations = false,
  double textScale = 1,
  TextDirection textDirection = TextDirection.ltr,
}) async {
  await tester.pumpRemixApp(
    Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          disableAnimations: disableAnimations,
          textScaler: TextScaler.linear(textScale),
        ),
        child: widget,
      ),
    ),
    textDirection: textDirection,
  );
  // A zero-length frame so a freshly started pulse ticker records its start
  // timestamp; later `pump(duration)` calls then advance deterministically.
  await tester.pump();
}

Finder _boxes() =>
    find.descendant(of: find.byType(RemixSkeleton), matching: find.byType(Box));

Decoration _decorationOf(WidgetTester tester) {
  final container = tester.widget<Container>(
    find.descendant(of: _boxes(), matching: find.byType(Container)),
  );

  return container.decoration!;
}

BoxDecoration _pulseDecoration(WidgetTester tester) =>
    _decorationOf(tester) as BoxDecoration;

List<double> _pulseOpacities(WidgetTester tester) {
  return tester
      .widgetList<Opacity>(
        find.descendant(
          of: find.byType(RemixSkeleton),
          matching: find.byType(Opacity),
        ),
      )
      .map((opacity) => opacity.opacity)
      .toList();
}

class _Counter extends StatefulWidget {
  const _Counter({super.key});

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  static int mounts = 0;
  static int disposals = 0;

  int count = 0;

  @override
  void initState() {
    super.initState();
    mounts++;
  }

  @override
  void dispose() {
    disposals++;
    super.dispose();
  }

  void increment() => setState(() => count++);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _childSize.width,
      height: _childSize.height,
      child: Text('$count'),
    );
  }
}
