import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

const _accent = ColorToken('test.toast.accent');

/// A bare WidgetsApp host: no Material, Scaffold, or Navigator.
Widget _host(Widget child, {Color accent = const Color(0xFF3E63DD)}) {
  return MixScope(
    tokens: {_accent: accent},
    child: WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (context, _) => Overlay.wrap(child: child),
    ),
  );
}

RemixToastController _controller() {
  final controller = RemixToastController();
  addTearDown(controller.dispose);

  return controller;
}

Widget _scope(
  RemixToastController controller, {
  ToastStyler style = const ToastStyler.create(),
}) {
  return RemixToastScope(
    controller: controller,
    style: style,
    child: const SizedBox.expand(),
  );
}

void main() {
  group('RemixToastScope', () {
    testWidgets('shows a toast through the nearest scope', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        _host(
          RemixToastScope(
            child: Builder(
              builder: (inner) {
                context = inner;

                return const SizedBox.expand();
              },
            ),
          ),
        ),
      );

      final handle = showRemixToast(
        context,
        const RemixToastData(title: 'Draft saved'),
      );
      await tester.pump();

      expect(find.text('Draft saved'), findsOneWidget);
      expect(find.byType(RemixToast), findsOneWidget);
      expect(handle.isClosed, isFalse);

      await tester.pump(const Duration(seconds: 4));
      expect(await handle.closed, RemixToastDismissReason.timeout);
    });

    testWidgets('explains a missing scope', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        _host(
          Builder(
            builder: (inner) {
              context = inner;

              return const SizedBox.expand();
            },
          ),
        ),
      );

      expect(
        () => showRemixToast(context, const RemixToastData(title: 'Saved')),
        throwsA(
          isA<FlutterError>().having(
            (error) => error.toString(),
            'message',
            allOf(contains('RemixToastScope'), contains('No Scaffold')),
          ),
        ),
      );
    });

    testWidgets('keeps Mix tokens live through the overlay portal', (
      tester,
    ) async {
      final controller = _controller();
      final style = ToastStyler().title(TextStyler().color(_accent()));
      await tester.pumpWidget(_host(_scope(controller, style: style)));
      controller.showToast(const RemixToastData(title: 'Draft saved'));
      await tester.pump();

      Color? titleColor() =>
          tester.widget<Text>(find.text('Draft saved')).style?.color;
      expect(titleColor(), const Color(0xFF3E63DD));

      await tester.pumpWidget(
        _host(
          _scope(controller, style: style),
          accent: const Color(0xFFE5484D),
        ),
      );
      expect(titleColor(), const Color(0xFFE5484D));
    });

    testWidgets('merges per-toast style over the scope style', (tester) async {
      final controller = _controller();
      await tester.pumpWidget(
        _host(
          _scope(
            controller,
            style: ToastStyler().title(
              TextStyler().color(const Color(0xFF111111)).fontSize(14),
            ),
          ),
        ),
      );
      controller.showToast(
        RemixToastData(
          title: 'Failed',
          style: ToastStyler().title(
            TextStyler().color(const Color(0xFFE5484D)),
          ),
        ),
      );
      await tester.pump();

      final style = tester.widget<Text>(find.text('Failed')).style!;
      expect(style.color, const Color(0xFFE5484D));
      expect(style.fontSize, 14);
    });

    testWidgets('dismisses with action after the callback, even if it throws', (
      tester,
    ) async {
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));
      final handle = controller.showToast(
        RemixToastData(
          title: 'Deleted',
          action: RemixToastAction(
            label: 'Undo',
            onPressed: () => throw StateError('undo failed'),
          ),
        ),
      );
      // The entrance slide briefly moves the lower edge outside the stack, so
      // tap once it settles, as a user would.
      await tester.pumpAndSettle();

      await tester.tap(find.text('Undo'));
      expect(tester.takeException(), isStateError);
      expect(handle.isClosed, isTrue);
      expect(await handle.closed, RemixToastDismissReason.action);
    });

    testWidgets('the close button dismisses with close', (tester) async {
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));
      final handle = controller.showToast(
        const RemixToastData(title: 'Saved', duration: null),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RemixIconButton));
      expect(handle.isClosed, isTrue);
      expect(await handle.closed, RemixToastDismissReason.close);
    });

    testWidgets('omits the close button when asked', (tester) async {
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));
      controller.showToast(
        const RemixToastData(title: 'Saved', showCloseButton: false),
      );
      await tester.pump();

      expect(find.byType(RemixIconButton), findsNothing);
    });

    testWidgets('rejects blank text and undismissable persistent toasts', (
      tester,
    ) async {
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));

      for (final toast in [
        const RemixToastData(title: ' '),
        const RemixToastData(title: 'Saved', description: ''),
        const RemixToastData(title: 'Saved', semanticLabel: '  '),
        RemixToastData(
          title: 'Saved',
          action: RemixToastAction(label: '', onPressed: () {}),
        ),
        const RemixToastData(
          title: 'Saved',
          duration: null,
          showCloseButton: false,
        ),
      ]) {
        expect(() => controller.showToast(toast), throwsArgumentError);
      }
      expect(controller.visibleCount, 0);
    });

    testWidgets('rejects a blank dismiss label', (tester) async {
      await tester.pumpWidget(
        _host(
          const RemixToastScope(dismissLabel: ' ', child: SizedBox.expand()),
        ),
      );

      expect(tester.takeException(), isArgumentError);
    });
  });

  group('RemixToastScope semantics', () {
    testWidgets('announces title and description once as a status', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));
      controller.showToast(
        RemixToastData(
          title: 'Draft saved',
          description: 'Stored on this device.',
          action: RemixToastAction(label: 'Undo', onPressed: () {}),
        ),
      );
      await tester.pump();

      final node = tester.getSemantics(
        find.bySemanticsLabel('Draft saved\nStored on this device.'),
      );
      expect(node.getSemanticsData().role, SemanticsRole.status);
      expect(find.semantics.byLabel('Draft saved'), findsNothing);
      expect(find.semantics.byLabel('Undo'), findsOne);
      expect(find.semantics.byLabel('Dismiss notification'), findsOne);
      semantics.dispose();
    });

    testWidgets('uses the alert role for assertive toasts', (tester) async {
      final semantics = tester.ensureSemantics();
      final controller = _controller();
      await tester.pumpWidget(_host(_scope(controller)));
      controller.showToast(
        const RemixToastData(
          title: 'Upload failed',
          semanticLabel: 'Upload failed. Check your connection.',
          priority: RemixToastPriority.assertive,
        ),
      );
      await tester.pump();

      final node = tester.getSemantics(
        find.bySemanticsLabel('Upload failed. Check your connection.'),
      );
      expect(node.getSemanticsData().role, SemanticsRole.alert);
      semantics.dispose();
    });
  });
}
