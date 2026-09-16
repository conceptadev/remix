import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';

part 'tabs.g.dart';

/// Ui tab-list size presets matching Radix Themes 3.3.0.
enum UiTabsSize { size1, size2 }

/// Ui-themed preset for [RemixTabBar].
///
/// The tab-list bottom border is a single hairline at every Radix size, so this
/// preset takes no `size` — unlike [uiTabStyle], whose per-tab metrics vary.
@MixWidget(target: RemixTabBar.new)
TabBarStyler uiTabBarStyle({TabBarStyler style = const TabBarStyler.create()}) {
  return TabBarStyler()
      .border(.bottom(.color(UiTokens.grayA5()).width(UiTokens.borderWidth1())))
      .merge(style);
}

/// Ui-themed preset for [RemixTabView].
@MixWidget(target: RemixTabView.new)
TabViewStyler uiTabViewStyle({
  TabViewStyler style = const TabViewStyler.create(),
}) => TabViewStyler().merge(style);

/// Ui-themed preset for [RemixTab].
@MixWidget(target: RemixTab.new)
TabStyler uiTabStyle({
  UiTabsSize size = UiTabsSize.size2,
  bool highContrast = false,
  TabStyler style = const TabStyler.create(),
}) {
  final metrics = switch (size) {
    UiTabsSize.size1 => (
      height: UiTokens.space6(),
      outerPaddingX: UiTokens.space1(),
      innerPaddingX: UiTokens.space1(),
      innerPaddingY: UiTokens.tabInnerPaddingY1(),
      radius: UiTokens.radius1(),
      text: UiTokens.text1.mix(),
      activeLetterSpacing: UiTokens.tabActiveLetterSpacing1(),
    ),
    UiTabsSize.size2 => (
      height: UiTokens.space7(),
      outerPaddingX: UiTokens.space2(),
      innerPaddingX: UiTokens.space2(),
      innerPaddingY: UiTokens.space1(),
      radius: UiTokens.radius2(),
      text: UiTokens.text2.mix(),
      activeLetterSpacing: UiTokens.tabActiveLetterSpacing2(),
    ),
  };

  return TabStyler()
      .label(.style(metrics.text).letterSpacing(0.0).color(UiTokens.grayA11()))
      .icon(.color(UiTokens.grayA11()).size(UiTokens.space4()))
      .wrap(
        .box(
          BoxStyler()
              .height(metrics.height)
              .padding(.horizontal(metrics.outerPaddingX))
              .alignment(.center)
              .border(
                .bottom(
                  .color(
                    const Color(0x00000000),
                  ).width(UiTokens.borderWidth2()),
                ),
              ),
        ),
      )
      .container(
        .direction(.horizontal)
            .padding(.horizontal(metrics.innerPaddingX))
            .padding(.vertical(metrics.innerPaddingY))
            .borderRadius(.all(metrics.radius))
            .mainAxisAlignment(.center)
            .spacing(UiTokens.space2()),
      )
      .onHovered(
        .label(.color(UiTokens.gray12()))
            .icon(.color(UiTokens.gray12()))
            .color(UiTokens.grayA3())
            .onFocusVisible(.color(UiTokens.accentA3())),
      )
      .onFocusVisible(
        // Solid `focus-8` where the other three rings use alpha `focus-a8`.
        // See uiFocusRing: unresolved whether that is intentional.
        TabStyler().uiFocusRing(color: UiTokens.focus8(), strokeAlign: null),
      )
      .onSelected(
        .label(
              .color(UiTokens.gray12())
                  .fontWeight(UiTokens.fontWeightMedium())
                  .letterSpacing(metrics.activeLetterSpacing),
            )
            .icon(.color(UiTokens.gray12()))
            .wrap(
              .box(
                BoxStyler().border(
                  .bottom(
                    .color(
                      highContrast
                          ? UiTokens.accent12()
                          : UiTokens.accentIndicator(),
                    ).width(UiTokens.borderWidth2()),
                  ),
                ),
              ),
            ),
      )
      .merge(style);
}
