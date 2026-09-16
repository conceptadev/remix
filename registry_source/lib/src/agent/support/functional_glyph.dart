import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_ui_icons/remix_ui_icons.dart';

abstract final class _Glyphs {
  static const arrowUp = RemixIcons.arrowUp;
  static const square = RemixIcons.square;
  static const copy = RemixIcons.copy;
  static const rotateCcw = RemixIcons.reload;
  static const chevronUp = RemixIcons.chevronUp;
  static const chevronDown = RemixIcons.chevronDown;
  static const circle = RemixIcons.circle;
  static const circleDot = RemixIcons.dotFilled;
  static const check = RemixIcons.check;
  static const x = RemixIcons.cross2;
  static const circleAlert = RemixIcons.exclamationTriangle;
  static const squareTerminal = RemixIcons.code;
  static const loaderCircle = RemixIcons.update;
  static const circleCheck = RemixIcons.checkCircled;
  static const ban = RemixIcons.circleBackslash;
  static const circleX = RemixIcons.crossCircled;
  static const shieldCheck = RemixIcons.lockClosed;
}

/// Builds the chevron that reports a collapsible surface's state.
///
/// Every collapsible Agent surface offers the host the same escape hatch — a
/// builder that replaces the glyph outright — over the same default. Each takes
/// that builder under its own name, because a permission card discloses
/// *details* and an answer discloses *sources*, so the shared part is this
/// body and not the parameter.
class AgentDisclosureIndicator extends StatelessWidget {
  const AgentDisclosureIndicator({
    super.key,
    required this.styleSpec,
    required this.expanded,
    this.builder,
  });

  final StyleSpec<IconSpec> styleSpec;
  final bool expanded;
  final Widget Function(BuildContext context, bool expanded)? builder;

  @override
  Widget build(BuildContext context) =>
      builder?.call(context, expanded) ??
      StyleSpecBuilder<IconSpec>(
        styleSpec: styleSpec,
        builder: (context, iconSpec) => AgentFunctionalGlyph(
          kind: .chevron,
          spec: iconSpec,
          expanded: expanded,
        ),
      );
}

/// Internal Material-free glyph set used by Agent's functional defaults.
///
/// The types are intentionally not exported from the package barrel. Public
/// icon/status builders remain the replacement mechanism.
enum AgentFunctionalGlyphKind {
  send,
  stop,
  copy,
  retry,
  chevron,
  pending,
  active,
  completed,
  cancelled,
  error,
  tool,
  loading,
  completedCircle,
  cancelledCircle,
  errorCircle,
  permission,
}

class AgentFunctionalGlyph extends StatelessWidget {
  const AgentFunctionalGlyph({
    super.key,
    required this.kind,
    required this.spec,
    this.expanded = false,
  });

  final AgentFunctionalGlyphKind kind;
  final IconSpec spec;
  final bool expanded;

  IconData get _icon => switch (kind) {
    .send => _Glyphs.arrowUp,
    .stop => _Glyphs.square,
    .copy => _Glyphs.copy,
    .retry => _Glyphs.rotateCcw,
    .chevron => expanded ? _Glyphs.chevronUp : _Glyphs.chevronDown,
    .pending => _Glyphs.circle,
    .active => _Glyphs.circleDot,
    .completed => _Glyphs.check,
    .cancelled => _Glyphs.x,
    .error => _Glyphs.circleAlert,
    .tool => _Glyphs.squareTerminal,
    .loading => _Glyphs.loaderCircle,
    .completedCircle => _Glyphs.circleCheck,
    .cancelledCircle => _Glyphs.ban,
    .errorCircle => _Glyphs.circleX,
    .permission => _Glyphs.shieldCheck,
  };

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final opacity = spec.opacity ?? theme.opacity;
    final baseColor = spec.color ?? theme.color;
    final color = opacity == null || baseColor == null
        ? baseColor
        : baseColor.withValues(alpha: baseColor.a * opacity.clamp(0, 1));

    final icon = Icon(
      _icon,
      size: spec.size ?? theme.size,
      fill: spec.fill ?? theme.fill,
      weight: spec.weight ?? theme.weight,
      grade: spec.grade ?? theme.grade,
      opticalSize: spec.opticalSize ?? theme.opticalSize,
      color: color,
      shadows: spec.shadows ?? theme.shadows,
      textDirection: spec.textDirection,
      applyTextScaling:
          spec.applyTextScaling ?? theme.applyTextScaling ?? false,
      blendMode: spec.blendMode ?? BlendMode.srcOver,
    );
    return ExcludeSemantics(
      child: kind == AgentFunctionalGlyphKind.loading
          ? _LoadingGlyph(child: icon)
          : icon,
    );
  }
}

/// Animate only indeterminate loading; status labels own the semantics.
class _LoadingGlyph extends StatefulWidget {
  const _LoadingGlyph({required this.child});

  final Widget child;

  @override
  State<_LoadingGlyph> createState() => _LoadingGlyphState();
}

class _LoadingGlyphState extends State<_LoadingGlyph>
    with SingleTickerProviderStateMixin {
  late final _turns = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final animate =
        !(MediaQuery.maybeOf(context)?.disableAnimations ?? false) &&
        TickerMode.valuesOf(context).enabled;
    if (animate) {
      if (!_turns.isAnimating) _turns.repeat();
    } else {
      _turns.stop();
      _turns.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) =>
      RotationTransition(turns: _turns, child: widget.child);

  @override
  void dispose() {
    _turns.dispose();
    super.dispose();
  }
}
