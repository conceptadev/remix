import 'dart:async';

import 'package:dashboard/main.dart';
import 'package:dashboard/shell/dashboard_shell.dart';
import 'package:dashboard/theme/theme_scope.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('visible toast follows live Fortal theme changes', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showRemixToast(
      context,
      const RemixToastData(title: 'Saved', icon: Icons.check_circle_outline),
    );
    await _settle(tester);

    final before = tester
        .widget<Icon>(find.byIcon(Icons.check_circle_outline))
        .color;

    final themeScope = tester.widget<ThemeScope>(find.byType(ThemeScope));
    themeScope.onChanged(
      themeScope.settings.copyWith(accentColor: FortalAccentColor.green),
    );
    await tester.pump();

    final after = tester
        .widget<Icon>(find.byIcon(Icons.check_circle_outline))
        .color;
    final expected = MixScope.tokenOf(
      FortalTokens.accent11,
      tester.element(find.byType(DashboardShell)),
    );

    expect(after, isNot(before));
    expect(after, expected);

    // Let the toast's own dismissal timer and exit transition run out
    // rather than leaving them pending past the end of the test.
    await tester.pump(const Duration(seconds: 4));
    await _settle(tester);
  });

  testWidgets('toast action invokes its callback and dismisses the toast', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);
    var actionCount = 0;

    showRemixToast(
      context,
      RemixToastData(
        title: 'Customer archived',
        icon: Icons.check_circle_outline,
        action: RemixToastAction(label: 'Undo', onPressed: () => actionCount++),
      ),
    );
    await _settle(tester);

    await tester.tap(find.text('Undo'));
    await _settle(tester);

    expect(actionCount, 1);
    expect(find.text('Customer archived'), findsNothing);
  });

  testWidgets('toast dismisses automatically after four seconds', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showRemixToast(
      context,
      const RemixToastData(title: 'Saved', icon: Icons.check_circle_outline),
    );
    await _settle(tester);

    expect(find.text('Saved'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 3999));
    expect(find.text('Saved'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1));
    // The timeout fires here; let the exit transition finish removing it.
    await _settle(tester);
    expect(find.text('Saved'), findsNothing);
  });

  testWidgets('two concurrent toasts stack instead of overlapping', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showRemixToast(
      context,
      const RemixToastData(
        title: 'First toast',
        icon: Icons.check_circle_outline,
      ),
    );
    showRemixToast(
      context,
      const RemixToastData(
        title: 'Second toast',
        icon: Icons.check_circle_outline,
      ),
    );
    await _settle(tester);

    final firstRect = tester.getRect(find.text('First toast'));
    final secondRect = tester.getRect(find.text('Second toast'));

    expect(firstRect.top, isNot(secondRect.top));
    expect(firstRect.overlaps(secondRect), isFalse);

    // Let both toasts' dismissal timers and exit transitions run out rather
    // than leaving them pending past the end of the test.
    await tester.pump(const Duration(seconds: 4));
    await _settle(tester);
  });

  testWidgets('toast shows from inside a dialog route', (tester) async {
    final context = await _pumpDashboard(tester);
    late BuildContext dialogContext;
    unawaited(
      showRemixDialog<void>(
        context: context,
        barrierLabel: 'Dismiss',
        builder: (context) {
          dialogContext = context;
          return const FortalDialog(
            title: 'Invite teammates',
            description: 'Share this workspace with your collaborators.',
          );
        },
      ),
    );
    await _settle(tester);

    // Dialog routes are siblings of `home` in the Navigator's Overlay, so
    // this only works when the scope sits above the Navigator.
    showRemixToast(
      dialogContext,
      const RemixToastData(
        title: 'Invite sent',
        icon: Icons.check_circle_outline,
      ),
    );
    await _settle(tester);

    expect(find.text('Invite sent'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await _settle(tester);
  });

  testWidgets('toast text resolves against the Fortal root, not a fallback', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showRemixToast(
      context,
      const RemixToastData(title: 'Saved', icon: Icons.check_circle_outline),
    );
    await _settle(tester);

    // Text outside a styled subtree inherits Flutter's "put your text in a
    // Material" fallback: red, monospace, with a yellow double underline.
    final style = tester
        .renderObject<RenderParagraph>(find.text('Saved'))
        .text
        .style!;

    expect(style.decoration, anyOf(isNull, TextDecoration.none));
    expect(style.fontFamily, isNot('monospace'));
    expect(style.color, MixScope.tokenOf(FortalTokens.gray12, context));

    await tester.pump(const Duration(seconds: 4));
    await _settle(tester);
  });
}

Future<BuildContext> _pumpDashboard(WidgetTester tester) async {
  await tester.pumpWidget(
    const DashboardApp(
      initialSettings: ThemeSettings(
        appearance: ThemeMode.light,
        accentColor: FortalAccentColor.blue,
      ),
    ),
  );
  return tester.element(find.byType(DashboardShell));
}

/// Advances past the toast entrance/exit transitions (180ms / 120ms) without
/// `pumpAndSettle()`, which never completes on the full [DashboardApp]: the
/// gallery display page's `FortalSkeleton` keeps a `repeat(reverse: true)`
/// shimmer animation running even while offstage in the shell's
/// `IndexedStack`.
Future<void> _settle(WidgetTester tester) async {
  for (var frame = 0; frame < 5; frame++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
