part of 'tabs.dart';

/// A customizable tabs component that supports tab navigation and content switching.
///
/// ## Example
///
/// ```dart
/// RemixTabs(
///   selectedTabId: 'tab1',
///   onChanged: (id) => setState(() => selectedTabId = id),
///   child: Column(
///     children: [
///       RemixTabBar(
///         child: Row(
///           children: [
///             RemixTab(tabId: 'tab1', child: Text('Tab 1')),
///             RemixTab(tabId: 'tab2', child: Text('Tab 2')),
///           ],
///         ),
///       ),
///       Expanded(
///         child: Column(
///           children: [
///             RemixTabView(tabId: 'tab1', child: Text('Content 1')),
///             RemixTabView(tabId: 'tab2', child: Text('Content 2')),
///           ],
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
class RemixTabs extends StatelessWidget {
  const RemixTabs({
    super.key,
    required this.child,
    this.controller,
    this.selectedTabId,
    this.onChanged,
    this.orientation = .horizontal,
    this.enabled = true,
    this.onEscapePressed,
  }) : assert(
         controller != null || selectedTabId != null,
         'Either controller or selectedTabId must be provided',
       );

  /// The tabs content.
  final Widget child;

  /// Optional controller for managing tab state.
  final NakedTabController? controller;

  /// The identifier of the currently selected tab.
  final String? selectedTabId;

  /// Called when the selected tab changes.
  final ValueChanged<String>? onChanged;

  /// Whether the tabs are enabled.
  final bool enabled;

  /// The tab list orientation.
  final Axis orientation;

  /// Called when Escape is pressed while a tab has focus.
  final VoidCallback? onEscapePressed;

  @override
  Widget build(BuildContext context) {
    return NakedTabs(
      controller: controller,
      selectedTabId: selectedTabId,
      onChanged: onChanged,
      orientation: orientation,
      enabled: enabled,
      onEscapePressed: onEscapePressed,
      child: child,
    );
  }
}

/// A container widget for tab buttons.
class RemixTabBar extends StatelessWidget {
  const RemixTabBar({
    super.key,
    required this.child,
    this.style = const TabBarStyler.create(),
    this.styleSpec,
  });

  /// The tab buttons.
  final Widget child;

  /// Style applied to the tab bar container.
  final TabBarStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final TabBarSpec? styleSpec;

  static final styleFrom = TabBarStyler.new;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<TabBarSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        return FlexBox(styleSpec: spec.container, children: [child]);
      },
    );
  }
}

/// An individual tab button.
class RemixTab extends StatelessWidget {
  const RemixTab({
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
    this.style = const TabStyler.create(),
    this.styleSpec,
  }) : assert(
         child != null || builder != null || label != null,
         'Either child, builder, or label must be provided',
       );

  /// The tab content when not using [builder].
  final Widget? child;

  /// The unique identifier for this tab.
  final String tabId;

  /// Whether this tab is enabled.
  final bool enabled;

  /// The mouse cursor for this tab.
  final MouseCursor mouseCursor;

  /// Whether to enable haptic feedback.
  final bool enableFeedback;

  /// Optional focus node for this tab.
  final FocusNode? focusNode;

  /// Whether this tab should automatically request focus.
  final bool autofocus;

  /// Called when focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when hover changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when press state changes.
  final ValueChanged<bool>? onPressChange;

  /// Custom builder for the tab content.
  final ValueWidgetBuilder<NakedTabState>? builder;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// The style configuration for this tab.
  final TabStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final TabSpec? styleSpec;

  /// Optional icon to display in the tab.
  final IconData? icon;

  /// Optional label text for the tab.
  final String? label;

  static final styleFrom = TabStyler.new;

  Widget _buildTabContent(
    BuildContext context,
    TabSpec spec,
    NakedTabState state,
  ) {
    final defaultContent =
        child ??
        FlexBox(
          styleSpec: spec.container,
          children: [
            if (icon != null) StyledIcon(icon: icon!, styleSpec: spec.icon),
            if (label != null) StyledText(label!, styleSpec: spec.label),
          ],
        );

    if (builder != null) {
      return builder!(context, state, defaultContent);
    }

    return defaultContent;
  }

  @override
  Widget build(BuildContext context) {
    return NakedTab(
      tabId: tabId,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      semanticLabel: semanticLabel ?? label,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<TabSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedTabState.controllerOf(context),
          builder: (context, spec) => _buildTabContent(context, spec, state),
        );
      },
    );
  }
}

/// A tab content panel that is shown when its corresponding tab is selected.
class RemixTabView extends StatelessWidget {
  const RemixTabView({
    super.key,
    required this.tabId,
    required this.child,
    this.style = const TabViewStyler.create(),
    this.styleSpec,
  });

  /// The unique identifier that matches a tab.
  final String tabId;

  /// The content to show when this tab is selected.
  final Widget child;

  /// Style applied to the tab view container.
  final TabViewStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final TabViewSpec? styleSpec;

  static final styleFrom = TabViewStyler.new;

  @override
  Widget build(BuildContext context) {
    return NakedTabView(
      tabId: tabId,
      child: RemixStyleSpecBuilder<TabViewSpec>(
        style: style,
        styleSpec: styleSpec,
        builder: (context, spec) {
          return Box(styleSpec: spec.container, child: child);
        },
      ),
    );
  }
}
