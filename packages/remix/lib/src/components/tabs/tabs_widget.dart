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
///         children: [
///           RemixTab(tabId: 'tab1', label: 'Tab 1'),
///           RemixTab(tabId: 'tab2', label: 'Tab 2'),
///         ],
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
    this.activationMode = .automatic,
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

  /// Whether focus movement also selects a tab or requires explicit action.
  final NakedTabActivationMode activationMode;

  /// Called when Escape is pressed while a tab has focus.
  final VoidCallback? onEscapePressed;

  @override
  Widget build(BuildContext context) {
    return NakedTabs(
      controller: controller,
      selectedTabId: selectedTabId,
      onChanged: onChanged,
      orientation: orientation,
      activationMode: activationMode,
      enabled: enabled,
      onEscapePressed: onEscapePressed,
      child: child,
    );
  }
}

/// A container widget for tab buttons.
enum RemixTabBarWrap { nowrap, wrap, wrapReverse }

/// Main-axis distribution for tab buttons.
enum RemixTabBarJustify { start, center, end }

class RemixTabBar extends StatelessWidget {
  const RemixTabBar({
    super.key,
    this.child,
    this.children,
    this.wrap = RemixTabBarWrap.nowrap,
    this.justify = RemixTabBarJustify.start,
    this.style = const RemixTabBarStyler.create(),
    this.styleSpec,
  }) : assert(
         (child == null) != (children == null),
         'Provide exactly one of child or children.',
       );

  /// Established arbitrary tab-bar content.
  final Widget? child;

  /// Additive tab list used by wrapping and distribution behavior.
  final List<Widget>? children;

  /// Whether tabs stay on one scrolling line or wrap into runs.
  final RemixTabBarWrap wrap;

  /// Main-axis distribution of the tabs or each wrapped run.
  final RemixTabBarJustify justify;

  /// Style applied to the tab bar container.
  final RemixTabBarStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixTabBarSpec? styleSpec;

  static final styleFrom = RemixTabBarStyler.new;

