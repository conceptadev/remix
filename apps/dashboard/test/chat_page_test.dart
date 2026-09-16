import 'package:dashboard/main.dart';
import 'package:dashboard/pages/chat_page.dart';
import 'package:dashboard/theme/theme_scope.dart';
import 'package:dashboard/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets(
    'focused composer stays above the keyboard and restores its layout',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1280, 844);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const DashboardApp());
      await tester.tap(find.text('Chat').first);
      await tester.pump();
      tester.view.physicalSize = const Size(430, 844);
      await tester.pump();
      final field = find.descendant(
        of: find.byType(UiComposer),
        matching: find.byType(EditableText),
      );
      await tester.enterText(field, 'A mobile draft');
      await tester.pump();
      final bottom = tester.getRect(find.byType(UiComposer)).bottom;
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      await tester.pump();
      await tester.pump();
      expect(tester.widget<EditableText>(field).focusNode.hasFocus, isTrue);
      expect(tester.getRect(field).bottom, lessThanOrEqualTo(544));
      expect(
        tester.getRect(find.byType(UiComposer)).bottom,
        lessThanOrEqualTo(544),
      );
      expect(tester.takeException(), isNull);
      tester.view.viewInsets = const FakeViewPadding();
      await tester.pump();
      expect(
        tester.getRect(find.byType(UiComposer)).bottom,
        closeTo(bottom, 0.1),
      );
      expect(
        tester.widget<EditableText>(field).controller.text,
        'A mobile draft',
      );
    },
  );

  testWidgets('New chat clears an unsent draft and accepts a fresh message', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    final field = find.descendant(
      of: find.byType(UiComposer),
      matching: find.byType(EditableText),
    );
    await tester.enterText(field, 'Old unsent draft');
    await tester.tap(find.text('New chat'));
    await tester.pump();
    expect(tester.widget<EditableText>(field).controller.text, isEmpty);
    await tester.enterText(field, 'Fresh conversation');
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(find.text('Fresh conversation'), findsOneWidget);
    expect(find.text('Old unsent draft'), findsNothing);
    await tester.tap(find.text('New chat'));
    await tester.pump();
  });

  testWidgets('copy matches the visible stopped answer and execution output', (
    tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.tap(find.bySemanticsLabel('Stop'));
    await tester.pump();
    await tester.pump();
    final copy = find.bySemanticsLabel('Copy answer');
    await tester.ensureVisible(copy);
    await tester.tap(copy);
    await tester.pump();
    expect(copied, 'Stopped before running the tool. No tool ran.');
    await tester.tap(find.text('Review checkout'));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 350));
    }
    await tester.scrollUntilVisible(
      find.text('Focused checks'),
      -200,
      scrollable: find
          .descendant(
            of: find.byType(UiTranscript),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.tap(find.text('Focused checks'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    final copyOutput = find.byWidgetPredicate(
      (w) => w is RemixIconButton && w.semanticLabel == 'Copy output',
    );
    await tester.ensureVisible(copyOutput);
    await tester.tap(copyOutput);
    await tester.pump();
    expect(
      copied,
      '\$ flutter test\nI inspected the checkout flow. The cart state is shared correctly, and the focused checks pass. The flow is ready for review.',
    );
  });

  testWidgets('return to latest does not animate with reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Review checkout'));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 350));
    }
    await tester.pump();
    final transcript = find.byType(UiTranscript);
    final scrollable = find
        .descendant(of: transcript, matching: find.byType(Scrollable))
        .first;
    final position = tester.state<ScrollableState>(scrollable).position;
    expect(position.maxScrollExtent, greaterThan(0));
    await tester.drag(transcript, const Offset(0, 300));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Return to latest'));
    expect(position.isScrollingNotifier.value, isFalse);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('retry after denial preserves the permission scenario', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    final firstRequest = tester
        .widget<UiPermission>(find.byType(UiPermission))
        .requestId;
    await tester.tap(find.text('Deny'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    final retry = find.byWidgetPredicate(
      (widget) =>
          widget is RemixIconButton && widget.semanticLabel == 'Retry answer',
    );
    await tester.ensureVisible(retry);
    await tester.tap(retry);
    await tester.pump(const Duration(milliseconds: 350));
    final permission = tester.widget<UiPermission>(find.byType(UiPermission));
    expect(permission.status, UiPermissionStatus.pending);
    expect(permission.requestId, isNot(firstRequest));
    expect(find.byType(UiExecution), findsNothing);
  });

  testWidgets('responsive breakpoint changes preserve pending permission', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    final requestId = tester
        .widget<UiPermission>(find.byType(UiPermission))
        .requestId;
    for (final width in [390.0, 1280.0]) {
      tester.view.physicalSize = Size(width, 900);
      await tester.pump();
      await tester.pump();
      final permission = tester.widget<UiPermission>(find.byType(UiPermission));
      expect(permission.requestId, requestId);
      expect(permission.status, UiPermissionStatus.pending);
      expect(tester.takeException(), isNull);
    }
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    tester.view.physicalSize = const Size(390, 900);
    await tester.pump();
    await tester.pump();
    expect(
      tester.widget<UiPermission>(find.byType(UiPermission)).requestId,
      requestId,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('live theme changes preserve the paused conversation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    final requestId = tester
        .widget<UiPermission>(find.byType(UiPermission))
        .requestId;
    final theme = ThemeScope.of(tester.element(find.byType(ChatPage)));
    theme.onChanged(
      theme.settings.copyWith(
        appearance: ThemeMode.dark,
        accentColor: .jade,
        grayColor: .sage,
        panelBackground: .translucent,
        radius: .large,
        scaling: .percent110,
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    final scope = tester.widget<UiScope>(find.byType(UiScope));
    expect(scope.brightness, Brightness.dark);
    expect(scope.accent, UiAccentColor.jade);
    expect(scope.gray, UiGrayColor.sage);
    expect(scope.panelBackground, UiPanelBackground.translucent);
    expect(scope.radius, UiRadius.large);
    expect(scope.scaling, UiScaling.percent110);
    final permission = tester.widget<UiPermission>(find.byType(UiPermission));
    expect(permission.requestId, requestId);
    expect(permission.status, UiPermissionStatus.pending);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Stop works during permission and reset cancels pending work', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    final stop = find.byWidgetPredicate(
      (widget) => widget is RemixIconButton && widget.semanticLabel == 'Stop',
    );
    await tester.tap(stop);
    await tester.pump();
    // The transcript follows the newly inserted stopped outcome after layout.
    await tester.pump();
    expect(
      find.text('Stopped before running the tool. No tool ran.'),
      findsOneWidget,
    );
    expect(find.byType(UiExecution), findsNothing);
    expect(find.byType(UiPermission), findsNothing);
    await tester.tap(find.text('New chat'));
    await tester.pump();
    await tester.tap(find.text('Review checkout'));
    await tester.pump();
    await tester.tap(find.text('New chat'));
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Choose a starter or write a message.'), findsOneWidget);
    expect(find.textContaining('I inspected'), findsNothing);
  });

  testWidgets('chat runs permission flow and survives dashboard navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();

    expect(find.text('Interactive demo'), findsOneWidget);
    await tester.tap(find.text('Run terminal checks'));
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Allow once'), findsOneWidget);
    final stopButton = tester.widget<RemixIconButton>(
      find.byWidgetPredicate(
        (widget) => widget is RemixIconButton && widget.semanticLabel == 'Stop',
      ),
    );
    expect(stopButton.enabled, isTrue);
    expect(stopButton.onPressed, isNotNull);

    await tester.tap(find.text('Allow once'));
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.textContaining('I inspected'), findsWidgets);

    await tester.tap(find.text('Overview').first);
    await tester.pump();
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    expect(find.text('Agent chat'), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.pump(const Duration(milliseconds: 350));
    }
    expect(find.textContaining('ready for review'), findsWidgets);
  });

  testWidgets('chat failure can retry through a fresh successful attempt', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const DashboardApp());
    await tester.tap(find.text('Chat').first);
    await tester.pump();
    await tester.tap(find.text('Recover a failed command'));
    for (var i = 0; i < 3; i++) {
      await tester.pump(const Duration(milliseconds: 350));
    }

    expect(find.textContaining('simulated command failed'), findsWidgets);
    // Following runs after layout; let the lazy transcript build its new tail.
    await tester.pump();
    final retry = find.byWidgetPredicate(
      (widget) =>
          widget is RemixIconButton && widget.semanticLabel == 'Retry answer',
    );
    expect(retry, findsOneWidget);
    await tester.ensureVisible(retry);
    await tester.tap(retry);
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 350));
    }
    expect(find.textContaining('ready for review'), findsWidgets);
  });
}
