import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixDialog layout contract', () {
    test('styler call forwards dimensions and alignment', () {
      final styler = RemixDialogStyler();
      final dialog = styler(
        title: 'Settings',
        alignment: RemixDialogAlignment.start,
        width: 320,
        minWidth: 240,
        maxWidth: 480,
        height: 200,
        minHeight: 120,
        maxHeight: 360,
        insetPadding: const EdgeInsets.all(24),
      );

      expect(dialog.style, same(styler));
      expect(dialog.alignment, RemixDialogAlignment.start);
      expect(dialog.width, 320);
      expect(dialog.minWidth, 240);
      expect(dialog.maxWidth, 480);
      expect(dialog.height, 200);
      expect(dialog.minHeight, 120);
      expect(dialog.maxHeight, 360);
      expect(dialog.insetPadding, const EdgeInsets.all(24));
    });

    testWidgets('applies exact dimensions', (tester) async {
      await tester.pumpRemixApp(
        const RemixDialog(title: 'Settings', width: 320, height: 200),
      );

      expect(
        tester.getSize(find.byKey(const ValueKey('remix-dialog-surface'))),
        const Size(320, 200),
      );
    });

    testWidgets('scrolls structured content inside a fixed height', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            height: 600,
            child: RemixDialog(
              alignment: RemixDialogAlignment.start,
              width: 320,
              height: 200,
              title: 'Settings',
              child: SizedBox(
                key: ValueKey('fixed-height-content'),
                height: 600,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final innerScroll = find.descendant(
        of: find.byKey(const ValueKey('remix-dialog-surface')),
        matching: find.byType(SingleChildScrollView),
      );
      expect(innerScroll, findsOneWidget);

      final before = tester.getTopLeft(
        find.byKey(const ValueKey('fixed-height-content')),
      );
      await tester.drag(innerScroll, const Offset(0, -200));
      await tester.pump();
      expect(
        tester
            .getTopLeft(find.byKey(const ValueKey('fixed-height-content')))
            .dy,
        lessThan(before.dy),
      );
    });

    testWidgets('clamps full width to maxWidth', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            height: 600,
            child: RemixDialog(
              title: 'Settings',
              width: double.infinity,
              maxWidth: 600,
            ),
          ),
        ),
      );

      expect(
        tester
            .getSize(find.byKey(const ValueKey('remix-dialog-surface')))
            .width,
        600,
      );
    });

    testWidgets('supports start and center viewport alignment', (tester) async {
      Future<double> pumpAlignment(RemixDialogAlignment alignment) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 800,
              height: 600,
              child: RemixDialog(
                title: 'Settings',
                alignment: alignment,
                width: 320,
                height: 200,
              ),
            ),
          ),
        );
        return tester
            .getTopLeft(find.byKey(const ValueKey('remix-dialog-surface')))
            .dy;
      }

      final startY = await pumpAlignment(RemixDialogAlignment.start);
      final centerY = await pumpAlignment(RemixDialogAlignment.center);

      expect(startY, 0);
      expect(centerY, 200);
    });

    testWidgets('scrolls content taller than the inset viewport', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            height: 600,
            child: RemixDialog(
              alignment: RemixDialogAlignment.start,
              insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: SizedBox(
                key: ValueKey('tall-content'),
                width: 320,
                height: 800,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(
        tester
            .getTopLeft(find.byKey(const ValueKey('remix-dialog-surface')))
            .dy,
        32,
      );

      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -200),
      );
      await tester.pump();
      expect(
        tester
            .getTopLeft(find.byKey(const ValueKey('remix-dialog-surface')))
            .dy,
        lessThan(32),
      );
    });
  });

  group('FortalDialog 3.3.0 contract', () {
    test('defaults to size 3, centered, full width up to 600', () {
      const dialog = FortalDialog(title: 'Settings');

      expect(dialog.size, FortalDialogSize.size3);
      expect(dialog.align, FortalDialogAlign.center);
      expect(dialog.width, double.infinity);
      expect(dialog.maxWidth, 600);
    });

    testWidgets('resolves the exact size padding and radius matrix', (
      tester,
    ) async {
      final paddings = <FortalDialogSize, EdgeInsetsGeometry?>{};
      final radii = <FortalDialogSize, BorderRadiusGeometry>{};

      await tester.pumpRemixApp(
        Builder(
          builder: (context) {
            for (final size in FortalDialogSize.values) {
              final spec = fortalDialogStyler(size: size).resolve(context).spec;
              paddings[size] = spec.container.spec.padding;
              radii[size] = (spec.container.spec.decoration! as BoxDecoration)
                  .borderRadius!;
            }
            return const SizedBox.shrink();
          },
        ),
      );

      expect(paddings, <FortalDialogSize, EdgeInsetsGeometry>{
        FortalDialogSize.size1: const EdgeInsets.all(12),
        FortalDialogSize.size2: const EdgeInsets.all(16),
        FortalDialogSize.size3: const EdgeInsets.all(24),
        FortalDialogSize.size4: const EdgeInsets.all(32),
      });
      expect(radii, <FortalDialogSize, BorderRadiusGeometry>{
        FortalDialogSize.size1: BorderRadius.circular(8),
        FortalDialogSize.size2: BorderRadius.circular(8),
        FortalDialogSize.size3: BorderRadius.circular(12),
        FortalDialogSize.size4: BorderRadius.circular(12),
      });
    });

    testWidgets('forwards official geometry without a component override', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const FortalDialog(
          title: 'Settings',
          size: FortalDialogSize.size1,
          align: FortalDialogAlign.start,
          width: 300,
          minHeight: 120,
          maxHeight: 360,
        ),
      );

      final dialog = tester.widget<RemixDialog>(find.byType(RemixDialog));
      expect(dialog.alignment, RemixDialogAlignment.start);
      expect(dialog.width, 300);
      expect(dialog.maxWidth, 600);
      expect(dialog.minHeight, 120);
      expect(dialog.maxHeight, 360);
      expect(dialog.insetPadding, const EdgeInsets.fromLTRB(16, 32, 16, 36));
    });
  });
}
