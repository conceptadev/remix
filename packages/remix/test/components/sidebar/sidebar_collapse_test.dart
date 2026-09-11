import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('animated widths must form a finite ordered pair', () {
    for (final widths in <(double?, double?)>[
      (256, null),
      (null, 72),
      (0, 0),
      (256, -1),
      (72, 256),
      (double.infinity, 72),
      (double.nan, 72),
    ]) {
      expect(
        () => RemixSidebar<String>(
          expandedWidth: widths.$1,
          collapsedWidth: widths.$2,
          sections: const [],
          selectedValue: null,
        ),
        throwsAssertionError,
      );
    }
  });

  testWidgets('width is optional and respects parent constraints', (
    tester,
  ) async {
    for (final ownWidth in [false, true]) {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 180,
              height: 300,
              child: RemixSidebar<String>(
                key: const ValueKey('sized-sidebar'),
                expandedWidth: ownWidth ? 256 : null,
                collapsedWidth: ownWidth ? 72 : null,
                showTooltips: false,
                sections: const [],
                selectedValue: null,
              ),
            ),
          ),
        ),
      );
      expect(
        tester.getSize(find.byKey(const ValueKey('sized-sidebar'))).width,
        180,
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('expanded raw styles retain wrapping and space-between layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            key: const ValueKey('raw-panel'),
            width: 256,
            height: 300,
            child: Builder(
              builder: (context) => RemixSidebar<String>(
                selectedValue: 'home',
                onSelected: (_) {},
                sections: const [
                  RemixSidebarSection(
                    label: 'Workspace\nNavigation',
                    destinations: [
                      RemixSidebarDestination(
                        value: 'home',
                        label: 'First\nSecond',
                        icon: Icons.home,
                      ),
                    ],
                  ),
                ],
                styleSpec: SidebarStyler()
                    .sectionLabel(TextStyler().fontSize(16).maxLines(2))
                    .destination(
                      ToggleStyler()
                          .container(
                            FlexBoxStyler().mainAxisAlignment(.spaceBetween),
                          )
                          .icon(IconStyler().size(20))
                          .label(TextStyler().fontSize(20).maxLines(2)),
                    )
                    .resolve(context)
                    .spec,
              ),
            ),
          ),
        ),
      ),
    );
    final panel = tester.getRect(find.byKey(const ValueKey('raw-panel')));
    final label = tester.getRect(find.text('First\nSecond'));
    expect(label.height, greaterThanOrEqualTo(40));
    expect(
      tester.getSize(find.text('Workspace\nNavigation')).height,
      greaterThanOrEqualTo(32),
    );
    expect(label.right, closeTo(panel.right, .01));
    expect(
      tester.getRect(find.byIcon(Icons.home)).left,
      closeTo(panel.left, .01),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'collapsed icons retain names, headings, selection and activation',
    (tester) async {
      final semantics = tester.ensureSemantics();

      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key, initiallyCollapsed: true));
      expect(find.text('Overview'), findsNothing);
      expect(find.text('Workspace'), findsNothing);
      expect(find.byIcon(Icons.home), findsOneWidget);
      final node = tester.getSemantics(find.bySemanticsLabel('Overview'));
      expect(
        node.getSemanticsData().flagsCollection.isSelected,
        ui.Tristate.isTrue,
      );
      expect(node.getSemanticsData().flagsCollection.isButton, isTrue);
      expect(
        node.getSemanticsData().flagsCollection.isToggled,
        ui.Tristate.none,
      );
      expect(find.bySemanticsLabel('Workspace'), findsOneWidget);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Workspace')).rect.isEmpty,
        isFalse,
        reason: 'Web accessibility omits zero-area headings.',
      );
      await tester.tap(find.byIcon(Icons.home));
      await tester.pump();
      expect(key.currentState!.selections, ['home']);
      await tester.tap(find.byIcon(Icons.settings));
      expect(key.currentState!.selections, ['home']);
      semantics.dispose();
    },
  );

  testWidgets(
    'both directions have continuous bounded geometry at every checkpoint',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      double width() =>
          tester.getSize(find.byKey(const ValueKey('panel'))).width;
      expect(width(), 256);
      for (final collapsed in [true, false]) {
        key.currentState!.update(collapsed: collapsed);
        await tester.pump();
        await tester.pump();
        var previous = width();
        var elapsed = 0;
        for (final time in [16, 50, 100, 150, 199, 200, 216]) {
          await tester.pump(Duration(milliseconds: time - elapsed));
          elapsed = time;
          final current = width();
          expect(current, inInclusiveRange(72.0, 256.0));
          expect(
            current,
            collapsed
                ? lessThanOrEqualTo(previous)
                : greaterThanOrEqualTo(previous),
          );
          final panel = tester.getRect(find.byKey(const ValueKey('panel')));
          final page = tester.getRect(find.byKey(const ValueKey('page')));
          expect(page.left, closeTo(panel.right, .01));
          expect(tester.takeException(), isNull);
          previous = current;
        }
        expect(width(), collapsed ? 72 : 256);
      }
    },
  );

  testWidgets(
    'rapid reversals continue from the displayed frame and last target wins',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      double width() =>
          tester.getSize(find.byKey(const ValueKey('panel'))).width;
      var elapsed = 0;
      for (final time in [0, 40, 90, 130]) {
        await tester.pump(Duration(milliseconds: time - elapsed));
        final before = width();
        final opacity = key.currentState!.motion!.labelOpacity;
        key.currentState!.update(collapsed: !key.currentState!.collapsed);
        await tester.pump();
        await tester.pump();
        expect(width(), closeTo(before, .001));
        expect(key.currentState!.motion!.labelOpacity, closeTo(opacity, .001));
        elapsed = time;
      }
      await tester.pump(const Duration(milliseconds: 200));
      expect(width(), 256);
      await tester.pump(const Duration(seconds: 1));
      expect(width(), 256);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'focus survives transitions and Enter/Space activate exactly once',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      final host = key.currentState!;
      host.focus.requestFocus();
      await tester.pump();
      host.update(collapsed: true);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(host.focus.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      expect(host.selections, ['home']);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(host.selections, ['home', 'home']);
      host.update(collapsed: false);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(host.focus.hasFocus, isTrue);
      host.update(showTooltips: false);
      await tester.pump();
      await tester.pump();
      expect(host.focus.hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'tooltip resumes after motion and closes on Escape and expansion',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      final gesture = await tester.createGesture(
        kind: ui.PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      key.currentState!.focus.requestFocus();
      await tester.pump();
      key.currentState!.update(collapsed: true);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(_openTooltips(tester), isEmpty);
      await tester.pump(const Duration(milliseconds: 100));
      expect(_openTooltips(tester), isEmpty);
      await tester.pump(const Duration(milliseconds: 16));
      await tester.pump(const Duration(milliseconds: 301));
      await tester.pump();
      expect(_openTooltips(tester), hasLength(1));
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      expect(_openTooltips(tester), isEmpty);
      await gesture.moveTo(const Offset(700, 500));
      await tester.pump(const Duration(milliseconds: 150));
      await gesture.moveTo(tester.getCenter(find.byIcon(Icons.home)));
      await tester.pump(const Duration(milliseconds: 301));
      await tester.pump();
      expect(_openTooltips(tester), hasLength(1));
      key.currentState!.update(collapsed: false);
      await tester.pump();
      await tester.pump();
      expect(_openTooltips(tester), isEmpty);
      await tester.pump(const Duration(milliseconds: 250));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'reduced motion settles on the next frame including mid-transition',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      key.currentState!.update(collapsed: true);
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      key.currentState!.update(reduceMotion: true);
      await tester.pump();
      await tester.pump();
      expect(key.currentState!.motion!.expansion, 0);
      expect(key.currentState!.motion!.labelOpacity, 0);
      expect(key.currentState!.motion!.isAnimating, isFalse);
      key.currentState!.update(collapsed: false);
      await tester.pump();
      await tester.pump();
      expect(key.currentState!.motion!.expansion, 1);
      expect(key.currentState!.motion!.isAnimating, isFalse);
      await tester.pump(const Duration(seconds: 1));
      expect(key.currentState!.motion!.expansion, 1);
    },
  );

  testWidgets(
    'AnimationStyle configures both directions without a second driver',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      key.currentState!.update(
        collapsed: true,
        animationStyle: const AnimationStyle(
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 100),
          curve: Curves.linear,
          reverseCurve: Curves.easeIn,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        key.currentState!.motion!.expansion,
        closeTo(1 - Curves.easeIn.transform(.5), .001),
      );
      await tester.pump(const Duration(milliseconds: 66));
      expect(key.currentState!.motion!.expansion, 0);
      key.currentState!.update(collapsed: false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(key.currentState!.motion!.expansion, closeTo(.5, .001));
      expect(key.currentState!.motion!.labelOpacity, 0);
      await tester.pump(const Duration(milliseconds: 100));
      expect(key.currentState!.motion!.labelOpacity, closeTo(.5, .001));
      await tester.pump(const Duration(milliseconds: 116));
      expect(key.currentState!.motion!.expansion, 1);
      expect(key.currentState!.motion!.isAnimating, isFalse);
    },
  );

  testWidgets(
    'timing changes preserve the current frame and noAnimation settles',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      key.currentState!.update(collapsed: true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      final previous = key.currentState!.motion!;
      key.currentState!.update(
        animationStyle: const AnimationStyle(
          duration: Duration(milliseconds: 400),
          curve: Curves.linear,
        ),
      );
      await tester.pump();
      expect(key.currentState!.motion!.expansion, previous.expansion);
      expect(key.currentState!.motion!.labelOpacity, previous.labelOpacity);
      await tester.pump(const Duration(milliseconds: 50));
      key.currentState!.update(animationStyle: AnimationStyle.noAnimation);
      await tester.pump();
      expect(key.currentState!.motion!.expansion, 0);
      expect(key.currentState!.motion!.isAnimating, isFalse);
      key.currentState!.update(collapsed: false);
      await tester.pump();
      expect(key.currentState!.motion!.expansion, 1);
      expect(key.currentState!.motion!.labelOpacity, 1);
      expect(key.currentState!.motion!.isAnimating, isFalse);
      key.currentState!.update(animationStyle: const AnimationStyle());
      await tester.pump();
      expect(key.currentState!.motion!.isAnimating, isFalse);
    },
  );

  testWidgets(
    'overshooting curves keep geometry bounded without skipping text phases',
    (tester) async {
      final key = GlobalKey<_HostState>();
      await tester.pumpWidget(_Host(key: key));
      key.currentState!.update(
        collapsed: true,
        animationStyle: const AnimationStyle(curve: Curves.easeInBack),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      final frame = key.currentState!.motion!;
      expect(frame.expansion, 1);
      expect(frame.labelOpacity, closeTo(1 / 3, .001));
      final opacity = tester.widget<Opacity>(
        find
            .ancestor(of: find.text('Overview'), matching: find.byType(Opacity))
            .first,
      );
      expect(opacity.opacity, frame.labelOpacity);
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 16));
        final width = tester.getSize(find.byKey(const ValueKey('panel'))).width;
        expect(width, inInclusiveRange(72, 256));
        expect(tester.takeException(), isNull);
      }
      expect(key.currentState!.motion!.expansion, 0);
    },
  );

  testWidgets('initial state and unrelated rebuilds do not start motion', (
    tester,
  ) async {
    final key = GlobalKey<_HostState>();
    await tester.pumpWidget(_Host(key: key, initiallyCollapsed: true));
    expect(key.currentState!.motion!.expansion, 0);
    expect(key.currentState!.motion!.isAnimating, isFalse);
    key.currentState!.update();
    await tester.pump();
    await tester.pump();
    expect(key.currentState!.motion!.isAnimating, isFalse);
  });

  testWidgets('RTL and enlarged long labels fit while collapsing', (
    tester,
  ) async {
    final key = GlobalKey<_HostState>();
    await tester.pumpWidget(_Host(key: key, rtl: true));
    key.currentState!.update(collapsed: true);
    await tester.pump();
    await tester.pump();
    for (var i = 0; i < 14; i++) {
      await tester.pump(const Duration(milliseconds: 16));
      expect(tester.takeException(), isNull);
    }
    final tooltip = tester
        .widgetList<RemixTooltip>(find.byType(RemixTooltip))
        .first;
    expect(tooltip.positioning.side, OverlaySide.left);
  });

  testWidgets('touch tooltip closes when its destination is removed', (
    tester,
  ) async {
    final key = GlobalKey<_HostState>();
    await tester.pumpWidget(_Host(key: key, initiallyCollapsed: true));
    final touch = await tester.startGesture(
      tester.getCenter(find.byIcon(Icons.home)),
    );
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump();
    expect(_openTooltips(tester), hasLength(1));
    await touch.up();
    key.currentState!.update(includeHome: false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byIcon(Icons.home), findsNothing);
    expect(find.text('Overview'), findsNothing);
    expect(_openTooltips(tester), isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('no-overlay hosts remain valid and missing icons fail clearly', (
    tester,
  ) async {
    Widget panel({
      bool collapsed = false,
      bool showTooltips = false,
      bool icon = true,
    }) => Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: 100,
        height: 200,
        child: RemixSidebar<String>(
          collapsed: collapsed,
          showTooltips: showTooltips,
          selectedValue: 'home',
          onSelected: (_) {},
          sections: [
            RemixSidebarSection(
              destinations: [
                RemixSidebarDestination(
                  value: 'home',
                  label: 'Home',
                  icon: icon ? Icons.home : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    await tester.pumpWidget(panel(showTooltips: true, icon: false));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(panel(collapsed: true));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(panel(collapsed: true, icon: false));
    expect(
      tester.takeException().toString(),
      contains('home must provide an icon'),
    );
    await tester.pumpWidget(panel(collapsed: true, showTooltips: true));
    expect(tester.takeException().toString(), contains('require an Overlay'));
  });
}

Iterable<RemixTooltip> _openTooltips(WidgetTester tester) => tester
    .widgetList<RemixTooltip>(find.byType(RemixTooltip))
    .where((tooltip) => tooltip.open == true);

class _Host extends StatefulWidget {
  const _Host({super.key, this.initiallyCollapsed = false, this.rtl = false});
  final bool initiallyCollapsed;
  final bool rtl;
  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  late bool collapsed = widget.initiallyCollapsed;
  bool showTooltips = true;
  bool reduceMotion = false;
  bool includeHome = true;
  SidebarAnimation? motion;
  AnimationStyle animationStyle = const AnimationStyle();
  final focus = FocusNode();
  final selections = <String>[];

  void update({
    bool? collapsed,
    bool? showTooltips,
    bool? reduceMotion,
    bool? includeHome,
    AnimationStyle? animationStyle,
  }) => setState(() {
    this.collapsed = collapsed ?? this.collapsed;
    this.showTooltips = showTooltips ?? this.showTooltips;
    this.reduceMotion = reduceMotion ?? this.reduceMotion;
    this.includeHome = includeHome ?? this.includeHome;
    this.animationStyle = animationStyle ?? this.animationStyle;
  });

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(
        disableAnimations: reduceMotion,
        textScaler: TextScaler.linear(widget.rtl ? 2 : 1),
      ),
      child: Directionality(
        textDirection: widget.rtl ? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          children: [
            RemixSidebar<String>(
              key: const ValueKey('panel'),
              expandedWidth: 256,
              collapsedWidth: 72,
              animationStyle: animationStyle,
              collapsed: collapsed,
              showTooltips: showTooltips,
              header: Builder(
                builder: (context) {
                  motion = RemixSidebar.animationOf(context);
                  return const SizedBox.shrink();
                },
              ),
              selectedValue: includeHome ? 'home' : null,
              onSelected: selections.add,
              sections: [
                RemixSidebarSection(
                  label: 'Workspace',
                  destinations: [
                    if (includeHome)
                      RemixSidebarDestination(
                        value: 'home',
                        label: 'Overview',
                        icon: Icons.home,
                        focusNode: focus,
                      ),
                    const RemixSidebarDestination(
                      value: 'settings',
                      label: 'A very long settings destination label',
                      icon: Icons.settings,
                      enabled: false,
                    ),
                  ],
                ),
              ],
              style: SidebarStyler().destination(ToggleStyler().minHeight(48)),
            ),
            const Expanded(child: SizedBox(key: ValueKey('page'))),
          ],
        ),
      ),
    ),
  );
}
