part of 'tabs.dart';

/// Fortal tab-list size presets matching Radix Themes 3.3.0.
enum FortalTabsSize { size1, size2 }

/// Fortal-themed preset for [RemixTabBar].
///
/// The tab-list bottom border is a single hairline at every Radix size, so this
/// preset takes no `size` — unlike [fortalTabStyle], whose per-tab metrics vary.
@MixWidget(target: RemixTabBar.new)
RemixTabBarStyler fortalTabBarStyle() {
  return RemixTabBarStyler().borderBottom(
    color: FortalTokens.grayA5(),
    width: FortalTokens.borderWidth1(),
  );
}

/// Fortal-themed preset for [RemixTabView].
@MixWidget(target: RemixTabView.new)
RemixTabViewStyler fortalTabViewStyle() => RemixTabViewStyler();

/// Fortal-themed preset for [RemixTab].
@MixWidget(target: RemixTab.new)
RemixTabStyler fortalTabStyle({
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

  return RemixTabStyler()
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
        RemixTabStyler()
            .borderAll(
              color: FortalTokens.focus8(),
              width: FortalTokens.focusRingWidth(),
            )
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

/// Fortal-themed preset for [RemixTabBar].
/// Fortal-themed preset for [RemixTabView].
/// Fortal-themed preset for [RemixTab].
