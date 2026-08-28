// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's tab-strip recipe.
///
/// The strip is the rule the tabs sit on: one hairline along its bottom edge,
/// in the same `border` token every other control outline uses. It spans its
/// container rather than hugging the tabs, so the rule lines up with the card
/// or page edge beside it.
///
/// The strip does not scroll. Tabs wider than the container are a layout
/// decision, and the scroll view belongs **outside** the bar:
///
/// ```dart
/// SingleChildScrollView(
///   scrollDirection: Axis.horizontal,
///   child: AcmeTabBar(child: Row(children: tabs)),
/// )
/// ```
///
/// Not inside it. Flutter's tab-bar semantics role requires every direct
/// semantics child of the bar to be a tab, and a scroll view inserted between
/// them adds a node of its own, which trips that assertion at runtime.
///
/// `RemixTabs` — the behavioral root that owns selection, roving focus, and
/// arrow-key traversal — carries no styler and therefore no recipe. Compose it
/// directly around this bar:
///
/// ```dart
/// RemixTabs(
///   selectedTabId: tab,
///   onChanged: (id) => setState(() => tab = id),
///   child: Column(
///     children: [
///       AcmeTabBar(
///         child: Row(children: [
///           AcmeTab(tabId: 'account', label: 'Account'),
///           AcmeTab(tabId: 'billing', label: 'Billing'),
///         ]),
///       ),
///       AcmeTabView(tabId: 'account', child: accountPanel),
///       AcmeTabView(tabId: 'billing', child: billingPanel),
///     ],
///   ),
/// )
/// ```
class AcmeTabBar extends StatelessWidget {
  const AcmeTabBar({
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
      style: acmeTabBarStyle(style: this.style),
      child: this.child,
    );
  }
}

/// The application's Tab recipe.
///
/// Everything visual about one tab lives in this function: geometry,
/// typography, and the hover/selected/focus/disabled fragments. Remix keeps
/// ownership of rendering, selection, keyboard traversal, and the tab
/// accessibility semantics — this recipe never reimplements any of that.
///
/// The selected tab is marked by its trailing edge. That edge is present in
/// every state and merely transparent when unselected, so selecting a tab
/// paints two pixels instead of reflowing the whole strip.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's selected underline has to
/// be declared as a selected fragment too (`TabStyler().onSelected(...)`).
///
/// `builder` is deliberately not forwarded to the generated
/// `AcmeTab`. Its type is `ValueWidgetBuilder<NakedTabState>`, and
/// `NakedTabState` comes from `package:naked_ui`, which this layer does not
/// depend on. Pass a `child` for custom content, or reach for `RemixTab`
/// directly on the rare call site that needs the raw state.
class AcmeTab extends StatelessWidget {
  const AcmeTab({
    super.key,
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
    this.semanticLabel,
  });

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

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return RemixTab(
      key: this.key,
      style: acmeTabStyle(style: this.style),
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

/// The application's recipe for the panel a tab reveals.
///
/// It exists so the panel carries the application's prefix and has one place
/// to edit, and it earns that by owning the gap between the strip and the
/// content: without it the panel's first line sits directly on the hairline.
class AcmeTabView extends StatelessWidget {
  const AcmeTabView({
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
      style: acmeTabViewStyle(style: this.style),
      tabId: this.tabId,
      child: this.child,
      maintainState: this.maintainState,
    );
  }
}
