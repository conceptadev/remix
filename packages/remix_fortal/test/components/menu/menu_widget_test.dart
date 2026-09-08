import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/src/utilities/remix_path_icon.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../../helpers/test_helpers.dart';

void main() {
  for (final variant in FortalMenuVariant.values) {
    testWidgets(
      '${variant.name} distinguishes checked, highlighted, and submenu-open surfaces',
      (tester) async {
        final menuController = MenuController();
        final submenuController = MenuController();
        await tester.pumpRemixApp(
          FortalMenu<String>(
            variant: variant,
            controller: menuController,
            trigger: const RemixMenuTrigger(label: 'Options'),
            onSelected: (_) {},
            items: [
              const RemixMenuCheckboxItem(
                value: 'checked',
                label: 'Checked',
                checked: true,
                closeOnActivate: false,
              ),
              const RemixMenuRadioGroup(
                value: 'compact',
                items: [
                  RemixMenuRadioItem(
                    value: 'compact',
                    label: 'Compact',
                    closeOnActivate: false,
                  ),
                  RemixMenuRadioItem(
                    value: 'comfortable',
                    label: 'Comfortable',
                    closeOnActivate: false,
                  ),
                ],
              ),
              RemixMenuSubmenu(
                controller: submenuController,
                label: 'More',
                items: const [
                  RemixMenuItem(value: 'archive', label: 'Archive'),
                ],
              ),
              const RemixMenuItem(
                value: 'locked',
                label: 'Locked',
                enabled: false,
              ),
            ],
          ),
        );

        menuController.open();
        await tester.pump();

        final context = tester.element(find.text('Checked'));
        final highlighted = switch (variant) {
          .solid => FortalTokens.accent9.resolve(context),
          .soft => FortalTokens.accentA4.resolve(context),
        };
        final submenuOpen = switch (variant) {
          .solid => FortalTokens.grayA3.resolve(context),
          .soft => FortalTokens.accentA3.resolve(context),
        };

        expect(_menuRowColor(tester, 'Checked'), isNull);
        expect(_menuRowColor(tester, 'Compact'), isNull);
        expect(_menuRowColor(tester, 'Comfortable'), isNull);
        expect(_menuRowColor(tester, 'More'), isNull);

        submenuController.open();
        await tester.pump();
        expect(_menuRowColor(tester, 'More'), submenuOpen);

        final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await mouse.addPointer(location: Offset.zero);
        addTearDown(mouse.removePointer);

        await mouse.moveTo(tester.getCenter(find.text('Checked')));
        await tester.pump();
        expect(_menuRowColor(tester, 'Checked'), highlighted);

        await mouse.moveTo(tester.getCenter(find.text('Compact')));
        await tester.pump();
        expect(_menuRowColor(tester, 'Compact'), highlighted);

        await mouse.moveTo(tester.getCenter(find.text('Comfortable')));
        await tester.pump();
        expect(_menuRowColor(tester, 'Comfortable'), highlighted);

        await mouse.moveTo(tester.getCenter(find.text('More')));
        await tester.pump();
        expect(_menuRowColor(tester, 'More'), highlighted);

        await mouse.moveTo(tester.getCenter(find.text('Locked')));
        await tester.pump();
        expect(_menuRowColor(tester, 'Locked'), Colors.transparent);
      },
    );
  }

  for (final variant in FortalMenuVariant.values) {
    for (final size in FortalMenuSize.values) {
      for (final highContrast in [false, true]) {
        testWidgets(
          '${variant.name} ${size.name} indicators follow Radix foreground states'
          '${highContrast ? ' at high contrast' : ''}',
          (tester) async {
            final controller = MenuController();
            await tester.pumpRemixApp(
              FortalMenu<String>(
                controller: controller,
                variant: variant,
                size: size,
                highContrast: highContrast,
                trigger: const RemixMenuTrigger(label: 'Options'),
                onSelected: (_) {},
                items: const [
                  RemixMenuCheckboxItem(
                    value: 'checked',
                    label: 'Checked',
                    checked: true,
                    closeOnActivate: false,
                  ),
                  RemixMenuRadioGroup(
                    value: 'compact',
                    items: [
                      RemixMenuRadioItem(
                        value: 'compact',
                        label: 'Compact',
                        closeOnActivate: false,
                      ),
                    ],
                  ),
                  RemixMenuCheckboxItem(
                    value: 'disabled',
                    label: 'Disabled',
                    checked: true,
                    enabled: false,
                  ),
                ],
              ),
            );

            controller.open();
            await tester.pump();

            IconSpec indicatorSpec(String label) => tester
                .widget<RemixPathIcon>(
                  find.byKey(ValueKey('remix-menu-indicator-$label')),
                )
                .styleSpec
                .spec;

            final context = tester.element(find.text('Checked'));
            final idleColor = FortalTokens.gray12.resolve(context);
            final disabledColor = FortalTokens.grayA8.resolve(context);
            final highlightedColor = switch (variant) {
              .solid =>
                highContrast
                    ? FortalTokens.accent1.resolve(context)
                    : FortalTokens.accentContrast.resolve(context),
              .soft => idleColor,
            };
            final expectedSize = switch (size) {
              .size1 => FortalTokens.selectIndicatorSize1.resolve(context),
              .size2 => FortalTokens.selectIndicatorSize2.resolve(context),
            };

            expect(indicatorSpec('Checked').color, idleColor);
            expect(indicatorSpec('Checked').size, expectedSize);
            expect(indicatorSpec('Compact').color, idleColor);
            expect(indicatorSpec('Compact').size, expectedSize);
            expect(indicatorSpec('Disabled').color, disabledColor);
            expect(indicatorSpec('Disabled').size, expectedSize);

            final mouse = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );
            await mouse.addPointer(location: Offset.zero);
            addTearDown(mouse.removePointer);
            await mouse.moveTo(tester.getCenter(find.text('Checked')));
            await tester.pump();

            expect(indicatorSpec('Checked').color, highlightedColor);
            expect(indicatorSpec('Checked').size, expectedSize);
          },
        );
      }
    }
  }

  for (final size in FortalMenuSize.values) {
    testWidgets('${size.name} pins the solid panel and Radix icon metrics', (
      tester,
    ) async {
      final controller = MenuController();
      await tester.pumpRemixApp(
        FortalMenu<String>(
          controller: controller,
          size: size,
          trigger: const RemixMenuTrigger(label: 'Options', icon: Icons.tune),
          onSelected: (_) {},
          items: const [
            RemixMenuItem(
              value: 'rename',
              label: 'Rename',
              leadingIcon: Icons.edit_outlined,
            ),
            RemixMenuSubmenu(
              label: 'More',
              items: [RemixMenuItem(value: 'nested', label: 'Nested')],
            ),
          ],
        ),
      );

      controller.open();
      await tester.pump();

      final context = tester.element(find.text('Rename'));
      final contentIconSize = switch (size) {
        .size1 => FortalTokens.space3.resolve(context),
        .size2 => FortalTokens.space4.resolve(context),
      };
      final subtriggerIconSize = switch (size) {
        .size1 => FortalTokens.selectIndicatorSize1.resolve(context),
        .size2 => FortalTokens.selectIndicatorSize2.resolve(context),
      };
      final triggerGap = switch (size) {
        .size1 => FortalTokens.space1.resolve(context),
        .size2 => FortalTokens.space2.resolve(context),
      };

      // Radix pins menus to the solid panel with no backdrop blur.
      final resolved = fortalMenuStyle(size: size).resolve(context).spec;
      expect(
        (resolved.overlay.spec.box?.spec.decoration as BoxDecoration?)?.color,
        FortalTokens.colorPanelSolid.resolve(context),
      );
      expect(resolved.containerEffects, isNull);

      // Content icons are text-matched; the subtrigger chevron keeps the
      // exact Radix icon size.
      expect(
        tester.getSize(find.byIcon(Icons.edit_outlined)),
        Size.square(contentIconSize),
      );
      expect(
        tester
            .widget<RemixPathIcon>(
              find.byKey(const ValueKey('remix-menu-submenu-chevron-More')),
            )
            .styleSpec
            .spec
            .size,
        subtriggerIconSize,
      );

      // The trigger content mirrors the base Radix button gap and icon.
      expect(
        tester.getSize(find.byIcon(Icons.tune)),
        Size.square(contentIconSize),
      );
      final triggerRow = tester.widget<RowBox>(
        find
            .ancestor(of: find.text('Options'), matching: find.byType(RowBox))
            .first,
      );
      expect(triggerRow.styleSpec?.spec.flex?.spec.spacing, triggerGap);
    });
  }

  testWidgets(
    'unnamed FortalMenu accepts RemixMenuTrigger.builder and keeps recipes',
    (tester) async {
      final semantics = tester.ensureSemantics();
      final controller = MenuController();
      await tester.pumpRemixApp(
        FortalMenu<String>(
          controller: controller,
          size: .size1,
          trigger: RemixMenuTrigger.builder(
            label: 'Account menu',
            builder: (context, state, child) =>
                const FortalAvatar(label: 'LF', size: .size2),
          ),
          onSelected: (_) {},
          items: const [RemixMenuItem(value: 'profile', label: 'View profile')],
        ),
      );

      expect(find.text('LF'), findsOneWidget);
      expect(find.text('Account menu'), findsNothing);
      expect(find.bySemanticsLabel('Account menu').evaluate().length, 1);
      expect(find.bySemanticsLabel('LF').evaluate().length, 0);
      semantics.dispose();

      await tester.tap(find.text('LF'));
      await tester.pump();

      expect(find.text('View profile'), findsOneWidget);

      final context = tester.element(find.text('View profile'));
      final overlay = tester.widget<Box>(
        find
            .ancestor(
              of: find
                  .ancestor(
                    of: find.text('View profile'),
                    matching: find.byType(ColumnBox),
                  )
                  .first,
              matching: find.byType(Box),
            )
            .first,
      );
      expect(
        (overlay.styleSpec?.spec.decoration as BoxDecoration?)?.color,
        FortalTokens.colorPanelSolid.resolve(context),
      );
      expect(_menuRowColor(tester, 'View profile'), isNull);

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      addTearDown(mouse.removePointer);
      await mouse.moveTo(tester.getCenter(find.text('View profile')));
      await tester.pump();
      expect(
        _menuRowColor(tester, 'View profile'),
        FortalTokens.accent9.resolve(context),
      );
    },
  );

  testWidgets(
    'FortalMenu.soft accepts RemixMenuTrigger.builder and opens items',
    (tester) async {
      await tester.pumpRemixApp(
        FortalMenu<String>.soft(
          trigger: RemixMenuTrigger.builder(
            label: 'Account menu',
            builder: (context, state, child) => const Icon(Icons.person),
          ),
          items: const [RemixMenuItem(value: 'profile', label: 'View profile')],
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pump();

      expect(find.text('View profile'), findsOneWidget);
    },
  );
}

Color? _menuRowColor(WidgetTester tester, String label) {
  final row = tester.widget<FlexBox>(
    find.ancestor(of: find.text(label), matching: find.byType(FlexBox)).first,
  );
  return (row.styleSpec?.spec.box?.spec.decoration as BoxDecoration?)?.color;
}
