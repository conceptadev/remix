// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_tabs.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon tab-list recipe.
class CarbonTabBar extends StatelessWidget {
  const CarbonTabBar({
    super.key,
    this.orientation = .horizontal,
    required this.child,
  });

  final Axis orientation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RemixTabBar(
      key: this.key,
      style: carbonTabBarStyle(orientation: this.orientation),
      child: this.child,
    );
  }
}

/// Carbon line-tab recipe.
class CarbonTab extends StatelessWidget {
  const CarbonTab({
    super.key,
    this.size = .medium,
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
    this.semanticLabel,
  });

  final CarbonTabSize size;

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

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return RemixTab(
      key: this.key,
      style: carbonTabStyle(size: this.size),
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
      semanticLabel: this.semanticLabel,
    );
  }
}

/// Carbon tab-panel recipe.
class CarbonTabView extends StatelessWidget {
  const CarbonTabView({
    super.key,
    required this.tabId,
    required this.child,
    this.maintainState = true,
  });

  final String tabId;

  final Widget child;

  final bool maintainState;

  @override
  Widget build(BuildContext context) {
    return RemixTabView(
      key: this.key,
      style: carbonTabViewStyle(),
      tabId: this.tabId,
      child: this.child,
      maintainState: this.maintainState,
    );
  }
}
