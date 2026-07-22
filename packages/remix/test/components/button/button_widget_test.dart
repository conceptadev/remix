import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_methods.dart';

void main() {
  group('RemixButton', () {
    testWidgets('renders arbitrary content without reordering it', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, key: ValueKey('leading')),
              Text('Continue'),
              Icon(Icons.arrow_forward, key: ValueKey('trailing')),
            ],
          ),
        ),
      );

      expect(find.byType(NakedButton), findsOneWidget);
      expect(
        find.byKey(const ValueKey('remix-button-surface')),
        findsOneWidget,
      );
      final labelX = tester.getTopLeft(find.text('Continue')).dx;
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('leading'))).dx,
        lessThan(labelX),
      );
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('trailing'))).dx,
        greaterThan(labelX),
      );
    });

    testWidgets('resolved text and icon styles are inherited by content', (
      tester,
    ) async {
      const textColor = Color(0xFF123456);
      const iconColor = Color(0xFF654321);
      await tester.pumpRemixApp(
        RemixButton(
          style: ButtonStyler(
            label: TextStyler().color(textColor).fontSize(15),
            icon: IconStyler().color(iconColor).size(19),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.star), Text('Inherited')],
          ),
        ),
      );

      final textContext = tester.element(find.text('Inherited'));
      final iconContext = tester.element(find.byIcon(Icons.star));
      expect(DefaultTextStyle.of(textContext).style.color, textColor);
      expect(DefaultTextStyle.of(textContext).style.fontSize, 15);
      expect(IconTheme.of(iconContext).color, iconColor);
      expect(IconTheme.of(iconContext).size, 19);
    });

    testWidgets('explicit descendant styles remain authoritative', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixButton(
          style: ButtonStyler(
            label: TextStyler().color(Colors.blue),
            icon: IconStyler().color(Colors.green),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.red),
              Text('Explicit', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      );

      expect(tester.widget<Icon>(find.byIcon(Icons.star)).color, Colors.red);
      expect(
        tester.widget<Text>(find.text('Explicit')).style!.color,
        Colors.orange,
      );
    });

    testWidgets('raw style spec supplies surface and inherited styles', (
      tester,
    ) async {
      const color = Color(0xFF224466);
      await tester.pumpRemixApp(
        const RemixButton(
          styleSpec: RemixButtonSpec(
            container: StyleSpec(
              spec: FlexBoxSpec(
                box: StyleSpec(spec: BoxSpec(decoration: BoxDecoration())),
              ),
            ),
            label: StyleSpec(
              spec: TextSpec(style: TextStyle(color: color)),
            ),
            effects: RemixSurfaceEffectsSpec(
              background: RemixSurfaceLayerSpec(
                shadows: [RemixPaintShadow(color: color)],
              ),
            ),
          ),
          child: Text('Spec'),
        ),
      );
      expect(find.byType(CustomPaint), findsWidgets);
      expect(
        DefaultTextStyle.of(tester.element(find.text('Spec'))).style.color,
        color,
      );
    });

    testWidgets('fluent color overrides a Fortal surface', (tester) async {
      const boundaryKey = ValueKey('button-color-boundary');
      await tester.pumpRemixApp(
        RepaintBoundary(
          key: boundaryKey,
          child: fortalButtonStyler()
              .color(Colors.red)
              .call(
                onPressed: () {},
                child: const SizedBox(width: 40, height: 12),
              ),
        ),
      );

      final pixels = await _capture(tester, find.byKey(boundaryKey));
      expect(
        _pixel(pixels, pixels.width ~/ 2, pixels.height ~/ 2),
        _rgba(Colors.red),
      );
    });

    testWidgets('loading preserves layout, hides visuals, and shows spinner', (
      tester,
    ) async {
      Widget build(bool loading) => RemixButton(
        loading: loading,
        onPressed: () {},
        child: const SizedBox(width: 96, height: 24, child: Text('Save')),
      );

      await tester.pumpRemixApp(build(false));
      final idleSize = tester.getSize(find.byType(RemixButton));
      expect(find.byType(RemixSpinner), findsNothing);

      await tester.pumpRemixApp(build(true));
      await tester.pump();
      final loadingSize = tester.getSize(find.byType(RemixButton));
      final visibility = tester.widget<Visibility>(find.byType(Visibility));

      expect(loadingSize, idleSize);
      expect(find.byType(RemixSpinner), findsOneWidget);
      expect(visibility.visible, isFalse);
      expect(visibility.maintainSize, isTrue);
      expect(visibility.maintainState, isTrue);
      expect(visibility.maintainAnimation, isTrue);
      expect(visibility.maintainSemantics, isTrue);
    });

    testWidgets('loadingBuilder receives the resolved spinner spec', (
      tester,
    ) async {
      RemixSpinnerSpec? received;
      await tester.pumpRemixApp(
        RemixButton(
          loading: true,
          onPressed: () {},
          loadingBuilder: (context, spec) {
            received = spec;
            return const SizedBox(key: ValueKey('custom-spinner'));
          },
          child: const Text('Save'),
        ),
      );
      await tester.pump();

      expect(received, isNotNull);
      expect(find.byKey(const ValueKey('custom-spinner')), findsOneWidget);
      expect(find.byType(RemixSpinner), findsNothing);
    });

    testWidgets('press and long-press callbacks independently enable it', (
      tester,
    ) async {
      var presses = 0;
      await tester.pumpRemixApp(
        RemixButton(onPressed: () => presses++, child: const Text('Press')),
      );
      await tester.tap(find.byType(RemixButton));
      expect(presses, 1);

      var longPresses = 0;
      await tester.pumpRemixApp(
        RemixButton(
          onLongPress: () => longPresses++,
          child: const Text('Long press'),
        ),
      );
      await tester.longPress(find.byType(RemixButton));
      expect(longPresses, 1);
    });

    testWidgets('disabled and loading states suppress every callback', (
      tester,
    ) async {
      var callbacks = 0;
      for (final configuration in [
        (enabled: false, loading: false),
        (enabled: true, loading: true),
      ]) {
        await tester.pumpRemixApp(
          RemixButton(
            enabled: configuration.enabled,
            loading: configuration.loading,
            onPressed: () => callbacks++,
            onLongPress: () => callbacks++,
            child: const Text('Unavailable'),
          ),
        );
        await tester.pump();
        await tester.tap(find.byType(RemixButton));
        await tester.longPress(find.byType(RemixButton));
      }
      expect(callbacks, 0);
    });

    testWidgets('semantic label and hint form one button node', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixButton(
          semanticLabel: 'Save document',
          semanticHint: 'Writes changes to disk',
          onPressed: () {},
          child: const Text('Save'),
        ),
      );

      final node = tester.getSemantics(find.byType(RemixButton));
      expect(node.label, 'Save document');
      expect(node.hint, 'Writes changes to disk');
      expect(node.flagsCollection.isButton, isTrue);
      semantics.dispose();
    });

    testWidgets('child supplies semantics when no explicit label is set', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpRemixApp(
        RemixButton(onPressed: () {}, child: const Text('Continue')),
      );

      expect(tester.getSemantics(find.byType(RemixButton)).label, 'Continue');
      semantics.dispose();
    });

    testWidgets('excludeSemantics is forwarded to the headless control', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        RemixButton(
          excludeSemantics: true,
          onPressed: () {},
          child: const Text('Hidden'),
        ),
      );

      expect(
        tester.widget<NakedButton>(find.byType(NakedButton)).excludeSemantics,
        isTrue,
      );
    });

    testWidgets('autofocus, feedback, and cursor are forwarded', (
      tester,
    ) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpRemixApp(
        RemixButton(
          autofocus: true,
          focusNode: focusNode,
          enableFeedback: false,
          mouseCursor: SystemMouseCursors.forbidden,
          onPressed: () {},
          child: const Text('Focus'),
        ),
      );
      await tester.pumpAndSettle();

      final naked = tester.widget<NakedButton>(find.byType(NakedButton));
      expect(focusNode.hasFocus, isTrue);
      expect(naked.enableFeedback, isFalse);
      expect(naked.mouseCursor, SystemMouseCursors.forbidden);
    });

    widgetControllerTest<RemixButtonSpec>(
      'reports disabled state when no callback is supplied',
      build: () => const RemixButton(child: Text('Disabled')),
      expectedStates: {WidgetState.disabled},
    );

    widgetControllerTest<RemixButtonSpec>(
      'reports hovered state',
      build: () => RemixButton(onPressed: () {}, child: const Text('Hover')),
      act: hoverAction<RemixButton>,
      expectedStates: {WidgetState.hovered},
    );

    widgetControllerTest<RemixButtonSpec>(
      'reports focused state',
      build: () => RemixButton(onPressed: () {}, child: const Text('Focus')),
      act: focusAction<RemixButton>,
      expectedStates: {WidgetState.focused},
    );

    widgetControllerTest<RemixButtonSpec>(
      'reports pressed state',
      build: () => RemixButton(onPressed: () {}, child: const Text('Press')),
      act: pressAction<RemixButton>,
      expectedStates: {WidgetState.pressed},
    );
  });

  group('FortalButton', () {
    testWidgets('forwards the enum recipe, overrides, and arbitrary child', (
      tester,
    ) async {
      const child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.save), Text('Save')],
      );
      await tester.pumpRemixApp(
        const FortalButton(
          variant: .classic,
          size: .size3,
          color: .red,
          radius: .small,
          highContrast: true,
          child: child,
        ),
      );

      final fortal = tester.widget<FortalButton>(find.byType(FortalButton));
      final remix = tester.widget<RemixButton>(find.byType(RemixButton));
      expect(fortal.variant, FortalButtonVariant.classic);
      expect(fortal.size, FortalButtonSize.size3);
      expect(remix.child, same(child));
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });
}

Future<({ByteData bytes, int width, int height})> _capture(
  WidgetTester tester,
  Finder finder,
) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(finder);
  final result = await tester.runAsync(() async {
    final image = boundary.toImageSync(pixelRatio: 1);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final result = (bytes: bytes!, width: image.width, height: image.height);
    image.dispose();
    return result;
  });
  return result!;
}

int _pixel(({ByteData bytes, int width, int height}) image, int x, int y) =>
    image.bytes.getUint32((y * image.width + x) * 4);

int _rgba(Color color) {
  final argb = color.toARGB32();
  return ((argb & 0x00FFFFFF) << 8) | (argb >>> 24);
}
