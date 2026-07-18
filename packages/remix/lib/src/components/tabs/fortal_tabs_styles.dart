part of 'tabs.dart';

/// Fortal-themed preset for [RemixTabBar].
RemixTabBarStyler fortalTabBarStyler() {
  return RemixTabBarStyler().container(
    FlexBoxStyler()
        .direction(.horizontal)
        .spacing(FortalTokens.space1())
        .mainAxisSize(.min),
  );
}

/// Fortal-themed preset for [RemixTabView].
RemixTabViewStyler fortalTabViewStyler() {
  return RemixTabViewStyler().paddingAll(FortalTokens.space3());
}

/// Fortal-themed preset for [RemixTab].
RemixTabStyler fortalTabStyler({bool highContrast = false}) {
  return RemixTabStyler()
      .label(TextStyler().color(FortalTokens.gray12()))
      .icon(IconStyler(color: FortalTokens.gray12(), size: 16.0))
      .wrap(
        .box(
          BoxStyler()
              .height(40)
              .paddingX(4)
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
            .borderRadiusAll(FortalTokens.radius2())
            .mainAxisAlignment(.center)
            .crossAxisAlignment(.center)
            .spacing(8.0),
      )
      .onHovered(RemixTabStyler().color(FortalTokens.gray3()))
      .onSelected(
        RemixTabStyler()
            .label(TextStyler().fontWeight(FortalTokens.fontWeightMedium()))
            .wrap(
              .box(
                BoxStyler().borderBottom(
                  color: highContrast
                      ? FortalTokens.accent12()
                      : FortalTokens.accent9(),
                ),
              ),
            ),
      )
      .padding(EdgeInsetsMix.symmetric(vertical: 6.0, horizontal: 12.0));
}

/// Fortal-themed preset for [RemixTabBar].
class FortalTabBar extends StatelessWidget {
  const FortalTabBar({super.key, this.color, this.radius, required this.child});

  /// Optional accent color override for this tab bar subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this tab bar subtree.
  final FortalRadius? radius;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalTabBarStyler().call(key: this.key, child: this.child),
    );
  }
}

/// Fortal-themed preset for [RemixTabView].
class FortalTabView extends StatelessWidget {
  const FortalTabView({
    super.key,
    this.color,
    this.radius,
    required this.tabId,
    required this.child,
  });

  /// Optional accent color override for this tab view subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this tab view subtree.
  final FortalRadius? radius;

  final String tabId;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalTabViewStyler().call(
        key: this.key,
        tabId: this.tabId,
        child: this.child,
      ),
    );
  }
}

/// Fortal-themed preset for [RemixTab].
class FortalTab extends StatelessWidget {
  const FortalTab({
    super.key,
    this.color,
    this.radius,
    this.highContrast = false,
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
  });

  final String tabId;

  /// Optional accent color override for this tab subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this tab subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

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

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child: fortalTabStyler(highContrast: this.highContrast).call(
        key: this.key,
        tabId: this.tabId,
        label: this.label,
        icon: this.icon,
        enabled: this.enabled,
        mouseCursor: this.mouseCursor,
        enableFeedback: this.enableFeedback,
        focusNode: this.focusNode,
        autofocus: this.autofocus,
        onFocusChange: this.onFocusChange,
        onHoverChange: this.onHoverChange,
        onPressChange: this.onPressChange,
        semanticLabel: this.semanticLabel,
        child: this.child,
        builder: this.builder,
      ),
    );
  }
}
