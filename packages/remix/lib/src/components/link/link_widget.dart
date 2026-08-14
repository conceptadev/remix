part of 'link.dart';

/// Styled text that navigates when activated.
///
/// A link is the navigation counterpart to [RemixButton]: it activates on tap
/// and on Enter, but not on Space, and it publishes the Link role instead of
/// the Button role. Reach for [RemixButton] when activation changes state in
/// place rather than moving the user somewhere.
///
/// Navigation itself stays caller-owned. [onPressed] performs it; [linkUrl] is
/// assistive metadata that is never launched.
///
/// ## Example
///
/// ```dart
/// RemixLink(
///   label: 'Documentation',
///   linkUrl: Uri.parse('https://example.com/docs'),
///   onPressed: () => router.go('/docs'),
/// )
/// ```
class RemixLink extends StatelessWidget {
  /// Creates a text link with [label] or an arbitrary-content link with
  /// [child]. Arbitrary content inherits the resolved text and icon themes.
  const RemixLink({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.enabled = true,
    this.linkUrl,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.style = const LinkStyler.create(),
    this.styleSpec,
  }) : // An empty label renders a zero-width link that assistive tech cannot
       // name, so it fails the same invariant a null label does.
       assert(
         child != null || (label != null && label != ''),
         'Either a non-empty label or a child must be provided so the link '
         'has a name.',
       ),
       // An inert link publishes no destination, so a linkUrl passed without a
       // callback would be silently dropped rather than merely unused.
       assert(
         linkUrl == null || onPressed != null,
         'linkUrl needs an onPressed: an inert link exposes no destination.',
       );

  static final styleFrom = LinkStyler.new;

  /// The link text. Ignored when [child] is provided.
  final String? label;

  /// Arbitrary link content, used instead of [label].
  final Widget? child;

  /// Performs the navigation when the link activates.
  ///
  /// A null callback makes the link inert: styled text with no link role, no
  /// focus stop, and no activation.
  final VoidCallback? onPressed;

  /// Whether an otherwise actionable link may activate.
  final bool enabled;

  /// Optional destination exposed through Link semantics.
  ///
  /// This is never launched. On Flutter web it becomes an anchor `href`, so
  /// omit it when [onPressed] already performs the navigation.
  final Uri? linkUrl;

  /// Optional focus node controlling the link's focus behavior.
  final FocusNode? focusNode;

  /// Whether the link requests focus when first built.
  final bool autofocus;

  /// Whether accepted activations provide platform feedback.
  final bool enableFeedback;

  /// Cursor shown while the link is actionable.
  final MouseCursor mouseCursor;

  /// Accessible name that replaces the visible text for screen readers.
  final String? semanticLabel;

  /// Additional description of what activating the link does.
  final String? semanticHint;

  /// Whether to hide the link and its subtree from semantics.
  final bool excludeSemantics;

  /// The style configuration for the link.
  final LinkStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final LinkSpec? styleSpec;

  Widget _buildContent(BuildContext context, LinkSpec spec) {
    final content = child == null
        ? StyledText(label!, styleSpec: spec.label)
        : RemixDefaultContentStyle(
            text: spec.label,
            icon: StyleSpec(
              spec: IconSpec(color: spec.label.spec.style?.color),
            ),
            child: child!,
          );

    return RemixBoxWithEffects(
      styleSpec: spec.container,
      containerEffects: spec.containerEffects,
      child: content,
    );
  }

  /// Renders a link with no callback as what it is: prose.
  ///
  /// HTML's `<a>` without an `href` has no role, no focus stop, and — the part
  /// that matters here — no disabled state. `NakedLink` folds `enabled` and
  /// `onPressed` into a single effective-enabled flag and publishes
  /// `hasEnabledState` for both, so routing this case through it would
  /// announce ordinary body text as unavailable. `enabled: false` with a real
  /// callback still goes through [NakedLink], because that *is* a disabled
  /// link.
  ///
  /// Collapse this back into a single [NakedLink] path once the primitive
  /// stops claiming an enabled state for a callback-less Link.
  Widget _buildInert(BuildContext context) {
    // The empty scope is load-bearing, not defensive. Without it the style
    // resolves against whatever WidgetStateProvider an ancestor publishes, so
    // an inert link inside a hovered card would render its hover variant. The
    // actionable path is already isolated by its own Naked state controller;
    // this keeps one LinkStyler behaving the same on both paths.
    final content = WidgetStateProvider(
      states: const {},
      child: RemixStyleSpecBuilder<LinkSpec>(
        style: style,
        styleSpec: styleSpec,
        builder: _buildContent,
      ),
    );

    if (excludeSemantics) return ExcludeSemantics(child: content);
    if (semanticLabel == null && semanticHint == null) return content;

    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      excludeSemantics: semanticLabel != null,
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) return _buildInert(context);

    return NakedLink(
      onPressed: onPressed,
      linkUrl: linkUrl,
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autofocus,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      builder: (context, _, _) => RemixStyleSpecBuilder<LinkSpec>(
        style: style,
        styleSpec: styleSpec,
        controller: NakedLinkState.controllerOf(context),
        builder: _buildContent,
      ),
    );
  }
}
