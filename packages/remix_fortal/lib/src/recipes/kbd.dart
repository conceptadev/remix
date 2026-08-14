import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

/// Radix Themes Kbd variants.
enum FortalKbdVariant { classic, soft }

/// Fortal-themed keyboard key.
///
/// Like Code, the geometry is em-relative to the resolved font size, so this
/// recipe takes a [context]. Radix uses two different type-scale factors: an
/// explicit size multiplies its token by `0.8`, while an omitted one keeps
/// upstream's unsized `0.75em` — anchored to the root `text3` token rather
/// than the ambient `DefaultTextStyle`, so a host text run cannot resize the
/// key cap.
BadgeStyler fortalKbdStyle(
  BuildContext context, {
  FortalTextSize? size,
  FortalKbdVariant variant = .classic,
}) {
  final base = fortalResolveTextToken(context, size ?? FortalTextSize.size3);
  final fontSize = base.fontSize! * (size == null ? 0.75 : 0.8);
  // Upstream `--letter-spacing-N` is em-relative, so an explicit size resolves
  // it against Kbd's own `0.8em` rather than the token's own font size. The
  // unsized path keeps the token's letter spacing unscaled, matching the
  // resolved value upstream's `0.75em` run would carry.
  final letterSpacing = (base.letterSpacing ?? 0) * (size == null ? 1 : 0.8);

  // Kbd pins its own weight and line box regardless of the surrounding style,
  // so it stays a key cap rather than following surrounding copy.
  final textStyle = TextStyler()
      .fontSize(fontSize)
      .fontWeight(FortalTokens.fontWeightRegular())
      .height(1.7)
      .letterSpacing(letterSpacing)
      .wordSpacing(-0.1 * fontSize)
      .textAlign(TextAlign.center)
      .softWrap(false)
      .maxLines(1)
      .color(FortalTokens.gray12())
      .inherit(false);

  var style = BadgeStyler()
      .label(textStyle)
      .minWidth(1.75 * fontSize)
      .padding(
        EdgeInsetsGeometryMix.only(
          left: 0.5 * fontSize,
          right: 0.5 * fontSize,
          bottom: 0.05 * fontSize,
        ),
      )
      .borderRadius(
        BorderRadiusGeometryMix.circular(
          0.35 * fontSize * fortalRadiusFactor(context),
        ),
      )
      .color(
        variant == FortalKbdVariant.classic
            ? fortalResolveColor(context, FortalTokens.gray1)
            : fortalResolveColor(context, FortalTokens.grayA3),
      );

  if (variant == FortalKbdVariant.classic) {
    style = style.containerEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(shadows: _fortalKbdShadows(context, fontSize)),
      ),
    );
  }

  return style;
}

/// The pinned six-layer classic key-cap stack, in upstream paint order.
///
/// Radix's `-0.03em` visual top nudge is deliberately skipped; a transform
/// wrapper for a sub-pixel baseline tweak is recorded as a measured visual
/// approximation instead.
List<RemixBoxShadowMix> _fortalKbdShadows(BuildContext context, double em) {
  final isDark = FortalTheme.of(context).isDark;

  return [
    RemixBoxShadowMix(
      kind: .inset,
      color: fortalResolveColor(
        context,
        isDark ? FortalTokens.grayA3 : FortalTokens.grayA2,
      ),
      offset: Offset(0, -0.05 * em),
      blurRadius: 0.5 * em,
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: fortalResolveColor(
        context,
        isDark ? FortalTokens.grayA11 : FortalTokens.whiteA12,
      ),
      offset: Offset(0, 0.05 * em),
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: fortalResolveColor(context, FortalTokens.grayA2),
      offset: Offset(0, 0.25 * em),
      blurRadius: 0.5 * em,
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: fortalResolveColor(
        context,
        isDark ? FortalTokens.blackA11 : FortalTokens.grayA6,
      ),
      offset: Offset(0, (isDark ? -0.1 : -0.05) * em),
    ),
    RemixBoxShadowMix(
      color: fortalResolveColor(
        context,
        isDark ? FortalTokens.grayA7 : FortalTokens.grayA5,
      ),
      spreadRadius: (isDark ? 0.075 : 0.05) * em,
    ),
    RemixBoxShadowMix(
      color: fortalResolveColor(
        context,
        isDark ? FortalTokens.blackA12 : FortalTokens.grayA7,
      ),
      offset: Offset(0, 0.08 * em),
      blurRadius: 0.17 * em,
    ),
  ];
}

/// Token-backed representation of one keyboard key or shortcut.
///
/// Publishes a single native `keyboardKey` node and no tap action; Kbd is inert
/// upstream, so the hover/pressed selectors that apply only when it is nested
/// in an actionable element are deliberately absent.
class FortalKbd extends StatelessWidget {
  const FortalKbd(
    this.text, {
    super.key,
    this.size,
    this.variant = FortalKbdVariant.classic,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  const FortalKbd.classic(
    this.text, {
    super.key,
    this.size,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalKbdVariant.classic,
       assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  const FortalKbd.soft(
    this.text, {
    super.key,
    this.size,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalKbdVariant.soft,
       assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  final String text;
  final FortalTextSize? size;
  final FortalKbdVariant variant;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    final content = fortalKbdStyle(context, size: size, variant: variant)(
      label: text,
    );

    if (excludeSemantics) return ExcludeSemantics(child: content);

    return Semantics(
      keyboardKey: true,
      label: semanticLabel ?? text,
      excludeSemantics: true,
      child: content,
    );
  }
}
