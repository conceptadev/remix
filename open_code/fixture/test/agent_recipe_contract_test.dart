import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_code_fixture/ui/ui.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('answer copy control resolves its own hover override', (
    tester,
  ) async {
    const idle = Color(0xFF123456);
    const hovered = Color(0xFFABCDEF);
    final recipe = acmeAgentAnswerRecipe(
      copyStyle: IconButtonStyler()
          .color(idle)
          .onHovered(IconButtonStyler().color(hovered)),
    );
    final answer = AcmeAnswer(
      status: AcmeAnswerStatus.complete,
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      copyStyle: recipe.copyStyle,
      onCopy: () {},
      child: const Text('Local answer'),
    );
    await tester.pumpWidget(
      WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (_, _) =>
            AcmeThemeScope(data: const AcmeThemeData.light(), child: answer),
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
    final recipe = acmeAgentComposerRecipe(
      style: AcmeComposerStyler(toolbar: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.toolbar.spec.flex?.spec.spacing, 37);
  });
  testWidgets('message recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentMessageRecipe(
      style: AcmeMessageStyler(maxWidth: 37),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.maxWidth, 37);
  });
  testWidgets('answer recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentAnswerRecipe(
      style: AcmeAnswerStyler(actions: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.actions.spec.flex?.spec.spacing, 37);
  });
  testWidgets('execution recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentExecutionRecipe(
      style: AcmeExecutionStyler(header: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.header.spec.flex?.spec.spacing, 37);
  });
  testWidgets('permission recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentPermissionRecipe(
      style: AcmePermissionStyler(actions: FlexBoxStyler().spacing(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.actions.spec.flex?.spec.spacing, 37);
  });
  testWidgets('plan recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentPlanRecipe(
      style: AcmePlanStyler(viewport: BoxStyler().maxHeight(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.viewport.spec.constraints?.maxHeight, 37);
  });
  testWidgets('activity recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentActivityRecipe(
      style: AcmeActivityStyler(viewport: BoxStyler().maxHeight(37)),
    );
    final result = await _resolve(tester, recipe.style);
    expect(result.spec.viewport.spec.constraints?.maxHeight, 37);
  });
  testWidgets('transcript recipe preserves the caller surface override', (
    tester,
  ) async {
    final recipe = acmeAgentTranscriptRecipe(
      style: AcmeTranscriptStyler(spacing: 37),
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
      builder: (_, _) =>
          AcmeThemeScope(data: const AcmeThemeData.light(), child: child),
    ),
  );
  return result;
}
