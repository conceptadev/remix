import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'tabs.g.dart';

/// The control densities this application offers for a tab.
///
/// Only the individual tab takes a size. The bar's hairline and the panel's
/// leading gap read the same at every density, so giving them a size
/// parameter would add an axis with nothing behind it.
enum PlaygroundTabSize {
  /// A 32px tab.
  small,

  /// A 36px tab. The default.
  medium,

  /// A 40px tab.
  large,
}

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
///   child: PlaygroundTabBar(child: Row(children: tabs)),
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
///       PlaygroundTabBar(
///         child: Row(children: [
///           PlaygroundTab(tabId: 'account', label: 'Account'),
///           PlaygroundTab(tabId: 'billing', label: 'Billing'),
///         ]),
///       ),
///       PlaygroundTabView(tabId: 'account', child: accountPanel),
///       PlaygroundTabView(tabId: 'billing', child: billingPanel),
///     ],
///   ),
/// )
/// ```
@MixWidget(name: 'PlaygroundTabBar', target: RemixTabBar.new)
TabBarStyler playgroundTabBarStyle({
  TabBarStyler style = const TabBarStyler.create(),
}) => TabBarStyler()
    .direction(.horizontal)
    .mainAxisSize(.max)
    .crossAxisAlignment(.end)
    .border(
      .bottom(
        BorderSideMix(color: PlaygroundTokens.border(), width: _barBorderWidth),
      ),
    )
    .merge(style);

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
/// `PlaygroundTab`. Its type is `ValueWidgetBuilder<NakedTabState>`, and
/// `NakedTabState` comes from `package:naked_ui`, which this layer does not
/// depend on. Pass a `child` for custom content, or reach for `RemixTab`
/// directly on the rare call site that needs the raw state.
@MixWidget(
  name: 'PlaygroundTab',
  target: RemixTab.new,
  widgetParameters: .only({
    'tabId',
    'child',
    'label',
    'icon',
    'enabled',
    'mouseCursor',
    'enableFeedback',
    'focusNode',
    'autofocus',
    'onFocusChange',
    'onHoverChange',
    'onPressChange',
    'semanticLabel',
  }),
)
TabStyler playgroundTabStyle({
  PlaygroundTabSize size = .medium,
  TabStyler style = const TabStyler.create(),
}) {
  return _base(_metricsFor(size))
      .onHovered(_activeContent().color(PlaygroundTokens.accent()))
      .onSelected(_selectedStyle())
      .onFocusVisible(_focusVisibleStyle())
      .onDisabled(_disabledStyle())
      .merge(style);
}

/// The application's recipe for the panel a tab reveals.
///
/// It exists so the panel carries the application's prefix and has one place
/// to edit, and it earns that by owning the gap between the strip and the
/// content: without it the panel's first line sits directly on the hairline.
@MixWidget(name: 'PlaygroundTabView', target: RemixTabView.new)
TabViewStyler playgroundTabViewStyle({
  TabViewStyler style = const TabViewStyler.create(),
}) => TabViewStyler().padding(.top(_panelGap)).merge(style);

/// Width of the strip's hairline.
const _barBorderWidth = 1.0;

/// Width of the edge that marks the selected tab.
///
/// Twice the strip's hairline so the mark reads as a deliberate indicator
/// rather than a thicker piece of the same rule.
const _selectedEdgeWidth = 2.0;

/// An edge that paints nothing, holding the selected mark's space.
const _noEdge = Color(0x00000000);

/// Gap between the strip and the panel it reveals.
const _panelGap = 16.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Opacity applied to the whole tab while disabled.
const _disabledOpacity = 0.5;

/// Geometry and type scale for one [PlaygroundTabSize].
typedef _PlaygroundTabMetrics = ({
  double minHeight,
  double paddingX,
  double gap,
  double labelSize,
  double iconSize,
});

_PlaygroundTabMetrics _metricsFor(PlaygroundTabSize size) => switch (size) {
  .small => (
    minHeight: 32.0,
    paddingX: 10.0,
    gap: 6.0,
    labelSize: 14.0,
    iconSize: 16.0,
  ),
  .medium => (
    minHeight: 36.0,
    paddingX: 12.0,
    gap: 8.0,
    labelSize: 14.0,
    iconSize: 16.0,
  ),
  .large => (
    minHeight: 40.0,
    paddingX: 16.0,
    gap: 8.0,
    labelSize: 16.0,
    iconSize: 18.0,
  ),
};

/// Layout, typography, and the unselected content color.
///
/// An unselected tab is a destination, not the current one, so it uses
/// `mutedForeground`; hover and selection both promote it to `foreground`.
TabStyler _base(_PlaygroundTabMetrics metrics) =>
    _content(PlaygroundTokens.mutedForeground())
        .direction(.horizontal)
        .mainAxisSize(.min)
        .mainAxisAlignment(.center)
        .crossAxisAlignment(.center)
        .minHeight(metrics.minHeight)
        .padding(.horizontal(metrics.paddingX))
        .spacing(metrics.gap)
        .border(
          .bottom(BorderSideMix(color: _noEdge, width: _selectedEdgeWidth)),
        )
        .label(.fontSize(metrics.labelSize).fontWeight(FontWeight.w500))
        .icon(.size(metrics.iconSize));

/// The selected tab: full-strength content and the `primary` edge.
///
/// It sets no fill on purpose. Variant fragments apply in declaration order
/// and only overwrite what they name, so leaving `color` alone here is what
/// lets a hovered selected tab keep the hover fill *and* the selected edge.
TabStyler _selectedStyle() => _activeContent().border(
  .bottom(
    BorderSideMix(color: PlaygroundTokens.primary(), width: _selectedEdgeWidth),
  ),
);

/// The content color shared by the hovered and selected tabs.
TabStyler _activeContent() => _content(PlaygroundTokens.foreground());

/// Applies one content color to the label and the icons.
TabStyler _content(Color foreground) =>
    TabStyler().label(.color(foreground)).icon(.color(foreground));

/// The keyboard focus ring.
///
/// A *foreground* decoration rather than the box border: `TabSpec` has no
/// `containerEffects` layer to paint an outline into, and Flutter insets a
/// container's content by its border widths — so adding a real border on
/// focus would nudge the label. A foreground decoration paints over the tab
/// and takes no layout space, which is what a ring needs.
TabStyler _focusVisibleStyle() => TabStyler().foregroundDecoration(
  BoxDecorationMix.border(
    .all(
      BorderSideMix(
        color: PlaygroundTokens.focusRing(),
        width: _focusRingWidth,
        // Inset, so the ring stays inside the tab's own bounds instead of
        // overlapping its neighbours in the strip.
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
  ),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled tab keeps whatever surface its state gives it and simply fades;
/// the focus ring is cleared because a disabled tab that still draws a focus
/// ring reads as reachable.
TabStyler _disabledStyle() => TabStyler()
    .foregroundDecoration(
      BoxDecorationMix.border(.all(BorderSideMix(style: BorderStyle.none))),
    )
    .wrap(WidgetModifierConfig.opacity(_disabledOpacity));
