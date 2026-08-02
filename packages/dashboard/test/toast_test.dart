import 'package:dashboard/main.dart';
import 'package:dashboard/shell/dashboard_shell.dart';
import 'package:dashboard/theme/theme_scope.dart';
import 'package:dashboard/theme/theme_settings.dart';
import 'package:dashboard/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('visible toast follows live Fortal theme changes', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showToast(context, message: 'Saved');
    await tester.pump();

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

    await tester.pump(const Duration(seconds: 4));

    expect(after, isNot(before));
    expect(after, expected);
  });

  testWidgets('toast action invokes its callback and dismisses the toast', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);
    var actionCount = 0;

    showToast(
      context,
      message: 'Customer archived',
      actionLabel: 'Undo',
      onAction: () => actionCount++,
    );
    await tester.pump();

    await tester.tap(find.text('Undo'));
    await tester.pump();

    expect(actionCount, 1);
    expect(find.text('Customer archived'), findsNothing);

    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('toast dismisses automatically after four seconds', (
    tester,
  ) async {
    final context = await _pumpDashboard(tester);

    showToast(context, message: 'Saved');
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 3999));
    expect(find.text('Saved'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('Saved'), findsNothing);
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
