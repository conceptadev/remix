import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

/// Accessible name for the compact navigation sheet's dialog barrier.
const _closeNavigationLabel = 'Close navigation';

/// Accessible name for the compact navigation sheet itself.
const _navigationSemanticLabel = 'Navigation';

/// A width, in logical pixels, reserved outside the compact sheet so its
/// scrim stays reachable on narrow screens.
const _compactSheetBarrierGutter = 56.0;

/// Application shell layout pairing a [sidebar] with a [body].
///
/// A layout, not a styled component: it owns no `Spec`, ships no generated
/// adapter, and paints nothing of its own beyond the compact sheet's panel
/// surface. [sidebar] is expected to be an already-configured `Sidebar`
/// (or any widget) that renders its own collapsed/expanded content; this
/// widget only decides where that content sits.
///
/// At or above [compactBreakpoint] logical pixels of available width, the
/// layout renders a row: [sidebar] at [collapsedWidth] or [sidebarWidth]
/// (matching [collapsed]), animated over 200ms with an ease-in-out curve —
/// the same timing `RemixSidebar` uses by default — next to an expanded
/// column holding the optional [header] above [body].
///
/// Below [compactBreakpoint], [sidebar] is hidden from the row entirely and
/// instead presented as a full-height sheet pinned to the layout's *start*
/// edge (end edge in RTL), opened and closed through
/// [PlaygroundSidebarLayoutScope]. The sheet is a [showRemixDialog]
/// route, which supplies the barrier, Escape-to-dismiss, and focus
/// containment; this widget only positions the sheet's content and supplies
/// its panel surface.
///
/// [compactOpen] and [onCompactOpenChanged] make the sheet's open state
/// controlled. Leave [compactOpen] null to let the layout manage it, still
/// observing changes through [onCompactOpenChanged] if supplied.
///
/// A controlled [compactOpen] is the single source of truth: a barrier tap,
/// Escape, a back gesture, or crossing back above [compactBreakpoint] only
/// calls [onCompactOpenChanged] rather than dismissing the sheet directly.
/// The host must set [compactOpen] to `false` from that callback for the
/// dismissal to stick.
///
/// ```dart
/// PlaygroundSidebarLayout(
///   sidebar: PlaygroundSidebar<AppPage>(
///     sections: sections,
///     selectedValue: page,
///     onSelected: (value) {
///       setState(() => page = value);
///       PlaygroundSidebarLayoutScope.of(context).closeCompact();
///     },
///   ),
///   header: const TopBar(),
///   body: PageBody(page: page),
/// )
/// ```
class PlaygroundSidebarLayout extends StatefulWidget {
  const PlaygroundSidebarLayout({
    super.key,
    required this.sidebar,
    required this.body,
    this.header,
    this.compactBreakpoint = 720,
    this.sidebarWidth = 256,
    this.collapsedWidth = 72,
    this.collapsed = false,
    this.compactOpen,
    this.onCompactOpenChanged,
  }) : assert(compactBreakpoint > 0),
       assert(sidebarWidth > 0),
       assert(collapsedWidth > 0 && collapsedWidth <= sidebarWidth);

  /// The navigation panel. Rendered inline while wide, and inside the
  /// compact sheet while narrow.
  final Widget sidebar;

  /// The page content, always visible.
  final Widget body;

  /// Optional fixed content above [body], in both presentations.
  final Widget? header;

  /// The available-width threshold, in logical pixels, below which the
  /// layout switches to its compact presentation.
  final double compactBreakpoint;

  /// The wide-mode panel width when [collapsed] is false.
  final double sidebarWidth;

  /// The wide-mode panel width when [collapsed] is true.
  final double collapsedWidth;

  /// Whether the wide-mode panel renders at [collapsedWidth] instead of
  /// [sidebarWidth]. The host toggles this; [sidebar] itself decides how its
  /// own content responds.
  final bool collapsed;

  /// Controlled compact-sheet visibility. Null lets the layout manage it.
  final bool? compactOpen;

  /// Called after the compact sheet's open state changes, whether the
  /// change came from the host (a controlled [compactOpen] update) or from
  /// the user dismissing the sheet (barrier tap, Escape, or a route pop).
  final ValueChanged<bool>? onCompactOpenChanged;

  @override
  State<PlaygroundSidebarLayout> createState() =>
      _PlaygroundSidebarLayoutState();
}

class _PlaygroundSidebarLayoutState extends State<PlaygroundSidebarLayout> {
  bool _selfOpen = false;
  bool _sheetShowing = false;

  /// The layout's presentation as of its most recent build, so [_openCompact]
  /// can no-op while wide even when called outside that build.
  bool _isCompact = false;

  /// The route [showRemixDialog] pushed for the open sheet, captured from
  /// inside its own builder via `ModalRoute.of` so [_removeSheetRoute] can
  /// close exactly that route on the Navigator that actually owns it,
  /// rather than popping whatever a bare `Navigator.of(context)` finds.
  Route<void>? _sheetRoute;

  bool get _effectiveOpen => widget.compactOpen ?? _selfOpen;

