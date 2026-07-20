import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix/src/rendering/remix_surface.dart'
    show RemixSurfaceBox, RemixSurfaceFlexBox;

void main() {
  testWidgets('FortalCard resolves translucent and solid panel surfaces', (
    tester,
  ) async {
    await tester.pumpWidget(
      _fortalApp(const FortalCard(child: Text('Panel card'))),
    );

    var finder = find.byType(RemixSurfaceBox);
    var context = tester.element(finder);
    var surface = tester.widget<RemixSurfaceBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: null,
      radius: MixScope.tokenOf(FortalTokens.radius4, context),
      blur: 64,
    );
    _expectPanelGradient(
      surface,
      MixScope.tokenOf(FortalTokens.colorPanel, context),
    );

    await tester.pumpWidget(
      FortalScope(
        panelBackground: .solid,
        child: const MaterialApp(
          home: Scaffold(body: FortalCard(child: Text('Panel card'))),
        ),
      ),
    );

    finder = find.byType(RemixSurfaceBox);
    context = tester.element(finder);
    surface = tester.widget<RemixSurfaceBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: null,
      radius: MixScope.tokenOf(FortalTokens.radius4, context),
      blur: 0,
    );
    _expectPanelGradient(
      surface,
      MixScope.tokenOf(FortalTokens.colorPanelSolid, context),
    );
  });

  testWidgets('Fortal transient surfaces resolve exact panel recipes', (
    tester,
  ) async {
    await tester.pumpWidget(
      _fortalApp(
        FortalMenu<String>(
          trigger: const Text('Open panel menu'),
          entries: const [
            RemixMenuAction(value: 'menu', child: Text('Panel menu item')),
          ],
        ),
      ),
    );
    await tester.tap(find.text('Open panel menu'));
    await tester.pumpAndSettle();

    var finder = find.byType(RemixSurfaceFlexBox);
    var context = tester.element(finder);
    var surface = tester.widget<RemixSurfaceFlexBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: MixScope.tokenOf(FortalTokens.colorPanel, context),
      radius: MixScope.tokenOf(FortalTokens.radius4, context),
      shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      blur: 64,
    );

    await tester.pumpWidget(
      _fortalApp(
        FortalSelect<String>(
          trigger: const RemixSelectTrigger(placeholder: 'Open panel select'),
          entries: const [
            RemixSelectItem(value: 'select', label: 'Panel select item'),
          ],
          onChanged: (_) {},
        ),
      ),
    );
    await tester.tap(find.byType(RemixSelect<String>));
    await tester.pumpAndSettle();

    finder = find.ancestor(
      of: find.text('Panel select item'),
      matching: find.byType(RemixSurfaceBox),
    );
    context = tester.element(finder);
    surface = tester.widget<RemixSurfaceBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: MixScope.tokenOf(FortalTokens.colorPanel, context),
      radius: MixScope.tokenOf(FortalTokens.radius4, context),
      shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      blur: 64,
    );

    await tester.pumpWidget(
      _fortalApp(
        const FortalPopover(
          popoverChild: Text('Panel popover content'),
          child: Text('Open panel popover'),
        ),
      ),
    );
    await tester.tap(find.text('Open panel popover'));
    await tester.pumpAndSettle();

    finder = find.ancestor(
      of: find.text('Panel popover content'),
      matching: find.byType(RemixSurfaceBox),
    );
    context = tester.element(finder);
    surface = tester.widget<RemixSurfaceBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: MixScope.tokenOf(FortalTokens.colorPanel, context),
      radius: MixScope.tokenOf(FortalTokens.radius4, context),
      shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      blur: 64,
    );

    await tester.pumpWidget(
      _fortalApp(const FortalDialog(title: 'Panel dialog')),
    );

    finder = find.byType(RemixSurfaceBox);
    context = tester.element(finder);
    surface = tester.widget<RemixSurfaceBox>(finder).surface!;
    _expectPanelSurface(
      tester: tester,
      finder: finder,
      surface: surface,
      color: MixScope.tokenOf(FortalTokens.colorPanel, context),
      radius: MixScope.tokenOf(FortalTokens.radius5, context),
      shadows: MixScope.tokenOf(FortalTokens.shadow6, context),
      blur: 64,
    );
  });

  testWidgets('FortalPopover keeps its ambient scope in the overlay', (
    tester,
  ) async {
    late Color overlayAccent;
    late Radius overlayRadius;

    await tester.pumpWidget(
      _fortalApp(
        FortalScope(
          accentColor: .red,
          radius: .small,
          child: FortalPopover(
            popoverChild: Builder(
              builder: (context) {
                overlayAccent = MixScope.tokenOf(FortalTokens.accent9, context);
                overlayRadius = MixScope.tokenOf(FortalTokens.radius3, context);
                return const Text('Red popover content');
              },
            ),
            child: const Text('Open red popover'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open red popover'));
    await tester.pumpAndSettle();

    expect(find.text('Red popover content'), findsOneWidget);
    expect(overlayAccent, red.light.scale.step(9));
    expect(overlayRadius, const Radius.circular(4.5));
  });

  testWidgets('FortalMenu keeps its color override in the overlay', (
    tester,
  ) async {
    await tester.pumpWidget(
      _fortalApp(
        FortalMenu<String>(
          color: .red,
          trigger: const Text('Open red menu'),
          entries: const [
            RemixMenuAction(value: 'red', child: Text('Red menu item')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Open red menu'));
    await tester.pumpAndSettle();

    final itemContext = tester.element(find.text('Red menu item'));
    expect(
      MixScope.tokenOf(FortalTokens.accent9, itemContext),
      red.light.scale.step(9),
    );
  });

  testWidgets('FortalSelect keeps its color override in the overlay', (
    tester,
  ) async {
    await tester.pumpWidget(
      _fortalApp(
        FortalSelect<String>(
          contentColor: .red,
          trigger: const RemixSelectTrigger(placeholder: 'Pick red'),
          entries: const [
            RemixSelectItem(value: 'red', label: 'Red select item'),
          ],
          onChanged: (_) {},
        ),
      ),
    );

    await tester.tap(find.byType(RemixSelect<String>));
    await tester.pumpAndSettle();

    final itemContext = tester.element(find.text('Red select item'));
    expect(
      MixScope.tokenOf(FortalTokens.accent9, itemContext),
      red.light.scale.step(9),
    );
  });

  testWidgets('FortalSlider resolves radiusThumb from its local radius', (
    tester,
  ) async {
    await tester.pumpWidget(
      FortalScope(
        radius: .none,
        child: const MaterialApp(
          home: Scaffold(body: FortalSlider(values: [50])),
        ),
      ),
    );

    final thumb = tester.widget<RemixSurfaceBox>(
      find.byKey(const ValueKey('remix-slider-thumb-0')),
    );
    expect(
      thumb.surface!.borderRadius,
      const BorderRadius.all(Radius.circular(0.5)),
    );
  });

  testWidgets('dialog barrier uses the scoped overlay token by default', (
    tester,
  ) async {
    late Color expectedBarrier;

    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                expectedBarrier = MixScope.tokenOf(
                  FortalTokens.colorOverlay,
                  context,
                );
                return TextButton(
                  onPressed: () => showRemixDialog<void>(
                    context: context,
                    builder: (context) => const RemixDialog(title: 'Dialog'),
                  ),
                  child: const Text('Open token barrier'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open token barrier'));
    await tester.pumpAndSettle();

    final barrier = tester.widget<AnimatedModalBarrier>(
      find.byType(AnimatedModalBarrier),
    );
    expect(barrier.color.value, expectedBarrier);
  });

  testWidgets('an explicit dialog barrier color takes precedence', (
    tester,
  ) async {
    const explicitBarrier = Color(0xFF123456);

    await tester.pumpWidget(
      _fortalApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => showRemixDialog<void>(
              context: context,
              barrierColor: explicitBarrier,
              builder: (context) => const RemixDialog(title: 'Dialog'),
            ),
            child: const Text('Open explicit barrier'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open explicit barrier'));
    await tester.pumpAndSettle();

    final barrier = tester.widget<AnimatedModalBarrier>(
      find.byType(AnimatedModalBarrier),
    );
    expect(barrier.color.value, explicitBarrier);
  });

  testWidgets('dialog routes replay the intentionally nested Fortal scope', (
    tester,
  ) async {
    late Color dialogAccent;
    late FortalThemeData dialogTheme;

    await tester.pumpWidget(
      FortalScope(
        appearance: .dark,
        accentColor: .blue,
        radius: .small,
        scaling: .percent90,
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: FortalScope(
                appearance: .light,
                accentColor: .red,
                radius: .large,
                scaling: .percent110,
                child: Builder(
                  builder: (context) => TextButton(
                    onPressed: () => showRemixDialog<void>(
                      context: context,
                      builder: (context) {
                        dialogAccent = MixScope.tokenOf(
                          FortalTokens.accent9,
                          context,
                        );
                        dialogTheme = FortalTheme.of(context);

                        return const FortalDialog(
                          title: 'Themed dialog',
                          child: FortalButton(
                            color: .green,
                            child: Text('Nested green action'),
                          ),
                        );
                      },
                    ),
                    child: const Text('Open themed dialog'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open themed dialog'));
    await tester.pumpAndSettle();

    expect(dialogAccent, red.light.scale.step(9));
    expect(dialogTheme.appearance, FortalAppearance.light);
    expect(dialogTheme.accentColor, FortalAccentColor.red);
    expect(dialogTheme.radius, FortalRadius.large);
    expect(dialogTheme.scaling, FortalScaling.percent110);
    expect(
      MixScope.tokenOf(
        FortalTokens.accent9,
        tester.element(find.byType(RemixButton)),
      ),
      green.light.scale.step(9),
    );
  });

  testWidgets('component accent overrides rebuild classic shadow tokens', (
    tester,
  ) async {
    await tester.pumpWidget(
      FortalScope(
        accentColor: .indigo,
        child: const MaterialApp(
          home: Scaffold(
            body: FortalButton(
              variant: .classic,
              color: .red,
              child: Text('Red classic'),
            ),
          ),
        ),
      ),
    );

    final context = tester.element(find.byType(RemixButton));
    final normal = FortalTokens.baseButtonClassicShadows.resolve(context);
    final normalHighContrast = FortalTokens.baseButtonClassicHighContrastShadows
        .resolve(context);
    final active = FortalTokens.baseButtonClassicActiveShadows.resolve(context);
    final activeHighContrast = FortalTokens
        .baseButtonClassicActiveHighContrastShadows
        .resolve(context);

    expect(
      normal.map((shadow) => shadow.color),
      contains(red.light.scale.step(9)),
    );
    expect(
      active.map((shadow) => shadow.color),
      contains(red.light.scale.step(9)),
    );
    expect(
      normalHighContrast.map((shadow) => shadow.color),
      contains(red.light.scale.step(12)),
    );
    expect(
      activeHighContrast.map((shadow) => shadow.color),
      contains(red.light.scale.step(12)),
    );
  });
}

Widget _fortalApp(Widget child) {
  return FortalScope(
    child: MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void _expectPanelSurface({
  required WidgetTester tester,
  required Finder finder,
  required RemixSurfaceLayerSpec surface,
  required Color? color,
  required Radius radius,
  List<RemixPaintShadow> shadows = const [],
  required double blur,
}) {
  expect(surface.color, color);
  expect(surface.borderRadius, BorderRadius.all(radius));
  expect(surface.shadows, shadows);
  expect(surface.backdropBlur, blur);
  expect(
    find.descendant(of: finder, matching: find.byType(BackdropFilter)),
    blur > 0 ? findsOneWidget : findsNothing,
  );
}

void _expectPanelGradient(RemixSurfaceLayerSpec surface, Color color) {
  expect(surface.gradientInsets, const [1]);
  expect(surface.gradients, hasLength(1));
  final gradient = surface.gradients.single as LinearGradient;
  expect(gradient.colors, [color, color]);
}
