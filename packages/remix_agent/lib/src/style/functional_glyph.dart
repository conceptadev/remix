import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

abstract final class _LucideGlyphs {
  static const _family = 'Lucide';
  static const _package = 'lucide_icons_flutter';

  static const arrowUp = IconData(
    57418,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const square = IconData(
    57703,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const copy = IconData(
    57502,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const rotateCcw = IconData(
    57672,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const chevronUp = IconData(
    57456,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const chevronDown = IconData(
    57453,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const circle = IconData(
    57462,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const circleDot = IconData(
    58181,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const check = IconData(
    57452,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const x = IconData(57778, fontFamily: _family, fontPackage: _package);
  static const circleAlert = IconData(
    57463,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const squareTerminal = IconData(
    57866,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const loaderCircle = IconData(
    57610,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const circleCheck = IconData(
    57894,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const ban = IconData(
    57425,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const circleX = IconData(
    57476,
    fontFamily: _family,
    fontPackage: _package,
  );
  static const shieldCheck = IconData(
    57855,
    fontFamily: _family,
    fontPackage: _package,
  );
}

/// Internal Material-free glyph set used by Agent's functional defaults.
///
/// The types are intentionally not exported from the package barrel. Public
/// icon/status builders remain the replacement mechanism.
/// Builds the chevron that reports a collapsible surface's state.
///
/// Every collapsible Agent surface offers the host the same escape hatch — a
/// builder that replaces the glyph outright — over the same default. Each takes
/// that builder under its own name, because a permission card discloses
/// *details* and an answer discloses *sources*, so the shared part is this
/// body and not the parameter.
Widget agentDisclosureIndicator(
  BuildContext context, {
  required StyleSpec<IconSpec> styleSpec,
  required bool expanded,
  Widget Function(BuildContext context, bool expanded)? builder,
}) {
  return builder?.call(context, expanded) ??
      StyleSpecBuilder<IconSpec>(
        styleSpec: styleSpec,
        builder: (context, iconSpec) => AgentFunctionalGlyph(
          kind: .chevron,
          spec: iconSpec,
          expanded: expanded,
        ),
      );
}

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
    .send => _LucideGlyphs.arrowUp,
    .stop => _LucideGlyphs.square,
    .copy => _LucideGlyphs.copy,
    .retry => _LucideGlyphs.rotateCcw,
    .chevron => expanded ? _LucideGlyphs.chevronUp : _LucideGlyphs.chevronDown,
    .pending => _LucideGlyphs.circle,
    .active => _LucideGlyphs.circleDot,
    .completed => _LucideGlyphs.check,
    .cancelled => _LucideGlyphs.x,
    .error => _LucideGlyphs.circleAlert,
    .tool => _LucideGlyphs.squareTerminal,
    .loading => _LucideGlyphs.loaderCircle,
    .completedCircle => _LucideGlyphs.circleCheck,
    .cancelledCircle => _LucideGlyphs.ban,
    .errorCircle => _LucideGlyphs.circleX,
    .permission => _LucideGlyphs.shieldCheck,
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
