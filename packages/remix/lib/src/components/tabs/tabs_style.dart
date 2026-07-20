part of 'tabs.dart';

/// Style builder for [RemixTabBar].
///
/// Use this class to style the flex container that lays out tab triggers.
extension RemixTabBarStylerRemixHelpers on RemixTabBarStyler {
  /// Creates a [RemixTabBar] widget with this style applied.
  RemixTabBar call({
    Key? key,
    required List<Widget> children,
    RemixTabBarWrap wrap = RemixTabBarWrap.nowrap,
    RemixTabBarJustify justify = RemixTabBarJustify.start,
  }) {
    return RemixTabBar(
      key: key,
      children: children,
      wrap: wrap,
      justify: justify,
      style: this,
    );
  }
}

/// Style builder for [RemixTabView].
///
/// Use this class to style the content container associated with a selected
/// tab.
extension RemixTabViewStylerRemixHelpers on RemixTabViewStyler {
  /// Creates a [RemixTabView] widget with this style applied.
  RemixTabView call({
    Key? key,
    required String tabId,
    required Widget child,
    bool maintainState = true,
  }) {
    return RemixTabView(
      key: key,
      tabId: tabId,
      maintainState: maintainState,
      style: this,
      child: child,
    );
  }
}

/// Style builder for [RemixTab].
///
/// Use this class to style an individual tab trigger, including its container,
/// label, icon, and selected state.
extension RemixTabStylerRemixHelpers on RemixTabStyler {
  /// Creates a [RemixTab] widget with this style applied.
  RemixTab call({
    Key? key,
    required String tabId,
    Widget? child,
    String? label,
    IconData? icon,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onPressChange,
    ValueWidgetBuilder<NakedTabState>? builder,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixTab(
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
      style: this,
      child: child,
      builder: builder,
    );
  }

  RemixTabStyler flex(FlexStyler value) {
    return merge(RemixTabStyler(container: FlexBoxStyler().flex(value)));
  }
}
