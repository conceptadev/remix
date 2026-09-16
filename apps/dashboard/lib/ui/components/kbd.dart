import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'typography.dart';

/// Radix Themes Kbd variants.
enum UiKbdVariant { classic, soft }

/// Ui-themed keyboard key.
///
/// Like Code, the geometry is em-relative to the resolved font size, so this
/// recipe takes a [context]. Radix uses two different type-scale factors: an
/// explicit size multiplies its token by `0.8`, while an omitted one keeps
/// upstream's unsized `0.75em` — anchored to the root `text3` token rather
/// than the ambient `DefaultTextStyle`, so a host text run cannot resize the
/// key cap.
/// The resolved token supplies the font family and fallback families; Kbd
/// retains its own weight, spacing, and line box.
BadgeStyler uiKbdStyle(
  BuildContext context, {
  UiTextSize? size,
  UiKbdVariant variant = .classic,
  BadgeStyler style = const BadgeStyler.create(),
}) {
  final base = uiResolveTextToken(context, size ?? UiTextSize.size3);
  final fontSize = base.fontSize! * (size == null ? 0.75 : 0.8);
  // Upstream `--letter-spacing-N` is em-relative, so an explicit size resolves
  // it against Kbd's own `0.8em` rather than the token's own font size. The
  // unsized path keeps the token's letter spacing unscaled, matching the
  // resolved value upstream's `0.75em` run would carry.
  final letterSpacing = (base.letterSpacing ?? 0) * (size == null ? 1 : 0.8);

  // Kbd pins its own weight and line box regardless of the surrounding style,
  // so it stays a key cap rather than following surrounding copy.
  final textStyle = TextStyler()
      .style(
        TextStyleMix(
          fontFamily: base.fontFamily,
          fontFamilyFallback: base.fontFamilyFallback,
        ),
      )
      .fontSize(fontSize)
      .fontWeight(UiTokens.fontWeightRegular())
      .height(1.7)
      .letterSpacing(letterSpacing)
      .wordSpacing(-0.1 * fontSize)
      .textAlign(TextAlign.center)
      .softWrap(false)
      .maxLines(1)
      .color(UiTokens.gray12())
      .inherit(false);

  var recipe = BadgeStyler()
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
          0.35 * fontSize * uiRadiusFactor(context),
        ),
      )
      .color(switch (variant) {
        .classic => uiResolveColor(context, UiTokens.gray1),
        .soft => uiResolveColor(context, UiTokens.grayA3),
      });

  if (variant == .classic) {
    recipe = recipe.containerEffects(
      RemixBoxEffectsMix.behindContent(
        RemixBoxEffectLayerMix(shadows: _uiKbdShadows(context, fontSize)),
      ),
    );
  }

  return recipe.merge(style);
}

/// The pinned six-layer classic key-cap stack, in upstream paint order.
///
/// Radix's `-0.03em` visual top nudge is deliberately skipped; a transform
/// wrapper for a sub-pixel baseline tweak is recorded as a measured visual
/// approximation instead.
List<RemixBoxShadowMix> _uiKbdShadows(BuildContext context, double em) {
  final isDark = UiTheme.of(context).isDark;

  return [
    RemixBoxShadowMix(
      kind: .inset,
      color: uiResolveColor(
        context,
        isDark ? UiTokens.grayA3 : UiTokens.grayA2,
      ),
      offset: Offset(0, -0.05 * em),
      blurRadius: 0.5 * em,
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: uiResolveColor(
        context,
        isDark ? UiTokens.grayA11 : UiTokens.whiteA12,
      ),
      offset: Offset(0, 0.05 * em),
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: uiResolveColor(context, UiTokens.grayA2),
      offset: Offset(0, 0.25 * em),
      blurRadius: 0.5 * em,
    ),
    RemixBoxShadowMix(
      kind: .inset,
      color: uiResolveColor(
        context,
        isDark ? UiTokens.blackA11 : UiTokens.grayA6,
      ),
      offset: Offset(0, (isDark ? -0.1 : -0.05) * em),
    ),
    RemixBoxShadowMix(
      color: uiResolveColor(
        context,
        isDark ? UiTokens.grayA7 : UiTokens.grayA5,
      ),
      spreadRadius: (isDark ? 0.075 : 0.05) * em,
    ),
    RemixBoxShadowMix(
      color: uiResolveColor(
        context,
        isDark ? UiTokens.blackA12 : UiTokens.grayA7,
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
class UiKbd extends StatelessWidget {
  const UiKbd(
    this.text, {
    super.key,
    this.size,
    this.variant = UiKbdVariant.classic,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const BadgeStyler.create(),
  }) : assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  const UiKbd.classic(
    this.text, {
    super.key,
    this.size,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiKbdVariant.classic,
       assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  const UiKbd.soft(
    this.text, {
    super.key,
    this.size,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const BadgeStyler.create(),
  }) : variant = UiKbdVariant.soft,
       assert(text != ''),
       assert(semanticLabel == null || semanticLabel != '');

  final String text;
  final UiTextSize? size;
  final UiKbdVariant variant;
  final String? semanticLabel;
  final bool excludeSemantics;
  final BadgeStyler style;

  @override
  Widget build(BuildContext context) {
    final content = uiKbdStyle(
      context,
      size: size,
      variant: variant,
      style: style,
    )(label: text);

    if (excludeSemantics) return ExcludeSemantics(child: content);

    return Semantics(
      keyboardKey: true,
      label: semanticLabel ?? text,
      excludeSemantics: true,
      child: content,
    );
  }
}
