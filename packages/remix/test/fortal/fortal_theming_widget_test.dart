import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('FortalCard resolves translucent and solid panel surfaces', (
    tester,
  ) async {
    final translucent = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalCardStyler().build(context).spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanel, context),
        radius: MixScope.tokenOf(FortalTokens.radius4, context),
      ),
    );
    final solid = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalCardStyler().build(context).spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanelSolid, context),
        radius: MixScope.tokenOf(FortalTokens.radius4, context),
      ),
      panelBackground: .solid,
    );

    _expectPanelRecipe(
      container: translucent.spec.container.spec,
      containerEffects: translucent.spec.containerEffects!,
      color: translucent.panel,
      radius: translucent.radius,
      blur: 64,
    );
    _expectPanelRecipe(
      container: solid.spec.container.spec,
      containerEffects: solid.spec.containerEffects!,
      color: solid.panel,
      radius: solid.radius,
      blur: 0,
    );
  });

  testWidgets('Fortal transient surfaces resolve exact panel recipes', (
    tester,
  ) async {
    final menu = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalMenuStyler().build(context).spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanel, context),
        radius: MixScope.tokenOf(FortalTokens.radius4, context),
        shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      ),
    );
    final select = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalSelectStyler().build(context).spec.content.spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanel, context),
        radius: MixScope.tokenOf(FortalTokens.radius4, context),
        shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      ),
    );
    final popover = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalPopoverStyler().build(context).spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanel, context),
        radius: MixScope.tokenOf(FortalTokens.radius4, context),
        shadows: MixScope.tokenOf(FortalTokens.shadow5, context),
      ),
    );
    final dialog = await _resolveFortal(
      tester,
      (context) => (
        spec: fortalDialogStyler().build(context).spec,
        panel: MixScope.tokenOf(FortalTokens.colorPanel, context),
        radius: MixScope.tokenOf(FortalTokens.radius5, context),
        shadows: MixScope.tokenOf(FortalTokens.shadow6, context),
      ),
    );

    _expectPanelRecipe(
      container: menu.spec.overlay.spec.box!.spec,
      containerEffects: menu.spec.containerEffects!,
      color: menu.panel,
      radius: menu.radius,
      shadows: menu.shadows,
      blur: 64,
    );
    _expectPanelRecipe(
      container: select.spec.container.spec,
      containerEffects: select.spec.containerEffects!,
      color: select.panel,
      radius: select.radius,
      shadows: select.shadows,
      blur: 64,
    );
    _expectPanelRecipe(
      container: popover.spec.container.spec,
      containerEffects: popover.spec.containerEffects!,
      color: popover.panel,
      radius: popover.radius,
      shadows: popover.shadows,
      blur: 64,
    );
    _expectPanelRecipe(
      container: dialog.spec.container.spec,
      containerEffects: dialog.spec.containerEffects!,
      color: dialog.panel,
      radius: dialog.radius,
      shadows: dialog.shadows,
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

    final decorations = tester
        .widgetList<DecoratedBox>(find.byType(DecoratedBox))
        .map((box) => box.decoration)
        .whereType<BoxDecoration>();
    expect(
      decorations.map((decoration) => decoration.borderRadius),
      contains(const BorderRadius.all(Radius.circular(0.5))),
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

void _expectPanelRecipe({
  required BoxSpec container,
  required RemixBoxEffectsSpec containerEffects,
  required Color color,
  required Radius radius,
  List<BoxShadow> shadows = const [],
  required double blur,
}) {
  final decoration = container.decoration! as BoxDecoration;
  if (decoration.color == null) {
    expect(containerEffects.behindContent!.gradients, isNotEmpty);
    expect(
      containerEffects.behindContent!.gradients.first.colors,
      everyElement(color),
    );
  } else {
    expect(decoration.color, color);
  }
  expect(decoration.borderRadius, BorderRadius.all(radius));
  expect(containerEffects.backdropBlur, blur);
  expect(decoration.boxShadow ?? const <BoxShadow>[], shadows);
}

Future<T> _resolveFortal<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve, {
  FortalPanelBackground panelBackground = .translucent,
}) async {
  late T result;
  await tester.pumpWidget(
    FortalScope(
      panelBackground: panelBackground,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            result = resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return result;
}
