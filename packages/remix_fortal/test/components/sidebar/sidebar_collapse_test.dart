import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('generated sidebar forwards AnimationStyle.noAnimation', (
    tester,
  ) async {
    bool collapsed = false;
    late StateSetter update;
    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: Align(
            alignment: Alignment.topLeft,
            child: StatefulBuilder(
              builder: (context, setState) {
                update = setState;
                return FortalSidebar<String>(
                  collapsed: collapsed,
                  expandedWidth: 256,
                  collapsedWidth: 72,
                  animationStyle: AnimationStyle.noAnimation,
                  sections: const [],
                  selectedValue: null,
                );
              },
            ),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(FortalSidebar<String>)).width, 256);
    update(() => collapsed = true);
    await tester.pump();
    expect(tester.getSize(find.byType(FortalSidebar<String>)).width, 72);
    expect(tester.binding.hasScheduledFrame, isFalse);
    update(() => collapsed = false);
    await tester.pump();
    expect(tester.getSize(find.byType(FortalSidebar<String>)).width, 256);
  });

  testWidgets(
    'collapsed preset centers icons with full targets and themed tooltips',
    (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        FortalScope(
          child: MaterialApp(
            home: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 72,
                child: FortalSidebar<String>(
                  collapsed: true,
                  selectedValue: 'home',
                  onSelected: (_) {},
                  sections: const [
                    RemixSidebarSection(
                      destinations: [
                        RemixSidebarDestination(
                          value: 'home',
                          label: 'Overview',
                          icon: Icons.home,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      final target = tester.getRect(find.bySemanticsLabel('Overview'));
      final icon = tester.getRect(find.byIcon(Icons.home));
      expect(target.width, greaterThanOrEqualTo(48));
      expect(target.height, greaterThanOrEqualTo(48));
      expect(icon.center.dx, closeTo(target.center.dx, .5));
      final node = tester.getSemantics(find.bySemanticsLabel('Overview'));
      expect(node.getSemanticsData().tooltip, isEmpty);
      expect(
        node.getSemanticsData().flagsCollection.isSelected,
        ui.Tristate.isTrue,
      );
      final gesture = await tester.createGesture(
        kind: ui.PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: const Offset(500, 500));
      await gesture.moveTo(icon.center);
      await tester.pump(const Duration(milliseconds: 201));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Overview'), findsOneWidget);
      final label = tester.widget<Text>(find.text('Overview'));
      expect(
        DefaultTextStyle.of(tester.element(find.text('Overview'))).style.color,
        isNotNull,
      );
      expect(label.data, 'Overview');
      await gesture.removePointer();
      await tester.pump(const Duration(milliseconds: 300));
      semantics.dispose();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('owned motion coordinates scaled RTL geometry and recipe tokens', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    for (final scaling in FortalScaling.values) {
      bool collapsed = false;
      late StateSetter update;
      late SidebarAnimation motion;
      late double padding;
      late double railPadding;
      late double expandedPadding;
      await tester.pumpWidget(
        FortalScope(
          scaling: scaling,
          child: MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: MediaQuery(
                data: const MediaQueryData(textScaler: TextScaler.linear(2)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 200,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        update = setState;
                        return FortalSidebar<String>(
                          key: ValueKey(scaling),
                          expandedWidth: 264 * scaling.factor + 20,
                          collapsedWidth: 80 * scaling.factor + 20,
                          collapsed: collapsed,
                          panelPadding: const EdgeInsets.fromLTRB(
                            10,
                            12,
                            10,
                            8,
                          ),
                          header: Builder(
                            builder: (context) {
                              motion = RemixSidebar.animationOf(context);
                              padding = fortalSidebarStyle(collapsed: collapsed)
                                  .resolve(context)
                                  .spec
                                  .content
                                  .spec
                                  .box!
                                  .spec
                                  .padding!
                                  .resolve(TextDirection.rtl)
                                  .left;
                              railPadding = FortalTokens.space2.resolve(
                                context,
                              );
                              expandedPadding = FortalTokens.space3.resolve(
                                context,
                              );
                              return const SizedBox.shrink();
                            },
                          ),
                          selectedValue: 'home',
                          onSelected: (_) {},
                          sections: const [
                            RemixSidebarSection(
                              label: 'Workspace',
                              destinations: [
                                RemixSidebarDestination(
                                  value: 'home',
                                  label:
                                      'A very long localized destination label',
                                  icon: Icons.home,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      for (final targetCollapsed in [true, false]) {
        update(() => collapsed = targetCollapsed);
        await tester.pump();
        for (final elapsed in [0, 50, 50, 50, 50, 16]) {
          await tester.pump(Duration(milliseconds: elapsed));
          final target = tester.getRect(
            find.bySemanticsLabel('A very long localized destination label'),
          );
          expect(target.width, greaterThanOrEqualTo(48));
          expect(target.height, greaterThanOrEqualTo(48 - .001));
          expect(
            target.contains(tester.getCenter(find.byIcon(Icons.home))),
            isTrue,
          );
          expect(
            padding,
            closeTo(
              railPadding + (expandedPadding - railPadding) * motion.expansion,
              .001,
            ),
          );
          expect(tester.takeException(), isNull);
        }
        expect(motion.expansion, targetCollapsed ? 0 : 1);
        expect(motion.isAnimating, isFalse);
      }
    }
    semantics.dispose();
  });
}