  @override
  Widget build(BuildContext context) {
    final orientation = NakedTabsScope.of(context).orientation;

    return RemixStyleSpecBuilder<RemixTabBarSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        if (child case final content?) {
          return FlexBox(
            styleSpec: spec.container,
            children: [NakedTabBar(child: content)],
          );
        }
        return FlexBox(
          styleSpec: spec.container,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: _RemixTabBarLayout(
                orientation: orientation,
                wrap: wrap,
                justify: justify,
                children: children!,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RemixTabBarLayout extends StatelessWidget {
  const _RemixTabBarLayout({
    required this.orientation,
    required this.wrap,
    required this.justify,
    required this.children,
  });

  final Axis orientation;
  final RemixTabBarWrap wrap;
  final RemixTabBarJustify justify;
  final List<Widget> children;

  MainAxisAlignment get _mainAxisAlignment => switch (justify) {
    RemixTabBarJustify.start => MainAxisAlignment.start,
    RemixTabBarJustify.center => MainAxisAlignment.center,
    RemixTabBarJustify.end => MainAxisAlignment.end,
  };

  WrapAlignment get _wrapAlignment => switch (justify) {
    RemixTabBarJustify.start => WrapAlignment.start,
    RemixTabBarJustify.center => WrapAlignment.center,
    RemixTabBarJustify.end => WrapAlignment.end,
  };

  @override
  Widget build(BuildContext context) {
    if (wrap != RemixTabBarWrap.nowrap) {
      final reverseRuns = wrap == RemixTabBarWrap.wrapReverse;
      final ambientDirection = Directionality.of(context);
      return NakedTabBar(
        child: Wrap(
          direction: orientation,
          alignment: _wrapAlignment,
          verticalDirection: orientation == Axis.horizontal && reverseRuns
              ? VerticalDirection.up
              : VerticalDirection.down,
          textDirection: orientation == Axis.vertical && reverseRuns
              ? (ambientDirection == TextDirection.ltr
                    ? TextDirection.rtl
                    : TextDirection.ltr)
              : ambientDirection,
          children: children,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final minimumMainAxisExtent = switch (orientation) {
          Axis.horizontal when constraints.hasBoundedWidth =>
            constraints.maxWidth,
          Axis.vertical when constraints.hasBoundedHeight =>
            constraints.maxHeight,
          _ => 0.0,
        };
        final minimumConstraints = switch (orientation) {
          Axis.horizontal => BoxConstraints(minWidth: minimumMainAxisExtent),
          Axis.vertical => BoxConstraints(minHeight: minimumMainAxisExtent),
        };

        return SingleChildScrollView(
          primary: false,
          scrollDirection: orientation,
          child: ConstrainedBox(
            constraints: minimumConstraints,
            child: NakedTabBar(
              child: Flex(
                direction: orientation,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: _mainAxisAlignment,
                children: children,
              ),
            ),
          ),
        );
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
    this.excludeSemantics = false,
    this.style = const RemixTabStyler.create(),
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

  /// Whether to hide this tab and its content from accessibility.
  final bool excludeSemantics;

  /// The style configuration for this tab.
  final RemixTabStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixTabSpec? styleSpec;

  /// Optional icon to display in the tab.
  final IconData? icon;

  /// Optional label text for the tab.
  final String? label;

  static final styleFrom = RemixTabStyler.new;

  Widget _buildTabContent(
    BuildContext context,
    RemixTabSpec spec,
    NakedTabState state,
  ) {
    final defaultContent = child ?? _buildStableDefaultContent(spec);

    if (builder != null) {
      return builder!(context, state, defaultContent);
    }

    return defaultContent;
  }

  Widget _buildDefaultContent(RemixTabSpec spec, {bool sizing = false}) {
    return FlexBox(
      styleSpec: spec.container,
      children: [
        if (icon != null)
          sizing
              ? _RemixTabSizingIcon(spec: spec.icon.spec)
              : StyledIcon(icon: icon!, styleSpec: spec.icon),
        if (label != null)
          sizing
              ? _RemixTabSizingLabel(label: label!, spec: spec.label.spec)
              : StyledText(label!, styleSpec: spec.label),
      ],
    );
  }

  Widget _buildStableDefaultContent(RemixTabSpec visibleSpec) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        WidgetStateProvider(
          states: const {},
          child: Builder(
            builder: (context) {
              final neutralSpec = styleSpec ?? style.build(context).spec;
              return ExcludeSemantics(
                child: Opacity(
                  opacity: 0,
                  child: _buildDefaultContent(neutralSpec, sizing: true),
                ),
              );
            },
          ),
        ),
        WidgetStateProvider(
          states: const {WidgetState.selected},
          child: Builder(
            builder: (context) {
              final selectedSpec = styleSpec ?? style.build(context).spec;
              return ExcludeSemantics(
                child: Opacity(
                  opacity: 0,
                  child: _buildDefaultContent(selectedSpec, sizing: true),
                ),
              );
            },
          ),
        ),
        ExcludeSemantics(
          child: Opacity(
            opacity: 0,
            child: _buildDefaultContent(visibleSpec, sizing: true),
          ),
        ),
        Positioned.fill(
          child: OverflowBox(
            alignment: Alignment.center,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: _buildDefaultContent(visibleSpec),
          ),
        ),
      ],
    );
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
      excludeSemantics: excludeSemantics,
      builder: (context, state, _) {
        return RemixStyleSpecBuilder<RemixTabSpec>(
          style: style,
          styleSpec: styleSpec,
          controller: NakedTabState.controllerOf(context),
          builder: (context, spec) => _buildTabContent(context, spec, state),
        );
      },
    );
  }
}

class _RemixTabSizingIcon extends StatelessWidget {
  const _RemixTabSizingIcon({required this.spec});

  final IconSpec spec;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final baseSize = spec.size ?? iconTheme.size ?? 24.0;
    final shouldScale =
        spec.applyTextScaling ?? iconTheme.applyTextScaling ?? false;
    final size = shouldScale
        ? MediaQuery.textScalerOf(context).scale(baseSize)
        : baseSize;
    return SizedBox.square(dimension: size);
  }
}

class _RemixTabSizingLabel extends StatelessWidget {
  const _RemixTabSizingLabel({required this.label, required this.spec});

  final String label;
  final TextSpec spec;

  @override
  Widget build(BuildContext context) {
    final defaults = DefaultTextStyle.of(context);
    var effectiveStyle = spec.style;
    if (effectiveStyle == null || effectiveStyle.inherit) {
      effectiveStyle = defaults.style.merge(effectiveStyle);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveStyle = effectiveStyle.merge(
        const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    return RichText(
      text: TextSpan(
        text: spec.textDirectives?.apply(label) ?? label,
        style: effectiveStyle,
        locale: spec.locale,
      ),
      textAlign: spec.textAlign ?? defaults.textAlign ?? TextAlign.start,
      textDirection: spec.textDirection,
      locale: spec.locale,
      softWrap: spec.softWrap ?? defaults.softWrap,
      overflow: spec.overflow ?? effectiveStyle.overflow ?? defaults.overflow,
      textScaler: spec.textScaler ?? MediaQuery.textScalerOf(context),
      maxLines: spec.maxLines ?? defaults.maxLines,
      strutStyle: spec.strutStyle,
      textWidthBasis: spec.textWidthBasis ?? defaults.textWidthBasis,
      textHeightBehavior:
          spec.textHeightBehavior ??
          defaults.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
    );
  }
}

/// A tab content panel that is shown when its corresponding tab is selected.
class RemixTabView extends StatelessWidget {
  const RemixTabView({
    super.key,
    required this.tabId,
    required this.child,
    this.maintainState = true,
    this.style = const RemixTabViewStyler.create(),
    this.styleSpec,
  });

  /// The unique identifier that matches a tab.
  final String tabId;

  /// The content to show when this tab is selected.
  final Widget child;

  /// Whether an inactive tab panel keeps its element state alive.
  final bool maintainState;

  /// Style applied to the tab view container.
  final RemixTabViewStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixTabViewSpec? styleSpec;

  static final styleFrom = RemixTabViewStyler.new;

  @override
  Widget build(BuildContext context) {
    return NakedTabView(
      tabId: tabId,
      maintainState: maintainState,
      child: RemixStyleSpecBuilder<RemixTabViewSpec>(
        style: style,
        styleSpec: styleSpec,
        builder: (context, spec) {
          return Box(styleSpec: spec.container, child: child);
        },
      ),
    );
  }
}
