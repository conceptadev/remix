// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixTabBar].
///
/// The tab-list bottom border is a single hairline at every Radix size, so this
/// preset takes no `size` — unlike [fortalTabStyle], whose per-tab metrics vary.
class FortalTabBar extends StatelessWidget {
  const FortalTabBar({
    super.key,
    this.style = const TabBarStyler.create(),
    required this.child,
  });

  final TabBarStyler style;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RemixTabBar(
      key: this.key,
      style: fortalTabBarStyle(style: this.style),
      child: this.child,
    );
  }
}

/// Fortal-themed preset for [RemixTabView].
class FortalTabView extends StatelessWidget {
  const FortalTabView({
    super.key,
    this.style = const TabViewStyler.create(),
    required this.tabId,
    required this.child,
    this.maintainState = true,
  });

  final TabViewStyler style;

  final String tabId;

  final Widget child;

  final bool maintainState;

  @override
  Widget build(BuildContext context) {
    return RemixTabView(
      key: this.key,
      style: fortalTabViewStyle(style: this.style),
      tabId: this.tabId,
      child: this.child,
      maintainState: this.maintainState,
    );
  }
}

/// Fortal-themed preset for [RemixTab].
class FortalTab extends StatelessWidget {
  const FortalTab({
    super.key,
    this.size = FortalTabsSize.size2,
    this.highContrast = false,
    this.style = const TabStyler.create(),
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

  final FortalTabsSize size;

  final bool highContrast;

  final TabStyler style;

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

  @override
  Widget build(BuildContext context) {
    return RemixTab(
      key: this.key,
      style: fortalTabStyle(
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      tabId: this.tabId,
      child: this.child,
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
      builder: this.builder,
      semanticLabel: this.semanticLabel,
    );
  }
}
