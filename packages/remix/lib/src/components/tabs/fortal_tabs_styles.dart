part of 'tabs.dart';

/// Fortal tab-list size presets matching Radix Themes 3.3.0.
enum FortalTabsSize { size1, size2 }

/// Fortal-themed preset for [RemixTabBar].
///
/// The tab-list bottom border is a single hairline at every Radix size, so this
/// preset takes no `size` — unlike [fortalTabStyler], whose per-tab metrics vary.
RemixTabBarStyler fortalTabBarStyler() {
  return RemixTabBarStyler().borderBottom(
    color: FortalTokens.grayA5(),
    width: FortalTokens.borderWidth1(),
  );
}

/// Fortal-themed preset for [RemixTabView].
RemixTabViewStyler fortalTabViewStyler() => RemixTabViewStyler();

/// Fortal-themed preset for [RemixTab].
RemixTabStyler fortalTabStyler({
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
        TextStyler(
          style: metrics.text,
        ).letterSpacing(0.0).color(FortalTokens.grayA11()),
      )
      .icon(
        IconStyler(color: FortalTokens.grayA11(), size: FortalTokens.space4()),
      )
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
        FlexBoxStyler()
            .direction(.horizontal)
            .paddingX(metrics.innerPaddingX)
            .paddingY(metrics.innerPaddingY)
            .borderRadiusAll(metrics.radius)
            .mainAxisAlignment(.center)
            .crossAxisAlignment(.center)
            .spacing(FortalTokens.space2()),
      )
      .onHovered(
        RemixTabStyler()
            .label(TextStyler().color(FortalTokens.gray12()))
            .icon(IconStyler().color(FortalTokens.gray12()))
            .color(FortalTokens.grayA3()),
      )
      .onFocused(
        RemixTabStyler()
            .borderAll(
              color: FortalTokens.focus8(),
              width: FortalTokens.focusRingWidth(),
            )
            .onHovered(RemixTabStyler().color(FortalTokens.accentA3())),
      )
      .onSelected(
        RemixTabStyler()
            .label(
              TextStyler()
                  .color(FortalTokens.gray12())
                  .fontWeight(FortalTokens.fontWeightMedium())
                  .letterSpacing(metrics.activeLetterSpacing),
            )
            .icon(IconStyler().color(FortalTokens.gray12()))
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

class _FortalTabListScope extends InheritedWidget {
  const _FortalTabListScope({
    required this.size,
    required this.highContrast,
    required super.child,
  });

  final FortalTabsSize size;
  final bool highContrast;

  static _FortalTabListScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_FortalTabListScope>();

  @override
  bool updateShouldNotify(_FortalTabListScope oldWidget) =>
      size != oldWidget.size || highContrast != oldWidget.highContrast;
}

/// Fortal-themed preset for [RemixTabBar].
class FortalTabBar extends StatelessWidget {
  const FortalTabBar({
    super.key,
    this.size = FortalTabsSize.size2,
    this.wrap = RemixTabBarWrap.nowrap,
    this.justify = RemixTabBarJustify.start,
    this.color,
    this.highContrast = false,
    required this.children,
  });

  final FortalTabsSize size;
  final RemixTabBarWrap wrap;
  final RemixTabBarJustify justify;
  final FortalAccentColor? color;
  final bool highContrast;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tabBar = fortalTabBarStyler().call(
      key: key,
      wrap: wrap,
      justify: justify,
      children: children,
    );

    return FortalComponentOverride(
      color: color,
      child: _FortalTabListScope(
        size: size,
        highContrast: highContrast,
        child: tabBar,
      ),
    );
  }
}

/// Fortal-themed preset for [RemixTabView].
class FortalTabView extends StatelessWidget {
  const FortalTabView({
    super.key,
    required this.tabId,
    required this.child,
    this.maintainState = true,
  });

  final String tabId;
  final Widget child;
  final bool maintainState;

  @override
  Widget build(BuildContext context) => fortalTabViewStyler().call(
    key: key,
    tabId: tabId,
    maintainState: maintainState,
    child: child,
  );
}

/// Fortal-themed preset for [RemixTab].
class FortalTab extends StatelessWidget {
  const FortalTab({
    super.key,
    required this.tabId,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.builder,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final String tabId;
  final Widget? child;
  final String? label;
  final IconData? icon;
  final bool enabled;
  final MouseCursor mouseCursor;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<bool>? onPressChange;
  final ValueWidgetBuilder<NakedTabState>? builder;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    final list = _FortalTabListScope.maybeOf(context);
    return fortalTabStyler(
      size: list?.size ?? FortalTabsSize.size2,
      highContrast: list?.highContrast ?? false,
    ).call(
      key: key,
      tabId: tabId,
      label: label,
      icon: icon,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
      child: child,
      builder: builder,
    );
  }
}
