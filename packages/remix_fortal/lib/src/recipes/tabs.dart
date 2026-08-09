import 'package:flutter/material.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';

part 'tabs.g.dart';

/// Fortal tab-list size presets matching Radix Themes 3.3.0.
enum FortalTabsSize { size1, size2 }

/// Fortal-themed preset for [RemixTabBar].
///
/// The tab-list bottom border is a single hairline at every Radix size, so this
/// preset takes no `size` — unlike [fortalTabStyle], whose per-tab metrics vary.
@MixWidget(target: RemixTabBar.new)
TabBarStyler fortalTabBarStyle() {
  return TabBarStyler().borderBottom(
    color: FortalTokens.grayA5(),
    width: FortalTokens.borderWidth1(),
  );
}

/// Fortal-themed preset for [RemixTabView].
@MixWidget(target: RemixTabView.new)
TabViewStyler fortalTabViewStyle() => TabViewStyler();

/// Fortal-themed preset for [RemixTab].
@MixWidget(target: RemixTab.new)
TabStyler fortalTabStyle({
  FortalTabsSize size = FortalTabsSize.size2,
  bool highContrast = false,
}) {
  final metrics = switch (size) {
    FortalTabsSize.size1 => (
      height: FortalTokens.space6(),
      outerPaddingX: FortalTokens.space1(),
      innerPaddingX: FortalTokens.space1(),
      innerPaddingY: FortalTokens.tabInnerPaddingY1(),
      radius: FortalTokens.radius1(),
      text: FortalTokens.text1.mix(),
      activeLetterSpacing: FortalTokens.tabActiveLetterSpacing1(),
    ),
    FortalTabsSize.size2 => (
      height: FortalTokens.space7(),
      outerPaddingX: FortalTokens.space2(),
      innerPaddingX: FortalTokens.space2(),
      innerPaddingY: FortalTokens.space1(),
      radius: FortalTokens.radius2(),
      text: FortalTokens.text2.mix(),
      activeLetterSpacing: FortalTokens.tabActiveLetterSpacing2(),
    ),
  };

  return TabStyler()
      .label(
        .style(metrics.text).letterSpacing(0.0).color(FortalTokens.grayA11()),
      )
      .icon(.color(FortalTokens.grayA11()).size(FortalTokens.space4()))
      .wrap(
        .box(
          BoxStyler()
              .height(metrics.height)
              .paddingX(metrics.outerPaddingX)
              .alignment(.center)
              .borderBottom(
                color: Colors.transparent,
                width: FortalTokens.borderWidth2(),
              ),
        ),
      )
      .container(
        .direction(.horizontal)
            .paddingX(metrics.innerPaddingX)
            .paddingY(metrics.innerPaddingY)
            .borderRadiusAll(metrics.radius)
            .mainAxisAlignment(.center)
            .crossAxisAlignment(.center)
            .spacing(FortalTokens.space2()),
      )
      .onHovered(
        .label(
          .color(FortalTokens.gray12()),
        ).icon(.color(FortalTokens.gray12())).color(FortalTokens.grayA3()),
      )
      .onFocused(
        // Solid `focus-8` where the other three rings use alpha `focus-a8`.
        // See fortalFocusRing: unresolved whether that is intentional.
        TabStyler()
            .fortalFocusRing(color: FortalTokens.focus8(), strokeAlign: null)
            .onHovered(.color(FortalTokens.accentA3())),
      )
      .onSelected(
        .label(
              .color(FortalTokens.gray12())
                  .fontWeight(FortalTokens.fontWeightMedium())
                  .letterSpacing(metrics.activeLetterSpacing),
            )
            .icon(.color(FortalTokens.gray12()))
            .wrap(
              .box(
                BoxStyler().borderBottom(
                  color: highContrast
                      ? FortalTokens.accent12()
                      : FortalTokens.accentIndicator(),
                  width: FortalTokens.borderWidth2(),
                ),
              ),
            ),
      );
}
