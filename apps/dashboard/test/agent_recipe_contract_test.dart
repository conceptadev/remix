import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:dashboard/ui/ui.dart';

void main() {
  testWidgets('answer copy control resolves its own hover override', (
    tester,
  ) async {
    const idle = Color(0xFF123456);
    const hovered = Color(0xFFABCDEF);
    final recipe = uiAgentAnswerRecipe(
      copyStyle: IconButtonStyler()
          .color(idle)
          .onHovered(IconButtonStyler().color(hovered)),
    );
    final answer = UiAnswer(
      status: UiAnswerStatus.complete,
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      copyStyle: recipe.copyStyle,
      onCopy: () {},
      child: const Text('Local answer'),
    );
    await tester.pumpWidget(
      WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (_, _) => UiScope(child: answer),
      ),
    );
    final copy = find.byWidgetPredicate(
      (widget) =>
          widget is RemixIconButton && widget.semanticLabel == 'Copy answer',
    );
    Iterable<Color?> colors() => tester
        .widgetList<DecoratedBox>(
          find.descendant(of: copy, matching: find.byType(DecoratedBox)),
        )
        .map(
          (box) => box.decoration is BoxDecoration
              ? (box.decoration as BoxDecoration).color
              : null,
        );
    expect(colors(), contains(idle));
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: Offset.zero);
    await mouse.moveTo(tester.getCenter(copy));
    await tester.pumpAndSettle();
    expect(colors(), contains(hovered));
    expect(colors(), isNot(contains(idle)));
  });

  testWidgets('composer recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentComposerRecipe(
      style: UiComposerStyler(toolbar: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.toolbar.spec.flex?.spec.spacing, 37);
  });
  testWidgets('message recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentMessageRecipe(style: UiMessageStyler(maxWidth: 37));
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.maxWidth, 37);
  });
  testWidgets('answer recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentAnswerRecipe(
      style: UiAnswerStyler(actions: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.actions.spec.flex?.spec.spacing, 37);
  });
  testWidgets('execution recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentExecutionRecipe(
      style: UiExecutionStyler(header: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.header.spec.flex?.spec.spacing, 37);
  });
  testWidgets('permission recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentPermissionRecipe(
      style: UiPermissionStyler(actions: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.actions.spec.flex?.spec.spacing, 37);
  });
  testWidgets('plan recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentPlanRecipe(
      style: UiPlanStyler(viewport: BoxStyler().maxHeight(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.viewport.spec.constraints?.maxHeight, 37);
  });
  testWidgets('activity recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentActivityRecipe(
      style: UiActivityStyler(viewport: BoxStyler().maxHeight(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.viewport.spec.constraints?.maxHeight, 37);
  });
  testWidgets('transcript recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = uiAgentTranscriptRecipe(
      style: UiTranscriptStyler(spacing: 37),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.spacing, 37);
  });
}

Future<StyleSpec<S>> _resolve<S extends Spec<S>>(
  WidgetTester tester,
  Style<S> style,
) async {
  late StyleSpec<S> result;
  final child = Builder(
    builder: (context) {
      result = style.build(context);
      return const SizedBox.shrink();
    },
  );
  await tester.pumpWidget(
    WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (_, _) => UiScope(child: child),
    ),
  );
  return result;
}