  void _setOpen(bool value) {
    if (widget.compactOpen == null) {
      if (_selfOpen == value) return;
      setState(() => _selfOpen = value);
    }
    widget.onCompactOpenChanged?.call(value);
  }

  // No-op while wide, so open state never carries over to the next compact
  // presentation.
  void _openCompact() {
    if (!_isCompact) return;
    _setOpen(true);
  }

  void _closeCompact() => _setOpen(false);

  void _reconcileSheet(bool isCompact) {
    _isCompact = isCompact;
    final desiredOpen = isCompact && _effectiveOpen;
    if (desiredOpen == _sheetShowing) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (desiredOpen) {
        if (!_sheetShowing) _pushSheet();
      } else if (_sheetShowing) {
        _removeSheetRoute();
      }
    });
  }

  void _removeSheetRoute() {
    final route = _sheetRoute;
    if (route == null || !route.isActive) return;
    route.navigator?.removeRoute(route);
  }

  Future<void> _pushSheet() async {
    _sheetShowing = true;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    await showRemixDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: _closeNavigationLabel,
      transitionDuration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 250),
      builder: (dialogContext) {
        _sheetRoute = ModalRoute.of(dialogContext);
        final available = MediaQuery.sizeOf(dialogContext).width;
        final width = math.min(
          widget.sidebarWidth,
          math.max(0.0, available - _compactSheetBarrierGutter),
        );
        return PlaygroundSidebarLayoutScope._(
          isCompact: true,
          isCompactOpen: true,
          openCompact: _openCompact,
          closeCompact: _closeCompact,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            // A plain DecoratedBox paints the panel surface without
            // affecting layout, unlike a Mix `Box`, whose border-box sizing
            // would shrink `width` by the border's own stroke width.
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: MixScope.tokenOf(
                  PlaygroundTokens.background,
                  dialogContext,
                ),
                border: BorderDirectional(
                  end: BorderSide(
                    color: MixScope.tokenOf(
                      PlaygroundTokens.border,
                      dialogContext,
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                width: width,
                height: double.infinity,
                child: RemixDialog(
                  semanticLabel: _navigationSemanticLabel,
                  child: widget.sidebar,
                ),
              ),
            ),
          ),
        );
      },
    );
    // Reached once, however the route completed: a user dismissal or
    // _removeSheetRoute above.
    _sheetRoute = null;
    _sheetShowing = false;
    if (mounted) _setOpen(false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < widget.compactBreakpoint;
        _reconcileSheet(isCompact);

        return PlaygroundSidebarLayoutScope._(
          isCompact: isCompact,
          // Anded with isCompact so it can't read true while wide.
          isCompactOpen: isCompact && _effectiveOpen,
          openCompact: _openCompact,
          closeCompact: _closeCompact,
          child: isCompact ? _body() : _wideRow(),
        );
      },
    );
  }

  Widget _wideRow() {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: widget.collapsed ? widget.collapsedWidth : widget.sidebarWidth,
          child: widget.sidebar,
        ),
        Expanded(child: _body()),
      ],
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?widget.header,
        Expanded(child: widget.body),
      ],
    );
  }
}

/// Reads the layout's compact state and drives its compact sheet.
///
/// Available to both the layout's normal subtree (for example, a [header]'s
/// menu button) and the compact sheet's own subtree (for example, a
/// destination's `onSelected` callback closing the sheet after navigating),
/// since the layout re-provides this scope inside the sheet route.
class PlaygroundSidebarLayoutScope extends InheritedWidget {
  const PlaygroundSidebarLayoutScope._({
    required this.isCompact,
    required this.isCompactOpen,
    required this._openCompact,
    required this._closeCompact,
    required super.child,
  });

  /// Whether the layout is currently in its compact presentation.
  final bool isCompact;

  /// Whether the compact sheet is currently open.
  ///
  /// Always false outside a compact presentation.
  final bool isCompactOpen;

  final VoidCallback _openCompact;
  final VoidCallback _closeCompact;

  /// Opens the compact sheet. A no-op while wide.
  void openCompact() => _openCompact();

  /// Closes the compact sheet. A no-op when already closed.
  void closeCompact() => _closeCompact();

  /// Reads the nearest [PlaygroundSidebarLayoutScope].
  ///
  /// Throws a [FlutterError] outside a [PlaygroundSidebarLayout].
  static PlaygroundSidebarLayoutScope of(BuildContext context) {
    final scope = maybeOf(context);
    if (scope == null) {
      throw FlutterError(
        'PlaygroundSidebarLayoutScope.of requires a '
        'PlaygroundSidebarLayout ancestor.',
      );
    }
    return scope;
  }

  /// Reads the nearest [PlaygroundSidebarLayoutScope], or null outside a
  /// [PlaygroundSidebarLayout].
  static PlaygroundSidebarLayoutScope? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<PlaygroundSidebarLayoutScope>();

  @override
  bool updateShouldNotify(PlaygroundSidebarLayoutScope oldWidget) =>
      isCompact != oldWidget.isCompact ||
      isCompactOpen != oldWidget.isCompactOpen;
}
